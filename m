From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH/WIP v2 03/14] read-cache: connect to file watcher
Date: Fri, 17 Jan 2014 16:47:29 +0700
Message-ID: <1389952060-12297-4-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
 <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 17 10:49:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W463c-0003hM-Ry
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 10:49:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752381AbaAQJtZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 17 Jan 2014 04:49:25 -0500
Received: from mail-pd0-f175.google.com ([209.85.192.175]:47300 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752147AbaAQJsY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jan 2014 04:48:24 -0500
Received: by mail-pd0-f175.google.com with SMTP id r10so3792693pdi.20
        for <git@vger.kernel.org>; Fri, 17 Jan 2014 01:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=JMs5Y3ynIvpgb0NgqU+jkBszZDadj0Fb0f40dBYRjOo=;
        b=obLhUDPypFxDow9eV1G5AFNBNsBTni1o0b6TCAQbv5VBaH6Gt+0lQi1p5Y5ql29Ite
         L2TlDMsxXMkG+Xd0JvThwbB8wIotWR9uPbXtjt2EP2mkFNG4idwcWj9UrsgkzvoX4YrK
         RPNG3oKnOtxW5qTaGOqh0eAW98HWvC9tD4NS8eGyBXsEp54MTJ6mnLCgCoeJnQIQ2ZhX
         2Q5/HtbJ7qz8AW/aMc48JRkX/26gmP9kbeKeQmkMysXdufK/yD7fVZ7t8xQoDhDvBBJe
         v4HLt0qB/FovSOBocS4s2/d7XKMvYRbvupyTTAfTSclq+Yv+30Yo1+wftCEuHCAsQGvk
         jPOg==
X-Received: by 10.68.201.10 with SMTP id jw10mr1028368pbc.25.1389952102997;
        Fri, 17 Jan 2014 01:48:22 -0800 (PST)
Received: from pclouds@gmail.com ([14.161.32.83])
        by mx.google.com with ESMTPSA id dq3sm21317422pbc.35.2014.01.17.01.48.18
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jan 2014 01:48:21 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 17 Jan 2014 16:48:16 +0700
X-Mailer: git-send-email 1.8.5.1.208.g05b12ea
In-Reply-To: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240592>

This patch establishes a connection between a new file watcher daemon
and git. Each index file may have at most one file watcher attached to
it. The file watcher maintains a UNIX socket at
$GIT_DIR/index.watcher. Any process that has write access to $GIT_DIR
can talk to the file watcher.

A validation is performed after git connects to the file watcher to
make sure both sides have the same view. This is done by exchanging
the index signature (*) The file watcher keeps a copy of the signature
locally while git computes the signature from the index. If the
signatures do not match, something has gone wrong so both sides
reinitialize wrt. to file watching: the file watcher clears all
watches while git clears CE_WATCHED flags.

If the signatures match, we can trust the file watcher and git can
start asking questions that are not important to this patch.

This file watching thing is all about speed. So if the daemon is not
responding within 20ms (or even hanging), git moves on without it.

A note about per-repo vs global (or per-user) daemon approach. While I
implement per-repo daemon, this is actually implementation
details. Nothing can stop you from writing a global daemon that opens
unix sockets to many repos, e.g. to avoid hitting inotify's 128 user
instances limit.

If env variable GIT_NO_FILE_WATCHER is set, the file watcher is
ignored. 'WATC' extension is kept, but if the index is updated
(likely), it'll become invalid at the next connection.

(*) for current index versions, the signature is the index SHA-1
trailer. But it could be something else (e.g. v5 does not have SHA-1
trailer)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore               |   1 +
 Makefile                 |   2 +
 cache.h                  |   3 +
 file-watcher-lib.c (new) |  97 ++++++++++++++++++++++++++++++++
 file-watcher-lib.h (new) |   9 +++
 file-watcher.c (new)     | 142 +++++++++++++++++++++++++++++++++++++++=
++++++++
 read-cache.c             |  37 ++++++++++++
 trace.c                  |   3 +-
 8 files changed, 292 insertions(+), 2 deletions(-)
 create mode 100644 file-watcher-lib.c
 create mode 100644 file-watcher-lib.h
 create mode 100644 file-watcher.c

diff --git a/.gitignore b/.gitignore
index dc600f9..dc870cc 100644
--- a/.gitignore
+++ b/.gitignore
@@ -56,6 +56,7 @@
 /git-fast-import
 /git-fetch
 /git-fetch-pack
+/git-file-watcher
 /git-filter-branch
 /git-fmt-merge-msg
 /git-for-each-ref
diff --git a/Makefile b/Makefile
index 287e6f8..4369b3b 100644
--- a/Makefile
+++ b/Makefile
@@ -536,6 +536,7 @@ PROGRAMS +=3D $(EXTRA_PROGRAMS)
 PROGRAM_OBJS +=3D credential-store.o
 PROGRAM_OBJS +=3D daemon.o
 PROGRAM_OBJS +=3D fast-import.o
+PROGRAM_OBJS +=3D file-watcher.o
 PROGRAM_OBJS +=3D http-backend.o
 PROGRAM_OBJS +=3D imap-send.o
 PROGRAM_OBJS +=3D sh-i18n--envsubst.o
@@ -798,6 +799,7 @@ LIB_OBJS +=3D entry.o
 LIB_OBJS +=3D environment.o
 LIB_OBJS +=3D exec_cmd.o
 LIB_OBJS +=3D fetch-pack.o
+LIB_OBJS +=3D file-watcher-lib.o
 LIB_OBJS +=3D fsck.o
 LIB_OBJS +=3D gettext.o
 LIB_OBJS +=3D gpg-interface.o
diff --git a/cache.h b/cache.h
index 069dce7..0d55551 100644
--- a/cache.h
+++ b/cache.h
@@ -282,6 +282,7 @@ struct index_state {
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
+	int watcher;
 };
=20
 extern struct index_state the_index;
@@ -1241,6 +1242,8 @@ extern void alloc_report(void);
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
 __attribute__((format (printf, 2, 3)))
+extern void trace_printf_key(const char *key, const char *fmt, ...);
+__attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, .=
=2E.);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
diff --git a/file-watcher-lib.c b/file-watcher-lib.c
new file mode 100644
index 0000000..ed14ef9
--- /dev/null
+++ b/file-watcher-lib.c
@@ -0,0 +1,97 @@
+#include "cache.h"
+
+#define WAIT_TIME 20		/* in ms */
+#define TRACE_KEY "GIT_TRACE_WATCHER"
+
+int connect_watcher(const char *path)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct stat st;
+	int fd =3D -1;
+
+	strbuf_addf(&sb, "%s.watcher", path);
+	if (!stat(sb.buf, &st) && S_ISSOCK(st.st_mode)) {
+		struct sockaddr_un sun;
+		fd =3D socket(AF_UNIX, SOCK_DGRAM, 0);
+		sun.sun_family =3D AF_UNIX;
+		strlcpy(sun.sun_path, sb.buf, sizeof(sun.sun_path));
+		if (connect(fd, (struct sockaddr *)&sun, sizeof(sun))) {
+			error(_("unable to connect to file watcher: %s"),
+			      strerror(errno));
+			close(fd);
+			fd =3D -1;
+		} else {
+			sprintf(sun.sun_path, "%c%"PRIuMAX, 0, (uintmax_t)getpid());
+			if (bind(fd, (struct sockaddr *)&sun, sizeof(sun))) {
+				error(_("unable to bind socket: %s"),
+				      strerror(errno));
+				close(fd);
+				fd =3D -1;
+			}
+		}
+	}
+	strbuf_release(&sb);
+	return fd;
+}
+
+ssize_t send_watcher(int sockfd, struct sockaddr_un *dest,
+		     const char *fmt, ...)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct pollfd pfd;
+	int ret;
+
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+
+	pfd.fd =3D sockfd;
+	pfd.events =3D POLLOUT;
+	ret =3D poll(&pfd, 1, WAIT_TIME);
+	if (ret > 0 && pfd.revents & POLLOUT) {
+		trace_printf_key(TRACE_KEY, "< %s\n", sb.buf);
+		if (dest)
+			ret =3D sendto(sockfd, sb.buf, sb.len, 0,
+				     (struct sockaddr *)dest,
+				     sizeof(struct sockaddr_un));
+		else
+			ret =3D write(sockfd, sb.buf, sb.len);
+	}
+	strbuf_release(&sb);
+	return ret;
+}
+
+char *read_watcher(int fd, ssize_t *size, struct sockaddr_un *sun)
+{
+	static char *buf;
+	static int buf_size;
+	struct pollfd pfd;
+	ssize_t len;
+
+	if (!buf_size) {
+		socklen_t vallen =3D sizeof(buf_size);
+		if (getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &buf_size, &vallen))
+			die_errno("could not get SO_SNDBUF from socket %d", fd);
+		buf =3D xmalloc(buf_size + 1);
+	}
+
+	pfd.fd =3D fd;
+	pfd.events =3D POLLIN;
+	if (poll(&pfd, 1, WAIT_TIME) > 0 &&
+	    (pfd.revents & POLLIN)) {
+		if (sun) {
+			socklen_t socklen =3D sizeof(*sun);
+			len =3D recvfrom(fd, buf, buf_size, 0, sun, &socklen);
+		} else
+			len =3D read(fd, buf, buf_size);
+		if (len > 0)
+			buf[len] =3D '\0';
+		if (size)
+			*size =3D len;
+		trace_printf_key(TRACE_KEY, "> %s\n", buf);
+		return buf;
+	} else if (size)
+		*size =3D 0;
+	return NULL;
+}
diff --git a/file-watcher-lib.h b/file-watcher-lib.h
new file mode 100644
index 0000000..0fe9399
--- /dev/null
+++ b/file-watcher-lib.h
@@ -0,0 +1,9 @@
+#ifndef __FILE_WATCHER_LIB__
+#define __FILE_WATCHER_LIB__
+
+int connect_watcher(const char *path);
+ssize_t send_watcher(int sockfd, struct sockaddr_un *dest,
+		     const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+char *read_watcher(int fd, ssize_t *size, struct sockaddr_un *sun);
+#endif
diff --git a/file-watcher.c b/file-watcher.c
new file mode 100644
index 0000000..36a9a8d
--- /dev/null
+++ b/file-watcher.c
@@ -0,0 +1,142 @@
+#include "cache.h"
+#include "sigchain.h"
+#include "parse-options.h"
+#include "exec_cmd.h"
+#include "file-watcher-lib.h"
+
+static const char *const file_watcher_usage[] =3D {
+	N_("git file-watcher [options]"),
+	NULL
+};
+
+static char index_signature[41];
+
+static int handle_command(int fd)
+{
+	struct sockaddr_un sun;
+	ssize_t len;
+	const char *arg;
+	char *msg;
+
+	if (!(msg =3D read_watcher(fd, &len, &sun)))
+		die_errno("read from socket");
+
+	if ((arg =3D skip_prefix(msg, "hello "))) {
+		send_watcher(fd, &sun, "hello %s", index_signature);
+		if (strcmp(arg, index_signature))
+			/*
+			 * Index SHA-1 mismatch, something has gone
+			 * wrong. Clean up and start over.
+			 */
+			index_signature[0] =3D '\0';
+	} else if (!strcmp(msg, "die")) {
+		exit(0);
+	} else {
+		die("unrecognized command %s", msg);
+	}
+	return 0;
+}
+
+static const char *socket_path;
+static int do_not_clean_up;
+
+static void cleanup(void)
+{
+	if (do_not_clean_up)
+		return;
+	unlink(socket_path);
+}
+
+static void cleanup_on_signal(int signo)
+{
+	cleanup();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
+static void daemonize(void)
+{
+#ifdef NO_POSIX_GOODIES
+	die("fork not supported on this platform");
+#else
+	switch (fork()) {
+		case 0:
+			break;
+		case -1:
+			die_errno("fork failed");
+		default:
+			do_not_clean_up =3D 1;
+			exit(0);
+	}
+	if (setsid() =3D=3D -1)
+		die_errno("setsid failed");
+	close(0);
+	close(1);
+	close(2);
+	sanitize_stdfds();
+#endif
+}
+
+int main(int argc, const char **argv)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct sockaddr_un sun;
+	struct pollfd pfd[2];
+	int fd, err, nr;
+	const char *prefix;
+	int daemon =3D 0;
+	struct option options[] =3D {
+		OPT_BOOL(0, "daemon", &daemon,
+			 N_("run in background")),
+		OPT_END()
+	};
+
+	git_extract_argv0_path(argv[0]);
+	git_setup_gettext();
+	prefix =3D setup_git_directory();
+	argc =3D parse_options(argc, argv, prefix, options,
+			     file_watcher_usage, 0);
+	if (argc)
+		die("too many arguments");
+
+	strbuf_addf(&sb, "%s.watcher", get_index_file());
+	socket_path =3D strbuf_detach(&sb, NULL);
+	memset(index_signature, 0, sizeof(index_signature));
+	fd =3D socket(AF_UNIX, SOCK_DGRAM, 0);
+	sun.sun_family =3D AF_UNIX;
+	strlcpy(sun.sun_path, socket_path, sizeof(sun.sun_path));
+	if (bind(fd, (struct sockaddr *)&sun, sizeof(sun)))
+		die_errno("unable to bind to %s", socket_path);
+	atexit(cleanup);
+	sigchain_push_common(cleanup_on_signal);
+
+	if (daemon) {
+		strbuf_addf(&sb, "%s.log", socket_path);
+		err =3D open(sb.buf, O_CREAT | O_TRUNC | O_WRONLY, 0600);
+		adjust_shared_perm(sb.buf);
+		if (err =3D=3D -1)
+			die_errno("unable to create %s", sb.buf);
+		daemonize();
+		dup2(err, 1);
+		dup2(err, 2);
+		close(err);
+	}
+
+	nr =3D 0;
+	pfd[nr].fd =3D fd;
+	pfd[nr++].events =3D POLLIN;
+
+	for (;;) {
+		if (poll(pfd, nr, -1) < 0) {
+			if (errno !=3D EINTR) {
+				error("Poll failed, resuming: %s", strerror(errno));
+				sleep(1);
+			}
+			continue;
+		}
+
+		if ((pfd[0].revents & POLLIN) && handle_command(fd))
+			break;
+	}
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index 6f21e3f..76cf0e3 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -14,6 +14,7 @@
 #include "resolve-undo.h"
 #include "strbuf.h"
 #include "varint.h"
+#include "file-watcher-lib.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,=
 int really);
=20
@@ -1447,6 +1448,37 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static void validate_watcher(struct index_state *istate, const char *p=
ath)
+{
+	int i;
+
+	if (getenv("GIT_NO_FILE_WATCHER")) {
+		istate->watcher =3D -1;
+		return;
+	}
+
+	istate->watcher =3D connect_watcher(path);
+	if (istate->watcher !=3D -1) {
+		struct strbuf sb =3D STRBUF_INIT;
+		char *msg;
+		strbuf_addf(&sb, "hello %s", sha1_to_hex(istate->sha1));
+		if (send_watcher(istate->watcher, NULL, "%s", sb.buf) > 0 &&
+		    (msg =3D read_watcher(istate->watcher, NULL, NULL)) !=3D NULL &&
+		    !strcmp(msg, sb.buf)) { /* good */
+			strbuf_release(&sb);
+			return;
+		}
+		strbuf_release(&sb);
+	}
+
+	/* No the file watcher is out of date, clear everything */
+	for (i =3D 0; i < istate->cache_nr; i++)
+		if (istate->cache[i]->ce_flags & CE_WATCHED) {
+			istate->cache[i]->ce_flags &=3D ~CE_WATCHED;
+			istate->cache_changed =3D 1;
+		}
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int read_index_from(struct index_state *istate, const char *path)
 {
@@ -1532,6 +1564,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		src_offset +=3D extsize;
 	}
 	munmap(mmap, mmap_size);
+	validate_watcher(istate, path);
 	return istate->cache_nr;
=20
 unmap:
@@ -1557,6 +1590,10 @@ int discard_index(struct index_state *istate)
 	istate->timestamp.nsec =3D 0;
 	free_name_hash(istate);
 	cache_tree_free(&(istate->cache_tree));
+	if (istate->watcher > 0) {
+		close(istate->watcher);
+		istate->watcher =3D -1;
+	}
 	istate->initialized =3D 0;
 	free(istate->cache);
 	istate->cache =3D NULL;
diff --git a/trace.c b/trace.c
index 3d744d1..0b8ebe0 100644
--- a/trace.c
+++ b/trace.c
@@ -75,8 +75,7 @@ static void trace_vprintf(const char *key, const char=
 *fmt, va_list ap)
 	strbuf_release(&buf);
 }
=20
-__attribute__((format (printf, 2, 3)))
-static void trace_printf_key(const char *key, const char *fmt, ...)
+void trace_printf_key(const char *key, const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
--=20
1.8.5.1.208.g05b12ea
