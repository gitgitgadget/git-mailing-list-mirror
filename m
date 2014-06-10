From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 2/5] index-helper: new daemon for caching index and related stuff
Date: Tue, 10 Jun 2014 20:24:22 +0700
Message-ID: <1402406665-27988-3-git-send-email-pclouds@gmail.com>
References: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 15:26:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuM4T-0004BT-Tk
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 15:26:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbaFJN0e convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jun 2014 09:26:34 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:53705 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752018AbaFJN0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 09:26:32 -0400
Received: by mail-pd0-f175.google.com with SMTP id z10so6105720pdj.20
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Hu5rPhQzb0Bvrdceeeg50v4078bZJ74G9Zo/weeZ8mI=;
        b=g4QkDX6NWDXbhG7P2kQkERPloHi49yVYijq0q0XiQLPyCel1zNovyKwB4ulWiDXgF5
         m8z/t2kXke06H4eng/560DkkDKDT4EDyC3xRdbwZUELG0Bcxv7aIVj7xMsoUQvIIg66c
         i7zgD4uRx7M6suuH5JXgKmYfei7HdV3S9UYHv5uQYwujJOLPOTVUDqh+5ZXeaeqA4wIJ
         mlt3414cMTZbYG06lrw9zPVjXM1BjKJaJTtBEZTfyNa9dq8p8x5vBpq/FRWtPa2HVTYQ
         c0RgvE4UgARTop76HL6zzk8iHK/5N8dBDsMVgNyKu9XIR3rtGK99dZsJoIVAzbiPsXga
         h0AA==
X-Received: by 10.68.130.38 with SMTP id ob6mr10951004pbb.141.1402406792392;
        Tue, 10 Jun 2014 06:26:32 -0700 (PDT)
Received: from lanh ([115.73.243.79])
        by mx.google.com with ESMTPSA id qf10sm69624715pbc.23.2014.06.10.06.26.27
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jun 2014 06:26:30 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Tue, 10 Jun 2014 20:26:26 +0700
X-Mailer: git-send-email 1.9.1.346.ga2b5940
In-Reply-To: <1402406665-27988-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251188>

The shared memory's name folows the template "git-<something>-<SHA1>"
where <SHA1> is the trailing SHA-1 of the index file. <something> is
"index" for caching index files. If such shared memory exists, it
contains the same index content as on disk. The content is already
validated by the daemon and git won't validate it again. Note that it
does not necessarily use the same format as the on-disk version. The
content could be in a format that can be parsed much faster, or even
reused without parsing).

Git can poke the daemon to tell it to refresh the index cache, or to
not exit for another some minutes via UNIX signals. It can't give any
real data directly to the daemon. Real data goes to disk first, then
the daemon reads and verifies it from there.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                               |   1 +
 Documentation/git-index-helper.txt (new) |  24 +++++
 Makefile                                 |   7 ++
 cache.h                                  |   1 +
 config.mak.uname                         |   1 +
 git-compat-util.h                        |   1 +
 index-helper.c (new)                     | 145 +++++++++++++++++++++++=
++++++++
 read-cache.c                             |  78 +++++++++++++++--
 shm.c (new)                              |  67 ++++++++++++++
 shm.h (new)                              |  23 +++++
 10 files changed, 341 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h

diff --git a/.gitignore b/.gitignore
index 70992a4..5a829dd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -71,6 +71,7 @@
 /git-http-fetch
 /git-http-push
 /git-imap-send
+/git-index-helper
 /git-index-pack
 /git-init
 /git-init-db
diff --git a/Documentation/git-index-helper.txt b/Documentation/git-ind=
ex-helper.txt
new file mode 100644
index 0000000..d0b1365
--- /dev/null
+++ b/Documentation/git-index-helper.txt
@@ -0,0 +1,24 @@
+git-index-helper(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-index-helper - A simple cache server for speeding up index file ac=
cess
+
+SYNOPSIS
+--------
+[verse]
+'git index-helper
+
+DESCRIPTION
+-----------
+Keep the index file in memory for faster access. This daemon is per
+repository. This daemon is only available on POSIX system with
+shared memory support (e.g. Linux)
+
+OPTIONS
+-------
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index f7058a6..d42f3cc 100644
--- a/Makefile
+++ b/Makefile
@@ -886,6 +886,7 @@ LIB_OBJS +=3D sha1-lookup.o
 LIB_OBJS +=3D sha1_file.o
 LIB_OBJS +=3D sha1_name.o
 LIB_OBJS +=3D shallow.o
+LIB_OBJS +=3D shm.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D split-index.o
@@ -1498,6 +1499,12 @@ ifdef HAVE_DEV_TTY
 	BASIC_CFLAGS +=3D -DHAVE_DEV_TTY
 endif
=20
+ifdef HAVE_SHM
+	BASIC_CFLAGS +=3D -DHAVE_SHM
+	EXTLIBS +=3D -lrt
+	PROGRAM_OBJS +=3D index-helper.o
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS +=3D -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/cache.h b/cache.h
index 6549e02..f05e062 100644
--- a/cache.h
+++ b/cache.h
@@ -483,6 +483,7 @@ extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
+#define REFRESH_DAEMON		(1 << 2)
 extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
diff --git a/config.mak.uname b/config.mak.uname
index eee0fc2..8de61a4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -39,6 +39,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_PATHS_H =3D YesPlease
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
+	HAVE_SHM =3D YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	NO_STRLCPY =3D YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index f6d3a46..a6ebecc 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -356,6 +356,7 @@ static inline const char *skip_prefix(const char *s=
tr, const char *prefix)
 #define PROT_READ 1
 #define PROT_WRITE 2
 #define MAP_PRIVATE 1
+#define MAP_SHARED 2
 #endif
=20
 #define mmap git_mmap
diff --git a/index-helper.c b/index-helper.c
new file mode 100644
index 0000000..e10d0c3
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,145 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "sigchain.h"
+#include "split-index.h"
+#include "shm.h"
+
+static unsigned char cached_sha1[20];
+static unsigned char cached_shared_sha1[20];
+static void *shm_index, *shm_sharedindex;
+static size_t size_index, size_sharedindex;
+static int daemonized;
+
+static void cleanup(void)
+{
+	if (daemonized)
+		return;
+	unlink(git_path("read-cache--daemon.pid"));
+	if (shm_index) {
+		munmap(shm_index, size_index);
+		git_shm_unlink("git-index-%s", sha1_to_hex(cached_sha1));
+	}
+	if (shm_sharedindex) {
+		munmap(shm_sharedindex, size_sharedindex);
+		git_shm_unlink("git-index-%s", sha1_to_hex(cached_shared_sha1));
+	}
+}
+
+static void cleanup_on_signal(int sig)
+{
+	cleanup();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+static void share_index(struct index_state *istate, void **mmap,
+			size_t *length, unsigned char *sha1)
+{
+	void *new_mmap;
+	if (istate->mmap_size <=3D 20 ||
+	    hashcmp(istate->sha1,
+		    (unsigned char *)istate->mmap + istate->mmap_size - 20) ||
+	    !hashcmp(istate->sha1, sha1) ||
+	    git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate->mmap_size,
+			&new_mmap, PROT_READ | PROT_WRITE, MAP_SHARED,
+			"git-index-%s", sha1_to_hex(istate->sha1)) < 0)
+		return;
+
+	if (*mmap) {
+		munmap(*mmap, *length);
+		git_shm_unlink("git-index-%s", sha1_to_hex(sha1));
+	}
+
+	*length =3D istate->mmap_size;
+	*mmap =3D new_mmap;
+	hashcpy(sha1, istate->sha1);
+	memcpy(new_mmap, istate->mmap, istate->mmap_size - 20);
+
+	/*
+	 * The trailing hash must be written last after everything is
+	 * written. It's the indication that the shared memory is now
+	 * ready.
+	 */
+	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, sha1);
+}
+
+static void refresh(int sig)
+{
+	the_index.keep_mmap =3D 1;
+	if (read_cache() < 0)
+		die("could not read index");
+	share_index(&the_index, &shm_index, &size_index, cached_sha1);
+	if (the_index.split_index && the_index.split_index->base)
+		share_index(the_index.split_index->base, &shm_sharedindex,
+			    &size_sharedindex, cached_shared_sha1);
+	discard_index(&the_index);
+}
+
+#ifdef HAVE_SHM
+
+static void do_nothing(int sig)
+{
+	/*
+	 * what we need is the signal received and interrupts
+	 * sleep(). We don't need to do anything else when receving
+	 * the signal
+	 */
+}
+
+static void loop(const char *pid_file, int idle_in_seconds)
+{
+	sigchain_push(SIGHUP, refresh);
+	sigchain_push(SIGUSR1, do_nothing);
+	refresh(0);
+	while (sleep(idle_in_seconds))
+		utime(git_path("read-cache--daemon.pid"), NULL);
+}
+
+#else
+
+static void loop(const char *pid_file, int idle_in_seconds)
+{
+}
+
+#endif
+
+static const char * const usage_text[] =3D {
+	"git read-cache--daemon [options]",
+	NULL
+};
+
+int main(int argc, char **argv)
+{
+	static struct lock_file lock;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *prefix;
+	int fd;
+	struct option options[] =3D {
+		OPT_END()
+	};
+
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(usage_text, options);
+	prefix =3D setup_git_directory();
+	if (parse_options(argc, (const char **)argv, prefix,
+			  options, usage_text, 0))
+		die("too many arguments");
+
+	fd =3D hold_lock_file_for_update(&lock,
+				       git_path("read-cache--daemon.pid"),
+				       LOCK_DIE_ON_ERROR);
+	strbuf_addf(&sb,
+		    "%" PRIuMAX, (uintmax_t) getpid());
+	write_in_full(fd, sb.buf, sb.len);
+	commit_lock_file(&lock);
+
+	atexit(cleanup);
+	sigchain_push(SIGINT,  cleanup_on_signal);
+	sigchain_push(SIGTERM, cleanup_on_signal);
+	sigchain_push(SIGQUIT, cleanup_on_signal);
+	sigchain_push(SIGPIPE, cleanup_on_signal);
+
+	loop(sb.buf, 600);
+	strbuf_release(&sb);
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index a5031f3..f9df984 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -16,6 +16,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "sigchain.h"
+#include "shm.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1332,6 +1333,8 @@ static int verify_hdr(struct cache_header *hdr, u=
nsigned long size)
 	hdr_version =3D ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+	if (!size)
+		return 0;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
@@ -1462,6 +1465,58 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static void poke_daemon(struct stat *st, int refresh_cache)
+{
+	int fd;
+	struct strbuf sb;
+
+	if (st->st_mtime + 600 < time(NULL))
+		return;	  /* don't try to read from stale .pid file */
+
+	fd =3D open(git_path("read-cache--daemon.pid"), O_RDONLY);
+	if (fd < 0)
+		return;
+	strbuf_init(&sb, st->st_size);
+	if (read_in_full(fd, sb.buf, st->st_size) =3D=3D st->st_size) {
+#ifdef HAVE_SHM
+		char *end =3D NULL;
+		pid_t pid =3D strtoul(sb.buf, &end, 10);
+		if (end && !*end)
+			kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+#endif
+	}
+	close(fd);
+	strbuf_release(&sb);
+}
+
+static void *try_shm(struct index_state *istate, void *mmap, size_t *m=
map_size)
+{
+	void *new_mmap =3D NULL;
+	size_t old_size =3D *mmap_size;
+	ssize_t new_length;
+	const unsigned char *sha1;
+	struct stat st;
+
+	if (old_size <=3D 20)
+		return mmap;
+	sha1 =3D (unsigned char *)mmap + old_size - 20;
+	if (stat(git_path("read-cache--daemon.pid"), &st))
+		return mmap;
+	new_length =3D git_shm_map(O_RDONLY, 0700, -1, &new_mmap,
+				 PROT_READ, MAP_SHARED,
+				 "git-index-%s", sha1_to_hex(sha1));
+	if (new_length <=3D 20 ||
+	    hashcmp((unsigned char *)mmap + old_size - 20,
+		    (unsigned char *)new_mmap + new_length - 20)) {
+		if (new_mmap)
+			munmap(new_mmap, new_length);
+		return mmap;
+	}
+	poke_daemon(&st, 0);
+	*mmap_size =3D new_length;
+	return new_mmap;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1469,8 +1524,8 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	struct stat st;
 	unsigned long src_offset;
 	struct cache_header *hdr;
-	void *mmap;
-	size_t mmap_size;
+	void *mmap, *old_mmap;
+	size_t mmap_size, old_mmap_size;
 	struct strbuf previous_name_buf =3D STRBUF_INIT, *previous_name;
=20
 	if (istate->initialized)
@@ -1501,9 +1556,14 @@ int do_read_index(struct index_state *istate, co=
nst char *path, int must_exist)
 	}
 	close(fd);
=20
-	hdr =3D mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
+	old_mmap      =3D mmap;
+	old_mmap_size =3D mmap_size;
+	mmap	      =3D try_shm(istate, mmap, &mmap_size);
+	hdr	      =3D mmap;
+	if (mmap =3D=3D old_mmap && verify_hdr(hdr, mmap_size) < 0)
 		goto unmap;
+	if (mmap !=3D old_mmap)
+		munmap(old_mmap, old_mmap_size);
=20
 	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
 	istate->version =3D ntohl(hdr->hdr_version);
@@ -2006,9 +2066,13 @@ static int do_write_locked_index(struct index_st=
ate *istate, struct lock_file *l
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=3D
 	       (COMMIT_LOCK | CLOSE_LOCK));
-	if (flags & COMMIT_LOCK)
-		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
+	if (flags & COMMIT_LOCK) {
+		struct stat st;
+		if (!commit_locked_index(lock) &&
+		    !stat(git_path("read-cache--daemon.pid"), &st))
+			poke_daemon(&st, 1);
+		return ret;
+	} else if (flags & CLOSE_LOCK)
 		return close_lock_file(lock);
 	else
 		return ret;
diff --git a/shm.c b/shm.c
new file mode 100644
index 0000000..4ec1a00
--- /dev/null
+++ b/shm.c
@@ -0,0 +1,67 @@
+#include "git-compat-util.h"
+#include "shm.h"
+
+#ifdef HAVE_SHM
+
+#define SHM_PATH_LEN 72		/* we don't create very long paths.. */
+
+ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap,
+		    int prot, int flags, const char *fmt, ...)
+{
+	va_list ap;
+	char path[SHM_PATH_LEN];
+	int fd;
+
+	path[0] =3D '/';
+	va_start(ap, fmt);
+	vsprintf(path + 1, fmt, ap);
+	va_end(ap);
+	fd =3D shm_open(path, oflag, perm);
+	if (fd < 0)
+		return -1;
+	if (length > 0 && ftruncate(fd, length)) {
+		shm_unlink(path);
+		close(fd);
+		return -1;
+	}
+	if (length < 0 && !(oflag & O_CREAT)) {
+		struct stat st;
+		if (fstat(fd, &st))
+			die_errno("unable to stat %s", path);
+		length =3D st.st_size;
+	}
+	*mmap =3D xmmap(NULL, length, prot, flags, fd, 0);
+	close(fd);
+	if (*mmap =3D=3D MAP_FAILED) {
+		*mmap =3D NULL;
+		shm_unlink(path);
+		return -1;
+	}
+	return length;
+}
+
+void git_shm_unlink(const char *fmt, ...)
+{
+	va_list ap;
+	char path[SHM_PATH_LEN];
+
+	path[0] =3D '/';
+	va_start(ap, fmt);
+	vsprintf(path + 1, fmt, ap);
+	va_end(ap);
+	shm_unlink(path);
+}
+
+#else
+
+ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap,
+		    int prot, int flags, const char *fmt, ...)
+{
+	return -1;
+}
+
+void git_shm_unlink(const char *fmt, ...)
+{
+}
+
+#endif
diff --git a/shm.h b/shm.h
new file mode 100644
index 0000000..798d3fd
--- /dev/null
+++ b/shm.h
@@ -0,0 +1,23 @@
+#ifndef SHM_H
+#define SHM_H
+
+/*
+ * Create or open a shared memory and mmap it. Return mmap size if
+ * successful, -1 otherwise. If successful mmap contains the mmap'd
+ * pointer. If oflag does not contain O_CREAT and length is negative,
+ * the mmap size is retrieved from existing shared memory object.
+ *
+ * The mmap could be freed by munmap, even on Windows. Note that on
+ * Windows, git_shm_unlink() is no-op, so the last unmap will destroy
+ * the shared memory.
+ */
+ssize_t git_shm_map(int oflag, int perm, ssize_t length, void **mmap,
+		    int prot, int flags, const char *fmt, ...);
+
+/*
+ * Unlink a shared memory object. Only needed on POSIX platforms. On
+ * Windows this is no-op.
+ */
+void git_shm_unlink(const char *fmt, ...);
+
+#endif
--=20
1.9.1.346.ga2b5940
