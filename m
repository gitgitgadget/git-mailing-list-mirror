From: David Turner <dturner@twopensource.com>
Subject: [PATCH v4 03/16] index-helper: new daemon for caching index and related stuff
Date: Tue, 12 Apr 2016 20:32:56 -0400
Message-ID: <1460507589-25525-4-git-send-email-dturner@twopensource.com>
References: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.co,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>
X-From: git-owner@vger.kernel.org Wed Apr 13 02:33:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aq8kN-0002e5-3f
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 02:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758911AbcDMAd1 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 Apr 2016 20:33:27 -0400
Received: from mail-qg0-f50.google.com ([209.85.192.50]:35776 "EHLO
	mail-qg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758903AbcDMAdZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Apr 2016 20:33:25 -0400
Received: by mail-qg0-f50.google.com with SMTP id f105so31004161qge.2
        for <git@vger.kernel.org>; Tue, 12 Apr 2016 17:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sh9rEiYztiezN+E0LuLATBjC40RyWBwUWsyHczc3sAs=;
        b=pQzuQXFEEU0SLkeu4pmikNRspapFcuLeZRBAif6k+BnRtw5AthFo85yc4QjY9wjfVV
         5cPIkK07RzmQD7V8eCJNioab7VZzsLvA8kviYA3TiEFmthYbjJF+2Y9VuwGy9Z0NNTeD
         Tuutp83LgXKx235LmnhihxFKRG5+kcxfP61R4yjcRdhTiGR44Pas3gzGlRzMoIReM+48
         ls67otZ91b1pQwILFdhLOJHb0I5KXO+xk+xqvJD8DFgCOt6ZXuwajkd/o2XhpGUb+IjL
         IZRLQIFq+cAadUVQFnSViu7U7tpG9Tv4BIoMQeBYuXBroiKYYCn6lFQPMj9SGORa9r+J
         EVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sh9rEiYztiezN+E0LuLATBjC40RyWBwUWsyHczc3sAs=;
        b=h+KqyaklAcjk8vXmKxhRzBtWMTK1RNOucMO0gZ/bcoeXax5Cqi57moSxoD8ThcG6Y0
         lBZoV5GspYB8a5lbTQIdGfcMi0R/9Ap2BogjKFjko+lG6j1Y3/jOFsYlzvihlfJwPyMZ
         9QqkyGRdJPwNkwQUSnSSsMolITjKSumqp7ldxpQjrMDuqS37f2SL8azqoEOcIY+nTfzk
         vSM+jgoBQoEaZGJmXcvX1Qb1lAXZR8y5AaP/hbsuJKGToR8RWF/4rOMoJGtplt+wnuBj
         11wztg9WE+A1qL5T/fD3HSWHBWP5I2PLlssWl5bLwLHGEU1vDd4VNT/iuF+V7HuJ2Lqz
         SrMg==
X-Gm-Message-State: AOPr4FXc4O+bq0U3oY45k8sYr5CyjeSjwEdYDoK32o0+5/lYaJpBk8rRas7RDy+TkNI/gw==
X-Received: by 10.140.91.244 with SMTP id z107mr7597532qgd.45.1460507604038;
        Tue, 12 Apr 2016 17:33:24 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id v65sm14677604qhc.6.2016.04.12.17.33.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 12 Apr 2016 17:33:22 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1460507589-25525-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291339>

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
name folows the template "git-<object>-<SHA1>" where <SHA1> is the
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

$GIT_DIR/index-helper.path is a symlink to the socket for the daemon
process. The daemon reads from the socket and executes commands.

Named pipes were considered for portability reasons, but then commands
that need replies from the daemon would have open their own pipes,
since a named pipe should only have one reader.  Unix domain sockets
don't have this problem.

On webkit.git with index format v2, duplicating 8 times to 1.4m
entries and 200MB in size:

(vanilla)      0.986986364 s: read_index_from .git/index
(index-helper) 0.267850279 s: read_index_from .git/index

Interestingly with index v4, we get less out of index-helper. It makes
sense as v4 requires more processing after loading the index:

(vanilla)      0.722496666 s: read_index_from .git/index
(index-helper) 0.302741500 s: read_index_from .git/index

(these benchmarks are from an earlier version of this patch, but should
still be valid).

[1] http://thread.gmane.org/gmane.comp.version-control.git/247268/focus=
=3D248771

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 .gitignore                         |   1 +
 Documentation/git-index-helper.txt |  48 +++++
 Makefile                           |   5 +
 cache.h                            |   2 +
 git-compat-util.h                  |  18 ++
 index-helper.c                     | 354 +++++++++++++++++++++++++++++=
++++++++
 read-cache.c                       | 172 +++++++++++++++++-
 t/t7900-index-helper.sh            |  23 +++
 8 files changed, 614 insertions(+), 9 deletions(-)
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
index 0000000..90138ec
--- /dev/null
+++ b/Documentation/git-index-helper.txt
@@ -0,0 +1,48 @@
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
+$GIT_DIR/index-helper.path is a symlink to a directory in $TMPDIR
+containing a Unix domain socket called 's' that the daemon reads
+commands from.  The directory will also contain files named
+"git-index-<SHA1>".  These are used as backing stores for shared
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
index 0000000..b52e568
--- /dev/null
+++ b/index-helper.c
@@ -0,0 +1,354 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "sigchain.h"
+#include "strbuf.h"
+#include "exec_cmd.h"
+#include "split-index.h"
+#include "lockfile.h"
+#include "cache.h"
+#include "unix-socket.h"
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
+static char *my_tmp_dir;
+
+/*
+ * We need to make a dir that we can own, so that users other
+ * than us cannot poke the daemon, and so that, if the daemon
+ * dies, no other process can recreate the socket and trick us
+ * into talking to an imposter.
+ */
+static const char *get_my_tmp_dir(void)
+{
+	const char *tmpdir;
+	struct strbuf path =3D STRBUF_INIT;
+
+	if (my_tmp_dir)
+		return my_tmp_dir;
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
+	strbuf_addf(&path, "%s/XXXXXX", tmpdir);
+	if (!mkdtemp(path.buf))
+		die(("failed to make temp dir for socket"));
+
+	my_tmp_dir =3D strbuf_detach(&path, NULL);
+	return my_tmp_dir;
+}
+
+static void strbuf_va_tmp_path(struct strbuf *sb, const char *format, =
va_list params)
+{
+	const char *tmpdir;
+
+	tmpdir =3D get_my_tmp_dir();
+
+	strbuf_reset(sb);
+	strbuf_addstr(sb, tmpdir);
+	strbuf_addch(sb, '/');
+
+	strbuf_vaddf(sb, format, params);
+}
+
+static void strbuf_tmp_path(struct strbuf *sb, const char *format, ...=
)
+{
+	va_list params;
+
+	va_start(params, format);
+	strbuf_va_tmp_path(sb, format, params);
+	va_end(params);
+}
+
+static const char *tmp_path(const char *format, ...)
+{
+	va_list params;
+	static struct strbuf sb =3D STRBUF_INIT;
+
+	va_start(params, format);
+	strbuf_va_tmp_path(&sb, format, params);
+	va_end(params);
+
+	return sb.buf;
+}
+
+static void release_index_shm(struct shm *is)
+{
+	if (!is->shm)
+		return;
+	munmap(is->shm, is->size);
+	unlink(tmp_path("git-index-%s", sha1_to_hex(is->sha1)));
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
+			       tmp_path("git-index-%s",
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
+		strbuf_release(&command);
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
+	/*
+	 * Use a stupid filename because we want to minimize the path
+	 * length since socket filenames must be short.
+	 */
+	strbuf_tmp_path(&socket_path, "s");
+
+	fd =3D unix_stream_listen(socket_path.buf);
+	if (fd < 0)
+		die_errno(_("could not set up index-helper socket"));
+	/*
+	 * Now that the socket is set up, we symlink it into
+	 * GIT_DIR so clients can find it.
+	 */
+	if (unlink(git_path("index-helper.path")) && errno !=3D ENOENT)
+		die(_("failed to delete old index-helper.path"));
+	if (symlink(get_my_tmp_dir(), git_path("index-helper.path")))
+		die(_("failed to symlink socket path into index-helper.path"));
+	loop(fd, idle_in_seconds);
+
+	return 0;
+}
diff --git a/read-cache.c b/read-cache.c
index 7e387e9..5b351c5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -18,6 +18,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "utf8.h"
+#include "unix-socket.h"
=20
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -48,6 +49,7 @@ static struct cache_entry *refresh_cache_entry(struct=
 cache_entry *ce,
=20
 struct index_state the_index;
 static const char *alternate_index_output;
+static const char *index_helper_dir;
=20
 static void set_index_entry(struct index_state *istate, int nr, struct=
 cache_entry *ce)
 {
@@ -1541,6 +1543,146 @@ static void post_read_index_from(struct index_s=
tate *istate)
 	tweak_untracked_cache(istate);
 }
=20
+
+static int read_link(const char *path, char *buf, size_t bufsize)
+{
+	int len;
+
+	len =3D readlink(path, buf, bufsize);
+	if (len < 0 || len >=3D bufsize)
+		return -1;
+	buf[len] =3D '\0';
+	return 0;
+}
+
+static const char *get_index_helper_dir(void)
+{
+	char helper_path[PATH_MAX];
+
+	if (index_helper_dir)
+		return index_helper_dir;
+
+	if (read_link(git_path("index-helper.path"), helper_path,
+		      sizeof(helper_path) - 1) < 0) {
+		/*
+		 * If we can't readlink it, let's avoid confusing
+		 * users in the future and zap the bad link
+		 */
+		unlink(git_path("index-helper.path"));
+		return NULL;
+	}
+
+	index_helper_dir =3D xstrdup(helper_path);
+	return index_helper_dir;
+}
+
+static const char *index_helper_path(const char *format, ...)
+{
+	static struct strbuf sb =3D STRBUF_INIT;
+	va_list params;
+	const char *dir;
+
+	dir =3D get_index_helper_dir();
+	if (!dir)
+		return NULL;
+
+	strbuf_reset(&sb);
+	strbuf_addstr(&sb, dir);
+
+	va_start(params, format);
+	strbuf_vaddf(&sb, format, params);
+	va_end(params);
+
+	return sb.buf;
+}
+
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
+	socket_path =3D index_helper_path("s");
+	if (!socket_path)
+		return -1;
+
+	fd =3D unix_stream_connect(socket_path);
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
+	int fd;
+
+	if (!is_main_index(istate) ||
+	    old_size <=3D 20 ||
+	    stat(git_path("index-helper.path"), &st))
+		return -1;
+	if (poke_daemon(istate, &st, 0))
+		return -1;
+	sha1 =3D (unsigned char *)istate->mmap + old_size - 20;
+
+	fd =3D open(index_helper_path("git-index-%s", sha1_to_hex(sha1)),
+		  O_RDONLY);
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
+	return 0;
+
+fail:
+	poke_daemon(istate, &st, 1);
+	return -1;
+}
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int mu=
st_exist)
 {
@@ -1555,6 +1697,7 @@ int do_read_index(struct index_state *istate, con=
st char *path, int must_exist)
 	if (istate->initialized)
 		return istate->cache_nr;
=20
+	istate->from_shm =3D 0;
 	istate->timestamp.sec =3D 0;
 	istate->timestamp.nsec =3D 0;
 	fd =3D open(path, O_RDONLY);
@@ -1574,15 +1717,17 @@ int do_read_index(struct index_state *istate, c=
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
@@ -1662,6 +1807,8 @@ int read_index_from(struct index_state *istate, c=
onst char *path)
 	else
 		split_index->base =3D xcalloc(1, sizeof(*split_index->base));
 	split_index->base->keep_mmap =3D istate->keep_mmap;
+	split_index->base->to_shm    =3D istate->to_shm;
+	split_index->base->from_shm  =3D istate->from_shm;
 	ret =3D do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1712,6 +1859,8 @@ int discard_index(struct index_state *istate)
 	discard_split_index(istate);
 	free_untracked_cache(istate->untracked);
 	istate->untracked =3D NULL;
+	istate->from_shm =3D 0;
+	istate->to_shm   =3D 0;
 	return 0;
 }
=20
@@ -2138,9 +2287,14 @@ static int do_write_locked_index(struct index_st=
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
diff --git a/t/t7900-index-helper.sh b/t/t7900-index-helper.sh
new file mode 100755
index 0000000..c127ed7
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
+	test_path_is_missing .git/index-helper.path
+'
+
+test_done
--=20
2.4.2.767.g62658d5-twtrsrc
