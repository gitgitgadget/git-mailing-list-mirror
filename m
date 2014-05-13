From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/3] Add read-cache--daemon
Date: Tue, 13 May 2014 18:15:29 +0700
Message-ID: <1399979737-8577-3-git-send-email-pclouds@gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 13 13:15:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkAgb-0007yx-4T
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:15:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760354AbaEMLPr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 07:15:47 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:42920 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760176AbaEMLPq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 07:15:46 -0400
Received: by mail-pa0-f49.google.com with SMTP id lj1so166391pab.22
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pgVRzs4RHiZ/bVE/KVK45/ivrUnsBbwYr9X+SPrmbuY=;
        b=s+Ccf4x3UgPrRAjdWcqszyaLQEgLb1EH6oSfZPbLJcVZhiMDCq/HzIOAK88cJar0mv
         ShiIEdPtU3JJ1ScT0/GlcZJgfflvPpyyeSLMRyLZry7aJaFPk5bnSth4b4n9MBA6nklM
         th3W0ssBhEVmu9TepsvbxWuwlrQp2j3haZt/afmSmw4uqp0rTXLFSZYwc7BPaY4Cgxle
         an/OARr2yySHmevfpZWuM9K+Kn6BDzp8DX/La/WBl9q0RFlIUTyN+g6BC/mBT2Sbo+VU
         y1lxvTXosjZGdfXqWaNcYnlfhZKkcQ5SzVmhEKykjkA4/I7al+5mCSL8ARmIK7UoBpfr
         bj5A==
X-Received: by 10.69.31.11 with SMTP id ki11mr4443532pbd.88.1399979745747;
        Tue, 13 May 2014 04:15:45 -0700 (PDT)
Received: from lanh ([115.73.238.182])
        by mx.google.com with ESMTPSA id it4sm27725937pbc.39.2014.05.13.04.15.42
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 13 May 2014 04:15:45 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 13 May 2014 18:15:51 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1399979737-8577-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248762>

---
 .gitignore                 |   1 +
 Makefile                   |   6 ++
 config.mak.uname           |   1 +
 git-compat-util.h          |   8 +++
 read-cache--daemon.c (new) | 167 +++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 183 insertions(+)
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
diff --git a/Makefile b/Makefile
index 028749b..98d22de 100644
--- a/Makefile
+++ b/Makefile
@@ -1502,6 +1502,12 @@ ifdef HAVE_DEV_TTY
 	BASIC_CFLAGS += -DHAVE_DEV_TTY
 endif
 
+ifdef HAVE_SHM
+	BASIC_CFLAGS += -DHAVE_SHM
+	EXTLIBS += -lrt
+	PROGRAM_OBJS += read-cache--daemon.o
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/config.mak.uname b/config.mak.uname
index 23a8803..b6a37e5 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -33,6 +33,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
 	HAVE_DEV_TTY = YesPlease
+	HAVE_SHM = YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY = YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..b2116ab 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -723,4 +723,12 @@ struct tm *git_gmtime_r(const time_t *, struct tm *);
 #define gmtime_r git_gmtime_r
 #endif
 
+#ifndef HAVE_SHM
+static inline int shm_open(const char *path, int flags, int mode)
+{
+	errno = ENOSYS;
+	return -1;
+}
+#endif
+
 #endif
diff --git a/read-cache--daemon.c b/read-cache--daemon.c
new file mode 100644
index 0000000..52b4067
--- /dev/null
+++ b/read-cache--daemon.c
@@ -0,0 +1,167 @@
+#include "cache.h"
+#include "sigchain.h"
+#include "unix-socket.h"
+#include "split-index.h"
+#include "pkt-line.h"
+
+static char *socket_path;
+static struct strbuf shm_index = STRBUF_INIT;
+static struct strbuf shm_sharedindex = STRBUF_INIT;
+
+static void cleanup_socket(void)
+{
+	if (socket_path)
+		unlink(socket_path);
+	if (shm_index.len)
+		shm_unlink(shm_index.buf);
+	if (shm_sharedindex.len)
+		shm_unlink(shm_sharedindex.buf);
+}
+
+static void cleanup_socket_on_signal(int sig)
+{
+	cleanup_socket();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+static void share_index(struct index_state *istate, struct strbuf *shm_path)
+{
+	struct strbuf sb = STRBUF_INIT;
+	void *map;
+	int fd;
+
+	strbuf_addf(&sb, "/git-index-%s", sha1_to_hex(istate->sha1));
+	if (shm_path->len && strcmp(sb.buf, shm_path->buf)) {
+		shm_unlink(shm_path->buf);
+		strbuf_reset(shm_path);
+	}
+	fd = shm_open(sb.buf, O_RDWR | O_CREAT | O_TRUNC, 0700);
+	if (fd < 0)
+		return;
+	/*
+	 * We "lock" the shm in preparation by set its size larger
+	 * than expected. The reader is supposed to check the size and
+	 * ignore if shm size is different than the actual file size
+	 */
+	if (ftruncate(fd, istate->mmap_size + 1)) {
+		close(fd);
+		shm_unlink(shm_path->buf);
+		return;
+	}
+	strbuf_addbuf(shm_path, &sb);
+	map = xmmap(NULL, istate->mmap_size, PROT_READ | PROT_WRITE,
+		    MAP_SHARED, fd, 0);
+	if (map == MAP_FAILED) {
+		close(fd);
+		shm_unlink(shm_path->buf);
+		return;
+	}
+	memcpy(map, istate->mmap, istate->mmap_size);
+	munmap(map, istate->mmap_size);
+	/* Now "unlock" it */
+	if (ftruncate(fd, istate->mmap_size)) {
+		close(fd);
+		shm_unlink(shm_path->buf);
+		return;
+	}
+	close(fd);
+}
+
+static void refresh()
+{
+	the_index.keep_mmap = 1;
+	if (read_cache() < 0)
+		die("could not read index");
+	share_index(&the_index, &shm_index);
+	if (the_index.split_index &&
+	    the_index.split_index->base)
+		share_index(the_index.split_index->base, &shm_sharedindex);
+	discard_index(&the_index);
+}
+
+static unsigned long next;
+static int serve_cache_loop(int fd)
+{
+	struct pollfd pfd;
+	unsigned long now = time(NULL);
+
+	if (now > next)
+		return 0;
+
+	pfd.fd = fd;
+	pfd.events = POLLIN;
+	if (poll(&pfd, 1, 1000 * (next - now)) < 0) {
+		if (errno != EINTR)
+			die_errno("poll failed");
+		return 1;
+	}
+
+	if (pfd.revents & POLLIN) {
+		int client = accept(fd, NULL, NULL);
+		if (client < 0) {
+			warning("accept failed: %s", strerror(errno));
+			return 1;
+		}
+		refresh();
+		close(client);
+		next = now + 600;
+	}
+	return 1;
+}
+
+static void serve_cache(const char *socket_path)
+{
+	int fd;
+
+	fd = unix_stream_listen(socket_path);
+	if (fd < 0)
+		die_errno("unable to bind to '%s'", socket_path);
+
+	refresh();
+
+	printf("ok\n");
+	fclose(stdout);
+
+	next = time(NULL) + 600;
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
+	char *path_copy = xstrdup(path);
+	char *dir = dirname(path_copy);
+
+	if (!stat(dir, &st)) {
+		free(path_copy);
+		return;
+	}
+
+	/*
+	 * We must be sure to create the directory with the correct mode,
+	 * not just chmod it after the fact; otherwise, there is a race
+	 * condition in which somebody can chdir to it, sleep, then try to open
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
+	setup_git_directory();
+	socket_path = git_pathdup("daemon/index");
+	check_socket_directory(socket_path);
+	atexit(cleanup_socket);
+	sigchain_push_common(cleanup_socket_on_signal);
+	serve_cache(socket_path);
+	return 0;
+}
-- 
1.9.1.346.ga2b5940
