From: "Peter Eriksen" <s022018@student.dtu.dk>
Subject: [PATCH 8/8] Builtin git-diff-files, git-diff-index, git-diff-stages, and git-diff-tree.
Date: Tue, 23 May 2006 10:31:20 +0200
Message-ID: <10301.3191408992$1148373129@news.gmane.org>
References: <11483730813930-git-send-email->
Reply-To: Patches/0001-Builtin-git-ls-files.txt@bohr.gbar.dtu.dk
Cc: Peter Eriksen <s022018@student.dtu.dk>
X-From: git-owner@vger.kernel.org Tue May 23 10:32:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiSJ0-0001gO-G8
	for gcvg-git@gmane.org; Tue, 23 May 2006 10:31:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932127AbWEWIbd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 04:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932130AbWEWIbd
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 04:31:33 -0400
Received: from bohr.gbar.dtu.dk ([192.38.95.24]:55787 "HELO bohr.gbar.dtu.dk")
	by vger.kernel.org with SMTP id S932127AbWEWIbX (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 04:31:23 -0400
Received: (qmail 8476 invoked by uid 5842); 23 May 2006 10:31:21 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.3.g288c
In-Reply-To: <11483730813930-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20585>

From: Peter Eriksen <s022018@student.dtu.dk>

Signed-off-by: Peter Eriksen <s022018@student.dtu.dk>


---

e2d2468b8550f2760b46a2eb461b051abfef4dff
 Makefile              |   12 ++--
 builtin-diff-files.c  |   55 ++++++++++++++++++
 builtin-diff-index.c  |   39 +++++++++++++
 builtin-diff-stages.c |  105 +++++++++++++++++++++++++++++++++++
 builtin-diff-tree.c   |  148 +++++++++++++++++++++++++++++++++++++++++++++++++
 builtin.h             |    5 ++
 diff-files.c          |   54 ------------------
 diff-index.c          |   38 -------------
 diff-stages.c         |  104 ----------------------------------
 diff-tree.c           |  147 -------------------------------------------------
 git.c                 |    6 ++
 11 files changed, 363 insertions(+), 350 deletions(-)
 create mode 100644 builtin-diff-files.c
 create mode 100644 builtin-diff-index.c
 create mode 100644 builtin-diff-stages.c
 create mode 100644 builtin-diff-tree.c
 delete mode 100644 diff-files.c
 delete mode 100644 diff-index.c
 delete mode 100644 diff-stages.c
 delete mode 100644 diff-tree.c

e2d2468b8550f2760b46a2eb461b051abfef4dff
diff --git a/Makefile b/Makefile
index b438a90..9dc1326 100644
--- a/Makefile
+++ b/Makefile
@@ -151,9 +151,7 @@ # ... and all the rest that could be mov
 PROGRAMS = \
 	git-cat-file$X \
 	git-checkout-index$X git-clone-pack$X \
-	git-convert-objects$X git-diff-files$X \
-	git-diff-index$X git-diff-stages$X \
-	git-diff-tree$X git-fetch-pack$X git-fsck-objects$X \
+	git-convert-objects$X git-fetch-pack$X git-fsck-objects$X \
 	git-hash-object$X git-index-pack$X git-local-fetch$X \
 	git-mailinfo$X git-merge-base$X \
 	git-merge-index$X git-mktag$X git-mktree$X git-pack-objects$X git-patch-id$X \
@@ -173,7 +171,8 @@ BUILT_INS = git-log$X git-whatchanged$X 
 	git-grep$X git-rev-list$X git-check-ref-format$X \
 	git-init-db$X git-ls-files$X git-ls-tree$X \
 	git-tar-tree$X git-read-tree$X git-commit-tree$X \
-	git-apply$X git-show-branch$X
+	git-apply$X git-show-branch$X git-diff-files$X \
+	git-diff-index$X git-diff-stages$X git-diff-tree$X
 
 # what 'all' will build and 'install' will install, in gitexecdir
 ALL_PROGRAMS = $(PROGRAMS) $(SIMPLE_PROGRAMS) $(SCRIPTS)
@@ -223,8 +222,9 @@ BUILTIN_OBJS = \
 	builtin-log.o builtin-help.o builtin-count.o builtin-diff.o builtin-push.o \
 	builtin-grep.o builtin-rev-list.o builtin-check-ref-format.o \
 	builtin-init-db.o builtin-ls-files.o builtin-ls-tree.o \
-        builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o \
-	builtin-apply.o builtin-show-branch.o
+	builtin-tar-tree.o builtin-read-tree.o builtin-commit-tree.o \
+	builtin-apply.o builtin-show-branch.o builtin-diff-files.o \
+	builtin-diff-index.o builtin-diff-stages.o builtin-diff-tree.o
 
 GITLIBS = $(LIB_FILE) $(XDIFF_LIB)
 LIBS = $(GITLIBS) -lz
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
new file mode 100644
index 0000000..cebda82
--- /dev/null
+++ b/builtin-diff-files.c
@@ -0,0 +1,55 @@
+/*
+ * GIT - The information manager from hell
+ *
+ * Copyright (C) Linus Torvalds, 2005
+ */
+#include "cache.h"
+#include "diff.h"
+#include "commit.h"
+#include "revision.h"
+#include "builtin.h"
+
+static const char diff_files_usage[] =
+"git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
+COMMON_DIFF_OPTIONS_HELP;
+
+int cmd_diff_files(int argc, const char **argv, char **envp)
+{
+	struct rev_info rev;
+	int silent = 0;
+
+	git_config(git_diff_config);
+	init_revisions(&rev);
+	rev.abbrev = 0;
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	while (1 < argc && argv[1][0] == '-') {
+		if (!strcmp(argv[1], "--base"))
+			rev.max_count = 1;
+		else if (!strcmp(argv[1], "--ours"))
+			rev.max_count = 2;
+		else if (!strcmp(argv[1], "--theirs"))
+			rev.max_count = 3;
+		else if (!strcmp(argv[1], "-q"))
+			silent = 1;
+		else
+			usage(diff_files_usage);
+		argv++; argc--;
+	}
+	/*
+	 * Make sure there are NO revision (i.e. pending object) parameter,
+	 * rev.max_count is reasonable (0 <= n <= 3),
+	 * there is no other revision filtering parameters.
+	 */
+	if (rev.pending_objects ||
+	    rev.min_age != -1 || rev.max_age != -1)
+		usage(diff_files_usage);
+	/*
+	 * Backward compatibility wart - "diff-files -s" used to
+	 * defeat the common diff option "-s" which asked for
+	 * DIFF_FORMAT_NO_OUTPUT.
+	 */
+	if (rev.diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
+		rev.diffopt.output_format = DIFF_FORMAT_RAW;
+	return run_diff_files(&rev, silent);
+}
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
new file mode 100644
index 0000000..1958580
--- /dev/null
+++ b/builtin-diff-index.c
@@ -0,0 +1,39 @@
+#include "cache.h"
+#include "diff.h"
+#include "commit.h"
+#include "revision.h"
+#include "builtin.h"
+
+static const char diff_cache_usage[] =
+"git-diff-index [-m] [--cached] "
+"[<common diff options>] <tree-ish> [<path>...]"
+COMMON_DIFF_OPTIONS_HELP;
+
+int cmd_diff_index(int argc, const char **argv, char **envp)
+{
+	struct rev_info rev;
+	int cached = 0;
+	int i;
+
+	git_config(git_diff_config);
+	init_revisions(&rev);
+	rev.abbrev = 0;
+
+	argc = setup_revisions(argc, argv, &rev, NULL);
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+			
+		if (!strcmp(arg, "--cached"))
+			cached = 1;
+		else
+			usage(diff_cache_usage);
+	}
+	/*
+	 * Make sure there is one revision (i.e. pending object),
+	 * and there is no revision filtering parameters.
+	 */
+	if (!rev.pending_objects || rev.pending_objects->next ||
+	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
+		usage(diff_cache_usage);
+	return run_diff_index(&rev, cached);
+}
diff --git a/builtin-diff-stages.c b/builtin-diff-stages.c
new file mode 100644
index 0000000..7c157ca
--- /dev/null
+++ b/builtin-diff-stages.c
@@ -0,0 +1,105 @@
+/*
+ * Copyright (c) 2005 Junio C Hamano
+ */
+
+#include "cache.h"
+#include "diff.h"
+#include "builtin.h"
+
+static struct diff_options diff_options;
+
+static const char diff_stages_usage[] =
+"git-diff-stages [<common diff options>] <stage1> <stage2> [<path>...]"
+COMMON_DIFF_OPTIONS_HELP;
+
+static void diff_stages(int stage1, int stage2, const char **pathspec)
+{
+	int i = 0;
+	while (i < active_nr) {
+		struct cache_entry *ce, *stages[4] = { NULL, };
+		struct cache_entry *one, *two;
+		const char *name;
+		int len, skip;
+
+		ce = active_cache[i];
+		skip = !ce_path_match(ce, pathspec);
+		len = ce_namelen(ce);
+		name = ce->name;
+		for (;;) {
+			int stage = ce_stage(ce);
+			stages[stage] = ce;
+			if (active_nr <= ++i)
+				break;
+			ce = active_cache[i];
+			if (ce_namelen(ce) != len ||
+			    memcmp(name, ce->name, len))
+				break;
+		}
+		one = stages[stage1];
+		two = stages[stage2];
+
+		if (skip || (!one && !two))
+			continue;
+		if (!one)
+			diff_addremove(&diff_options, '+', ntohl(two->ce_mode),
+				       two->sha1, name, NULL);
+		else if (!two)
+			diff_addremove(&diff_options, '-', ntohl(one->ce_mode),
+				       one->sha1, name, NULL);
+		else if (memcmp(one->sha1, two->sha1, 20) ||
+			 (one->ce_mode != two->ce_mode) ||
+			 diff_options.find_copies_harder)
+			diff_change(&diff_options,
+				    ntohl(one->ce_mode), ntohl(two->ce_mode),
+				    one->sha1, two->sha1, name, NULL);
+	}
+}
+
+int cmd_diff_stages(int ac, const char **av, char **envp)
+{
+	int stage1, stage2;
+	const char *prefix = setup_git_directory();
+	const char **pathspec = NULL;
+
+	git_config(git_diff_config);
+	read_cache();
+	diff_setup(&diff_options);
+	while (1 < ac && av[1][0] == '-') {
+		const char *arg = av[1];
+		if (!strcmp(arg, "-r"))
+			; /* as usual */
+		else {
+			int diff_opt_cnt;
+			diff_opt_cnt = diff_opt_parse(&diff_options,
+						      av+1, ac-1);
+			if (diff_opt_cnt < 0)
+				usage(diff_stages_usage);
+			else if (diff_opt_cnt) {
+				av += diff_opt_cnt;
+				ac -= diff_opt_cnt;
+				continue;
+			}
+			else
+				usage(diff_stages_usage);
+		}
+		ac--; av++;
+	}
+
+	if (ac < 3 ||
+	    sscanf(av[1], "%d", &stage1) != 1 ||
+	    ! (0 <= stage1 && stage1 <= 3) ||
+	    sscanf(av[2], "%d", &stage2) != 1 ||
+	    ! (0 <= stage2 && stage2 <= 3))
+		usage(diff_stages_usage);
+
+	av += 3; /* The rest from av[0] are for paths restriction. */
+	pathspec = get_pathspec(prefix, av);
+
+	if (diff_setup_done(&diff_options) < 0)
+		usage(diff_stages_usage);
+
+	diff_stages(stage1, stage2, pathspec);
+	diffcore_std(&diff_options);
+	diff_flush(&diff_options);
+	return 0;
+}
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
new file mode 100644
index 0000000..cc53b81
--- /dev/null
+++ b/builtin-diff-tree.c
@@ -0,0 +1,148 @@
+#include "cache.h"
+#include "diff.h"
+#include "commit.h"
+#include "log-tree.h"
+#include "builtin.h"
+
+static struct rev_info log_tree_opt;
+
+static int diff_tree_commit_sha1(const unsigned char *sha1)
+{
+	struct commit *commit = lookup_commit_reference(sha1);
+	if (!commit)
+		return -1;
+	return log_tree_commit(&log_tree_opt, commit);
+}
+
+static int diff_tree_stdin(char *line)
+{
+	int len = strlen(line);
+	unsigned char sha1[20];
+	struct commit *commit;
+
+	if (!len || line[len-1] != '\n')
+		return -1;
+	line[len-1] = 0;
+	if (get_sha1_hex(line, sha1))
+		return -1;
+	commit = lookup_commit(sha1);
+	if (!commit || parse_commit(commit))
+		return -1;
+	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
+		/* Graft the fake parents locally to the commit */
+		int pos = 41;
+		struct commit_list **pptr, *parents;
+
+		/* Free the real parent list */
+		for (parents = commit->parents; parents; ) {
+			struct commit_list *tmp = parents->next;
+			free(parents);
+			parents = tmp;
+		}
+		commit->parents = NULL;
+		pptr = &(commit->parents);
+		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
+			struct commit *parent = lookup_commit(sha1);
+			if (parent) {
+				pptr = &commit_list_insert(parent, pptr)->next;
+			}
+			pos += 41;
+		}
+	}
+	return log_tree_commit(&log_tree_opt, commit);
+}
+
+static const char diff_tree_usage[] =
+"git-diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
+"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
+"  -r            diff recursively\n"
+"  --root        include the initial commit as diff against /dev/null\n"
+COMMON_DIFF_OPTIONS_HELP;
+
+int cmd_diff_tree(int argc, const char **argv, char **envp)
+{
+	int nr_sha1;
+	char line[1000];
+	struct object *tree1, *tree2;
+	static struct rev_info *opt = &log_tree_opt;
+	struct object_list *list;
+	int read_stdin = 0;
+
+	git_config(git_diff_config);
+	nr_sha1 = 0;
+	init_revisions(opt);
+	opt->abbrev = 0;
+	opt->diff = 1;
+	argc = setup_revisions(argc, argv, opt, NULL);
+
+	while (--argc > 0) {
+		const char *arg = *++argv;
+
+		if (!strcmp(arg, "--stdin")) {
+			read_stdin = 1;
+			continue;
+		}
+		usage(diff_tree_usage);
+	}
+
+	/*
+	 * NOTE! "setup_revisions()" will have inserted the revisions
+	 * it parsed in reverse order. So if you do
+	 *
+	 *	git-diff-tree a b
+	 *
+	 * the commit list will be "b" -> "a" -> NULL, so we reverse
+	 * the order of the objects if the first one is not marked
+	 * UNINTERESTING.
+	 */
+	nr_sha1 = 0;
+	list = opt->pending_objects;
+	if (list) {
+		nr_sha1++;
+		tree1 = list->item;
+		list = list->next;
+		if (list) {
+			nr_sha1++;
+			tree2 = tree1;
+			tree1 = list->item;
+			if (list->next)
+				usage(diff_tree_usage);
+			/* Switch them around if the second one was uninteresting.. */
+			if (tree2->flags & UNINTERESTING) {
+				struct object *tmp = tree2;
+				tree2 = tree1;
+				tree1 = tmp;
+			}
+		}
+	}
+
+	switch (nr_sha1) {
+	case 0:
+		if (!read_stdin)
+			usage(diff_tree_usage);
+		break;
+	case 1:
+		diff_tree_commit_sha1(tree1->sha1);
+		break;
+	case 2:
+		diff_tree_sha1(tree1->sha1,
+			       tree2->sha1,
+			       "", &opt->diffopt);
+		log_tree_diff_flush(opt);
+		break;
+	}
+
+	if (!read_stdin)
+		return 0;
+
+	if (opt->diffopt.detect_rename)
+		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
+				       DIFF_SETUP_USE_CACHE);
+	while (fgets(line, sizeof(line), stdin))
+		if (line[0] == '\n')
+			fflush(stdout);
+		else
+			diff_tree_stdin(line);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 01882ec..7620984 100644
--- a/builtin.h
+++ b/builtin.h
@@ -34,5 +34,10 @@ extern int cmd_read_tree(int argc, const
 extern int cmd_commit_tree(int argc, const char **argv, char **envp);
 extern int cmd_apply(int argc, const char **argv, char **envp);
 extern int cmd_show_branch(int argc, const char **argv, char **envp);
+extern int cmd_diff_files(int argc, const char **argv, char **envp);
+extern int cmd_diff_index(int argc, const char **argv, char **envp);
+extern int cmd_diff_stages(int argc, const char **argv, char **envp);
+extern int cmd_diff_tree(int argc, const char **argv, char **envp);
+
 
 #endif
diff --git a/diff-files.c b/diff-files.c
deleted file mode 100644
index b9d193d..0000000
--- a/diff-files.c
+++ /dev/null
@@ -1,54 +0,0 @@
-/*
- * GIT - The information manager from hell
- *
- * Copyright (C) Linus Torvalds, 2005
- */
-#include "cache.h"
-#include "diff.h"
-#include "commit.h"
-#include "revision.h"
-
-static const char diff_files_usage[] =
-"git-diff-files [-q] [-0/-1/2/3 |-c|--cc] [<common diff options>] [<path>...]"
-COMMON_DIFF_OPTIONS_HELP;
-
-int main(int argc, const char **argv)
-{
-	struct rev_info rev;
-	int silent = 0;
-
-	git_config(git_diff_config);
-	init_revisions(&rev);
-	rev.abbrev = 0;
-
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
-	/*
-	 * Make sure there are NO revision (i.e. pending object) parameter,
-	 * rev.max_count is reasonable (0 <= n <= 3),
-	 * there is no other revision filtering parameters.
-	 */
-	if (rev.pending_objects ||
-	    rev.min_age != -1 || rev.max_age != -1)
-		usage(diff_files_usage);
-	/*
-	 * Backward compatibility wart - "diff-files -s" used to
-	 * defeat the common diff option "-s" which asked for
-	 * DIFF_FORMAT_NO_OUTPUT.
-	 */
-	if (rev.diffopt.output_format == DIFF_FORMAT_NO_OUTPUT)
-		rev.diffopt.output_format = DIFF_FORMAT_RAW;
-	return run_diff_files(&rev, silent);
-}
diff --git a/diff-index.c b/diff-index.c
deleted file mode 100644
index 8c9f601..0000000
--- a/diff-index.c
+++ /dev/null
@@ -1,38 +0,0 @@
-#include "cache.h"
-#include "diff.h"
-#include "commit.h"
-#include "revision.h"
-
-static const char diff_cache_usage[] =
-"git-diff-index [-m] [--cached] "
-"[<common diff options>] <tree-ish> [<path>...]"
-COMMON_DIFF_OPTIONS_HELP;
-
-int main(int argc, const char **argv)
-{
-	struct rev_info rev;
-	int cached = 0;
-	int i;
-
-	git_config(git_diff_config);
-	init_revisions(&rev);
-	rev.abbrev = 0;
-
-	argc = setup_revisions(argc, argv, &rev, NULL);
-	for (i = 1; i < argc; i++) {
-		const char *arg = argv[i];
-			
-		if (!strcmp(arg, "--cached"))
-			cached = 1;
-		else
-			usage(diff_cache_usage);
-	}
-	/*
-	 * Make sure there is one revision (i.e. pending object),
-	 * and there is no revision filtering parameters.
-	 */
-	if (!rev.pending_objects || rev.pending_objects->next ||
-	    rev.max_count != -1 || rev.min_age != -1 || rev.max_age != -1)
-		usage(diff_cache_usage);
-	return run_diff_index(&rev, cached);
-}
diff --git a/diff-stages.c b/diff-stages.c
deleted file mode 100644
index dcd20e7..0000000
--- a/diff-stages.c
+++ /dev/null
@@ -1,104 +0,0 @@
-/*
- * Copyright (c) 2005 Junio C Hamano
- */
-
-#include "cache.h"
-#include "diff.h"
-
-static struct diff_options diff_options;
-
-static const char diff_stages_usage[] =
-"git-diff-stages [<common diff options>] <stage1> <stage2> [<path>...]"
-COMMON_DIFF_OPTIONS_HELP;
-
-static void diff_stages(int stage1, int stage2, const char **pathspec)
-{
-	int i = 0;
-	while (i < active_nr) {
-		struct cache_entry *ce, *stages[4] = { NULL, };
-		struct cache_entry *one, *two;
-		const char *name;
-		int len, skip;
-
-		ce = active_cache[i];
-		skip = !ce_path_match(ce, pathspec);
-		len = ce_namelen(ce);
-		name = ce->name;
-		for (;;) {
-			int stage = ce_stage(ce);
-			stages[stage] = ce;
-			if (active_nr <= ++i)
-				break;
-			ce = active_cache[i];
-			if (ce_namelen(ce) != len ||
-			    memcmp(name, ce->name, len))
-				break;
-		}
-		one = stages[stage1];
-		two = stages[stage2];
-
-		if (skip || (!one && !two))
-			continue;
-		if (!one)
-			diff_addremove(&diff_options, '+', ntohl(two->ce_mode),
-				       two->sha1, name, NULL);
-		else if (!two)
-			diff_addremove(&diff_options, '-', ntohl(one->ce_mode),
-				       one->sha1, name, NULL);
-		else if (memcmp(one->sha1, two->sha1, 20) ||
-			 (one->ce_mode != two->ce_mode) ||
-			 diff_options.find_copies_harder)
-			diff_change(&diff_options,
-				    ntohl(one->ce_mode), ntohl(two->ce_mode),
-				    one->sha1, two->sha1, name, NULL);
-	}
-}
-
-int main(int ac, const char **av)
-{
-	int stage1, stage2;
-	const char *prefix = setup_git_directory();
-	const char **pathspec = NULL;
-
-	git_config(git_diff_config);
-	read_cache();
-	diff_setup(&diff_options);
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
-			else
-				usage(diff_stages_usage);
-		}
-		ac--; av++;
-	}
-
-	if (ac < 3 ||
-	    sscanf(av[1], "%d", &stage1) != 1 ||
-	    ! (0 <= stage1 && stage1 <= 3) ||
-	    sscanf(av[2], "%d", &stage2) != 1 ||
-	    ! (0 <= stage2 && stage2 <= 3))
-		usage(diff_stages_usage);
-
-	av += 3; /* The rest from av[0] are for paths restriction. */
-	pathspec = get_pathspec(prefix, av);
-
-	if (diff_setup_done(&diff_options) < 0)
-		usage(diff_stages_usage);
-
-	diff_stages(stage1, stage2, pathspec);
-	diffcore_std(&diff_options);
-	diff_flush(&diff_options);
-	return 0;
-}
diff --git a/diff-tree.c b/diff-tree.c
deleted file mode 100644
index 69bb74b..0000000
--- a/diff-tree.c
+++ /dev/null
@@ -1,147 +0,0 @@
-#include "cache.h"
-#include "diff.h"
-#include "commit.h"
-#include "log-tree.h"
-
-static struct rev_info log_tree_opt;
-
-static int diff_tree_commit_sha1(const unsigned char *sha1)
-{
-	struct commit *commit = lookup_commit_reference(sha1);
-	if (!commit)
-		return -1;
-	return log_tree_commit(&log_tree_opt, commit);
-}
-
-static int diff_tree_stdin(char *line)
-{
-	int len = strlen(line);
-	unsigned char sha1[20];
-	struct commit *commit;
-
-	if (!len || line[len-1] != '\n')
-		return -1;
-	line[len-1] = 0;
-	if (get_sha1_hex(line, sha1))
-		return -1;
-	commit = lookup_commit(sha1);
-	if (!commit || parse_commit(commit))
-		return -1;
-	if (isspace(line[40]) && !get_sha1_hex(line+41, sha1)) {
-		/* Graft the fake parents locally to the commit */
-		int pos = 41;
-		struct commit_list **pptr, *parents;
-
-		/* Free the real parent list */
-		for (parents = commit->parents; parents; ) {
-			struct commit_list *tmp = parents->next;
-			free(parents);
-			parents = tmp;
-		}
-		commit->parents = NULL;
-		pptr = &(commit->parents);
-		while (line[pos] && !get_sha1_hex(line + pos, sha1)) {
-			struct commit *parent = lookup_commit(sha1);
-			if (parent) {
-				pptr = &commit_list_insert(parent, pptr)->next;
-			}
-			pos += 41;
-		}
-	}
-	return log_tree_commit(&log_tree_opt, commit);
-}
-
-static const char diff_tree_usage[] =
-"git-diff-tree [--stdin] [-m] [-c] [--cc] [-s] [-v] [--pretty] [-t] [-r] [--root] "
-"[<common diff options>] <tree-ish> [<tree-ish>] [<path>...]\n"
-"  -r            diff recursively\n"
-"  --root        include the initial commit as diff against /dev/null\n"
-COMMON_DIFF_OPTIONS_HELP;
-
-int main(int argc, const char **argv)
-{
-	int nr_sha1;
-	char line[1000];
-	struct object *tree1, *tree2;
-	static struct rev_info *opt = &log_tree_opt;
-	struct object_list *list;
-	int read_stdin = 0;
-
-	git_config(git_diff_config);
-	nr_sha1 = 0;
-	init_revisions(opt);
-	opt->abbrev = 0;
-	opt->diff = 1;
-	argc = setup_revisions(argc, argv, opt, NULL);
-
-	while (--argc > 0) {
-		const char *arg = *++argv;
-
-		if (!strcmp(arg, "--stdin")) {
-			read_stdin = 1;
-			continue;
-		}
-		usage(diff_tree_usage);
-	}
-
-	/*
-	 * NOTE! "setup_revisions()" will have inserted the revisions
-	 * it parsed in reverse order. So if you do
-	 *
-	 *	git-diff-tree a b
-	 *
-	 * the commit list will be "b" -> "a" -> NULL, so we reverse
-	 * the order of the objects if the first one is not marked
-	 * UNINTERESTING.
-	 */
-	nr_sha1 = 0;
-	list = opt->pending_objects;
-	if (list) {
-		nr_sha1++;
-		tree1 = list->item;
-		list = list->next;
-		if (list) {
-			nr_sha1++;
-			tree2 = tree1;
-			tree1 = list->item;
-			if (list->next)
-				usage(diff_tree_usage);
-			/* Switch them around if the second one was uninteresting.. */
-			if (tree2->flags & UNINTERESTING) {
-				struct object *tmp = tree2;
-				tree2 = tree1;
-				tree1 = tmp;
-			}
-		}
-	}
-
-	switch (nr_sha1) {
-	case 0:
-		if (!read_stdin)
-			usage(diff_tree_usage);
-		break;
-	case 1:
-		diff_tree_commit_sha1(tree1->sha1);
-		break;
-	case 2:
-		diff_tree_sha1(tree1->sha1,
-			       tree2->sha1,
-			       "", &opt->diffopt);
-		log_tree_diff_flush(opt);
-		break;
-	}
-
-	if (!read_stdin)
-		return 0;
-
-	if (opt->diffopt.detect_rename)
-		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
-				       DIFF_SETUP_USE_CACHE);
-	while (fgets(line, sizeof(line), stdin))
-		if (line[0] == '\n')
-			fflush(stdout);
-		else
-			diff_tree_stdin(line);
-
-	return 0;
-}
diff --git a/git.c b/git.c
index d29505c..8749748 100644
--- a/git.c
+++ b/git.c
@@ -59,7 +59,11 @@ static void handle_internal_command(int 
 		{ "read-tree", cmd_read_tree },
 		{ "commit-tree", cmd_commit_tree },
 		{ "apply", cmd_apply },
-		{ "show-branch", cmd_show_branch }
+		{ "show-branch", cmd_show_branch },
+		{ "diff-files", cmd_diff_files },
+		{ "diff-index", cmd_diff_index },
+		{ "diff-stages", cmd_diff_stages },
+		{ "diff-tree", cmd_diff_tree }
 	};
 	int i;
 
-- 
1.3.3.g288c
