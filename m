From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v10 2/5] lstat_cache(): introduce
 has_symlink_or_noent_leading_path() function
Date: Sun, 18 Jan 2009 16:14:51 +0100
Message-ID: <1232291694-18083-3-git-send-email-barvik@broadpark.no>
References: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 16:16:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOZO5-00067Y-2V
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 16:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763570AbZARPPH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Jan 2009 10:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763333AbZARPPG
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Jan 2009 10:15:06 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:56574 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763517AbZARPPE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Jan 2009 10:15:04 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDO00A8LAD2IU70@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:15:02 +0100 (CET)
Received: from localhost.localdomain ([80.203.29.59])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDO00BSIACUNG70@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Sun, 18 Jan 2009 16:15:02 +0100 (CET)
X-Mailer: git-send-email 1.6.1.83.gd727f
In-reply-to: <1232291694-18083-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106220>

In some cases, especially inside the unpack-trees.c file, and inside
the verify_absent() function, we can avoid some unnecessary calls to
lstat(), if the lstat_cache() function can also be told to keep track
of non-existing directories.

So we update the lstat_cache() function to handle this new fact,
introduce a new wrapper function, and the result is that we save lots
of lstat() calls for a removed directory which previously contained
lots of files, when we call this new wrapper of lstat_cache() instead
of the old one.

We do similar changes inside the unlink_entry() function, since if we
can already say that the leading directory component of a pathname
does not exist, it is not necessary to try to remove a pathname below
it!

Thanks to Junio C Hamano, Linus Torvalds and Rene Scharfe for valuable
comments to this patch!

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 cache.h        |    1 +
 symlinks.c     |   94 +++++++++++++++++++++++++++++++++++--------------------
 unpack-trees.c |    4 +-
 3 files changed, 63 insertions(+), 36 deletions(-)

diff --git a/cache.h b/cache.h
index 8e1af26..518e4c7 100644
--- a/cache.h
+++ b/cache.h
@@ -717,6 +717,7 @@ struct checkout {
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 extern int has_symlink_leading_path(int len, const char *name);
+extern int has_symlink_or_noent_leading_path(int len, const char *name);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index 49fb4d8..c69556a 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -4,6 +4,7 @@ static struct cache_def {
 	char path[PATH_MAX];
 	int len;
 	int flags;
+	int track_flags;
 } cache;
 
 /*
@@ -30,21 +31,23 @@ static inline int longest_match_lstat_cache(int len, const char *name)
 	return match_len;
 }
 
-static inline void reset_lstat_cache(void)
+static inline void reset_lstat_cache(int track_flags)
 {
 	cache.path[0] = '\0';
 	cache.len = 0;
 	cache.flags = 0;
+	cache.track_flags = track_flags;
 }
 
 #define FL_DIR      (1 << 0)
-#define FL_SYMLINK  (1 << 1)
-#define FL_LSTATERR (1 << 2)
-#define FL_ERR      (1 << 3)
+#define FL_NOENT    (1 << 1)
+#define FL_SYMLINK  (1 << 2)
+#define FL_LSTATERR (1 << 3)
+#define FL_ERR      (1 << 4)
 
 /*
  * Check if name 'name' of length 'len' has a symlink leading
- * component, or if the directory exists and is real.
+ * component, or if the directory exists and is real, or not.
  *
  * To speed up the check, some information is allowed to be cached.
  * This can be indicated by the 'track_flags' argument.
@@ -56,25 +59,35 @@ static int lstat_cache(int len, const char *name,
 	int match_flags, ret_flags, save_flags, max_len;
 	struct stat st;
 
-	/*
-	 * Check to see if we have a match from the cache for the
-	 * symlink path type.
-	 */
-	match_len = last_slash = longest_match_lstat_cache(len, name);
-	match_flags = cache.flags & track_flags & FL_SYMLINK;
-	if (match_flags && match_len == cache.len)
-		return match_flags;
-	/*
-	 * If we now have match_len > 0, we would know that the
-	 * matched part will always be a directory.
-	 *
-	 * Also, if we are tracking directories and 'name' is a
-	 * substring of the cache on a path component basis, we can
-	 * return immediately.
-	 */
-	match_flags = track_flags & FL_DIR;
-	if (match_flags && len == match_len)
-		return match_flags;
+	if (cache.track_flags != track_flags) {
+		/*
+		 * As a safeguard we clear the cache if the value of
+		 * track_flags does not match with the last supplied
+		 * value.
+		 */
+		reset_lstat_cache(track_flags);
+		match_len = last_slash = 0;
+	} else {
+		/*
+		 * Check to see if we have a match from the cache for
+		 * the 2 "excluding" path types.
+		 */
+		match_len = last_slash = longest_match_lstat_cache(len, name);
+		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
+		if (match_flags && match_len == cache.len)
+			return match_flags;
+		/*
+		 * If we now have match_len > 0, we would know that
+		 * the matched part will always be a directory.
+		 *
+		 * Also, if we are tracking directories and 'name' is
+		 * a substring of the cache on a path component basis,
+		 * we can return immediately.
+		 */
+		match_flags = track_flags & FL_DIR;
+		if (match_flags && len == match_len)
+			return match_flags;
+	}
 
 	/*
 	 * Okay, no match from the cache so far, so now we have to
@@ -95,6 +108,8 @@ static int lstat_cache(int len, const char *name,
 
 		if (lstat(cache.path, &st)) {
 			ret_flags = FL_LSTATERR;
+			if (errno == ENOENT)
+				ret_flags |= FL_NOENT;
 		} else if (S_ISDIR(st.st_mode)) {
 			last_slash_dir = last_slash;
 			continue;
@@ -107,11 +122,11 @@ static int lstat_cache(int len, const char *name,
 	}
 
 	/*
-	 * At the end update the cache.  Note that max 2 different
-	 * path types, FL_SYMLINK and FL_DIR, can be cached for the
-	 * moment!
+	 * At the end update the cache.  Note that max 3 different
+	 * path types, FL_NOENT, FL_SYMLINK and FL_DIR, can be cached
+	 * for the moment!
 	 */
-	save_flags = ret_flags & track_flags & FL_SYMLINK;
+	save_flags = ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
 	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
 		cache.path[last_slash] = '\0';
 		cache.len = last_slash;
@@ -120,20 +135,20 @@ static int lstat_cache(int len, const char *name,
 		   last_slash_dir > 0 && last_slash_dir < PATH_MAX) {
 		/*
 		 * We have a separate test for the directory case,
-		 * since it could be that we have found a symlink and
-		 * the track_flags says that we cannot cache this
-		 * fact, so the cache would then have been left empty
-		 * in this case.
+		 * since it could be that we have found a symlink or a
+		 * non-existing directory and the track_flags says
+		 * that we cannot cache this fact, so the cache would
+		 * then have been left empty in this case.
 		 *
 		 * But if we are allowed to track real directories, we
 		 * can still cache the path components before the last
-		 * one (the found symlink component).
+		 * one (the found symlink or non-existing component).
 		 */
 		cache.path[last_slash_dir] = '\0';
 		cache.len = last_slash_dir;
 		cache.flags = FL_DIR;
 	} else {
-		reset_lstat_cache();
+		reset_lstat_cache(track_flags);
 	}
 	return ret_flags;
 }
@@ -147,3 +162,14 @@ int has_symlink_leading_path(int len, const char *name)
 			   FL_SYMLINK|FL_DIR) &
 		FL_SYMLINK;
 }
+
+/*
+ * Return non-zero if path 'name' has a leading symlink component or
+ * if some leading path component does not exists.
+ */
+int has_symlink_or_noent_leading_path(int len, const char *name)
+{
+	return lstat_cache(len, name,
+			   FL_SYMLINK|FL_NOENT|FL_DIR) &
+		(FL_SYMLINK|FL_NOENT);
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 15c9ef5..16bc2ca 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -61,7 +61,7 @@ static void unlink_entry(struct cache_entry *ce)
 	char *cp, *prev;
 	char *name = ce->name;
 
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
 		return;
 	if (unlink(name))
 		return;
@@ -580,7 +580,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-- 
1.6.1.83.gd727f
