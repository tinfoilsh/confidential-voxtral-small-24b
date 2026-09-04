# syntax=docker/dockerfile:1.6
ARG VLLM_BASE_IMAGE=ghcr.io/tinfoilsh/vllm-openai-audio:v0.0.11@sha256:5c91900505727f91a32a533be9715123e703ea6ffcd7888239b0ebc2fd976d50
ARG SIDECAR_IMAGE=ghcr.io/tinfoilsh/inference-sidecar@sha256:65ce23d6560c46a1e8614ede187fcbf9798b267aa33878905b4872404787f47d
FROM ${SIDECAR_IMAGE} AS sidecar

FROM ${VLLM_BASE_IMAGE}

ARG SOURCE_REVISION=""

COPY --from=sidecar /inference-sidecar /opt/tinfoil/inference-sidecar
ENTRYPOINT ["/opt/tinfoil/inference-sidecar", "/app/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/tinfoilsh/confidential-voxtral-small-24b" \
      org.opencontainers.image.revision="${SOURCE_REVISION}"
