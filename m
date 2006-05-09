From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 5/6] gitopt: convert setup_revisions(), and diff_opt_parse()
Date: Mon, 08 May 2006 22:06:48 -0700
Message-ID: <11471512123005-git-send-email-normalperson@yhbt.net>
References: <11471512121152-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Tue May 09 08:23:21 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdLck-0008Bq-6W
	for gcvg-git@gmane.org; Tue, 09 May 2006 08:23:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWEIGWu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 02:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEIGWu
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 02:22:50 -0400
Received: from hand.yhbt.net ([66.150.188.102]:8671 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1751425AbWEIGWo (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 May 2006 02:22:44 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id 3F99B2DC03A;
	Mon,  8 May 2006 23:22:43 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.2.ge3d7
In-Reply-To: <11471512121152-git-send-email-normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19824>

I've added --raw to diff_opt_parse() for consistency's sake:
--patch-with-raw would otherwise be inconsistently abbreviated
to --raw if it wasn't added.

--with-r => --patch-with-raw works great

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 builtin-diff.c |  109 ++++---------
 builtin-log.c  |    7 -
 commit.c       |   12 +
 diff-files.c   |   22 +--
 diff-index.c   |   19 +-
 diff-tree.c    |   21 +-
 diff.c         |  182 ++++++++++++---------
 diff.h         |    1 
 gitopt/diff.h  |   26 +++
 http-push.c    |    2 
 rev-list.c     |   34 ++--
 revision.c     |  484 +++++++++++++++++++++++++-------------------------------
 revision.h     |    6 +
 13 files changed, 437 insertions(+), 488 deletions(-)
 create mode 100644 gitopt/diff.h

28cbff1d1b543e8234acc6cada0fc889d4767a59
diff --git a/builtin-diff.c b/builtin-diff.c
index d3ac581..ff4a0ec 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -12,6 +12,7 @@ #include "diffcore.h"
 #include "revision.h"
 #include "log-tree.h"
 #include "builtin.h"
+#include "gitopt/diff.h"
 
 /* NEEDSWORK: struct object has place for name but we _do_
  * know mode when we extracted the blob out of a tree, which
@@ -29,22 +30,12 @@ static int builtin_diff_files(struct rev
 			      int argc, const char **argv)
 {
 	int silent = 0;
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
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	struct exec_args *a;
+
+	g_rev = revs;
+	a = new_exec_args(argc);
+	if (gitopt_parse_ost_split(a, a, diff_files_ost, argc, argv))
+		usage(builtin_diff_usage);
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
 	 * specified rev.max_count is reasonable (0 <= n <= 3), and
@@ -107,14 +98,8 @@ static int builtin_diff_b_f(struct rev_i
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
 	if (lstat(path, &st))
 		die("'%s': %s", path, strerror(errno));
 	if (!(S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)))
@@ -135,14 +120,9 @@ static int builtin_diff_blobs(struct rev
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
@@ -155,17 +135,13 @@ static int builtin_diff_blobs(struct rev
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
-			usage(builtin_diff_usage);
-		argv++; argc--;
-	}
+	struct exec_args *a;
+
+	g_rev = revs;
+	a = new_exec_args(argc);
+	if (gitopt_parse_ost_split(a, a, diff_index_ost, argc, argv))
+		usage(builtin_diff_usage);
+
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
@@ -183,14 +159,6 @@ static int builtin_diff_tree(struct rev_
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
 
 	/* We saw two trees, ent[0] and ent[1].
 	 * unless ent[0] is unintesting, they are swapped
@@ -212,14 +180,6 @@ static int builtin_diff_combined(struct 
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
 	if (!revs->dense_combined_merges && !revs->combine_merges)
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	parent = xmalloc(ents * sizeof(*parent));
@@ -250,6 +210,7 @@ int cmd_diff(int argc, const char **argv
 	int ents = 0, blobs = 0, paths = 0;
 	const char *path = NULL;
 	struct blobinfo blob[2];
+	struct exec_args *b;
 
 	/*
 	 * We could get N tree-ish in the rev.pending_objects list.
@@ -274,23 +235,14 @@ int cmd_diff(int argc, const char **argv
 	git_config(git_diff_config);
 	init_revisions(&rev);
 	rev.diffopt.output_format = DIFF_FORMAT_PATCH;
+	cached = 0;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	b = setup_revisions(argc, argv, &rev, NULL, diff_index_ost);
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
+	if (!rev.pending_objects && cached)
+		add_head(&rev);
 
 	for (list = rev.pending_objects; list; list = list->next) {
 		struct object *obj = list->item;
@@ -340,17 +292,18 @@ int cmd_diff(int argc, const char **argv
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
+			return builtin_diff_b_f(&rev, b->argc, b->argv,
+						blob, path);
 			break;
 		case 2:
 			if (paths)
 				usage(builtin_diff_usage);
-			return builtin_diff_blobs(&rev, argc, argv, blob);
+			return builtin_diff_blobs(&rev, b->argc, b->argv, blob);
 			break;
 		default:
 			usage(builtin_diff_usage);
@@ -359,10 +312,10 @@ int cmd_diff(int argc, const char **argv
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
index 69f2911..b004bc5 100644
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
+	if (b->argc)
+		die("unrecognized argument: %s", b->argv[0]);
 
 	prepare_revision_walk(rev);
 	setup_pager();
diff --git a/commit.c b/commit.c
index 2717dd8..a056b25 100644
--- a/commit.c
+++ b/commit.c
@@ -26,17 +26,17 @@ enum cmit_fmt get_commit_format(const ch
 {
 	if (!*arg)
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
index b9d193d..e5b69f4 100644
--- a/diff-files.c
+++ b/diff-files.c
@@ -7,6 +7,7 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "gitopt/diff.h"
 
 static const char diff_files_usage[] =
 "git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
@@ -15,26 +16,17 @@ COMMON_DIFF_OPTIONS_HELP;
 int main(int argc, const char **argv)
 {
 	struct rev_info rev;
-	int silent = 0;
+	struct exec_args *b;
 
+	silent = 0;
 	git_config(git_diff_config);
 	init_revisions(&rev);
 	rev.abbrev = 0;
+	g_rev = &rev;
 
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
+	b = setup_revisions(argc, argv, &rev, NULL, diff_files_ost);
+	if (b->argc)
+		usage(diff_files_usage);
 	/*
 	 * Make sure there are NO revision (i.e. pending object) parameter,
 	 * rev.max_count is reasonable (0 <= n <= 3),
diff --git a/diff-index.c b/diff-index.c
index 8c9f601..92052dc 100644
--- a/diff-index.c
+++ b/diff-index.c
@@ -2,6 +2,8 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "revision.h"
+#include "gitopt.h"
+#include "gitopt/diff.h"
 
 static const char diff_cache_usage[] =
 "git-diff-index [-m] [--cached] "
@@ -11,22 +13,17 @@ COMMON_DIFF_OPTIONS_HELP;
 int main(int argc, const char **argv)
 {
 	struct rev_info rev;
-	int cached = 0;
-	int i;
+	struct exec_args *b;
+	cached = 0;
 
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
+	b = setup_revisions(argc, argv, &rev, NULL, diff_index_ost);
+	if (b->argc)
+		usage(diff_cache_usage);
+
 	/*
 	 * Make sure there is one revision (i.e. pending object),
 	 * and there is no revision filtering parameters.
diff --git a/diff-tree.c b/diff-tree.c
index 7207867..240242c 100644
--- a/diff-tree.c
+++ b/diff-tree.c
@@ -2,6 +2,7 @@ #include "cache.h"
 #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
+#include "gitopt.h"
 
 static struct rev_info log_tree_opt;
 
@@ -58,6 +59,13 @@ static const char diff_tree_usage[] =
 "  --root        include the initial commit as diff against /dev/null\n"
 COMMON_DIFF_OPTIONS_HELP;
 
+static int read_stdin = 0;
+gitopt_eat(opt_stdin, read_stdin = 1;)
+static const struct opt_spec diff_tree_ost[] = {
+	{ "stdin",	0,	0,	0,	opt_stdin },
+	{ 0, 0 }
+};
+
 int main(int argc, const char **argv)
 {
 	int nr_sha1;
@@ -65,24 +73,17 @@ int main(int argc, const char **argv)
 	struct object *tree1, *tree2;
 	static struct rev_info *opt = &log_tree_opt;
 	struct object_list *list;
-	int read_stdin = 0;
+	struct exec_args *b;
 
 	git_config(git_diff_config);
 	nr_sha1 = 0;
 	init_revisions(opt);
 	opt->abbrev = 0;
 	opt->diff = 1;
-	argc = setup_revisions(argc, argv, opt, NULL);
-
-	while (--argc > 0) {
-		const char *arg = *++argv;
 
-		if (!strcmp(arg, "--stdin")) {
-			read_stdin = 1;
-			continue;
-		}
+	b = setup_revisions(argc, argv, opt, NULL, diff_tree_ost);
+	if (b->argc)
 		usage(diff_tree_usage);
-	}
 
 	/*
 	 * NOTE! "setup_revisions()" will have inserted the revisions
diff --git a/diff.c b/diff.c
index 5315270..3b56efc 100644
--- a/diff.c
+++ b/diff.c
@@ -9,6 +9,8 @@ #include "quote.h"
 #include "diff.h"
 #include "diffcore.h"
 #include "xdiff-interface.h"
+#include "gitopt.h"
+#include "gitopt/abbrev.h"
 
 static int use_size_cache;
 
@@ -407,7 +409,8 @@ static void builtin_diff(const char *nam
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
-			 int complete_rewrite)
+			 int complete_rewrite,
+			 struct diff_options *o)
 {
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
@@ -463,10 +466,9 @@ static void builtin_diff(const char *nam
 
 		ecbdata.label_path = lbl;
 		xpp.flags = XDF_NEED_MINIMAL;
-		xecfg.ctxlen = 3;
 		xecfg.flags = XDL_EMIT_FUNCNAMES;
 		if (!diffopts)
-			;
+			xecfg.ctxlen = o->ctxlen;
 		else if (!strncmp(diffopts, "--unified=", 10))
 			xecfg.ctxlen = strtoul(diffopts + 10, NULL, 10);
 		else if (!strncmp(diffopts, "-u", 2))
@@ -928,7 +930,8 @@ static void run_diff_cmd(const char *pgm
 			 struct diff_filespec *one,
 			 struct diff_filespec *two,
 			 const char *xfrm_msg,
-			 int complete_rewrite)
+			 int complete_rewrite,
+			 struct diff_options *o)
 {
 	if (pgm) {
 		run_external_diff(pgm, name, other, one, two, xfrm_msg,
@@ -937,7 +940,7 @@ static void run_diff_cmd(const char *pgm
 	}
 	if (one && two)
 		builtin_diff(name, other ? other : name,
-			     one, two, xfrm_msg, complete_rewrite);
+			     one, two, xfrm_msg, complete_rewrite, o);
 	else
 		printf("* Unmerged path %s\n", name);
 }
@@ -971,7 +974,7 @@ static void run_diff(struct diff_filepai
 
 	if (DIFF_PAIR_UNMERGED(p)) {
 		/* unmerged */
-		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, 0);
+		run_diff_cmd(pgm, p->one->path, NULL, NULL, NULL, NULL, 0, o);
 		return;
 	}
 
@@ -1041,15 +1044,15 @@ static void run_diff(struct diff_filepai
 		 * needs to be split into deletion and creation.
 		 */
 		struct diff_filespec *null = alloc_filespec(two->path);
-		run_diff_cmd(NULL, name, other, one, null, xfrm_msg, 0);
+		run_diff_cmd(NULL, name, other, one, null, xfrm_msg, 0, o);
 		free(null);
 		null = alloc_filespec(one->path);
-		run_diff_cmd(NULL, name, other, null, two, xfrm_msg, 0);
+		run_diff_cmd(NULL, name, other, null, two, xfrm_msg, 0, o);
 		free(null);
 	}
 	else
 		run_diff_cmd(pgm, name, other, one, two, xfrm_msg,
-			     complete_rewrite);
+			     complete_rewrite, o);
 
 	free(name_munged);
 	free(other_munged);
@@ -1086,6 +1089,7 @@ void diff_setup(struct diff_options *opt
 	options->line_termination = '\n';
 	options->break_opt = -1;
 	options->rename_limit = -1;
+	options->ctxlen = 3;
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
@@ -1126,76 +1130,100 @@ int diff_setup_done(struct diff_options 
 	return 0;
 }
 
+static struct diff_options *g_opt = NULL; /* gitopt needs globals :x */
+static int rv_diff_opt_parse = 0;
+
+gitopt_eat_opt_int(opt_unified,
+		g_opt->output_format = DIFF_FORMAT_PATCH;
+		if (ea->argc) g_opt->ctxlen = strtol(ea->argv[0], NULL, 10);)
+gitopt_eat(opt_p, g_opt->output_format = DIFF_FORMAT_PATCH;)
+gitopt_eat(opt_patch_with_raw,
+		g_opt->output_format = DIFF_FORMAT_PATCH;
+		g_opt->with_raw = 1;)
+gitopt_eat(opt_raw, g_opt->output_format = DIFF_FORMAT_RAW;)
+gitopt_eat(opt_stat,
+		g_opt->output_format = DIFF_FORMAT_DIFFSTAT;)
+gitopt_eat(opt_patch_with_stat,
+		g_opt->output_format = DIFF_FORMAT_PATCH;
+		g_opt->with_stat = 1;)
+gitopt_eat(opt_z, g_opt->line_termination = 0;)
+gitopt_eat_one_arg(opt_l, g_opt->rename_limit = strtoul(ea->argv[0],NULL,10);)
+gitopt_eat(opt_full_index, g_opt->full_index = 1;)
+gitopt_eat(opt_name_only, g_opt->output_format = DIFF_FORMAT_NAME;)
+gitopt_eat(opt_name_status,
+			g_opt->output_format = DIFF_FORMAT_NAME_STATUS;)
+gitopt_eat(opt_R, g_opt->reverse_diff = 1;)
+gitopt_eat_one_arg(opt_S, g_opt->pickaxe = ea->argv[0];)
+gitopt_eat(opt_s, g_opt->output_format = DIFF_FORMAT_NO_OUTPUT;)
+gitopt_eat_one_arg(opt_O, g_opt->orderfile = ea->argv[0];)
+gitopt_eat_one_arg(opt_diff_filter, g_opt->filter = ea->argv[0];)
+gitopt_eat(opt_pickaxe_all, g_opt->pickaxe_opts = DIFF_PICKAXE_ALL;)
+gitopt_eat(opt_pickaxe_regex, g_opt->pickaxe_opts = DIFF_PICKAXE_REGEX;)
+gitopt_eat_opt_int(opt_B,
+	if ((g_opt->break_opt = diff_scoreopt_parse(*argv)) == -1)
+		rv_diff_opt_parse = -1;)
+gitopt_eat_opt_int(opt_M,
+	if ((g_opt->rename_score = diff_scoreopt_parse(*argv)) == -1)
+		rv_diff_opt_parse = -1;
+	g_opt->detect_rename = DIFF_DETECT_RENAME;)
+gitopt_eat_opt_int(opt_C,
+	if ((g_opt->rename_score = diff_scoreopt_parse(*argv)) == -1)
+		rv_diff_opt_parse = -1;
+	g_opt->detect_rename = DIFF_DETECT_COPY;)
+gitopt_eat(opt_find_copies_harder, g_opt->find_copies_harder = 1;)
+gitopt_opt_abbrev(g_opt->abbrev)
+
+static const struct opt_spec diff_ost[] = {
+	{ 0,			'p',	0,	0,	opt_p },
+	{ "unified",		'u',	"%s",	ARG_OPTINT,	opt_unified },
+	{ "raw",		0,	0,	0,	opt_raw },
+	{ "patch-with-raw",	0,	0,	0,	opt_patch_with_raw },
+	{ "stat",		0,	0,	0,	opt_stat },
+	{ "patch-with-stat",	0,	0,	0,	opt_patch_with_stat },
+	{ 0,			'z',	0,	0,	opt_z },
+	{ 0,			'l',	"%s",	ARG_INT,opt_l },
+	{ "full-index",		0,	0,	0,	opt_full_index },
+	{ "name-only",		0,	0,	0,	opt_name_only },
+	{ "name-status",	0,	0,	0,	opt_name_status },
+	{ 0,			'R',	0,	0,	opt_R },
+	{ 0,			'S',	"%s",	ARG_ONE,opt_S },
+	{ 0,			's',	0,	0,	opt_s },
+	{ 0,			'O',	"%s",	ARG_ONE, opt_O },
+	{ "diff-filter",	0,	"%s",	ARG_ONE, opt_diff_filter },
+	{ "pickaxe-all",	0,	0,	0,	opt_pickaxe_all },
+	{ "pickaxe-regex",	0,	0,	0,	opt_pickaxe_regex },
+	{ 0,			'B',	"%s",	ARG_OPTINT,opt_B },
+	{ 0,			'M',	"%s",	ARG_OPTINT,opt_M },
+	{ 0,			'C',	"%s",	ARG_OPTINT,opt_C },
+	{ "find-copies-harder",	0,	0,	0,	opt_find_copies_harder},
+	abbrev_ost_row,
+	{ 0, 0 }
+};
+
+static void diff_non_option_cb(struct exec_args *b, const int argc,
+					const char **argv, int *argc_pos)
+{
+	rv_diff_opt_parse = 0;
+}
+
 int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 {
-	const char *arg = av[0];
-	if (!strcmp(arg, "-p") || !strcmp(arg, "-u"))
-		options->output_format = DIFF_FORMAT_PATCH;
-	else if (!strcmp(arg, "--patch-with-raw")) {
-		options->output_format = DIFF_FORMAT_PATCH;
-		options->with_raw = 1;
-	}
-	else if (!strcmp(arg, "--stat"))
-		options->output_format = DIFF_FORMAT_DIFFSTAT;
-	else if (!strcmp(arg, "--patch-with-stat")) {
-		options->output_format = DIFF_FORMAT_PATCH;
-		options->with_stat = 1;
-	}
-	else if (!strcmp(arg, "-z"))
-		options->line_termination = 0;
-	else if (!strncmp(arg, "-l", 2))
-		options->rename_limit = strtoul(arg+2, NULL, 10);
-	else if (!strcmp(arg, "--full-index"))
-		options->full_index = 1;
-	else if (!strcmp(arg, "--name-only"))
-		options->output_format = DIFF_FORMAT_NAME;
-	else if (!strcmp(arg, "--name-status"))
-		options->output_format = DIFF_FORMAT_NAME_STATUS;
-	else if (!strcmp(arg, "-R"))
-		options->reverse_diff = 1;
-	else if (!strncmp(arg, "-S", 2))
-		options->pickaxe = arg + 2;
-	else if (!strcmp(arg, "-s"))
-		options->output_format = DIFF_FORMAT_NO_OUTPUT;
-	else if (!strncmp(arg, "-O", 2))
-		options->orderfile = arg + 2;
-	else if (!strncmp(arg, "--diff-filter=", 14))
-		options->filter = arg + 14;
-	else if (!strcmp(arg, "--pickaxe-all"))
-		options->pickaxe_opts = DIFF_PICKAXE_ALL;
-	else if (!strcmp(arg, "--pickaxe-regex"))
-		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
-	else if (!strncmp(arg, "-B", 2)) {
-		if ((options->break_opt =
-		     diff_scoreopt_parse(arg)) == -1)
-			return -1;
-	}
-	else if (!strncmp(arg, "-M", 2)) {
-		if ((options->rename_score =
-		     diff_scoreopt_parse(arg)) == -1)
-			return -1;
-		options->detect_rename = DIFF_DETECT_RENAME;
-	}
-	else if (!strncmp(arg, "-C", 2)) {
-		if ((options->rename_score =
-		     diff_scoreopt_parse(arg)) == -1)
-			return -1;
-		options->detect_rename = DIFF_DETECT_COPY;
-	}
-	else if (!strcmp(arg, "--find-copies-harder"))
-		options->find_copies_harder = 1;
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
-		return 0;
-	return 1;
+	struct exec_args *a = new_exec_args(1);
+	int i = 0;
+	void (*old_non_option_cb)(struct exec_args *b, const int argc,
+				const char **argv, int *argc_pos);
+	g_opt = options;
+	rv_diff_opt_parse = 1;
+	gitopt_pass_through = 1;
+	old_non_option_cb = gitopt_non_option_cb;
+	gitopt_non_option_cb = diff_non_option_cb;
+
+	gitopt_parse_one_opt(a, a, diff_ost, ac, av, &i);
+
+	free_exec_args(a);
+	gitopt_non_option_cb = old_non_option_cb;
+
+	return rv_diff_opt_parse;
 }
 
 static int parse_num(const char **cp_p)
diff --git a/diff.h b/diff.h
index b3b2c4d..b5f016e 100644
--- a/diff.h
+++ b/diff.h
@@ -41,6 +41,7 @@ struct diff_options {
 	int rename_limit;
 	int setup;
 	int abbrev;
+	int ctxlen;
 
 	int nr_paths;
 	const char **paths;
diff --git a/gitopt/diff.h b/gitopt/diff.h
new file mode 100644
index 0000000..6530474
--- /dev/null
+++ b/gitopt/diff.h
@@ -0,0 +1,26 @@
+#ifndef GITOPT_DIFF_H
+#define GITOPT_DIFF_H
+
+static struct rev_info *g_rev;
+static int silent;
+static int cached;
+
+gitopt_eat(opt_base,		g_rev->max_count = 1;)
+gitopt_eat(opt_ours,		g_rev->max_count = 2;)
+gitopt_eat(opt_theres,		g_rev->max_count = 3;)
+gitopt_eat(opt_q,		silent = 1;)
+static const struct opt_spec diff_files_ost[] = {
+	{ "base",	0,	0,	0,	opt_base },
+	{ "ours",	0,	0,	0,	opt_ours },
+	{ "theres",	0,	0,	0,	opt_theres },
+	{ 0,		'q',	0,	0,	opt_q },
+	{ 0, 0 }
+};
+
+gitopt_eat(opt_cached,		cached = 1;)
+static const struct opt_spec diff_index_ost[] = {
+	{ "cached",	0,	0,	0,	opt_cached },
+	{ 0, 0 }
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
index 8b0ec38..3c72c59 100644
--- a/rev-list.c
+++ b/rev-list.c
@@ -7,6 +7,7 @@ #include "blob.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "revision.h"
+#include "gitopt.h"
 
 /* bits #0-15 in revision.h */
 
@@ -291,34 +292,31 @@ static void mark_edges_uninteresting(str
 	}
 }
 
+static struct rev_info *g_rev;
+gitopt_eat(opt_header,			g_rev->verbose_header = 1;)
+gitopt_eat(opt_timestamp,		show_timestamp = 1;)
+gitopt_eat(opt_bisect,			bisect_list = 1;)
+static const struct opt_spec rev_list_ost[] = {
+	{ "header",	0,	0,	0,	opt_header },
+	{ "timestamp",	0,	0,	0,	opt_timestamp },
+	{ "bisect",	0,	0,	0,	opt_bisect },
+	{ 0, 0 }
+};
+
 int main(int argc, const char **argv)
 {
 	struct commit_list *list;
-	int i;
+	struct exec_args *b;
 
 	init_revisions(&revs);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
-	argc = setup_revisions(argc, argv, &revs, NULL);
-
-	for (i = 1 ; i < argc; i++) {
-		const char *arg = argv[i];
+	g_rev = &revs;
 
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
+	b = setup_revisions(argc, argv, &revs, NULL, rev_list_ost);
+	if (b->argc)
 		usage(rev_list_usage);
 
-	}
 	if (revs.commit_format != CMIT_FMT_UNSPECIFIED) {
 		/* The command line has a --pretty  */
 		hdr_termination = '\n';
diff --git a/revision.c b/revision.c
index 2294b16..6769a48 100644
--- a/revision.c
+++ b/revision.c
@@ -6,6 +6,7 @@ #include "commit.h"
 #include "diff.h"
 #include "refs.h"
 #include "revision.h"
+#include "gitopt/abbrev.h"
 
 static char *path_name(struct name_path *path, const char *name)
 {
@@ -534,6 +535,198 @@ void init_revisions(struct rev_info *rev
 	diff_setup(&revs->diffopt);
 }
 
+static const char *g_def = NULL;
+
+/* I think I should just be able to use the all_* versions of these.. -ew */
+static struct rev_info *g_revs = NULL;
+static int g_flags = 0;
+static const struct opt_spec *g_extra_ost;
+
+gitopt_eat_int(opt_max_count,	g_revs->max_count = atoi(ea->argv[0]);)
+gitopt_eat_int(opt_max_age,	g_revs->max_age = atoi(ea->argv[0]);)
+gitopt_eat_int(opt_since,	g_revs->max_age = approxidate(ea->argv[0]);)
+gitopt_eat_int(opt_min_age,	g_revs->min_age = atoi(ea->argv[0]);)
+gitopt_eat_int(opt_until,	g_revs->min_age = approxidate(ea->argv[0]);)
+gitopt_eat(opt_all,		handle_all(g_revs, g_flags);)
+gitopt_eat(opt_not,		g_flags ^= UNINTERESTING;)
+gitopt_eat_arg(opt_default,	g_def = ea->argv[0];)
+gitopt_eat(opt_topo_order,	g_revs->topo_order = 1;)
+gitopt_eat(opt_date_order,	g_revs->topo_order = 1; g_revs->lifo = 0;)
+gitopt_eat(opt_parents,		g_revs->parents = 1;)
+gitopt_eat(opt_dense,		g_revs->dense = 1;)
+gitopt_eat(opt_sparse,		g_revs->dense = 0;)
+gitopt_eat(opt_remove_empty,	g_revs->remove_empty_trees = 1;)
+gitopt_eat(opt_no_merges,	g_revs->no_merges = 1;)
+gitopt_eat(opt_boundary,	g_revs->boundary = 1;)
+gitopt_eat(opt_objects,		g_revs->tag_objects = g_revs->tree_objects =
+					g_revs->blob_objects = 1;)
+gitopt_eat(opt_objects_edge,	g_revs->tag_objects = g_revs->tree_objects =
+				g_revs->blob_objects = g_revs->edge_hint = 1;)
+gitopt_eat(opt_unpacked,	g_revs->unpacked = 1;)
+gitopt_eat(opt_r,		g_revs->diff = g_revs->diffopt.recursive = 1;)
+gitopt_eat(opt_t,		g_revs->diff = g_revs->diffopt.recursive =
+					g_revs->diffopt.tree_in_recursive = 1;)
+gitopt_eat(opt_m,		g_revs->ignore_merges = 0;)
+gitopt_eat(opt_c,		g_revs->diff = g_revs->combine_merges = 1;
+				g_revs->dense_combined_merges = 0;)
+gitopt_eat(opt_cc,		g_revs->diff = g_revs->combine_merges =
+					g_revs->dense_combined_merges = 1;)
+gitopt_eat(opt_v,		g_revs->verbose_header = 1;)
+gitopt_eat_arg(opt_pretty,		g_revs->verbose_header = 1;
+				g_revs->commit_format = get_commit_format(
+								ea->argv[0]);)
+gitopt_eat(opt_root,		g_revs->show_root_diff = 1;)
+gitopt_eat(opt_no_commit_id,	g_revs->no_commit_id = 1;)
+gitopt_eat(opt_always,		g_revs->always_show_header = 1;)
+gitopt_opt_abbrev(g_revs->abbrev)
+gitopt_eat(opt_no_abbrev,	g_revs->abbrev = 0;)
+gitopt_eat(opt_abbrev_commit,	g_revs->abbrev_commit = 1;)
+gitopt_eat(opt_full_diff,	g_revs->full_diff = g_revs->diff = 1;)
+
+static const struct opt_spec setup_revisions_ost[] = {
+	{ "max-count",		'n',	"%s",	ARG_INT,	opt_max_count },
+	{ 0,			' ',	"%s",	ARG_INT,	opt_max_count },
+	{ "max-age",		0,	"%s",	ARG_INT,	opt_max_age },
+	{ "min-age",		0,	"%s",	ARG_INT,	opt_min_age },
+	{ "since",		0,	"%s",	ARG_ONE,	opt_since },
+	{ "after",		0,	"%s",	ARG_ONE,	opt_since },
+	{ "before",		0,	"%s",	ARG_ONE,	opt_until },
+	{ "until",		0,	"%s",	ARG_ONE,	opt_until },
+	{ "all",		0,	0,	0,		opt_all },
+	{ "not",		0,	0,	0,		opt_not },
+	{ "default",		0,	"%s",	ARG_ONE,	opt_default },
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
+	{ "pretty",		0,	"%s",	ARG_ONE,	opt_pretty },
+	{ "root",		0,	0,	0,	opt_root },
+	{ "no-commit-id",	0,	0,	0,	opt_no_commit_id },
+	{ "always",		0,	0,	0,	opt_always },
+	{ "no-abbrev",		0,	0,	0,	opt_no_abbrev },
+	abbrev_ost_row,
+	{ "abbrev-commit",	0,	0,	0,	opt_abbrev_commit },
+	{ "full-diff",		0,	0,	0,	opt_full_diff },
+	{ 0, 0 }
+};
+
+/* call this for every non-option (and everything after "--") we have */
+static void setup_revisions_non_option_cb(struct exec_args *b,
+			const int argc, const char **argv, int *argc_pos)
+{
+	int i = *argc_pos;
+	const char *arg = argv[i];
+	unsigned char sha1[20];
+	struct object *object;
+	char *dotdot;
+	int local_flags;
+
+	if (arg[0] == '-') { /* handle diff options: */
+		int opts = diff_opt_parse(&(g_revs->diffopt),
+					argv + i, argc - 1);
+		if (opts > 0) {
+			g_revs->diff = 1;
+			*argc_pos += opts - 1;
+			return;
+		}
+		if (g_extra_ost) {
+			void (*old_non_option_cb)(struct exec_args *b,
+					const int argc, const char **argv,
+					int *argc_pos);
+			int j = 0;
+			old_non_option_cb = gitopt_non_option_cb;
+			gitopt_non_option_cb = gitopt_default_non_option_cb;
+			gitopt_parse_one_opt(b, b, g_extra_ost,
+						argc - i, argv + i, &j);
+			gitopt_non_option_cb = old_non_option_cb;
+			*argc_pos += j;
+		}
+		return;
+	}
+
+	/* otherwise it's a revision */
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
+			exclude = get_reference(g_revs, this, from_sha1,
+						g_flags ^ UNINTERESTING);
+			include = get_reference(g_revs, next, sha1, g_flags);
+			if (!exclude || !include)
+				die("Invalid revision range %s..%s", arg, next);
+
+			if (!gitopt_dd_seen) {
+				*dotdot = '.';
+				verify_non_filename(g_revs->prefix, arg);
+			}
+			add_pending_object(g_revs, exclude, this);
+			add_pending_object(g_revs, include, next);
+			return;
+		}
+		*dotdot = '.';
+	}
+
+	dotdot = strstr(arg, "^@");
+	if (dotdot && !dotdot[2]) {
+		*dotdot = 0;
+		if (add_parents_only(g_revs, arg, g_flags))
+			return;
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
+		if (gitopt_dd_seen || local_flags)
+			die("bad revision '%s'", arg);
+
+		/* If we didn't have a "--":
+		 * (1) all filenames must exist;
+		 * (2) all rev-args must not be interpretable
+		 *     as a valid filename.
+		 * but the latter we have checked in the main loop.
+		 */
+		for (j = *argc_pos; j < argc; j++)
+			verify_filename(g_revs->prefix, argv[j]);
+
+		g_revs->prune_data = get_pathspec(g_revs->prefix,
+						argv + *argc_pos);
+		return;
+	}
+	if (!gitopt_dd_seen)
+		verify_non_filename(g_revs->prefix, arg);
+	object = get_reference(g_revs, arg, sha1, g_flags ^ local_flags);
+	add_pending_object(g_revs, object, arg);
+}
+
 /*
  * Parse revision information, filling in the "rev_info" structure,
  * and removing the used arguments from the argument list.
@@ -541,14 +734,19 @@ void init_revisions(struct rev_info *rev
  * Returns the number of arguments left that weren't recognized
  * (which are also moved to the head of the argument list)
  */
-int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
+struct exec_args *setup_revisions(int argc, const char **argv,
+				struct rev_info *revs, const char *def,
+				const struct opt_spec *extra_ost)
 {
-	int i, flags, seen_dashdash;
-	const char **unrecognized = argv + 1;
-	int left = 1;
+	int i;
+	struct exec_args *a, *b;
+
+	g_extra_ost = extra_ost;
+	g_def = def;
+	g_revs = revs;
+	gitopt_dd_seen = 0;
 
 	/* First, search for "--" */
-	seen_dashdash = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (strcmp(arg, "--"))
@@ -556,274 +754,24 @@ int setup_revisions(int argc, const char
 		argv[i] = NULL;
 		argc = i;
 		revs->prune_data = get_pathspec(revs->prefix, argv + i + 1);
-		seen_dashdash = 1;
+		gitopt_dd_seen = 1;
 		break;
 	}
 
-	flags = 0;
-	for (i = 1; i < argc; i++) {
-		struct object *object;
-		const char *arg = argv[i];
-		unsigned char sha1[20];
-		char *dotdot;
-		int local_flags;
-
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
-				revs->abbrev = DEFAULT_ABBREV;
-				continue;
-			}
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
+	a = new_exec_args(argc);
+	b = new_exec_args(argc);
+	gitopt_pass_through = 1;
+	gitopt_non_option_cb = setup_revisions_non_option_cb;
+	if (gitopt_parse_ost_split(a, b, setup_revisions_ost, argc, argv))
+		return b;
 
-			revs->prune_data = get_pathspec(revs->prefix, argv + i);
-			break;
-		}
-		if (!seen_dashdash)
-			verify_non_filename(revs->prefix, arg);
-		object = get_reference(revs, arg, sha1, flags ^ local_flags);
-		add_pending_object(revs, object, arg);
-	}
-	if (def && !revs->pending_objects) {
+	if (g_def && !revs->pending_objects) {
 		unsigned char sha1[20];
 		struct object *object;
-		if (get_sha1(def, sha1))
-			die("bad default revision '%s'", def);
-		object = get_reference(revs, def, sha1, 0);
-		add_pending_object(revs, object, def);
+		if (get_sha1(g_def, sha1))
+			die("bad default revision '%s'", g_def);
+		object = get_reference(revs, g_def, sha1, 0);
+		add_pending_object(revs, object, g_def);
 	}
 
 	if (revs->topo_order || revs->unpacked)
@@ -844,7 +792,7 @@ int setup_revisions(int argc, const char
 	revs->diffopt.abbrev = revs->abbrev;
 	diff_setup_done(&revs->diffopt);
 
-	return left;
+	return b;
 }
 
 void prepare_revision_walk(struct rev_info *revs)
diff --git a/revision.h b/revision.h
index 48d7b4c..11a5820 100644
--- a/revision.h
+++ b/revision.h
@@ -1,6 +1,8 @@
 #ifndef REVISION_H
 #define REVISION_H
 
+#include "gitopt.h"
+
 #define SEEN		(1u<<0)
 #define UNINTERESTING   (1u<<1)
 #define TREECHANGE	(1u<<2)
@@ -81,7 +83,9 @@ extern int rev_same_tree_as_empty(struct
 extern int rev_compare_tree(struct rev_info *, struct tree *t1, struct tree *t2);
 
 extern void init_revisions(struct rev_info *revs);
-extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern struct exec_args *setup_revisions(int argc, const char **argv,
+					struct rev_info *revs, const char *def,
+					const struct opt_spec *extra_ost);
 extern void prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
 
-- 
1.3.2.g0a3ae
