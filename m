From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/3] Make refresh_cache_entry() public
Date: Fri, 30 Jun 2006 16:43:58 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0606301643400.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20060630002756.GD22618@steel.home>
 <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 16:44:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwKE1-0003UX-8H
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 16:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932599AbWF3OoA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 10:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751273AbWF3OoA
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 10:44:00 -0400
Received: from mail.gmx.net ([213.165.64.21]:45024 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751268AbWF3On7 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 30 Jun 2006 10:43:59 -0400
Received: (qmail invoked by alias); 30 Jun 2006 14:43:58 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 30 Jun 2006 16:43:58 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Alex Riesen <fork0@t-online.de>
In-Reply-To: <Pine.LNX.4.63.0606300235300.29667@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22988>


This renames refresh_entry() to refresh_cache_entry(), to make clashes
more unlikely, and makes it public. It also rethinks the rather awkward
way to pass an error: this is done by returning a NULL pointer and setting
cache_errno now.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
 cache.h      |    2 ++
 read-cache.c |   44 +++++++++++++++++---------------------------
 2 files changed, 19 insertions(+), 27 deletions(-)

diff --git a/cache.h b/cache.h
index a5343db..a59b319 100644
--- a/cache.h
+++ b/cache.h
@@ -115,6 +115,7 @@ #define cache_entry_size(len) ((offsetof
 extern struct cache_entry **active_cache;
 extern unsigned int active_nr, active_alloc, active_cache_changed;
 extern struct cache_tree *active_cache_tree;
+extern int cache_errno;
 
 #define GIT_DIR_ENVIRONMENT "GIT_DIR"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
@@ -151,6 +152,7 @@ #define ADD_CACHE_OK_TO_ADD 1		/* Ok to 
 #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
 #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
 extern int add_cache_entry(struct cache_entry *ce, int option);
+extern struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really);
 extern int remove_cache_entry_at(int pos);
 extern int remove_file_from_cache(const char *path);
 extern int ce_same_name(struct cache_entry *a, struct cache_entry *b);
diff --git a/read-cache.c b/read-cache.c
index 04d2ec7..1c0fc8b 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -24,6 +24,8 @@ unsigned int active_nr = 0, active_alloc
 
 struct cache_tree *active_cache_tree = NULL;
 
+int cache_errno = 0;
+
 static void *cache_mmap = NULL;
 static size_t cache_mmap_size = 0;
 
@@ -580,22 +582,6 @@ int add_cache_entry(struct cache_entry *
 	return 0;
 }
 
-/* Three functions to allow overloaded pointer return; see linux/err.h */
-static inline void *ERR_PTR(long error)
-{
-	return (void *) error;
-}
-
-static inline long PTR_ERR(const void *ptr)
-{
-	return (long) ptr;
-}
-
-static inline long IS_ERR(const void *ptr)
-{
-	return (unsigned long)ptr > (unsigned long)-1000L;
-}
-
 /*
  * "refresh" does not calculate a new sha1 file or bring the
  * cache up-to-date for mode/content changes. But what it
@@ -607,14 +593,16 @@ static inline long IS_ERR(const void *pt
  * For example, you'd want to do this after doing a "git-read-tree",
  * to link up the stat cache details with the proper files.
  */
-static struct cache_entry *refresh_entry(struct cache_entry *ce, int really)
+struct cache_entry *refresh_cache_entry(struct cache_entry *ce, int really)
 {
 	struct stat st;
 	struct cache_entry *updated;
 	int changed, size;
 
-	if (lstat(ce->name, &st) < 0)
-		return ERR_PTR(-errno);
+	if (lstat(ce->name, &st) < 0) {
+		cache_errno = errno;
+		return NULL;
+	}
 
 	changed = ce_match_stat(ce, &st, really);
 	if (!changed) {
@@ -622,11 +610,13 @@ static struct cache_entry *refresh_entry
 		    !(ce->ce_flags & htons(CE_VALID)))
 			; /* mark this one VALID again */
 		else
-			return NULL;
+			return ce;
 	}
 
-	if (ce_modified(ce, &st, really))
-		return ERR_PTR(-EINVAL);
+	if (ce_modified(ce, &st, really)) {
+		cache_errno = EINVAL;
+		return NULL;
+	}
 
 	size = ce_size(ce);
 	updated = xmalloc(size);
@@ -669,13 +659,13 @@ int refresh_cache(unsigned int flags)
 			continue;
 		}
 
-		new = refresh_entry(ce, really);
-		if (!new)
+		new = refresh_cache_entry(ce, really);
+		if (new == ce)
 			continue;
-		if (IS_ERR(new)) {
-			if (not_new && PTR_ERR(new) == -ENOENT)
+		if (!new) {
+			if (not_new && cache_errno == ENOENT)
 				continue;
-			if (really && PTR_ERR(new) == -EINVAL) {
+			if (really && cache_errno == EINVAL) {
 				/* If we are doing --really-refresh that
 				 * means the index is not valid anymore.
 				 */
-- 
1.4.1.rc1.gb2d14
