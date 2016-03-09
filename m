From: David Turner <dturner@twopensource.com>
Subject: [PATCH 04/19] index-helper: new daemon for caching index and related stuff
Date: Wed,  9 Mar 2016 13:36:07 -0500
Message-ID: <1457548582-28302-5-git-send-email-dturner@twopensource.com>
References: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Mar 09 19:37:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adiye-0007Hh-65
	for gcvg-git-2@plane.gmane.org; Wed, 09 Mar 2016 19:36:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933849AbcCISgu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Mar 2016 13:36:50 -0500
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35520 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933793AbcCISgi (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 13:36:38 -0500
Received: by mail-qg0-f50.google.com with SMTP id y89so49334002qge.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 10:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=Adi7q7AsvCRJhtaHlGrWEIpooRFfSkTVibKCy8XK4fo=;
        b=LMhpY3ZDa1cq+Rxr+xOwSwFroyaoOprRjkUIWWcUfu40Av7BayAkPacHelR8GuwcqA
         rC9PwD1H+79Fe8CKlc6pJpw/BGhZE19bCWWNrrYd/QG+QGve1yfcBULLbkrGICl1iiIk
         jQ9mZ0dbq8gbp8ghqPDr8E2Zzi1ANACBlO9gGWvK2EqGq1mHC5t/oSu4TOordUvnJt9k
         kzuqkk0X3DfAr8Lb3H+kUWwwmEnAlR4L6Jclm0AYbopdJJdTVYwx9n/TvpkoNuZQcO39
         LG74BouDiKBaUs5HOGC1uiIIphjxi4Z5vEEMFfbGh33CpRWyRxK0Jc7J3mY+Qa2kwRE+
         rmEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Adi7q7AsvCRJhtaHlGrWEIpooRFfSkTVibKCy8XK4fo=;
        b=Rq44+AAVYgnN8zSMN8SB40roE5dkiQJiLJeRy/LVU6lBF06Pwpx9XcuMnwI/EkUU4g
         npXv+XF/rGqarWDTCzRkieuFCBRJc3vrpYO6TZfTgdvtuDvDyMlm3mA7kUIErld2sppd
         pC1+GianEci+XjeXRn4X9ToKfIaWBcUMxErFqGWqeSP/+bfxc7d2nJrNszVQtw0WRKuR
         3/1xMhRyJe5F3AtCLAS6ojSKqXyWyMYWn+umPmkTRNdgFLI6sD/lL+8bXo/japFVXJiH
         9AXpthxmeDa4oyTUhPtNcSrV3v2hobroI5gnQY4htG7iFevpK/sOndGirOCdJfdCOJF+
         XeXg==
X-Gm-Message-State: AD7BkJLges9d5JDX7wN3HqGVqQhrEXRW1W+YXgTWQFonAakfKfVLe5FbjzlVry+o/yP49Q==
X-Received: by 10.140.20.39 with SMTP id 36mr44733737qgi.15.1457548596897;
        Wed, 09 Mar 2016 10:36:36 -0800 (PST)
Received: from ubuntu.twitter.biz ([192.133.79.128])
        by smtp.gmail.com with ESMTPSA id r6sm4166929qhb.49.2016.03.09.10.36.35
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 09 Mar 2016 10:36:36 -0800 (PST)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1457548582-28302-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288553>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

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
 .gitignore                         |   1 +
 Documentation/git-index-helper.txt |  44 ++++++++++
 Makefile                           |   9 +++
 cache.h                            |   3 +
 config.mak.uname                   |   1 +
 git-compat-util.h                  |   1 +
 index-helper.c                     | 162 +++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       | 106 +++++++++++++++++++++---
 shm.c                              |  67 +++++++++++++++
 shm.h                              |  23 ++++++
 10 files changed, 408 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h

diff --git a/.gitignore b/.gitignore
index 5087ce1..b92f122 100644
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
index 24bef8d..a6c668b 100644
--- a/Makefile
+++ b/Makefile
@@ -367,6 +367,8 @@ all::
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl =
function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
+#
+# Define HAVE_SHM if you platform support shm_* functions in librt.
=20
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -802,6 +804,7 @@ LIB_OBJS +=3D sha1-lookup.o
 LIB_OBJS +=3D sha1_file.o
 LIB_OBJS +=3D sha1_name.o
 LIB_OBJS +=3D shallow.o
+LIB_OBJS +=3D shm.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D split-index.o
@@ -1430,6 +1433,12 @@ ifdef HAVE_DEV_TTY
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
index c43ef3d..bc2f529 100644
--- a/cache.h
+++ b/cache.h
@@ -334,6 +334,8 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 keep_mmap : 1,
+		 from_shm : 1,
+		 to_shm : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
@@ -560,6 +562,7 @@ extern int is_index_unborn(struct index_state *);
 extern int read_index_unmerged(struct index_state *);
 #define COMMIT_LOCK		(1 << 0)
 #define CLOSE_LOCK		(1 << 1)
+#define REFRESH_DAEMON		(1 << 2)
 extern int write_locked_index(struct index_state *, struct lock_file *=
lock, unsigned flags);
 extern int discard_index(struct index_state *);
 extern int unmerged_index(const struct index_state *);
diff --git a/config.mak.uname b/config.mak.uname
index 4c68e07..b5108e1 100644
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
index c07e0c1..56945a7 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -513,6 +513,7 @@ static inline int ends_with(const char *str, const =
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
index 7e387e9..eb4b9b4 100644
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
@@ -1541,6 +1542,81 @@ static void post_read_index_from(struct index_st=
ate *istate)
 	tweak_untracked_cache(istate);
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
+	ssize_t new_size;
+	const unsigned char *sha1;
+	struct stat st;
+
+	if (!is_main_index(istate) ||
+	    old_size <=3D 20 ||
+	    stat(git_path("index-helper.pid"), &st))
+		return -1;
+	poke_daemon(istate, &st, 0);
+	sha1 =3D (unsigned char *)istate->mmap + old_size - 20;
+	new_size =3D git_shm_map(O_RDONLY, 0700, -1, &new_mmap,
+				 PROT_READ, MAP_SHARED,
+				 "git-index-%s", sha1_to_hex(sha1));
+	if (new_size <=3D 20 ||
+	    hashcmp((unsigned char *)istate->mmap + old_size - 20,
+		    (unsigned char *)new_mmap + new_size - 20)) {
+		if (new_mmap)
+			munmap(new_mmap, new_size);
+		poke_daemon(istate, &st, 1);
+		return -1;
+	}
+	munmap(istate->mmap, istate->mmap_size);
+	istate->mmap =3D new_mmap;
+	istate->mmap_size =3D new_size;
+	istate->from_shm =3D 1;
+	return 0;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1555,6 +1631,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	istate->from_shm =3D 0;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
@@ -1574,15 +1651,17 @@ int do_read_index(struct index_state *istate, c=
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
@@ -1662,6 +1741,8 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
 	split_index->base->keep_mmap =3D istate->keep_mmap;
+	split_index->base->to_shm    =3D istate->to_shm;
+	split_index->base->from_shm  =3D istate->from_shm;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1712,6 +1793,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
+	istate->from_shm =3D 0;
+	istate->to_shm   =3D 0;
 	return 0;
 }
=20
@@ -2138,9 +2221,14 @@ static int do_write_locked_index(struct index_st=
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
2.4.2.767.g62658d5-twtrsrc
