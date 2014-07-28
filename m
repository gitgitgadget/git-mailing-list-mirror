From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 4/9] index-helper: new daemon for caching index and related stuff
Date: Mon, 28 Jul 2014 19:03:10 +0700
Message-ID: <1406548995-28549-5-git-send-email-pclouds@gmail.com>
References: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 28 14:04:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBjf7-0002yi-5k
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 14:04:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752640AbaG1MEM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 08:04:12 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:60438 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751365AbaG1MEK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2014 08:04:10 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so9818593pdj.30
        for <git@vger.kernel.org>; Mon, 28 Jul 2014 05:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=X3H0R3mkvNwpeDrf4xa41ORnjqslYxgntiywUy6JX64=;
        b=HGeY6pLe5JNo+uueE/11TcPRgRSFGLymJdN/6zVuTVpYc1w/o65WV3mYdIhyt3Gx9w
         DcwIT6zv2nYa5Z/icEeEVWUZVyQn01/RMBmpcxmS/shuUTbNFEDtur7T+Sef5ZFuROxa
         sVnt2GyzzNkerMlxpgIFMeiUcCDOuBNNuoiIns8EDWKmbYmcgiRy1qTcofuE5tG6b/Ij
         2P6NCoKdPSRmrZTEC2T9MjUv/7W4SzvzpBe7Ti72lpHxfq0tNtPWNJKczF66E1MVfJcP
         rJ/Y7rqPG1kjwhePZl/fPTiF/3JcgTAJ+ZPNmUZ+88CNDG1RNuyDhshKzx6Z4oPi/W4Q
         3ToQ==
X-Received: by 10.70.103.238 with SMTP id fz14mr2353714pdb.153.1406549049800;
        Mon, 28 Jul 2014 05:04:09 -0700 (PDT)
Received: from lanh ([115.73.211.176])
        by mx.google.com with ESMTPSA id qj1sm17475296pbb.24.2014.07.28.05.04.06
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jul 2014 05:04:09 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Mon, 28 Jul 2014 19:04:11 +0700
X-Mailer: git-send-email 2.1.0.rc0.66.gb9187ad
In-Reply-To: <1406548995-28549-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254318>

Instead of reading the index from disk and worrying about disk
corruption, the index is cached in memory (memory bit-flips happen
too, but hopefully less often). The result is faster read.

The biggest gain is not having to verify the trailing SHA-1, which
takes lots of time especially on large index files. But this also
opens doors for further optimiztions:

 - we could create an in-memory format that's essentially the memory
   dump of the index to eliminate most of parsing/allocation
   overhead. The mmap'd memory can be used straight away.

 - we could cache non-index info such as name hash

The shared memory's name folows the template "git-<object>-<SHA1>"
where <SHA1> is the trailing SHA-1 of the index file. <object> is
"index" for cached index files (and may be "name-hash" for name-hash
cache). If such shared memory exists, it contains the same index
content as on disk. The content is already validated by the daemon and
git won't validate it again (except comparing the trailing SHA-1s).

Git can poke the daemon to tell it to refresh the index cache, or to
keep it alive some more minutes via UNIX signals. It can't give any
real index data directly to the daemon. Real data goes to disk first,
then the daemon reads and verifies it from there.

$GIT_DIR/index-helper.pid contains a reference to daemon process (and
it's pid on *nix). The file's mtime is updated every time it's accessed
(or should be updated often enough). Old index-helper.pid is considered
stale and ignored.

index-helper requires POSIX realtime extension. POSIX shm interface
however is abstracted away so that Windows support can be added later.

On webkit.git with index format v2, duplicating 8 times to 1.4m
entries and 200MB in size:

  (vanilla)      0.986986364 s: read_index_from .git/index
  (index-helper) 0.267850279 s: read_index_from .git/index

Interestingly with index v4, we get less out of index-helper. It makes
sense as v4 requires more processing after loading the index:

  (vanilla)      0.722496666 s: read_index_from .git/index
  (index-helper) 0.302741500 s: read_index_from .git/index

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                               |   1 +
 Documentation/git-index-helper.txt (new) |  44 +++++++++
 Makefile                                 |   9 ++
 cache.h                                  |   2 +
 config.mak.uname                         |   1 +
 git-compat-util.h                        |   1 +
 index-helper.c (new)                     | 157 +++++++++++++++++++++++=
++++++++
 read-cache.c                             |  85 +++++++++++++++--
 shm.c (new)                              |  67 +++++++++++++
 shm.h (new)                              |  23 +++++
 10 files changed, 381 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h

diff --git a/.gitignore b/.gitignore
index 81e12c0..66148ef 100644
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
index 0000000..da41c4d
--- /dev/null
+++ b/Documentation/git-index-helper.txt
@@ -0,0 +1,44 @@
+git-index-helper(1)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+git-index-helper - A simple cache daemon for speeding up index file ac=
cess
+
+SYNOPSIS
+--------
+[verse]
+'git index-helper' [options]
+
+DESCRIPTION
+-----------
+Keep the index file in memory for faster access. This daemon is per
+repository.
+
+OPTIONS
+-------
+
+--exit-after=3D<n>::
+	Exit if the cached index is not accessed for `<n>`
+	minutes. Specify 0 to wait forever. Default is 10.
+
+NOTES
+-----
+On UNIX-like systems, $GIT_DIR/index-helper.pid contains the process
+id of the daemon. At least on Linux, shared memory objects are
+availble via /dev/shm with the name pattern "git-<something>-<SHA1>".
+Normally the daemon will clean up shared memory objects when it exits.
+But if it crashes, some objects could remain there and they can be
+safely deleted with "rm" command. The following signals are used to
+control the daemon:
+
+SIGHUP::
+	Reread the index.
+
+SIGUSR1::
+	This signal is counted as "an access", which keeps the daemon
+	alive longer, unless `--exit-after=3D0` is used.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 2320de5..24734e6 100644
--- a/Makefile
+++ b/Makefile
@@ -342,6 +342,8 @@ all::
 # return NULL when it receives a bogus time_t.
 #
 # Define HAVE_CLOCK_GETTIME if your platform has clock_gettime in libr=
t.
+#
+# Define HAVE_SHM if you platform support shm_* functions in librt.
=20
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -876,6 +878,7 @@ LIB_OBJS +=3D sha1-lookup.o
 LIB_OBJS +=3D sha1_file.o
 LIB_OBJS +=3D sha1_name.o
 LIB_OBJS +=3D shallow.o
+LIB_OBJS +=3D shm.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D split-index.o
@@ -1469,6 +1472,12 @@ ifdef HAVE_DEV_TTY
 	BASIC_CFLAGS +=3D -DHAVE_DEV_TTY
 endif
=20
+ifdef HAVE_SHM
+	BASIC_CFLAGS	+=3D -DHAVE_SHM
+	EXTLIBS	        +=3D -lrt
+	PROGRAM_OBJS	+=3D index-helper.o
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS +=3D -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
diff --git a/cache.h b/cache.h
index 978e53d..29a0c53 100644
--- a/cache.h
+++ b/cache.h
@@ -499,6 +499,7 @@ extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
+#define REFRESH_DAEMON		(1 << 2)
 extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
@@ -621,6 +622,7 @@ extern size_t packed_git_limit;
 extern size_t delta_base_cache_limit;
 extern unsigned long big_file_threshold;
 extern unsigned long pack_size_limit_cfg;
+extern int dont_poke_index_helper;
=20
 /*
  * Do replace refs need to be checked this run?  This variable is
diff --git a/config.mak.uname b/config.mak.uname
index 00cf4c6..7e66d80 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -35,6 +35,7 @@ ifeq ($(uname_S),Linux)
 	LIBC_CONTAINS_LIBINTL =3D YesPlease
 	HAVE_DEV_TTY =3D YesPlease
 	HAVE_CLOCK_GETTIME =3D YesPlease
+	HAVE_SHM =3D YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H =3D YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 26e92f1..13eef92 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -417,6 +417,7 @@ static inline int ends_with(const char *str, const =
char *suffix)
 #define PROT_READ 1
 #define PROT_WRITE 2
 #define MAP_PRIVATE 1
+#define MAP_SHARED 2
 #endif
=20
 #define mmap git_mmap
diff --git a/index-helper.c b/index-helper.c
new file mode 100644
index 0000000..8fa0af9
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,157 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "sigchain.h"
+#include "exec_cmd.h"
+#include "split-index.h"
+#include "shm.h"
+
+struct index_shm {
+	unsigned char sha1[20];
+	void *shm;
+	size_t size;
+};
+
+static struct index_shm shm_index;
+static struct index_shm shm_base_index;
+
+static void free_index_shm(struct index_shm *is)
+{
+	if (!is->shm)
+		return;
+	munmap(is->shm, is->size);
+	git_shm_unlink("git-index-%s", sha1_to_hex(is->sha1));
+	is->shm =3D NULL;
+}
+
+static void cleanup_shm(void)
+{
+	free_index_shm(&shm_index);
+	free_index_shm(&shm_base_index);
+}
+
+static void cleanup(void)
+{
+	unlink(git_path("index-helper.pid"));
+	cleanup_shm();
+}
+
+static void cleanup_on_signal(int sig)
+{
+	cleanup();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+static void share_index(struct index_state *istate, struct index_shm *=
is)
+{
+	void *new_mmap;
+	if (istate->mmap_size <=3D 20 ||
+	    hashcmp(istate->sha1,
+		    (unsigned char *)istate->mmap + istate->mmap_size - 20) ||
+	    !hashcmp(istate->sha1, is->sha1) ||
+	    git_shm_map(O_CREAT | O_EXCL | O_RDWR, 0700, istate->mmap_size,
+			&new_mmap, PROT_READ | PROT_WRITE, MAP_SHARED,
+			"git-index-%s", sha1_to_hex(istate->sha1)) < 0)
+		return;
+
+	free_index_shm(is);
+	is->size =3D istate->mmap_size;
+	is->shm =3D new_mmap;
+	hashcpy(is->sha1, istate->sha1);
+	memcpy(new_mmap, istate->mmap, istate->mmap_size - 20);
+
+	/*
+	 * The trailing hash must be written last after everything is
+	 * written. It's the indication that the shared memory is now
+	 * ready.
+	 */
+	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, is->sha1)=
;
+}
+
+static void refresh(int sig)
+{
+	the_index.keep_mmap =3D 1;
+	if (read_cache() < 0)
+		die(_("could not read index"));
+	if (the_index.split_index && the_index.split_index->base)
+		share_index(the_index.split_index->base, &shm_base_index);
+	share_index(&the_index, &shm_index);
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
+	sigchain_pop(SIGHUP);	/* pushed by sigchain_push_common */
+	sigchain_push(SIGHUP, refresh);
+	sigchain_push(SIGUSR1, do_nothing);
+	refresh(0);
+	while (sleep(idle_in_seconds))
+		; /* do nothing, all is handled by signal handlers already */
+}
+
+#else
+
+static void loop(const char *pid_file, int idle_in_seconds)
+{
+	die(_("index-helper is not supported on this platform"));
+}
+
+#endif
+
+static const char * const usage_text[] =3D {
+	N_("git index-helper [options]"),
+	NULL
+};
+
+int main(int argc, char **argv)
+{
+	static struct lock_file lock;
+	struct strbuf sb =3D STRBUF_INIT;
+	const char *prefix;
+	int fd, idle_in_minutes =3D 10;
+	struct option options[] =3D {
+		OPT_INTEGER(0, "exit-after", &idle_in_minutes,
+			    N_("exit if not used after some minutes")),
+		OPT_END()
+	};
+
+	git_extract_argv0_path(argv[0]);
+	git_setup_gettext();
+	dont_poke_index_helper =3D 1; /* cyclic poking is no fun */
+
+	if (argc =3D=3D 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(usage_text, options);
+
+	prefix =3D setup_git_directory();
+	if (parse_options(argc, (const char **)argv, prefix,
+			  options, usage_text, 0))
+		die(_("too many arguments"));
+
+	fd =3D hold_lock_file_for_update(&lock,
+				       git_path("index-helper.pid"),
+				       LOCK_DIE_ON_ERROR);
+	strbuf_addf(&sb,
+		    "%" PRIuMAX, (uintmax_t) getpid());
+	write_in_full(fd, sb.buf, sb.len);
+	commit_lock_file(&lock);
+
+	atexit(cleanup);
+	sigchain_push_common(cleanup_on_signal);
+
+	if (!idle_in_minutes)
+		idle_in_minutes =3D 0xffffffff / 60;
+	loop(sb.buf, idle_in_minutes * 60);
+	strbuf_release(&sb);
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index b679781..ff28142 100644
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
@@ -45,6 +46,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
=20
 struct index_state the_index;
 static const char *alternate_index_output;
+int dont_poke_index_helper;
=20
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
@@ -1465,6 +1467,65 @@ static struct cache_entry *create_from_disk(stru=
ct ondisk_cache_entry *ondisk,
 	return ce;
 }
=20
+static void poke_daemon(const struct stat *st, int refresh_cache)
+{
+	int fd;
+	struct strbuf sb;
+
+	if (dont_poke_index_helper)
+		return;
+	fd =3D open(git_path("index-helper.pid"), O_RDONLY);
+	if (fd < 0)
+		return;
+	strbuf_init(&sb, st->st_size + 1);
+	strbuf_setlen(&sb, st->st_size);
+	if (read_in_full(fd, sb.buf, st->st_size) =3D=3D st->st_size) {
+#ifdef HAVE_SHM
+		char *end =3D NULL;
+		pid_t pid =3D strtoul(sb.buf, &end, 10);
+		if (end && sb.buf + st->st_size =3D=3D end)
+			kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+#endif
+	}
+	close(fd);
+	strbuf_release(&sb);
+}
+
+/*
+ * Try to open and verify a cached shm index if available. Return 0 if
+ * succeeds (istate->mmap and istate->mmap_size are updated). Return
+ * negative otherwise.
+ */
+static int try_shm(struct index_state *istate)
+{
+	void *new_mmap =3D NULL;
+	size_t old_size =3D istate->mmap_size;
+	ssize_t new_length;
+	const unsigned char *sha1;
+	struct stat st;
+
+	if (old_size <=3D 20 ||
+	    stat(git_path("index-helper.pid"), &st))
+		return -1;
+	sha1 =3D (unsigned char *)istate->mmap + old_size - 20;
+	new_length =3D git_shm_map(O_RDONLY, 0700, -1, &new_mmap,
+				 PROT_READ, MAP_SHARED,
+				 "git-index-%s", sha1_to_hex(sha1));
+	if (new_length <=3D 20 ||
+	    hashcmp((unsigned char *)istate->mmap + old_size - 20,
+		    (unsigned char *)new_mmap + new_length - 20)) {
+		if (new_mmap)
+			munmap(new_mmap, new_length);
+		poke_daemon(&st, 1);
+		return -1;
+	}
+	munmap(istate->mmap, istate->mmap_size);
+	istate->mmap =3D new_mmap;
+	istate->mmap_size =3D new_length;
+	poke_daemon(&st, 0);
+	return 0;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1498,15 +1559,17 @@ int do_read_index(struct index_state *istate, c=
onst char *path, int must_exist)
 	mmap =3D xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, =
fd, 0);
 	if (mmap =3D=3D MAP_FAILED)
 		die_errno("unable to map index file");
-	if (istate->keep_mmap) {
-		istate->mmap =3D mmap;
-		istate->mmap_size =3D mmap_size;
-	}
 	close(fd);
=20
-	hdr =3D mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
+	istate->mmap =3D mmap;
+	istate->mmap_size =3D mmap_size;
+	if (try_shm(istate) &&
+	    verify_hdr(istate->mmap, istate->mmap_size) < 0)
 		goto unmap;
+	hdr =3D mmap =3D istate->mmap;
+	mmap_size =3D istate->mmap_size;
+	if (!istate->keep_mmap)
+		istate->mmap =3D NULL;
=20
 	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
 	istate->version =3D ntohl(hdr->hdr_version);
@@ -2054,9 +2117,13 @@ static int do_write_locked_index(struct index_st=
ate *istate, struct lock_file *l
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=3D
 	       (COMMIT_LOCK | CLOSE_LOCK));
-	if (flags & COMMIT_LOCK)
-		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
+	if (flags & COMMIT_LOCK) {
+		struct stat st;
+		ret =3D commit_locked_index(lock);
+		if (!ret && !stat(git_path("index-helper.pid"), &st))
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
2.1.0.rc0.66.gb9187ad
