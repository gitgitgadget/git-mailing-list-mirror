From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH 6/7] Release pack windows before reporting out of memory.
Date: Sun, 24 Dec 2006 00:47:19 -0500
Message-ID: <20061224054719.GF8146@spearce.org>
References: <487c7d0ea81f2f82f330e277e0aea38a66ca7cfe.1166939109.git.spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 06:47:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyMCj-0001bB-U7
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 06:47:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbWLXFrX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 00:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754140AbWLXFrX
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 00:47:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53794 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754133AbWLXFrW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 00:47:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyMCf-0008TF-9I; Sun, 24 Dec 2006 00:47:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 7FB6720FB65; Sun, 24 Dec 2006 00:47:19 -0500 (EST)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35343>

If we are about to fail because this process has run out of memory we
should first try to automatically control our appetite for address
space by releasing enough least-recently-used pack windows to gain
back enough memory such that we might actually be able to meet the
current allocation request.

This should help users who have fairly large repositories but are
working on systems with relatively small virtual address space.
Many times we see reports on the mailing list of these users running
out of memory during various Git operations.  Dynamically decreasing
the amount of pack memory used when the demand for heap memory is
increasing is an intelligent solution to this problem.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 git-compat-util.h |   40 ++++++++++++++++++++++++++++++++--------
 sha1_file.c       |    7 +++++++
 2 files changed, 39 insertions(+), 8 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index e056339..4a417be 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -120,11 +120,17 @@ extern char *gitstrcasestr(const char *haystack, const char *needle);
 extern size_t gitstrlcpy(char *, const char *, size_t);
 #endif
 
+extern void release_pack_memory(size_t);
+
 static inline char* xstrdup(const char *str)
 {
 	char *ret = strdup(str);
-	if (!ret)
-		die("Out of memory, strdup failed");
+	if (!ret) {
+		release_pack_memory(strlen(str) + 1);
+		ret = strdup(str);
+		if (!ret)
+			die("Out of memory, strdup failed");
+	}
 	return ret;
 }
 
@@ -133,8 +139,14 @@ static inline void *xmalloc(size_t size)
 	void *ret = malloc(size);
 	if (!ret && !size)
 		ret = malloc(1);
-	if (!ret)
-		die("Out of memory, malloc failed");
+	if (!ret) {
+		release_pack_memory(size);
+		ret = malloc(size);
+		if (!ret && !size)
+			ret = malloc(1);
+		if (!ret)
+			die("Out of memory, malloc failed");
+	}
 #ifdef XMALLOC_POISON
 	memset(ret, 0xA5, size);
 #endif
@@ -146,8 +158,14 @@ static inline void *xrealloc(void *ptr, size_t size)
 	void *ret = realloc(ptr, size);
 	if (!ret && !size)
 		ret = realloc(ptr, 1);
-	if (!ret)
-		die("Out of memory, realloc failed");
+	if (!ret) {
+		release_pack_memory(size);
+		ret = realloc(ptr, size);
+		if (!ret && !size)
+			ret = realloc(ptr, 1);
+		if (!ret)
+			die("Out of memory, realloc failed");
+	}
 	return ret;
 }
 
@@ -156,8 +174,14 @@ static inline void *xcalloc(size_t nmemb, size_t size)
 	void *ret = calloc(nmemb, size);
 	if (!ret && (!nmemb || !size))
 		ret = calloc(1, 1);
-	if (!ret)
-		die("Out of memory, calloc failed");
+	if (!ret) {
+		release_pack_memory(nmemb * size);
+		ret = calloc(nmemb, size);
+		if (!ret && (!nmemb || !size))
+			ret = calloc(1, 1);
+		if (!ret)
+			die("Out of memory, calloc failed");
+	}
 	return ret;
 }
 
diff --git a/sha1_file.c b/sha1_file.c
index 8de8ce0..fb1032b 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -522,6 +522,13 @@ static int unuse_one_window(struct packed_git *current)
 	return 0;
 }
 
+void release_pack_memory(size_t need)
+{
+	size_t cur = pack_mapped;
+	while (need >= (cur - pack_mapped) && unuse_one_window(NULL))
+		; /* nothing */
+}
+
 void unuse_pack(struct pack_window **w_cursor)
 {
 	struct pack_window *w = *w_cursor;
-- 
1.4.4.3.g2e63
