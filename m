From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/5] gitopt: convert setup_revisions() and friends
Date: Sun, 14 May 2006 08:19:20 -0700
Message-ID: <11476199622704-git-send-email-normalperson@yhbt.net>
References: <11476199622462-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 14 17:19:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfINl-0004pX-9J
	for gcvg-git@gmane.org; Sun, 14 May 2006 17:19:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbWENPT3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 11:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWENPT3
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 11:19:29 -0400
Received: from hand.yhbt.net ([66.150.188.102]:65436 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751452AbWENPTX (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 May 2006 11:19:23 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 4E9807DC022;
	Sun, 14 May 2006 08:19:23 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11476199622462-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19968>

	diff_opt_parse => diff_opt_handle

I've added --raw to diff_opt_handle() for consistency's sake

Lightly tested, some bugs in the original series of submitted
patches were fixed wrt argument parsing for -C,-M,-B).

Passes all tests so that's a good sign.

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 builtin-diff.c      |  152 +++++++-------
 builtin-log.c       |    7 -
 commit.c            |   14 +
 diff-files.c        |   25 +-
 diff-index.c        |   18 +-
 diff-stages.c       |   56 +++--
 diff-tree.c         |   15 +
 diff.c              |  183 ++++++++++++-----
 diff.h              |    7 -
 gitopt/diff-files.h |   45 ++++
 gitopt/diff-index.h |   22 ++
 gitopt/diff-tree.h  |   22 ++
 gitopt/diff.h       |   19 ++
 http-push.c         |    2 
 rev-list.c          |   51 +++--
 revision.c          |  542 +++++++++++++++++++++++++++------------------------
 revision.h          |    4 
 17 files changed, 704 insertions(+), 480 deletions(-)
 create mode 100644 gitopt/diff-files.h
 create mode 100644 gitopt/diff-index.h
 create mode 100644 gitopt/diff-tree.h
 create mode 100644 gitopt/diff.h

946397f743f363198d154efaa74d5cc5bd9d6aae
diff --git a/builtin-diff.c b/builtin-diff.c
index d3ac581..3aefd3c 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -12,6 +12,9 @@ #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "gitopt/diff-index.h"
+#include "gitopt/diff-files.h"
+#include "gitopt/diff-tree.h"
 
 /* NEEDSWORK: struct object has place for name but we _do_
  * know mode when we extracted the blob out of a tree, which
@@ -25,26 +28,25 @@ struct blobinfo {
 static const char builtin_diff_usage[] =
 "diff <options> <rev>{0,2} -- <path>*";
 
+static int extra_diff_flags[LAST_DIFF_EXTRA_ID] = { 0 };
+
 static int builtin_diff_files(struct rev_info *revs,
 			      int argc, const char **argv)
 {
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
-		else if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
-		else
+	int i;
+	struct df_extra_opts dfeo = { revs, 0 };
+
+	if (argc)
+		usage(builtin_diff_usage);
+
+	for (i = 1; i < ARRAY_SIZE(extra_diff_flags); i++) {
+		if (extra_diff_flags[i]) {
+			if (diff_files_opt_handler(NULL, i, &dfeo) > 0)
+				continue;
 			usage(builtin_diff_usage);
-		argv++; argc--;
+		}
 	}
+
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
 	 * specified rev.max_count is reasonable (0 <= n <= 3), and
@@ -65,7 +67,7 @@ static int builtin_diff_files(struct rev
 	 */
 	if (revs->diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
 		revs->diffopt.output_format = DIFF_FORMAT_RAW;
-	return run_diff_files(revs, silent);
+	return run_diff_files(revs, dfeo.silent);
 }
 
 static void stuff_change(struct diff_options *opt,
@@ -107,14 +109,9 @@ static int builtin_diff_b_f(struct rev_i
 	/* Blob vs file in the working tree*/
 	struct stat st;
 
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	if (argc)
+		usage(builtin_diff_usage);
+
 	if (lstat(path, &st))
 		die("'%s': %s", path, strerror(errno));
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
@@ -135,14 +132,9 @@ static int builtin_diff_blobs(struct rev
 	/* Blobs */
 	unsigned mode = canon_mode(S_IFREG | 0644);
 
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	if (argc)
+		usage(builtin_diff_usage);
+
 	stuff_change(&revs->diffopt,
 		     mode, mode,
 		     blob[0].sha1, blob[1].sha1,
@@ -155,17 +147,19 @@ static int builtin_diff_blobs(struct rev
 static int builtin_diff_index(struct rev_info *revs,
 			      int argc, const char **argv)
 {
-	int cached = 0;
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--cached"))
-			cached = 1;
-		else if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
-		else
+	int i, cached = 0;
+
+	if (argc)
+		usage(builtin_diff_usage);
+
+	for (i = 1; i < ARRAY_SIZE(extra_diff_flags); i++) {
+		if (extra_diff_flags[i]) {
+			if (diff_index_opt_handler(NULL, i, &cached) > 0)
+				continue;
 			usage(builtin_diff_usage);
-		argv++; argc--;
+		}
 	}
+
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
@@ -183,14 +177,9 @@ static int builtin_diff_tree(struct rev_
 {
 	const unsigned char *(sha1[2]);
 	int swap = 1;
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+
+	if (argc)
+		usage(builtin_diff_usage);
 
 	/* We saw two trees, ent[0] and ent[1].
 	 * unless ent[0] is unintesting, they are swapped
@@ -212,14 +201,9 @@ static int builtin_diff_combined(struct 
 	const unsigned char (*parent)[20];
 	int i;
 
-	while (1 < argc) {
-		const char *arg = argv[1];
-		if (!strcmp(arg, "--raw"))
-			revs->diffopt.output_format = DIFF_FORMAT_RAW;
-		else
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	if (argc)
+		usage(builtin_diff_usage);
+
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	parent = xmalloc(ents * sizeof(*parent));
@@ -243,6 +227,27 @@ static void add_head(struct rev_info *re
 	add_object(obj, &revs->pending_objects, NULL, "HEAD");
 }
 
+static struct opt_spec * diff_combined_ost()
+{
+	struct opt_spec *rv, *tmp;
+
+	tmp = combine_opt_spec(diff_files_ost, diff_tree_ost);
+	rv = combine_opt_spec(tmp, diff_index_ost);
+	free(tmp);
+	return rv;
+}
+
+/* just set flags in here for use by the builtin_diff_* functions  */
+static int diff_combined_handler(struct gitopt_iterator *gi,
+				const int id, void *args)
+{
+	if (id > 0 && id < LAST_DIFF_EXTRA_ID) {
+		extra_diff_flags[id] = 1;
+		return 1;
+	}
+	return 0;
+}
+
 int cmd_diff(int argc, const char **argv, char **envp)
 {
 	struct rev_info rev;
@@ -250,6 +255,9 @@ int cmd_diff(int argc, const char **argv
 	int ents = 0, blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
+	struct exec_args *b;
+	struct opt_spec *ost = diff_combined_ost();
+	struct gitopt_extra ge = { ost, diff_combined_handler, NULL };
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -275,22 +283,14 @@ int cmd_diff(int argc, const char **argv
 	init_revisions(&rev);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	b = setup_revisions(argc, argv, &rev, NULL, &ge);
+	free(ost);
+
 	/* Do we have --cached and not have a pending object, then
 	 * default to HEAD by hand.  Eek.
 	 */
-	if (!rev.pending_objects) {
-		int i;
-		for (i = 1; i < argc; i++) {
-			const char *arg = argv[i];
-			if (!strcmp(arg, "--"))
-				break;
-			else if (!strcmp(arg, "--cached")) {
-				add_head(&rev);
-				break;
-			}
-		}
-	}
+	if (!rev.pending_objects && extra_diff_flags[opt_cached])
+		add_head(&rev);
 
 	for (list = rev.pending_objects; list; list = list->next) {
 		struct object *obj = list->item;
@@ -340,17 +340,17 @@ int cmd_diff(int argc, const char **argv
 	if (!ents) {
 		switch (blobs) {
 		case 0:
-			return builtin_diff_files(&rev, argc, argv);
+			return builtin_diff_files(&rev, b->argc, b->argv);
 			break;
 		case 1:
 			if (paths != 1)
 				usage(builtin_diff_usage);
-			return builtin_diff_b_f(&rev, argc, argv, blob, path);
+			return builtin_diff_b_f(&rev, b->argc, b->argv, blob, path);
 			break;
 		case 2:
 			if (paths)
 				usage(builtin_diff_usage);
-			return builtin_diff_blobs(&rev, argc, argv, blob);
+			return builtin_diff_blobs(&rev, b->argc, b->argv, blob);
 			break;
 		default:
 			usage(builtin_diff_usage);
@@ -359,10 +359,10 @@ int cmd_diff(int argc, const char **argv
 	else if (blobs)
 		usage(builtin_diff_usage);
 	else if (ents == 1)
-		return builtin_diff_index(&rev, argc, argv);
+		return builtin_diff_index(&rev, b->argc, b->argv);
 	else if (ents == 2)
-		return builtin_diff_tree(&rev, argc, argv, ent);
+		return builtin_diff_tree(&rev, b->argc, b->argv, ent);
 	else
-		return builtin_diff_combined(&rev, argc, argv, ent, ents);
+		return builtin_diff_combined(&rev, b->argc, b->argv, ent, ents);
 	usage(builtin_diff_usage);
 }
diff --git a/builtin-log.c b/builtin-log.c
index 69f2911..3cfc8ac 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -14,14 +14,15 @@ static int cmd_log_wc(int argc, const ch
 		      struct rev_info *rev)
 {
 	struct commit *commit;
+	struct exec_args *b;
 
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
-	argc = setup_revisions(argc, argv, rev, "HEAD");
+	b = setup_revisions(argc, argv, rev, "HEAD", NULL);
 
-	if (argc > 1)
-		die("unrecognized argument: %s", argv[1]);
+	if (b->argc > 1)
+		die("unrecognized argument: %s", b->argv[0]);
 
 	prepare_revision_walk(rev);
 	setup_pager();
diff --git a/commit.c b/commit.c
index 2717dd8..2343729 100644
--- a/commit.c
+++ b/commit.c
@@ -24,19 +24,19 @@ const char *commit_type = "commit";
 
 enum cmit_fmt get_commit_format(const char *arg)
 {
-	if (!*arg)
+	if (!arg)
 		return CMIT_FMT_DEFAULT;
-	if (!strcmp(arg, "=raw"))
+	if (!strcmp(arg, "raw"))
 		return CMIT_FMT_RAW;
-	if (!strcmp(arg, "=medium"))
+	if (!strcmp(arg, "medium"))
 		return CMIT_FMT_MEDIUM;
-	if (!strcmp(arg, "=short"))
+	if (!strcmp(arg, "short"))
 		return CMIT_FMT_SHORT;
-	if (!strcmp(arg, "=full"))
+	if (!strcmp(arg, "full"))
 		return CMIT_FMT_FULL;
-	if (!strcmp(arg, "=fuller"))
+	if (!strcmp(arg, "fuller"))
 		return CMIT_FMT_FULLER;
-	if (!strcmp(arg, "=oneline"))
+	if (!strcmp(arg, "oneline"))
 		return CMIT_FMT_ONELINE;
 	die("invalid --pretty format");
 }
diff --git a/diff-files.c b/diff-files.c
index b9d193d..431487b 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "gitopt/diff-files.h"
 
 static const char diff_files_usage[] =
 "git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
@@ -15,26 +16,18 @@ COMMON_DIFF_OPTIONS_HELP;
 int main(int argc, const char **argv)
 {
 	struct rev_info rev;
-	int silent = 0;
+	struct exec_args *b;
+	struct df_extra_opts dfeo = { &rev, 0 };
+	struct gitopt_extra ge = { diff_files_ost, diff_files_opt_handler,
+				   &dfeo };
 
 	git_config(git_diff_config);
 	init_revisions(&rev);
 	rev.abbrev = 0;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
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
+	b = setup_revisions(argc, argv, &rev, NULL, &ge);
+	if (b->argc)
+		usage(diff_files_usage);
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
 	 * rev.max_count is reasonable (0 <= n <= 3),
@@ -50,5 +43,5 @@ int main(int argc, const char **argv)
 	 */
 	if (rev.diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-	return run_diff_files(&rev, silent);
+	return run_diff_files(&rev, dfeo.silent);
 }
diff --git a/diff-index.c b/diff-index.c
index 8c9f601..987a00a 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -2,6 +2,7 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "gitopt/diff-index.h"
 
 static const char diff_cache_usage[] =
 "git-diff-index [-m] [--cached] "
@@ -12,21 +13,18 @@ int main(int argc, const char **argv)
 {
 	struct rev_info rev;
 	int cached = 0;
-	int i;
+	struct exec_args *b;
+	struct gitopt_extra ge = { diff_index_ost,
+				diff_index_opt_handler, &cached };
 
 	git_config(git_diff_config);
 	init_revisions(&rev);
 	rev.abbrev = 0;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-			
-		if (!strcmp(arg, "--cached"))
-			cached = 1;
-		else
-			usage(diff_cache_usage);
-	}
+	b = setup_revisions(argc, argv, &rev, NULL, &ge);
+	if (b->argc)
+		usage(diff_cache_usage);
+
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
diff --git a/diff-stages.c b/diff-stages.c
index dcd20e7..05129c5 100644
--- a/diff-stages.c
+++ b/diff-stages.c
@@ -4,6 +4,13 @@
 
 #include "cache.h"
 #include "diff.h"
+#include "gitopt.h"
+
+enum diff_stages_ost { opt_r = 1 };
+static const struct opt_spec diff_stages_ost[] = {
+	{ 0,	'r',	0,	0,	opt_r },
+	{ 0, 0 }
+};
 
 static struct diff_options diff_options;
 
@@ -59,40 +66,47 @@ int main(int ac, const char **av)
 	int stage1, stage2;
 	const char *prefix = setup_git_directory();
 	const char **pathspec = NULL;
+	struct exec_args *b;
+	struct opt_spec *ost;
+	struct gitopt_iterator gi;
+	int i;
 
 	git_config(git_diff_config);
 	read_cache();
 	diff_setup(&diff_options);
-	while (1 < ac && av[1][0] == '-') {
-		const char *arg = av[1];
-		if (!strcmp(arg, "-r"))
-			; /* as usual */
-		else {
-			int diff_opt_cnt;
-			diff_opt_cnt = diff_opt_parse(&diff_options,
-						      av+1, ac-1);
-			if (diff_opt_cnt < 0)
-				usage(diff_stages_usage);
-			else if (diff_opt_cnt) {
-				av += diff_opt_cnt;
-				ac -= diff_opt_cnt;
-				continue;
-			}
+
+	ost = combine_opt_spec(diff_ost, diff_stages_ost);
+	gitopt_iter_setup(&gi, ac, av);
+
+	for (b=gi.b; (i=gitopt_iter_parse(&gi, ost)); gitopt_iter_next(&gi)) {
+		switch (i) {
+		case GITOPT_NON_OPTION:
+			b->argv[b->argc++] = gi.argv[gi.pos];
+		case GITOPT_DD:
+		case opt_r: /* as usual */
+			break;
+		case GITOPT_ERROR:
+			usage(diff_stages_usage);
+		default:
+			i = diff_opt_handler(&gi, i, &diff_options);
+			if (i > 0)
+				gi.pos += i - 1;
 			else
 				usage(diff_stages_usage);
 		}
-		ac--; av++;
 	}
+	gitopt_iter_done(&gi);
+	free(ost);
 
-	if (ac < 3 ||
-	    sscanf(av[1], "%d", &stage1) != 1 ||
+	if (b->argc < 2 ||
+	    sscanf(b->argv[0], "%d", &stage1) != 1 ||
 	    ! (0 <= stage1 && stage1 <= 3) ||
-	    sscanf(av[2], "%d", &stage2) != 1 ||
+	    sscanf(b->argv[1], "%d", &stage2) != 1 ||
 	    ! (0 <= stage2 && stage2 <= 3))
 		usage(diff_stages_usage);
 
-	av += 3; /* The rest from av[0] are for paths restriction. */
-	pathspec = get_pathspec(prefix, av);
+	b->argv += 2; /* The rest from b->argv[0] are for paths restriction. */
+	pathspec = get_pathspec(prefix, b->argv);
 
 	if (diff_setup_done(&diff_options) < 0)
 		usage(diff_stages_usage);
diff --git a/diff-tree.c b/diff-tree.c
index 7207867..b5c6072 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -2,6 +2,7 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
+#include "gitopt/diff-tree.h"
 
 static struct rev_info log_tree_opt;
 
@@ -66,23 +67,19 @@ int main(int argc, const char **argv)
 	static struct rev_info *opt = &log_tree_opt;
 	struct object_list *list;
 	int read_stdin = 0;
+	struct exec_args *b;
+	struct gitopt_extra ge = { diff_tree_ost, diff_tree_opt_handler,
+				&read_stdin };
 
 	git_config(git_diff_config);
 	nr_sha1 = 0;
 	init_revisions(opt);
 	opt->abbrev = 0;
 	opt->diff = 1;
-	argc = setup_revisions(argc, argv, opt, NULL);
+	b = setup_revisions(argc, argv, opt, NULL, &ge);
 
-	while (--argc > 0) {
-		const char *arg = *++argv;
-
-		if (!strcmp(arg, "--stdin")) {
-			read_stdin = 1;
-			continue;
-		}
+	if (b->argc)
 		usage(diff_tree_usage);
-	}
 
 	/*
 	 * NOTE! "setup_revisions()" will have inserted the revisions
diff --git a/diff.c b/diff.c
index 7a7b839..7d88dc5 100644
--- a/diff.c
+++ b/diff.c
@@ -10,6 +10,48 @@ #include "diff.h"
 #include "diffcore.h"
 #include "delta.h"
 #include "xdiff-interface.h"
+#include "gitopt.h"
+
+static int diff_scoreopt_parse(const int id, const char *opt);
+
+enum diff_ost_ids {
+	opt_p = GITOPT_DIFF_BASE, opt_raw, opt_patch_with_raw,
+	opt_stat, opt_patch_with_stat,
+	opt_z, opt_l, opt_full_index, opt_name_only, opt_name_status,
+	opt_R, opt_S, opt_s, opt_O, opt_diff_filter,
+	opt_pickaxe_all, opt_pickaxe_regex,
+	opt_B, opt_M, opt_C, opt_find_copies_harder, opt_abbrev,
+	opt_binary
+};
+
+const struct opt_spec diff_ost[] = {
+	{ 0,			'p',	0,	0,	opt_p },
+	{ "unified",		'u',	0,	0,	opt_p },
+	{ "raw",		0,	0,	0,	opt_raw },
+	{ "patch-with-raw",	0,	0,	0,	opt_patch_with_raw },
+	{ "stat",		0,	0,	0,	opt_stat },
+	{ "patch-with-stat",	0,	0,	0,	opt_patch_with_stat },
+	{ 0,			'z',	0,	0,	opt_z },
+	{ 0,			'l',	0,	ARG_INT,	opt_l },
+	{ "full-index",		0,	0,	0,	opt_full_index },
+	{ "name-only",		0,	0,	0,	opt_name_only },
+	{ "name-status",	0,	0,	0,	opt_name_status },
+	{ 0,			'R',	0,	0,	opt_R },
+	{ 0,			'S',	0,	ARG_ONE,	opt_S },
+	{ 0,			's',	0,	0,	opt_s },
+	{ 0,			'O',	0,	ARG_ONE, opt_O },
+	{ "diff-filter",	0,	0,	ARG_ONE, opt_diff_filter },
+	{ "pickaxe-all",	0,	0,	0,	opt_pickaxe_all },
+	{ "pickaxe-regex",	0,	0,	0,	opt_pickaxe_regex },
+	{ 0,			'B',	0,	ARG_OPT,	opt_B },
+	{ 0,			'M',	0,	ARG_OPT,	opt_M },
+	{ 0,			'C',	0,	ARG_OPT,	opt_C },
+	{ "find-copies-harder",	0,	0,	0,	opt_find_copies_harder},
+	{ "abbrev",		0,	0,	ARG_OPTINT, opt_abbrev },
+	{ "binary",		0,	0,	0,	opt_binary },
+	{ 0, 0 }
+};
+
 
 static int use_size_cache;
 
@@ -1222,79 +1264,102 @@ int diff_setup_done(struct diff_options 
 	return 0;
 }
 
-int diff_opt_parse(struct diff_options *options, const char **av, int ac)
+int diff_opt_handler(struct gitopt_iterator *gi, const int id, void *args)
 {
-	const char *arg = av[0];
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
+	struct diff_options *options = (struct diff_options *)args;
+
+	switch (id) {
+	case opt_p:
 		options->output_format = DIFF_FORMAT_PATCH;
-	else if (!strcmp(arg, "--patch-with-raw")) {
+		break;
+	case opt_raw:
+		options->output_format = DIFF_FORMAT_RAW;
+		break;
+	case opt_patch_with_raw:
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_raw = 1;
-	}
-	else if (!strcmp(arg, "--stat"))
+		break;
+	case opt_stat:
 		options->output_format = DIFF_FORMAT_DIFFSTAT;
-	else if (!strcmp(arg, "--patch-with-stat")) {
+		break;
+	case opt_patch_with_stat:
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->with_stat = 1;
-	}
-	else if (!strcmp(arg, "-z"))
+		break;
+	case opt_z:
 		options->line_termination = 0;
-	else if (!strncmp(arg, "-l", 2))
-		options->rename_limit = strtoul(arg+2, NULL, 10);
-	else if (!strcmp(arg, "--full-index"))
+		break;
+	case opt_l:
+		options->rename_limit = strtoul(gi->ea->argv[0], NULL, 10);
+		break;
+	case opt_full_index:
 		options->full_index = 1;
-	else if (!strcmp(arg, "--binary")) {
+		break;
+	case opt_binary:
 		options->output_format = DIFF_FORMAT_PATCH;
 		options->full_index = options->binary = 1;
-	}
-	else if (!strcmp(arg, "--name-only"))
+		break;
+	case opt_name_only:
 		options->output_format = DIFF_FORMAT_NAME;
-	else if (!strcmp(arg, "--name-status"))
+		break;
+	case opt_name_status:
 		options->output_format = DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-R"))
+		break;
+	case opt_R:
 		options->reverse_diff = 1;
-	else if (!strncmp(arg, "-S", 2))
-		options->pickaxe = arg + 2;
-	else if (!strcmp(arg, "-s"))
+		break;
+	case opt_S:
+		options->pickaxe = gi->ea->argv[0];
+		break;
+	case opt_s:
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
-	else if (!strncmp(arg, "-O", 2))
-		options->orderfile = arg + 2;
-	else if (!strncmp(arg, "--diff-filter=", 14))
-		options->filter = arg + 14;
-	else if (!strcmp(arg, "--pickaxe-all"))
+		break;
+	case opt_O:
+		options->orderfile = gi->ea->argv[0];
+		break;
+	case opt_diff_filter:
+		options->filter = gi->ea->argv[0];
+		break;
+	case opt_pickaxe_all:
 		options->pickaxe_opts = DIFF_PICKAXE_ALL;
-	else if (!strcmp(arg, "--pickaxe-regex"))
+		break;
+	case opt_pickaxe_regex:
 		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
-	else if (!strncmp(arg, "-B", 2)) {
-		if ((options->break_opt =
-		     diff_scoreopt_parse(arg)) == -1)
+		break;
+	case opt_B:
+		if (gi->ea->argc && (options->break_opt =
+		     diff_scoreopt_parse(id, gi->ea->argv[1])) == -1)
 			return -1;
-	}
-	else if (!strncmp(arg, "-M", 2)) {
-		if ((options->rename_score =
-		     diff_scoreopt_parse(arg)) == -1)
+		break;
+	case opt_M:
+		if (gi->ea->argc && (options->rename_score =
+		     diff_scoreopt_parse(id, gi->ea->argv[1])) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_RENAME;
-	}
-	else if (!strncmp(arg, "-C", 2)) {
-		if ((options->rename_score =
-		     diff_scoreopt_parse(arg)) == -1)
+		break;
+	case opt_C:
+		if (gi->ea->argc && (options->rename_score =
+		     diff_scoreopt_parse(id, gi->ea->argv[1])) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_COPY;
-	}
-	else if (!strcmp(arg, "--find-copies-harder"))
+		break;
+	case opt_find_copies_harder:
 		options->find_copies_harder = 1;
-	else if (!strcmp(arg, "--abbrev"))
-		options->abbrev = DEFAULT_ABBREV;
-	else if (!strncmp(arg, "--abbrev=", 9)) {
-		options->abbrev = strtoul(arg + 9, NULL, 10);
-		if (options->abbrev < MINIMUM_ABBREV)
-			options->abbrev = MINIMUM_ABBREV;
-		else if (40 < options->abbrev)
-			options->abbrev = 40;
-	}
-	else
+		break;
+	case opt_abbrev:
+		if (gi->ea->argc == 1)
+			options->abbrev = DEFAULT_ABBREV;
+		else {
+			options->abbrev = strtoul(gi->ea->argv[1], NULL, 10);
+			if (options->abbrev < MINIMUM_ABBREV)
+				options->abbrev = MINIMUM_ABBREV;
+			else if (40 < options->abbrev)
+				options->abbrev = 40;
+		}
+		break;
+	default:
 		return 0;
+	}
 	return 1;
 }
 
@@ -1304,9 +1369,13 @@ static int parse_num(const char **cp_p)
 	int ch, dot;
 	const char *cp = *cp_p;
 
+	if (!cp)
+		return 0;
+
 	num = 0;
 	scale = 1;
 	dot = 0;
+
 	for(;;) {
 		ch = *cp;
 		if ( !dot && ch == '.' ) {
@@ -1334,21 +1403,15 @@ static int parse_num(const char **cp_p)
 	return (num >= scale) ? MAX_SCORE : (MAX_SCORE * num / scale);
 }
 
-int diff_scoreopt_parse(const char *opt)
+static int diff_scoreopt_parse(const int id, const char *opt)
 {
-	int opt1, opt2, cmd;
-
-	if (*opt++ != '-')
-		return -1;
-	cmd = *opt++;
-	if (cmd != 'M' && cmd != 'C' && cmd != 'B')
-		return -1; /* that is not a -M, -C nor -B option */
+	int opt1, opt2;
 
 	opt1 = parse_num(&opt);
-	if (cmd != 'B')
+	if (id != opt_B)
 		opt2 = 0;
 	else {
-		if (*opt == 0)
+		if (!opt || *opt == 0)
 			opt2 = 0;
 		else if (*opt != '/')
 			return -1; /* we expect -B80/99 or -B80 */
@@ -1357,7 +1420,7 @@ int diff_scoreopt_parse(const char *opt)
 			opt2 = parse_num(&opt);
 		}
 	}
-	if (*opt != 0)
+	if (opt && *opt != 0)
 		return -1;
 	return opt1 | (opt2 << 16);
 }
diff --git a/diff.h b/diff.h
index d052608..fa44d1b 100644
--- a/diff.h
+++ b/diff.h
@@ -5,6 +5,7 @@ #ifndef DIFF_H
 #define DIFF_H
 
 #include "tree-walk.h"
+#include "gitopt.h"
 
 struct rev_info;
 struct diff_options;
@@ -96,15 +97,13 @@ extern void diff_change(struct diff_opti
 extern void diff_unmerge(struct diff_options *,
 			 const char *path);
 
-extern int diff_scoreopt_parse(const char *opt);
-
 #define DIFF_SETUP_REVERSE      	1
 #define DIFF_SETUP_USE_CACHE		2
 #define DIFF_SETUP_USE_SIZE_CACHE	4
 
 extern int git_diff_config(const char *var, const char *value);
 extern void diff_setup(struct diff_options *);
-extern int diff_opt_parse(struct diff_options *, const char **, int);
+extern int diff_opt_handler(struct gitopt_iterator *, const int, void *);
 extern int diff_setup_done(struct diff_options *);
 
 #define DIFF_DETECT_RENAME	1
@@ -117,6 +116,8 @@ extern void diffcore_std(struct diff_opt
 
 extern void diffcore_std_no_resolve(struct diff_options *);
 
+extern const struct opt_spec diff_ost[];
+
 #define COMMON_DIFF_OPTIONS_HELP \
 "\ncommon diff options:\n" \
 "  -z            output diff-raw with lines terminated with NUL.\n" \
diff --git a/gitopt/diff-files.h b/gitopt/diff-files.h
new file mode 100644
index 0000000..85c84ba
--- /dev/null
+++ b/gitopt/diff-files.h
@@ -0,0 +1,45 @@
+#ifndef GITOPT_DIFF_FILES_H
+#define GITOPT_DIFF_FILES_H
+
+#include "../gitopt/diff.h"
+#include "../revision.h"
+
+struct df_extra_opts {
+	struct rev_info *rev;
+	int silent;
+};
+
+static const struct opt_spec diff_files_ost[] = {
+	{ "base",	0,	0,	0,	opt_base },
+	{ "ours",	0,	0,	0,	opt_ours },
+	{ "theirs",	0,	0,	0,	opt_theirs },
+	{ 0,		'q',	0,	0,	opt_q },
+	{ 0, 0 }
+};
+
+static int diff_files_opt_handler(struct gitopt_iterator *gi,
+				const int id, void *args)
+{
+	int rv = 1;
+	struct df_extra_opts *dfeo = (struct df_extra_opts *)args;
+
+	switch (id) {
+	case opt_base:
+		dfeo->rev->max_count = 1;
+		break;
+	case opt_ours:
+		dfeo->rev->max_count = 2;
+		break;
+	case opt_theirs:
+		dfeo->rev->max_count = 3;
+		break;
+	case opt_q:
+		dfeo->silent = 1;
+		break;
+	default:
+		rv = 0;
+	}
+	return rv;
+}
+
+#endif
diff --git a/gitopt/diff-index.h b/gitopt/diff-index.h
new file mode 100644
index 0000000..aff0944
--- /dev/null
+++ b/gitopt/diff-index.h
@@ -0,0 +1,22 @@
+#ifndef GITOPT_DIFF_INDEX_H
+#define GITOPT_DIFF_INDEX_H
+
+#include "../gitopt/diff.h"
+
+static const struct opt_spec diff_index_ost[] = {
+	{ "cached",	0,	0,	0,	opt_cached },
+	{ 0, 0 }
+};
+
+static int diff_index_opt_handler(struct gitopt_iterator *gi,
+				const int id, void *args)
+{
+	if (id == opt_cached) {
+		*(int *)args = 1;
+		return 1;
+	}
+	return 0;
+}
+
+#endif
+
diff --git a/gitopt/diff-tree.h b/gitopt/diff-tree.h
new file mode 100644
index 0000000..cfee9b5
--- /dev/null
+++ b/gitopt/diff-tree.h
@@ -0,0 +1,22 @@
+#ifndef GITOPT_DIFF_TREE_H
+#define GITOPT_DIFF_TREE_H
+
+#include "../gitopt/diff.h"
+
+static const struct opt_spec diff_tree_ost[] = {
+	{ "stdin",	0,	0,	0,	opt_stdin },
+	{ 0, 0 }
+};
+
+/* inline to suppress a warning as it's not used in builtin_diff_tree */
+static inline int diff_tree_opt_handler(struct gitopt_iterator *gi,
+				const int id, void *args)
+{
+	if (id == opt_stdin) {
+		*(int *)args = 1;
+		return 1;
+	}
+	return 0;
+}
+
+#endif
diff --git a/gitopt/diff.h b/gitopt/diff.h
new file mode 100644
index 0000000..abc2c7a
--- /dev/null
+++ b/gitopt/diff.h
@@ -0,0 +1,19 @@
+#ifndef GITOPT_DIFF_H
+#define GITOPT_DIFF_H
+
+#include "../gitopt.h"
+
+enum diff_extra_ids {
+	/* diff-files */
+	opt_base = 1, opt_ours, opt_theirs, opt_q,
+
+	/* diff-tree */
+	opt_stdin,
+
+	/* diff-index */
+	opt_cached,
+
+	LAST_DIFF_EXTRA_ID,
+};
+
+#endif /* GITOPT_DIFF_H */
diff --git a/http-push.c b/http-push.c
index b4327d9..9c16f3b 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2499,7 +2499,7 @@ int main(int argc, char **argv)
 			commit_argc++;
 		}
 		init_revisions(&revs);
-		setup_revisions(commit_argc, commit_argv, &revs, NULL);
+		setup_revisions(commit_argc, commit_argv, &revs, NULL, NULL);
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
 			free(old_sha1_hex);
diff --git a/rev-list.c b/rev-list.c
index 8b0ec38..7baeb52 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -291,34 +291,49 @@ static void mark_edges_uninteresting(str
 	}
 }
 
+enum rev_list_ids { opt_header = 1, opt_timestamp, opt_bisect };
+
+static const struct opt_spec rev_list_ost[] = {
+	{ "header",	0,	0,	0,	opt_header },
+	{ "timestamp",	0,	0,	0,	opt_timestamp },
+	{ "bisect",	0,	0,	0,	opt_bisect },
+	{ 0, 0 }
+};
+
+static int rev_list_opt_handler(struct gitopt_iterator *gi,
+				const int id, void *args)
+{
+	int rv = 1;
+	switch (id) {
+	case opt_header:
+		revs.verbose_header = 1;
+		break;
+	case opt_timestamp:
+		show_timestamp = 1;
+		break;
+	case opt_bisect:
+		bisect_list = 1;
+		break;
+	default:
+		rv = 0;
+	}
+	return rv;
+}
+
 int main(int argc, const char **argv)
 {
 	struct commit_list *list;
-	int i;
+	struct exec_args *b;
+	struct gitopt_extra ge = { rev_list_ost, rev_list_opt_handler, NULL };
 
 	init_revisions(&revs);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
-	argc = setup_revisions(argc, argv, &revs, NULL);
-
-	for (i = 1 ; i < argc; i++) {
-		const char *arg = argv[i];
+	b = setup_revisions(argc, argv, &revs, NULL, &ge);
 
-		if (!strcmp(arg, "--header")) {
-			revs.verbose_header = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--timestamp")) {
-			show_timestamp = 1;
-			continue;
-		}
-		if (!strcmp(arg, "--bisect")) {
-			bisect_list = 1;
-			continue;
-		}
+	if (b->argc)
 		usage(rev_list_usage);
 
-	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
 		hdr_termination = '\n';
diff --git a/revision.c b/revision.c
index 2294b16..aeaf52c 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,7 @@ #include "commit.h"
 #include "diff.h"
 #include "refs.h"
 #include "revision.h"
+#include "gitopt.h"
 
 static char *path_name(struct name_path *path, const char *name)
 {
@@ -534,6 +535,136 @@ void init_revisions(struct rev_info *rev
 	diff_setup(&revs->diffopt);
 }
 
+enum setup_revision_ost_ids {
+	opt_max_count = GITOPT_SR_BASE, opt_max_age, opt_min_age,
+	opt_since, opt_until, opt_all, opt_not, opt_default,
+	opt_topo_order, opt_date_order, opt_parents, opt_dense,
+	opt_sparse, opt_remove_empty, opt_no_merges, opt_boundary,
+	opt_objects, opt_objects_edge, opt_unpacked,
+	opt_r, opt_t, opt_m, opt_c, opt_cc, opt_v,
+	opt_pretty, opt_root, opt_no_commit_id, opt_always,
+	opt_abbrev, opt_no_abbrev, opt_abbrev_commit, opt_full_diff
+};
+
+static const struct opt_spec setup_revisions_ost[] = {
+	{ "max-count",		'n',	0,	ARG_INT,	opt_max_count },
+	{ 0,			' ',	0,	ARG_INT,	opt_max_count },
+	{ "max-age",		0,	0,	ARG_INT,	opt_max_age },
+	{ "min-age",		0,	0,	ARG_INT,	opt_min_age },
+	{ "since",		0,	0,	ARG_ONE,	opt_since },
+	{ "after",		0,	0,	ARG_ONE,	opt_since },
+	{ "before",		0,	0,	ARG_ONE,	opt_until },
+	{ "until",		0,	0,	ARG_ONE,	opt_until },
+	{ "all",		0,	0,	0,		opt_all },
+	{ "not",		0,	0,	0,		opt_not },
+	{ "default",		0,	0,	ARG_ONE,	opt_default },
+	{ "topo-order",		0,	0,	0,	opt_topo_order },
+	{ "date-order",		0,	0,	0,	opt_date_order },
+	{ "parents",		0,	0,	0,	opt_parents },
+	{ "dense",		0,	0,	0,	opt_dense },
+	{ "sparse",		0,	0,	0,	opt_sparse },
+	{ "remove-empty",	0,	0,	0,	opt_remove_empty },
+	{ "no-merges",		0,	0,	0,	opt_no_merges },
+	{ "boundary",		0,	0,	0,	opt_boundary },
+	{ "objects",		0,	0,	0,	opt_objects },
+	{ "objects-edge",	0,	0,	0,	opt_objects_edge },
+	{ "unpacked",		0,	0,	0,	opt_unpacked },
+	{ 0,			'r',	0,	0,	opt_r },
+	{ 0,			't',	0,	0,	opt_t },
+	{ 0,			'm',	0,	0,	opt_m },
+	{ 0,			'c',	0,	0,	opt_c },
+	{ "cc",			0,	0,	0,	opt_cc },
+	{ 0,			'v',	0,	0,	opt_v },
+	{ "pretty",		0,	0,	ARG_OPT,	opt_pretty },
+	{ "root",		0,	0,	0,	opt_root },
+	{ "no-commit-id",	0,	0,	0,	opt_no_commit_id },
+	{ "always",		0,	0,	0,	opt_always },
+	{ "no-abbrev",		0,	0,	0,	opt_no_abbrev },
+	{ "abbrev",		0,	0,	0,	opt_abbrev },
+	{ "abbrev-commit",	0,	0,	0,	opt_abbrev_commit },
+	{ "full-diff",		0,	0,	0,	opt_full_diff },
+	{ 0, 0 }
+};
+
+static int setup_revision(struct gitopt_iterator *gi, struct rev_info *revs,
+			int flags, int seen_dashdash)
+{
+	const char *arg = gi->argv[gi->pos];
+	unsigned char sha1[20];
+	struct object *object;
+	char *dotdot;
+	int local_flags;
+
+	dotdot = strstr(arg, "..");
+	if (dotdot) {
+		unsigned char from_sha1[20];
+		const char *next = dotdot + 2;
+		const char *this = arg;
+		*dotdot = 0;
+		if (!*next)
+			next = "HEAD";
+		if (dotdot == arg)
+			this = "HEAD";
+		if (!get_sha1(this, from_sha1) &&
+		    !get_sha1(next, sha1)) {
+			struct object *exclude;
+			struct object *include;
+
+			exclude = get_reference(revs, this, from_sha1,
+						flags ^ UNINTERESTING);
+			include = get_reference(revs, next, sha1, flags);
+			if (!exclude || !include)
+				die("Invalid revision range %s..%s", arg, next);
+
+			if (!seen_dashdash) {
+				*dotdot = '.';
+				verify_non_filename(revs->prefix, arg);
+			}
+			add_pending_object(revs, exclude, this);
+			add_pending_object(revs, include, next);
+			return 1;
+		}
+		*dotdot = '.';
+	}
+
+	dotdot = strstr(arg, "^@");
+	if (dotdot && !dotdot[2]) {
+		*dotdot = 0;
+		if (add_parents_only(revs, arg, flags))
+			return 1;
+		*dotdot = '^';
+	}
+	local_flags = 0;
+	if (*arg == '^') {
+		local_flags = UNINTERESTING;
+		arg++;
+	}
+	if (get_sha1(arg, sha1) < 0) {
+		int j;
+
+		if (seen_dashdash || local_flags)
+			die("bad revision '%s'", arg);
+
+		/* If we didn't have a "--":
+		 * (1) all filenames must exist;
+		 * (2) all rev-args must not be interpretable
+		 *     as a valid filename.
+		 * but the latter we have checked in the main loop.
+		 */
+		for (j = gi->pos; j < gi->argc; j++)
+			verify_filename(revs->prefix, gi->argv[j]);
+
+		revs->prune_data = get_pathspec(revs->prefix,
+						gi->argv + gi->pos);
+		return 1;
+	}
+	if (!seen_dashdash)
+		verify_non_filename(revs->prefix, arg);
+	object = get_reference(revs, arg, sha1, flags ^ local_flags);
+	add_pending_object(revs, object, arg);
+	return 1;
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -541,11 +672,14 @@ void init_revisions(struct rev_info *rev
  * Returns the number of arguments left that weren't recognized
  * (which are also moved to the head of the argument list)
  */
-int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
+struct exec_args *setup_revisions(int argc, const char **argv,
+					struct rev_info *revs, const char *def,
+					const struct gitopt_extra *ge)
 {
-	int i, flags, seen_dashdash;
-	const char **unrecognized = argv + 1;
-	int left = 1;
+	int i, id, flags, seen_dashdash;
+	struct gitopt_iterator gi;
+	struct exec_args *ea, *b;
+	struct opt_spec *ost;
 
 	/* First, search for "--" */
 	seen_dashdash = 0;
@@ -561,261 +695,158 @@ int setup_revisions(int argc, const char
 	}
 
 	flags = 0;
-	for (i = 1; i < argc; i++) {
-		struct object *object;
-		const char *arg = argv[i];
-		unsigned char sha1[20];
-		char *dotdot;
-		int local_flags;
+	ost = combine_opt_spec(setup_revisions_ost, diff_ost);
+	if (ge) {
+		struct opt_spec *tmp = ost;
+		ost = combine_opt_spec(tmp, ge->ost);
+		free(tmp);
+	}
 
-		if (*arg == '-') {
-			int opts;
-			if (!strncmp(arg, "--max-count=", 12)) {
-				revs->max_count = atoi(arg + 12);
-				continue;
-			}
-			/* accept -<digit>, like traditional "head" */
-			if ((*arg == '-') && isdigit(arg[1])) {
-				revs->max_count = atoi(arg + 1);
-				continue;
-			}
-			if (!strcmp(arg, "-n")) {
-				if (argc <= i + 1)
-					die("-n requires an argument");
-				revs->max_count = atoi(argv[++i]);
-				continue;
-			}
-			if (!strncmp(arg,"-n",2)) {
-				revs->max_count = atoi(arg + 2);
-				continue;
-			}
-			if (!strncmp(arg, "--max-age=", 10)) {
-				revs->max_age = atoi(arg + 10);
-				continue;
-			}
-			if (!strncmp(arg, "--since=", 8)) {
-				revs->max_age = approxidate(arg + 8);
-				continue;
-			}
-			if (!strncmp(arg, "--after=", 8)) {
-				revs->max_age = approxidate(arg + 8);
-				continue;
-			}
-			if (!strncmp(arg, "--min-age=", 10)) {
-				revs->min_age = atoi(arg + 10);
-				continue;
-			}
-			if (!strncmp(arg, "--before=", 9)) {
-				revs->min_age = approxidate(arg + 9);
-				continue;
-			}
-			if (!strncmp(arg, "--until=", 8)) {
-				revs->min_age = approxidate(arg + 8);
-				continue;
-			}
-			if (!strcmp(arg, "--all")) {
-				handle_all(revs, flags);
-				continue;
-			}
-			if (!strcmp(arg, "--not")) {
-				flags ^= UNINTERESTING;
-				continue;
-			}
-			if (!strcmp(arg, "--default")) {
-				if (++i >= argc)
-					die("bad --default argument");
-				def = argv[i];
-				continue;
-			}
-			if (!strcmp(arg, "--topo-order")) {
-				revs->topo_order = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--date-order")) {
-				revs->lifo = 0;
-				revs->topo_order = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--parents")) {
-				revs->parents = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--dense")) {
-				revs->dense = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--sparse")) {
-				revs->dense = 0;
-				continue;
-			}
-			if (!strcmp(arg, "--remove-empty")) {
-				revs->remove_empty_trees = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--no-merges")) {
-				revs->no_merges = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--boundary")) {
-				revs->boundary = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--objects")) {
-				revs->tag_objects = 1;
-				revs->tree_objects = 1;
-				revs->blob_objects = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--objects-edge")) {
-				revs->tag_objects = 1;
-				revs->tree_objects = 1;
-				revs->blob_objects = 1;
-				revs->edge_hint = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--unpacked")) {
-				revs->unpacked = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-r")) {
-				revs->diff = 1;
-				revs->diffopt.recursive = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-t")) {
-				revs->diff = 1;
-				revs->diffopt.recursive = 1;
-				revs->diffopt.tree_in_recursive = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-m")) {
-				revs->ignore_merges = 0;
-				continue;
-			}
-			if (!strcmp(arg, "-c")) {
-				revs->diff = 1;
-				revs->dense_combined_merges = 0;
-				revs->combine_merges = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--cc")) {
-				revs->diff = 1;
-				revs->dense_combined_merges = 1;
-				revs->combine_merges = 1;
-				continue;
-			}
-			if (!strcmp(arg, "-v")) {
-				revs->verbose_header = 1;
-				continue;
-			}
-			if (!strncmp(arg, "--pretty", 8)) {
-				revs->verbose_header = 1;
-				revs->commit_format = get_commit_format(arg+8);
-				continue;
-			}
-			if (!strcmp(arg, "--root")) {
-				revs->show_root_diff = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--no-commit-id")) {
-				revs->no_commit_id = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--always")) {
-				revs->always_show_header = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--no-abbrev")) {
-				revs->abbrev = 0;
-				continue;
-			}
-			if (!strcmp(arg, "--abbrev")) {
+	gitopt_iter_setup(&gi, argc, argv);
+	ea = gi.ea;
+	b = gi.b;
+	for (; (id = gitopt_iter_parse(&gi, ost)); gitopt_iter_next(&gi)) {
+		switch (id) {
+		case opt_max_count:
+			revs->max_count = atoi(ea->argv[0]);
+			break;
+		case opt_max_age:
+			revs->max_age = atoi(ea->argv[0]);
+			break;
+		case opt_min_age:
+			revs->min_age = atoi(ea->argv[0]);
+			break;
+		case opt_since:
+			revs->max_age = approxidate(ea->argv[0]);
+			break;
+		case opt_until:
+			revs->min_age = approxidate(ea->argv[0]);
+			break;
+		case opt_all:
+			handle_all(revs, flags);
+			break;
+		case opt_not:
+			flags ^= UNINTERESTING;
+			break;
+		case opt_default:
+			if (!ea->argc)
+				die("bad --default argument");
+			def = ea->argv[0];
+			break;
+		case opt_topo_order:
+			revs->topo_order = 1;
+			break;
+		case opt_date_order:
+			revs->lifo = 0;
+			revs->topo_order = 1;
+			break;
+		case opt_parents:
+			revs->parents = 1;
+			break;
+		case opt_dense:
+			revs->dense = 1;
+			break;
+		case opt_sparse:
+			revs->dense = 0;
+			break;
+		case opt_remove_empty:
+			revs->remove_empty_trees = 1;
+			break;
+		case opt_no_merges:
+			revs->no_merges = 1;
+			break;
+		case opt_boundary:
+			revs->boundary = 1;
+			break;
+		case opt_objects_edge:
+			revs->edge_hint = 1; /* fall through */
+		case opt_objects:
+			revs->tag_objects = 1;
+			revs->tree_objects = 1;
+			revs->blob_objects = 1;
+			break;
+		case opt_unpacked:
+			revs->unpacked = 1;
+			break;
+		case opt_r:
+			revs->diff = 1;
+			revs->diffopt.recursive = 1;
+			break;
+		case opt_t:
+			revs->diff = 1;
+			revs->diffopt.recursive = 1;
+			revs->diffopt.tree_in_recursive = 1;
+			break;
+		case opt_m:
+			revs->ignore_merges = 0;
+			break;
+		case opt_c:
+			revs->diff = 1;
+			revs->dense_combined_merges = 0;
+			revs->combine_merges = 1;
+			break;
+		case opt_cc:
+			revs->diff = 1;
+			revs->dense_combined_merges = 1;
+			revs->combine_merges = 1;
+			break;
+		case opt_v:
+			revs->verbose_header = 1;
+			break;
+		case opt_pretty:
+			revs->verbose_header = 1;
+			revs->commit_format = get_commit_format(ea->argv[1]);
+			break;
+		case opt_root:
+			revs->show_root_diff = 1;
+			break;
+		case opt_no_commit_id:
+			revs->no_commit_id = 1;
+			break;
+		case opt_always:
+			revs->always_show_header = 1;
+			break;
+		case opt_no_abbrev:
+			revs->abbrev = 0;
+			break;
+		case opt_abbrev_commit:
+			revs->abbrev_commit = 1;
+			break;
+		case opt_full_diff:
+			revs->diff = 1;
+			revs->full_diff = 1;
+			break;
+		case opt_abbrev:
+			if (ea->argc == 1)
 				revs->abbrev = DEFAULT_ABBREV;
-				continue;
+			else {
+				revs->abbrev = strtoul(ea->argv[1], NULL, 10);
+				if (revs->abbrev < MINIMUM_ABBREV)
+					revs->abbrev = MINIMUM_ABBREV;
+				else if (40 < revs->abbrev)
+					revs->abbrev = 40;
 			}
-			if (!strcmp(arg, "--abbrev-commit")) {
-				revs->abbrev_commit = 1;
-				continue;
-			}
-			if (!strcmp(arg, "--full-diff")) {
-				revs->diff = 1;
-				revs->full_diff = 1;
-				continue;
-			}
-			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
-			if (opts > 0) {
-				revs->diff = 1;
-				i += opts - 1;
-				continue;
-			}
-			*unrecognized++ = arg;
-			left++;
-			continue;
-		}
-		dotdot = strstr(arg, "..");
-		if (dotdot) {
-			unsigned char from_sha1[20];
-			const char *next = dotdot + 2;
-			const char *this = arg;
-			*dotdot = 0;
-			if (!*next)
-				next = "HEAD";
-			if (dotdot == arg)
-				this = "HEAD";
-			if (!get_sha1(this, from_sha1) &&
-			    !get_sha1(next, sha1)) {
-				struct object *exclude;
-				struct object *include;
-
-				exclude = get_reference(revs, this, from_sha1, flags ^ UNINTERESTING);
-				include = get_reference(revs, next, sha1, flags);
-				if (!exclude || !include)
-					die("Invalid revision range %s..%s", arg, next);
-
-				if (!seen_dashdash) {
-					*dotdot = '.';
-					verify_non_filename(revs->prefix, arg);
-				}
-				add_pending_object(revs, exclude, this);
-				add_pending_object(revs, include, next);
-				continue;
-			}
-			*dotdot = '.';
-		}
-		dotdot = strstr(arg, "^@");
-		if (dotdot && !dotdot[2]) {
-			*dotdot = 0;
-			if (add_parents_only(revs, arg, flags))
-				continue;
-			*dotdot = '^';
-		}
-		local_flags = 0;
-		if (*arg == '^') {
-			local_flags = UNINTERESTING;
-			arg++;
-		}
-		if (get_sha1(arg, sha1)) {
-			int j;
-
-			if (seen_dashdash || local_flags)
-				die("bad revision '%s'", arg);
-
-			/* If we didn't have a "--":
-			 * (1) all filenames must exist;
-			 * (2) all rev-args must not be interpretable
-			 *     as a valid filename.
-			 * but the latter we have checked in the main loop.
-			 */
-			for (j = i; j < argc; j++)
-				verify_filename(revs->prefix, argv[j]);
-
-			revs->prune_data = get_pathspec(revs->prefix, argv + i);
 			break;
+		case GITOPT_NON_OPTION:
+			/* fprintf(stderr,"no: %s\n",gi.argv[gi.pos]); */
+			i = setup_revision(&gi, revs, flags, seen_dashdash);
+			gi.pos += i - 1;
+			break;
+		default:
+			/* fprintf(stderr,"do: %s\n",gi.argv[gi.pos]); */
+			i = diff_opt_handler(&gi, id, &revs->diffopt);
+			if (i > 0)
+				revs->diff = 1;
+			else if (i < 0) /* error */
+				b->argv[b->argc++] = gi.argv[gi.pos++];
+			else if (ge) {
+				/* i = 0: not a diff_opt, try other handler */
+				i = ge->opt_handler(&gi, id, ge->args);
+				if (i <= 0) /* error */
+					b->argv[b->argc++] = gi.argv[gi.pos++];
+			}
+			gi.pos += i - 1;
 		}
-		if (!seen_dashdash)
-			verify_non_filename(revs->prefix, arg);
-		object = get_reference(revs, arg, sha1, flags ^ local_flags);
-		add_pending_object(revs, object, arg);
 	}
 	if (def && !revs->pending_objects) {
 		unsigned char sha1[20];
@@ -844,7 +875,8 @@ int setup_revisions(int argc, const char
 	revs->diffopt.abbrev = revs->abbrev;
 	diff_setup_done(&revs->diffopt);
 
-	return left;
+	free(ost);
+	return b;
 }
 
 void prepare_revision_walk(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index 48d7b4c..28211b6 100644
--- a/revision.h
+++ b/revision.h
@@ -81,7 +81,9 @@ extern int rev_same_tree_as_empty(struct
 extern int rev_compare_tree(struct rev_info *, struct tree *t1, struct tree *t2);
 
 extern void init_revisions(struct rev_info *revs);
-extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern struct exec_args *setup_revisions(int, const char **argv,
+					struct rev_info *revs, const char *def,
+					const struct gitopt_extra *);
 extern void prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 
-- 
1.3.2.g102e322
