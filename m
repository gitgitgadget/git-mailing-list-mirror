From: Kjetil Barvik <barvik@broadpark.no>
Subject: [PATCH v4 3/9] lstat_cache(): swap func(length,
 string) into func(string, length)
Date: Mon, 09 Feb 2009 21:54:06 +0100
Message-ID: <f81744504a7f7c42fc877b6ae5811afab798ab77.1234211595.git.barvik@broadpark.no>
References: <cover.1234211594.git.barvik@broadpark.no>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>,
	Kjetil Barvik <barvik@broadpark.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 09 21:55:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWdAT-0002Ax-KE
	for gcvg-git-2@gmane.org; Mon, 09 Feb 2009 21:55:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753170AbZBIUyZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Feb 2009 15:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753140AbZBIUyY
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Feb 2009 15:54:24 -0500
Received: from osl1smout1.broadpark.no ([80.202.4.58]:36104 "EHLO
	osl1smout1.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753015AbZBIUyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Feb 2009 15:54:22 -0500
Received: from osl1sminn1.broadpark.no ([80.202.4.59])
 by osl1smout1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTP id <0KET00IE6GQKPR80@osl1smout1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:20 +0100 (CET)
Received: from localhost.localdomain ([80.202.166.166])
 by osl1sminn1.broadpark.no
 (Sun Java(tm) System Messaging Server 6.3-3.01 (built Jul 12 2007; 32bit))
 with ESMTPA id <0KET007FSGQC8090@osl1sminn1.broadpark.no> for
 git@vger.kernel.org; Mon, 09 Feb 2009 21:54:20 +0100 (CET)
X-Mailer: git-send-email 1.6.1.349.g99fa5
In-reply-to: <cover.1234211594.git.barvik@broadpark.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109119>

Swap function argument pair (length, string) into (string, length) to
conform with the commonly used order inside the GIT source code.

Also, add a note about this fact into the coding guidelines.

Signed-off-by: Kjetil Barvik <barvik@broadpark.no>
---
 Documentation/CodingGuidelines |    3 +++
 builtin-add.c                  |    2 +-
 builtin-apply.c                |    2 +-
 builtin-update-index.c         |    2 +-
 cache.h                        |    8 ++++----
 diff-lib.c                     |    2 +-
 dir.c                          |    2 +-
 entry.c                        |    2 +-
 symlinks.c                     |   16 ++++++++--------
 unpack-trees.c                 |    4 ++--
 10 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index 0d7fa9c..b8bf618 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -129,3 +129,6 @@ For C programs:
    used in the git core command set (unless your command is clearly
    separate from it, such as an importer to convert random-scm-X
    repositories to git).
+
+ - When we pass <string, length> pair to functions, we should try to
+   pass them in that order.
diff --git a/builtin-add.c b/builtin-add.c
index ac98c83..a23ad96 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -148,7 +148,7 @@ static const char **validate_pathspec(int argc, const char **argv, const char *p
 	if (pathspec) {
 		const char **p;
 		for (p = pathspec; *p; p++) {
-			if (has_symlink_leading_path(strlen(*p), *p)) {
+			if (has_symlink_leading_path(*p, strlen(*p))) {
 				int len = prefix ? strlen(prefix) : 0;
 				die("'%s' is beyond a symbolic link", *p + len);
 			}
diff --git a/builtin-apply.c b/builtin-apply.c
index f312798..106be94 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2360,7 +2360,7 @@ static int check_to_create_blob(const char *new_name, int ok_if_exists)
 		 * In such a case, path "new_name" does not exist as
 		 * far as git is concerned.
 		 */
-		if (has_symlink_leading_path(strlen(new_name), new_name))
+		if (has_symlink_leading_path(new_name, strlen(new_name)))
 			return 0;
 
 		return error("%s: already exists in working directory", new_name);
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 5604977..6c55527 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -195,7 +195,7 @@ static int process_path(const char *path)
 	struct stat st;
 
 	len = strlen(path);
-	if (has_symlink_leading_path(len, path))
+	if (has_symlink_leading_path(path, len))
 		return error("'%s' is beyond a symbolic link", path);
 
 	/*
diff --git a/cache.h b/cache.h
index 2d889de..80eeeb7 100644
--- a/cache.h
+++ b/cache.h
@@ -724,10 +724,10 @@ struct checkout {
 };
 
 extern int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *topath);
-extern int has_symlink_leading_path(int len, const char *name);
-extern int has_symlink_or_noent_leading_path(int len, const char *name);
-extern int has_dirs_only_path(int len, const char *name, int prefix_len);
-extern void invalidate_lstat_cache(int len, const char *name);
+extern int has_symlink_leading_path(const char *name, int len);
+extern int has_symlink_or_noent_leading_path(const char *name, int len);
+extern int has_dirs_only_path(const char *name, int len, int prefix_len);
+extern void invalidate_lstat_cache(const char *name, int len);
 extern void clear_lstat_cache(void);
 
 extern struct alternate_object_database {
diff --git a/diff-lib.c b/diff-lib.c
index a41e1ec..a3ba20e 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -31,7 +31,7 @@ static int check_removed(const struct cache_entry *ce, struct stat *st)
 			return -1;
 		return 1;
 	}
-	if (has_symlink_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_leading_path(ce->name, ce_namelen(ce)))
 		return 1;
 	if (S_ISDIR(st->st_mode)) {
 		unsigned char sub[20];
diff --git a/dir.c b/dir.c
index cfd1ea5..8fb5226 100644
--- a/dir.c
+++ b/dir.c
@@ -720,7 +720,7 @@ int read_directory(struct dir_struct *dir, const char *path, const char *base, i
 {
 	struct path_simplify *simplify;
 
-	if (has_symlink_leading_path(strlen(path), path))
+	if (has_symlink_leading_path(path, strlen(path)))
 		return dir->nr;
 
 	simplify = create_simplify(pathspec);
diff --git a/entry.c b/entry.c
index 05aa58d..bb6bdb9 100644
--- a/entry.c
+++ b/entry.c
@@ -20,7 +20,7 @@ static void create_directories(const char *path, const struct checkout *state)
 		 * we test the path components of the prefix with the
 		 * stat() function instead of the lstat() function.
 		 */
-		if (has_dirs_only_path(len, buf, state->base_dir_len))
+		if (has_dirs_only_path(buf, len, state->base_dir_len))
 			continue; /* ok, it is already a directory. */
 
 		/*
diff --git a/symlinks.c b/symlinks.c
index 4596aee..5167286 100644
--- a/symlinks.c
+++ b/symlinks.c
@@ -70,7 +70,7 @@ static inline void reset_lstat_cache(void)
  * of the prefix, where the cache should use the stat() function
  * instead of the lstat() function to test each path component.
  */
-static int lstat_cache(int len, const char *name,
+static int lstat_cache(const char *name, int len,
 		       int track_flags, int prefix_len_stat_func)
 {
 	int match_len, last_slash, last_slash_dir, previous_slash;
@@ -185,7 +185,7 @@ static int lstat_cache(int len, const char *name,
  * Invalidate the given 'name' from the cache, if 'name' matches
  * completely with the cache.
  */
-void invalidate_lstat_cache(int len, const char *name)
+void invalidate_lstat_cache(const char *name, int len)
 {
 	int match_len, previous_slash;
 
@@ -214,9 +214,9 @@ void clear_lstat_cache(void)
 /*
  * Return non-zero if path 'name' has a leading symlink component
  */
-int has_symlink_leading_path(int len, const char *name)
+int has_symlink_leading_path(const char *name, int len)
 {
-	return lstat_cache(len, name,
+	return lstat_cache(name, len,
 			   FL_SYMLINK|FL_DIR, USE_ONLY_LSTAT) &
 		FL_SYMLINK;
 }
@@ -225,9 +225,9 @@ int has_symlink_leading_path(int len, const char *name)
  * Return non-zero if path 'name' has a leading symlink component or
  * if some leading path component does not exists.
  */
-int has_symlink_or_noent_leading_path(int len, const char *name)
+int has_symlink_or_noent_leading_path(const char *name, int len)
 {
-	return lstat_cache(len, name,
+	return lstat_cache(name, len,
 			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT) &
 		(FL_SYMLINK|FL_NOENT);
 }
@@ -239,9 +239,9 @@ int has_symlink_or_noent_leading_path(int len, const char *name)
  * 'prefix_len', thus we then allow for symlinks in the prefix part as
  * long as those points to real existing directories.
  */
-int has_dirs_only_path(int len, const char *name, int prefix_len)
+int has_dirs_only_path(const char *name, int len, int prefix_len)
 {
-	return lstat_cache(len, name,
+	return lstat_cache(name, len,
 			   FL_DIR|FL_FULLPATH, prefix_len) &
 		FL_DIR;
 }
diff --git a/unpack-trees.c b/unpack-trees.c
index e547282..2293158 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -61,7 +61,7 @@ static void unlink_entry(struct cache_entry *ce)
 	char *cp, *prev;
 	char *name = ce->name;
 
-	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
 		return;
 	if (unlink(name))
 		return;
@@ -583,7 +583,7 @@ static int verify_absent(struct cache_entry *ce, const char *action,
 	if (o->index_only || o->reset || !o->update)
 		return 0;
 
-	if (has_symlink_or_noent_leading_path(ce_namelen(ce), ce->name))
+	if (has_symlink_or_noent_leading_path(ce->name, ce_namelen(ce)))
 		return 0;
 
 	if (!lstat(ce->name, &st)) {
-- 
1.6.1.349.g99fa5
