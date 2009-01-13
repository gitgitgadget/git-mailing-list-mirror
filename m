From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v7 2/5] lstat_cache(): introduce
 has_symlink_or_noent_leading_path() function
Date: Tue, 13 Jan 2009 13:29:05 +0100
Message-ID: <1231849748-8244-3-git-send-email-barvik@broadpark.no>
References: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Pete Harlan <pgit@pcharlan.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 13:31:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMiQR-0007vI-3s
	for gcvg-git-2@gmane.org; Tue, 13 Jan 2009 13:31:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758278AbZAMM3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2009 07:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758252AbZAMM3U
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Jan 2009 07:29:20 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:58276 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758008AbZAMM3R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2009 07:29:17 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KDE0015FTCSOM10@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:16 +0100 (CET)
Received: from localhost.localdomain ([84.48.79.194])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KDE00L11TCKJ9C0@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Tue, 13 Jan 2009 13:29:16 +0100 (CET)
X-Mailer: git-send-email 1.6.0.2.GIT
In-reply-to: <1231849748-8244-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105490>

In some cases, especially inside the unpack-trees.c file, and inside
the verify_absent() function, we can avoid some unnecessary calls to
lstat(), if the lstat_cache() function can also be told to keep track
of none existing directories.

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
 symlinks.c     |   87 ++++++++++++++++++++++++++++++++++++--------------------
 unpack-trees.c |    4 +-
 3 files changed, 59 insertions(+), 33 deletions(-)

diff --git a/cache.h b/cache.h
index 231c06d..11181aa 100644
--- a/cache.h
+++ b/cache.h
@@ -720,6 +720,7 @@ struct checkout {
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
 extern int has_symlink_leading_path(int len, const char *name);
+extern int has_symlink_or_noent_leading_path(int len, const char *name);
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/symlinks.c b/symlinks.c
index b17e4b3..52b3b0e 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -4,6 +4,7 @@ static struct cache_def {
 	char path[PATH_MAX];
 	int len;
 	int flags;
+	int track_flags;
 } cache;
 
 /* Returns the length (on a path component basis) of the longest
@@ -29,21 +30,23 @@ static inline int greatest_match_lstat_cache(int len, const char *name)
 	return match_len;
 }
 
-static inline void reset_lstat_cache(void)
+static inline void reset_lstat_cache(int track_flags)
 {
 	cache.path[0] = '\0';
 	cache.len   = 0;
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
  * This is can be indicated by the 'track_flags' argument.
@@ -55,22 +58,32 @@ static int lstat_cache(int len, const char *name,
 	int match_flags, ret_flags, save_flags, max_len;
 	struct stat st;
 
-	/*
-	 * Check to see if we have a match from the cache for the
-	 * symlink path type.
-	 */
-	match_len = last_slash = greatest_match_lstat_cache(len, name);
-	match_flags = cache.flags & track_flags & FL_SYMLINK;
-	if (match_flags && match_len == cache.len)
-		return match_flags;
-	/*
-	 * If 'name' is a substring of the cache on a path component
-	 * basis, and a directory is cached, we can return
-	 * immediately.
-	 */
-	match_flags = cache.flags & track_flags & FL_DIR;
-	if (match_flags && match_len == len)
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
+		match_len = last_slash = greatest_match_lstat_cache(len, name);
+		match_flags = cache.flags & track_flags & (FL_NOENT|FL_SYMLINK);
+		if (match_flags && match_len == cache.len)
+			return match_flags;
+		/*
+		 * If 'name' is a substring of the cache on a path
+		 * component basis, and a directory is cached, we
+		 * can return immediately.
+		 */
+		match_flags = cache.flags & track_flags & FL_DIR;
+		if (match_flags && match_len == len)
+			return match_flags;
+	}
 
 	/* Okay, no match from the cache so far, so now we have to
 	 * check the rest of the path components.
@@ -90,6 +103,8 @@ static int lstat_cache(int len, const char *name,
 
 		if (lstat(cache.path, &st)) {
 			ret_flags = FL_LSTATERR;
+			if (errno == ENOENT)
+				ret_flags |= FL_NOENT;
 		} else if (S_ISDIR(st.st_mode)) {
 			last_slash_dir = last_slash;
 			continue;
@@ -101,11 +116,11 @@ static int lstat_cache(int len, const char *name,
 		break;
 	}
 
-	/* At the end update the cache.  Note that max 2 different
-	 * path types, FL_SYMLINK and FL_DIR, can be cached for the
-	 * moment!
+	/* At the end update the cache.  Note that max 3 different
+	 * path types, FL_NOENT, FL_SYMLINK and FL_DIR, can be cached
+	 * for the moment!
 	 */
-	save_flags = ret_flags & track_flags & FL_SYMLINK;
+	save_flags = ret_flags & track_flags & (FL_NOENT|FL_SYMLINK);
 	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
 		cache.path[last_slash] = '\0';
 		cache.len   = last_slash;
@@ -113,20 +128,20 @@ static int lstat_cache(int len, const char *name,
 	} else if (track_flags & FL_DIR &&
 		   last_slash_dir > 0 && last_slash_dir < PATH_MAX) {
 		/* We have a separate test for the directory case,
-		 * since it could be that we have found a symlink and
-		 * the track_flags says that we can not cache this
-		 * fact, so the cache would then have been left empty
-		 * in this case.
+		 * since it could be that we have found a symlink or a
+		 * none existing directory and the track_flags says
+		 * that we can not cache this fact, so the cache would
+		 * then have been left empty in this case.
 		 *
 		 * But, if we is allowed to track real directories, we
 		 * can still cache the path components before the last
-		 * one (the found symlink component).
+		 * one (the found symlink or none existing component).
 		 */
 		cache.path[last_slash_dir] = '\0';
 		cache.len   = last_slash_dir;
 		cache.flags = FL_DIR;
 	} else {
-		reset_lstat_cache();
+		reset_lstat_cache(track_flags);
 	}
 	return ret_flags;
 }
@@ -139,3 +154,13 @@ int has_symlink_leading_path(int len, const char *name)
 			   FL_SYMLINK|FL_DIR) &
 		FL_SYMLINK;
 }
+
+/* Return non-zero if path 'name' has a leading symlink component or
+ * if some leading path component does not exists.
+ */
+int has_symlink_or_noent_leading_path(int len, const char *name)
+{
+	return lstat_cache(len, name,
+			   FL_SYMLINK|FL_NOENT|FL_DIR) &
+		(FL_SYMLINK|FL_NOENT);
+}
diff --git a/unpack-trees.c b/unpack-trees.c
index 54f301d..a3fd383 100644
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
@@ -584,7 +584,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-- 
1.6.0.2.GIT
