From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] Teach git-diff{,-files} the new option `--no-index`
Date: Tue, 20 Feb 2007 19:46:28 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702201944340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Feb 20 19:46:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJa0Z-0003p7-QT
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 19:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030354AbXBTSqd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 13:46:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030355AbXBTSqd
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 13:46:33 -0500
Received: from mail.gmx.net ([213.165.64.20]:41604 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030354AbXBTSqa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 13:46:30 -0500
Received: (qmail invoked by alias); 20 Feb 2007 18:46:28 -0000
X-Provags-ID: V01U2FsdGVkX194Iwx5s8R4S94IZIv1GsE0RhUf5EIblk6nLYm0V6
	iw9w==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40253>


With this flag and given two paths, git-diff-files behaves as a GNU diff
lookalike (plus the git goodies like --check, colour, etc.).  This flag
is also available in git-diff.  It also works outside of a git repository.

In addition, if git-diff{,-files} is called without revision or stage
parameter, and with exactly two paths at least one of which is not tracked,
the default is --no-index.

This also unifies the duplicated argument parsing between cmd_diff_files()
and builtin_diff_files().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	Is this better than diff2 or what?

	This patch is only weakly tested; basically it passes `make test`.

 Documentation/git-diff-files.txt |    5 +-
 Documentation/git-diff.txt       |    4 +
 builtin-diff-files.c             |   29 +-----
 builtin-diff.c                   |   38 +-------
 diff-lib.c                       |  207 +++++++++++++++++++++++++++++++++++++-
 diff.c                           |    3 +-
 diff.h                           |    2 +-
 git.c                            |    4 +-
 wt-status.c                      |    2 +-
 9 files changed, 226 insertions(+), 68 deletions(-)

diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 7248b35..b78c4c6 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -8,7 +8,7 @@ git-diff-files - Compares files in the working tree and the index
 
 SYNOPSIS
 --------
-'git-diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
+'git-diff-files' [-q] [-0|-1|-2|-3|-c|--cc|-n|--no-index] [<common diff options>] [<path>...]
 
 DESCRIPTION
 -----------
@@ -36,6 +36,9 @@ omit diff output for unmerged entries and just show "Unmerged".
 	diff, similar to the way 'diff-tree' shows a merge
 	commit with these flags.
 
+\-n,\--no-index::
+	Compare the two given files / directories.
+
 -q::
 	Remain silent even on nonexistent files
 
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 6a098df..12a531d 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -23,6 +23,10 @@ tree and the index file, or the index file and the working tree.
 	further add to the index but you still haven't.  You can
 	stage these changes by using gitlink:git-add[1].
 
+	If exactly two paths are given, and at least one is untracked,
+	compare the two files / directories. This behavior can be
+	forced by --no-index.
+
 'git-diff' [--options] --cached [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 5d4a5c5..8d78dfa 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -10,42 +10,21 @@
 #include "builtin.h"
 
 static const char diff_files_usage[] =
-"git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
+"git-diff-files [-q] [-0/-1/2/3 |-c|--cc|-n|--no-index] [<common diff options>] [<path>...]"
 COMMON_DIFF_OPTIONS_HELP;
 
 int cmd_diff_files(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info rev;
-	int silent = 0;
+	int nongit = 0;
 
+	prefix = setup_git_directory_gently(&nongit);
 	init_revisions(&rev, prefix);
 	git_config(git_default_config); /* no "diff" UI options */
 	rev.abbrev = 0;
 
 	argc = setup_revisions(argc, argv, &rev, NULL);
-	while (1 < argc && argv[1][0] == '-') {
-		if (!strcmp(argv[1], "--base"))
-			rev.max_count = 1;
-		else if (!strcmp(argv[1], "--ours"))
-			rev.max_count = 2;
-		else if (!strcmp(argv[1], "--theirs"))
-			rev.max_count = 3;
-		else if (!strcmp(argv[1], "-q"))
-			silent = 1;
-		else
-			usage(diff_files_usage);
-		argv++; argc--;
-	}
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-
-	/*
-	 * Make sure there are NO revision (i.e. pending object) parameter,
-	 * rev.max_count is reasonable (0 <= n <= 3),
-	 * there is no other revision filtering parameters.
-	 */
-	if (rev.pending.nr ||
-	    rev.min_age != -1 || rev.max_age != -1)
-		usage(diff_files_usage);
-	return run_diff_files(&rev, silent);
+	return run_diff_files(&rev, argc, argv);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index a659020..9334589 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -25,40 +25,6 @@ struct blobinfo {
 static const char builtin_diff_usage[] =
 "git-diff <options> <rev>{0,2} -- <path>*";
 
-static int builtin_diff_files(struct rev_info *revs,
-			      int argc, const char **argv)
-{
-	int silent = 0;
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--base"))
-			revs->max_count = 1;
-		else if (!strcmp(arg, "--ours"))
-			revs->max_count = 2;
-		else if (!strcmp(arg, "--theirs"))
-			revs->max_count = 3;
-		else if (!strcmp(arg, "-q"))
-			silent = 1;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
-	/*
-	 * Make sure there are NO revision (i.e. pending object) parameter,
-	 * specified rev.max_count is reasonable (0 <= n <= 3), and
-	 * there is no other revision filtering parameter.
-	 */
-	if (revs->pending.nr ||
-	    revs->min_age != -1 ||
-	    revs->max_age != -1 ||
-	    3 < revs->max_count)
-		usage(builtin_diff_usage);
-	if (revs->max_count < 0 &&
-	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
-		revs->combine_merges = revs->dense_combined_merges = 1;
-	return run_diff_files(revs, silent);
-}
-
 static void stuff_change(struct diff_options *opt,
 			 unsigned old_mode, unsigned new_mode,
 			 const unsigned char *old_sha1,
@@ -218,6 +184,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	int ents = 0, blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
+	int nongit = 0;
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -239,6 +206,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	 * Other cases are errors.
 	 */
 
+	prefix = setup_git_directory_gently(&nongit);
 	git_config(git_diff_ui_config);
 	init_revisions(&rev, prefix);
 
@@ -314,7 +282,7 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	if (!ents) {
 		switch (blobs) {
 		case 0:
-			return builtin_diff_files(&rev, argc, argv);
+			return run_diff_files(&rev, argc, argv);
 			break;
 		case 1:
 			if (paths != 1)
diff --git a/diff-lib.c b/diff-lib.c
index 556d534..83d6682 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -8,15 +8,218 @@
 #include "diffcore.h"
 #include "revision.h"
 #include "cache-tree.h"
+#include "path-list.h"
 
 /*
  * diff-files
  */
 
-int run_diff_files(struct rev_info *revs, int silent_on_removed)
+static int read_directory(const char *path, struct path_list *list)
+{
+	DIR *dir;
+	struct dirent *e;
+
+	if (!(dir = opendir(path)))
+		return error("Could not open directory %s", path);
+
+	while ((e = readdir(dir)))
+		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
+			path_list_insert(xstrdup(e->d_name), list);
+
+	closedir(dir);
+	return 0;
+}
+
+static int queue_diff(struct diff_options *o,
+		const char *name1, const char *name2)
+{
+	struct stat st;
+	int mode1 = 0, mode2 = 0;
+
+	if (name1) {
+		if (stat(name1, &st))
+			return error("Could not access '%s'", name1);
+		mode1 = st.st_mode;
+	}
+	if (name2) {
+		if (stat(name2, &st))
+			return error("Could not access '%s'", name1);
+		mode2 = st.st_mode;
+	}
+
+	if (mode1 && mode2 && S_ISDIR(mode1) != S_ISDIR(mode2))
+		return error("file/directory conflict: %s, %s", name1, name2);
+
+	if (S_ISDIR(mode1) || S_ISDIR(mode2)) {
+		char buffer1[PATH_MAX], buffer2[PATH_MAX];
+		struct path_list p1 = {NULL, 0, 0, 1}, p2 = {NULL, 0, 0, 1};
+		int len1 = 0, len2 = 0, i1, i2, ret = 0;
+
+		if (name1 && read_directory(name1, &p1))
+			return -1;
+		if (name2 && read_directory(name2, &p2)) {
+			path_list_clear(&p1, 0);
+			return -1;
+		}
+
+		if (name1) {
+			len1 = strlen(name1);
+			if (len1 > 0 && name1[len1 - 1] == '/')
+				len1--;
+			memcpy(buffer1, name1, len1);
+			buffer1[len1++] = '/';
+		}
+
+		if (name2) {
+			len2 = strlen(name2);
+			if (len2 > 0 && name2[len2 - 1] == '/')
+				len2--;
+			memcpy(buffer2, name2, len2);
+			buffer2[len2++] = '/';
+		}
+
+		for (i1 = i2 = 0; !ret && (i1 < p1.nr || i2 < p2.nr); ) {
+			const char *n1, *n2;
+			int comp;
+
+			if (i1 == p1.nr)
+				comp = 1;
+			else if (i2 == p2.nr)
+				comp = -1;
+			else
+				comp = strcmp(p1.items[i1].path,
+					p2.items[i2].path);
+
+			if (comp > 0)
+				n1 = NULL;
+			else {
+				n1 = buffer1;
+				strncpy(buffer1 + len1, p1.items[i1++].path,
+						PATH_MAX - len1);
+			}
+
+			if (comp < 0)
+				n2 = NULL;
+			else {
+				n2 = buffer2;
+				strncpy(buffer2 + len2, p2.items[i2++].path,
+						PATH_MAX - len2);
+			}
+
+			ret = queue_diff(o, n1, n2);
+		}
+		path_list_clear(&p1, 0);
+		path_list_clear(&p2, 0);
+
+		return ret;
+	} else {
+		struct diff_filespec *d1, *d2;
+
+		if (o->reverse_diff) {
+			unsigned tmp;
+			const char *tmp_c;
+			tmp = mode1; mode1 = mode2; mode2 = tmp;
+			tmp_c = name1; name1 = name2; name2 = tmp_c;
+		}
+
+		if (!name1)
+			name1 = "/dev/null";
+		if (!name2)
+			name2 = "/dev/null";
+		d1 = alloc_filespec(name1);
+		d2 = alloc_filespec(name2);
+		fill_filespec(d1, null_sha1, mode1);
+		fill_filespec(d2, null_sha1, mode2);
+
+		diff_queue(&diff_queued_diff, d1, d2);
+		return 0;
+	}
+}
+
+static int is_in_index(const char *path)
+{
+	int len = strlen(path);
+	int pos = cache_name_pos(path, len);
+	char c;
+
+	if (pos < 0)
+		return 0;
+	if (strncmp(active_cache[pos]->name, path, len))
+		return 0;
+	c = active_cache[pos]->name[len];
+	return c == '\0' || c == '/';
+}
+
+static int handle_diff_files_args(struct rev_info *revs,
+		int argc, const char **argv, int *silent)
+{
+	*silent = 0;
+
+	/* revs->max_count == -2 means --no-index */
+	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "--base"))
+			revs->max_count = 1;
+		else if (!strcmp(argv[1], "--ours"))
+			revs->max_count = 2;
+		else if (!strcmp(argv[1], "--theirs"))
+			revs->max_count = 3;
+		else if (!strcmp(argv[1], "-n") ||
+				!strcmp(argv[1], "--no-index"))
+			revs->max_count = -2;
+		else if (!strcmp(argv[1], "-q"))
+			*silent = 1;
+		else
+			return error("invalid option: %s", argv[1]);
+		argv++; argc--;
+	}
+
+	if (revs->max_count == -1 && revs->diffopt.nr_paths == 2) {
+		/*
+		 * If two files are specified, and at least one is untracked,
+		 * default to no-index.
+		 */
+		read_cache();
+		if (!is_in_index(revs->diffopt.paths[0]) ||
+					!is_in_index(revs->diffopt.paths[1]))
+			revs->max_count = -2;
+	}
+
+	/*
+	 * Make sure there are NO revision (i.e. pending object) parameter,
+	 * rev.max_count is reasonable (0 <= n <= 3),
+	 * there is no other revision filtering parameters.
+	 */
+	if (revs->pending.nr || revs->max_count > 3 ||
+	    revs->min_age != -1 || revs->max_age != -1)
+		return error("no revision allowed with diff-files");
+
+	if (revs->max_count == -1 &&
+	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
+		revs->combine_merges = revs->dense_combined_merges = 1;
+
+	return 0;
+}
+
+int run_diff_files(struct rev_info *revs, int argc, const char **argv)
 {
 	int entries, i;
-	int diff_unmerged_stage = revs->max_count;
+	int diff_unmerged_stage;
+	int silent_on_removed;
+
+	if (handle_diff_files_args(revs, argc, argv, &silent_on_removed))
+		return -1;
+
+	diff_unmerged_stage = revs->max_count;
+
+	if (revs->max_count == -2) {
+		if (revs->diffopt.nr_paths != 2)
+			return error("need two files/directories with --no-index");
+		queue_diff(&revs->diffopt, revs->diffopt.paths[0],
+				revs->diffopt.paths[1]);
+		diffcore_std(&revs->diffopt);
+		diff_flush(&revs->diffopt);
+		return 0;
+	}
 
 	if (diff_unmerged_stage < 0)
 		diff_unmerged_stage = 2;
diff --git a/diff.c b/diff.c
index 12c8b2b..701880a 100644
--- a/diff.c
+++ b/diff.c
@@ -2406,7 +2406,8 @@ static void diff_resolve_rename_copy(void)
 				p->status = DIFF_STATUS_RENAMED;
 		}
 		else if (hashcmp(p->one->sha1, p->two->sha1) ||
-			 p->one->mode != p->two->mode)
+			 p->one->mode != p->two->mode ||
+			 is_null_sha1(p->one->sha1))
 			p->status = DIFF_STATUS_MODIFIED;
 		else {
 			/* This is a "no-change" entry and should not
diff --git a/diff.h b/diff.h
index eece65d..cc28418 100644
--- a/diff.h
+++ b/diff.h
@@ -218,7 +218,7 @@ extern void diff_flush(struct diff_options*);
 
 extern const char *diff_unique_abbrev(const unsigned char *, int);
 
-extern int run_diff_files(struct rev_info *revs, int silent_on_removed);
+extern int run_diff_files(struct rev_info *revs, int argc, const char **argv);
 
 extern int run_diff_index(struct rev_info *revs, int cached);
 
diff --git a/git.c b/git.c
index 4dd1967..79fc73c 100644
--- a/git.c
+++ b/git.c
@@ -237,8 +237,8 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
 		{ "describe", cmd_describe, RUN_SETUP },
-		{ "diff", cmd_diff, RUN_SETUP | USE_PAGER },
-		{ "diff-files", cmd_diff_files, RUN_SETUP },
+		{ "diff", cmd_diff, USE_PAGER },
+		{ "diff-files", cmd_diff_files },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
diff --git a/wt-status.c b/wt-status.c
index 2879c3d..b68eea3 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -231,7 +231,7 @@ static void wt_status_print_changed(struct wt_status *s)
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
-	run_diff_files(&rev, 0);
+	run_diff_files(&rev, 0, NULL);
 }
 
 static void wt_status_print_untracked(struct wt_status *s)
-- 
1.5.0.50.gb7581-dirty
