From: Albert Yale <surfingalbert@gmail.com>
Subject: [PATCH/RFC v4] grep: Add the option '--exclude'
Date: Thu,  2 Feb 2012 09:25:53 -0500
Message-ID: <1328192753-29162-1-git-send-email-surfingalbert@gmail.com>
Cc: gitster@pobox.com, pclouds@gmail.com,
	Albert Yale <surfingalbert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 15:26:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rsxc5-0001fG-MF
	for gcvg-git-2@plane.gmane.org; Thu, 02 Feb 2012 15:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756200Ab2BBO0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Feb 2012 09:26:08 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:59091 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755960Ab2BBO0G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2012 09:26:06 -0500
Received: by qafk1 with SMTP id k1so1600645qaf.19
        for <git@vger.kernel.org>; Thu, 02 Feb 2012 06:26:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+f9UazgXLNmy4tMq7svKKhe7E3JaGZXpWratFSK7GTA=;
        b=JouEKC4xWpbJ8vCq0Kmu6M5LalhYK5/KKzNwlrzidKZLABgNPaTScNgN2xT5BgqlLB
         P/UlpJjjWaCz1F3cON+q4aRqox6z+6sIZU89/IZ7tgJMCKEy3fMLbNNQLxx3tZ9GaZO4
         7pPk84PgxXFDWaNj/8beFE8n+PB3HVD/WW4V8=
Received: by 10.224.31.147 with SMTP id y19mr1697088qac.61.1328192761354;
        Thu, 02 Feb 2012 06:26:01 -0800 (PST)
Received: from f.uze.ca.uze.ca (modemcable104.125-21-96.mc.videotron.ca. [96.21.125.104])
        by mx.google.com with ESMTPS id ft9sm5825644qab.20.2012.02.02.06.25.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 02 Feb 2012 06:26:00 -0800 (PST)
X-Mailer: git-send-email 1.7.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189645>

grep: Add the option '--exclude'

Signed-off-by: Albert Yale <surfingalbert@gmail.com>
---
hi Junio,

You're correct that adding an extra parameter to
match_pathspec_depth() was unnecessary.

I added a "struct pathspec_set" as you suggested
in your previous review. It had the side effect
of forcing me to update a few more files than was
previously necessary.

I understand that you want to keep the internals
of a pathspec hidden from its users as much as
possible. But if someone is already accessing its
internals, I don't think it's a problem to change
their usage, for example, from "ps->nr" to
"ps->include.nr". Please correct me if I'm wrong.

There's one thing I did differently. You suggested
moving "recursive" into "struct pathspec_set". I
kept it in "struct pathspec" because it's usually
modified alongside "max_depth".

btw, the last two parameters of
match_pathspec_depth(), namely "prefix" and
"seen", are not used anywhere. I understand their
potential usefulness, but I wanted to point this
out in case you want to further simplify calls to
this function.

Looking forward to your feedback,

Albert Yale

 Documentation/git-grep.txt |    5 ++
 builtin/diff.c             |    6 +-
 builtin/fast-export.c      |    2 +-
 builtin/grep.c             |   31 +++++++++++++-
 builtin/log.c              |    2 +-
 builtin/ls-files.c         |    2 +-
 builtin/ls-tree.c          |    6 +-
 cache.h                    |   15 +++++--
 dir.c                      |  100 +++++++++++++++++++++++++++++++++++---------
 list-objects.c             |    2 +-
 revision.c                 |    4 +-
 tree-diff.c                |    2 +-
 tree-walk.c                |    8 ++--
 13 files changed, 143 insertions(+), 42 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6a8b1e3..b45706a 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	   [--color[=<when>] | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
+	   [-x <pattern>|--exclude <pattern>]
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [ [--exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
@@ -124,6 +125,10 @@ OPTIONS
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
+-x <pattern>::
+--exclude <pattern>::
+	Skip files matching pattern.
+
 -n::
 --line-number::
 	Prefix the line number to matching lines.
diff --git a/builtin/diff.c b/builtin/diff.c
index 387afa7..e910f80 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -365,10 +365,10 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		}
 		die(_("unhandled object '%s' given."), name);
 	}
-	if (rev.prune_data.nr) {
+	if (rev.prune_data.include.nr) {
 		if (!path)
-			path = rev.prune_data.items[0].match;
-		paths += rev.prune_data.nr;
+			path = rev.prune_data.include.items[0].match;
+		paths += rev.prune_data.include.nr;
 	}
 
 	/*
diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 08fed98..23043a2 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -674,7 +674,7 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	if (import_filename)
 		import_marks(import_filename);
 
-	if (import_filename && revs.prune_data.nr)
+	if (import_filename && revs.prune_data.include.nr)
 		full_tree = 1;
 
 	get_tags_and_duplicates(&revs.pending, &extra_refs);
diff --git a/builtin/grep.c b/builtin/grep.c
index 5c2ae94..19d1afd 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -566,6 +566,10 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
 
+		if (!match_pathspec_depth(pathspec,
+					  entry.path, strlen(entry.path),
+					  0, NULL))
+			continue;
 		if (match != all_entries_interesting) {
 			match = tree_entry_interesting(&entry, base, tn_len, pathspec);
 			if (match == all_entries_not_interesting)
@@ -606,8 +610,16 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name)
 {
-	if (obj->type == OBJ_BLOB)
+	if (obj->type == OBJ_BLOB) {
+		const char *name_without_sha1 = strchr(name, ':') + 1;
+		if (!match_pathspec_depth(pathspec,
+					  name_without_sha1,
+					  strlen(name_without_sha1),
+					  0, NULL))
+			return 0;
+
 		return grep_sha1(opt, obj->sha1, name, 0);
+	}
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -764,6 +776,14 @@ static int pattern_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int exclude_cb(const struct option *opt, const char *arg,
+		      int unset)
+{
+	struct string_list *exclude_list = opt->value;
+	string_list_append(exclude_list, arg);
+	return 0;
+}
+
 static int help_callback(const struct option *opt, const char *arg, int unset)
 {
 	return -1;
@@ -792,6 +812,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		pattern_type_pcre,
 	};
 	int pattern_type = pattern_type_unspecified;
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
@@ -872,6 +893,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"read patterns from file", file_callback),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
 			"match <pattern>", PARSE_OPT_NONEG, pattern_callback },
+		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, "pattern",
+		  "add <pattern> to ignore rules", PARSE_OPT_NONEG, exclude_cb },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
 		  "combine patterns specified with -e",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
@@ -1054,6 +1077,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 
+	if (exclude_list.nr) {
+		init_pathspec_exclude_from_string_list(&pathspec, &exclude_list);
+	}
+
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
@@ -1103,5 +1130,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
+	free_pathspec(&pathspec);
+	string_list_clear(&exclude_list, 0);
 	return !hit;
 }
diff --git a/builtin/log.c b/builtin/log.c
index 7d1f6f8..c837616 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -125,7 +125,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
 		rev->always_show_header = 0;
-		if (rev->diffopt.pathspec.nr != 1)
+		if (rev->diffopt.pathspec.include.nr != 1)
 			usage("git logs can only follow renames on one pathname at a time");
 	}
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index 7cff175..8cae770 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -326,7 +326,7 @@ void overlay_tree_on_cache(const char *tree_name, const char *prefix)
 		matchbuf[0] = prefix;
 		matchbuf[1] = NULL;
 		init_pathspec(&pathspec, matchbuf);
-		pathspec.items[0].use_wildcard = 0;
+		pathspec.include.items[0].use_wildcard = 0;
 	} else
 		init_pathspec(&pathspec, NULL);
 	if (read_tree(tree, 1, &pathspec))
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 6b666e1..651169c 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -167,9 +167,9 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 		die("Not a valid object name %s", argv[0]);
 
 	init_pathspec(&pathspec, get_pathspec(prefix, argv + 1));
-	for (i = 0; i < pathspec.nr; i++)
-		pathspec.items[i].use_wildcard = 0;
-	pathspec.has_wildcard = 0;
+	for (i = 0; i < pathspec.include.nr; i++)
+		pathspec.include.items[i].use_wildcard = 0;
+	pathspec.include.has_wildcard = 0;
 	tree = parse_tree_indirect(sha1);
 	if (!tree)
 		die("not a tree object");
diff --git a/cache.h b/cache.h
index 9bd8c2d..ea70b92 100644
--- a/cache.h
+++ b/cache.h
@@ -522,12 +522,9 @@ extern int index_name_is_other(const struct index_state *, const char *, int);
 extern int ie_match_stat(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 extern int ie_modified(const struct index_state *, struct cache_entry *, struct stat *, unsigned int);
 
-struct pathspec {
-	const char **raw; /* get_pathspec() result, not freed by free_pathspec() */
+struct pathspec_set {
 	int nr;
 	unsigned int has_wildcard:1;
-	unsigned int recursive:1;
-	int max_depth;
 	struct pathspec_item {
 		const char *match;
 		int len;
@@ -535,7 +532,17 @@ struct pathspec {
 	} *items;
 };
 
+struct pathspec {
+	const char **raw; /* get_pathspec() result, not freed by free_pathspec() */
+	unsigned int recursive:1;
+	int max_depth;
+
+	struct pathspec_set include;
+	struct pathspec_set exclude;
+};
+
 extern int init_pathspec(struct pathspec *, const char **);
+extern int init_pathspec_exclude_from_string_list(struct pathspec *, const struct string_list *);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec);
 
diff --git a/dir.c b/dir.c
index 0a78d00..faf2db3 100644
--- a/dir.c
+++ b/dir.c
@@ -9,6 +9,8 @@
 #include "dir.h"
 #include "refs.h"
 
+#include "string-list.h"
+
 struct path_simplify {
 	int len;
 	const char *path;
@@ -251,17 +253,18 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
  * and a mark is left in seen[] array for pathspec element that
  * actually matched anything.
  */
-int match_pathspec_depth(const struct pathspec *ps,
-			 const char *name, int namelen,
-			 int prefix, char *seen)
+static int match_pathspec_set_depth(const struct pathspec_set *ps,
+				    unsigned int recursive, int max_depth,
+				    const char *name, int namelen,
+				    int prefix, char *seen)
 {
 	int i, retval = 0;
 
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth == -1)
+		if (!recursive || max_depth == -1)
 			return MATCHED_RECURSIVELY;
 
-		if (within_depth(name, namelen, 0, ps->max_depth))
+		if (within_depth(name, namelen, 0, max_depth))
 			return MATCHED_EXACTLY;
 		else
 			return 0;
@@ -275,12 +278,12 @@ int match_pathspec_depth(const struct pathspec *ps,
 		if (seen && seen[i] == MATCHED_EXACTLY)
 			continue;
 		how = match_pathspec_item(ps->items+i, prefix, name, namelen);
-		if (ps->recursive && ps->max_depth != -1 &&
+		if (recursive && max_depth != -1 &&
 		    how && how != MATCHED_FNMATCH) {
 			int len = ps->items[i].len;
 			if (name[len] == '/')
 				len++;
-			if (within_depth(name+len, namelen-len, 0, ps->max_depth))
+			if (within_depth(name+len, namelen-len, 0, max_depth))
 				how = MATCHED_EXACTLY;
 			else
 				how = 0;
@@ -295,6 +298,25 @@ int match_pathspec_depth(const struct pathspec *ps,
 	return retval;
 }
 
+int match_pathspec_depth(const struct pathspec *ps,
+			 const char *name, int namelen,
+			 int prefix, char *seen)
+{
+	int retval = match_pathspec_set_depth(&ps->include,
+					      ps->recursive, ps->max_depth,
+					      name, namelen, prefix, seen);
+
+	if (retval && ps->exclude.nr)
+	{
+		if (match_pathspec_set_depth(&ps->exclude,
+					     ps->recursive, ps->max_depth,
+					     name, namelen, prefix, seen))
+			return 0;
+	}
+
+	return retval;
+}
+
 static int no_wildcard(const char *string)
 {
 	return string[strcspn(string, "*?[{\\")] == '\0';
@@ -1259,9 +1281,44 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 	return strcmp(a->match, b->match);
 }
 
+static int init_pathspec_item(struct pathspec_item *item, const char *path)
+{
+	item->match = path;
+	item->len = strlen(path);
+	item->use_wildcard = !no_wildcard(path);
+
+	return item->use_wildcard;
+}
+
+int init_pathspec_exclude_from_string_list(struct pathspec *pathspec,
+					   const struct string_list *path_list)
+{
+	struct pathspec_set *exclude = &pathspec->exclude;
+	int i;
+
+	if (!path_list->nr)
+		return 0;
+
+	exclude->nr = path_list->nr;
+	exclude->items = xcalloc(path_list->nr, sizeof(struct pathspec_item));
+
+	for (i = 0; i < path_list->nr; i++) {
+		struct pathspec_item *item = exclude->items+i;
+		const char *path = path_list->items[i].string;
+
+		exclude->has_wildcard |= init_pathspec_item(item, path);
+	}
+
+	qsort(exclude->items, exclude->nr,
+	      sizeof(struct pathspec_item), pathspec_item_cmp);
+
+	return 0;
+}
+
 int init_pathspec(struct pathspec *pathspec, const char **paths)
 {
 	const char **p = paths;
+	struct pathspec_set *include = &pathspec->include;
 	int i;
 
 	memset(pathspec, 0, sizeof(*pathspec));
@@ -1270,23 +1327,20 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 	while (*p)
 		p++;
 	pathspec->raw = paths;
-	pathspec->nr = p - paths;
-	if (!pathspec->nr)
+
+	include->nr = p - paths;
+	if (!include->nr)
 		return 0;
 
-	pathspec->items = xmalloc(sizeof(struct pathspec_item)*pathspec->nr);
-	for (i = 0; i < pathspec->nr; i++) {
-		struct pathspec_item *item = pathspec->items+i;
+	include->items = xmalloc(sizeof(struct pathspec_item)*include->nr);
+	for (i = 0; i < include->nr; i++) {
+		struct pathspec_item *item = include->items+i;
 		const char *path = paths[i];
 
-		item->match = path;
-		item->len = strlen(path);
-		item->use_wildcard = !no_wildcard(path);
-		if (item->use_wildcard)
-			pathspec->has_wildcard = 1;
+		include->has_wildcard |= init_pathspec_item(item, path);
 	}
 
-	qsort(pathspec->items, pathspec->nr,
+	qsort(include->items, include->nr,
 	      sizeof(struct pathspec_item), pathspec_item_cmp);
 
 	return 0;
@@ -1294,6 +1348,12 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 
 void free_pathspec(struct pathspec *pathspec)
 {
-	free(pathspec->items);
-	pathspec->items = NULL;
+	if (pathspec->include.items) {
+		free(pathspec->include.items);
+		pathspec->include.items = NULL;
+	}
+	if (pathspec->exclude.items) {
+		free(pathspec->exclude.items);
+		pathspec->exclude.items = NULL;
+	}
 }
diff --git a/list-objects.c b/list-objects.c
index 3dd4a96..cdac52d 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -71,7 +71,7 @@ static void process_tree(struct rev_info *revs,
 	struct tree_desc desc;
 	struct name_entry entry;
 	struct name_path me;
-	enum interesting match = revs->diffopt.pathspec.nr == 0 ?
+	enum interesting match = revs->diffopt.pathspec.include.nr == 0 ?
 		all_entries_interesting: entry_not_interesting;
 	int baselen = base->len;
 
diff --git a/revision.c b/revision.c
index c97d834..a516df4 100644
--- a/revision.c
+++ b/revision.c
@@ -389,7 +389,7 @@ static int rev_compare_tree(struct rev_info *revs, struct commit *parent, struct
 		 * tagged commit by specifying both --simplify-by-decoration
 		 * and pathspec.
 		 */
-		if (!revs->prune_data.nr)
+		if (!revs->prune_data.include.nr)
 			return REV_TREE_SAME;
 	}
 
@@ -1835,7 +1835,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	if (revs->topo_order)
 		revs->limited = 1;
 
-	if (revs->prune_data.nr) {
+	if (revs->prune_data.include.nr) {
 		diff_tree_setup_paths(revs->prune_data.raw, &revs->pruning);
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
diff --git a/tree-diff.c b/tree-diff.c
index 28ad6db..43aa00f 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -146,7 +146,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2,
 	for (;;) {
 		if (diff_can_quit_early(opt))
 			break;
-		if (opt->pathspec.nr) {
+		if (opt->pathspec.include.nr) {
 			skip_uninteresting(t1, &base, opt, &t1_match);
 			skip_uninteresting(t2, &base, opt, &t2_match);
 		}
diff --git a/tree-walk.c b/tree-walk.c
index 492c7cd..e95cd6a 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -584,10 +584,10 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 {
 	int i;
 	int pathlen, baselen = base->len - base_offset;
-	int never_interesting = ps->has_wildcard ?
+	int never_interesting = ps->include.has_wildcard ?
 		entry_not_interesting : all_entries_not_interesting;
 
-	if (!ps->nr) {
+	if (!ps->include.nr) {
 		if (!ps->recursive || ps->max_depth == -1)
 			return all_entries_interesting;
 		return within_depth(base->buf + base_offset, baselen,
@@ -598,8 +598,8 @@ enum interesting tree_entry_interesting(const struct name_entry *entry,
 
 	pathlen = tree_entry_len(entry);
 
-	for (i = ps->nr - 1; i >= 0; i--) {
-		const struct pathspec_item *item = ps->items+i;
+	for (i = ps->include.nr - 1; i >= 0; i--) {
+		const struct pathspec_item *item = ps->include.items+i;
 		const char *match = item->match;
 		const char *base_str = base->buf + base_offset;
 		int matchlen = item->len;
-- 
1.7.8.3
