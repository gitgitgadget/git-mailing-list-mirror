From: Albert Yale <surfingalbert@gmail.com>
Subject: [PATCH/RFC v2] grep: Add the option '--exclude'
Date: Sun, 29 Jan 2012 17:42:14 -0500
Message-ID: <1327876934-61526-1-git-send-email-surfingalbert@gmail.com>
Cc: gitster@pobox.com, Albert Yale <surfingalbert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 23:42:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RrdSC-0002rZ-QI
	for gcvg-git-2@plane.gmane.org; Sun, 29 Jan 2012 23:42:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752412Ab2A2Wm1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jan 2012 17:42:27 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:58528 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751980Ab2A2Wm0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jan 2012 17:42:26 -0500
Received: by qcsg15 with SMTP id g15so1917853qcs.19
        for <git@vger.kernel.org>; Sun, 29 Jan 2012 14:42:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=/Cxvn4cN6zuQbp/B3v+GmfquTBUgaOzzqDj1x7DsHJo=;
        b=hZLgsszElEZDgpZLSUenYlF/Ty2DFSI2Hxy4MUVQo6EoVOFOv1pVZ0DHlEitwzFke7
         BdP+UzS/uwhGnQFJtPZaXk8wn+UNoYcd/c2Io/JmJvl2HXOTchl8IE9sRyV5jTf7TbYE
         iM0ch85b8NAPVrbMVS1yHudbYtAHgpKpbg4Ho=
Received: by 10.224.106.196 with SMTP id y4mr18294238qao.90.1327876945452;
        Sun, 29 Jan 2012 14:42:25 -0800 (PST)
Received: from f.uze.ca.uze.ca (modemcable104.125-21-96.mc.videotron.ca. [96.21.125.104])
        by mx.google.com with ESMTPS id df3sm30914631qab.6.2012.01.29.14.42.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 29 Jan 2012 14:42:24 -0800 (PST)
X-Mailer: git-send-email 1.7.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189299>

Signed-off-by: Albert Yale <surfingalbert@gmail.com>
---
This is a revision to my previous patch.
The exclusion information is now held
inside the pathspec.

Feedback would again be appreciated,

Albert Yale

 Documentation/git-grep.txt |    7 +++++
 builtin/grep.c             |   43 ++++++++++++++++++++++++++++++++-
 cache.h                    |    3 ++
 dir.c                      |   55 ++++++++++++++++++++++++++++++++++++++++----
 4 files changed, 101 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6a8b1e3..db143e3 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	   [--color[=<when>] | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
+	   [-x<pattern>|--exclude<pattern>]
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [ [--exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
@@ -124,6 +125,12 @@ OPTIONS
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
+-x<pattern>::
+--exclude<pattern>::
+	In addition to those found in .gitignore (per directory) and
+	$GIT_DIR/info/exclude, also consider these patterns to be in the
+	set of the ignore rules in effect.
+
 -n::
 --line-number::
 	Prefix the line number to matching lines.
diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..9772fa4 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -530,6 +530,10 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 			continue;
 		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
 			continue;
+		if (pathspec->exclude &&
+			pathspec->exclude->nr &&
+			match_pathspec_depth(pathspec->exclude, ce->name, ce_namelen(ce), 0, NULL))
+			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
 		 * are identical, even if worktree file has been modified, so use
@@ -566,6 +570,11 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 	while (tree_entry(tree, &entry)) {
 		int te_len = tree_entry_len(&entry);
 
+		if (pathspec->exclude &&
+			pathspec->exclude->nr &&
+			match_pathspec_depth(pathspec->exclude, entry.path, strlen(entry.path), 0, NULL))
+			continue;
+
 		if (match != all_entries_interesting) {
 			match = tree_entry_interesting(&entry, base, tn_len, pathspec);
 			if (match == all_entries_not_interesting)
@@ -606,8 +615,16 @@ static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
 static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 		       struct object *obj, const char *name)
 {
-	if (obj->type == OBJ_BLOB)
+	if (obj->type == OBJ_BLOB) {
+		const char *name_without_sha1 = strchr(name, ':') + 1;
+
+		if (pathspec->exclude &&
+			pathspec->exclude->nr &&
+			match_pathspec_depth(pathspec->exclude, name_without_sha1, strlen(name_without_sha1), 0, NULL))
+			return 0;
+
 		return grep_sha1(opt, obj->sha1, name, 0);
+	}
 	if (obj->type == OBJ_COMMIT || obj->type == OBJ_TREE) {
 		struct tree_desc tree;
 		void *data;
@@ -673,6 +690,10 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 		int namelen = strlen(name);
 		if (!match_pathspec_depth(pathspec, name, namelen, 0, NULL))
 			continue;
+		if (pathspec->exclude &&
+			pathspec->exclude->nr &&
+			match_pathspec_depth(pathspec->exclude, name, namelen, 0, NULL))
+			continue;
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
 			break;
@@ -764,6 +785,14 @@ static int pattern_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int exclude_cb(const struct option *opt, const char *arg,
+			    int unset)
+{
+	struct string_list *exclude_list = opt->value;
+	string_list_append(exclude_list, arg);
+	return 0;
+}
+
 static int help_callback(const struct option *opt, const char *arg, int unset)
 {
 	return -1;
@@ -792,7 +821,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		pattern_type_pcre,
 	};
 	int pattern_type = pattern_type_unspecified;
-
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -872,6 +901,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"read patterns from file", file_callback),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
 			"match <pattern>", PARSE_OPT_NONEG, pattern_callback },
+		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, "pattern",
+		  "add <pattern> to ignore rules", PARSE_OPT_NONEG, exclude_cb },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
 		  "combine patterns specified with -e",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
@@ -1053,6 +1084,12 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 
+	if( exclude_list.nr ) {
+		create_pathspec_from_string_list(&pathspec.exclude, &exclude_list);
+		pathspec.exclude->max_depth = opt.max_depth;
+		pathspec.exclude->recursive = 1;
+	}
+
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
@@ -1102,5 +1139,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
+	free_pathspec(&pathspec);
+	string_list_clear(&exclude_list, 0);
 	return !hit;
 }
diff --git a/cache.h b/cache.h
index 10afd71..882a390 100644
--- a/cache.h
+++ b/cache.h
@@ -533,9 +533,12 @@ struct pathspec {
 		int len;
 		unsigned int use_wildcard:1;
 	} *items;
+
+	struct pathspec *exclude;
 };
 
 extern int init_pathspec(struct pathspec *, const char **);
+extern int create_pathspec_from_string_list(struct pathspec **, const struct string_list *);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec);
 
diff --git a/dir.c b/dir.c
index 0a78d00..fd04afa 100644
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
@@ -1259,6 +1261,49 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 	return strcmp(a->match, b->match);
 }
 
+static int init_pathspec_item( struct pathspec_item *item, const char *path )
+{
+	item->match = path;
+	item->len = strlen(path);
+	item->use_wildcard = !no_wildcard(path);
+
+	return item->use_wildcard;
+}
+
+int create_pathspec_from_string_list(struct pathspec **pathspec, const struct string_list *path_list)
+{
+	int i;
+
+	*pathspec = xcalloc( 1, sizeof( struct pathspec ) );
+
+	if (!path_list->nr)
+		return 0;
+
+	(*pathspec)->nr = path_list->nr;
+	(*pathspec)->items = xcalloc(path_list->nr, sizeof(struct pathspec_item));
+
+	for (i = 0; i < path_list->nr; i++) {
+		struct pathspec_item *item = (*pathspec)->items+i;
+		const char *path = path_list->items[i].string;
+
+		(*pathspec)->has_wildcard |= init_pathspec_item( item, path );
+	}
+
+	qsort((*pathspec)->items, (*pathspec)->nr,
+	      sizeof(struct pathspec_item), pathspec_item_cmp);
+
+	/*
+	* Please comment/review:
+	*
+	* Here, pathspec->raw is NULL despite pathspec->nr being non-zero.
+	* A possible problem might arrise if other areas of the code make
+	* the assumption that a NULL pathspec->raw means that pathspec->nr
+	* is zero.
+	*/
+
+	return 0;
+}
+
 int init_pathspec(struct pathspec *pathspec, const char **paths)
 {
 	const char **p = paths;
@@ -1279,11 +1324,7 @@ int init_pathspec(struct pathspec *pathspec, const char **paths)
 		struct pathspec_item *item = pathspec->items+i;
 		const char *path = paths[i];
 
-		item->match = path;
-		item->len = strlen(path);
-		item->use_wildcard = !no_wildcard(path);
-		if (item->use_wildcard)
-			pathspec->has_wildcard = 1;
+		pathspec->has_wildcard |= init_pathspec_item( item, path );
 	}
 
 	qsort(pathspec->items, pathspec->nr,
@@ -1296,4 +1337,8 @@ void free_pathspec(struct pathspec *pathspec)
 {
 	free(pathspec->items);
 	pathspec->items = NULL;
+	if (pathspec->exclude) {
+		free_pathspec(pathspec->exclude);
+		pathspec->exclude = NULL;
+	}
 }
-- 
1.7.8.3
