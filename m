From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v7 3/5] lstat_cache(): introduce has_dirs_only_path()
 function
Date: Tue, 13 Jan 2009 13:29:06 +0100
Message-ID: <1231849748-8244-4-git-send-email-barvik@broadpark.no>
References: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 13:31:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMiQU-0007vI-8K
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 13:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758350AbZAMM30 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 07:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758310AbZAMM3Z
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 07:29:25 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:58286 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758286AbZAMM3W (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 07:29:22 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDE00163TCWOM10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:20 +0100 (CET)
Received: from localhost.localdomain ([84.48.79.194])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDE00L11TCKJ9C0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:20 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.GIT
In-reply-to: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105493>

Inside the create_directories() function inside entry.c we currently
do an stat() or lstat() call for each path component of the pathname
'path' each and every time called.  For the 'git checkout' command,
this function is called on each file for which we must do an update
(ce->ce_flags & CE_UPDATE), so we get lots and lots of calls...

To fix this, we make a new wrapper to the lstat_cache() function, and
call the wrapper function instead of the calls to the stat() or the
lstat() functions.  Since the paths given to the create_directories()
function, is sorted alphabetically, the new wrapper would be very
cache effective in this situation.

To support it we must update the lstat_cache() function to be able to
say that "pleace test the complete length of 'name'", and also to give
it the length of a prefix, where the cache should use the stat()
function instead of the lstat() function to test each path component.

Thanks to Junio C Hamano, Linus Torvalds and Rene Scharfe for valuable
comments to this patch!

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h    |    1 +
 entry.c    |   34 ++++++++++---------------------
 symlinks.c |   63 +++++++++++++++++++++++++++++++++++++++++++----------------
 3 files changed, 58 insertions(+), 40 deletions(-)

diff --git a/cache.h b/cache.h
index 11181aa..7c8c8e4 100644
--- a/cache.h
+++ b/cache.h
@@ -721,6 +721,7 @@ struct checkout {
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 extern int has_symlink_leading_path(int len, const char *name);
 extern int has_symlink_or_noent_leading_path(int len, const char *name);
+extern int has_dirs_only_path(int len, const char *name, int prefix_len);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/entry.c b/entry.c
index aa2ee46..b0295bd 100644
--- a/entry.c
+++ b/entry.c
@@ -8,35 +8,23 @@ static void create_directories(const char *path, const struct checkout *state)
 	const char *slash = path;
 
 	while ((slash = strchr(slash+1, '/')) != NULL) {
-		struct stat st;
-		int stat_status;
-
 		len = slash - path;
 		memcpy(buf, path, len);
 		buf[len] = 0;
 
-		if (len <= state->base_dir_len)
-			/*
-			 * checkout-index --prefix=<dir>; <dir> is
-			 * allowed to be a symlink to an existing
-			 * directory.
-			 */
-			stat_status = stat(buf, &st);
-		else
-			/*
-			 * if there currently is a symlink, we would
-			 * want to replace it with a real directory.
-			 */
-			stat_status = lstat(buf, &st);
-
-		if (!stat_status && S_ISDIR(st.st_mode))
+		/* For 'checkout-index --prefix=<dir>', <dir> is
+		 * allowed to be a symlink to an existing directory,
+		 * and we set 'state->base_dir_len' below, such that
+		 * we test the path components of the prefix with the
+		 * stat() function instead of the lstat() function.
+		 */
+		if (has_dirs_only_path(len, buf, state->base_dir_len))
 			continue; /* ok, it is already a directory. */
 
-		/*
-		 * We know stat_status == 0 means something exists
-		 * there and this mkdir would fail, but that is an
-		 * error codepath; we do not care, as we unlink and
-		 * mkdir again in such a case.
+		/* If this mkdir() would fail, it could be that there
+		 * is already a symlink or something else exists
+		 * there, therefore we then try to unlink it and try
+		 * one more time to create the directory.
 		 */
 		if (mkdir(buf, 0777)) {
 			if (errno == EEXIST && state->force &&
diff --git a/symlinks.c b/symlinks.c
index 52b3b0e..f9d1821 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,10 +1,11 @@
 #include "cache.h"
 
 static struct cache_def {
-	char path[PATH_MAX];
+	char path[PATH_MAX + 1];
 	int len;
 	int flags;
 	int track_flags;
+	int prefix_len_stat_func;
 } cache;
 
 /* Returns the length (on a path component basis) of the longest
@@ -30,12 +31,13 @@ static inline int greatest_match_lstat_cache(int len, const char *name)
 	return match_len;
 }
 
-static inline void reset_lstat_cache(int track_flags)
+static inline void reset_lstat_cache(int track_flags, int prefix_len_stat_func)
 {
 	cache.path[0] = '\0';
 	cache.len   = 0;
 	cache.flags = 0;
 	cache.track_flags = track_flags;
+	cache.prefix_len_stat_func = prefix_len_stat_func;
 }
 
 #define FL_DIR      (1 << 0)
@@ -43,28 +45,35 @@ static inline void reset_lstat_cache(int track_flags)
 #define FL_SYMLINK  (1 << 2)
 #define FL_LSTATERR (1 << 3)
 #define FL_ERR      (1 << 4)
+#define FL_FULLPATH (1 << 5)
 
 /*
  * Check if name 'name' of length 'len' has a symlink leading
  * component, or if the directory exists and is real, or not.
  *
  * To speed up the check, some information is allowed to be cached.
- * This is can be indicated by the 'track_flags' argument.
+ * This is can be indicated by the 'track_flags' argument, which also
+ * can be used to indicate that we should always check the full path.
+ *
+ * The 'prefix_len_stat_func' parameter can be used to set the length
+ * of the prefix, where the cache should use the stat() function
+ * instead of the lstat() function to test each path component.
  */
 static int lstat_cache(int len, const char *name,
-		       int track_flags)
+		       int track_flags, int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir;
-	int match_flags, ret_flags, save_flags, max_len;
+	int match_flags, ret_flags, save_flags, max_len, ret;
 	struct stat st;
 
-	if (cache.track_flags != track_flags) {
+	if (cache.track_flags != track_flags ||
+	    cache.prefix_len_stat_func != prefix_len_stat_func) {
 		/*
-		 * As a safeguard we clear the cache if the value of
-		 * track_flags does not match with the last supplied
-		 * value.
+		 * As a safeguard we clear the cache if the values of
+		 * track_flags and/or prefix_len_stat_func does not
+		 * match with the last supplied values.
 		 */
-		reset_lstat_cache(track_flags);
+		reset_lstat_cache(track_flags, prefix_len_stat_func);
 		match_len = last_slash = 0;
 	} else {
 		/*
@@ -96,12 +105,17 @@ static int lstat_cache(int len, const char *name,
 			cache.path[match_len] = name[match_len];
 			match_len++;
 		} while (match_len < max_len && name[match_len] != '/');
-		if (match_len >= max_len)
+		if (match_len >= max_len && !(track_flags & FL_FULLPATH))
 			break;
 		last_slash = match_len;
 		cache.path[last_slash] = '\0';
 
-		if (lstat(cache.path, &st)) {
+		if (last_slash <= prefix_len_stat_func)
+			ret = stat(cache.path, &st);
+		else
+			ret = lstat(cache.path, &st);
+
+		if (ret) {
 			ret_flags = FL_LSTATERR;
 			if (errno == ENOENT)
 				ret_flags |= FL_NOENT;
@@ -121,12 +135,12 @@ static int lstat_cache(int len, const char *name,
 	 * for the moment!
 	 */
 	save_flags = ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
-	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
+	if (save_flags && last_slash > 0 && last_slash <= PATH_MAX) {
 		cache.path[last_slash] = '\0';
 		cache.len   = last_slash;
 		cache.flags = save_flags;
 	} else if (track_flags & FL_DIR &&
-		   last_slash_dir > 0 && last_slash_dir < PATH_MAX) {
+		   last_slash_dir > 0 && last_slash_dir <= PATH_MAX) {
 		/* We have a separate test for the directory case,
 		 * since it could be that we have found a symlink or a
 		 * none existing directory and the track_flags says
@@ -141,17 +155,19 @@ static int lstat_cache(int len, const char *name,
 		cache.len   = last_slash_dir;
 		cache.flags = FL_DIR;
 	} else {
-		reset_lstat_cache(track_flags);
+		reset_lstat_cache(track_flags, prefix_len_stat_func);
 	}
 	return ret_flags;
 }
 
+#define USE_ONLY_LSTAT  0
+
 /* Return non-zero if path 'name' has a leading symlink component.
  */
 int has_symlink_leading_path(int len, const char *name)
 {
 	return lstat_cache(len, name,
-			   FL_SYMLINK|FL_DIR) &
+			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
 		FL_SYMLINK;
 }
 
@@ -161,6 +177,19 @@ int has_symlink_leading_path(int len, const char *name)
 int has_symlink_or_noent_leading_path(int len, const char *name)
 {
 	return lstat_cache(len, name,
-			   FL_SYMLINK|FL_NOENT|FL_DIR) &
+			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
 		(FL_SYMLINK|FL_NOENT);
 }
+
+/* Return non-zero if all path components of 'name' exists as a
+ * directory.  If prefix_len > 0, we will test with the stat()
+ * function instead of the lstat() function for a prefix length of
+ * 'prefix_len', thus we then allow for symlink(s) in the prefix part
+ * as long as those points to real existing directories.
+ */
+int has_dirs_only_path(int len, const char *name, int prefix_len)
+{
+	return lstat_cache(len, name,
+			   FL_DIR|FL_FULLPATH, prefix_len) &
+		FL_DIR;
+}
-- 
1.6.0.2.GIT
