From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v4 01/11] dir.c: use a single struct exclude_list per source of excludes
Date: Sun,  6 Jan 2013 16:58:03 +0000
Message-ID: <1357491493-11619-2-git-send-email-git@adamspiers.org>
References: <20130106161758.GC2396@pacific.linksys.moosehall>
 <1357491493-11619-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 17:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrtYs-0008A9-1M
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 17:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab3AFQ6V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 11:58:21 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:45592 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756069Ab3AFQ6R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 11:58:17 -0500
Received: from localhost (f.4.d.7.f.d.e.f.f.f.3.7.3.0.a.1.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:1a03:73ff:fedf:7d4f])
	by coral.adamspiers.org (Postfix) with ESMTPSA id E97FE2E5DE
	for <git@vger.kernel.org>; Sun,  6 Jan 2013 16:58:14 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.7.33.gb8feba5
In-Reply-To: <1357491493-11619-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212820>

Previously each exclude_list could potentially contain patterns
from multiple sources.  For example dir->exclude_list[EXC_FILE]
would typically contain patterns from .git/info/exclude and
core.excludesfile, and dir->exclude_list[EXC_DIRS] could contain
patterns from multiple per-directory .gitignore files during
directory traversal (i.e. when dir->exclude_stack was more than
one item deep).

We split these composite exclude_lists up into three groups of
exclude_lists (EXC_CMDL / EXC_DIRS / EXC_FILE as before), so that each
exclude_list now contains patterns from a single source.  This will
allow us to cleanly track the origin of each pattern simply by adding
a src field to struct exclude_list, rather than to struct exclude,
which would make memory management of the source string tricky in the
EXC_DIRS case where its contents are dynamically generated.

Similarly, by moving the filebuf member from struct exclude_stack to
struct exclude_list, it allows us to track and subsequently free
memory buffers allocated during the parsing of all exclude files,
rather than only tracking buffers allocated for files in the EXC_DIRS
group.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 Documentation/technical/api-directory-listing.txt | 12 +++--
 builtin/clean.c                                   |  3 +-
 builtin/ls-files.c                                |  8 +--
 dir.c                                             | 64 ++++++++++++++++-------
 dir.h                                             | 36 +++++++++----
 unpack-trees.c                                    |  2 +-
 6 files changed, 86 insertions(+), 39 deletions(-)

diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 944fc39..fa9c8ae 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -67,11 +67,13 @@ marked. If you to exclude files, make sure you have loaded index first.
 * Prepare `struct dir_struct dir` and clear it with `memset(&dir, 0,
   sizeof(dir))`.
 
-* Call `add_exclude()` to add single exclude pattern,
-  `add_excludes_from_file()` to add patterns from a file
-  (e.g. `.git/info/exclude`), and/or set `dir.exclude_per_dir`.  A
-  short-hand function `setup_standard_excludes()` can be used to set up
-  the standard set of exclude settings.
+* To add single exclude pattern, call `add_exclude_list()` and then
+  `add_exclude()`.
+
+* To add patterns from a file (e.g. `.git/info/exclude`), call
+  `add_excludes_from_file()` , and/or set `dir.exclude_per_dir`.  A
+  short-hand function `setup_standard_excludes()` can be used to set
+  up the standard set of exclude settings.
 
 * Set options described in the Data Structure section above.
 
diff --git a/builtin/clean.c b/builtin/clean.c
index 0c7b3d0..dd89737 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -97,9 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
+	add_exclude_list(&dir, EXC_CMDL);
 	for (i = 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0,
-			    &dir.exclude_list[EXC_CMDL]);
+			    &dir.exclude_list_group[EXC_CMDL].el[0]);
 
 	pathspec = get_pathspec(prefix, argv);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index ef7f99a..0ca9d8e 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -420,10 +420,10 @@ static int option_parse_z(const struct option *opt,
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
-	struct exclude_list *list = opt->value;
+	struct exclude_list_group *group = opt->value;
 
 	exc_given = 1;
-	add_exclude(arg, "", 0, list);
+	add_exclude(arg, "", 0, &group->el[0]);
 
 	return 0;
 }
@@ -488,7 +488,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 			"show unmerged files in the output"),
 		OPT_BOOLEAN(0, "resolve-undo", &show_resolve_undo,
 			    "show resolve-undo information"),
-		{ OPTION_CALLBACK, 'x', "exclude", &dir.exclude_list[EXC_CMDL], "pattern",
+		{ OPTION_CALLBACK, 'x', "exclude",
+			&dir.exclude_list_group[EXC_CMDL], "pattern",
 			"skip files matching pattern",
 			0, option_parse_exclude },
 		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, "file",
@@ -523,6 +524,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
+	add_exclude_list(&dir, EXC_CMDL);
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
diff --git a/dir.c b/dir.c
index 41f141c..3a15cb9 100644
--- a/dir.c
+++ b/dir.c
@@ -411,15 +411,16 @@ void clear_exclude_list(struct exclude_list *el)
 	for (i = 0; i < el->nr; i++)
 		free(el->excludes[i]);
 	free(el->excludes);
+	free(el->filebuf);
 
 	el->nr = 0;
 	el->excludes = NULL;
+	el->filebuf = NULL;
 }
 
 int add_excludes_from_file_to_list(const char *fname,
 				   const char *base,
 				   int baselen,
-				   char **buf_p,
 				   struct exclude_list *el,
 				   int check_index)
 {
@@ -460,8 +461,7 @@ int add_excludes_from_file_to_list(const char *fname,
 		close(fd);
 	}
 
-	if (buf_p)
-		*buf_p = buf;
+	el->filebuf = buf;
 	entry = buf;
 	for (i = 0; i < size; i++) {
 		if (buf[i] == '\n') {
@@ -475,10 +475,26 @@ int add_excludes_from_file_to_list(const char *fname,
 	return 0;
 }
 
+struct exclude_list *add_exclude_list(struct dir_struct *dir, int group_type)
+{
+	struct exclude_list *el;
+	struct exclude_list_group *group;
+
+	group = &dir->exclude_list_group[group_type];
+	ALLOC_GROW(group->el, group->nr + 1, group->alloc);
+	el = &group->el[group->nr++];
+	memset(el, 0, sizeof(*el));
+	return el;
+}
+
+/*
+ * Used to set up core.excludesfile and .git/info/exclude lists.
+ */
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
-	if (add_excludes_from_file_to_list(fname, "", 0, NULL,
-					   &dir->exclude_list[EXC_FILE], 0) < 0)
+	struct exclude_list *el;
+	el = add_exclude_list(dir, EXC_FILE);
+	if (add_excludes_from_file_to_list(fname, "", 0, el, 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
 
@@ -488,6 +504,7 @@ void add_excludes_from_file(struct dir_struct *dir, const char *fname)
  */
 static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 {
+	struct exclude_list_group *group;
 	struct exclude_list *el;
 	struct exclude_stack *stk = NULL;
 	int current;
@@ -496,17 +513,20 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 	    (baselen + strlen(dir->exclude_per_dir) >= PATH_MAX))
 		return; /* too long a path -- ignore */
 
-	/* Pop the directories that are not the prefix of the path being checked. */
-	el = &dir->exclude_list[EXC_DIRS];
+	group = &dir->exclude_list_group[EXC_DIRS];
+
+	/* Pop the exclude lists from the EXCL_DIRS exclude_list_group
+	 * which originate from directories not in the prefix of the
+	 * path being checked. */
 	while ((stk = dir->exclude_stack) != NULL) {
 		if (stk->baselen <= baselen &&
 		    !strncmp(dir->basebuf, base, stk->baselen))
 			break;
+		el = &group->el[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack = stk->prev;
-		while (stk->exclude_ix < el->nr)
-			free(el->excludes[--el->nr]);
-		free(stk->filebuf);
+		clear_exclude_list(el);
 		free(stk);
+		group->nr--;
 	}
 
 	/* Read from the parent directories and push them down. */
@@ -527,13 +547,14 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		}
 		stk->prev = dir->exclude_stack;
 		stk->baselen = cp - base;
-		stk->exclude_ix = el->nr;
 		memcpy(dir->basebuf + current, base + current,
 		       stk->baselen - current);
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
+		el = add_exclude_list(dir, EXC_DIRS);
+		stk->exclude_ix = group->nr - 1;
 		add_excludes_from_file_to_list(dir->basebuf,
 					       dir->basebuf, stk->baselen,
-					       &stk->filebuf, el, 1);
+					       el, 1);
 		dir->exclude_stack = stk;
 		current = stk->baselen;
 	}
@@ -679,18 +700,23 @@ static struct exclude *last_exclude_matching(struct dir_struct *dir,
 					     int *dtype_p)
 {
 	int pathlen = strlen(pathname);
-	int st;
+	int i, j;
+	struct exclude_list_group *group;
 	struct exclude *exclude;
 	const char *basename = strrchr(pathname, '/');
 	basename = (basename) ? basename+1 : pathname;
 
 	prep_exclude(dir, pathname, basename-pathname);
-	for (st = EXC_CMDL; st <= EXC_FILE; st++) {
-		exclude = last_exclude_matching_from_list(
-			pathname, pathlen, basename, dtype_p,
-			&dir->exclude_list[st]);
-		if (exclude)
-			return exclude;
+
+	for (i = EXC_CMDL; i <= EXC_FILE; i++) {
+		group = &dir->exclude_list_group[i];
+		for (j = group->nr - 1; j >= 0; j--) {
+			exclude = last_exclude_matching_from_list(
+				pathname, pathlen, basename, dtype_p,
+				&group->el[j]);
+			if (exclude)
+				return exclude;
+		}
 	}
 	return NULL;
 }
diff --git a/dir.h b/dir.h
index 5664ba8..c4d88db 100644
--- a/dir.h
+++ b/dir.h
@@ -16,14 +16,18 @@ struct dir_entry {
 #define EXC_FLAG_NEGATIVE 16
 
 /*
- * Each .gitignore file will be parsed into patterns which are then
- * appended to the relevant exclude_list (either EXC_DIRS or
- * EXC_FILE).  exclude_lists are also used to represent the list of
- * --exclude values passed via CLI args (EXC_CMDL).
+ * Each excludes file will be parsed into a fresh exclude_list which
+ * is appended to the relevant exclude_list_group (either EXC_DIRS or
+ * EXC_FILE).  An exclude_list within the EXC_CMDL exclude_list_group
+ * can also be used to represent the list of --exclude values passed
+ * via CLI args.
  */
 struct exclude_list {
 	int nr;
 	int alloc;
+	/* remember pointer to exclude file contents so we can free() */
+	char *filebuf;
+
 	struct exclude {
 		const char *pattern;
 		int patternlen;
@@ -42,9 +46,13 @@ struct exclude_list {
  */
 struct exclude_stack {
 	struct exclude_stack *prev; /* the struct exclude_stack for the parent directory */
-	char *filebuf; /* remember pointer to per-directory exclude file contents so we can free() */
 	int baselen;
-	int exclude_ix;
+	int exclude_ix; /* index of exclude_list within EXC_DIRS exclude_list_group */
+};
+
+struct exclude_list_group {
+	int nr, alloc;
+	struct exclude_list *el;
 };
 
 struct dir_struct {
@@ -62,16 +70,23 @@ struct dir_struct {
 
 	/* Exclude info */
 	const char *exclude_per_dir;
-	struct exclude_list exclude_list[3];
+
 	/*
-	 * We maintain three exclude pattern lists:
+	 * We maintain three groups of exclude pattern lists:
+	 *
 	 * EXC_CMDL lists patterns explicitly given on the command line.
 	 * EXC_DIRS lists patterns obtained from per-directory ignore files.
-	 * EXC_FILE lists patterns from fallback ignore files.
+	 * EXC_FILE lists patterns from fallback ignore files, e.g.
+	 *   - .git/info/exclude
+	 *   - core.excludesfile
+	 *
+	 * Each group contains multiple exclude lists, a single list
+	 * per source.
 	 */
 #define EXC_CMDL 0
 #define EXC_DIRS 1
 #define EXC_FILE 2
+	struct exclude_list_group exclude_list_group[3];
 
 	/*
 	 * Temporary variables which are used during loading of the
@@ -129,8 +144,9 @@ extern struct exclude *last_exclude_matching_path(struct path_exclude_check *, c
 extern int is_path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
 
 
+extern struct exclude_list *add_exclude_list(struct dir_struct *dir, int group_type);
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
-					  char **buf_p, struct exclude_list *el, int check_index);
+					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void parse_exclude_pattern(const char **string, int *patternlen, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
diff --git a/unpack-trees.c b/unpack-trees.c
index ad621d9..de8da46 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1019,7 +1019,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	if (!core_apply_sparse_checkout || !o->update)
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
-		if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"), "", 0, NULL, &el, 0) < 0)
+		if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"), "", 0, &el, 0) < 0)
 			o->skip_sparse_checkout = 1;
 		else
 			o->el = &el;
-- 
1.7.11.7.33.gb8feba5
