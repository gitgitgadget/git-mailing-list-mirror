From: David Turner <dturner@twopensource.com>
Subject: [PATCH v6 03/19] index-helper: new daemon for caching index and related stuff
Date: Wed, 27 Apr 2016 16:04:25 -0400
Message-ID: <1461787481-877-4-git-send-email-dturner@twopensource.com>
References: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Wed Apr 27 22:05:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avViB-0003FU-BF
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 22:05:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbcD0UFR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Apr 2016 16:05:17 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:35154 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753237AbcD0UFO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 16:05:14 -0400
Received: by mail-qk0-f171.google.com with SMTP id q76so21037082qke.2
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+XNWJwkIOGE2MLNKp3gFh/XCZ5DcjK7/NGTlUsbzQ80=;
        b=eavcumGr2pfWtq3tUvt//fHiujs1L2uPncJ0nKRdeVQQo1bpyBJ+boUfJfkrkaLt0Y
         WIHndZ2SUQku0xkQt5oIMy8Zh6EjbQk3arecMt+cd4XWsEwq+MpdVtE9eRUjJSN+ad3Q
         +y2eUnzcfXMs2STSVIMn1g72o3e8dEkjhv+qVWa3ZfJPGPWTfCvCaZeQzOsvncRjcgft
         ArGR2AokFevDw3gxCe4VgvUylx/zin183ZxhkyaoBDGzywvKIqLfAWLCXyoQ/wdu9FhH
         kOmpIFNo1vCQtgvmyceHfTzqENH5LKuK+0Sg20z+Z1OoAwAuSQxqYSORt++NOlkA8jFb
         IbTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+XNWJwkIOGE2MLNKp3gFh/XCZ5DcjK7/NGTlUsbzQ80=;
        b=EDTJ4vns8Xyp+QuEraVkztQj5aecpyFwvFNpWjd+VaJSoWVTcZfsFZZhT0K/ve4qOL
         kkzJSSqqafTQtM7dAwCeeIezYOpVs+6y618h8zGADJlaMLGiBj0VFwy7leT/YAK6V1iG
         RstbiQ2VDdrFaklrhGb1EQDsp28dTfq7Qk5AxQ5+3NRXEv1tC95v/LBB3qCypPBsP/n1
         i9fyZKLMD46TcRcDAImNbV0i5rTg4kPk3lNe5yk9bxWrp2tWhsDQqJk7L2atGX5Gg3IZ
         pjeiRhE0BJH92vaGQ1pBIGV9WSpuUI06rbeXkVDhPbSYzTgoDzzc7DTyqYnqxb3iZxmI
         grLw==
X-Gm-Message-State: AOPr4FWbA+Xhc14WMVs05bvtDD+dPW3Ryzqr3eMEQ/shsTlaRtOZFQQVX47tJgSHj6UrPA==
X-Received: by 10.55.33.167 with SMTP id f39mr10802554qki.132.1461787512865;
        Wed, 27 Apr 2016 13:05:12 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id r124sm1700085qhr.48.2016.04.27.13.05.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 27 Apr 2016 13:05:11 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461787481-877-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292791>

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

Shared memory is done by storing files in a per-repository temporary
directory.  This is more portable than shm (which requires
posix-realtime and has various quirks on OS X).  It might even work on
Windows, although this has not been tested. The shared memory file's
name follows the template "shm-<object>-<SHA1>" where <SHA1> is the
trailing SHA-1 of the index file. <object> is "index" for cached index
files (and might later be "name-hash" for name-hash cache). If such
shared memory exists, it contains the same index content as on
disk. The content is already validated by the daemon and git won't
validate it again (except comparing the trailing SHA-1s).

We keep this daemon's logic as thin as possible. The "brain" stays in
git. So the daemon can read and validate stuff, but that's all it's
allowed to do. It does not add/create new information. It doesn't even
accept direct updates from git.

Git can poke the daemon via unix domain sockets to tell it to refresh
the index cache, or to keep it alive some more minutes. It can't give
any real index data directly to the daemon. Real data goes to disk
first, then the daemon reads and verifies it from there. Poking only
happens for $GIT_DIR/index, not temporary index files.

$GIT_DIR/index-helper.sock is the socket for the daemon process. The
daemon reads from the socket and executes commands.

Named pipes were considered for portability reasons, but then commands
that need replies from the daemon would have open their own pipes,
since a named pipe should only have one reader.  Unix domain sockets
don't have this problem.

On webkit.git with index format v2, duplicating 8 times to 1.5m
entries and 236MB in size:

(vanilla)      0.50 s: read_index_from .git/index
(index-helper) 0.18 s: read_index_from .git/index

Interestingly with index v4, we get less out of index-helper. It makes
sense as v4 requires more processing after loading the index:

(vanilla)      0.37 s: read_index_from .git/index
(index-helper) 0.22 s: read_index_from .git/index

[1] http://thread.gmane.org/gmane.comp.version-control.git/247268/focus=
=3D248771

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 .gitignore                         |   1 +
 Documentation/git-index-helper.txt |  47 ++++++
 Makefile                           |   5 +
 cache.h                            |   2 +
 git-compat-util.h                  |   1 +
 index-helper.c                     | 285 +++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       | 122 ++++++++++++++--
 t/t7900-index-helper.sh            |  23 +++
 8 files changed, 477 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/git-index-helper.txt
 create mode 100644 index-helper.c
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
index 0000000..77687c0
--- /dev/null
+++ b/Documentation/git-index-helper.txt
@@ -0,0 +1,47 @@
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
+	seconds. Specify 0 to wait forever. Default is 600.
+
+NOTES
+-----
+
+$GIT_DIR/index-helper.sock a Unix domain socket that the daemon reads
+commands from.  The directory will also contain files named
+"shm-index-<SHA1>".  These are used as backing stores for shared
+memory.  Normally the daemon will clean up these files when it exits
+or when they are no longer relevant.  But if it crashes, some objects
+could remain there and they can be safely deleted with "rm"
+command. The following commands are used to control the daemon:
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
index 2742a69..c8be0e7 100644
--- a/Makefile
+++ b/Makefile
@@ -1433,6 +1433,10 @@ ifdef HAVE_DEV_TTY
 	BASIC_CFLAGS +=3D -DHAVE_DEV_TTY
 endif
=20
+ifndef NO_MMAP
+	PROGRAM_OBJS +=3D index-helper.o
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS +=3D -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
@@ -2159,6 +2163,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=3D\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@=
+
 	@echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' =
>>$@+
 	@echo NO_UNIX_SOCKETS=3D\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SO=
CKETS)))'\' >>$@+
+	@echo NO_MMAP=3D\''$(subst ','\'',$(subst ','\'',$(NO_MMAP)))'\' >>$@=
+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=3D\''$(subst ','\'',$(subst ','\'',$(TEST=
_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/cache.h b/cache.h
index 4180e2b..43fb314 100644
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
index 0000000..976e913
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,285 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "sigchain.h"
+#include "strbuf.h"
+#include "exec_cmd.h"
+#include "split-index.h"
+#include "lockfile.h"
+#include "cache.h"
+#include "unix-socket.h"
+#include "pkt-line.h"
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
+	unlink(git_path("shm-index-%s", sha1_to_hex(is->sha1)));
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
+	unlink(git_path("index-helper.sock"));
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
+static int shared_mmap_create(int file_flags, int file_mode, size_t si=
ze,
+			      void **new_mmap, int mmap_prot, int mmap_flags,
+			      const char *path)
+{
+	int fd =3D -1;
+	int ret =3D -1;
+
+	fd =3D open(path, file_flags, file_mode);
+
+	if (fd < 0)
+		goto done;
+
+	if (ftruncate(fd, size))
+		goto done;
+
+	*new_mmap =3D mmap(NULL, size, mmap_prot, mmap_flags, fd, 0);
+
+	if (*new_mmap =3D=3D MAP_FAILED) {
+		*new_mmap =3D NULL;
+		goto done;
+	}
+	madvise(new_mmap, size, MADV_WILLNEED);
+
+	ret =3D 0;
+done:
+	if (fd > 0)
+		close(fd);
+	return ret;
+}
+
+static void share_index(struct index_state *istate, struct shm *is)
+{
+	void *new_mmap;
+	if (istate->mmap_size <=3D 20 ||
+	    hashcmp(istate->sha1,
+		    (unsigned char *)istate->mmap + istate->mmap_size - 20) ||
+	    !hashcmp(istate->sha1, is->sha1) ||
+	    shared_mmap_create(O_CREAT | O_EXCL | O_RDWR, 0700,
+			       istate->mmap_size, &new_mmap,
+			       PROT_READ | PROT_WRITE, MAP_SHARED,
+			       git_path("shm-index-%s",
+					sha1_to_hex(istate->sha1))) < 0)
+		return;
+
+	release_index_shm(is);
+	is->size =3D istate->mmap_size;
+	is->shm =3D new_mmap;
+	hashcpy(is->sha1, istate->sha1);
+
+	memcpy(new_mmap, istate->mmap, istate->mmap_size - 20);
+
+	/*
+	 * The trailing hash must be written last after everything is
+	 * written. It's the indication that the shared memory is now
+	 * ready.
+	 * The memory barrier here matches read-cache.c:try_shm.
+	 */
+	__sync_synchronize();
+
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
+static void set_socket_blocking_flag(int fd, int make_nonblocking)
+{
+	int flags;
+
+	flags =3D fcntl(fd, F_GETFL, NULL);
+
+	if (flags < 0)
+		die(_("fcntl failed"));
+
+	if (make_nonblocking)
+		flags |=3D O_NONBLOCK;
+	else
+		flags &=3D ~O_NONBLOCK;
+
+	if (fcntl(fd, F_SETFL, flags) < 0)
+		die(_("fcntl failed"));
+}
+
+static void refresh(void)
+{
+	discard_index(&the_index);
+	the_index.keep_mmap =3D 1;
+	the_index.to_shm    =3D 1;
+	if (read_cache() < 0)
+		die(_("could not read index"));
+	share_the_index();
+}
+
+#ifndef NO_MMAP
+
+static void loop(int fd, int idle_in_seconds)
+{
+	struct timeval timeout;
+	struct timeval *timeout_p;
+
+	while (1) {
+		fd_set readfds;
+		int result, client_fd;
+		int flags;
+		char buf[4096];
+		int bytes_read;
+
+		/* need to reset timer in case select() decremented it */
+		if (idle_in_seconds) {
+			timeout.tv_usec =3D 0;
+			timeout.tv_sec =3D idle_in_seconds;
+			timeout_p =3D &timeout;
+		} else {
+			timeout_p =3D NULL;
+		}
+
+		/* Wait for a request */
+		FD_ZERO(&readfds);
+		FD_SET(fd, &readfds);
+		result =3D select(fd + 1, &readfds, NULL, NULL, timeout_p);
+		if (result < 0) {
+			if (errno =3D=3D EINTR)
+				/*
+				 * This can lead to an overlong keepalive,
+				 * but that is better than a premature exit.
+				 */
+				continue;
+			die_errno(_("select() failed"));
+		}
+		if (result =3D=3D 0)
+			/* timeout */
+			break;
+
+		client_fd =3D accept(fd, NULL, NULL);
+		if (client_fd < 0)
+			/*
+			 * An error here is unlikely -- it probably
+			 * indicates that the connecting process has
+			 * already dropped the connection.
+			 */
+			continue;
+
+		/*
+		 * Our connection to the client is blocking since a client
+		 * can always be killed by SIGINT or similar.
+		 */
+		set_socket_blocking_flag(client_fd, 0);
+
+		flags =3D PACKET_READ_GENTLE_ON_EOF | PACKET_READ_CHOMP_NEWLINE;
+		bytes_read =3D packet_read(client_fd, NULL, NULL, buf,
+					 sizeof(buf), flags);
+
+		if (bytes_read > 0) {
+			/* ensure string termination */
+			buf[bytes_read] =3D 0;
+			if (!strcmp(buf, "refresh")) {
+				refresh();
+			} else if (!strcmp(buf, "poke")) {
+				/*
+				 * Just a poke to keep us
+				 * alive, nothing to do.
+				 */
+			} else {
+				warning("BUG: Bogus command %s", buf);
+			}
+		} else {
+			/*
+			 * No command from client.  Probably it's just
+			 * a liveness check or client error.  Just
+			 * close up.
+			 */
+		}
+		close(client_fd);
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
+	struct strbuf socket_path =3D STRBUF_INIT;
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
+	strbuf_git_path(&socket_path, "index-helper.sock");
+
+	fd =3D unix_stream_listen(socket_path.buf);
+	if (fd < 0)
+		die_errno(_("could not set up index-helper socket"));
+
+	loop(fd, idle_in_seconds);
+
+	close(fd);
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index 3cb0ec3..81dfb4e 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,8 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "unix-socket.h"
+#include "pkt-line.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1541,6 +1543,96 @@ static void post_read_index_from(struct index_st=
ate *istate)
 	tweak_untracked_cache(istate);
 }
=20
+static int poke_daemon(struct index_state *istate,
+		       const struct stat *st, int refresh_cache)
+{
+	int fd;
+	int ret =3D 0;
+	const char *socket_path;
+
+	/* if this is from index-helper, do not poke itself (recursively) */
+	if (istate->to_shm)
+		return 0;
+
+	socket_path =3D git_path("index-helper.sock");
+	if (!socket_path)
+		return -1;
+
+	fd =3D unix_stream_connect(socket_path);
+	if (refresh_cache) {
+		packet_write(fd, "refresh");
+	} else {
+		packet_write(fd, "poke");
+	}
+	packet_flush(fd);
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
+	int fd =3D -1;
+
+	if (!is_main_index(istate) ||
+	    old_size <=3D 20 ||
+	    stat(git_path("index-helper.sock"), &st))
+		return -1;
+	if (poke_daemon(istate, &st, 0))
+		return -1;
+	sha1 =3D (unsigned char *)istate->mmap + old_size - 20;
+
+	fd =3D open(git_path("shm-index-%s", sha1_to_hex(sha1)), O_RDONLY);
+	if (fd < 0)
+		goto fail;
+
+	if (fstat(fd, &st))
+		goto fail;
+
+	new_size =3D st.st_size;
+	new_mmap =3D mmap(NULL, new_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (new_size <=3D 20 ||
+	    hashcmp((unsigned char *)istate->mmap + old_size - 20,
+		    (unsigned char *)new_mmap + new_size - 20)) {
+		if (new_mmap)
+			munmap(new_mmap, new_size);
+		goto fail;
+	}
+
+	/* The memory barrier here matches index-helper.c:share_index. */
+	__sync_synchronize();
+
+	munmap(istate->mmap, istate->mmap_size);
+	istate->mmap =3D new_mmap;
+	istate->mmap_size =3D new_size;
+	istate->from_shm =3D 1;
+	close(fd);
+	return 0;
+
+fail:
+	if (fd >=3D 0)
+		close(fd);
+	poke_daemon(istate, &st, 1);
+	return -1;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1555,6 +1647,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	istate->from_shm =3D 0;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
@@ -1574,15 +1667,17 @@ int do_read_index(struct index_state *istate, c=
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
@@ -1662,6 +1757,8 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
 	split_index->base->keep_mmap =3D istate->keep_mmap;
+	split_index->base->to_shm    =3D istate->to_shm;
+	split_index->base->from_shm  =3D istate->from_shm;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1712,6 +1809,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
+	istate->from_shm =3D 0;
+	istate->to_shm   =3D 0;
 	return 0;
 }
=20
@@ -2138,9 +2237,14 @@ static int do_write_locked_index(struct index_st=
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
+		    !stat(git_path("index-helper.sock"), &st))
+			poke_daemon(istate, &st, 1);
+		return ret;
+	} else if (flags & CLOSE_LOCK)
 		return close_lock_file(lock);
 	else
 		return ret;
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
new file mode 100755
index 0000000..114c112
--- /dev/null
+++ b/t/t7900-index-helper.sh
@@ -0,0 +1,23 @@
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
+test -n "$NO_MMAP" && {
+	skip_all=3D'skipping index-helper tests: no mmap'
+	test_done
+}
+
+test_expect_success 'index-helper smoke test' '
+	git index-helper --exit-after 1 &&
+	test_path_is_missing .git/index-helper.sock
+'
+
+test_done
--=20
2.4.2.767.g62658d5-twtrsrc
