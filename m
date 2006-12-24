From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 7/7] Replace mmap with xmmap, better handling MAP_FAILED.
Date: Sun, 24 Dec 2006 00:47:23 -0500
Message-ID: <20061224054723.GG8146@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:47:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMCo-0001bE-NP
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:47:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754140AbWLXFr2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754141AbWLXFr1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:47:27 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53798 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754140AbWLXFr1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:47:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMCj-0008TK-Jj; Sun, 24 Dec 2006 00:47:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DC17220FB65; Sun, 24 Dec 2006 00:47:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35344>

In some cases we did not even bother to check the return value of
mmap() and just assume it worked.  This is bad, because if we are
out of virtual address space the kernel returned MAP_FAILED and we
would attempt to dereference that address, segfaulting without any
real error output to the user.

We are replacing all calls to mmap() with xmmap() and moving all
MAP_FAILED checking into that single location.  If a mmap call
fails we try to release enough least-recently-used pack windows
to possibly succeed, then retry the mmap() attempt.  If we cannot
mmap even after releasing pack memory then we die() as none of our
callers have any reasonable recovery strategy for a failed mmap.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 config.c          |    2 +-
 diff.c            |    4 +---
 git-compat-util.h |   13 +++++++++++++
 read-cache.c      |    2 +-
 refs.c            |    2 +-
 sha1_file.c       |   18 +++++-------------
 6 files changed, 22 insertions(+), 19 deletions(-)

diff --git a/config.c b/config.c
index edc42f4..410d5e9 100644
--- a/config.c
+++ b/config.c
@@ -698,7 +698,7 @@ int git_config_set_multivar(const char* key, const char* value,
 		}
 
 		fstat(in_fd, &st);
-		contents = mmap(NULL, st.st_size, PROT_READ,
+		contents = xmmap(NULL, st.st_size, PROT_READ,
 			MAP_PRIVATE, in_fd, 0);
 		close(in_fd);
 
diff --git a/diff.c b/diff.c
index f14288b..244292a 100644
--- a/diff.c
+++ b/diff.c
@@ -1341,10 +1341,8 @@ int diff_populate_filespec(struct diff_filespec *s, int size_only)
 		fd = open(s->path, O_RDONLY);
 		if (fd < 0)
 			goto err_empty;
-		s->data = mmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
+		s->data = xmmap(NULL, s->size, PROT_READ, MAP_PRIVATE, fd, 0);
 		close(fd);
-		if (s->data == MAP_FAILED)
-			goto err_empty;
 		s->should_munmap = 1;
 	}
 	else {
diff --git a/git-compat-util.h b/git-compat-util.h
index 4a417be..51e8d7a 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -185,6 +185,19 @@ static inline void *xcalloc(size_t nmemb, size_t size)
 	return ret;
 }
 
+static inline void *xmmap(void *start, size_t length,
+	int prot, int flags, int fd, off_t offset)
+{
+	void *ret = mmap(start, length, prot, flags, fd, offset);
+	if (ret == MAP_FAILED) {
+		release_pack_memory(length);
+		ret = mmap(start, length, prot, flags, fd, offset);
+		if (ret == MAP_FAILED)
+			die("Out of memory? mmap failed: %s", strerror(errno));
+	}
+	return ret;
+}
+
 static inline ssize_t xread(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
diff --git a/read-cache.c b/read-cache.c
index b8d83cc..ca3efbb 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -798,7 +798,7 @@ int read_cache_from(const char *path)
 		cache_mmap_size = st.st_size;
 		errno = EINVAL;
 		if (cache_mmap_size >= sizeof(struct cache_header) + 20)
-			cache_mmap = mmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
+			cache_mmap = xmmap(NULL, cache_mmap_size, PROT_READ | PROT_WRITE, MAP_PRIVATE, fd, 0);
 	}
 	close(fd);
 	if (cache_mmap == MAP_FAILED)
diff --git a/refs.c b/refs.c
index a101ff3..286ae45 100644
--- a/refs.c
+++ b/refs.c
@@ -1025,7 +1025,7 @@ int read_ref_at(const char *ref, unsigned long at_time, int cnt, unsigned char *
 	fstat(logfd, &st);
 	if (!st.st_size)
 		die("Log %s is empty.", logfile);
-	logdata = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, logfd, 0);
+	logdata = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, logfd, 0);
 	close(logfd);
 
 	lastrec = NULL;
diff --git a/sha1_file.c b/sha1_file.c
index fb1032b..84037fe 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -355,10 +355,8 @@ static void read_info_alternates(const char * relative_base, int depth)
 		close(fd);
 		return;
 	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	map = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (map == MAP_FAILED)
-		return;
 
 	link_alt_odb_entries(map, map + st.st_size, '\n', relative_base, depth);
 
@@ -442,10 +440,8 @@ static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
 		return -1;
 	}
 	idx_size = st.st_size;
-	idx_map = mmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	idx_map = xmmap(NULL, idx_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (idx_map == MAP_FAILED)
-		return -1;
 
 	index = idx_map;
 	*idx_map_ = idx_map;
@@ -630,7 +626,7 @@ unsigned char* use_pack(struct packed_git *p,
 			while (packed_git_limit < pack_mapped
 				&& unuse_one_window(p))
 				; /* nothing */
-			win->base = mmap(NULL, win->len,
+			win->base = xmmap(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,
 				p->pack_fd, win->offset);
 			if (win->base == MAP_FAILED)
@@ -828,10 +824,8 @@ void *map_sha1_file(const unsigned char *sha1, unsigned long *size)
 		 */
 		sha1_file_open_flag = 0;
 	}
-	map = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	map = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (map == MAP_FAILED)
-		return NULL;
 	*size = st.st_size;
 	return map;
 }
@@ -1987,10 +1981,8 @@ int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, con
 
 	buf = "";
 	if (size)
-		buf = mmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
+		buf = xmmap(NULL, size, PROT_READ, MAP_PRIVATE, fd, 0);
 	close(fd);
-	if (buf == MAP_FAILED)
-		return -1;
 
 	if (!type)
 		type = blob_type;
-- 
1.4.4.3.g2e63
