# Use clux/muslrust as the base image
FROM clux/muslrust:stable as builder

# Set the working directory
WORKDIR /workdir

# Copy the entire repository into the container
COPY . .

# Build the specific project
ARG PROJECT_DIR
RUN cd $PROJECT_DIR && cargo build --release

# Copy the statically linked binary into a new scratch container
FROM scratch
ARG PROJECT_DIR
COPY --from=builder /workdir/$PROJECT_DIR/target/x86_64-unknown-linux-musl/release/$PROJECT_DIR /app

# Specify the binary as the entrypoint
ENTRYPOINT ["/app"]

