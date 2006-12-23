From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 11/17] Fully activate the sliding window pack access.
Date: Sat, 23 Dec 2006 02:34:28 -0500
Message-ID: <20061223073428.GL9837@spearce.org>
References: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 08:34:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy1Ou-0001uB-Ao
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 08:34:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752753AbWLWHed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 02:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752778AbWLWHed
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 02:34:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:38802 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752753AbWLWHec (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 02:34:32 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Gy1OQ-0003CO-8b; Sat, 23 Dec 2006 02:34:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EBB0920FB65; Sat, 23 Dec 2006 02:34:28 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <53b67707929c7f051f6d384c5d96e653bfa8419c.1166857884.git.spearce@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35291>

This finally turns on the sliding window behavior for packfile data
access by mapping limited size windows and chaining them under the
packed_git->windows list.

We consider a given byte offset to be within the window only if there
would be at least 20 bytes (one hash worth of data) accessible after
the requested offset.  This range selection relates to the contract
that use_pack() makes with its callers, allowing them to access
one hash or one object header without needing to call use_pack()
for every byte of data obtained.

In the worst case scenario we will map the same page of data twice
into memory: once at the end of one window and once again at the
start of the next window.  This duplicate page mapping will happen
only when an object header or a delta base reference is spanned
over the end of a window and is always limited to just one page of
duplication, as no sane operating system will ever have a page size
smaller than a hash.

I am assuming that the possible wasted page of virtual address
space is going to perform faster than the alternatives, which
would be to copy the object header or ref delta into a temporary
buffer prior to parsing, or to check the window range on every byte
during header parsing.  We may decide to revisit this decision in
the future since this is just a gut instinct decision and has not
actually been proven out by experimental testing.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/config.txt |   11 +++++++
 cache.h                  |    1 +
 config.c                 |   10 +++++++
 environment.c            |    1 +
 sha1_file.c              |   66 +++++++++++++++++++++++++++++++++++++---------
 5 files changed, 76 insertions(+), 13 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 4e93066..f8775f1 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -118,6 +118,17 @@ core.legacyheaders::
 	database directly (where the "http://" and "rsync://" protocols
 	count as direct access).
 
+core.packedGitWindowSize::
+	Number of bytes of a pack file to map into memory in a
+	single mapping operation.  Larger window sizes may allow
+	your system to process a smaller number of large pack files
+	more quickly.  Smaller window sizes will negatively affect
+	performance due to increased calls to the opreating system's
+	memory manager, but may improve performance when accessing
+	a large number of large pack files.  Default is 32 MiB,
+	which should be reasonable for all users/operating systems.
+	You probably do not need to adjust this value.
+
 core.packedGitLimit::
 	Maximum number of bytes to map simultaneously into memory
 	from pack files.  If Git needs to access more than this many
diff --git a/cache.h b/cache.h
index b294bbf..b7855ef 100644
--- a/cache.h
+++ b/cache.h
@@ -196,6 +196,7 @@ extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
 extern int zlib_compression_level;
+extern size_t packed_git_window_size;
 extern size_t packed_git_limit;
 
 #define GIT_REPO_VERSION 0
diff --git a/config.c b/config.c
index 1e79f09..a8ea063 100644
--- a/config.c
+++ b/config.c
@@ -298,6 +298,16 @@ int git_default_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.packedgitwindowsize")) {
+		int pgsz = getpagesize();
+		packed_git_window_size = git_config_int(var, value);
+		packed_git_window_size /= pgsz;
+		if (!packed_git_window_size)
+			packed_git_window_size = 1;
+		packed_git_window_size *= pgsz;
+		return 0;
+	}
+
 	if (!strcmp(var, "core.packedgitlimit")) {
 		packed_git_limit = git_config_int(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 8a09df2..289fc84 100644
--- a/environment.c
+++ b/environment.c
@@ -22,6 +22,7 @@ char git_commit_encoding[MAX_ENCODING_LENGTH] = "utf-8";
 int shared_repository = PERM_UMASK;
 const char *apply_default_whitespace;
 int zlib_compression_level = Z_DEFAULT_COMPRESSION;
+size_t packed_git_window_size = 32 * 1024 * 1024;
 size_t packed_git_limit = 256 * 1024 * 1024;
 int pager_in_use;
 int pager_use_color = 1;
diff --git a/sha1_file.c b/sha1_file.c
index 49dd4b7..fab2ab0 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -397,8 +397,9 @@ static char *find_sha1_file(const unsigned char *sha1, struct stat *st)
 	return NULL;
 }
 
-static int pack_used_ctr;
-static unsigned long pack_mapped;
+static unsigned int pack_used_ctr;
+static size_t pack_mapped;
+static size_t page_size;
 struct packed_git *packed_git;
 
 static int check_packed_git_idx(const char *path, unsigned long *idx_size_,
@@ -536,31 +537,70 @@ static void open_packed_git(struct packed_git *p)
 		die("packfile %s does not match index", p->pack_name);
 }
 
+static int in_window(struct pack_window *win, unsigned long offset)
+{
+	/* We must promise at least 20 bytes (one hash) after the
+	 * offset is available from this window, otherwise the offset
+	 * is not actually in this window and a different window (which
+	 * has that one hash excess) must be used.  This is to support
+	 * the object header and delta base parsing routines below.
+	 */
+	off_t win_off = win->offset;
+	return win_off <= offset
+		&& (offset + 20) <= (win_off + win->len);
+}
+
 unsigned char* use_pack(struct packed_git *p,
 		struct pack_window **w_cursor,
 		unsigned long offset,
 		unsigned int *left)
 {
-	struct pack_window *win = p->windows;
+	struct pack_window *win = *w_cursor;
 
 	if (p->pack_fd == -1)
 		open_packed_git(p);
-	if (!win) {
-		pack_mapped += p->pack_size;
-		while (packed_git_limit < pack_mapped && unuse_one_window())
-			; /* nothing */
-		win = xcalloc(1, sizeof(*win));
-		win->len = p->pack_size;
-		win->base = mmap(NULL, p->pack_size, PROT_READ, MAP_PRIVATE, p->pack_fd, 0);
-		if (win->base == MAP_FAILED)
-			die("packfile %s cannot be mapped.", p->pack_name);
-		p->windows = win;
+
+	/* Since packfiles end in a hash of their content and its
+	 * pointless to ask for an offset into the middle of that
+	 * hash, and the in_window function above wouldn't match
+	 * don't allow an offset too close to the end of the file.
+	 */
+	if (offset > (p->pack_size - 20))
+		die("offset beyond end of packfile (truncated pack?)");
+
+	if (!win || !in_window(win, offset)) {
+		if (win)
+			win->inuse_cnt--;
+		for (win = p->windows; win; win = win->next) {
+			if (in_window(win, offset))
+				break;
+		}
+		if (!win) {
+			if (!page_size)
+				page_size = getpagesize();
+			win = xcalloc(1, sizeof(*win));
+			win->offset = (offset / page_size) * page_size;
+			win->len = p->pack_size - win->offset;
+			if (win->len > packed_git_window_size)
+				win->len = packed_git_window_size;
+			pack_mapped += win->len;
+			while (packed_git_limit < pack_mapped && unuse_one_window())
+				; /* nothing */
+			win->base = mmap(NULL, win->len,
+				PROT_READ, MAP_PRIVATE,
+				p->pack_fd, win->offset);
+			if (win->base == MAP_FAILED)
+				die("packfile %s cannot be mapped.", p->pack_name);
+			win->next = p->windows;
+			p->windows = win;
+		}
 	}
 	if (win != *w_cursor) {
 		win->last_used = pack_used_ctr++;
 		win->inuse_cnt++;
 		*w_cursor = win;
 	}
+	offset -= win->offset;
 	if (left)
 		*left = win->len - offset;
 	return win->base + offset;
-- 
1.4.4.3.g87d8
