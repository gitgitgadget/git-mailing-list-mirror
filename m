From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/6] add context pointer to read_tree_recursive()
Date: Mon, 14 Jul 2008 21:22:12 +0200
Message-ID: <487BA764.2060003@lsrfire.ath.cx>
References: <487B92FC.5030103@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 14 21:36:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KITqj-0001Bx-Lb
	for gcvg-git-2@gmane.org; Mon, 14 Jul 2008 21:36:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754868AbYGNTfX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2008 15:35:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754865AbYGNTfW
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Jul 2008 15:35:22 -0400
Received: from india601.server4you.de ([85.25.151.105]:45941 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754766AbYGNTfK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2008 15:35:10 -0400
Received: from [10.0.1.200] (p57B7FF09.dip.t-dialin.net [87.183.255.9])
	by india601.server4you.de (Postfix) with ESMTPSA id 0F0A42F81E8;
	Mon, 14 Jul 2008 21:24:17 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <487B92FC.5030103@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88458>

Add a pointer parameter to read_tree_recursive(), which is passed to the
callback function.  This allows callers of read_tree_recursive() to
share data with the callback without resorting to global variables.  All
current callers pass NULL.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 archive-tar.c             |   11 ++++++-----
 archive-zip.c             |   11 ++++++-----
 builtin-checkout.c        |    4 ++--
 builtin-log.c             |    4 ++--
 builtin-ls-tree.c         |    4 ++--
 builtin-merge-recursive.c |    4 ++--
 tree.c                    |   12 ++++++------
 tree.h                    |    4 ++--
 8 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 99db58f..6eaf59e 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -234,9 +234,9 @@ static int git_tar_config(const char *var, const char *value, void *cb)
 	return git_default_config(var, value, cb);
 }
 
-static int write_tar_entry(const unsigned char *sha1,
-                           const char *base, int baselen,
-                           const char *filename, unsigned mode, int stage)
+static int write_tar_entry(const unsigned char *sha1, const char *base,
+		int baselen, const char *filename, unsigned mode, int stage,
+		void *context)
 {
 	static struct strbuf path = STRBUF_INIT;
 	void *buffer;
@@ -286,11 +286,12 @@ int write_tar_archive(struct archiver_args *args)
 
 		while (baselen > 0 && base[baselen - 1] == '/')
 			base[--baselen] = '\0';
-		write_tar_entry(args->tree->object.sha1, "", 0, base, 040777, 0);
+		write_tar_entry(args->tree->object.sha1, "", 0, base, 040777,
+				0, NULL);
 		free(base);
 	}
 	read_tree_recursive(args->tree, args->base, plen, 0,
-			    args->pathspec, write_tar_entry);
+			    args->pathspec, write_tar_entry, NULL);
 	write_trailer();
 
 	return 0;
diff --git a/archive-zip.c b/archive-zip.c
index 5742762..0d24f3f 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -152,9 +152,9 @@ static char *construct_path(const char *base, int baselen,
 	return path;
 }
 
-static int write_zip_entry(const unsigned char *sha1,
-                           const char *base, int baselen,
-                           const char *filename, unsigned mode, int stage)
+static int write_zip_entry(const unsigned char *sha1, const char *base,
+		int baselen, const char *filename, unsigned mode, int stage,
+		void *context)
 {
 	struct zip_local_header header;
 	struct zip_dir_header dirent;
@@ -332,11 +332,12 @@ int write_zip_archive(struct archiver_args *args)
 
 		while (baselen > 0 && base[baselen - 1] == '/')
 			base[--baselen] = '\0';
-		write_zip_entry(args->tree->object.sha1, "", 0, base, 040777, 0);
+		write_zip_entry(args->tree->object.sha1, "", 0, base, 040777,
+				0, NULL);
 		free(base);
 	}
 	read_tree_recursive(args->tree, args->base, plen, 0,
-			    args->pathspec, write_zip_entry);
+			    args->pathspec, write_zip_entry, NULL);
 	write_zip_trailer(args->commit_sha1);
 
 	free(zip_dir);
diff --git a/builtin-checkout.c b/builtin-checkout.c
index d6641c2..a542033 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -43,7 +43,7 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 }
 
 static int update_some(const unsigned char *sha1, const char *base, int baselen,
-		       const char *pathname, unsigned mode, int stage)
+		const char *pathname, unsigned mode, int stage, void * context)
 {
 	int len;
 	struct cache_entry *ce;
@@ -67,7 +67,7 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 
 static int read_tree_some(struct tree *tree, const char **pathspec)
 {
-	read_tree_recursive(tree, "", 0, 0, pathspec, update_some);
+	read_tree_recursive(tree, "", 0, 0, pathspec, update_some, NULL);
 
 	/* update the index with the given tree's info
 	 * for all args, expanding wildcards, and exit
diff --git a/builtin-log.c b/builtin-log.c
index 430d876..617aa67 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -313,7 +313,7 @@ static int show_object(const unsigned char *sha1, int show_tag_object,
 
 static int show_tree_object(const unsigned char *sha1,
 		const char *base, int baselen,
-		const char *pathname, unsigned mode, int stage)
+		const char *pathname, unsigned mode, int stage, void *context)
 {
 	printf("%s%s\n", pathname, S_ISDIR(mode) ? "/" : "");
 	return 0;
@@ -366,7 +366,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			read_tree_recursive((struct tree *)o, "", 0, 0, NULL,
-					show_tree_object);
+					show_tree_object, NULL);
 			break;
 		case OBJ_COMMIT:
 			rev.pending.nr = rev.pending.alloc = 0;
diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index f4a75dd..0da047c 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -56,7 +56,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
 }
 
 static int show_tree(const unsigned char *sha1, const char *base, int baselen,
-		     const char *pathname, unsigned mode, int stage)
+		const char *pathname, unsigned mode, int stage, void *context)
 {
 	int retval = 0;
 	const char *type = blob_type;
@@ -189,7 +189,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
-	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree);
+	read_tree_recursive(tree, "", 0, 0, pathspec, show_tree, NULL);
 
 	return 0;
 }
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 43bf6aa..385e742 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -256,7 +256,7 @@ struct tree *write_tree_from_memory(void)
 
 static int save_files_dirs(const unsigned char *sha1,
 		const char *base, int baselen, const char *path,
-		unsigned int mode, int stage)
+		unsigned int mode, int stage, void *context)
 {
 	int len = strlen(path);
 	char *newpath = xmalloc(baselen + len + 1);
@@ -276,7 +276,7 @@ static int save_files_dirs(const unsigned char *sha1,
 static int get_files_dirs(struct tree *tree)
 {
 	int n;
-	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs) != 0)
+	if (read_tree_recursive(tree, "", 0, 0, NULL, save_files_dirs, NULL))
 		return 0;
 	n = current_file_set.nr + current_directory_set.nr;
 	return n;
diff --git a/tree.c b/tree.c
index 4b1825c..03e782a 100644
--- a/tree.c
+++ b/tree.c
@@ -29,7 +29,7 @@ static int read_one_entry_opt(const unsigned char *sha1, const char *base, int b
 	return add_cache_entry(ce, opt);
 }
 
-static int read_one_entry(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
+static int read_one_entry(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage, void *context)
 {
 	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
 				  ADD_CACHE_OK_TO_ADD|ADD_CACHE_SKIP_DFCHECK);
@@ -39,7 +39,7 @@ static int read_one_entry(const unsigned char *sha1, const char *base, int basel
  * This is used when the caller knows there is no existing entries at
  * the stage that will conflict with the entry being added.
  */
-static int read_one_entry_quick(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage)
+static int read_one_entry_quick(const unsigned char *sha1, const char *base, int baselen, const char *pathname, unsigned mode, int stage, void *context)
 {
 	return read_one_entry_opt(sha1, base, baselen, pathname, mode, stage,
 				  ADD_CACHE_JUST_APPEND);
@@ -92,7 +92,7 @@ static int match_tree_entry(const char *base, int baselen, const char *path, uns
 int read_tree_recursive(struct tree *tree,
 			const char *base, int baselen,
 			int stage, const char **match,
-			read_tree_fn_t fn)
+			read_tree_fn_t fn, void *context)
 {
 	struct tree_desc desc;
 	struct name_entry entry;
@@ -106,7 +106,7 @@ int read_tree_recursive(struct tree *tree,
 		if (!match_tree_entry(base, baselen, entry.path, entry.mode, match))
 			continue;
 
-		switch (fn(entry.sha1, base, baselen, entry.path, entry.mode, stage)) {
+		switch (fn(entry.sha1, base, baselen, entry.path, entry.mode, stage, context)) {
 		case 0:
 			continue;
 		case READ_TREE_RECURSIVE:
@@ -126,7 +126,7 @@ int read_tree_recursive(struct tree *tree,
 			retval = read_tree_recursive(lookup_tree(entry.sha1),
 						     newbase,
 						     baselen + pathlen + 1,
-						     stage, match, fn);
+						     stage, match, fn, context);
 			free(newbase);
 			if (retval)
 				return -1;
@@ -174,7 +174,7 @@ int read_tree(struct tree *tree, int stage, const char **match)
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(tree, "", 0, stage, match, fn);
+	err = read_tree_recursive(tree, "", 0, stage, match, fn, NULL);
 	if (fn == read_one_entry || err)
 		return err;
 
diff --git a/tree.h b/tree.h
index dd25c53..2ff01a4 100644
--- a/tree.h
+++ b/tree.h
@@ -21,12 +21,12 @@ int parse_tree(struct tree *tree);
 struct tree *parse_tree_indirect(const unsigned char *sha1);
 
 #define READ_TREE_RECURSIVE 1
-typedef int (*read_tree_fn_t)(const unsigned char *, const char *, int, const char *, unsigned int, int);
+typedef int (*read_tree_fn_t)(const unsigned char *, const char *, int, const char *, unsigned int, int, void *);
 
 extern int read_tree_recursive(struct tree *tree,
 			       const char *base, int baselen,
 			       int stage, const char **match,
-			       read_tree_fn_t fn);
+			       read_tree_fn_t fn, void *context);
 
 extern int read_tree(struct tree *tree, int stage, const char **paths);
 
-- 
1.5.6.2.212.g08b51
