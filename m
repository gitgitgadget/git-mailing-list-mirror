From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 3/6] read-cache: connect to file watcher
Date: Sun, 12 Jan 2014 18:03:39 +0700
Message-ID: <1389524622-6702-4-git-send-email-pclouds@gmail.com>
References: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 12 11:58:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2Ikp-0006n6-Nx
	for gcvg-git-2@plane.gmane.org; Sun, 12 Jan 2014 11:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbaALK6u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Jan 2014 05:58:50 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:55411 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751212AbaALK6o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jan 2014 05:58:44 -0500
Received: by mail-pa0-f52.google.com with SMTP id kx10so2689211pab.39
        for <git@vger.kernel.org>; Sun, 12 Jan 2014 02:58:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=2saGKG1MpmxFDbqhKFWIrxXRAIrYDvYrlxcpWU4zr9E=;
        b=grFf/Vb3VQ3dQrOTWLoZj5e6WhV8w6sHWfThZsfNlNIn2VISpmjL3MfVbqHB4nEj4H
         4+doSLgaNIhRFztl9ptaMo5twFmCWhp6nVV1NX4FOrxkdXSBlwxe/wfavsFAjgPFra+x
         yab5hp6gFWkLRW2wLGnhDAVyhVh8VpBBWe3Ue7rxD8whsWNq4QhcnCiNcNF5x+Ftoo7m
         wIBmAXA7ezSzB1mv0BUomrNA7FaA13h6eJ4J9npbcjftZAcfrcgTFrh/JThIqc33FBd8
         8iLsskkdMjz1vKiHGb94njiGqrum2KIMRZ/Hh2RbJiPfsy1I5skSWZVlXsHD0y60k9ra
         EKhA==
X-Received: by 10.66.188.203 with SMTP id gc11mr22964616pac.63.1389524324169;
        Sun, 12 Jan 2014 02:58:44 -0800 (PST)
Received: from lanh ([115.73.194.184])
        by mx.google.com with ESMTPSA id ju10sm30158433pbd.33.2014.01.12.02.58.41
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 12 Jan 2014 02:58:43 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Sun, 12 Jan 2014 18:04:01 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1389524622-6702-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240342>

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

TODO: do not let git hang if the file watcher refuses to
answer. Timeout and move on without file watcher support after 20ms or
so.

(*) for current index versions, the signature is the index SHA-1
trailer. But it could be something else (e.g. v5 does not have SHA-1
trailer)

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore           |   1 +
 Makefile             |   1 +
 cache.h              |   1 +
 file-watcher.c (new) | 136 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
 git-compat-util.h    |   5 ++
 read-cache.c         |  48 ++++++++++++++++++
 wrapper.c            |  27 ++++++++++
 7 files changed, 219 insertions(+)
 create mode 100644 file-watcher.c

diff --git a/.gitignore b/.gitignore
index b5f9def..12c78f0 100644
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
index b4af1e2..ca5dc96 100644
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
diff --git a/cache.h b/cache.h
index dfa8622..6a182b5 100644
--- a/cache.h
+++ b/cache.h
@@ -281,6 +281,7 @@ struct index_state {
 	struct hash_table name_hash;
 	struct hash_table dir_hash;
 	unsigned char sha1[20];
+	int watcher;
 };
=20
 extern struct index_state the_index;
diff --git a/file-watcher.c b/file-watcher.c
new file mode 100644
index 0000000..66b44e5
--- /dev/null
+++ b/file-watcher.c
@@ -0,0 +1,136 @@
+#include "cache.h"
+#include "sigchain.h"
+
+static char index_signature[41];
+
+static int handle_command(int fd, char *msg, int msgsize)
+{
+	struct sockaddr_un sun;
+	int len;
+	socklen_t socklen;
+	const char *arg;
+
+	socklen =3D sizeof(sun);
+	len =3D recvfrom(fd, msg, msgsize, 0, &sun, &socklen);
+	if (!len)
+		return -1;
+	if (len =3D=3D -1)
+		die_errno("read");
+	msg[len] =3D '\0';
+
+	if ((arg =3D skip_prefix(msg, "hello "))) {
+		sendtof(fd, 0, &sun, socklen, "hello %s", index_signature);
+		if (!strcmp(index_signature, arg))
+			return 0;
+		/*
+		 * Index SHA-1 mismatch, something has gone
+		 * wrong. Clean up and start over.
+		 */
+		strlcpy(index_signature, arg, sizeof(index_signature));
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
+int main(int argc, char **argv)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct sockaddr_un sun;
+	struct pollfd pfd[2];
+	int fd, err, nr;
+	int msgsize;
+	char *msg;
+	socklen_t vallen =3D sizeof(msgsize);
+	int no_daemon =3D 0;
+
+	if (!strcmp(argv[1], "--no-daemon")) {
+		no_daemon =3D1;
+		argv++;
+		argc--;
+	}
+	if (argc < 2)
+		die("insufficient arguments");
+	socket_path =3D argv[1];
+	memset(index_signature, 0, sizeof(index_signature));
+	fd =3D socket(AF_UNIX, SOCK_DGRAM, 0);
+	sun.sun_family =3D AF_UNIX;
+	strlcpy(sun.sun_path, socket_path, sizeof(sun.sun_path));
+	if (bind(fd, (struct sockaddr *)&sun, sizeof(sun)))
+		die_errno("unable to bind to %s", socket_path);
+	atexit(cleanup);
+	sigchain_push_common(cleanup_on_signal);
+
+	if (getsockopt(fd, SOL_SOCKET, SO_SNDBUF, &msgsize, &vallen))
+		die_errno("could not get SO_SNDBUF");
+	msg =3D xmalloc(msgsize + 1);
+
+	if (!no_daemon) {
+		strbuf_addf(&sb, "%s.log", socket_path);
+		err =3D open(sb.buf, O_CREAT | O_TRUNC | O_WRONLY, 0600);
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
+		if ((pfd[0].revents & POLLIN) && handle_command(fd, msg, msgsize))
+			break;
+	}
+	return 0;
+}
diff --git a/git-compat-util.h b/git-compat-util.h
index b73916b..c119a94 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -536,6 +536,11 @@ extern void *xcalloc(size_t nmemb, size_t size);
 extern void *xmmap(void *start, size_t length, int prot, int flags, in=
t fd, off_t offset);
 extern ssize_t xread(int fd, void *buf, size_t len);
 extern ssize_t xwrite(int fd, const void *buf, size_t len);
+extern ssize_t writef(int fd, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+extern ssize_t sendtof(int sockfd, int flags, const void *dest_addr,
+		       socklen_t addrlen, const char *fmt, ...)
+	__attribute__((format (printf, 5, 6)));
 extern int xdup(int fd);
 extern FILE *xfdopen(int fd, const char *mode);
 extern int xmkstemp(char *template);
diff --git a/read-cache.c b/read-cache.c
index 098d3b6..506d488 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1443,6 +1443,49 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static void connect_watcher(struct index_state *istate, const char *pa=
th)
+{
+	struct stat st;
+	struct strbuf sb =3D STRBUF_INIT;
+	int i;
+
+	strbuf_addf(&sb, "%s.watcher", path);
+	if (!stat(sb.buf, &st) && S_ISSOCK(st.st_mode)) {
+		struct sockaddr_un sun;
+		istate->watcher =3D socket(AF_UNIX, SOCK_DGRAM, 0);
+		sun.sun_family =3D AF_UNIX;
+		strlcpy(sun.sun_path, sb.buf, sizeof(sun.sun_path));
+		if (connect(istate->watcher, (struct sockaddr *)&sun, sizeof(sun))) =
{
+			perror("connect");
+			close(istate->watcher);
+			istate->watcher =3D -1;
+		}
+		sprintf(sun.sun_path, "%c%"PRIuMAX, 0, (uintmax_t)getpid());
+		bind(istate->watcher, (struct sockaddr *)&sun, sizeof(sun));
+	} else
+		istate->watcher =3D -1;
+	strbuf_release(&sb);
+	if (istate->watcher !=3D -1) {
+		char line[1024];
+		int len;
+		strbuf_addf(&sb, "hello %s", sha1_to_hex(istate->sha1));
+		write(istate->watcher, sb.buf, sb.len);
+		len =3D read(istate->watcher, line, sizeof(line) - 1);
+		if (len > 0) {
+			line[len] =3D '\0';
+			if (!strcmp(sb.buf, line))
+				return; /* good */
+		}
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
@@ -1528,6 +1571,7 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 		src_offset +=3D extsize;
 	}
 	munmap(mmap, mmap_size);
+	connect_watcher(istate, path);
 	return istate->cache_nr;
=20
 unmap:
@@ -1557,6 +1601,10 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache =3D NULL;
 	istate->cache_alloc =3D 0;
+	if (istate->watcher !=3D -1) {
+		close(istate->watcher);
+		istate->watcher =3D -1;
+	}
 	return 0;
 }
=20
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..29e3b35 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -455,3 +455,30 @@ struct passwd *xgetpwuid_self(void)
 		    errno ? strerror(errno) : _("no such user"));
 	return pw;
 }
+
+ssize_t writef(int fd, const char *fmt, ...)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret;
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+	ret =3D write(fd, sb.buf, sb.len);
+	strbuf_release(&sb);
+	return ret;
+}
+
+ssize_t sendtof(int sockfd, int flags, const void *dest_addr, socklen_=
t addrlen,
+		const char *fmt, ...)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	int ret;
+	va_list ap;
+	va_start(ap, fmt);
+	strbuf_vaddf(&sb, fmt, ap);
+	va_end(ap);
+	ret =3D sendto(sockfd, sb.buf, sb.len, flags, dest_addr, addrlen);
+	strbuf_release(&sb);
+	return ret;
+}
--=20
1.8.5.2.240.g8478abd
