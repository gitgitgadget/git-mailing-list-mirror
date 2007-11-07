From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH DIFF-CLEANUP 1/2] Make the diff_options bitfields be an unsigned with explicit masks.
Date: Wed,  7 Nov 2007 11:20:31 +0100
Message-ID: <1194430832-6224-7-git-send-email-madcoder@debian.org>
References: <1194430832-6224-1-git-send-email-madcoder@debian.org>
 <1194430832-6224-2-git-send-email-madcoder@debian.org>
 <1194430832-6224-3-git-send-email-madcoder@debian.org>
 <1194430832-6224-4-git-send-email-madcoder@debian.org>
 <1194430832-6224-5-git-send-email-madcoder@debian.org>
 <1194430832-6224-6-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 11:21:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ipi2Y-0001LP-U3
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 11:21:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbXKGKUu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 05:20:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751382AbXKGKUt
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 05:20:49 -0500
Received: from pan.madism.org ([88.191.52.104]:35307 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752967AbXKGKUh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 05:20:37 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B093928E27;
	Wed,  7 Nov 2007 11:20:34 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3473F1CAA1; Wed,  7 Nov 2007 11:20:33 +0100 (CET)
X-Mailer: git-send-email 1.5.3.5.1598.gdef4e
In-Reply-To: <1194430832-6224-6-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63800>

reverse_diff was a bit-value in disguise, it's merged in the flags now.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-blame.c      |   10 ++--
 builtin-diff-files.c |    4 +-
 builtin-diff-index.c |    4 +-
 builtin-diff-tree.c  |    9 ++--
 builtin-diff.c       |   12 +++---
 builtin-log.c        |   24 ++++------
 combine-diff.c       |   10 ++--
 diff-lib.c           |   23 +++++-----
 diff.c               |  123 ++++++++++++++++++++++++-------------------------
 diff.h               |   40 ++++++++++-------
 log-tree.c           |    6 +--
 merge-recursive.c    |    2 +-
 patch-ids.c          |    2 +-
 revision.c           |   22 +++++-----
 tree-diff.c          |   14 +++---
 15 files changed, 155 insertions(+), 150 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 55a3c0b..eaf9c15 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -335,7 +335,7 @@ static struct origin *find_origin(struct scoreboard *sb,
 	 * same and diff-tree is fairly efficient about this.
 	 */
 	diff_setup(&diff_opts);
-	diff_opts.recursive = 1;
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.detect_rename = 0;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	paths[0] = origin->path;
@@ -409,7 +409,7 @@ static struct origin *find_rename(struct scoreboard *sb,
 	const char *paths[2];
 
 	diff_setup(&diff_opts);
-	diff_opts.recursive = 1;
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = origin->path;
@@ -1075,7 +1075,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 		return 1; /* nothing remains for this target */
 
 	diff_setup(&diff_opts);
-	diff_opts.recursive = 1;
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 
 	paths[0] = NULL;
@@ -1093,7 +1093,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 	if ((opt & PICKAXE_BLAME_COPY_HARDEST)
 	    || ((opt & PICKAXE_BLAME_COPY_HARDER)
 		&& (!porigin || strcmp(target->path, porigin->path))))
-		diff_opts.find_copies_harder = 1;
+		DIFF_OPT_SET(&diff_opts, FIND_COPIES_HARDER);
 
 	if (is_null_sha1(target->commit->object.sha1))
 		do_diff_cache(parent->tree->object.sha1, &diff_opts);
@@ -1102,7 +1102,7 @@ static int find_copy_in_parent(struct scoreboard *sb,
 			       target->commit->tree->object.sha1,
 			       "", &diff_opts);
 
-	if (!diff_opts.find_copies_harder)
+	if (!DIFF_OPT_TST(&diff_opts, FIND_COPIES_HARDER))
 		diffcore_std(&diff_opts);
 
 	retval = 0;
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index 6cb30c8..046b7e3 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -31,5 +31,7 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
 	result = run_diff_files_cmd(&rev, argc, argv);
-	return rev.diffopt.exit_with_status ? rev.diffopt.has_changes: result;
+	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
+		return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
+	return result;
 }
diff --git a/builtin-diff-index.c b/builtin-diff-index.c
index 81e7167..556c506 100644
--- a/builtin-diff-index.c
+++ b/builtin-diff-index.c
@@ -44,5 +44,7 @@ int cmd_diff_index(int argc, const char **argv, const char *prefix)
 		return -1;
 	}
 	result = run_diff_index(&rev, cached);
-	return rev.diffopt.exit_with_status ? rev.diffopt.has_changes: result;
+	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
+		return DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
+	return result;
 }
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 0b591c8..e71841a 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -118,12 +118,12 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!read_stdin)
-		return opt->diffopt.exit_with_status ?
-		    opt->diffopt.has_changes: 0;
+		return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
+			&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);
 
 	if (opt->diffopt.detect_rename)
 		opt->diffopt.setup |= (DIFF_SETUP_USE_SIZE_CACHE |
-				       DIFF_SETUP_USE_CACHE);
+							   DIFF_SETUP_USE_CACHE);
 	while (fgets(line, sizeof(line), stdin)) {
 		unsigned char sha1[20];
 
@@ -134,5 +134,6 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 		else
 			diff_tree_stdin(line);
 	}
-	return opt->diffopt.exit_with_status ? opt->diffopt.has_changes: 0;
+	return DIFF_OPT_TST(&opt->diffopt, EXIT_WITH_STATUS)
+		&& DIFF_OPT_TST(&opt->diffopt, HAS_CHANGES);
 }
diff --git a/builtin-diff.c b/builtin-diff.c
index 80392a8..59b9c6e 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -35,7 +35,7 @@ static void stuff_change(struct diff_options *opt,
 	    !hashcmp(old_sha1, new_sha1) && (old_mode == new_mode))
 		return;
 
-	if (opt->reverse_diff) {
+	if (DIFF_OPT_TST(opt, REVERSE_DIFF)) {
 		unsigned tmp;
 		const unsigned char *tmp_u;
 		const char *tmp_c;
@@ -257,13 +257,13 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 		if (diff_setup_done(&rev.diffopt) < 0)
 			die("diff_setup_done failed");
 	}
-	rev.diffopt.allow_external = 1;
-	rev.diffopt.recursive = 1;
+	DIFF_OPT_SET(&rev.diffopt, ALLOW_EXTERNAL);
+	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	/* If the user asked for our exit code then don't start a
 	 * pager or we would end up reporting its exit code instead.
 	 */
-	if (!rev.diffopt.exit_with_status)
+	if (!DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
 		setup_pager();
 
 	/* Do we have --cached and not have a pending object, then
@@ -367,8 +367,8 @@ int cmd_diff(int argc, const char **argv, const char *prefix)
 	else
 		result = builtin_diff_combined(&rev, argc, argv,
 					     ent, ents);
-	if (rev.diffopt.exit_with_status)
-		result = rev.diffopt.has_changes;
+	if (DIFF_OPT_TST(&rev.diffopt, EXIT_WITH_STATUS))
+		result = DIFF_OPT_TST(&rev.diffopt, HAS_CHANGES) != 0;
 
 	if (1 < rev.diffopt.skip_stat_unmatch)
 		refresh_index_quietly();
diff --git a/builtin-log.c b/builtin-log.c
index b6ca04a..72745cd 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -55,13 +55,13 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	rev->abbrev = DEFAULT_ABBREV;
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	rev->verbose_header = 1;
-	rev->diffopt.recursive = 1;
+	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	argc = setup_revisions(argc, argv, rev, "HEAD");
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
 		rev->always_show_header = 0;
-	if (rev->diffopt.follow_renames) {
+	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
 		rev->always_show_header = 0;
 		if (rev->diffopt.nr_paths != 1)
 			usage("git logs can only follow renames on one pathname at a time");
@@ -308,11 +308,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			struct tag *t = (struct tag *)o;
 
 			printf("%stag %s%s\n\n",
-					diff_get_color(rev.diffopt.color_diff,
-						DIFF_COMMIT),
+					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					t->tag,
-					diff_get_color(rev.diffopt.color_diff,
-						DIFF_RESET));
+					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			ret = show_object(o->sha1, 1);
 			objects[i].item = (struct object *)t->tagged;
 			i--;
@@ -320,11 +318,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		}
 		case OBJ_TREE:
 			printf("%stree %s%s\n\n",
-					diff_get_color(rev.diffopt.color_diff,
-						DIFF_COMMIT),
+					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
-					diff_get_color(rev.diffopt.color_diff,
-						DIFF_RESET));
+					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
 			read_tree_recursive((struct tree *)o, "", 0, 0, NULL,
 					show_tree_object);
 			break;
@@ -620,7 +616,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.combine_merges = 0;
 	rev.ignore_merges = 1;
 	rev.diffopt.msg_sep = "";
-	rev.diffopt.recursive = 1;
+	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
 	rev.extra_headers = extra_headers;
@@ -728,8 +724,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_SUMMARY | DIFF_FORMAT_PATCH;
 
-	if (!rev.diffopt.text)
-		rev.diffopt.binary = 1;
+	if (!DIFF_OPT_TST(&rev.diffopt, TEXT))
+		DIFF_OPT_SET(&rev.diffopt, BINARY);
 
 	if (!output_directory && !use_stdout)
 		output_directory = prefix;
@@ -887,7 +883,7 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	revs.diff = 1;
 	revs.combine_merges = 0;
 	revs.ignore_merges = 1;
-	revs.diffopt.recursive = 1;
+	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 
 	if (add_pending_commit(head, &revs, 0))
 		die("Unknown commit %s", head);
diff --git a/combine-diff.c b/combine-diff.c
index fe5a2a1..3cab04b 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -664,7 +664,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	int mode_differs = 0;
 	int i, show_hunks;
 	int working_tree_file = is_null_sha1(elem->sha1);
-	int abbrev = opt->full_index ? 40 : DEFAULT_ABBREV;
+        int abbrev = DIFF_OPT_TST(opt, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
 	mmfile_t result_file;
 
 	context = opt->context;
@@ -784,7 +784,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 
 	if (show_hunks || mode_differs || working_tree_file) {
 		const char *abb;
-		int use_color = opt->color_diff;
+		int use_color = DIFF_OPT_TST(opt, COLOR_DIFF);
 		const char *c_meta = diff_get_color(use_color, DIFF_METAINFO);
 		const char *c_reset = diff_get_color(use_color, DIFF_RESET);
 		int added = 0;
@@ -836,7 +836,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 			dump_quoted_path("+++ /dev/", "null", c_meta, c_reset);
 		else
 			dump_quoted_path("+++ b/", elem->path, c_meta, c_reset);
-		dump_sline(sline, cnt, num_parent, opt->color_diff);
+		dump_sline(sline, cnt, num_parent, DIFF_OPT_TST(opt, COLOR_DIFF));
 	}
 	free(result);
 
@@ -929,8 +929,8 @@ void diff_tree_combined(const unsigned char *sha1,
 
 	diffopts = *opt;
 	diffopts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diffopts.recursive = 1;
-	diffopts.allow_external = 0;
+	DIFF_OPT_SET(&diffopts, RECURSIVE);
+	DIFF_OPT_CLR(&diffopts, ALLOW_EXTERNAL);
 
 	show_log_first = !!rev->loginfo && !rev->no_commit_id;
 	needsep = 0;
diff --git a/diff-lib.c b/diff-lib.c
index da55713..69b5dc9 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -121,7 +121,7 @@ static int queue_diff(struct diff_options *o,
 	} else {
 		struct diff_filespec *d1, *d2;
 
-		if (o->reverse_diff) {
+		if (DIFF_OPT_TST(o, REVERSE_DIFF)) {
 			unsigned tmp;
 			const char *tmp_c;
 			tmp = mode1; mode1 = mode2; mode2 = tmp;
@@ -188,8 +188,7 @@ static int handle_diff_files_args(struct rev_info *revs,
 		else if (!strcmp(argv[1], "-n") ||
 				!strcmp(argv[1], "--no-index")) {
 			revs->max_count = -2;
-			revs->diffopt.exit_with_status = 1;
-			revs->diffopt.no_index = 1;
+			revs->diffopt.flags |= DIFF_OPT_EXIT_WITH_STATUS | DIFF_OPT_NO_INDEX;
 		}
 		else if (!strcmp(argv[1], "-q"))
 			*silent = 1;
@@ -207,7 +206,7 @@ static int handle_diff_files_args(struct rev_info *revs,
 		if (!is_in_index(revs->diffopt.paths[0]) ||
 					!is_in_index(revs->diffopt.paths[1])) {
 			revs->max_count = -2;
-			revs->diffopt.no_index = 1;
+			DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
 		}
 	}
 
@@ -258,7 +257,7 @@ int setup_diff_no_index(struct rev_info *revs,
 			break;
 		} else if (i < argc - 3 && !strcmp(argv[i], "--no-index")) {
 			i = argc - 3;
-			revs->diffopt.exit_with_status = 1;
+			DIFF_OPT_SET(&revs->diffopt, EXIT_WITH_STATUS);
 			break;
 		}
 	if (argc != i + 2 || (!is_outside_repo(argv[i + 1], nongit, prefix) &&
@@ -296,7 +295,7 @@ int setup_diff_no_index(struct rev_info *revs,
 	else
 		revs->diffopt.paths = argv + argc - 2;
 	revs->diffopt.nr_paths = 2;
-	revs->diffopt.no_index = 1;
+	DIFF_OPT_SET(&revs->diffopt, NO_INDEX);
 	revs->max_count = -2;
 	if (diff_setup_done(&revs->diffopt) < 0)
 		die("diff_setup_done failed");
@@ -310,7 +309,7 @@ int run_diff_files_cmd(struct rev_info *revs, int argc, const char **argv)
 	if (handle_diff_files_args(revs, argc, argv, &silent_on_removed))
 		return -1;
 
-	if (revs->diffopt.no_index) {
+	if (DIFF_OPT_TST(&revs->diffopt, NO_INDEX)) {
 		if (revs->diffopt.nr_paths != 2)
 			return error("need two files/directories with --no-index");
 		if (queue_diff(&revs->diffopt, revs->diffopt.paths[0],
@@ -346,7 +345,8 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 		struct cache_entry *ce = active_cache[i];
 		int changed;
 
-		if (revs->diffopt.quiet && revs->diffopt.has_changes)
+		if (DIFF_OPT_TST(&revs->diffopt, QUIET) &&
+			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
 
 		if (!ce_path_match(ce, revs->prune_data))
@@ -442,7 +442,7 @@ int run_diff_files(struct rev_info *revs, int silent_on_removed)
 			continue;
 		}
 		changed = ce_match_stat(ce, &st, 0);
-		if (!changed && !revs->diffopt.find_copies_harder)
+		if (!changed && !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 			continue;
 		oldmode = ntohl(ce->ce_mode);
 		newmode = ntohl(ce_mode_from_stat(ce, st.st_mode));
@@ -561,7 +561,7 @@ static int show_modified(struct rev_info *revs,
 
 	oldmode = old->ce_mode;
 	if (mode == oldmode && !hashcmp(sha1, old->sha1) &&
-	    !revs->diffopt.find_copies_harder)
+	    !DIFF_OPT_TST(&revs->diffopt, FIND_COPIES_HARDER))
 		return 0;
 
 	mode = ntohl(mode);
@@ -581,7 +581,8 @@ static int diff_cache(struct rev_info *revs,
 		struct cache_entry *ce = *ac;
 		int same = (entries > 1) && ce_same_name(ce, ac[1]);
 
-		if (revs->diffopt.quiet && revs->diffopt.has_changes)
+		if (DIFF_OPT_TST(&revs->diffopt, QUIET) &&
+			DIFF_OPT_TST(&revs->diffopt, HAS_CHANGES))
 			break;
 
 		if (!ce_path_match(ce, pathspec))
diff --git a/diff.c b/diff.c
index 6bb902f..97c9a59 100644
--- a/diff.c
+++ b/diff.c
@@ -827,10 +827,10 @@ static void show_stats(struct diffstat_t* data, struct diff_options *options)
 	}
 
 	/* Find the longest filename and max number of changes */
-	reset = diff_get_color(options->color_diff, DIFF_RESET);
-	set = diff_get_color(options->color_diff, DIFF_PLAIN);
-	add_c = diff_get_color(options->color_diff, DIFF_FILE_NEW);
-	del_c = diff_get_color(options->color_diff, DIFF_FILE_OLD);
+	reset = diff_get_color_opt(options, DIFF_RESET);
+	set   = diff_get_color_opt(options, DIFF_PLAIN);
+	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
+	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
 
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
@@ -1256,8 +1256,8 @@ static void builtin_diff(const char *name_a,
 	mmfile_t mf1, mf2;
 	const char *lbl[2];
 	char *a_one, *b_two;
-	const char *set = diff_get_color(o->color_diff, DIFF_METAINFO);
-	const char *reset = diff_get_color(o->color_diff, DIFF_RESET);
+	const char *set = diff_get_color_opt(o, DIFF_METAINFO);
+	const char *reset = diff_get_color_opt(o, DIFF_RESET);
 
 	a_one = quote_two("a/", name_a + (*name_a == '/'));
 	b_two = quote_two("b/", name_b + (*name_b == '/'));
@@ -1290,7 +1290,7 @@ static void builtin_diff(const char *name_a,
 			goto free_ab_and_return;
 		if (complete_rewrite) {
 			emit_rewrite_diff(name_a, name_b, one, two,
-					o->color_diff);
+					DIFF_OPT_TST(o, COLOR_DIFF));
 			o->found_changes = 1;
 			goto free_ab_and_return;
 		}
@@ -1299,13 +1299,13 @@ static void builtin_diff(const char *name_a,
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
 
-	if (!o->text &&
+	if (!DIFF_OPT_TST(o, TEXT) &&
 	    (diff_filespec_is_binary(one) || diff_filespec_is_binary(two))) {
 		/* Quite common confusing case */
 		if (mf1.size == mf2.size &&
 		    !memcmp(mf1.ptr, mf2.ptr, mf1.size))
 			goto free_ab_and_return;
-		if (o->binary)
+		if (DIFF_OPT_TST(o, BINARY))
 			emit_binary_diff(&mf1, &mf2);
 		else
 			printf("Binary files %s and %s differ\n",
@@ -1328,7 +1328,7 @@ static void builtin_diff(const char *name_a,
 		memset(&xecfg, 0, sizeof(xecfg));
 		memset(&ecbdata, 0, sizeof(ecbdata));
 		ecbdata.label_path = lbl;
-		ecbdata.color_diff = o->color_diff;
+		ecbdata.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 		ecbdata.found_changesp = &o->found_changes;
 		xpp.flags = XDF_NEED_MINIMAL | o->xdl_opts;
 		xecfg.ctxlen = o->context;
@@ -1344,11 +1344,11 @@ static void builtin_diff(const char *name_a,
 		ecb.outf = xdiff_outf;
 		ecb.priv = &ecbdata;
 		ecbdata.xm.consume = fn_out_consume;
-		if (o->color_diff_words)
+		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			ecbdata.diff_words =
 				xcalloc(1, sizeof(struct diff_words_data));
 		xdl_diff(&mf1, &mf2, &xpp, &xecfg, &ecb);
-		if (o->color_diff_words)
+		if (DIFF_OPT_TST(o, COLOR_DIFF_WORDS))
 			free_diff_words_data(&ecbdata);
 	}
 
@@ -1422,7 +1422,7 @@ static void builtin_checkdiff(const char *name_a, const char *name_b,
 	data.xm.consume = checkdiff_consume;
 	data.filename = name_b ? name_b : name_a;
 	data.lineno = 0;
-	data.color_diff = o->color_diff;
+	data.color_diff = DIFF_OPT_TST(o, COLOR_DIFF);
 
 	if (fill_mmfile(&mf1, one) < 0 || fill_mmfile(&mf2, two) < 0)
 		die("unable to read files to diff");
@@ -1866,7 +1866,7 @@ static void run_diff_cmd(const char *pgm,
 			 struct diff_options *o,
 			 int complete_rewrite)
 {
-	if (!o->allow_external)
+	if (!DIFF_OPT_TST(o, ALLOW_EXTERNAL))
 		pgm = NULL;
 	else {
 		const char *cmd = external_diff_attr(name);
@@ -1964,9 +1964,9 @@ static void run_diff(struct diff_filepair *p, struct diff_options *o)
 	}
 
 	if (hashcmp(one->sha1, two->sha1)) {
-		int abbrev = o->full_index ? 40 : DEFAULT_ABBREV;
+		int abbrev = DIFF_OPT_TST(o, FULL_INDEX) ? 40 : DEFAULT_ABBREV;
 
-		if (o->binary) {
+		if (DIFF_OPT_TST(o, BINARY)) {
 			mmfile_t mf;
 			if ((!fill_mmfile(&mf, one) && diff_filespec_is_binary(one)) ||
 			    (!fill_mmfile(&mf, two) && diff_filespec_is_binary(two)))
@@ -2058,7 +2058,10 @@ void diff_setup(struct diff_options *options)
 
 	options->change = diff_change;
 	options->add_remove = diff_addremove;
-	options->color_diff = diff_use_color_default;
+	if (diff_use_color_default)
+		DIFF_OPT_SET(options, COLOR_DIFF);
+	else
+		DIFF_OPT_CLR(options, COLOR_DIFF);
 	options->detect_rename = diff_detect_rename_default;
 }
 
@@ -2077,7 +2080,7 @@ int diff_setup_done(struct diff_options *options)
 	if (count > 1)
 		die("--name-only, --name-status, --check and -s are mutually exclusive");
 
-	if (options->find_copies_harder)
+	if (DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		options->detect_rename = DIFF_DETECT_COPY;
 
 	if (options->output_format & (DIFF_FORMAT_NAME |
@@ -2101,12 +2104,12 @@ int diff_setup_done(struct diff_options *options)
 				      DIFF_FORMAT_SHORTSTAT |
 				      DIFF_FORMAT_SUMMARY |
 				      DIFF_FORMAT_CHECKDIFF))
-		options->recursive = 1;
+		DIFF_OPT_SET(options, RECURSIVE);
 	/*
 	 * Also pickaxe would not work very well if you do not say recursive
 	 */
 	if (options->pickaxe)
-		options->recursive = 1;
+		DIFF_OPT_SET(options, RECURSIVE);
 
 	if (options->detect_rename && options->rename_limit < 0)
 		options->rename_limit = diff_rename_limit_default;
@@ -2128,9 +2131,9 @@ int diff_setup_done(struct diff_options *options)
 	 * to have found.  It does not make sense not to return with
 	 * exit code in such a case either.
 	 */
-	if (options->quiet) {
+	if (DIFF_OPT_TST(options, QUIET)) {
 		options->output_format = DIFF_FORMAT_NO_OUTPUT;
-		options->exit_with_status = 1;
+		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	}
 
 	/*
@@ -2138,7 +2141,7 @@ int diff_setup_done(struct diff_options *options)
 	 * upon the first hit.  We need to run diff as usual.
 	 */
 	if (options->pickaxe || options->filter)
-		options->quiet = 0;
+		DIFF_OPT_CLR(options, QUIET);
 
 	return 0;
 }
@@ -2201,15 +2204,12 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_PATCH;
 	else if (!strcmp(arg, "--raw"))
 		options->output_format |= DIFF_FORMAT_RAW;
-	else if (!strcmp(arg, "--patch-with-raw")) {
+	else if (!strcmp(arg, "--patch-with-raw"))
 		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_RAW;
-	}
-	else if (!strcmp(arg, "--numstat")) {
+	else if (!strcmp(arg, "--numstat"))
 		options->output_format |= DIFF_FORMAT_NUMSTAT;
-	}
-	else if (!strcmp(arg, "--shortstat")) {
+	else if (!strcmp(arg, "--shortstat"))
 		options->output_format |= DIFF_FORMAT_SHORTSTAT;
-	}
 	else if (!prefixcmp(arg, "--stat")) {
 		char *end;
 		int width = options->stat_width;
@@ -2241,33 +2241,30 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 		options->output_format |= DIFF_FORMAT_CHECKDIFF;
 	else if (!strcmp(arg, "--summary"))
 		options->output_format |= DIFF_FORMAT_SUMMARY;
-	else if (!strcmp(arg, "--patch-with-stat")) {
+	else if (!strcmp(arg, "--patch-with-stat"))
 		options->output_format |= DIFF_FORMAT_PATCH | DIFF_FORMAT_DIFFSTAT;
-	}
 	else if (!strcmp(arg, "-z"))
 		options->line_termination = 0;
 	else if (!prefixcmp(arg, "-l"))
 		options->rename_limit = strtoul(arg+2, NULL, 10);
 	else if (!strcmp(arg, "--full-index"))
-		options->full_index = 1;
+		DIFF_OPT_SET(options, FULL_INDEX);
 	else if (!strcmp(arg, "--binary")) {
 		options->output_format |= DIFF_FORMAT_PATCH;
-		options->binary = 1;
-	}
-	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text")) {
-		options->text = 1;
+		DIFF_OPT_SET(options, BINARY);
 	}
+	else if (!strcmp(arg, "-a") || !strcmp(arg, "--text"))
+		DIFF_OPT_SET(options, TEXT);
 	else if (!strcmp(arg, "--name-only"))
 		options->output_format |= DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
 		options->output_format |= DIFF_FORMAT_NAME_STATUS;
 	else if (!strcmp(arg, "-R"))
-		options->reverse_diff = 1;
+		DIFF_OPT_SET(options, REVERSE_DIFF);
 	else if (!prefixcmp(arg, "-S"))
 		options->pickaxe = arg + 2;
-	else if (!strcmp(arg, "-s")) {
+	else if (!strcmp(arg, "-s"))
 		options->output_format |= DIFF_FORMAT_NO_OUTPUT;
-	}
 	else if (!prefixcmp(arg, "-O"))
 		options->orderfile = arg + 2;
 	else if (!prefixcmp(arg, "--diff-filter="))
@@ -2277,28 +2274,25 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--pickaxe-regex"))
 		options->pickaxe_opts = DIFF_PICKAXE_REGEX;
 	else if (!prefixcmp(arg, "-B")) {
-		if ((options->break_opt =
-		     diff_scoreopt_parse(arg)) == -1)
+		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 	}
 	else if (!prefixcmp(arg, "-M")) {
-		if ((options->rename_score =
-		     diff_scoreopt_parse(arg)) == -1)
+		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_RENAME;
 	}
 	else if (!prefixcmp(arg, "-C")) {
 		if (options->detect_rename == DIFF_DETECT_COPY)
-			options->find_copies_harder = 1;
-		if ((options->rename_score =
-		     diff_scoreopt_parse(arg)) == -1)
+			DIFF_OPT_SET(options, FIND_COPIES_HARDER);
+		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)
 			return -1;
 		options->detect_rename = DIFF_DETECT_COPY;
 	}
 	else if (!strcmp(arg, "--find-copies-harder"))
-		options->find_copies_harder = 1;
+		DIFF_OPT_SET(options, FIND_COPIES_HARDER);
 	else if (!strcmp(arg, "--follow"))
-		options->follow_renames = 1;
+		DIFF_OPT_SET(options, FOLLOW_RENAMES);
 	else if (!strcmp(arg, "--abbrev"))
 		options->abbrev = DEFAULT_ABBREV;
 	else if (!prefixcmp(arg, "--abbrev=")) {
@@ -2309,9 +2303,9 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 			options->abbrev = 40;
 	}
 	else if (!strcmp(arg, "--color"))
-		options->color_diff = 1;
+		DIFF_OPT_SET(options, COLOR_DIFF);
 	else if (!strcmp(arg, "--no-color"))
-		options->color_diff = 0;
+		DIFF_OPT_CLR(options, COLOR_DIFF);
 	else if (!strcmp(arg, "-w") || !strcmp(arg, "--ignore-all-space"))
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE;
 	else if (!strcmp(arg, "-b") || !strcmp(arg, "--ignore-space-change"))
@@ -2319,17 +2313,17 @@ int diff_opt_parse(struct diff_options *options, const char **av, int ac)
 	else if (!strcmp(arg, "--ignore-space-at-eol"))
 		options->xdl_opts |= XDF_IGNORE_WHITESPACE_AT_EOL;
 	else if (!strcmp(arg, "--color-words"))
-		options->color_diff = options->color_diff_words = 1;
+		options->flags |= DIFF_OPT_COLOR_DIFF | DIFF_OPT_COLOR_DIFF_WORDS;
 	else if (!strcmp(arg, "--no-renames"))
 		options->detect_rename = 0;
 	else if (!strcmp(arg, "--exit-code"))
-		options->exit_with_status = 1;
+		DIFF_OPT_SET(options, EXIT_WITH_STATUS);
 	else if (!strcmp(arg, "--quiet"))
-		options->quiet = 1;
+		DIFF_OPT_SET(options, QUIET);
 	else if (!strcmp(arg, "--ext-diff"))
-		options->allow_external = 1;
+		DIFF_OPT_SET(options, ALLOW_EXTERNAL);
 	else if (!strcmp(arg, "--no-ext-diff"))
-		options->allow_external = 0;
+		DIFF_OPT_CLR(options, ALLOW_EXTERNAL);
 	else
 		return 0;
 	return 1;
@@ -3084,7 +3078,7 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 			 * to determine how many paths were dirty only
 			 * due to stat info mismatch.
 			 */
-			if (!diffopt->no_index)
+			if (!DIFF_OPT_TST(diffopt, NO_INDEX))
 				diffopt->skip_stat_unmatch++;
 			diff_free_filepair(p);
 		}
@@ -3095,10 +3089,10 @@ static void diffcore_skip_stat_unmatch(struct diff_options *diffopt)
 
 void diffcore_std(struct diff_options *options)
 {
-	if (options->quiet)
+	if (DIFF_OPT_TST(options, QUIET))
 		return;
 
-	if (options->skip_stat_unmatch && !options->find_copies_harder)
+	if (options->skip_stat_unmatch && !DIFF_OPT_TST(options, FIND_COPIES_HARDER))
 		diffcore_skip_stat_unmatch(options);
 	if (options->break_opt != -1)
 		diffcore_break(options->break_opt);
@@ -3113,7 +3107,10 @@ void diffcore_std(struct diff_options *options)
 	diff_resolve_rename_copy();
 	diffcore_apply_filter(options->filter);
 
-	options->has_changes = !!diff_queued_diff.nr;
+	if (diff_queued_diff.nr)
+		DIFF_OPT_SET(options, HAS_CHANGES);
+	else
+		DIFF_OPT_CLR(options, HAS_CHANGES);
 }
 
 
@@ -3137,7 +3134,7 @@ void diff_addremove(struct diff_options *options,
 	 * Before the final output happens, they are pruned after
 	 * merged into rename/copy pairs as appropriate.
 	 */
-	if (options->reverse_diff)
+	if (DIFF_OPT_TST(options, REVERSE_DIFF))
 		addremove = (addremove == '+' ? '-' :
 			     addremove == '-' ? '+' : addremove);
 
@@ -3152,7 +3149,7 @@ void diff_addremove(struct diff_options *options,
 		fill_filespec(two, sha1, mode);
 
 	diff_queue(&diff_queued_diff, one, two);
-	options->has_changes = 1;
+	DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
 void diff_change(struct diff_options *options,
@@ -3164,7 +3161,7 @@ void diff_change(struct diff_options *options,
 	char concatpath[PATH_MAX];
 	struct diff_filespec *one, *two;
 
-	if (options->reverse_diff) {
+	if (DIFF_OPT_TST(options, REVERSE_DIFF)) {
 		unsigned tmp;
 		const unsigned char *tmp_c;
 		tmp = old_mode; old_mode = new_mode; new_mode = tmp;
@@ -3178,7 +3175,7 @@ void diff_change(struct diff_options *options,
 	fill_filespec(two, new_sha1, new_mode);
 
 	diff_queue(&diff_queued_diff, one, two);
-	options->has_changes = 1;
+	DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
 void diff_unmerge(struct diff_options *options,
diff --git a/diff.h b/diff.h
index 4546aad..6ff2b0e 100644
--- a/diff.h
+++ b/diff.h
@@ -43,26 +43,32 @@ typedef void (*diff_format_fn_t)(struct diff_queue_struct *q,
 
 #define DIFF_FORMAT_CALLBACK	0x1000
 
+#define DIFF_OPT_RECURSIVE           (1 <<  0)
+#define DIFF_OPT_TREE_IN_RECURSIVE   (1 <<  1)
+#define DIFF_OPT_BINARY              (1 <<  2)
+#define DIFF_OPT_TEXT                (1 <<  3)
+#define DIFF_OPT_FULL_INDEX          (1 <<  4)
+#define DIFF_OPT_SILENT_ON_REMOVE    (1 <<  5)
+#define DIFF_OPT_FIND_COPIES_HARDER  (1 <<  6)
+#define DIFF_OPT_FOLLOW_RENAMES      (1 <<  7)
+#define DIFF_OPT_COLOR_DIFF          (1 <<  8)
+#define DIFF_OPT_COLOR_DIFF_WORDS    (1 <<  9)
+#define DIFF_OPT_HAS_CHANGES         (1 << 10)
+#define DIFF_OPT_QUIET               (1 << 11)
+#define DIFF_OPT_NO_INDEX            (1 << 12)
+#define DIFF_OPT_ALLOW_EXTERNAL      (1 << 13)
+#define DIFF_OPT_EXIT_WITH_STATUS    (1 << 14)
+#define DIFF_OPT_REVERSE_DIFF        (1 << 15)
+#define DIFF_OPT_TST(opts, flag)    ((opts)->flags & DIFF_OPT_##flag)
+#define DIFF_OPT_SET(opts, flag)    ((opts)->flags |= DIFF_OPT_##flag)
+#define DIFF_OPT_CLR(opts, flag)    ((opts)->flags &= ~DIFF_OPT_##flag)
+
 struct diff_options {
 	const char *filter;
 	const char *orderfile;
 	const char *pickaxe;
 	const char *single_follow;
-	unsigned recursive:1,
-		 tree_in_recursive:1,
-		 binary:1,
-		 text:1,
-		 full_index:1,
-		 silent_on_remove:1,
-		 find_copies_harder:1,
-		 follow_renames:1,
-		 color_diff:1,
-		 color_diff_words:1,
-		 has_changes:1,
-		 quiet:1,
-		 no_index:1,
-		 allow_external:1,
-		 exit_with_status:1;
+	unsigned flags;
 	int context;
 	int break_opt;
 	int detect_rename;
@@ -71,7 +77,6 @@ struct diff_options {
 	int output_format;
 	int pickaxe_opts;
 	int rename_score;
-	int reverse_diff;
 	int rename_limit;
 	int setup;
 	int abbrev;
@@ -105,6 +110,9 @@ enum color_diff {
 	DIFF_WHITESPACE = 7,
 };
 const char *diff_get_color(int diff_use_color, enum color_diff ix);
+#define diff_get_color_opt(o, ix) \
+	diff_get_color(DIFF_OPT_TST((o), COLOR_DIFF), ix)
+
 
 extern const char mime_boundary_leader[];
 
diff --git a/log-tree.c b/log-tree.c
index a34beb0..1f3fcf1 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -245,8 +245,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			opt->diffopt.stat_sep = buffer;
 		}
 	} else if (opt->commit_format != CMIT_FMT_USERFORMAT) {
-		fputs(diff_get_color(opt->diffopt.color_diff, DIFF_COMMIT),
-		      stdout);
+		fputs(diff_get_color_opt(&opt->diffopt, DIFF_COMMIT), stdout);
 		if (opt->commit_format != CMIT_FMT_ONELINE)
 			fputs("commit ", stdout);
 		if (commit->object.flags & BOUNDARY)
@@ -266,8 +265,7 @@ void show_log(struct rev_info *opt, const char *sep)
 			       diff_unique_abbrev(parent->object.sha1,
 						  abbrev_commit));
 		show_decorations(commit);
-		printf("%s",
-		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
+		printf("%s", diff_get_color_opt(&opt->diffopt, DIFF_RESET));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
 		if (opt->reflog_info) {
 			show_reflog_message(opt->reflog_info,
diff --git a/merge-recursive.c b/merge-recursive.c
index 6c6f595..9a1e2f2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -366,7 +366,7 @@ static struct path_list *get_renames(struct tree *tree,
 
 	renames = xcalloc(1, sizeof(struct path_list));
 	diff_setup(&opts);
-	opts.recursive = 1;
+	DIFF_OPT_SET(&opts, RECURSIVE);
 	opts.detect_rename = DIFF_DETECT_RENAME;
 	opts.rename_limit = rename_limit;
 	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
diff --git a/patch-ids.c b/patch-ids.c
index a288fac..3be5d31 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -121,7 +121,7 @@ int init_patch_ids(struct patch_ids *ids)
 {
 	memset(ids, 0, sizeof(*ids));
 	diff_setup(&ids->diffopts);
-	ids->diffopts.recursive = 1;
+	DIFF_OPT_SET(&ids->diffopts, RECURSIVE);
 	if (diff_setup_done(&ids->diffopts) < 0)
 		return error("diff_setup_done failed");
 	return 0;
diff --git a/revision.c b/revision.c
index 931f978..040214f 100644
--- a/revision.c
+++ b/revision.c
@@ -252,7 +252,7 @@ static void file_add_remove(struct diff_options *options,
 	}
 	tree_difference = diff;
 	if (tree_difference == REV_TREE_DIFFERENT)
-		options->has_changes = 1;
+		DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
 static void file_change(struct diff_options *options,
@@ -262,7 +262,7 @@ static void file_change(struct diff_options *options,
 		 const char *base, const char *path)
 {
 	tree_difference = REV_TREE_DIFFERENT;
-	options->has_changes = 1;
+	DIFF_OPT_SET(options, HAS_CHANGES);
 }
 
 static int rev_compare_tree(struct rev_info *revs, struct tree *t1, struct tree *t2)
@@ -272,7 +272,7 @@ static int rev_compare_tree(struct rev_info *revs, struct tree *t1, struct tree
 	if (!t2)
 		return REV_TREE_DIFFERENT;
 	tree_difference = REV_TREE_SAME;
-	revs->pruning.has_changes = 0;
+	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
 	if (diff_tree_sha1(t1->object.sha1, t2->object.sha1, "",
 			   &revs->pruning) < 0)
 		return REV_TREE_DIFFERENT;
@@ -296,7 +296,7 @@ static int rev_same_tree_as_empty(struct rev_info *revs, struct tree *t1)
 	init_tree_desc(&empty, "", 0);
 
 	tree_difference = REV_TREE_SAME;
-	revs->pruning.has_changes = 0;
+	DIFF_OPT_CLR(&revs->pruning, HAS_CHANGES);
 	retval = diff_tree(&empty, &real, "", &revs->pruning);
 	free(tree);
 
@@ -688,8 +688,8 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->abbrev = DEFAULT_ABBREV;
 	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
-	revs->pruning.recursive = 1;
-	revs->pruning.quiet = 1;
+	DIFF_OPT_SET(&revs->pruning, RECURSIVE);
+	DIFF_OPT_SET(&revs->pruning, QUIET);
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
 	revs->lifo = 1;
@@ -1086,13 +1086,13 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 			}
 			if (!strcmp(arg, "-r")) {
 				revs->diff = 1;
-				revs->diffopt.recursive = 1;
+				DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
 				continue;
 			}
 			if (!strcmp(arg, "-t")) {
 				revs->diff = 1;
-				revs->diffopt.recursive = 1;
-				revs->diffopt.tree_in_recursive = 1;
+				DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
+				DIFF_OPT_SET(&revs->diffopt, TREE_IN_RECURSIVE);
 				continue;
 			}
 			if (!strcmp(arg, "-m")) {
@@ -1274,7 +1274,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		revs->diff = 1;
 
 	/* Pickaxe and rename following needs diffs */
-	if (revs->diffopt.pickaxe || revs->diffopt.follow_renames)
+	if (revs->diffopt.pickaxe || DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 		revs->diff = 1;
 
 	if (revs->topo_order)
@@ -1283,7 +1283,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 	if (revs->prune_data) {
 		diff_tree_setup_paths(revs->prune_data, &revs->pruning);
 		/* Can't prune commits with rename following: the paths change.. */
-		if (!revs->diffopt.follow_renames)
+		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
 			revs->prune = 1;
 		if (!revs->full_diff)
 			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
diff --git a/tree-diff.c b/tree-diff.c
index 7c261fd..aa0a100 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -39,7 +39,7 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 		show_entry(opt, "+", t2, base, baselen);
 		return 1;
 	}
-	if (!opt->find_copies_harder && !hashcmp(sha1, sha2) && mode1 == mode2)
+	if (!DIFF_OPT_TST(opt, FIND_COPIES_HARDER) && !hashcmp(sha1, sha2) && mode1 == mode2)
 		return 0;
 
 	/*
@@ -52,10 +52,10 @@ static int compare_tree_entry(struct tree_desc *t1, struct tree_desc *t2, const
 		return 0;
 	}
 
-	if (opt->recursive && S_ISDIR(mode1)) {
+	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode1)) {
 		int retval;
 		char *newbase = malloc_base(base, baselen, path1, pathlen1);
-		if (opt->tree_in_recursive)
+		if (DIFF_OPT_TST(opt, TREE_IN_RECURSIVE))
 			opt->change(opt, mode1, mode2,
 				    sha1, sha2, base, path1);
 		retval = diff_tree_sha1(sha1, sha2, newbase, opt);
@@ -206,7 +206,7 @@ static void show_entry(struct diff_options *opt, const char *prefix, struct tree
 	const char *path;
 	const unsigned char *sha1 = tree_entry_extract(desc, &path, &mode);
 
-	if (opt->recursive && S_ISDIR(mode)) {
+	if (DIFF_OPT_TST(opt, RECURSIVE) && S_ISDIR(mode)) {
 		enum object_type type;
 		int pathlen = tree_entry_len(path, sha1);
 		char *newbase = malloc_base(base, baselen, path, pathlen);
@@ -257,7 +257,7 @@ int diff_tree(struct tree_desc *t1, struct tree_desc *t2, const char *base, stru
 	int baselen = strlen(base);
 
 	for (;;) {
-		if (opt->quiet && opt->has_changes)
+		if (DIFF_OPT_TST(opt, QUIET) && DIFF_OPT_TST(opt, HAS_CHANGES))
 			break;
 		if (opt->nr_paths) {
 			skip_uninteresting(t1, base, baselen, opt);
@@ -315,7 +315,7 @@ static void try_to_follow_renames(struct tree_desc *t1, struct tree_desc *t2, co
 	q->nr = 0;
 
 	diff_setup(&diff_opts);
-	diff_opts.recursive = 1;
+	DIFF_OPT_SET(&diff_opts, RECURSIVE);
 	diff_opts.detect_rename = DIFF_DETECT_RENAME;
 	diff_opts.output_format = DIFF_FORMAT_NO_OUTPUT;
 	diff_opts.single_follow = opt->paths[0];
@@ -380,7 +380,7 @@ int diff_tree_sha1(const unsigned char *old, const unsigned char *new, const cha
 	init_tree_desc(&t1, tree1, size1);
 	init_tree_desc(&t2, tree2, size2);
 	retval = diff_tree(&t1, &t2, base, opt);
-	if (opt->follow_renames && diff_might_be_rename()) {
+	if (DIFF_OPT_TST(opt, FOLLOW_RENAMES) && diff_might_be_rename()) {
 		init_tree_desc(&t1, tree1, size1);
 		init_tree_desc(&t2, tree2, size2);
 		try_to_follow_renames(&t1, &t2, base, opt);
-- 
1.5.3.5.1598.gdef4e
