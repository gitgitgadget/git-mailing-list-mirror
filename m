From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v10 4/5] lstat_cache(): introduce invalidate_lstat_cache()
 function
Date: Sun, 18 Jan 2009 16:14:53 +0100
Message-ID: <1232291694-18083-5-git-send-email-barvik@broadpark.no>
References: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 16:16:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZOM-0006JQ-IS
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763333AbZARPPR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763962AbZARPPN
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:15:13 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:56577 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763333AbZARPPJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:15:09 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDO00A8RAD8IU70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:15:08 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.59])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDO00BSIACUNG70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:15:08 +0100 (CET)
X-Mailer: git-send-email 1.6.1.83.gd727f
In-reply-to: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106222>

In some cases it could maybe be necessary to say to the cache that
"Hey, I deleted/changed the type of this pathname and if you currently
have it inside your cache, you should deleted it".

This patch introduce a function which support this.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h    |    1 +
 symlinks.c |   44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 110b9f9..efcceec 100644
--- a/cache.h
+++ b/cache.h
@@ -719,6 +719,7 @@ extern int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 extern int has_symlink_leading_path(int len, const char *name);
 extern int has_symlink_or_noent_leading_path(int len, const char *name);
 extern int has_dirs_only_path(int len, const char *name, int prefix_len);
+extern void invalidate_lstat_cache(int len, const char *name);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index 918e24a..dbdfec4 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -12,23 +12,30 @@ static struct cache_def {
  * Returns the length (on a path component basis) of the longest
  * common prefix match of 'name' and the cached path string.
  */
-static inline int longest_match_lstat_cache(int len, const char *name)
+static inline int longest_match_lstat_cache(int len, const char *name,
+					    int *previous_slash)
 {
-	int max_len, match_len = 0, i = 0;
+	int max_len, match_len = 0, match_len_prev = 0, i = 0;
 
 	max_len = len < cache.len ? len : cache.len;
 	while (i < max_len && name[i] == cache.path[i]) {
-		if (name[i] == '/')
+		if (name[i] == '/') {
+			match_len_prev = match_len;
 			match_len = i;
+		}
 		i++;
 	}
 	/* Is the cached path string a substring of 'name'? */
-	if (i == cache.len && cache.len < len && name[cache.len] == '/')
+	if (i == cache.len && cache.len < len && name[cache.len] == '/') {
+		match_len_prev = match_len;
 		match_len = cache.len;
 	/* Is 'name' a substring of the cached path string? */
-	else if ((i == len && len < cache.len && cache.path[len] == '/') ||
-		 (i == len && len == cache.len))
+	} else if ((i == len && len < cache.len && cache.path[len] == '/') ||
+		   (i == len && len == cache.len)) {
+		match_len_prev = match_len;
 		match_len = len;
+	}
+	*previous_slash = match_len_prev;
 	return match_len;
 }
 
@@ -63,7 +70,7 @@ static inline void reset_lstat_cache(int track_flags, int prefix_len_stat_func)
 static int lstat_cache(int len, const char *name,
 		       int track_flags, int prefix_len_stat_func)
 {
-	int match_len, last_slash, last_slash_dir;
+	int match_len, last_slash, last_slash_dir, previous_slash;
 	int match_flags, ret_flags, save_flags, max_len, ret;
 	struct stat st;
 
@@ -81,7 +88,8 @@ static int lstat_cache(int len, const char *name,
 		 * Check to see if we have a match from the cache for
 		 * the 2 "excluding" path types.
 		 */
-		match_len = last_slash = longest_match_lstat_cache(len, name);
+		match_len = last_slash =
+			longest_match_lstat_cache(len, name, &previous_slash);
 		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
 		if (match_flags && match_len == cache.len)
 			return match_flags;
@@ -167,6 +175,26 @@ static int lstat_cache(int len, const char *name,
 	return ret_flags;
 }
 
+/*
+ * Invalidate the given 'name' from the cache, if 'name' matches
+ * completely with the cache.
+ */
+void invalidate_lstat_cache(int len, const char *name)
+{
+	int match_len, previous_slash;
+
+	match_len = longest_match_lstat_cache(len, name, &previous_slash);
+	if (len == match_len) {
+		if (cache.track_flags & FL_DIR && previous_slash > 0) {
+			cache.path[previous_slash] = '\0';
+			cache.len = previous_slash;
+			cache.flags = FL_DIR;
+		} else
+			reset_lstat_cache(cache.track_flags,
+					  cache.prefix_len_stat_func);
+	}
+}
+
 #define USE_ONLY_LSTAT  0
 
 /*
-- 
1.6.1.83.gd727f
