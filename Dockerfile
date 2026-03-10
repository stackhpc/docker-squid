FROM quay.io/rockylinux/rockylinux:10
LABEL maintainer=StackHPC

ARG SQUID_VERSION=""

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=squid

RUN if [[ -z "${SQUID_VERSION}" ]]; then \
      dnf install -y which squid; \
    else \
      dnf install -y which squid-${SQUID_VERSION}; \
    fi

COPY squid.conf /etc/squid/squid.conf
RUN chown root:squid /etc/squid/squid.conf
RUN chmod 0640 /etc/squid/squid.conf

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 0755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
