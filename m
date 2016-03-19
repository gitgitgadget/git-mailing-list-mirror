From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2 03/17] index-helper: new daemon for caching index and related stuff
Date: Fri, 18 Mar 2016 21:04:36 -0400
Message-ID: <1458349490-1704-4-git-send-email-dturner@twopensource.com>
References: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Mar 19 02:06:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ah5LT-0008I6-02
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 02:06:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754174AbcCSBGS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Mar 2016 21:06:18 -0400
Received: from mail-qk0-f170.google.com ([209.85.220.170]:35921 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751538AbcCSBGJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2016 21:06:09 -0400
Received: by mail-qk0-f170.google.com with SMTP id s68so56411370qkh.3
        for <git@vger.kernel.org>; Fri, 18 Mar 2016 18:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WyCu8yFjvpb49LZgjQteLpZWxZ5vXyw9v9CqRGNoE6Q=;
        b=R2wdOotbmCKEQwUjYT122dfqtoR3f9dix0418Qjb2+Xmz4EtmTptNKU8eenOUgiVxd
         02vOhxfIcPDQeqY00AE/krnwJYq/6SMx7YMUltwIcbPNct8nSmhMeDTubjCD0MypyYZA
         QjaoypMJtWeKIr5e34Gaw9hN9xv7q87sm8iQ1EBalKpkCuaXfn/qHYPmjUKiJxqPDELQ
         IXdAJD9niv4Bo5tb5q0sqCsnyKn/eLuBDR80BSs/pUdW+vtRfndW8uhODwAwtNE8JwUv
         eTQxvwv3N+hydqnmyxuWg5hvvExNKttLoe3vTLdZnWXYxE0Kfw/w0F1cVnHiUMP7dvGr
         TXCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WyCu8yFjvpb49LZgjQteLpZWxZ5vXyw9v9CqRGNoE6Q=;
        b=XvYGyoD3ngwLqQHMpE6OyGR42WRhn3hwk4scqkcVZvUjHVHE0WlflmiEWmVq9Cz0AP
         sNGOhEqD7kOrbtoc77OaPK/6trStKx63N220eGQr8JLTSxFcWXo5GWvsof8mQ28LItb2
         sITBMoQZbpK8BfLUTUPePPCJTjtAnJOTg67tt8BJT4kWYdjdyiX9qimaG9Y0xPGB0U4Q
         6RHss2oZMaIFk+eFwEmJtQYbzXQW+vrvaGGXvi3NJ9sPFHU59IFj1HMgk/FrthxB8D7R
         63rR1i8Xnky0erfm3j1fh1CPHiqUsbbM/FnM8enVjnpAMz2ry2uMb3p8gzXHLUl1d2EB
         GEsg==
X-Gm-Message-State: AD7BkJITRIEIRKKYG9TEF1R/KjnyZGO/un6xVmKBpckpi+XHcKdPQlOkta/qWj8Twa+XcA==
X-Received: by 10.55.77.216 with SMTP id a207mr25942963qkb.80.1458349568279;
        Fri, 18 Mar 2016 18:06:08 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.26])
        by smtp.gmail.com with ESMTPSA id 139sm7186154qho.2.2016.03.18.18.06.06
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 18 Mar 2016 18:06:07 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1458349490-1704-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289271>

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

We keep this daemon's logic as thin as possible. The "brain" stays in
git. So the daemon can read and validate stuff, but that's all it's
allowed to do. It does not add/create new information. It doesn't even
accept direct updates from git.

Git can poke the daemon via named pipes to tell it to refresh the
index cache, or to keep it alive some more minutes. It can't give any
real index data directly to the daemon. Real data goes to disk first,
then the daemon reads and verifies it from there. Poking only happens
for $GIT_DIR/index, not temporary index files.

$GIT_DIR/index-helper.pipe is the named pipe for daemon process. The
daemon reads from the pipe and executes commands.  Commands that need
replies from the daemon will have to open their own pipe, since a
named pipe should only have one reader.  Unix domain sockets don't
have this problem, but are less portable.

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
Signed-off-by: David Turner <dturner@twopensource.com>
---
 .gitignore                         |   1 +
 Documentation/git-index-helper.txt |  46 ++++++++
 Makefile                           |   9 ++
 cache.h                            |   3 +
 config.mak.uname                   |   1 +
 git-compat-util.h                  |   1 +
 index-helper.c                     | 215 +++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       |  99 +++++++++++++++--
 shm.c                              |  67 ++++++++++++
 shm.h                              |  23 ++++
 t/t7900-index-helper.sh            |  18 ++++
 11 files changed, 474 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
 create mode 100644 shm.c
 create mode 100644 shm.h
 create mode 100755 t/t7900-index-helper.sh

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
index 0000000..59a5abc
--- /dev/null
+++ b/Documentation/git-index-helper.txt
@@ -0,0 +1,46 @@
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
+$GIT_DIR/index-helper.pipe is a named pipe that the daemon reads
+commands from. At least on Linux, shared memory objects are availble
+via /dev/shm with the name pattern "git-<something>-<SHA1>".  Normally
+the daemon will clean up shared memory objects when it exits.  But if
+it crashes, some objects could remain there and they can be safely
+deleted with "rm" command. The following commands are used to control
+the daemon:
+
+"refresh"::
+	Reread the index.
+
+"poke":
+	Let the daemon know the index is to be read. It keeps the
+	daemon alive longer, unless `--exit-after=3D0` is used.
+
+All commands and replies are terminated by a 0 byte.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 2742a69..2d72771 100644
--- a/Makefile
+++ b/Makefile
@@ -370,6 +370,8 @@ all::
 # Define HAVE_BSD_SYSCTL if your platform has a BSD-compatible sysctl =
function.
 #
 # Define HAVE_GETDELIM if your system has the getdelim() function.
+#
+# Define HAVE_SHM if you platform support shm_* functions in librt.
=20
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
@@ -805,6 +807,7 @@ LIB_OBJS +=3D sha1-lookup.o
 LIB_OBJS +=3D sha1_file.o
 LIB_OBJS +=3D sha1_name.o
 LIB_OBJS +=3D shallow.o
+LIB_OBJS +=3D shm.o
 LIB_OBJS +=3D sideband.o
 LIB_OBJS +=3D sigchain.o
 LIB_OBJS +=3D split-index.o
@@ -1433,6 +1436,12 @@ ifdef HAVE_DEV_TTY
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
index 4180e2b..c3c6d85 100644
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
index 1139b44..d28d05d 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -38,6 +38,7 @@ ifeq ($(uname_S),Linux)
 	HAVE_CLOCK_MONOTONIC =3D YesPlease
 	HAVE_GETDELIM =3D YesPlease
 	SANE_TEXT_GREP=3D-a
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
index 0000000..962c973
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,215 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "sigchain.h"
+#include "strbuf.h"
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
+	unlink(git_path("index-helper.pipe"));
+	cleanup_shm();
+}
+
+static void cleanup_on_signal(int sig)
+{
+	/* We ignore sigpipes -- that's just a client being broken. */
+	if (sig =3D=3D SIGPIPE)
+		return;
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
+static void refresh(void)
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
+static void loop(int fd, int idle_in_seconds)
+{
+	struct timeval timeout;
+	struct timeval *timeout_p;
+
+	if (idle_in_seconds) {
+		timeout.tv_usec =3D 0;
+		timeout.tv_sec =3D idle_in_seconds;
+		timeout_p =3D &timeout;
+	} else {
+		timeout_p =3D NULL;
+	}
+
+	while (1) {
+		fd_set readfds;
+
+		/* Wait for a request */
+		FD_ZERO(&readfds);
+		FD_SET(fd, &readfds);
+		if (select(fd + 1, &readfds, NULL, NULL, timeout_p)) {
+			/* Got one! */
+			struct strbuf command =3D STRBUF_INIT;
+			/*
+			 * We assume that after the client does a
+			 * write, we can do a full read of the data
+			 * they wrote (which will be less than
+			 * PIPE_BUF).
+			 */
+			if (strbuf_getwholeline_fd(&command, fd, '\0') =3D=3D 0) {
+				if (!strcmp(command.buf, "refresh")) {
+					refresh();
+				} else if (!strcmp(command.buf, "poke")) {
+					  /*
+					   * Just a poke to keep us
+					   * alive, nothing to do.
+					   */
+				} else {
+					warning("BUG: Bogus command %s", command.buf);
+				}
+			}
+		} else {
+			/* No request before timeout */
+			break;
+		}
+	}
+
+	close(fd);
+}
+
+#else
+
+static void loop(int fd, int idle_in_seconds)
+{
+	die(_("index-helper is not supported on this platform"));
+}
+
+#endif
+
+static int setup_pipe(const char *pipe_path)
+{
+	int fd;
+
+	if (mkfifo(pipe_path, 0600)) {
+		if (errno !=3D EEXIST)
+			die(_("failed to create pipe %s"), pipe_path);
+
+		/* Left over from a previous run, delete & retry */
+		if (unlink(pipe_path))
+			die(_("failed to delete %s"), pipe_path);
+		if (mkfifo(pipe_path, 0600))
+			die(_("failed to create pipe %s"), pipe_path);
+	}
+
+	/*
+	 * Even though we never write to this pipe, we need to open
+	 * O_RDWR to prevent select() looping on EOF.
+	 */
+	fd =3D open(pipe_path, O_RDWR | O_NONBLOCK);
+	if (fd < 0)
+		die(_("Failed to open %s"), pipe_path);
+	return fd;
+}
+
+static const char * const usage_text[] =3D {
+	N_("git index-helper [options]"),
+	NULL
+};
+
+int main(int argc, char **argv)
+{
+	const char *prefix;
+	int idle_in_seconds =3D 600;
+	int fd;
+	struct strbuf pipe_path =3D STRBUF_INIT;
+	struct option options[] =3D {
+		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
+			    N_("exit if not used after some seconds")),
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
+	atexit(cleanup);
+	sigchain_push_common(cleanup_on_signal);
+
+	strbuf_git_path(&pipe_path, "index-helper.pipe");
+	fd =3D setup_pipe(pipe_path.buf);
+	if (fd < 0)
+		die_errno("Could not set up index-helper.pipe");
+	loop(fd, idle_in_seconds);
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index 7e387e9..f5fafd6 100644
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
@@ -1541,6 +1542,74 @@ static void post_read_index_from(struct index_st=
ate *istate)
 	tweak_untracked_cache(istate);
 }
=20
+static int poke_daemon(struct index_state *istate,
+		       const struct stat *st, int refresh_cache)
+{
+	int fd;
+	int ret =3D 0;
+
+	/* if this is from index-helper, do not poke itself (recursively) */
+	if (istate->to_shm)
+		return 0;
+
+	fd =3D open(git_path("index-helper.pipe"), O_WRONLY | O_NONBLOCK);
+	if (fd < 0)
+		return -1;
+	if (refresh_cache) {
+		ret =3D write_in_full(fd, "refresh", 8) =3D=3D 8;
+	} else {
+		ret =3D write_in_full(fd, "poke", 5) =3D=3D 5;
+	}
+
+	close(fd);
+	return ret;
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
+	    stat(git_path("index-helper.pipe"), &st))
+		return -1;
+	if (poke_daemon(istate, &st, 0))
+		return -1;
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
@@ -1555,6 +1624,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	istate->from_shm =3D 0;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
@@ -1574,15 +1644,17 @@ int do_read_index(struct index_state *istate, c=
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
@@ -1662,6 +1734,8 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
 	split_index->base->keep_mmap =3D istate->keep_mmap;
+	split_index->base->to_shm    =3D istate->to_shm;
+	split_index->base->from_shm  =3D istate->from_shm;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1712,6 +1786,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
+	istate->from_shm =3D 0;
+	istate->to_shm   =3D 0;
 	return 0;
 }
=20
@@ -2138,9 +2214,14 @@ static int do_write_locked_index(struct index_st=
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
+		    !stat(git_path("index-helper.pipe"), &st))
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
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
new file mode 100755
index 0000000..7126037
--- /dev/null
+++ b/t/t7900-index-helper.sh
@@ -0,0 +1,18 @@
+#!/bin/sh
+#
+# Copyright (c) 2016, Twitter, Inc
+#
+
+test_description=3D'git-index-helper
+
+Testing git index-helper
+'
+
+. ./test-lib.sh
+
+test_expect_success 'index-helper smoke test' '
+	git index-helper --exit-after 1 &&
+	test_path_is_missing .git/index-helper.pipe
+'
+
+test_done
--=20
2.4.2.767.g62658d5-twtrsrc
