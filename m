From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v3 12/19] dir.c: keep track of where patterns came from
Date: Thu, 27 Dec 2012 02:32:31 +0000
Message-ID: <1356575558-2674-13-git-send-email-git@adamspiers.org>
References: <1356575558-2674-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 27 03:33:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1To3Hi-0006Tl-Fs
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 03:33:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497Ab2L0Ccy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Dec 2012 21:32:54 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:53767 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751852Ab2L0Ccu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Dec 2012 21:32:50 -0500
Received: from localhost (host-2-103-56-128.as13285.net [2.103.56.128])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 355002E5E4
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 02:32:49 +0000 (GMT)
X-Mailer: git-send-email 1.7.11.2.249.g31c7954
In-Reply-To: <1356575558-2674-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212174>

For exclude patterns read in from files, the filename is stored in the
exclude list, and the originating line number is stored in the
individual exclude (counting starting at 1).

For exclude patterns provided on the command line, a string describing
the source of the patterns is stored in the exclude list, and the
sequence number assigned to each exclude pattern is negative, with
counting starting at -1.  So for example the 2nd pattern provided via
--exclude would be numbered -2.  This allows any future consumers of
that data to easily distinguish between exclude patterns from files
vs. from the CLI.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/clean.c    |  4 ++--
 builtin/ls-files.c |  5 +++--
 dir.c              | 26 ++++++++++++++++++++------
 dir.h              | 21 +++++++++++++++++++--
 4 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index bd18b88..72d2876 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -97,10 +97,10 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	add_exclude_list(&dir, EXC_CMDL);
+	add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++)
 		add_exclude(exclude_list.items[i].string, "", 0,
-			    &dir.exclude_list_groups[EXC_CMDL].ary[0]);
+			    &dir.exclude_list_groups[EXC_CMDL].ary[0], -(i+1));
 
 	pathspec = get_pathspec(prefix, argv);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c448e06..d4e55c2 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -35,6 +35,7 @@ static int error_unmatch;
 static char *ps_matched;
 static const char *with_tree;
 static int exc_given;
+static int exclude_args;
 
 static const char *tag_cached = "";
 static const char *tag_unmerged = "";
@@ -423,7 +424,7 @@ static int option_parse_exclude(const struct option *opt,
 	struct exclude_list_group *group = opt->value;
 
 	exc_given = 1;
-	add_exclude(arg, "", 0, &group->ary[0]);
+	add_exclude(arg, "", 0, &group->ary[0], --exclude_args);
 
 	return 0;
 }
@@ -524,7 +525,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	add_exclude_list(&dir, EXC_CMDL);
+	add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
 	if (show_tag || show_valid_bit) {
diff --git a/dir.c b/dir.c
index 3a9d89b..aefe2bb 100644
--- a/dir.c
+++ b/dir.c
@@ -349,7 +349,7 @@ void parse_exclude_pattern(const char **pattern,
 }
 
 void add_exclude(const char *string, const char *base,
-		 int baselen, struct exclude_list *el)
+		 int baselen, struct exclude_list *el, int srcpos)
 {
 	struct exclude *x;
 	int patternlen;
@@ -373,8 +373,10 @@ void add_exclude(const char *string, const char *base,
 	x->base = base;
 	x->baselen = baselen;
 	x->flags = flags;
+	x->srcpos = srcpos;
 	ALLOC_GROW(el->excludes, el->nr + 1, el->alloc);
 	el->excludes[el->nr++] = x;
+	x->el = el;
 }
 
 static void *read_skip_worktree_file_from_index(const char *path, size_t *size)
@@ -425,7 +427,7 @@ int add_excludes_from_file_to_list(const char *fname,
 				   int check_index)
 {
 	struct stat st;
-	int fd, i;
+	int fd, i, lineno = 1;
 	size_t size = 0;
 	char *buf, *entry;
 
@@ -467,15 +469,17 @@ int add_excludes_from_file_to_list(const char *fname,
 		if (buf[i] == '\n') {
 			if (entry != buf + i && entry[0] != '#') {
 				buf[i - (i && buf[i-1] == '\r')] = 0;
-				add_exclude(entry, base, baselen, el);
+				add_exclude(entry, base, baselen, el, lineno);
 			}
+			lineno++;
 			entry = buf + i + 1;
 		}
 	}
 	return 0;
 }
 
-struct exclude_list *add_exclude_list(struct dir_struct *dir, int group_type)
+struct exclude_list *add_exclude_list(struct dir_struct *dir,
+				      int group_type, const char *src)
 {
 	struct exclude_list *el;
 	struct exclude_list_group *group;
@@ -484,6 +488,7 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir, int group_type)
 	ALLOC_GROW(group->ary, group->nr + 1, group->alloc);
 	el = &group->ary[group->nr++];
 	memset(el, 0, sizeof(*el));
+	el->src = src;
 	return el;
 }
 
@@ -493,7 +498,7 @@ struct exclude_list *add_exclude_list(struct dir_struct *dir, int group_type)
 void add_excludes_from_file(struct dir_struct *dir, const char *fname)
 {
 	struct exclude_list *el;
-	el = add_exclude_list(dir, EXC_FILE);
+	el = add_exclude_list(dir, EXC_FILE, fname);
 	if (add_excludes_from_file_to_list(fname, "", 0, el, 0) < 0)
 		die("cannot use %s as an exclude file", fname);
 }
@@ -522,6 +527,7 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 			break;
 		el = &group->ary[dir->exclude_stack->exclude_ix];
 		dir->exclude_stack = stk->prev;
+		free((char *)el->src); /* see strdup() below */
 		clear_exclude_list(el);
 		free(stk);
 		group->nr--;
@@ -548,7 +554,15 @@ static void prep_exclude(struct dir_struct *dir, const char *base, int baselen)
 		memcpy(dir->basebuf + current, base + current,
 		       stk->baselen - current);
 		strcpy(dir->basebuf + stk->baselen, dir->exclude_per_dir);
-		el = add_exclude_list(dir, EXC_DIRS);
+		/*
+		 * dir->basebuf gets reused by the traversal, but we
+		 * need fname to remain unchanged to ensure the src
+		 * member of each struct exclude correctly
+		 * back-references its source file.  Other invocations
+		 * of add_exclude_list provide stable strings, so we
+		 * strdup() and free() here in the caller.
+		 */
+		el = add_exclude_list(dir, EXC_DIRS, strdup(dir->basebuf));
 		stk->exclude_ix = group->nr - 1;
 		add_excludes_from_file_to_list(dir->basebuf,
 					       dir->basebuf, stk->baselen,
diff --git a/dir.h b/dir.h
index 9408fbe..f91770a 100644
--- a/dir.h
+++ b/dir.h
@@ -25,16 +25,32 @@ struct dir_entry {
 struct exclude_list {
 	int nr;
 	int alloc;
+
 	/* remember pointer to exclude file contents so we can free() */
 	char *filebuf;
 
+	/* origin of list, e.g. path to filename, or descriptive string */
+	const char *src;
+
 	struct exclude {
+		/*
+		 * This allows callers of last_exclude_matching() etc.
+		 * to determine the origin of the matching pattern.
+		 */
+		struct exclude_list *el;
+
 		const char *pattern;
 		int patternlen;
 		int nowildcardlen;
 		const char *base;
 		int baselen;
 		int flags;
+
+		/*
+		 * Counting starts from 1 for line numbers in ignore files,
+		 * and from -1 decrementing for patterns from CLI args.
+		 */
+		int srcpos;
 	} **excludes;
 };
 
@@ -144,13 +160,14 @@ extern struct exclude *last_exclude_matching_path(struct path_exclude_check *, c
 extern int is_path_excluded(struct path_exclude_check *, const char *, int namelen, int *dtype);
 
 
-extern struct exclude_list *add_exclude_list(struct dir_struct *dir, int group_type);
+extern struct exclude_list *add_exclude_list(struct dir_struct *dir,
+					     int group_type, const char *src);
 extern int add_excludes_from_file_to_list(const char *fname, const char *base, int baselen,
 					  struct exclude_list *el, int check_index);
 extern void add_excludes_from_file(struct dir_struct *, const char *fname);
 extern void parse_exclude_pattern(const char **string, int *patternlen, int *flags, int *nowildcardlen);
 extern void add_exclude(const char *string, const char *base,
-			int baselen, struct exclude_list *el);
+			int baselen, struct exclude_list *el, int srcpos);
 extern void clear_exclude_list(struct exclude_list *el);
 extern int file_exists(const char *);
 
-- 
1.7.11.2.249.g31c7954
