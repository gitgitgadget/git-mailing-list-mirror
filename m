From: Albert Yale <surfingalbert@gmail.com>
Subject: [PATCH/RFC] grep: Add the option '--exclude'
Date: Fri, 27 Jan 2012 21:06:10 -0500
Message-ID: <1327716370-40705-1-git-send-email-surfingalbert@gmail.com>
Cc: pclouds@gmail.com, rene.scharfe@lsrfire.ath.cx,
	tfransosi@gmail.com, Albert Yale <surfingalbert@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 28 03:06:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rqxgd-00011M-Or
	for gcvg-git-2@lo.gmane.org; Sat, 28 Jan 2012 03:06:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab2A1CGe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jan 2012 21:06:34 -0500
Received: from mail-qw0-f53.google.com ([209.85.216.53]:65411 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751339Ab2A1CGd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jan 2012 21:06:33 -0500
Received: by qafk1 with SMTP id k1so692723qaf.19
        for <git@vger.kernel.org>; Fri, 27 Jan 2012 18:06:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=K5aq5NiV4stKUDAiDWlpxWFeBUXMl2i1vRUNCefYUnM=;
        b=o79LDHhnoWXklzCEgeXoQKqZaqvaEbz0mw7/hVhWq3UWWMQrLVukGTuYZSHz66qaGs
         nSKdwoMC/2X6OI7nstKWtxPWWnYLml//qruXT/s0jUOZt7wZeNJdB3gQk3dQ3oDbPTlP
         aLKbBrlVR6kYquuJi5XRo2tu7r88JABki1eC4=
Received: by 10.224.175.2 with SMTP id v2mr11673358qaz.69.1327716392800;
        Fri, 27 Jan 2012 18:06:32 -0800 (PST)
Received: from f.uze.ca.uze.ca (modemcable104.125-21-96.mc.videotron.ca. [96.21.125.104])
        by mx.google.com with ESMTPS id g9sm18469885qad.16.2012.01.27.18.06.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 27 Jan 2012 18:06:32 -0800 (PST)
X-Mailer: git-send-email 1.7.7.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189247>

grep: Add the option '--exclude'

Signed-off-by: Albert Yale <surfingalbert@gmail.com>
---
This is a work-in-progress. It's functional,
but it hasn't been thoroughly tested.

I'd like some feedback. Particularly for
init_pathspec_string_list() in dir.c.

Thank you,

Albert Yale

 Documentation/git-grep.txt |    7 ++++++
 builtin/grep.c             |   50 ++++++++++++++++++++++++++++++++++++-------
 cache.h                    |    1 +
 dir.c                      |   32 ++++++++++++++++++++++++++++
 4 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 6a8b1e3..8cbb161 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -22,6 +22,7 @@ SYNOPSIS
 	   [--color[=<when>] | --no-color]
 	   [-A <post-context>] [-B <pre-context>] [-C <context>]
 	   [-f <file>] [-e] <pattern>
+	   [-x <pattern>|--exclude=<pattern>]
 	   [--and|--or|--not|(|)|-e <pattern>...]
 	   [ [--exclude-standard] [--cached | --no-index | --untracked] | <tree>...]
 	   [--] [<pathspec>...]
@@ -124,6 +125,12 @@ OPTIONS
 	Use fixed strings for patterns (don't interpret pattern
 	as a regex).
 
+-x <pattern>::
+--exclude=<pattern>::
+	In addition to those found in .gitignore (per directory) and
+	$GIT_DIR/info/exclude, also consider these patterns to be in the
+	set of the ignore rules in effect.
+
 -n::
 --line-number::
 	Prefix the line number to matching lines.
diff --git a/builtin/grep.c b/builtin/grep.c
index 9ce064a..106810f 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -518,7 +518,8 @@ static void run_pager(struct grep_opt *opt, const char *prefix)
 	free(argv);
 }
 
-static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int cached)
+static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec,
+			  int cached, const struct pathspec *exclude_pathspec)
 {
 	int hit = 0;
 	int nr;
@@ -530,6 +531,9 @@ static int grep_cache(struct grep_opt *opt, const struct pathspec *pathspec, int
 			continue;
 		if (!match_pathspec_depth(pathspec, ce->name, ce_namelen(ce), 0, NULL))
 			continue;
+		if (exclude_pathspec->nr &&
+			match_pathspec_depth(exclude_pathspec, ce->name, ce_namelen(ce), 0, NULL))
+			continue;
 		/*
 		 * If CE_VALID is on, we assume worktree file and its cache entry
 		 * are identical, even if worktree file has been modified, so use
@@ -639,16 +643,23 @@ static int grep_object(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
-			const struct object_array *list)
+			const struct object_array *list, const struct pathspec *exclude_pathspec)
 {
 	unsigned int i;
 	int hit = 0;
 	const unsigned int nr = list->nr;
 
 	for (i = 0; i < nr; i++) {
+		const char *name = list->objects[i].name;
+		int namelen = strlen(name);
 		struct object *real_obj;
 		real_obj = deref_tag(list->objects[i].item, NULL, 0);
-		if (grep_object(opt, pathspec, real_obj, list->objects[i].name)) {
+
+		if (exclude_pathspec->nr &&
+			match_pathspec_depth(exclude_pathspec, name, namelen, 0, NULL))
+			continue;
+
+		if (grep_object(opt, pathspec, real_obj, name)) {
 			hit = 1;
 			if (opt->status_only)
 				break;
@@ -658,7 +669,7 @@ static int grep_objects(struct grep_opt *opt, const struct pathspec *pathspec,
 }
 
 static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
-			  int exc_std)
+			  int exc_std, struct string_list *exclude_list)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
@@ -667,6 +678,10 @@ static int grep_directory(struct grep_opt *opt, const struct pathspec *pathspec,
 	if (exc_std)
 		setup_standard_excludes(&dir);
 
+	for (i = 0; i < exclude_list->nr; i++)
+		add_exclude(exclude_list->items[i].string, "", 0,
+			    &dir.exclude_list[EXC_CMDL]);
+
 	fill_directory(&dir, pathspec->raw);
 	for (i = 0; i < dir.nr; i++) {
 		const char *name = dir.entries[i]->name;
@@ -764,6 +779,14 @@ static int pattern_callback(const struct option *opt, const char *arg,
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
@@ -780,6 +803,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct object_array list = OBJECT_ARRAY_INIT;
 	const char **paths = NULL;
 	struct pathspec pathspec;
+	struct pathspec exclude_pathspec;
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
 	int i;
 	int dummy;
@@ -792,7 +816,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		pattern_type_pcre,
 	};
 	int pattern_type = pattern_type_unspecified;
-
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option options[] = {
 		OPT_BOOLEAN(0, "cached", &cached,
 			"search in index instead of in the work tree"),
@@ -872,6 +896,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			"read patterns from file", file_callback),
 		{ OPTION_CALLBACK, 'e', NULL, &opt, "pattern",
 			"match <pattern>", PARSE_OPT_NONEG, pattern_callback },
+		{ OPTION_CALLBACK, 'x', "exclude", &exclude_list, "pattern",
+		  "add <pattern> to ignore rules", PARSE_OPT_NONEG, exclude_cb },
 		{ OPTION_CALLBACK, 0, "and", &opt, NULL,
 		  "combine patterns specified with -e",
 		  PARSE_OPT_NOARG | PARSE_OPT_NONEG, and_callback },
@@ -1053,6 +1079,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
 
+	init_pathspec_string_list(&exclude_pathspec, &exclude_list);
+	exclude_pathspec.max_depth = opt.max_depth;
+	exclude_pathspec.recursive = 1;
+
 	if (show_in_pager && (cached || list.nr))
 		die(_("--open-files-in-pager only works on the worktree"));
 
@@ -1083,18 +1113,19 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
 		if (list.nr)
 			die(_("--no-index or --untracked cannot be used with revs."));
-		hit = grep_directory(&opt, &pathspec, use_exclude);
+		hit = grep_directory(&opt, &pathspec, use_exclude, &exclude_list);
 	} else if (0 <= opt_exclude) {
 		die(_("--[no-]exclude-standard cannot be used for tracked contents."));
 	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
 
-		hit = grep_cache(&opt, &pathspec, cached);
+		hit = grep_cache(&opt, &pathspec, cached, &exclude_pathspec);
 	} else {
 		if (cached)
 			die(_("both --cached and trees are given."));
-		hit = grep_objects(&opt, &pathspec, &list);
+
+		hit = grep_objects(&opt, &pathspec, &list, &exclude_pathspec);
 	}
 
 	if (use_threads)
@@ -1102,5 +1133,8 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
+	free_pathspec(&pathspec);
+	free_pathspec(&exclude_pathspec);
+	string_list_clear(&exclude_list, 0);
 	return !hit;
 }
diff --git a/cache.h b/cache.h
index 10afd71..5c34ccb 100644
--- a/cache.h
+++ b/cache.h
@@ -536,6 +536,7 @@ struct pathspec {
 };
 
 extern int init_pathspec(struct pathspec *, const char **);
+extern int init_pathspec_string_list(struct pathspec *, struct string_list *);
 extern void free_pathspec(struct pathspec *);
 extern int ce_path_match(const struct cache_entry *ce, const struct pathspec *pathspec);
 
diff --git a/dir.c b/dir.c
index 0a78d00..65749cc 100644
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
@@ -1259,6 +1261,36 @@ static int pathspec_item_cmp(const void *a_, const void *b_)
 	return strcmp(a->match, b->match);
 }
 
+int init_pathspec_string_list(struct pathspec *pathspec, struct string_list *path_list)
+{
+	int i;
+
+	memset(pathspec, 0, sizeof(*pathspec));
+	if (!path_list)
+		return 0;
+	pathspec->raw = 0; /* THIS IS PROBABLY BAD!!! */
+	pathspec->nr = path_list->nr;
+	if (!pathspec->nr)
+		return 0;
+
+	pathspec->items = xmalloc(sizeof(struct pathspec_item)*pathspec->nr);
+	for (i = 0; i < pathspec->nr; i++) {
+		struct pathspec_item *item = pathspec->items+i;
+		const char *path = path_list->items[i].string;
+
+		item->match = path;
+		item->len = strlen(path);
+		item->use_wildcard = !no_wildcard(path);
+		if (item->use_wildcard)
+			pathspec->has_wildcard = 1;
+	}
+
+	qsort(pathspec->items, pathspec->nr,
+	      sizeof(struct pathspec_item), pathspec_item_cmp);
+
+	return 0;
+}
+
 int init_pathspec(struct pathspec *pathspec, const char **paths)
 {
 	const char **p = paths;
-- 
1.7.8.3
