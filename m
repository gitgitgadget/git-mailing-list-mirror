From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] revisions: refactor init_revisions and setup_revisions.
Date: Wed, 28 May 2008 11:17:24 +0200
Message-ID: <1211966245-18393-1-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 11:18:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1Hnb-00020G-M4
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 11:18:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbYE1JRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 05:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751656AbYE1JRb
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 05:17:31 -0400
Received: from pan.madism.org ([88.191.52.104]:52723 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751623AbYE1JR3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 05:17:29 -0400
Received: from madism.org (APuteaux-155-1-52-172.w86-217.abo.wanadoo.fr [86.217.43.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 40EA138EB7;
	Wed, 28 May 2008 11:17:27 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id DCC361A42EF; Wed, 28 May 2008 11:17:25 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.145.ge0aba
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83083>

struct rev_info gains two new field:
* .def to store --default argument;
* .show_merge 1-bit field.

setup_revisions has been split in two: parse_revisions that does (almost)
only argument parsing, to be more like what parse-options can do, and
setup_revisions that does the rest.

Many places had no arguments to pass to setup_revisions, and those don't use
parse_revisions at all.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  This patch was submitted long time ago, Junio did some remarks I've now
  integrated (wrt the default argument that I passed to init_revisions once,
  and now is back as a setup_revisions argument).

 builtin-add.c           |    2 +-
 builtin-blame.c         |    3 ++-
 builtin-checkout.c      |    3 ++-
 builtin-commit.c        |    4 ++--
 builtin-diff-files.c    |    3 ++-
 builtin-diff-index.c    |    3 ++-
 builtin-diff-tree.c     |    3 ++-
 builtin-diff.c          |    3 ++-
 builtin-fast-export.c   |    3 ++-
 builtin-fmt-merge-msg.c |    2 +-
 builtin-log.c           |    7 ++++---
 builtin-pack-objects.c  |    3 ++-
 builtin-rev-list.c      |    3 ++-
 builtin-revert.c        |    2 +-
 builtin-shortlog.c      |    3 ++-
 bundle.c                |    6 ++++--
 http-push.c             |    3 ++-
 revision.c              |   32 ++++++++++++++++++--------------
 revision.h              |    7 +++++--
 upload-pack.c           |    4 ++--
 wt-status.c             |    6 +++---
 21 files changed, 63 insertions(+), 42 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 1da22ee..c60d310 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -121,7 +121,7 @@ int add_files_to_cache(const char *prefix, const char **pathspec, int flags)
 	struct update_callback_data data;
 	struct rev_info rev;
 	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
+	setup_revisions(&rev, NULL);
 	rev.prune_data = pathspec;
 	rev.diffopt.output_format = DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = update_callback;
diff --git a/builtin-blame.c b/builtin-blame.c
index cf41511..1e26b88 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2425,7 +2425,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	argv[unk] = NULL;
 
 	init_revisions(&revs, NULL);
-	setup_revisions(unk, argv, &revs, NULL);
+	parse_revisions(unk, argv, &revs);
+	setup_revisions(&revs, NULL);
 	memset(&sb, 0, sizeof(sb));
 
 	sb.revs = &revs;
diff --git a/builtin-checkout.c b/builtin-checkout.c
index 1ea017f..9d83fdb 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -357,7 +357,8 @@ static void report_tracking(struct branch_info *new, struct checkout_opts *opts)
 	strcpy(symmetric + 43, sha1_to_hex(theirs->object.sha1));
 
 	init_revisions(&revs, NULL);
-	setup_revisions(rev_argc, rev_argv, &revs, NULL);
+	parse_revisions(rev_argc, rev_argv, &revs);
+	setup_revisions(&revs, NULL);
 	prepare_revision_walk(&revs);
 
 	/* ... and count the commits on each side. */
diff --git a/builtin-commit.c b/builtin-commit.c
index 07872c8..59b3dc2 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -600,7 +600,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix)
 		else {
 			init_revisions(&rev, "");
 			rev.abbrev = 0;
-			setup_revisions(0, NULL, &rev, parent);
+			setup_revisions(&rev, parent);
 			DIFF_OPT_SET(&rev.diffopt, QUIET);
 			DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 			run_diff_index(&rev, 1 /* cached */);
@@ -834,7 +834,7 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 		die("could not parse newly created commit");
 
 	init_revisions(&rev, prefix);
-	setup_revisions(0, NULL, &rev, NULL);
+	setup_revisions(&rev, NULL);
 
 	rev.abbrev = 0;
 	rev.diff = 1;
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 384d871..e7e202a 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -23,7 +23,8 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	argc = parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev, NULL);
 	while (1 < argc && argv[1][0] == '-') {
 		if (!strcmp(argv[1], "--base"))
 			rev.max_count = 1;
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 2f44ebf..286a9de 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -20,7 +20,8 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	rev.abbrev = 0;
 
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	argc = parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev, NULL);
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 9d2a48f..0900175 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -72,7 +72,8 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	nr_sha1 = 0;
 	opt->abbrev = 0;
 	opt->diff = 1;
-	argc = setup_revisions(argc, argv, opt, NULL);
+	argc = parse_revisions(argc, argv, opt);
+	setup_revisions(opt, NULL);
 
 	while (--argc > 0) {
 		const char *arg = *++argv;
diff --git a/builtin-diff.c b/builtin-diff.c
index 4c289e7..a92dbd4 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -283,7 +283,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 
 	if (nongit)
 		die("Not a git repository");
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	argc = parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev, NULL);
 	if (!rev.diffopt.output_format) {
 		rev.diffopt.output_format = DIFF_FORMAT_PATCH;
 		if (diff_setup_done(&rev.diffopt) < 0)
diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 1dfc01e..59b60b5 100755
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -371,7 +371,8 @@ int cmd_fast_export(int argc, const char **argv, const char *prefix)
 	git_config(git_default_config, NULL);
 
 	init_revisions(&revs, prefix);
-	argc = setup_revisions(argc, argv, &revs, NULL);
+	argc = parse_revisions(argc, argv, &revs);
+	setup_revisions(&revs, NULL);
 	argc = parse_options(argc, argv, options, fast_export_usage, 0);
 	if (argc > 1)
 		usage_with_options (fast_export_usage, options);
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index b892621..dad81b8 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -187,7 +187,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 	if (!branch || branch->type != OBJ_COMMIT)
 		return;
 
-	setup_revisions(0, NULL, rev, NULL);
+	setup_revisions(rev, NULL);
 	rev->ignore_merges = 1;
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
diff --git a/builtin-log.c b/builtin-log.c
index 9817d6f..dde7192 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -68,8 +68,8 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	if (default_date_mode)
 		rev->date_mode = parse_date_format(default_date_mode);
 
-	argc = setup_revisions(argc, argv, rev, "HEAD");
-
+	argc = parse_revisions(argc, argv, rev);
+	setup_revisions(rev, "HEAD");
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
@@ -927,7 +927,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (numbered_files && use_stdout)
 		die ("--numbered-files and --stdout are mutually exclusive.");
 
-	argc = setup_revisions(argc, argv, &rev, "HEAD");
+	argc = parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev, "HEAD");
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 70d2f5d..46a8abc 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1981,7 +1981,8 @@ static void get_object_list(int ac, const char **av)
 
 	init_revisions(&revs, NULL);
 	save_commit_buffer = 0;
-	setup_revisions(ac, av, &revs, NULL);
+	parse_revisions(ac, av, &revs);
+	setup_revisions(&revs, NULL);
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		int len = strlen(line);
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index 11a7eae..ed60227 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -605,7 +605,8 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 	init_revisions(&revs, prefix);
 	revs.abbrev = 0;
 	revs.commit_format = CMIT_FMT_UNSPECIFIED;
-	argc = setup_revisions(argc, argv, &revs, NULL);
+	argc = parse_revisions(argc, argv, &revs);
+	setup_revisions(&revs, NULL);
 
 	for (i = 1 ; i < argc; i++) {
 		const char *arg = argv[i];
diff --git a/builtin-revert.c b/builtin-revert.c
index 0270f9b..0adff14 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -253,7 +253,7 @@ static int index_is_dirty(void)
 {
 	struct rev_info rev;
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, "HEAD");
+	setup_revisions(&rev, "HEAD");
 	DIFF_OPT_SET(&rev.diffopt, QUIET);
 	DIFF_OPT_SET(&rev.diffopt, EXIT_WITH_STATUS);
 	run_diff_index(&rev, 1);
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index e6a2865..3428bf6 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -256,7 +256,8 @@ int cmd_shortlog(int argc, const char **argv, const char *prefix)
 		argc--;
 	}
 	init_revisions(&rev, prefix);
-	argc = setup_revisions(argc, argv, &rev, NULL);
+	argc = parse_revisions(argc, argv, &rev);
+	setup_revisions(&rev, NULL);
 	if (argc > 1)
 		die ("unrecognized argument: %s", argv[1]);
 
diff --git a/bundle.c b/bundle.c
index 0ba5df1..c4848d7 100644
--- a/bundle.c
+++ b/bundle.c
@@ -120,7 +120,8 @@ int verify_bundle(struct bundle_header *header, int verbose)
 	if (revs.pending.nr != p->nr)
 		return ret;
 	req_nr = revs.pending.nr;
-	setup_revisions(2, argv, &revs, NULL);
+	parse_revisions(2, argv, &revs);
+	setup_revisions(&revs, NULL);
 
 	memset(&refs, 0, sizeof(struct object_array));
 	for (i = 0; i < revs.pending.nr; i++) {
@@ -226,7 +227,8 @@ int create_bundle(struct bundle_header *header, const char *path,
 		return error("rev-list died");
 
 	/* write references */
-	argc = setup_revisions(argc, argv, &revs, NULL);
+	argc = parse_revisions(argc, argv, &revs);
+	setup_revisions(&revs, NULL);
 	if (argc > 1)
 		return error("unrecognized argument: %s'", argv[1]);
 
diff --git a/http-push.c b/http-push.c
index f173dcd..fa757ff 100644
--- a/http-push.c
+++ b/http-push.c
@@ -2406,7 +2406,8 @@ int main(int argc, char **argv)
 			commit_argc++;
 		}
 		init_revisions(&revs, setup_git_directory());
-		setup_revisions(commit_argc, commit_argv, &revs, NULL);
+		parse_revisions(commit_argc, commit_argv, &revs);
+		setup_revisions(&revs, NULL);
 		free(new_sha1_hex);
 		if (old_sha1_hex) {
 			free(old_sha1_hex);
diff --git a/revision.c b/revision.c
index 5a1a948..4abe410 100644
--- a/revision.c
+++ b/revision.c
@@ -964,9 +964,9 @@ static void add_ignore_packed(struct rev_info *revs, const char *name)
  * Returns the number of arguments left that weren't recognized
  * (which are also moved to the head of the argument list)
  */
-int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def)
+int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 {
-	int i, flags, seen_dashdash, show_merge;
+	int i, flags, seen_dashdash;
 	const char **unrecognized = argv + 1;
 	int left = 1;
 	int all_match = 0;
@@ -987,7 +987,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		break;
 	}
 
-	flags = show_merge = 0;
+	flags = 0;
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg == '-') {
@@ -1075,11 +1075,11 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			if (!strcmp(arg, "--default")) {
 				if (++i >= argc)
 					die("bad --default argument");
-				def = argv[i];
+				revs->def = argv[i];
 				continue;
 			}
 			if (!strcmp(arg, "--merge")) {
-				show_merge = 1;
+				revs->show_merge = 1;
 				continue;
 			}
 			if (!strcmp(arg, "--topo-order")) {
@@ -1361,18 +1361,25 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->grep_filter) {
 		revs->grep_filter->regflags |= regflags;
 		revs->grep_filter->fixed = fixed;
+		revs->grep_filter->all_match = all_match;
 	}
+	return left;
+}
 
-	if (show_merge)
+void setup_revisions(struct rev_info *revs, const char *def)
+{
+	if (revs->def == NULL)
+		revs->def = def;
+	if (revs->show_merge)
 		prepare_show_merge(revs);
-	if (def && !revs->pending.nr) {
+	if (revs->def && !revs->pending.nr) {
 		unsigned char sha1[20];
 		struct object *object;
 		unsigned mode;
-		if (get_sha1_with_mode(def, sha1, &mode))
-			die("bad default revision '%s'", def);
-		object = get_reference(revs, def, sha1, 0);
-		add_pending_object_with_mode(revs, object, def, mode);
+		if (get_sha1_with_mode(revs->def, sha1, &mode))
+			die("bad default revision '%s'", revs->def);
+		object = get_reference(revs, revs->def, sha1, 0);
+		add_pending_object_with_mode(revs, object, revs->def, mode);
 	}
 
 	/* Did the user ask for any diff output? Run the diff! */
@@ -1406,7 +1413,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		die("diff_setup_done failed");
 
 	if (revs->grep_filter) {
-		revs->grep_filter->all_match = all_match;
 		compile_grep_patterns(revs->grep_filter);
 	}
 
@@ -1423,8 +1429,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 	if (revs->reflog_info && revs->graph)
 		die("cannot combine --walk-reflogs with --graph");
-
-	return left;
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
diff --git a/revision.h b/revision.h
index dcf08e0..72ab144 100644
--- a/revision.h
+++ b/revision.h
@@ -25,6 +25,7 @@ struct rev_info {
 
 	/* Basic information */
 	const char *prefix;
+	const char *def;
 	void *prune_data;
 	unsigned int early_output;
 
@@ -65,8 +66,9 @@ struct rev_info {
 
 	/* Format info */
 	unsigned int	shown_one:1,
-			abbrev_commit:1,
+			show_merge:1,
 			use_terminator:1,
+			abbrev_commit:1,
 			missing_newline:1;
 	enum date_mode date_mode;
 
@@ -116,7 +118,8 @@ typedef void (*show_early_output_fn_t)(struct rev_info *, struct commit_list *);
 volatile show_early_output_fn_t show_early_output;
 
 extern void init_revisions(struct rev_info *revs, const char *prefix);
-extern int setup_revisions(int argc, const char **argv, struct rev_info *revs, const char *def);
+extern int parse_revisions(int argc, const char **argv, struct rev_info *revs);
+extern void setup_revisions(struct rev_info *revs, const char *def);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
 
 extern int prepare_revision_walk(struct rev_info *revs);
diff --git a/upload-pack.c b/upload-pack.c
index b46dd36..9d031fc 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -116,7 +116,7 @@ static int do_rev_list(int fd, void *create_full_pack)
 
 	if (create_full_pack) {
 		const char *args[] = {"rev-list", "--all", NULL};
-		setup_revisions(2, args, &revs, NULL);
+		parse_revisions(2, args, &revs);
 	} else {
 		for (i = 0; i < want_obj.nr; i++) {
 			struct object *o = want_obj.objects[i].item;
@@ -129,8 +129,8 @@ static int do_rev_list(int fd, void *create_full_pack)
 			o->flags |= UNINTERESTING;
 			add_pending_object(&revs, o, NULL);
 		}
-		setup_revisions(0, NULL, &revs, NULL);
 	}
+	setup_revisions(&revs, NULL);
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
 	mark_edges_uninteresting(revs.commits, &revs, show_edge);
diff --git a/wt-status.c b/wt-status.c
index 5b4d74c..7fa6f59 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -204,7 +204,7 @@ static void wt_status_print_updated(struct wt_status *s)
 {
 	struct rev_info rev;
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, s->reference);
+	setup_revisions(&rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_updated_cb;
 	rev.diffopt.format_callback_data = s;
@@ -218,7 +218,7 @@ static void wt_status_print_changed(struct wt_status *s)
 {
 	struct rev_info rev;
 	init_revisions(&rev, "");
-	setup_revisions(0, NULL, &rev, NULL);
+	setup_revisions(&rev, NULL);
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = wt_status_print_changed_cb;
 	rev.diffopt.format_callback_data = s;
@@ -306,7 +306,7 @@ static void wt_status_print_verbose(struct wt_status *s)
 	struct rev_info rev;
 
 	init_revisions(&rev, NULL);
-	setup_revisions(0, NULL, &rev, s->reference);
+	setup_revisions(&rev, s->reference);
 	rev.diffopt.output_format |= DIFF_FORMAT_PATCH;
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.file = s->fp;
-- 
1.5.6.rc0.145.ge0aba
