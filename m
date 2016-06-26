Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.9 required=3.0 tests=AWL,BAYES_20,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBF201F744
	for <e@80x24.org>; Sun, 26 Jun 2016 04:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751793AbcFZEOj (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 00:14:39 -0400
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:38885 "EHLO
	homiemail-a17.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751682AbcFZEOg convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 00:14:36 -0400
Received: from homiemail-a17.g.dreamhost.com (localhost [127.0.0.1])
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTP id 657172B206A;
	Sat, 25 Jun 2016 21:14:36 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=from:to:cc
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-type:content-transfer-encoding; s=novalis.org; bh=hr5Q9
	V3jRIthpoxlyuUOQMlc69c=; b=USS0DBjdn2r3gByjo7JyGy+GqEfRTEMpYbBdH
	d7BR9/y9Z+n4K0W2rrk/gSEOcf6yuIB/2KWic1l6g4jJ61sZf/jOb+ylRmCO9Nqe
	Kgm5HCiQMGswV+cfnQ1P6gBFpSSR0kPWA+7dvB/dxt5OkzShIxDS62qRj9fiGhSh
	tTNdFY=
Received: from frank.cable.rcn.com (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com [207.38.164.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: novalis@novalis.org)
	by homiemail-a17.g.dreamhost.com (Postfix) with ESMTPSA id 8D1992B205C;
	Sat, 25 Jun 2016 21:14:35 -0700 (PDT)
From:	David Turner <novalis@novalis.org>
To:	git@vger.kernel.org, pclouds@gmail.com, kamggg@gmail.com
Cc:	David Turner <dturner@twopensource.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v13 04/20] index-helper: new daemon for caching index and related stuff
Date:	Sun, 26 Jun 2016 00:14:08 -0400
Message-Id: <1466914464-10358-4-git-send-email-novalis@novalis.org>
X-Mailer: git-send-email 2.8.0.rc4.20.g1d4f562
In-Reply-To: <1466914464-10358-1-git-send-email-novalis@novalis.org>
References: <1466914464-10358-1-git-send-email-novalis@novalis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

Instead of reading the index from disk and worrying about disk
corruption, the index is cached in memory (memory bit-flips happen
too, but hopefully less often). The result is faster read. Read time
is reduced by 70%.

The biggest gain is not having to verify the trailing SHA-1, which
takes lots of time especially on large index files. But this also
opens doors for further optimizations:

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

We also add some bits to the index (to_shm and from_shm) to track
when an index came from shared memory or is going to shared memory.

We keep this daemon's logic as thin as possible. The "brain" stays in
git. So the daemon can read and validate stuff, but that's all it's
allowed to do. It does not add/create new information. It doesn't even
accept direct updates from git.

Git can poke the daemon via unix domain sockets to tell it to refresh
the index cache, or to keep it alive some more minutes. It can't give
any real index data directly to the daemon. Real data goes to disk
first, then the daemon reads and verifies it from there. The daemon
only handles $GIT_DIR/index, not temporary index files; it only gets
poked for the former.

$GIT_DIR/index-helper.sock is the socket for the daemon process. The
daemon reads from the socket and executes commands.

Named pipes were considered for portability reasons, but then commands
that need replies from the daemon would have to open their own pipes,
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

[1] http://thread.gmane.org/gmane.comp.version-control.git/247268/focus=248771

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 .gitignore                             |   1 +
 Documentation/git-index-helper.txt     |  50 ++++++
 Makefile                               |   7 +
 cache.h                                |  11 ++
 command-list.txt                       |   1 +
 contrib/completion/git-completion.bash |   1 +
 git-compat-util.h                      |   1 +
 index-helper.c                         | 292 +++++++++++++++++++++++++++++++++
 read-cache.c                           | 123 +++++++++++++-
 t/t7900-index-helper.sh                |  23 +++
 10 files changed, 501 insertions(+), 9 deletions(-)
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
diff --git a/Documentation/git-index-helper.txt b/Documentation/git-index-helper.txt
new file mode 100644
index 0000000..fa6e347
--- /dev/null
+++ b/Documentation/git-index-helper.txt
@@ -0,0 +1,50 @@
+git-index-helper(1)
+===================
+
+NAME
+----
+git-index-helper - A simple cache daemon for speeding up index file access
+
+SYNOPSIS
+--------
+[verse]
+'git index-helper' [options]
+
+DESCRIPTION
+-----------
+Keep the index file in memory for faster access. This daemon is per
+repository and per working tree.  So if you have two working trees
+each with a submodule, you might need four index-helpers.  (In practice,
+this is only worthwhile for large indexes, so only use it if you notice
+that git status is slow).
+
+OPTIONS
+-------
+
+--exit-after=<n>::
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
+	daemon alive longer, unless `--exit-after=0` is used.
+
+All commands and replies are in pkt-line format.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 2742a69..2b2ac05 100644
--- a/Makefile
+++ b/Makefile
@@ -1433,6 +1433,12 @@ ifdef HAVE_DEV_TTY
 	BASIC_CFLAGS += -DHAVE_DEV_TTY
 endif
 
+ifndef NO_MMAP
+ifndef NO_UNIX_SOCKETS
+	PROGRAM_OBJS += index-helper.o
+endif
+endif
+
 ifdef DIR_HAS_BSD_GROUP_SEMANTICS
 	COMPAT_CFLAGS += -DDIR_HAS_BSD_GROUP_SEMANTICS
 endif
@@ -2159,6 +2165,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
 	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
 	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
+	@echo NO_MMAP=\''$(subst ','\'',$(subst ','\'',$(NO_MMAP)))'\' >>$@+
 ifdef TEST_OUTPUT_DIRECTORY
 	@echo TEST_OUTPUT_DIRECTORY=\''$(subst ','\'',$(subst ','\'',$(TEST_OUTPUT_DIRECTORY)))'\' >>$@+
 endif
diff --git a/cache.h b/cache.h
index 4180e2b..2d7af6f 100644
--- a/cache.h
+++ b/cache.h
@@ -334,6 +334,17 @@ struct index_state {
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
 		 keep_mmap : 1,
+
+		 /*
+		  * This index came from index-helper originally.
+		  */
+		 from_shm : 1,
+		 /*
+		  * We're moving this index to shared memory, so we
+		  * don't need to poke the daemon to request updates
+		  * on it.
+		  */
+		 to_shm : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
diff --git a/command-list.txt b/command-list.txt
index 2a94137..d9ad7d1 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -69,6 +69,7 @@ git-http-backend                        synchingrepositories
 git-http-fetch                          synchelpers
 git-http-push                           synchelpers
 git-imap-send                           foreignscminterface
+git-index-helper                        purehelpers
 git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain           init
 git-instaweb                            ancillaryinterrogators
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index e3918c8..98794d2 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -684,6 +684,7 @@ __git_list_porcelain_commands ()
 		for-each-ref)     : plumbing;;
 		hash-object)      : plumbing;;
 		http-*)           : transport;;
+		index-helper)     : plumbing;;
 		index-pack)       : plumbing;;
 		init-db)          : deprecated;;
 		local-fetch)      : plumbing;;
diff --git a/git-compat-util.h b/git-compat-util.h
index 4743954..41a0efa 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -513,6 +513,7 @@ static inline int ends_with(const char *str, const char *suffix)
 #define PROT_READ 1
 #define PROT_WRITE 2
 #define MAP_PRIVATE 1
+#define MAP_SHARED 2
 #endif
 
 #define mmap git_mmap
diff --git a/index-helper.c b/index-helper.c
new file mode 100644
index 0000000..baf5bc6
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,292 @@
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
+	is->shm = NULL;
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
+	/*
+	 * We ignore sigpipes -- that's just a client suddenly dying.
+	 */
+	if (sig == SIGPIPE)
+		return;
+	cleanup();
+	sigchain_pop(sig);
+	raise(sig);
+}
+
+static int shared_mmap_create(size_t size, void **new_mmap, const char *path)
+{
+	int fd = -1;
+	int ret = -1;
+
+	fd = open(path, O_CREAT | O_EXCL | O_RDWR, 0600);
+
+	if (fd < 0) {
+		if (errno != EEXIST)
+			goto done;
+
+		unlink(path);
+		fd = open(path, O_CREAT | O_EXCL | O_RDWR, 0600);
+	}
+
+	if (fd < 0)
+		goto done;
+
+	if (ftruncate(fd, size))
+		goto done;
+
+	*new_mmap = mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED,
+			 fd, 0);
+
+	if (*new_mmap == MAP_FAILED) {
+		*new_mmap = NULL;
+		goto done;
+	}
+	madvise(new_mmap, size, MADV_WILLNEED);
+
+	ret = 0;
+done:
+	if (fd >= 0)
+		close(fd);
+	return ret;
+}
+
+static void share_index(struct index_state *istate, struct shm *is)
+{
+	void *new_mmap;
+	if (istate->mmap_size <= 20 ||
+	    hashcmp(istate->sha1,
+		    (unsigned char *)istate->mmap + istate->mmap_size - 20) ||
+	    !hashcmp(istate->sha1, is->sha1))
+		/* Nothing to do */
+		return;
+	if (shared_mmap_create(istate->mmap_size, &new_mmap,
+			       git_path("shm-index-%s",
+					sha1_to_hex(istate->sha1))) < 0) {
+		die("Failed to create shm-index file");
+	}
+
+
+	release_index_shm(is);
+	is->size = istate->mmap_size;
+	is->shm = new_mmap;
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
+	hashcpy((unsigned char *)new_mmap + istate->mmap_size - 20, is->sha1);
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
+	flags = fcntl(fd, F_GETFL, NULL);
+
+	if (flags < 0)
+		die(_("fcntl failed"));
+
+	if (make_nonblocking)
+		flags |= O_NONBLOCK;
+	else
+		flags &= ~O_NONBLOCK;
+
+	if (fcntl(fd, F_SETFL, flags) < 0)
+		die(_("fcntl failed"));
+}
+
+static void refresh(void)
+{
+	discard_index(&the_index);
+	the_index.keep_mmap = 1;
+	the_index.to_shm    = 1;
+	if (read_cache() < 0)
+		die(_("could not read index"));
+	share_the_index();
+}
+
+#ifndef NO_MMAP
+
+static void loop(int fd, int idle_in_seconds)
+{
+	assert(idle_in_seconds < INT_MAX / 1000);
+
+	if (idle_in_seconds == 0)
+		idle_in_seconds = -1;
+
+	while (1) {
+		struct pollfd pollfd;
+		int result, client_fd;
+		int flags;
+		char buf[4096];
+		int bytes_read;
+
+		/* Wait for a request */
+		pollfd.fd = fd;
+		pollfd.events = POLLIN;
+		result = poll(&pollfd, 1, idle_in_seconds * 1000);
+		if (result < 0) {
+			if (errno == EINTR)
+				/*
+				 * This can lead to an overlong keepalive,
+				 * but that is better than a premature exit.
+				 */
+				continue;
+			die_errno(_("poll() failed"));
+		} else if (result == 0)
+			/* timeout */
+			break;
+
+		client_fd = accept(fd, NULL, NULL);
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
+		flags = PACKET_READ_GENTLE_ON_EOF | PACKET_READ_CHOMP_NEWLINE;
+		bytes_read = packet_read(client_fd, NULL, NULL, buf,
+					 sizeof(buf), flags);
+
+		if (bytes_read > 0) {
+			/* ensure string termination */
+			buf[bytes_read] = 0;
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
+static const char * const usage_text[] = {
+	N_("git index-helper [options]"),
+	NULL
+};
+
+int main(int argc, char **argv)
+{
+	const char *prefix;
+	int idle_in_seconds = 600;
+	int fd;
+	struct strbuf socket_path = STRBUF_INIT;
+	struct option options[] = {
+		OPT_INTEGER(0, "exit-after", &idle_in_seconds,
+			    N_("exit if not used after some seconds")),
+		OPT_END()
+	};
+
+	git_extract_argv0_path(argv[0]);
+	git_setup_gettext();
+
+	if (argc == 2 && !strcmp(argv[1], "-h"))
+		usage_with_options(usage_text, options);
+
+	prefix = setup_git_directory();
+	if (parse_options(argc, (const char **)argv, prefix,
+			  options, usage_text, 0))
+		die(_("too many arguments"));
+
+	atexit(cleanup);
+	sigchain_push_common(cleanup_on_signal);
+
+	strbuf_git_path(&socket_path, "index-helper.sock");
+
+	fd = unix_stream_listen(socket_path.buf);
+	if (fd < 0)
+		die_errno(_("could not set up index-helper socket"));
+
+	if (idle_in_seconds >= INT_MAX / 1000)
+		die("--exit-after value must be less than %d seconds",
+		    INT_MAX / 1000);
+
+	loop(fd, idle_in_seconds);
+
+	close(fd);
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index 3cb0ec3..10d5465 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,9 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "unix-socket.h"
+#include "pkt-line.h"
+#include "sigchain.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1541,6 +1544,96 @@ static void post_read_index_from(struct index_state *istate)
 	tweak_untracked_cache(istate);
 }
 
+static int poke_daemon(struct index_state *istate,
+		       const struct stat *st, int refresh_cache)
+{
+	int fd;
+	int ret = 0;
+	const char *socket_path;
+
+	/* if this is from index-helper, do not poke itself (recursively) */
+	if (istate->to_shm)
+		return 0;
+
+	socket_path = git_path("index-helper.sock");
+
+	fd = unix_stream_connect(socket_path);
+	sigchain_push(SIGPIPE, SIG_IGN);
+	if (refresh_cache) {
+		packet_write_gently(fd, "refresh");
+	} else {
+		packet_write_gently(fd, "poke");
+	}
+	packet_flush_gently(fd);
+
+	close(fd);
+	sigchain_pop(SIGPIPE);
+	return ret;
+}
+
+static int is_main_index(struct index_state *istate)
+{
+	return istate == &the_index ||
+		(the_index.split_index &&
+		 istate == the_index.split_index->base);
+}
+
+/*
+ * Try to open and verify a cached shm index if available. Return 0 if
+ * succeeds (istate->mmap and istate->mmap_size are updated). Return
+ * negative otherwise.
+ */
+static int try_shm(struct index_state *istate)
+{
+	void *new_mmap = NULL;
+	size_t old_size = istate->mmap_size;
+	ssize_t new_size;
+	const unsigned char *sha1;
+	struct stat st;
+	int fd = -1;
+
+	if (!is_main_index(istate) ||
+	    old_size <= 20 ||
+	    stat(git_path("index-helper.sock"), &st))
+		return -1;
+	if (poke_daemon(istate, &st, 0))
+		return -1;
+	sha1 = (unsigned char *)istate->mmap + old_size - 20;
+
+	fd = open(git_path("shm-index-%s", sha1_to_hex(sha1)), O_RDONLY);
+	if (fd < 0)
+		goto fail;
+
+	if (fstat(fd, &st))
+		goto fail;
+
+	new_size = st.st_size;
+	new_mmap = mmap(NULL, new_size, PROT_READ, MAP_SHARED, fd, 0);
+	if (new_size <= 20 ||
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
+	istate->mmap = new_mmap;
+	istate->mmap_size = new_size;
+	istate->from_shm = 1;
+	close(fd);
+	return 0;
+
+fail:
+	if (fd >= 0)
+		close(fd);
+	poke_daemon(istate, &st, 1);
+	return -1;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -1555,6 +1648,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	if (istate->initialized)
 		return istate->cache_nr;
 
+	istate->from_shm = 0;
 	istate->timestamp.sec = 0;
 	istate->timestamp.nsec = 0;
 	fd = open(path, O_RDONLY);
@@ -1574,15 +1668,17 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	if (mmap == MAP_FAILED)
 		die_errno("unable to map index file");
-	if (istate->keep_mmap) {
-		istate->mmap = mmap;
-		istate->mmap_size = mmap_size;
-	}
 	close(fd);
 
-	hdr = mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
+	istate->mmap = mmap;
+	istate->mmap_size = mmap_size;
+	if (try_shm(istate) &&
+	    verify_hdr(istate->mmap, istate->mmap_size) < 0)
 		goto unmap;
+	hdr = mmap = istate->mmap;
+	mmap_size = istate->mmap_size;
+	if (!istate->keep_mmap)
+		istate->mmap = NULL;
 
 	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
 	istate->version = ntohl(hdr->hdr_version);
@@ -1662,6 +1758,8 @@ int read_index_from(struct index_state *istate, const char *path)
 	else
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
 	split_index->base->keep_mmap = istate->keep_mmap;
+	split_index->base->to_shm    = istate->to_shm;
+	split_index->base->from_shm  = istate->from_shm;
 	ret = do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1712,6 +1810,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked = NULL;
+	istate->from_shm = 0;
+	istate->to_shm   = 0;
 	return 0;
 }
 
@@ -2138,9 +2238,14 @@ static int do_write_locked_index(struct index_state *istate, struct lock_file *l
 		return ret;
 	assert((flags & (COMMIT_LOCK | CLOSE_LOCK)) !=
 	       (COMMIT_LOCK | CLOSE_LOCK));
-	if (flags & COMMIT_LOCK)
-		return commit_locked_index(lock);
-	else if (flags & CLOSE_LOCK)
+	if (flags & COMMIT_LOCK) {
+		struct stat st;
+		ret = commit_locked_index(lock);
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
+test_description='git-index-helper
+
+Testing git index-helper
+'
+
+. ./test-lib.sh
+
+test -n "$NO_MMAP" && {
+	skip_all='skipping index-helper tests: no mmap'
+	test_done
+}
+
+test_expect_success 'index-helper smoke test' '
+	git index-helper --exit-after 1 &&
+	test_path_is_missing .git/index-helper.sock
+'
+
+test_done
-- 
1.9.1

