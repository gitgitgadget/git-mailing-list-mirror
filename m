From: David Ripton <dripton@ripton.net>
Subject: Re: [RFC/PATCH] Add --exclude-dir option to git grep
Date: Sat, 25 Sep 2010 06:14:44 -0700
Message-ID: <20100925131444.GA7142@nulllenny.dreamhost.com>
References: <20100924042614.GA25944@nulllenny.dreamhost.com> <7v1v8iq3tu.fsf@alter.siamese.dyndns.org> <4C9D596C.4060906@ripton.net> <7vsk0ynzfl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 25 15:14:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzUaZ-0004UO-Pn
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 15:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab0IYNOp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 09:14:45 -0400
Received: from smarty.dreamhost.com ([208.113.175.8]:43555 "EHLO
	smarty.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754448Ab0IYNOo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 09:14:44 -0400
Received: from eridanus.dreamhost.com (eridanus.dreamhost.com [173.236.136.187])
	by smarty.dreamhost.com (Postfix) with ESMTP id 576916E8056;
	Sat, 25 Sep 2010 06:14:44 -0700 (PDT)
Received: by eridanus.dreamhost.com (Postfix, from userid 59956)
	id 5512CD279C; Sat, 25 Sep 2010 06:14:44 -0700 (PDT)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vsk0ynzfl.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157149>

It works much like the same option in recent versions of GNU grep.
Any directory name which matches the option will not be searched.

For example, "git grep --exclude-dir Documentation malloc"

Signed-off-by: David Ripton <dripton@ripton.net>
---
This version makes "s1" const, rather than casting away const.

 builtin/grep.c |  130 +++++++++++++++++++++++++++++++++++++++++++++++++------
 grep.h         |    2 +
 2 files changed, 117 insertions(+), 15 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index da32f3d..699b308 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -333,15 +333,68 @@ static int grep_config(const char *var, const char *value, void *cb)
 	return 0;
 }
 
+/* Return a sorted string_list of all possible directories within path.
+ *
+ * e.g. if path is "foo/bar/baz", then return a string_list with:
+ *                 "bar"
+ *                 "foo"
+ *                 "foo/bar"
+ *
+ *  (We do not need to return baz because the paths we receive always
+ *  end with a file not a directory.)
+ */
+static struct string_list subdirs(const char *path)
+{
+	struct string_list list = STRING_LIST_INIT_DUP;
+	/* Make a copy so we can chop off the end. */
+	char *path2 = xstrdup(path);
+	/* A pointer that advances along path2 */
+	char *path3 = path2;
+	/* Chop off the basename portion. */
+	if ((path3 = strrchr(path3, '/')) != NULL)
+		*path3 = '\0';
+	int again = 0;
+	do {
+		again = 0;
+		string_list_append(&list, path2);
+		path3 = path2;
+		while ((path3 = strchr(path3, '/')) != NULL) {
+			path3++;
+			string_list_append(&list, path3);
+		}
+		path3 = path2;
+		if ((path3 = strrchr(path3, '/')) != NULL) {
+			*path3 = '\0';
+			again = 1;
+		}
+	} while (again);
+	free(path2);
+	sort_string_list(&list);
+	return list;
+}
+
 /*
  * Return non-zero if max_depth is negative or path has no more then max_depth
  * slashes.
  */
-static int accept_subdir(const char *path, int max_depth)
+static int accept_subdir(const char *path, int max_depth,
+				const struct string_list exclude_dir_list)
 {
+	if (exclude_dir_list.nr > 0) {
+		struct string_list subdir_list = subdirs(path);
+		int i;
+		for (i = 0; i < subdir_list.nr; i++) {
+			if (string_list_has_string(&exclude_dir_list,
+					subdir_list.items[i].string)) {
+				string_list_clear(&subdir_list, 0);
+				return 0;
+			}
+		}
+		string_list_clear(&subdir_list, 0);
+	}
+
 	if (max_depth < 0)
 		return 1;
-
 	while ((path = strchr(path, '/')) != NULL) {
 		max_depth--;
 		if (max_depth < 0)
@@ -355,7 +408,8 @@ static int accept_subdir(const char *path, int max_depth)
  * Return non-zero if name is a subdirectory of match and is not too deep.
  */
 static int is_subdir(const char *name, int namelen,
-		const char *match, int matchlen, int max_depth)
+		const char *match, int matchlen, int max_depth,
+		const struct string_list exclude_dir_list)
 {
 	if (matchlen > namelen || strncmp(name, match, matchlen))
 		return 0;
@@ -364,7 +418,8 @@ static int is_subdir(const char *name, int namelen,
 		return 1;
 
 	if (!matchlen || match[matchlen-1] == '/' || name[matchlen] == '/')
-		return accept_subdir(name + matchlen + 1, max_depth);
+		return accept_subdir(name + matchlen + 1, max_depth,
+					exclude_dir_list);
 
 	return 0;
 }
@@ -373,18 +428,21 @@ static int is_subdir(const char *name, int namelen,
  * git grep pathspecs are somewhat different from diff-tree pathspecs;
  * pathname wildcards are allowed.
  */
-static int pathspec_matches(const char **paths, const char *name, int max_depth)
+static int pathspec_matches(const char **paths, const char *name,
+				int max_depth,
+				const struct string_list exclude_dir_list)
 {
 	int namelen, i;
 	if (!paths || !*paths)
-		return accept_subdir(name, max_depth);
+		return accept_subdir(name, max_depth, exclude_dir_list);
 	namelen = strlen(name);
 	for (i = 0; paths[i]; i++) {
 		const char *match = paths[i];
 		int matchlen = strlen(match);
 		const char *cp, *meta;
 
-		if (is_subdir(name, namelen, match, matchlen, max_depth))
+		if (is_subdir(name, namelen, match, matchlen, max_depth,
+				exclude_dir_list))
 			return 1;
 		if (!fnmatch(match, name, 0))
 			return 1;
@@ -595,14 +653,17 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 		struct cache_entry *ce = active_cache[nr];
 		if (!S_ISREG(ce->ce_mode))
 			continue;
-		if (!pathspec_matches(paths, ce->name, opt->max_depth))
+		if (!pathspec_matches(paths, ce->name, opt->max_depth,
+					opt->exclude_dir_list))
 			continue;
+
 		/*
-		 * If CE_VALID is on, we assume worktree file and its cache entry
-		 * are identical, even if worktree file has been modified, so use
-		 * cache version instead
+		 * If CE_VALID is on, we assume worktree file and its cache
+		 * entry are identical, even if worktree file has been
+		 * modified, so use cache version instead
 		 */
-		if (cached || (ce->ce_flags & CE_VALID) || ce_skip_worktree(ce)) {
+		if (cached || (ce->ce_flags & CE_VALID) ||
+			ce_skip_worktree(ce)) {
 			if (ce_stage(ce))
 				continue;
 			hit |= grep_sha1(opt, ce->sha1, ce->name, 0);
@@ -656,7 +717,8 @@ static int grep_tree(struct grep_opt *opt, const char **paths,
 			strbuf_addch(&pathbuf, '/');
 
 		down = pathbuf.buf + tn_len;
-		if (!pathspec_matches(paths, down, opt->max_depth))
+		if (!pathspec_matches(paths, down, opt->max_depth,
+					opt->exclude_dir_list))
 			;
 		else if (S_ISREG(entry.mode))
 			hit |= grep_sha1(opt, entry.sha1, pathbuf.buf, tn_len);
@@ -722,7 +784,8 @@ static int grep_objects(struct grep_opt *opt, const char **paths,
 	return hit;
 }
 
-static int grep_directory(struct grep_opt *opt, const char **paths)
+static int grep_directory(struct grep_opt *opt, const char **paths,
+				const struct string_list exclude_dir_list)
 {
 	struct dir_struct dir;
 	int i, hit = 0;
@@ -730,7 +793,12 @@ static int grep_directory(struct grep_opt *opt, const char **paths)
 	memset(&dir, 0, sizeof(dir));
 	setup_standard_excludes(&dir);
 
+	for (i = 0; i < exclude_dir_list.nr; i++)
+		add_exclude(exclude_dir_list.items[i].string, "", 0,
+				dir.exclude_list);
+
 	fill_directory(&dir, paths);
+
 	for (i = 0; i < dir.nr; i++) {
 		hit |= grep_file(opt, dir.entries[i]->name);
 		if (hit && opt->status_only)
@@ -826,6 +894,29 @@ static int help_callback(const struct option *opt, const char *arg, int unset)
 	return -1;
 }
 
+static int exclude_dir_callback(const struct option *opt, const char *arg,
+				int unset)
+{
+	struct string_list *exclude_dir_list = opt->value;
+	const char *s1 = arg;
+	char *s2;
+	char *s3;
+	/* We do not want leading or trailing slashes. */
+	while (*s1 == '/') {
+		s1++;
+	}
+	s2 = xstrdup(s1);
+	s3 = s2 + strlen(s2) - 1;
+	while (s3 >= s2 && *s3 == '/') {
+		*s3 = '\0';
+		s3--;
+	}
+	string_list_append(exclude_dir_list, s2);
+	free(s2);
+	return 0;
+}
+
+
 int cmd_grep(int argc, const char **argv, const char *prefix)
 {
 	int hit = 0;
@@ -837,6 +928,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	struct object_array list = OBJECT_ARRAY_INIT;
 	const char **paths = NULL;
 	struct string_list path_list = STRING_LIST_INIT_NODUP;
+	struct string_list exclude_dir_list = STRING_LIST_INIT_DUP;
 	int i;
 	int dummy;
 	int use_index = 1;
@@ -920,6 +1012,10 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN(0, "all-match", &opt.all_match,
 			"show only matches from files that match all patterns"),
 		OPT_GROUP(""),
+		{ OPTION_CALLBACK, 0, "exclude-dir", &exclude_dir_list,
+		  "pattern", "exclude <pattern>", PARSE_OPT_NONEG,
+		  exclude_dir_callback },
+		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			"pager", "show matching files in the pager",
 			PARSE_OPT_OPTARG, NULL, (intptr_t)default_pager },
@@ -974,6 +1070,9 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			     PARSE_OPT_STOP_AT_NON_OPTION |
 			     PARSE_OPT_NO_INTERNAL_HELP);
 
+	sort_string_list(&exclude_dir_list);
+	opt.exclude_dir_list = exclude_dir_list;
+
 	if (use_index && !startup_info->have_repository)
 		/* die the same way as if we did it at the beginning */
 		setup_git_directory();
@@ -1093,7 +1192,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			die("--cached cannot be used with --no-index.");
 		if (list.nr)
 			die("--no-index cannot be used with revs.");
-		hit = grep_directory(&opt, paths);
+		hit = grep_directory(&opt, paths, exclude_dir_list);
 	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
@@ -1110,5 +1209,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (hit && show_in_pager)
 		run_pager(&opt, prefix);
 	free_grep_patterns(&opt);
+	string_list_clear(&exclude_dir_list, 0);
 	return !hit;
 }
diff --git a/grep.h b/grep.h
index efa8cff..0400611 100644
--- a/grep.h
+++ b/grep.h
@@ -1,6 +1,7 @@
 #ifndef GREP_H
 #define GREP_H
 #include "color.h"
+#include "string-list.h"
 
 enum grep_pat_token {
 	GREP_PATTERN,
@@ -99,6 +100,7 @@ struct grep_opt {
 	unsigned post_context;
 	unsigned last_shown;
 	int show_hunk_mark;
+	struct string_list exclude_dir_list;
 	void *priv;
 
 	void (*output)(struct grep_opt *opt, const void *data, size_t size);

-- 
David Ripton    dripton@ripton.net
