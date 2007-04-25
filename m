From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH] Actually handle some-low memory conditions
Date: Wed, 25 Apr 2007 04:02:27 -0400
Message-ID: <20070425080227.GA8368@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Wed Apr 25 10:02:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgcST-0003fJ-3Q
	for gcvg-git@gmane.org; Wed, 25 Apr 2007 10:02:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161840AbXDYICd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 25 Apr 2007 04:02:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161843AbXDYICd
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Apr 2007 04:02:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58254 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161840AbXDYICb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2007 04:02:31 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgcSK-00061S-AD; Wed, 25 Apr 2007 04:02:28 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C9D8520FBAE; Wed, 25 Apr 2007 04:02:27 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45506>

Tim Ansell discovered his Debian server didn't permit git-daemon to
use as much memory as it needed to handle cloning a project with
a 128 MiB packfile.  Filtering the strace provided by Tim of the
rev-list child showed this gem of a sequence:

  open("./objects/pack/pack-*.pack", O_RDONLY|O_LARGEFILE <unfinished ...>
  <... open resumed> )              = 5

OK, so the packfile is fd 5...

  mmap2(NULL, 33554432, PROT_READ, MAP_PRIVATE, 5, 0 <unfinished ...>
   <... mmap2 resumed> )             = 0xb5e2d000

and we mapped one 32 MiB window from it at position 0...

   mmap2(NULL, 31020635, PROT_READ, MAP_PRIVATE, 5, 0x6000 <unfinished ...>
   <... mmap2 resumed> )             = -1 ENOMEM (Cannot allocate memory)

And we asked for another window further into the file.  But got
denied.  In Tim's case this was due to a resource limit on the
git-daemon process, and its children.

Now where are we in the code?  We're down inside use_pack(),
after we have called unuse_one_window() enough times to make sure
we stay within our allowed maximum window size.  However since we
didn't unmap the prior window at 0xb5e2d000 we aren't exceeding
the current limit (which probably was just the defaults).

But we're actually down inside xmmap()...

So we release the window we do have (by calling release_pack_memory),
assuming there is some memory pressure...

   munmap(0xb5e2d000, 33554432 <unfinished ...>
   <... munmap resumed> )            = 0
   close(5 <unfinished ...>
   <... close resumed> )             = 0

And that was the last window in this packfile.  So we closed it.
Way to go us.  Our xmmap did not expect release_pack_memory to
close the fd its about to map...

   mmap2(NULL, 31020635, PROT_READ, MAP_PRIVATE, 5, 0x6000 <unfinished ...>
   <... mmap2 resumed> )             = -1 EBADF (Bad file descriptor)

And so the Linux kernel happily tells us f' off.

   write(2, "fatal: ", 7 <unfinished ...>
   <... write resumed> )             = 7
   write(2, "Out of memory? mmap failed: Bad "..., 47 <unfinished ...>
   <... write resumed> )             = 47

And we report the bad file descriptor error, and not the ENOMEM,
and die, claiming we are out of memory.  But actually that mmap
should have succeeded, as we had enough memory for that window,
seeing as how we released the prior one.

Originally when I developed the sliding window mmap feature I had
this exact same bug in fast-import, and I dealt with it by handing
in the struct packed_git* we want to open the new window for, as the
caller wasn't prepared to reopen the packfile if unuse_one_window
closed it.  The same is true here from xmmap, but the caller doesn't
have the struct packed_git* handy.  So I'm using the file descriptor
instead to perform the same test.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 The patch is obviously correct.  But I don't have the CPU cycles
 right now to compile this thing, or test it.  (Sorry, another job
 is higher priority, has been running 9 hours now and has another
 ~11 hours to go.)

 git-compat-util.h |   12 ++++++------
 sha1_file.c       |   10 +++++-----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5f6a281..e3cf370 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -156,13 +156,13 @@ extern size_t gitstrlcpy(char *, const char *, size_t);
 extern uintmax_t gitstrtoumax(const char *, char **, int);
 #endif
 
-extern void release_pack_memory(size_t);
+extern void release_pack_memory(size_t, int);
 
 static inline char* xstrdup(const char *str)
 {
 	char *ret = strdup(str);
 	if (!ret) {
-		release_pack_memory(strlen(str) + 1);
+		release_pack_memory(strlen(str) + 1, -1);
 		ret = strdup(str);
 		if (!ret)
 			die("Out of memory, strdup failed");
@@ -176,7 +176,7 @@ static inline void *xmalloc(size_t size)
 	if (!ret && !size)
 		ret = malloc(1);
 	if (!ret) {
-		release_pack_memory(size);
+		release_pack_memory(size, -1);
 		ret = malloc(size);
 		if (!ret && !size)
 			ret = malloc(1);
@@ -195,7 +195,7 @@ static inline void *xrealloc(void *ptr, size_t size)
 	if (!ret && !size)
 		ret = realloc(ptr, 1);
 	if (!ret) {
-		release_pack_memory(size);
+		release_pack_memory(size, -1);
 		ret = realloc(ptr, size);
 		if (!ret && !size)
 			ret = realloc(ptr, 1);
@@ -211,7 +211,7 @@ static inline void *xcalloc(size_t nmemb, size_t size)
 	if (!ret && (!nmemb || !size))
 		ret = calloc(1, 1);
 	if (!ret) {
-		release_pack_memory(nmemb * size);
+		release_pack_memory(nmemb * size, -1);
 		ret = calloc(nmemb, size);
 		if (!ret && (!nmemb || !size))
 			ret = calloc(1, 1);
@@ -228,7 +228,7 @@ static inline void *xmmap(void *start, size_t length,
 	if (ret == MAP_FAILED) {
 		if (!length)
 			return NULL;
-		release_pack_memory(length);
+		release_pack_memory(length, fd);
 		ret = mmap(start, length, prot, flags, fd, offset);
 		if (ret == MAP_FAILED)
 			die("Out of memory? mmap failed: %s", strerror(errno));
diff --git a/sha1_file.c b/sha1_file.c
index 9c26038..3717c7e 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -516,7 +516,7 @@ static void scan_windows(struct packed_git *p,
 	}
 }
 
-static int unuse_one_window(struct packed_git *current)
+static int unuse_one_window(struct packed_git *current, int keep_fd)
 {
 	struct packed_git *p, *lru_p = NULL;
 	struct pack_window *lru_w = NULL, *lru_l = NULL;
@@ -532,7 +532,7 @@ static int unuse_one_window(struct packed_git *current)
 			lru_l->next = lru_w->next;
 		else {
 			lru_p->windows = lru_w->next;
-			if (!lru_p->windows && lru_p != current) {
+			if (!lru_p->windows && lru_p->pack_fd != keep_fd) {
 				close(lru_p->pack_fd);
 				lru_p->pack_fd = -1;
 			}
@@ -544,10 +544,10 @@ static int unuse_one_window(struct packed_git *current)
 	return 0;
 }
 
-void release_pack_memory(size_t need)
+void release_pack_memory(size_t need, int fd)
 {
 	size_t cur = pack_mapped;
-	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
+	while (need >= (cur - pack_mapped) && unuse_one_window(NULL, fd))
 		; /* nothing */
 }
 
@@ -680,7 +680,7 @@ unsigned char* use_pack(struct packed_git *p,
 			win->len = (size_t)len;
 			pack_mapped += win->len;
 			while (packed_git_limit < pack_mapped
-				&& unuse_one_window(p))
+				&& unuse_one_window(p, p->pack_fd))
 				; /* nothing */
 			win->base = xmmap(NULL, win->len,
 				PROT_READ, MAP_PRIVATE,
-- 
1.5.1.1.135.gf948
