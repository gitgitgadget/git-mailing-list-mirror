From: Albert Yale <surfingalbert@gmail.com>
Subject: [PATCH/RFC v3] grep: Add the option '--exclude'
Date: Tue, 31 Jan 2012 09:45:08 -0500
Message-ID: <1328021108-4662-1-git-send-email-surfingalbert@gmail.com>
Cc: gitster@pobox.com, Albert Yale <surfingalbert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 15:45:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsExZ-0002Iw-2P
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 15:45:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754294Ab2AaOpR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 09:45:17 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:33231 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753061Ab2AaOpO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 09:45:14 -0500
Received: by qafk1 with SMTP id k1so181333qaf.19
        for <git@vger.kernel.org>; Tue, 31 Jan 2012 06:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=+HLVKOiL5meHJPxZonVUH5u+4/eoEnpzBVZZBfCAk1I=;
        b=JBGUpih2i37MhX7jt4UZa1PXyzKW8VtfVh+ykujSxrRwcrE38/3NtyIn2MnCNEvhFI
         O2r+w0ZEnAUriwSNt6rTR8nEIWB5nKphjlG8iFeHal4DsCyqdBz1yw6wYtnhq3XW5qgu
         E1F+MDvexeeQJEbVEjB7hij5S+v+GuvTINo+Y=
Received: by 10.224.207.134 with SMTP id fy6mr28404429qab.72.1328021113854;
        Tue, 31 Jan 2012 06:45:13 -0800 (PST)
Received: from f.uze.ca.uze.ca (modemcable104.125-21-96.mc.videotron.ca. [96.21.125.104])
        by mx.google.com with ESMTPS id gw4sm1154264qab.13.2012.01.31.06.45.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 31 Jan 2012 06:45:13 -0800 (PST)
X-Mailer: git-send-email 1.7.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189455>

[PATCH/RFC v3] grep: Add the option '--exclude'

Signed-off-by: Albert Yale <surfingalbert@gmail.com>
---
Here's my latest progress towards a cleaner implementation.

Albert Yale

 Documentation/git-grep.txt |    7 +++
 builtin/grep.c             |   41 +++++++++++++--
 cache.h                    |    3 +
 dir.c                      |  126 +++++++++++++++++++++++++++++++++++++------
 dir.h                      |    3 +-
 read-cache.c               |    2 +-
 6 files changed, 158 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6a8b1e3..67a83aa 100644
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
@@ -124,6 +125,12 @@ OPTIONS
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
+-x <pattern>::
+--exclude <pattern>::
+	In addition to those found in .gitignore (per directory) and
+	$GIT_DIR/info/exclude, also consider these patterns to be in the
+	set of the ignore rules in effect.
+
 -n::
 --line-number::
 	Prefix the line number to matching lines.
diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..e9e1ac1 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -528,7 +528,8 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 		struct cache_entry *ce = active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
+		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce),
+					  0, NULL, 1))
 			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
@@ -566,6 +567,11 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
 
+		if (match_pathspec_depth(pathspec->exclude,
+					 entry.path, strlen(entry.path),
+					 0, NULL, 0))
+			continue;
+
 		if (match != all_entries_interesting) {
 			match = tree_entry_interesting(&entry, base, tn_len, pathspec);
 			if (match == all_entries_not_interesting)
@@ -606,8 +612,17 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name)
 {
-	if (obj->type == OBJ_BLOB)
+	if (obj->type == OBJ_BLOB) {
+		const char *name_without_sha1 = strchr(name, ':') + 1;
+
+		if (match_pathspec_depth(pathspec->exclude,
+					 name_without_sha1,
+					 strlen(name_without_sha1),
+					 0, NULL, 0))
+			return 0;
+
 		return grep_sha1(opt, obj->sha1, name, 0);
+	}
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -671,7 +686,7 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	for (i = 0; i < dir.nr; i++) {
 		const char *name = dir.entries[i]->name;
 		int namelen = strlen(name);
-		if (!match_pathspec_depth(pathspec, name, namelen, 0, NULL))
+		if (!match_pathspec_depth(pathspec, name, namelen, 0, NULL, 1))
 			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
@@ -764,6 +779,14 @@ static int pattern_callback(const struct option *opt, const char *arg,
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
@@ -792,7 +815,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		pattern_type_pcre,
 	};
 	int pattern_type = pattern_type_unspecified;
-
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -872,6 +895,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"read patterns from file", file_callback),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
 			"match <pattern>", PARSE_OPT_NONEG, pattern_callback },
+		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, "pattern",
+		  "add <pattern> to ignore rules", PARSE_OPT_NONEG, exclude_cb },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
 		  "combine patterns specified with -e",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
@@ -1053,6 +1078,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 
+	if (exclude_list.nr) {
+		add_pathspec_item_from_string_list(pathspec.exclude, &exclude_list);
+		pathspec.exclude->max_depth = opt.max_depth;
+		pathspec.exclude->recursive = 1;
+	}
+
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
@@ -1102,5 +1133,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
+	free_pathspec(&pathspec);
+	string_list_clear(&exclude_list, 0);
 	return !hit;
 }
diff --git a/cache.h b/cache.h
index 9bd8c2d..683458a 100644
--- a/cache.h
+++ b/cache.h
@@ -533,9 +533,12 @@ struct pathspec {
 		int len;
 		unsigned int use_wildcard:1;
 	} *items;
+
+	struct pathspec *exclude; /* This is never NULL. */
 };
 
 extern int init_pathspec(struct pathspec *, const char **);
+extern int add_pathspec_item_from_string_list(struct pathspec *, const struct string_list *);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec);
 
diff --git a/dir.c b/dir.c
index 0a78d00..9e4312c 100644
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
@@ -253,34 +255,47 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
  */
 int match_pathspec_depth(const struct pathspec *ps,
 			 const char *name, int namelen,
-			 int prefix, char *seen)
+			 int prefix, char *seen,
+			 int empty_pathspec_can_match)
 {
 	int i, retval = 0;
+	const char *name_without_prefix = name + prefix;
+	int namelen_without_prefix = namelen - prefix;
 
 	if (!ps->nr) {
-		if (!ps->recursive || ps->max_depth == -1)
-			return MATCHED_RECURSIVELY;
+		if (empty_pathspec_can_match) {
+			if (match_pathspec_depth(ps->exclude,
+						   name, namelen,
+						   prefix, seen, 0))
+				return 0;
 
-		if (within_depth(name, namelen, 0, ps->max_depth))
-			return MATCHED_EXACTLY;
+			if (!ps->recursive || ps->max_depth == -1)
+				return MATCHED_RECURSIVELY;
+
+			if (within_depth(name, namelen, 0, ps->max_depth))
+				return MATCHED_EXACTLY;
+			else
+				return 0;
+		}
 		else
 			return 0;
 	}
 
-	name += prefix;
-	namelen -= prefix;
-
 	for (i = ps->nr - 1; i >= 0; i--) {
 		int how;
 		if (seen && seen[i] == MATCHED_EXACTLY)
 			continue;
-		how = match_pathspec_item(ps->items+i, prefix, name, namelen);
+		how = match_pathspec_item(ps->items+i, prefix,
+					  name_without_prefix,
+					  namelen_without_prefix);
 		if (ps->recursive && ps->max_depth != -1 &&
 		    how && how != MATCHED_FNMATCH) {
 			int len = ps->items[i].len;
-			if (name[len] == '/')
+			if (name_without_prefix[len] == '/')
 				len++;
-			if (within_depth(name+len, namelen-len, 0, ps->max_depth))
+			if (within_depth(name_without_prefix+len,
+					 namelen_without_prefix-len,
+					 0, ps->max_depth))
 				how = MATCHED_EXACTLY;
 			else
 				how = 0;
@@ -292,6 +307,12 @@ int match_pathspec_depth(const struct pathspec *ps,
 				seen[i] = how;
 		}
 	}
+
+	if (retval && match_pathspec_depth(ps->exclude,
+					   name, namelen,
+					   prefix, seen, 0))
+		return 0;
+
 	return retval;
 }
 
@@ -1259,12 +1280,79 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
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
+int add_pathspec_item_from_string_list(struct pathspec *pathspec,
+				       const struct string_list *path_list)
+{
+	int i;
+	struct pathspec_item *new_items;
+	int previous_items_count = pathspec->nr;
+
+	if (!path_list->nr)
+		return 0;
+
+	pathspec->nr += path_list->nr;
+
+	if (previous_items_count)
+		pathspec->items = xrealloc(pathspec->items,
+					   sizeof(struct pathspec_item)*pathspec->nr);
+	else
+		pathspec->items = xcalloc(pathspec->nr, sizeof(struct pathspec_item));
+
+	new_items = pathspec->items + previous_items_count;
+
+	for (i = 0; i < path_list->nr; i++) {
+		struct pathspec_item *item = new_items+i;
+		const char *path = path_list->items[i].string;
+
+		pathspec->has_wildcard |= init_pathspec_item(item, path);
+	}
+
+	/*
+	* Give the pathspec a pathspec->exclude so we can test
+	* pathspec->exclude->nr without testing the validity of
+	* pathspec->exclude first.
+	*/
+	if (!pathspec->exclude)
+		pathspec->exclude = xcalloc(1, sizeof(*pathspec));
+
+	qsort(pathspec->items, pathspec->nr,
+	      sizeof(struct pathspec_item), pathspec_item_cmp);
+
+	/*
+	* Please comment/review:
+	*
+	* Here, pathspec->raw is NULL despite pathspec->nr being non-zero.
+	*
+	* Usually, a NULL pathspec->raw implies that pathspec->nr is zero.
+	*
+	* A problem might arrise if other areas of the code assume that a
+	* NULL pathspec->raw means that pathspec->nr is zero, or vice-versa.
+	*/
+
+	return 0;
+}
+
 int init_pathspec(struct pathspec *pathspec, const char **paths)
 {
 	const char **p = paths;
 	int i;
 
 	memset(pathspec, 0, sizeof(*pathspec));
+	/*
+	* We create pathspec->exclude unconditionally so that we don't have
+	* to test the validity of pathspec->exclude before using the value
+	* of pathspec->exclude->nr.
+	*/
+	pathspec->exclude = xcalloc(1, sizeof(*pathspec));
 	if (!p)
 		return 0;
 	while (*p)
@@ -1279,11 +1367,7 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 		struct pathspec_item *item = pathspec->items+i;
 		const char *path = paths[i];
 
-		item->match = path;
-		item->len = strlen(path);
-		item->use_wildcard = !no_wildcard(path);
-		if (item->use_wildcard)
-			pathspec->has_wildcard = 1;
+		pathspec->has_wildcard |= init_pathspec_item(item, path);
 	}
 
 	qsort(pathspec->items, pathspec->nr,
@@ -1294,6 +1378,12 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 
 void free_pathspec(struct pathspec *pathspec)
 {
-	free(pathspec->items);
-	pathspec->items = NULL;
+	if (pathspec->items) {
+		free(pathspec->items);
+		pathspec->items = NULL;
+	}
+	if (pathspec->exclude) {
+		free_pathspec(pathspec->exclude);
+		pathspec->exclude = NULL;
+	}
 }
diff --git a/dir.h b/dir.h
index dd6947e..2b9870d 100644
--- a/dir.h
+++ b/dir.h
@@ -68,7 +68,8 @@ extern char *common_prefix(const char **pathspec);
 extern int match_pathspec(const char **pathspec, const char *name, int namelen, int prefix, char *seen);
 extern int match_pathspec_depth(const struct pathspec *pathspec,
 				const char *name, int namelen,
-				int prefix, char *seen);
+				int prefix, char *seen,
+				int empty_pathspec_can_match);
 extern int within_depth(const char *name, int namelen, int depth, int max_depth);
 
 extern int fill_directory(struct dir_struct *dir, const char **pathspec);
diff --git a/read-cache.c b/read-cache.c
index a51bba1..9783c4f 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -708,7 +708,7 @@ int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 
 int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec)
 {
-	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL);
+	return match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL, 1);
 }
 
 /*
-- 
1.7.8.3
