From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 4/8] Add read-cache--daemon for caching index and related stuff
Date: Tue, 13 May 2014 18:15:33 +0700
Message-ID: <1399979737-8577-7-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:16:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAhA-0000Rc-LV
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760673AbaEMLQS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:16:18 -0400
Received: from mail-pb0-f45.google.com ([209.85.160.45]:38535 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759338AbaEMLQQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:16:16 -0400
Received: by mail-pb0-f45.google.com with SMTP id um1so162347pbc.32
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Lwh3PcCggswsDmkI1iNaqecCC3Ya08nKZGQm3u+xbr8=;
        b=oFHUPkTYFOSyRHqL0YrPBMFnBqcpFAhc9Qq49IUavxbhM5MymVuit/zCpS+tr0O/WG
         tALdWL+OmfV98fF0yTw5x/1nVTWBry6FOyE8t3V8jZ4L0AybS3/5JNgndJn8Z+wfowik
         ugOJ4A5cpN/DtMZ/PLqjYggDTIOLcaNWFqm7kqukEfMr/xU2DYfBigIcpAhs3xs7x2qY
         eY+VXxhasrIwWXewTRF0KZKgE6WB0/DuewwnTENuT1f4sGVaiCDzHDEm0wORTWLEIWqw
         SP2frHpd6Q4KTx51aYELDqiKIinT+xdV9I06WZ9s5AbjZ62WByFskPNTU4KSu+bJYp3t
         ZZdw==
X-Received: by 10.66.218.36 with SMTP id pd4mr63364039pac.141.1399979776048;
        Tue, 13 May 2014 04:16:16 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id el14sm60422830pac.31.2014.05.13.04.16.13
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:16:15 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:16:21 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248766>

The name of the shared memory folows the template "/git-index-<SHA1>"
where <SHA1> is the trailing SHA-1 of the index file. If such a shared
memory exists, it contains the same index content as on disk. The
content is already validated by the daemon. Note that it does not
necessarily use the same format as the on-disk version. The content
could be in a format that can be parsed much faster, or even reused
without parsing).

While preparing the shm object, the daemon would keep the shm object
"/git-index-<SHA1>.lock". After "git-index-<SHA1>" is ready, the
".lock" object is removed. A shared object must not be updated
afterwards. So if ".lock" does not exist, it's safe to assume that the
associated shm object is ready.

Other info could also by cached if it's tied to the index. For
example, name hash could be stored in "/git-namehash-<SHA1>"..

After Git writes a new index down, it may want to ask the daemon to
preload the new index so next time Git runs the index is already
validated and in memory. It does so by send a command to a UNIX socket
in $GIT_DIR/daemon/index.

Windows can use its named shared memory instead of POSIX shared memory
and probably named pipe in place of UNIX socket.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                                     |   1 +
 Documentation/git-read-cache--daemon.txt (new) |  27 ++++
 Makefile                                       |   6 +
 config.mak.uname                               |   1 +
 read-cache--daemon.c (new)                     | 207 +++++++++++++++++=
++++++++
 wrapper.c                                      |  14 ++
 6 files changed, 256 insertions(+)
 create mode 100644 Documentation/git-read-cache--daemon.txt
 create mode 100644 read-cache--daemon.c

diff --git a/.gitignore b/.gitignore
index 70992a4..07e0cb6 100644
--- a/.gitignore
+++ b/.gitignore
@@ -110,6 +110,7 @@
 /git-pull
 /git-push
 /git-quiltimport
+/git-read-cache--daemon
 /git-read-tree
 /git-rebase
 /git-rebase--am
diff --git a/Documentation/git-read-cache--daemon.txt b/Documentation/g=
it-read-cache--daemon.txt
new file mode 100644
index 0000000..1b05be4
--- /dev/null
+++ b/Documentation/git-read-cache--daemon.txt
@@ -0,0 +1,27 @@
+git-read-cache--daemon(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-daemon - A simple cache server for speeding up index file access
+
+SYNOPSIS
+--------
+[verse]
+'git daemon' [--detach]
+
+DESCRIPTION
+-----------
+Keep the index file in memory for faster access. This daemon is per
+repository. Note that core.useReadCacheDaemon must be set for Git to
+contact the daemon. This daemon is only available on POSIX system with
+shared memory support (e.g. Linux)
+
+OPTIONS
+-------
+--detach::
+	Detach from the shell.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index d0a2b4b..a44ab0b 100644
--- a/Makefile
+++ b/Makefile
@@ -1504,6 +1504,12 @@ ifdef HAVE_DEV_TTY
 	BASIC_CFLAGS +=3D -DHAVE_DEV_TTY
 endif
=20
+ifdef HAVE_SHM
+	BASIC_CFLAGS +=3D -DHAVE_SHM
+	EXTLIBS +=3D -lrt
+	PROGRAM_OBJS +=3D read-cache--daemon.o
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS +=3D -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 23a8803..b6a37e5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -33,6 +33,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H =3D YesPlease
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
+	HAVE_SHM =3D YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
diff --git a/read-cache--daemon.c b/read-cache--daemon.c
new file mode 100644
index 0000000..4531978
--- /dev/null
+++ b/read-cache--daemon.c
@@ -0,0 +1,207 @@
+#include "cache.h"
+#include "sigchain.h"
+#include "unix-socket.h"
+#include "split-index.h"
+#include "pkt-line.h"
+
+static char *socket_path;
+static struct strbuf shm_index =3D STRBUF_INIT;
+static struct strbuf shm_sharedindex =3D STRBUF_INIT;
+static struct strbuf shm_lock =3D STRBUF_INIT;
+static int lock_fd =3D -1;
+static int daemonized;
+
+static void cleanup_socket(void)
+{
+	if (daemonized)
+		return;
+	if (socket_path)
+		unlink(socket_path);
+	if (shm_index.len)
+		shm_unlink(shm_index.buf);
+	if (shm_sharedindex.len)
+		shm_unlink(shm_sharedindex.buf);
+	if (lock_fd !=3D -1)
+		close(lock_fd);
+	if (shm_lock.len)
+		shm_unlink(shm_lock.buf);
+}
+
+static void cleanup_socket_on_signal(int sig)
+{
+	cleanup_socket();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+static int do_share_index(struct index_state *istate, struct strbuf *s=
hm_path)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	void *map;
+	int fd;
+
+	strbuf_addf(&sb, "/git-index-%s", sha1_to_hex(istate->sha1));
+	fd =3D shm_open(sb.buf, O_RDWR | O_CREAT | O_EXCL, 0700);
+	if (fd < 0)
+		return -1;
+	if (shm_path->len) {
+		shm_unlink(shm_path->buf);
+		strbuf_reset(shm_path);
+	}
+	if (ftruncate(fd, istate->mmap_size)) {
+		close(fd);
+		shm_unlink(shm_path->buf);
+		return -1;
+	}
+	strbuf_addbuf(shm_path, &sb);
+	map =3D xmmap(NULL, istate->mmap_size, PROT_READ | PROT_WRITE,
+		    MAP_SHARED, fd, 0);
+	if (map =3D=3D MAP_FAILED) {
+		close(fd);
+		shm_unlink(shm_path->buf);
+		return -1;
+	}
+	memcpy(map, istate->mmap, istate->mmap_size);
+	munmap(map, istate->mmap_size);
+	fchmod(fd, 0400);
+	close(fd);
+	return 0;
+}
+
+static void share_index(struct index_state *istate, struct strbuf *shm=
_path)
+{
+	if (shm_lock.len)
+		return;
+
+	strbuf_addf(&shm_lock, "/git-index-%s.lock", sha1_to_hex(istate->sha1=
));
+	lock_fd =3D shm_open(shm_lock.buf, O_CREAT | O_EXCL, 0700);
+	if (lock_fd < 0) {
+		strbuf_reset(&shm_lock);
+		return;
+	}
+	do_share_index(istate, shm_path);
+	close(lock_fd);
+	lock_fd =3D -1;
+	shm_unlink(shm_lock.buf);
+	strbuf_reset(&shm_lock);
+}
+
+static void refresh()
+{
+	the_index.keep_mmap =3D 1;
+	if (read_cache() < 0)
+		die("could not read index");
+	share_index(&the_index, &shm_index);
+	if (the_index.split_index &&
+	    the_index.split_index->base)
+		share_index(the_index.split_index->base, &shm_sharedindex);
+	discard_index(&the_index);
+}
+
+static void serve_one_client(int fd)
+{
+	char *buf =3D packet_read_line(fd, NULL);
+	if (!strcmp(buf, "refresh"))
+		refresh();
+	else
+		fprintf(stderr, "unrecognized command %s\n", buf);
+}
+
+static unsigned long next;
+static int serve_cache_loop(int fd)
+{
+	struct pollfd pfd;
+	unsigned long now =3D time(NULL);
+
+	if (now > next)
+		return 0;
+
+	pfd.fd =3D fd;
+	pfd.events =3D POLLIN;
+	if (poll(&pfd, 1, 1000 * (next - now)) < 0) {
+		if (errno !=3D EINTR)
+			die_errno("poll failed");
+		return 1;
+	}
+
+	if (pfd.revents & POLLIN) {
+		int client =3D accept(fd, NULL, NULL);
+		if (client < 0) {
+			warning("accept failed: %s", strerror(errno));
+			return 1;
+		}
+		serve_one_client(client);
+		close(client);
+		next =3D now + 600;
+	}
+	return 1;
+}
+
+static void serve_cache(const char *socket_path, int detach)
+{
+	int fd;
+
+	fd =3D unix_stream_listen(socket_path);
+	if (fd < 0)
+		die_errno("unable to bind to '%s'", socket_path);
+
+	refresh();
+	if (detach && daemonize(&daemonized))
+		die_errno("unable to detach");
+
+	next =3D time(NULL) + 600;
+	while (serve_cache_loop(fd))
+		; /* nothing */
+
+	close(fd);
+	unlink(socket_path);
+}
+
+static void check_socket_directory(const char *path)
+{
+	struct stat st;
+	char *path_copy =3D xstrdup(path);
+	char *dir =3D dirname(path_copy);
+
+	if (!stat(dir, &st)) {
+		free(path_copy);
+		return;
+	}
+
+	/*
+	 * We must be sure to create the directory with the correct mode,
+	 * not just chmod it after the fact; otherwise, there is a race
+	 * condition in which somebody can chdir to it, sleep, then try to op=
en
+	 * our protected socket.
+	 */
+	if (safe_create_leading_directories_const(dir) < 0)
+		die_errno("unable to create directories for '%s'", dir);
+	if (mkdir(dir, 0700) < 0)
+		die_errno("unable to mkdir '%s'", dir);
+	free(path_copy);
+}
+
+int main(int argc, const char **argv)
+{
+	int detach =3D 0;
+	switch (argc) {
+	case 1:
+		break;
+	case 2:
+		if (!strcmp(argv[1], "--detach"))
+			detach =3D 1;
+		else
+			die("unknown option %s", argv[1]);
+		break;
+	default:
+		die("unexpected argument number %d\n", argc);
+	}
+
+	setup_git_directory();
+	socket_path =3D git_pathdup("daemon/index");
+	check_socket_directory(socket_path);
+	atexit(cleanup_socket);
+	sigchain_push_common(cleanup_socket_on_signal);
+	serve_cache(socket_path, detach);
+	return 0;
+}
diff --git a/wrapper.c b/wrapper.c
index 0cc5636..4cd7415 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -455,3 +455,17 @@ struct passwd *xgetpwuid_self(void)
 		    errno ? strerror(errno) : _("no such user"));
 	return pw;
 }
+
+#ifndef HAVE_SHM
+int shm_open(const char *path, int flags, mode_t mode)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+
+int shm_unlink(const char *path)
+{
+	errno =3D ENOSYS;
+	return -1;
+}
+#endif
--=20
1.9.1.346.ga2b5940
