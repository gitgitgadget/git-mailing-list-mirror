From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH/RFC v4 1/2] Optimised, faster,
 more effective symlink/directory detection
Date: Thu, 08 Jan 2009 12:32:35 +0100
Message-ID: <1231414356-6982-2-git-send-email-barvik@broadpark.no>
References: <1231414356-6982-1-git-send-email-barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 08 12:34:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKt9K-0005sF-PX
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 12:34:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754450AbZAHLcq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 06:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754339AbZAHLcp
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 06:32:45 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:57588 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753687AbZAHLcm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 06:32:42 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KD500EK8HEH3P30@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Thu, 08 Jan 2009 12:32:41 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.24])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KD50047PHECTW80@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Thu, 08 Jan 2009 12:32:41 +0100 (CET)
X-Mailer: git-send-email 1.6.1.rc1.49.g7f705
In-reply-to: <1231414356-6982-1-git-send-email-barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104917>

Changes includes the following:

- The cache functionality is more effective.  Previously when A/B/C/D
  was in the cache and A/B/C/E/file.c was called for, there was no
  match at all from the cache.  Now we use the fact that the paths
  "A", "A/B" and "A/B/C" is already tested, and we only need to do an
  lstat() call on "A/B/C/E".

- We only cache/store the last path regardless of it's type.  Since the
  cache functionality is always used with alphabetically sorted names
  (at least it seams so for me), there is no need to store both the
  last symlink-leading path and the last real-directory path.  Note
  that if the cache is not called with (mostly) alphabetically sorted
  names, neither the old, nor this new one, would be very effective.

- We also can cache the fact that a directory does not exist.
  Previously we could end up doing lots of lstat() calls for a removed
  directory which previously contained lots of files.  Since we
  already have simplified the cache functionality and only store the
  last path (see above), this new functionality was easy to add.

- Previously, when symlink A/B/C/S was cached/stored in the
  symlink-leading path, and A/B/C/file.c was called for, it was not
  easy to use the fact that we already known that the paths "A", "A/B"
  and "A/B/C" is real directories.  Since we now only store one single
  path (the last one), we also get similar logic for free regarding
  the new "non-exsisting-directory-cache".

- Avoid copying the first path components of the name 2 zillions times
  when we tests new path components.  Since we always cache/store the
  last path, we can copy each component as we test those directly into
  the cache.  Previously we ended up doing a memcpy() for the full
  path/name right before each lstat() call, and when updating the
  cache for each time we have tested an new path component.

- We also use less memory, that is PATH_MAX bytes less memory on the
  stack and PATH_MAX bytes less memory on the heap.

- Introduce a 3rd argument, 'unsigned int track_flags', to the
  cache-test function, check_lstat_cache().  This new argument can be
  used to tell the cache functionality which types of directories
  should be cached.

- Also introduce a 'void clear_lstat_cache(void)' function, which
  should be used to clean the cache before usage.  If for instance,
  you have changed the types of directories which should be cached,
  the cache could contain a path which was not wanted.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
:100644 100644 719de8b... 870961e... M	builtin-add.c
:100644 100644 a8f75ed... d3d001a... M	builtin-apply.c
:100644 100644 5604977... 8907219... M	builtin-update-index.c
:100644 100644 231c06d... 768ba38... M	cache.h
:100644 100644 ae96c64... c9caa0e... M	diff-lib.c
:100644 100644 5a5e781... a68b11e... M	symlinks.c
:100644 100644 54f301d... 28e2759... M	unpack-trees.c
 builtin-add.c          |    1 +
 builtin-apply.c        |    1 +
 builtin-update-index.c |    1 +
 cache.h                |   22 ++++++++-
 diff-lib.c             |    1 +
 symlinks.c             |  120 ++++++++++++++++++++++++++++++-----------------
 unpack-trees.c         |    5 +-
 7 files changed, 104 insertions(+), 47 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 719de8b0f2d2d831f326d948aa18700e5c474950..870961e8ca4e3d6f9333020083d0a232bccd542c 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -225,6 +225,7 @@ int cmd_add(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, builtin_add_options,
 			  builtin_add_usage, 0);
+	clear_symlink_cache();
 	if (patch_interactive)
 		add_interactive = 1;
 	if (add_interactive)
diff --git a/builtin-apply.c b/builtin-apply.c
index a8f75ed3ed411d8cf7a3ec9dfefef7407c50f447..d3d001a96be6e502d6338af4467f7c313370d78e 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -3154,6 +3154,7 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 	if (apply_default_whitespace)
 		parse_whitespace_option(apply_default_whitespace);
 
+	clear_symlink_cache();
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		char *end;
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 560497750586ec61be4e34de6dedd9c307129817..8907219fb9cb438113e29ee17854edb5dd4baa4d 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -581,6 +581,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	if (entries < 0)
 		die("cache corrupted");
 
+	clear_symlink_cache();
 	for (i = 1 ; i < argc; i++) {
 		const char *path = argv[i];
 		const char *p;
diff --git a/cache.h b/cache.h
index 231c06d7726b575f6e522d5b0c0fe43557e8c651..768ba3825f3015828381490b0c387177a4f71578 100644
--- a/cache.h
+++ b/cache.h
@@ -719,7 +719,27 @@ struct checkout {
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
-extern int has_symlink_leading_path(int len, const char *name);
+
+#define LSTAT_DIR       (1u << 0)
+#define LSTAT_NOENT     (1u << 1)
+#define LSTAT_SYMLINK   (1u << 2)
+#define LSTAT_LSTATERR  (1u << 3)
+#define LSTAT_ERR       (1u << 4)
+extern unsigned int check_lstat_cache(int len, const char *name,
+				      unsigned int track_flags);
+extern void clear_lstat_cache(void);
+static inline unsigned int has_symlink_leading_path(int len, const char *name)
+{
+	return check_lstat_cache(len, name, LSTAT_SYMLINK|LSTAT_DIR) &
+		LSTAT_SYMLINK;
+}
+#define clear_symlink_cache() clear_lstat_cache()
+static inline unsigned int has_symlink_or_noent_leading_path(int len, const char *name)
+{
+	return check_lstat_cache(len, name, LSTAT_SYMLINK|LSTAT_NOENT|LSTAT_DIR) &
+		(LSTAT_SYMLINK|LSTAT_NOENT);
+}
+#define clear_symlink_or_noent_cache() clear_lstat_cache()
 
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
diff --git a/diff-lib.c b/diff-lib.c
index ae96c64ca209f4df9008198e8a04b160bed618c7..c9caa0e6ef0f4a8ee8b850869ef6d0f52b712385 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -69,6 +69,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 		diff_unmerged_stage = 2;
 	entries = active_nr;
 	symcache[0] = '\0';
+	clear_symlink_cache();
 	for (i = 0; i < entries; i++) {
 		struct stat st;
 		unsigned int oldmode, newmode;
diff --git a/symlinks.c b/symlinks.c
index 5a5e781a15d7d9cb60797958433eca896b31ec85..a68b11e2dbd875bc26b4fe0b87490dd64305cdd0 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -1,64 +1,96 @@
 #include "cache.h"
 
-struct pathname {
-	int len;
-	char path[PATH_MAX];
-};
+static char         cache_path[PATH_MAX];
+static int          cache_len   = 0;
+static unsigned int cache_flags = 0;
 
-/* Return matching pathname prefix length, or zero if not matching */
-static inline int match_pathname(int len, const char *name, struct pathname *match)
+static inline int greatest_match_lstat_cache(int len, const char *name)
 {
-	int match_len = match->len;
-	return (len > match_len &&
-		name[match_len] == '/' &&
-		!memcmp(name, match->path, match_len)) ? match_len : 0;
-}
+	int max_len, match_len = 0, i = 0;
 
-static inline void set_pathname(int len, const char *name, struct pathname *match)
-{
-	if (len < PATH_MAX) {
-		match->len = len;
-		memcpy(match->path, name, len);
-		match->path[len] = 0;
+	max_len = len < cache_len ? len : cache_len;
+	while (i < max_len && name[i] == cache_path[i]) {
+		if (name[i] == '/') match_len = i;
+		i++;
 	}
+	if (i == cache_len && len > cache_len && name[cache_len] == '/')
+		match_len = cache_len;
+	return match_len;
 }
 
-int has_symlink_leading_path(int len, const char *name)
+/*
+ * Check if name 'name' of length 'len' has a symlink leading
+ * component, or if the directory exists and is real, or not.
+ *
+ * To speed up the check, some information is allowed to be cached.
+ * This is indicated by the 'track_flags' argument.
+ */
+unsigned int
+check_lstat_cache(int len, const char *name, unsigned int track_flags)
 {
-	static struct pathname link, nonlink;
-	char path[PATH_MAX];
+	int match_len, last_slash, max_len;
+	unsigned int match_flags, ret_flags, save_flags;
 	struct stat st;
-	char *sp;
-	int known_dir;
 
-	/*
-	 * See if the last known symlink cache matches.
+	/* Check if match from the cache for 2 "excluding" path types.
 	 */
-	if (match_pathname(len, name, &link))
-		return 1;
+	match_len = last_slash = greatest_match_lstat_cache(len, name);
+	match_flags = cache_flags & track_flags & (LSTAT_NOENT|LSTAT_SYMLINK);
+	if (match_flags && match_len == cache_len)
+		return match_flags;
 
-	/*
-	 * Get rid of the last known directory part
+	/* Okay, no match from the cache so far, so now we have to
+	 * check the rest of the path components.
 	 */
-	known_dir = match_pathname(len, name, &nonlink);
-
-	while ((sp = strchr(name + known_dir + 1, '/')) != NULL) {
-		int thislen = sp - name ;
-		memcpy(path, name, thislen);
-		path[thislen] = 0;
+	ret_flags = LSTAT_DIR;
+	max_len = len < PATH_MAX ? len : PATH_MAX;
+	while (match_len < max_len) {
+		do {
+			cache_path[match_len] = name[match_len];
+			match_len++;
+		} while (match_len < max_len && name[match_len] != '/');
+		if (match_len >= max_len)
+			break;
+		last_slash = match_len;
+		cache_path[last_slash] = '\0';
 
-		if (lstat(path, &st))
-			return 0;
-		if (S_ISDIR(st.st_mode)) {
-			set_pathname(thislen, path, &nonlink);
-			known_dir = thislen;
+		if (lstat(cache_path, &st)) {
+			ret_flags = LSTAT_LSTATERR;
+			if (errno == ENOENT)
+				ret_flags |= LSTAT_NOENT;
+		} else if (S_ISDIR(st.st_mode)) {
 			continue;
-		}
-		if (S_ISLNK(st.st_mode)) {
-			set_pathname(thislen, path, &link);
-			return 1;
+		} else if (S_ISLNK(st.st_mode)) {
+			ret_flags = LSTAT_SYMLINK;
+		} else {
+			ret_flags = LSTAT_ERR;
 		}
 		break;
 	}
-	return 0;
+
+	/* At the end update the cache.  Note that max 3 different
+	 * path types can be cached for the moment!
+	 */
+	save_flags = ret_flags & track_flags &
+		(LSTAT_NOENT|LSTAT_SYMLINK|LSTAT_DIR);
+	if (save_flags && last_slash > 0 && last_slash < PATH_MAX) {
+		cache_path[last_slash] = '\0';
+		cache_len   = last_slash;
+		cache_flags = save_flags;
+	} else {
+		clear_lstat_cache();
+	}
+	return ret_flags;
+}
+
+/*
+ * Before usage of the check_lstat_cache() function one should call
+ * clear_lstat_cache() (at an appropriate place) to make sure that the
+ * cache is clean.
+ */
+void clear_lstat_cache(void)
+{
+	cache_path[0] = '\0';
+	cache_len     = 0;
+	cache_flags   = 0;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index 54f301da67be879c80426bc21776427fdd38c02e..28e275981a21b033459ef9c7e420cce4bf7e5513 100644
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
@@ -105,6 +105,7 @@ static int check_updates(struct unpack_trees_options *o)
 		cnt = 0;
 	}
 
+	clear_symlink_or_noent_cache();
 	for (i = 0; i < index->cache_nr; i++) {
 		struct cache_entry *ce = index->cache[i];
 
@@ -584,7 +585,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-- 
1.6.1.rc1.49.g7f705
