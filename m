From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v7 4/5] lstat_cache(): introduce invalidate_lstat_cache()
 function
Date: Tue, 13 Jan 2009 13:29:07 +0100
Message-ID: <1231849748-8244-5-git-send-email-barvik@broadpark.no>
References: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 13:31:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMiQU-0007vI-Vo
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 13:31:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758402AbZAMM31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 07:29:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758363AbZAMM30
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 07:29:26 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:58286 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758305AbZAMM3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 07:29:25 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDE0016FTCYOM10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:22 +0100 (CET)
Received: from localhost.localdomain ([84.48.79.194])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDE00L11TCKJ9C0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:22 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.GIT
In-reply-to: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105491>

In some cases it could maybe be necessary to say to the cache that
"Hey, I deleted this directory and if you currently has it inside your
cache, you should deleted it".  This patch introduce a function which
support this.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h    |    1 +
 symlinks.c |   39 +++++++++++++++++++++++++++++++--------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/cache.h b/cache.h
index 7c8c8e4..f4452a8 100644
--- a/cache.h
+++ b/cache.h
@@ -722,6 +722,7 @@ extern int checkout_entry(struct cache_entry *ce, const struct checkout *state,
 extern int has_symlink_leading_path(int len, const char *name);
 extern int has_symlink_or_noent_leading_path(int len, const char *name);
 extern int has_dirs_only_path(int len, const char *name, int prefix_len);
+extern void invalidate_lstat_cache(int len, const char *name);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index f9d1821..3b1c3da 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -11,23 +11,30 @@ static struct cache_def {
 /* Returns the length (on a path component basis) of the longest
  * common prefix match of 'name' and the cached path string.
  */
-static inline int greatest_match_lstat_cache(int len, const char *name)
+static inline int greatest_match_lstat_cache(int len, const char *name,
+					     int *previous_slash)
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
-	if (i == cache.len && len > cache.len && name[cache.len] == '/')
+	if (i == cache.len && len > cache.len && name[cache.len] == '/') {
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
 
@@ -62,7 +69,7 @@ static inline void reset_lstat_cache(int track_flags, int prefix_len_stat_func)
 static int lstat_cache(int len, const char *name,
 		       int track_flags, int prefix_len_stat_func)
 {
-	int match_len, last_slash, last_slash_dir;
+	int match_len, last_slash, last_slash_dir, previous_slash;
 	int match_flags, ret_flags, save_flags, max_len, ret;
 	struct stat st;
 
@@ -80,7 +87,8 @@ static int lstat_cache(int len, const char *name,
 		 * Check to see if we have a match from the cache for
 		 * the 2 "excluding" path types.
 		 */
-		match_len = last_slash = greatest_match_lstat_cache(len, name);
+		match_len = last_slash =
+			greatest_match_lstat_cache(len, name, &previous_slash);
 		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
 		if (match_flags && match_len == cache.len)
 			return match_flags;
@@ -160,6 +168,21 @@ static int lstat_cache(int len, const char *name,
 	return ret_flags;
 }
 
+/* Invalidate the given 'name' from the cache, if 'name' matches
+ * completely with the cache.
+ */
+void invalidate_lstat_cache(int len, const char *name)
+{
+	int match_len, previous_slash;
+
+	match_len = greatest_match_lstat_cache(len, name, &previous_slash);
+	if (match_len == len) {
+		cache.path[previous_slash] = '\0';
+		cache.len   = previous_slash;
+		cache.flags = previous_slash ? FL_DIR : 0;
+	}
+}
+
 #define USE_ONLY_LSTAT  0
 
 /* Return non-zero if path 'name' has a leading symlink component.
-- 
1.6.0.2.GIT
