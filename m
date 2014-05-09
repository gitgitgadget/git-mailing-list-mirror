From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 00/32] Split index mode for very large indexes
Date: Fri, 9 May 2014 17:27:44 +0700
Message-ID: <20140509102744.GA4939@lanh>
References: <1398682553-11634-1-git-send-email-pclouds@gmail.com>
 <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 09 12:28:08 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wii2A-0001ij-LD
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 12:28:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753387AbaEIK1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 06:27:46 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:56946 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbaEIK1o (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 06:27:44 -0400
Received: by mail-pa0-f47.google.com with SMTP id lf10so1728465pab.20
        for <git@vger.kernel.org>; Fri, 09 May 2014 03:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=Qw49xvgpX/uMxgrZKExuikQx9CfPVgqwpqTmuY4l6aI=;
        b=FuluPI+4cOqF5EUgzMpBSfc4E3pQhmq0wC/XhrV3Qw4QgObBYmQUGpfjsMuAWP0zvx
         10ZVoZ+JgtEzJ+h2dTDFTd63fR4LQfFLF/z7wChCWbL4V3PhcKsS5b5SBvk1Qmh727ea
         jb//ID9PdVPawzOppoD1MNrgQAzowcarOMy2Xr4UYsoS5SAMBZxsp4K7EoFDIl92Uc/E
         4m91zhUT9qtvvra3SRDlURnLv/wgli9AJB2LsDNsVsW70zrJl623VVLXLMUAHhZAQGHV
         sp1W6SOEkYCIjaBeeUvvlJIwGWUTId+sPsyXRUATXhwhvsDZXNf2X81dBFoLwYcp9dYn
         lM/A==
X-Received: by 10.66.158.10 with SMTP id wq10mr19232522pab.32.1399631263833;
        Fri, 09 May 2014 03:27:43 -0700 (PDT)
Received: from lanh ([115.73.231.16])
        by mx.google.com with ESMTPSA id gg3sm6803673pbc.34.2014.05.09.03.27.40
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 09 May 2014 03:27:42 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Fri, 09 May 2014 17:27:44 +0700
Content-Disposition: inline
In-Reply-To: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248547>

On Mon, Apr 28, 2014 at 02:18:44PM -0700, Shawn Pearce wrote:
> > The read penalty is not addressed here, so I still pay 14MB hashing
> > cost. But that's an easy problem. We could cache the validated index
> > in a daemon. Whenever git needs to load an index, it pokes the daemon.
> > The daemon verifies that the on-disk index still has the same
> > signature, then sends the in-mem index to git. When git updates the
> > index, it pokes the daemon again to update in-mem index. Next time git
> > reads the index, it does not have to pay I/O cost any more (actually
> > it does but the cost is hidden away when you do not have to read it
> > yet).
> 
> If we are going this far, maybe it is worthwhile building a mmap()
> region the daemon exports to the git client that holds the "in memory"
> format of the index. Clients would mmap this PROT_READ, MAP_PRIVATE
> and can then quickly access the base file information without doing
> further validation, or copying the large(ish) data over a pipe.

The below patch implements such a daemon to cache the index. It takes
91ms and 377ms to load a 25MB index with and without the daemon. I use
share memory instead of pipe, but the format is still "on disk" not
"in memory" for simplicity. I think we're good even without in memory
format.

The daemon should work on Windows after shm_open and unix socket are
replaced with the equivalents. Then we could cache name-hash in it
too.

With all improvements on (index v4, split index, preload index,
untracked cache, read-cache daemon), "git status" goes from 1.8s to
0.6s on webkit.git (the CPU is clocked at 800 MHz so this is close to
"poor machine" case).

Time to convince Junio it's good and push bit by bit to master :)

-- 8< --
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
diff --git a/cache.h b/cache.h
index 99854c7..5251bda 100644
--- a/cache.h
+++ b/cache.h
@@ -290,10 +290,14 @@ struct index_state {
 	struct split_index *split_index;
 	struct cache_time timestamp;
 	unsigned name_hash_initialized : 1,
+		 keep_mmap : 1,
+		 poke_daemon : 1,
 		 initialized : 1;
 	struct hashmap name_hash;
 	struct hashmap dir_hash;
 	unsigned char sha1[20];
+	void *mmap;
+	size_t mmap_size;
 };
 
 extern struct index_state the_index;
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
index 0000000..32a5aa7
--- /dev/null
+++ b/read-cache--daemon.c
@@ -0,0 +1,168 @@
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
+	fprintf(stderr, "refreshed\n");
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
diff --git a/read-cache.c b/read-cache.c
index 42eac62..7ab6fb5 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -16,6 +16,7 @@
 #include "varint.h"
 #include "split-index.h"
 #include "sigchain.h"
+#include "unix-socket.h"
 
 static struct cache_entry *refresh_cache_entry(struct cache_entry *ce,
 					       unsigned int options);
@@ -1332,6 +1333,8 @@ static int verify_hdr(struct cache_header *hdr, unsigned long size)
 	hdr_version = ntohl(hdr->hdr_version);
 	if (hdr_version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < hdr_version)
 		return error("bad index version %d", hdr_version);
+	if (!size)
+		return 0;
 	git_SHA1_Init(&c);
 	git_SHA1_Update(&c, hdr, size - 20);
 	git_SHA1_Final(sha1, &c);
@@ -1462,6 +1465,35 @@ static struct cache_entry *create_from_disk(struct ondisk_cache_entry *ondisk,
 	return ce;
 }
 
+static void *try_shm(void *mmap, size_t mmap_size)
+{
+	struct strbuf sb = STRBUF_INIT;
+	void *new_mmap;
+	struct stat st;
+	int fd;
+
+	if (mmap_size <= 20)
+		return mmap;
+
+	strbuf_addf(&sb, "/git-index-%s",
+		    sha1_to_hex((unsigned char *)mmap + mmap_size - 20));
+	fd = shm_open(sb.buf, O_RDONLY, 0777);
+	strbuf_release(&sb);
+	if (fd < 0)
+		return mmap;
+	if (fstat(fd, &st) || st.st_size != mmap_size) {
+		close(fd);
+		return mmap;
+	}
+	new_mmap = xmmap(NULL, mmap_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	close(fd);
+	if (new_mmap == MAP_FAILED)
+		return mmap;
+	munmap(mmap, mmap_size);
+	return new_mmap;
+}
+
+
 /* remember to discard_cache() before reading a different cache! */
 int do_read_index(struct index_state *istate, const char *path, int must_exist)
 {
@@ -1469,7 +1501,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	struct stat st;
 	unsigned long src_offset;
 	struct cache_header *hdr;
-	void *mmap;
+	void *mmap, *old_mmap;
 	size_t mmap_size;
 	struct strbuf previous_name_buf = STRBUF_INIT, *previous_name;
 
@@ -1495,11 +1527,23 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 	mmap = xmmap(NULL, mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	if (mmap == MAP_FAILED)
 		die_errno("unable to map index file");
+	if (istate->keep_mmap) {
+		istate->mmap = mmap;
+		istate->mmap_size = mmap_size;
+	}
 	close(fd);
 
+	old_mmap = mmap;
+	mmap = try_shm(old_mmap, mmap_size);
 	hdr = mmap;
-	if (verify_hdr(hdr, mmap_size) < 0)
-		goto unmap;
+	if (old_mmap == mmap) {
+		if (verify_hdr(hdr, mmap_size) < 0)
+			goto unmap;
+	} else {
+		if (verify_hdr(hdr, 0) < 0)
+			goto unmap;
+		istate->poke_daemon = 1;
+	}
 
 	hashcpy(istate->sha1, (const unsigned char *)hdr + mmap_size - 20);
 	istate->version = ntohl(hdr->hdr_version);
@@ -1547,10 +1591,12 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
 		src_offset += 8;
 		src_offset += extsize;
 	}
-	munmap(mmap, mmap_size);
+	if (!istate->keep_mmap)
+		munmap(mmap, mmap_size);
 	return istate->cache_nr;
 
 unmap:
+	istate->mmap = NULL;
 	munmap(mmap, mmap_size);
 	die("index file corrupt");
 }
@@ -1576,6 +1622,7 @@ int read_index_from(struct index_state *istate, const char *path)
 		discard_index(split_index->base);
 	else
 		split_index->base = xcalloc(1, sizeof(*split_index->base));
+	split_index->base->keep_mmap = istate->keep_mmap;
 	ret = do_read_index(split_index->base,
 			    git_path("sharedindex.%s",
 				     sha1_to_hex(split_index->base_sha1)), 1);
@@ -1618,6 +1665,10 @@ int discard_index(struct index_state *istate)
 	free(istate->cache);
 	istate->cache = NULL;
 	istate->cache_alloc = 0;
+	if (istate->keep_mmap && istate->mmap) {
+		munmap(istate->mmap, istate->mmap_size);
+		istate->mmap = NULL;
+	}
 	discard_split_index(istate);
 	return 0;
 }
@@ -2071,12 +2122,14 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 		       unsigned flags)
 {
 	struct split_index *si = istate->split_index;
+	int ret;
 
 	if (!si || alternate_index_output ||
 	    (istate->cache_changed & ~EXTMASK)) {
 		if (si)
 			hashclr(si->base_sha1);
-		return do_write_locked_index(istate, lock, flags);
+		ret = do_write_locked_index(istate, lock, flags);
+		goto done;
 	}
 
 	if (getenv("GIT_TEST_SPLIT_INDEX")) {
@@ -2090,7 +2143,13 @@ int write_locked_index(struct index_state *istate, struct lock_file *lock,
 			return ret;
 	}
 
-	return write_split_index(istate, lock, flags);
+	ret = write_split_index(istate, lock, flags);
+done:
+	if (!ret && istate->poke_daemon) {
+		int fd = unix_stream_connect(git_path("daemon/index"));
+		close(fd);
+	}
+	return ret;
 }
 
 /*
-- 8< --
