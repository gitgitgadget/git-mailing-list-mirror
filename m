From: David Turner <dturner@twopensource.com>
Subject: [PATCH v3 03/16] index-helper: new daemon for caching index and related stuff
Date: Wed,  6 Apr 2016 18:11:49 -0400
Message-ID: <1459980722-4836-4-git-send-email-dturner@twopensource.com>
References: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com, aevarb@gmail.com,
	jeffhost@microsoft.com
X-From: git-owner@vger.kernel.org Thu Apr 07 00:12:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anvgz-0004mU-4E
	for gcvg-git-2@plane.gmane.org; Thu, 07 Apr 2016 00:12:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754167AbcDFWMp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Apr 2016 18:12:45 -0400
Received: from mail-qg0-f52.google.com ([209.85.192.52]:33459 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbcDFWMj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 18:12:39 -0400
Received: by mail-qg0-f52.google.com with SMTP id j35so48392480qge.0
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 15:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iRuQGUi3kd/kJJuH87x9bVJREVuTXIAPF2RWgc7vQn8=;
        b=TPjBz/KcZIrLup6XlFoNRw4cw7pXbn3+L9e5BA/zZVJdwdxNqmnbMnZC7mcKmlyiIC
         g3Y5Qgn+EQLUvVf6YS9TxlQWn9SNb5Wh7DPH0ior+zJjzqiiGm5hxKVsnjODvPjLG3KB
         naJMlgPQbSJkFJ4YwtEqc1O2DfknSzBoTTnXvpAa5zDVYxxxxlftvALsArGJnyhKmI+t
         HBImDhCPqlYPdkVtU7YalBIOUpZskOsDIPECz0319ODo0RKmRMX/e7TKQO7dpGdunG4h
         2b+mMJVQItNiAN3QWavGvOnAPup5QcjNp2HEEy2tLPXO+dJgjo6vVsv1rpd2O3IZTxS3
         v60w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iRuQGUi3kd/kJJuH87x9bVJREVuTXIAPF2RWgc7vQn8=;
        b=DlrCLSefdwiQA5ymgpEBhfr75qIwyHFFO/jHUE+7RY69ODNY+yZPHnbxP78oDDuu72
         s0TDdanfiq2BVaNdxVmraJK9D+94AT2plxOsNsKYExwWWkxFucdIK0D6I8YVy4b+vDDH
         fWKOXXwWmTqI5TNCLD8Pp5KfywSAmXV0+qjVrmzsNnKMuykMBU6QTUyZ6g9Af6XI+VoD
         uwisi7thR5u+C4ym7anruZvjMKHqDBcyQN/aGxVPb7EhiCikGCxXSXUUBflz1Q9LU62D
         /ZBI85wCmrmwK1jwdLqzjsYY6Mvevig+PoDz8kTapgnj5yHBpuwiG9ysqIGEQ/U24h7Y
         HToQ==
X-Gm-Message-State: AD7BkJJZEW/6ssJ9+paKJCuwhcFIzzeUqwP5YW+oXOduGJO3i1fLfEMYu5NxxxoE8wRvVg==
X-Received: by 10.140.178.133 with SMTP id y127mr1953449qhy.100.1459980758792;
        Wed, 06 Apr 2016 15:12:38 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id l33sm2165241qge.11.2016.04.06.15.12.37
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 06 Apr 2016 15:12:37 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1459980722-4836-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290875>

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

Git can poke the daemon via unix domain sockets to tell it to refresh
the index cache, or to keep it alive some more minutes. It can't give
any real index data directly to the daemon. Real data goes to disk
first, then the daemon reads and verifies it from there. Poking only
happens for $GIT_DIR/index, not temporary index files.

$GIT_DIR/index-helper.path is a symlink to the socket for the daemon
process. The daemon reads from the socket and executes commands.

Named pipes were considered for portability reasons, but then commands
that need replies from the daemon would have open their own pipes,
since a named pipe should only have one reader.  Unix domain sockets
don't have this problem.

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

[1] http://thread.gmane.org/gmane.comp.version-control.git/247268/focus=
=3D248771

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 .gitignore                         |   1 +
 Documentation/git-index-helper.txt |  46 ++++++
 Makefile                           |  10 ++
 cache.h                            |   2 +
 config.mak.uname                   |   1 +
 git-compat-util.h                  |  18 +++
 index-helper.c                     | 284 +++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       | 116 +++++++++++++--
 shm.c                              |  67 +++++++++
 shm.h                              |  23 +++
 t/t7900-index-helper.sh            |  23 +++
 11 files changed, 582 insertions(+), 9 deletions(-)
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
index 0000000..61605e9
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
+	seconds. Specify 0 to wait forever. Default is 600.
+
+NOTES
+-----
+$GIT_DIR/index-helper.path is a symlink to a Unix domain socket in
+$TMPDIR that the daemon reads commands from. At least on Linux, shared
+memory objects are available via /dev/shm with the name pattern
+"git-<something>-<SHA1>".  Normally the daemon will clean up shared
+memory objects when it exits.  But if it crashes, some objects could
+remain there and they can be safely deleted with "rm" command. The
+following commands are used to control the daemon:
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
index 2742a69..24d6c0e 100644
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
@@ -2159,6 +2168,7 @@ GIT-BUILD-OPTIONS: FORCE
 	@echo NO_PERL=3D\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@=
+
 	@echo NO_PYTHON=3D\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' =
>>$@+
 	@echo NO_UNIX_SOCKETS=3D\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SO=
CKETS)))'\' >>$@+
+	@echo HAVE_SHM=3D\''$(subst ','\'',$(subst ','\'',$(HAVE_SHM)))'\' >>=
$@+
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
index c07e0c1..8b878fe 100644
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
@@ -1045,4 +1046,21 @@ struct tm *git_gmtime_r(const time_t *, struct t=
m *);
 #define getc_unlocked(fh) getc(fh)
 #endif
=20
+#ifdef __linux__
+#define UNIX_PATH_MAX 108
+#elif defined(__APPLE__) || defined(BSD)
+#define UNIX_PATH_MAX 104
+#else
+/*
+ * Quoth POSIX: The size of sun_path has intentionally been left
+ * undefined. This is because different implementations use different
+ * sizes. For example, 4.3 BSD uses a size of 108, and 4.4 BSD uses a
+ * size of 104. Since most implementations originate from BSD
+ * versions, the size is typically in the range 92 to 108.
+ *
+ * Thanks, POSIX!  Super-helpful!  Hope we don't overflow any buffers!
+ */
+#define UNIX_PATH_MAX 92
+#endif
+
 #endif
diff --git a/index-helper.c b/index-helper.c
new file mode 100644
index 0000000..263b066
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,284 @@
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
+	unlink(git_path("index-helper.path"));
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
+static void refresh(void)
+{
+	the_index.keep_mmap =3D 1;
+	the_index.to_shm    =3D 1;
+	if (read_cache() < 0)
+		die(_("could not read index"));
+	share_the_index();
+}
+
+static void set_socket_nonblocking(int fd)
+{
+	int flags;
+
+	flags =3D fcntl(fd, F_GETFL, NULL);
+
+	if (flags < 0)
+		die(_("fcntl failed"));
+
+	if (fcntl(fd, F_SETFL, flags | O_NONBLOCK) < 0)
+		die(_("fcntl failed"));
+}
+
+#ifdef HAVE_SHM
+
+static void loop(int fd, int idle_in_seconds)
+{
+	struct timeval timeout;
+	struct timeval *timeout_p;
+
+	while (1) {
+		fd_set readfds;
+		int result, client_fd;
+		struct strbuf command =3D STRBUF_INIT;
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
+		if (result < 0)
+			die_errno(_("select() failed"));
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
+		if (strbuf_getwholeline_fd(&command, client_fd, '\0') =3D=3D 0) {
+			if (!strcmp(command.buf, "refresh")) {
+				refresh();
+			} else if (!strcmp(command.buf, "poke")) {
+				/*
+				 * Just a poke to keep us
+				 * alive, nothing to do.
+				 */
+			} else {
+				warning("BUG: Bogus command %s", command.buf);
+			}
+		} else {
+			/*
+			 * No command from client.  Probably it's just
+			 * a liveness check.  Just close up.
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
+static int setup_socket(const char *socket_path)
+{
+	struct sockaddr_un address =3D {0};
+	int fd;
+	int len;
+
+	len =3D strlen(socket_path);
+	if (len > UNIX_PATH_MAX - 1)
+		die("path %s is too long for a socket", socket_path);
+
+	fd =3D socket(PF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		return -1;
+
+	address.sun_family =3D AF_UNIX;
+	strncpy(address.sun_path, socket_path, UNIX_PATH_MAX);
+
+	if (bind(fd, (struct sockaddr *) &address, sizeof(address)))
+		die_errno(_("failed to bind to socket %s"), socket_path);
+
+	set_socket_nonblocking(fd);
+
+	if (listen(fd, 3))
+		die_errno(_("failed to listen on socket %s"), socket_path);
+
+	return fd;
+}
+
+static const char * const usage_text[] =3D {
+	N_("git index-helper [options]"),
+	NULL
+};
+
+static void make_socket_path(struct strbuf *path)
+{
+	const char *tmpdir;
+
+	tmpdir =3D getenv("TMPDIR");
+	if (!tmpdir)
+		tmpdir =3D "/tmp";
+
+	/*
+	 * We need to make a dir that we can own, so that users other
+	 * than us cannot poke the daemon, and so that, if the daemon
+	 * dies, no other process can recreate the socket and trick us
+	 * into talking to an imposter.
+	 */
+	strbuf_addf(path, "%s/XXXXXX", tmpdir);
+	if (!mkdtemp(path->buf))
+		die(("failed to make temp dir for socket"));
+
+	/*
+	 * Use a stupid filename because we want to minimize the path
+	 * length since socket filenames must be short.
+	 */
+	strbuf_addstr(path, "/s");
+}
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
+	make_socket_path(&socket_path);
+	fd =3D setup_socket(socket_path.buf);
+	if (fd < 0)
+		die_errno(_("could not set up index-helper socket"));
+	/*
+	 * Now that the socket is set up, we symlink it into
+	 * GIT_DIR so clients can find it.
+	 */
+	if (unlink(git_path("index-helper.path")) && errno !=3D ENOENT)
+		die(_("failed to delete old index-helper.path"));
+	if (symlink(socket_path.buf, git_path("index-helper.path")))
+		die(_("failed to symlink socket path into index-helper.path"));
+	loop(fd, idle_in_seconds);
+
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index 7e387e9..66f2874 100644
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
@@ -1541,6 +1542,91 @@ static void post_read_index_from(struct index_st=
ate *istate)
 	tweak_untracked_cache(istate);
 }
=20
+static int poke_daemon(struct index_state *istate,
+		       const struct stat *st, int refresh_cache)
+{
+	int fd;
+	int ret =3D 0;
+	struct sockaddr_un address =3D {0};
+
+	/* if this is from index-helper, do not poke itself (recursively) */
+	if (istate->to_shm)
+		return 0;
+
+	if (readlink(git_path("index-helper.path"), address.sun_path,
+		     UNIX_PATH_MAX) < 0)
+		return -1;
+
+	fd =3D socket(PF_UNIX, SOCK_STREAM, 0);
+	if (fd < 0)
+		return -1;
+
+	address.sun_family =3D AF_UNIX;
+	if (connect(fd, (struct sockaddr *) &address, sizeof(address))) {
+		warning("Failed to connect to socket %s", address.sun_path);
+		close(fd);
+		return -1;
+	}
+
+	if (refresh_cache) {
+		ret =3D write_in_full(fd, "refresh", 8) !=3D 8;
+	} else {
+		ret =3D write_in_full(fd, "poke", 5) !=3D 5;
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
+	    stat(git_path("index-helper.path"), &st))
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
+
+	/* The memory barrier here matches index-helper.c:share_index. */
+	__sync_synchronize();
+
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
@@ -1555,6 +1641,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	istate->from_shm =3D 0;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
@@ -1574,15 +1661,17 @@ int do_read_index(struct index_state *istate, c=
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
@@ -1662,6 +1751,8 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
 	split_index->base->keep_mmap =3D istate->keep_mmap;
+	split_index->base->to_shm    =3D istate->to_shm;
+	split_index->base->from_shm  =3D istate->from_shm;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1712,6 +1803,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
+	istate->from_shm =3D 0;
+	istate->to_shm   =3D 0;
 	return 0;
 }
=20
@@ -2138,9 +2231,14 @@ static int do_write_locked_index(struct index_st=
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
+		    !stat(git_path("index-helper.path"), &st))
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
index 0000000..6a06094
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
+test -z "$HAVE_SHM" && {
+	skip_all=3D'skipping index-helper tests: no SHM'
+	test_done
+}
+
+test_expect_success 'index-helper smoke test' '
+	git index-helper --exit-after 1 &&
+	test_path_is_missing .git/index-helper.path
+'
+
+test_done
--=20
2.4.2.767.g62658d5-twtrsrc
