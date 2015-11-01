From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v4 4/9] index-helper: new daemon for caching index and related stuff
Date: Sun,  1 Nov 2015 14:42:44 +0100
Message-ID: <1446385369-8669-5-git-send-email-pclouds@gmail.com>
References: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Christian Couder <christian.couder@gmail.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 01 14:51:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zst2p-0006nR-8r
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 14:51:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520AbbKANvf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 1 Nov 2015 08:51:35 -0500
Received: from mail-wm0-f42.google.com ([74.125.82.42]:34249 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752189AbbKANvd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 08:51:33 -0500
X-Greylist: delayed 486 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Nov 2015 08:51:33 EST
Received: by wmff134 with SMTP id f134so40663962wmf.1
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 05:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iTpVzg5QiYrS1caJsVzrQldzpmhW+jNjtTXPHQhY9ug=;
        b=gUPpHG8jUePItBCPS0dGo20LNIiQE2HW6xiQit0W4R2K6KESjJhJIGJ8cb3/i7S7Ri
         8ivNKXzM5pFjNfFJfaEQe4gD5BCPYOj46s1Uke1N12MWBJJbdG2uHiqouQtC345t/Sg3
         xEsRWcAZ+lUtlrDiqnIE7c+YrOtGHbaZrvn4cQSlA9tuR5vMUrH8cjYsrpqwB7CKpGBx
         2RmITSvfE1ssTZEpOJGZj/S+OaVeG0GAKgUzojqv0fb2JIF+c9fPmUtvA+gjrfgFz6+Q
         mO5EJiyNdDAeDUojQYPVUd7bQp4eSToy+K/xS+7jq0WJdCgeAp89bKjFeaZ+Wevvl+Bo
         uqyQ==
X-Received: by 10.28.135.206 with SMTP id j197mr8756716wmd.14.1446385413212;
        Sun, 01 Nov 2015 05:43:33 -0800 (PST)
Received: from duynguyen-vnpc.dek-tpc.homenet.telecomitalia.it (host171-164-static.60-79-b.business.telecomitalia.it. [79.60.164.171])
        by smtp.gmail.com with ESMTPSA id gd10sm17058028wjb.47.2015.11.01.05.43.31
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 01 Nov 2015 05:43:31 -0800 (PST)
X-Mailer: git-send-email 2.2.0.513.g477eb31
In-Reply-To: <1446385369-8669-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280627>

Instead of reading the index from disk and worrying about disk
corruption, the index is cached in memory (memory bit-flips happen
too, but hopefully less often). The result is faster read. Read time
is reduced by 70%.

The biggest gain is not having to verify the trailing SHA-1, which
takes lots of time especially on large index files. But this also
opens doors for further optimiztions:

 - we could create an in-memory format that's essentially the memory
   dump of the index to eliminate most of parsing/allocation
   overhead. The mmap'd memory can be used straight away. Experiment
   [1] shows we could reduce read time by 88%.

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
then the daemon reads and verifies it from there. Poking only happens
for $GIT_DIR/index, not temporary index files.

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
 cache.h                                  |   3 +
 config.mak.uname                         |   1 +
 git-compat-util.h                        |   1 +
 index-helper.c (new)                     | 162 +++++++++++++++++++++++=
++++++++
 read-cache.c                             | 106 ++++++++++++++++++--
 shm.c (new)                              |  67 +++++++++++++
 shm.h (new)                              |  23 +++++
 10 files changed, 408 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h

diff --git a/.gitignore b/.gitignore
index 1c2f832..f36f1d3 100644
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
index 0000000..9db28cf
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
+	Let the daemon know the index is to be read. It keeps the
+	daemon alive longer, unless `--exit-after=3D0` is used.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 43ceeb9..c01cd2e 100644
--- a/Makefile
+++ b/Makefile
@@ -363,6 +363,8 @@ all::
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl =
function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
+#
+# Define HAVE_SHM if you platform support shm_* functions in librt.
=20
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -784,6 +786,7 @@ LIB_OBJS +=3D sha1-lookup.o
 LIB_OBJS +=3D sha1_file.o
 LIB_OBJS +=3D sha1_name.o
 LIB_OBJS +=3D shallow.o
+LIB_OBJS +=3D shm.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D split-index.o
@@ -1403,6 +1406,12 @@ ifdef HAVE_DEV_TTY
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
index 89e9aaf..30a3a77 100644
--- a/cache.h
+++ b/cache.h
@@ -312,6 +312,8 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 keep_mmap : 1,
+		 from_shm : 1,
+		 to_shm : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
@@ -520,6 +522,7 @@ extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
+#define REFRESH_DAEMON		(1 << 2)
 extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
diff --git a/config.mak.uname b/config.mak.uname
index f34dcaa..3167e36 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -37,6 +37,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_GETTIME =3D YesPlease
 	HAVE_CLOCK_MONOTONIC =3D YesPlease
 	HAVE_GETDELIM =3D YesPlease
+	HAVE_SHM =3D YesPlease
 endif
 ifeq ($(uname_S),GNU/kFreeBSD)
 	HAVE_ALLOCA_H =3D YesPlease
diff --git a/git-compat-util.h b/git-compat-util.h
index 8e39867..d8f6c3a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -499,6 +499,7 @@ static inline int ends_with(const char *str, const =
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
index 0000000..cf2971d
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,162 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "sigchain.h"
+#include "exec_cmd.h"
+#include "split-index.h"
+#include "shm.h"
+#include "lockfile.h"
+
+struct shm {
+	unsigned char sha1[20];
+	void *shm;
+	size_t size;
+};
+
+static struct shm shm_index;
+static struct shm shm_base_index;
+
+static void release_index_shm(struct shm *is)
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
+	release_index_shm(&shm_index);
+	release_index_shm(&shm_base_index);
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
+static void share_index(struct index_state *istate, struct shm *is)
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
+	release_index_shm(is);
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
+static void share_the_index(void)
+{
+	if (the_index.split_index && the_index.split_index->base)
+		share_index(the_index.split_index->base, &shm_base_index);
+	share_index(&the_index, &shm_index);
+	discard_index(&the_index);
+}
+
+static void refresh(int sig)
+{
+	the_index.keep_mmap =3D 1;
+	the_index.to_shm    =3D 1;
+	if (read_cache() < 0)
+		die(_("could not read index"));
+	share_the_index();
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
+	strbuf_addf(&sb, "%" PRIuMAX, (uintmax_t) getpid());
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
index 7d04108..6c98e98 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "shm.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1519,6 +1520,81 @@ static void check_ce_order(struct index_state *i=
state)
 	}
 }
=20
+static void do_poke(struct strbuf *sb, int refresh_cache)
+{
+	char	*start =3D sb->buf;
+	char	*end   =3D NULL;
+	pid_t	 pid   =3D strtoul(start, &end, 10);
+	if (!end || end !=3D sb->buf + sb->len)
+		return;
+	kill(pid, refresh_cache ? SIGHUP : SIGUSR1);
+}
+
+static void poke_daemon(struct index_state *istate,
+			const struct stat *st, int refresh_cache)
+{
+	int fd;
+	struct strbuf sb;
+
+	/* if this is from index-helper, do not poke itself (recursively) */
+	if (istate->to_shm)
+		return;
+
+	fd =3D open(git_path("index-helper.pid"), O_RDONLY);
+	if (fd < 0)
+		return;
+	strbuf_init(&sb, st->st_size + 1);
+	strbuf_setlen(&sb, st->st_size);
+	if (read_in_full(fd, sb.buf, st->st_size) =3D=3D st->st_size)
+		do_poke(&sb, refresh_cache);
+	close(fd);
+	strbuf_release(&sb);
+}
+
+static int is_main_index(struct index_state *istate)
+{
+	return istate =3D=3D &the_index ||
+		(the_index.split_index &&
+		 istate =3D=3D the_index.split_index->base);
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
+	if (!is_main_index(istate) ||
+	    old_size <=3D 20 ||
+	    stat(git_path("index-helper.pid"), &st))
+		return -1;
+	poke_daemon(istate, &st, 0);
+	sha1 =3D (unsigned char *)istate->mmap + old_size - 20;
+	new_length =3D git_shm_map(O_RDONLY, 0700, -1, &new_mmap,
+				 PROT_READ, MAP_SHARED,
+				 "git-index-%s", sha1_to_hex(sha1));
+	if (new_length <=3D 20 ||
+	    hashcmp((unsigned char *)istate->mmap + old_size - 20,
+		    (unsigned char *)new_mmap + new_length - 20)) {
+		if (new_mmap)
+			munmap(new_mmap, new_length);
+		poke_daemon(istate, &st, 1);
+		return -1;
+	}
+	munmap(istate->mmap, istate->mmap_size);
+	istate->mmap =3D new_mmap;
+	istate->mmap_size =3D new_length;
+	istate->from_shm =3D 1;
+	return 0;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1533,6 +1609,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	istate->from_shm =3D 0;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
@@ -1552,15 +1629,17 @@ int do_read_index(struct index_state *istate, c=
onst char *path, int must_exist)
 	mmap =3D xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
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
@@ -1639,6 +1718,8 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
 	split_index->base->keep_mmap =3D istate->keep_mmap;
+	split_index->base->to_shm    =3D istate->to_shm;
+	split_index->base->from_shm  =3D istate->from_shm;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1689,6 +1770,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
+	istate->from_shm =3D 0;
+	istate->to_shm   =3D 0;
 	return 0;
 }
=20
@@ -2115,9 +2198,14 @@ static int do_write_locked_index(struct index_st=
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
+		if (!ret && is_main_index(istate) &&
+		    !stat(git_path("index-helper.pid"), &st))
+			poke_daemon(istate, &st, 1);
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
2.2.0.513.g477eb31
