From: Pierre Habouzit <madcoder@debian.org>
Subject: [RESEND SMALL FIX] revisions: move traversal bit-fields to masks.
Date: Wed, 28 May 2008 19:16:25 +0200
Message-ID: <1211994985-25317-1-git-send-email-madcoder@debian.org>
References: <1211966245-18393-2-git-send-email-madcoder@debian.org>
Cc: gitster@pobox.com, Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 28 19:17:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K1PHJ-0002Kg-8x
	for gcvg-git-2@gmane.org; Wed, 28 May 2008 19:17:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753040AbYE1RQk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 May 2008 13:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752879AbYE1RQk
	(ORCPT <rfc822;git-outgoing>); Wed, 28 May 2008 13:16:40 -0400
Received: from pan.madism.org ([88.191.52.104]:45198 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752278AbYE1RQh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 May 2008 13:16:37 -0400
Received: from madism.org (APuteaux-155-1-52-172.w86-217.abo.wanadoo.fr [86.217.43.172])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 4821A39A3D;
	Wed, 28 May 2008 19:16:26 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 4B3FBF26; Wed, 28 May 2008 19:16:25 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.145.gbc48c
In-Reply-To: <1211966245-18393-2-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83114>

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

  For some reason my previous patch was borked, probably because of a sloppy rebase :/
  Please consider that one instead.

 builtin-commit.c        |    8 +-
 builtin-diff-files.c    |    6 +-
 builtin-diff-tree.c     |    2 +-
 builtin-diff.c          |   14 ++-
 builtin-fmt-merge-msg.c |    6 +-
 builtin-log.c           |   64 ++++++++-------
 builtin-rev-list.c      |   25 +++---
 combine-diff.c          |    8 +-
 diff-lib.c              |   10 +-
 graph.c                 |   10 ++-
 list-objects.c          |    6 +-
 log-tree.c              |   42 +++++-----
 pretty.c                |    6 +-
 reachable.c             |    6 +-
 revision.c              |  202 +++++++++++++++++++++++-----------------------
 revision.h              |   95 +++++++++++++----------
 upload-pack.c           |    8 +-
 17 files changed, 272 insertions(+), 246 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 59b3dc2..4fc7eaa 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -837,14 +837,14 @@ static void print_summary(const char *prefix, const unsigned char *sha1)
 	setup_revisions(&rev, NULL);
 
 	rev.abbrev = 0;
-	rev.diff = 1;
+	REV_DIFF_SET(&rev, DIFF);
+	REV_DIFF_SET(&rev, VERBOSE_HEADER);
+	REV_DIFF_SET(&rev, SHOW_ROOT_DIFF);
 	rev.diffopt.output_format =
 		DIFF_FORMAT_SHORTSTAT | DIFF_FORMAT_SUMMARY;
 
-	rev.verbose_header = 1;
-	rev.show_root_diff = 1;
 	get_commit_format("format:%h: %s", &rev);
-	rev.always_show_header = 0;
+	REV_DIFF_CLR(&rev, ALWAYS_SHOW_HEADER);
 	rev.diffopt.detect_rename = 1;
 	rev.diffopt.rename_limit = 100;
 	rev.diffopt.break_opt = 0;
diff --git a/builtin-diff-files.c b/builtin-diff-files.c
index e7e202a..cb7a318 100644
--- a/builtin-diff-files.c
+++ b/builtin-diff-files.c
@@ -52,8 +52,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 		usage(diff_files_usage);
 
 	if (rev.max_count == -1 &&
-	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
-		rev.combine_merges = rev.dense_combined_merges = 1;
+	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH)) {
+		REV_DIFF_SET(&rev, COMBINE_MERGES);
+		REV_DIFF_SET(&rev, DENSE_COMBINED_MERGES);
+	}
 
 	if (read_cache() < 0) {
 		perror("read_cache");
diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 0900175..9a34a36 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -71,7 +71,7 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
 	nr_sha1 = 0;
 	opt->abbrev = 0;
-	opt->diff = 1;
+	REV_DIFF_SET(opt, DIFF);
 	argc = parse_revisions(argc, argv, opt);
 	setup_revisions(opt, NULL);
 
diff --git a/builtin-diff.c b/builtin-diff.c
index a92dbd4..acf50aa 100644
--- a/builtin-diff.c
+++ b/builtin-diff.c
@@ -170,15 +170,17 @@ static int builtin_diff_combined(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	if (!revs->dense_combined_merges && !revs->combine_merges)
-		revs->dense_combined_merges = revs->combine_merges = 1;
+	if (!REV_DIFF_TST(revs, DENSE_COMBINED_MERGES) && !REV_DIFF_TST(revs, COMBINE_MERGES)) {
+		REV_DIFF_SET(revs, DENSE_COMBINED_MERGES);
+		REV_DIFF_SET(revs, COMBINE_MERGES);
+	}
 	parent = xmalloc(ents * sizeof(*parent));
 	/* Again, the revs are all reverse */
 	for (i = 0; i < ents; i++)
 		hashcpy((unsigned char *)(parent + i),
 			ent[ents - 1 - i].item->sha1);
 	diff_tree_combined(parent[0], parent + 1, ents - 1,
-			   revs->dense_combined_merges, revs);
+			   REV_DIFF_TST(revs, DENSE_COMBINED_MERGES), revs);
 	return 0;
 }
 
@@ -222,8 +224,10 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	}
 
 	if (revs->max_count == -1 &&
-	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
-		revs->combine_merges = revs->dense_combined_merges = 1;
+	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH)) {
+		REV_DIFF_SET(revs, COMBINE_MERGES);
+		REV_DIFF_SET(revs, DENSE_COMBINED_MERGES);
+	}
 
 	if (read_cache() < 0) {
 		perror("read_cache");
diff --git a/builtin-fmt-merge-msg.c b/builtin-fmt-merge-msg.c
index dad81b8..29a1cfe 100644
--- a/builtin-fmt-merge-msg.c
+++ b/builtin-fmt-merge-msg.c
@@ -188,7 +188,7 @@ static void shortlog(const char *name, unsigned char *sha1,
 		return;
 
 	setup_revisions(rev, NULL);
-	rev->ignore_merges = 1;
+	REV_DIFF_SET(rev, IGNORE_MERGES);
 	add_pending_object(rev, branch, name);
 	add_pending_object(rev, &head->object, "^HEAD");
 	head->object.flags |= UNINTERESTING;
@@ -355,8 +355,8 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix)
 		head = lookup_commit(head_sha1);
 		init_revisions(&rev, prefix);
 		rev.commit_format = CMIT_FMT_ONELINE;
-		rev.ignore_merges = 1;
-		rev.limited = 1;
+		REV_DIFF_SET(&rev, IGNORE_MERGES);
+		REV_TRAV_SET(&rev, LIMITED);
 
 		for (i = 0; i < origins.nr; i++)
 			shortlog(origins.list[i], origins.payload[i],
diff --git a/builtin-log.c b/builtin-log.c
index dde7192..be8f5b9 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -60,9 +60,13 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	rev->commit_format = CMIT_FMT_DEFAULT;
 	if (fmt_pretty)
 		get_commit_format(fmt_pretty, rev);
-	rev->verbose_header = 1;
 	DIFF_OPT_SET(&rev->diffopt, RECURSIVE);
-	rev->show_root_diff = default_show_root;
+	REV_DIFF_SET(rev, VERBOSE_HEADER);
+	if (default_show_root) {
+		REV_DIFF_SET(rev, SHOW_ROOT_DIFF);
+	} else {
+		REV_DIFF_CLR(rev, SHOW_ROOT_DIFF);
+	}
 	rev->subject_prefix = fmt_patch_subject_prefix;
 
 	if (default_date_mode)
@@ -71,9 +75,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 	argc = parse_revisions(argc, argv, rev);
 	setup_revisions(rev, "HEAD");
 	if (rev->diffopt.pickaxe || rev->diffopt.filter)
-		rev->always_show_header = 0;
+		REV_DIFF_CLR(rev, ALWAYS_SHOW_HEADER);
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
-		rev->always_show_header = 0;
+		REV_DIFF_CLR(rev, ALWAYS_SHOW_HEADER);
 		if (rev->diffopt.nr_paths != 1)
 			usage("git logs can only follow renames on one pathname at a time");
 	}
@@ -108,8 +112,8 @@ static int estimate_commit_count(struct rev_info *rev, struct commit_list *list)
 
 static void show_early_header(struct rev_info *rev, const char *stage, int nr)
 {
-	if (rev->shown_one) {
-		rev->shown_one = 0;
+	if (REV_FMT_TST(rev, SHOWN_ONE)) {
+		REV_FMT_CLR(rev, SHOWN_ONE);
 		if (rev->commit_format != CMIT_FMT_ONELINE)
 			putchar(rev->diffopt.line_termination);
 	}
@@ -123,7 +127,7 @@ static void log_show_early(struct rev_info *revs, struct commit_list *list)
 	int i = revs->early_output;
 	int show_header = 1;
 
-	sort_in_topological_order(&list, revs->lifo);
+	sort_in_topological_order(&list, REV_TRAV_TST(revs, LIFO));
 	while (list && i) {
 		struct commit *commit = list->item;
 		switch (simplify_commit(revs, commit)) {
@@ -259,8 +263,8 @@ int cmd_whatchanged(int argc, const char **argv, const char *prefix)
 		diff_use_color_default = git_use_color_default;
 
 	init_revisions(&rev, prefix);
-	rev.diff = 1;
-	rev.simplify_history = 0;
+	REV_DIFF_SET(&rev, DIFF);
+	REV_TRAV_CLR(&rev, SIMPLIFY_HISTORY);
 	cmd_log_init(argc, argv, prefix, &rev);
 	if (!rev.diffopt.output_format)
 		rev.diffopt.output_format = DIFF_FORMAT_RAW;
@@ -335,12 +339,12 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		diff_use_color_default = git_use_color_default;
 
 	init_revisions(&rev, prefix);
-	rev.diff = 1;
-	rev.combine_merges = 1;
-	rev.dense_combined_merges = 1;
-	rev.always_show_header = 1;
-	rev.ignore_merges = 0;
-	rev.no_walk = 1;
+	REV_DIFF_SET(&rev, DIFF);
+	REV_DIFF_SET(&rev, COMBINE_MERGES);
+	REV_DIFF_SET(&rev, DENSE_COMBINED_MERGES);
+	REV_DIFF_SET(&rev, ALWAYS_SHOW_HEADER);
+	REV_DIFF_CLR(&rev, IGNORE_MERGES);
+	REV_TRAV_SET(&rev, NO_WALK);
 	cmd_log_init(argc, argv, prefix, &rev);
 
 	count = rev.pending.nr;
@@ -400,8 +404,8 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&rev, prefix);
 	init_reflog_walk(&rev.reflog_info);
-	rev.abbrev_commit = 1;
-	rev.verbose_header = 1;
+	REV_FMT_SET(&rev, ABBREV_COMMIT);
+	REV_DIFF_SET(&rev, VERBOSE_HEADER);
 	cmd_log_init(argc, argv, prefix, &rev);
 
 	/*
@@ -410,8 +414,8 @@ int cmd_log_reflog(int argc, const char **argv, const char *prefix)
 	 * allow us to set a different default.
 	 */
 	rev.commit_format = CMIT_FMT_ONELINE;
-	rev.use_terminator = 1;
-	rev.always_show_header = 1;
+	REV_FMT_SET(&rev, USE_TERMINATOR);
+	REV_DIFF_SET(&rev, ALWAYS_SHOW_HEADER);
 
 	/*
 	 * We get called through "git reflog", so unlike the other log
@@ -432,7 +436,7 @@ int cmd_log(int argc, const char **argv, const char *prefix)
 		diff_use_color_default = git_use_color_default;
 
 	init_revisions(&rev, prefix);
-	rev.always_show_header = 1;
+	REV_DIFF_SET(&rev, ALWAYS_SHOW_HEADER);
 	cmd_log_init(argc, argv, prefix, &rev);
 	return cmd_log_walk(&rev);
 }
@@ -784,10 +788,10 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
-	rev.verbose_header = 1;
-	rev.diff = 1;
-	rev.combine_merges = 0;
-	rev.ignore_merges = 1;
+	REV_DIFF_SET(&rev, VERBOSE_HEADER);
+	REV_DIFF_SET(&rev, DIFF);
+	REV_DIFF_CLR(&rev, COMBINE_MERGES);
+	REV_DIFF_SET(&rev, IGNORE_MERGES);
 	DIFF_OPT_SET(&rev.diffopt, RECURSIVE);
 
 	rev.subject_prefix = fmt_patch_subject_prefix;
@@ -950,7 +954,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	if (rev.pending.nr == 1) {
-		if (rev.max_count < 0 && !rev.show_root_diff) {
+		if (rev.max_count < 0 && !REV_DIFF_TST(&rev, SHOW_ROOT_DIFF)) {
 			/*
 			 * This is traditional behaviour of "git format-patch
 			 * origin" that prepares what the origin side still
@@ -986,7 +990,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (prepare_revision_walk(&rev))
 		die("revision walk setup failed");
-	rev.boundary = 1;
+	REV_TRAV_SET(&rev, BOUNDARY);
 	while ((commit = get_revision(&rev)) != NULL) {
 		if (commit->object.flags & BOUNDARY) {
 			boundary_count++;
@@ -1058,7 +1062,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		 * not want the extra blank line.
 		 */
 		if (!use_stdout)
-			rev.shown_one = 0;
+			REV_FMT_CLR(&rev, SHOWN_ONE);
 		if (shown) {
 			if (rev.mime_boundary)
 				printf("\n--%s%s--\n\n\n",
@@ -1124,9 +1128,9 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	}
 
 	init_revisions(&revs, prefix);
-	revs.diff = 1;
-	revs.combine_merges = 0;
-	revs.ignore_merges = 1;
+	REV_DIFF_SET(&revs, DIFF);
+	REV_DIFF_CLR(&revs, COMBINE_MERGES);
+	REV_DIFF_SET(&revs, IGNORE_MERGES);
 	DIFF_OPT_SET(&revs.diffopt, RECURSIVE);
 
 	if (add_pending_commit(head, &revs, 0))
diff --git a/builtin-rev-list.c b/builtin-rev-list.c
index ed60227..db61872 100644
--- a/builtin-rev-list.c
+++ b/builtin-rev-list.c
@@ -72,19 +72,19 @@ static void show_commit(struct commit *commit)
 			putchar('-');
 		else if (commit->object.flags & UNINTERESTING)
 			putchar('^');
-		else if (revs.left_right) {
+		else if (REV_TRAV_TST(&revs, LEFT_RIGHT)) {
 			if (commit->object.flags & SYMMETRIC_LEFT)
 				putchar('<');
 			else
 				putchar('>');
 		}
 	}
-	if (revs.abbrev_commit && revs.abbrev)
+	if (REV_FMT_TST(&revs, ABBREV_COMMIT) && revs.abbrev)
 		fputs(find_unique_abbrev(commit->object.sha1, revs.abbrev),
 		      stdout);
 	else
 		fputs(sha1_to_hex(commit->object.sha1), stdout);
-	if (revs.print_parents) {
+	if (REV_TRAV_TST(&revs, PRINT_PARENTS)) {
 		struct commit_list *parents = commit->parents;
 		while (parents) {
 			printf(" %s", sha1_to_hex(parents->item->object.sha1));
@@ -106,7 +106,7 @@ static void show_commit(struct commit *commit)
 	else
 		putchar('\n');
 
-	if (revs.verbose_header && commit->buffer) {
+	if (REV_DIFF_TST(&revs, VERBOSE_HEADER) && commit->buffer) {
 		struct strbuf buf;
 		strbuf_init(&buf, 0);
 		pretty_print_commit(revs.commit_format, commit,
@@ -612,7 +612,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		const char *arg = argv[i];
 
 		if (!strcmp(arg, "--header")) {
-			revs.verbose_header = 1;
+			REV_DIFF_SET(&revs, VERBOSE_HEADER);
 			continue;
 		}
 		if (!strcmp(arg, "--timestamp")) {
@@ -654,25 +654,26 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
 		else
 			header_prefix = "commit ";
 	}
-	else if (revs.verbose_header)
+	else if (REV_DIFF_TST(&revs, VERBOSE_HEADER))
 		/* Only --header was specified */
 		revs.commit_format = CMIT_FMT_RAW;
 
 	list = revs.commits;
 
 	if ((!list &&
-	     (!(revs.tag_objects||revs.tree_objects||revs.blob_objects) &&
-	      !revs.pending.nr)) ||
-	    revs.diff)
+		 (!(REV_TRAV_TST(&revs, TAG_OBJECTS) ||
+			REV_TRAV_TST(&revs, TREE_OBJECTS) ||
+			REV_TRAV_TST(&revs, BLOB_OBJECTS)) &&
+	      !revs.pending.nr)) || REV_DIFF_TST(&revs, DIFF))
 		usage(rev_list_usage);
 
-	save_commit_buffer = revs.verbose_header || revs.grep_filter;
+	save_commit_buffer = REV_DIFF_TST(&revs, VERBOSE_HEADER) || revs.grep_filter;
 	if (bisect_list)
-		revs.limited = 1;
+		REV_TRAV_SET(&revs, LIMITED);
 
 	if (prepare_revision_walk(&revs))
 		die("revision walk setup failed");
-	if (revs.tree_objects)
+	if (REV_TRAV_TST(&revs, TREE_OBJECTS))
 		mark_edges_uninteresting(revs.commits, &revs, show_edge);
 
 	if (bisect_list) {
diff --git a/combine-diff.c b/combine-diff.c
index 588c58b..9b32bcf 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -796,7 +796,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 		int added = 0;
 		int deleted = 0;
 
-		if (rev->loginfo && !rev->no_commit_id)
+		if (rev->loginfo && !REV_DIFF_TST(rev, NO_COMMIT_ID))
 			show_log(rev);
 		dump_quoted_path(dense ? "diff --cc " : "diff --combined ",
 				 "", elem->path, c_meta, c_reset);
@@ -879,7 +879,7 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
 	if (!line_termination)
 		inter_name_termination = 0;
 
-	if (rev->loginfo && !rev->no_commit_id)
+	if (rev->loginfo && !REV_DIFF_TST(rev, NO_COMMIT_ID))
 		show_log(rev);
 
 	if (opt->output_format & DIFF_FORMAT_RAW) {
@@ -943,7 +943,7 @@ void diff_tree_combined(const unsigned char *sha1,
 	DIFF_OPT_SET(&diffopts, RECURSIVE);
 	DIFF_OPT_CLR(&diffopts, ALLOW_EXTERNAL);
 
-	show_log_first = !!rev->loginfo && !rev->no_commit_id;
+	show_log_first = !!rev->loginfo && !REV_DIFF_TST(rev, NO_COMMIT_ID);
 	needsep = 0;
 	/* find set of paths that everybody touches */
 	for (i = 0; i < num_parent; i++) {
@@ -962,7 +962,7 @@ void diff_tree_combined(const unsigned char *sha1,
 
 		if (show_log_first && i == 0) {
 			show_log(rev);
-			if (rev->verbose_header && opt->output_format)
+			if (REV_DIFF_TST(rev, VERBOSE_HEADER) && opt->output_format)
 				putchar(opt->line_termination);
 		}
 		diff_flush(&diffopts);
diff --git a/diff-lib.c b/diff-lib.c
index b17722d..777b98f 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -140,9 +140,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			 */
 			i--;
 
-			if (revs->combine_merges && num_compare_stages == 2) {
+			if (REV_DIFF_TST(revs, COMBINE_MERGES) && num_compare_stages == 2) {
 				show_combined_diff(dpath, 2,
-						   revs->dense_combined_merges,
+						   REV_DIFF_TST(revs, DENSE_COMBINED_MERGES),
 						   revs);
 				free(dpath);
 				continue;
@@ -281,7 +281,7 @@ static int show_modified(struct oneway_unpack_data *cbdata,
 		return -1;
 	}
 
-	if (revs->combine_merges && !cached &&
+	if (REV_DIFF_TST(revs, COMBINE_MERGES) && !cached &&
 	    (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
 		struct combine_diff_path *p;
 		int pathlen = ce_namelen(new);
@@ -301,7 +301,7 @@ static int show_modified(struct oneway_unpack_data *cbdata,
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old->ce_mode;
 		hashcpy(p->parent[1].sha1, old->sha1);
-		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
+		show_combined_diff(p, 2, REV_DIFF_TST(revs, DENSE_COMBINED_MERGES), revs);
 		free(p);
 		return 0;
 	}
@@ -354,7 +354,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * "!revs->ignore_merges".
 	 */
 	cached = o->index_only;
-	match_missing = !revs->ignore_merges;
+	match_missing = !REV_DIFF_TST(revs, IGNORE_MERGES);
 
 	if (cached && idx && ce_stage(idx)) {
 		if (tree)
diff --git a/graph.c b/graph.c
index 26b8c52..1173440 100644
--- a/graph.c
+++ b/graph.c
@@ -196,7 +196,8 @@ static int graph_is_interesting(struct git_graph *graph, struct commit *commit)
 	 * been shown are always interesting, even if they have the
 	 * UNINTERESTING or TREESAME flags set.
 	 */
-	if (graph->revs && graph->revs->boundary) {
+	if (graph->revs && (REV_TRAV_TST(graph->revs, BOUNDARY)
+			|| REV_TRAV_TST(graph->revs, BOUNDARY_OUTPUT))) {
 		if (commit->object.flags & CHILD_SHOWN)
 			return 1;
 	}
@@ -557,10 +558,11 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 {
 	/*
 	 * For boundary commits, print 'o'
-	 * (We should only see boundary commits when revs->boundary is set.)
+	 * (We should only see boundary commits when BOUNDARY/BOUNDARY_OUTPUT is set.)
 	 */
 	if (graph->commit->object.flags & BOUNDARY) {
-		assert(graph->revs->boundary);
+		assert (REV_TRAV_TST(graph->revs, BOUNDARY)
+				|| REV_TRAV_TST(graph->revs, BOUNDARY_OUTPUT));
 		strbuf_addch(sb, 'o');
 		return;
 	}
@@ -570,7 +572,7 @@ static void graph_output_commit_char(struct git_graph *graph, struct strbuf *sb)
 	 * come from the left side, and '>' for commits from the right
 	 * side.
 	 */
-	if (graph->revs && graph->revs->left_right) {
+	if (graph->revs && REV_TRAV_TST(graph->revs, LEFT_RIGHT)) {
 		if (graph->commit->object.flags & SYMMETRIC_LEFT)
 			strbuf_addch(sb, '<');
 		else
diff --git a/list-objects.c b/list-objects.c
index c8b8375..b15af12 100644
--- a/list-objects.c
+++ b/list-objects.c
@@ -16,7 +16,7 @@ static void process_blob(struct rev_info *revs,
 {
 	struct object *obj = &blob->object;
 
-	if (!revs->blob_objects)
+	if (!REV_TRAV_TST(revs, BLOB_OBJECTS))
 		return;
 	if (!obj)
 		die("bad blob object");
@@ -69,7 +69,7 @@ static void process_tree(struct rev_info *revs,
 	struct name_entry entry;
 	struct name_path me;
 
-	if (!revs->tree_objects)
+	if (!REV_TRAV_TST(revs, TREE_OBJECTS))
 		return;
 	if (!obj)
 		die("bad tree object");
@@ -114,7 +114,7 @@ static void mark_edge_parents_uninteresting(struct commit *commit,
 		if (!(parent->object.flags & UNINTERESTING))
 			continue;
 		mark_tree_uninteresting(parent->tree);
-		if (revs->edge_hint && !(parent->object.flags & SHOWN)) {
+		if (REV_TRAV_TST(revs, EDGE_HINT) && !(parent->object.flags & SHOWN)) {
 			parent->object.flags |= SHOWN;
 			show_edge(parent);
 		}
diff --git a/log-tree.c b/log-tree.c
index 5505606..e2ee3ec 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -220,12 +220,12 @@ void show_log(struct rev_info *opt)
 	struct log_info *log = opt->loginfo;
 	struct commit *commit = log->commit, *parent = log->parent;
 	int abbrev = opt->diffopt.abbrev;
-	int abbrev_commit = opt->abbrev_commit ? opt->abbrev : 40;
+	int abbrev_commit = REV_FMT_TST(opt, ABBREV_COMMIT) ? opt->abbrev : 40;
 	const char *subject = NULL, *extra_headers = opt->extra_headers;
 	int need_8bit_cte = 0;
 
 	opt->loginfo = NULL;
-	if (!opt->verbose_header) {
+	if (!REV_DIFF_TST(opt, VERBOSE_HEADER)) {
 		graph_show_commit(opt->graph);
 
 		if (!opt->graph) {
@@ -233,7 +233,7 @@ void show_log(struct rev_info *opt)
 				putchar('-');
 			else if (commit->object.flags & UNINTERESTING)
 				putchar('^');
-			else if (opt->left_right) {
+			else if (REV_TRAV_TST(opt, LEFT_RIGHT)) {
 				if (commit->object.flags & SYMMETRIC_LEFT)
 					putchar('<');
 				else
@@ -241,7 +241,7 @@ void show_log(struct rev_info *opt)
 			}
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit), stdout);
-		if (opt->print_parents)
+		if (REV_TRAV_TST(opt, PRINT_PARENTS))
 			show_parents(commit, abbrev_commit);
 		show_decorations(commit);
 		if (opt->graph && !graph_is_commit_finished(opt->graph)) {
@@ -257,7 +257,7 @@ void show_log(struct rev_info *opt)
 	 * Otherwise, add a diffopt.line_termination character before all
 	 * entries but the first.  (IOW, as a separator between entries)
 	 */
-	if (opt->shown_one && !opt->use_terminator) {
+	if (REV_FMT_TST(opt, SHOWN_ONE) && !REV_FMT_TST(opt, USE_TERMINATOR)) {
 		/*
 		 * If entries are separated by a newline, the output
 		 * should look human-readable.  If the last entry ended
@@ -271,11 +271,11 @@ void show_log(struct rev_info *opt)
 		 * separator.
 		 */
 		if (opt->diffopt.line_termination == '\n' &&
-		    !opt->missing_newline)
+			!REV_FMT_TST(opt, MISSING_NEWLINE))
 			graph_show_padding(opt->graph);
 		putchar(opt->diffopt.line_termination);
 	}
-	opt->shown_one = 1;
+	REV_FMT_SET(opt, SHOWN_ONE);
 
 	/*
 	 * If the history graph was requested,
@@ -301,7 +301,7 @@ void show_log(struct rev_info *opt)
 				putchar('-');
 			else if (commit->object.flags & UNINTERESTING)
 				putchar('^');
-			else if (opt->left_right) {
+			else if (REV_TRAV_TST(opt, LEFT_RIGHT)) {
 				if (commit->object.flags & SYMMETRIC_LEFT)
 					putchar('<');
 				else
@@ -310,7 +310,7 @@ void show_log(struct rev_info *opt)
 		}
 		fputs(diff_unique_abbrev(commit->object.sha1, abbrev_commit),
 		      stdout);
-		if (opt->print_parents)
+		if (REV_TRAV_TST(opt, PRINT_PARENTS))
 			show_parents(commit, abbrev_commit);
 		if (parent)
 			printf(" (from %s)",
@@ -364,16 +364,16 @@ void show_log(struct rev_info *opt)
 	 * end in a newline (including if it is empty)
 	 */
 	if (!msgbuf.len || msgbuf.buf[msgbuf.len - 1] != '\n')
-		opt->missing_newline = 1;
+		REV_FMT_SET(opt, MISSING_NEWLINE);
 	else
-		opt->missing_newline = 0;
+		REV_FMT_CLR(opt, MISSING_NEWLINE);
 
 	if (opt->graph)
 		graph_show_commit_msg(opt->graph, &msgbuf);
 	else
 		fwrite(msgbuf.buf, sizeof(char), msgbuf.len, stdout);
-	if (opt->use_terminator) {
-		if (!opt->missing_newline)
+	if (REV_FMT_TST(opt, USE_TERMINATOR)) {
+		if (!REV_FMT_TST(opt, MISSING_NEWLINE))
 			graph_show_padding(opt->graph);
 		putchar('\n');
 	}
@@ -393,7 +393,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 		return 0;
 	}
 
-	if (opt->loginfo && !opt->no_commit_id) {
+	if (opt->loginfo && !REV_DIFF_TST(opt, NO_COMMIT_ID)) {
 		/* When showing a verbose header (i.e. log message),
 		 * and not in --pretty=oneline format, we would want
 		 * an extra newline between the end of log and the
@@ -401,7 +401,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 		 */
 		show_log(opt);
 		if ((opt->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT) &&
-		    opt->verbose_header &&
+		    REV_DIFF_TST(opt, VERBOSE_HEADER) &&
 		    opt->commit_format != CMIT_FMT_ONELINE) {
 			int pch = DIFF_FORMAT_DIFFSTAT | DIFF_FORMAT_PATCH;
 			if ((pch & opt->diffopt.output_format) == pch)
@@ -417,7 +417,7 @@ static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 {
 	unsigned const char *sha1 = commit->object.sha1;
 
-	diff_tree_combined_merge(sha1, opt->dense_combined_merges, opt);
+	diff_tree_combined_merge(sha1, REV_DIFF_TST(opt, DENSE_COMBINED_MERGES), opt);
 	return !opt->loginfo;
 }
 
@@ -432,13 +432,13 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 	struct commit_list *parents;
 	unsigned const char *sha1 = commit->object.sha1;
 
-	if (!opt->diff)
+	if (!REV_DIFF_TST(opt, DIFF))
 		return 0;
 
 	/* Root commit? */
 	parents = commit->parents;
 	if (!parents) {
-		if (opt->show_root_diff) {
+		if (REV_DIFF_TST(opt, SHOW_ROOT_DIFF)) {
 			diff_root_tree_sha1(sha1, "", &opt->diffopt);
 			log_tree_diff_flush(opt);
 		}
@@ -447,9 +447,9 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 	/* More than one parent? */
 	if (parents && parents->next) {
-		if (opt->ignore_merges)
+		if (REV_DIFF_TST(opt, IGNORE_MERGES))
 			return 0;
-		else if (opt->combine_merges)
+		else if (REV_DIFF_TST(opt, COMBINE_MERGES))
 			return do_diff_combined(opt, commit);
 
 		/* If we show individual diffs, show the parent info */
@@ -485,7 +485,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	opt->loginfo = &log;
 
 	shown = log_tree_diff(opt, commit, &log);
-	if (!shown && opt->loginfo && opt->always_show_header) {
+	if (!shown && opt->loginfo && REV_DIFF_TST(opt, ALWAYS_SHOW_HEADER)) {
 		log.parent = NULL;
 		show_log(opt);
 		shown = 1;
diff --git a/pretty.c b/pretty.c
index 8eb39e9..38a9099 100644
--- a/pretty.c
+++ b/pretty.c
@@ -23,7 +23,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		{ "oneline",	1,	CMIT_FMT_ONELINE },
 	};
 
-	rev->use_terminator = 0;
+	REV_FMT_CLR(rev, USE_TERMINATOR);
 	if (!arg || !*arg) {
 		rev->commit_format = CMIT_FMT_DEFAULT;
 		return;
@@ -33,7 +33,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		free(user_format);
 		user_format = xstrdup(cp);
 		if (arg[0] == 't')
-			rev->use_terminator = 1;
+			REV_FMT_SET(rev, USE_TERMINATOR);
 		rev->commit_format = CMIT_FMT_USERFORMAT;
 		return;
 	}
@@ -41,7 +41,7 @@ void get_commit_format(const char *arg, struct rev_info *rev)
 		if (!strncmp(arg, cmt_fmts[i].n, cmt_fmts[i].cmp_len) &&
 		    !strncmp(arg, cmt_fmts[i].n, strlen(arg))) {
 			if (cmt_fmts[i].v == CMIT_FMT_ONELINE)
-				rev->use_terminator = 1;
+				REV_FMT_SET(rev, USE_TERMINATOR);
 			rev->commit_format = cmt_fmts[i].v;
 			return;
 		}
diff --git a/reachable.c b/reachable.c
index 3b1c18f..6ee77f9 100644
--- a/reachable.c
+++ b/reachable.c
@@ -203,9 +203,9 @@ void mark_reachable_objects(struct rev_info *revs, int mark_reflog)
 	 * Set up revision parsing, and mark us as being interested
 	 * in all object types, not just commits.
 	 */
-	revs->tag_objects = 1;
-	revs->blob_objects = 1;
-	revs->tree_objects = 1;
+	REV_TRAV_SET(revs, TAG_OBJECTS);
+	REV_TRAV_SET(revs, BLOB_OBJECTS);
+	REV_TRAV_SET(revs, TREE_OBJECTS);
 
 	/* Add all refs from the index file */
 	add_cache_refs(revs);
diff --git a/revision.c b/revision.c
index 4abe410..89036e7 100644
--- a/revision.c
+++ b/revision.c
@@ -131,7 +131,7 @@ void mark_parents_uninteresting(struct commit *commit)
 
 static void add_pending_object_with_mode(struct rev_info *revs, struct object *obj, const char *name, unsigned mode)
 {
-	if (revs->no_walk && (obj->flags & UNINTERESTING))
+	if (REV_TRAV_TST(revs, NO_WALK) && (obj->flags & UNINTERESTING))
 		die("object ranges do not make sense when not walking revisions");
 	if (revs->reflog_info && obj->type == OBJ_COMMIT &&
 			add_reflog_for_walk(revs->reflog_info,
@@ -177,7 +177,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 	 */
 	while (object->type == OBJ_TAG) {
 		struct tag *tag = (struct tag *) object;
-		if (revs->tag_objects && !(flags & UNINTERESTING))
+		if (REV_TRAV_TST(revs, TAG_OBJECTS) && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
 		if (!tag->tagged)
 			die("bad tag");
@@ -197,7 +197,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		if (flags & UNINTERESTING) {
 			commit->object.flags |= UNINTERESTING;
 			mark_parents_uninteresting(commit);
-			revs->limited = 1;
+			REV_TRAV_SET(revs, LIMITED);
 		}
 		return commit;
 	}
@@ -208,7 +208,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 	 */
 	if (object->type == OBJ_TREE) {
 		struct tree *tree = (struct tree *)object;
-		if (!revs->tree_objects)
+		if (!REV_TRAV_TST(revs, TREE_OBJECTS))
 			return NULL;
 		if (flags & UNINTERESTING) {
 			mark_tree_uninteresting(tree);
@@ -223,7 +223,7 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 	 */
 	if (object->type == OBJ_BLOB) {
 		struct blob *blob = (struct blob *)object;
-		if (!revs->blob_objects)
+		if (!REV_TRAV_TST(revs, BLOB_OBJECTS))
 			return NULL;
 		if (flags & UNINTERESTING) {
 			mark_blob_uninteresting(blob);
@@ -338,7 +338,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	/*
 	 * If we don't do pruning, everything is interesting
 	 */
-	if (!revs->prune)
+	if (!REV_TRAV_TST(revs, PRUNE))
 		return;
 
 	if (!commit->tree)
@@ -354,7 +354,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 	 * Normal non-merge commit? If we don't want to make the
 	 * history dense, we consider it always to be a change..
 	 */
-	if (!revs->dense && !commit->parents->next)
+	if (!REV_TRAV_TST(revs, DENSE) && !commit->parents->next)
 		return;
 
 	pp = &commit->parents;
@@ -368,7 +368,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 		switch (rev_compare_tree(revs, p->tree, commit->tree)) {
 		case REV_TREE_SAME:
 			tree_same = 1;
-			if (!revs->simplify_history || (p->object.flags & UNINTERESTING)) {
+			if (!REV_TRAV_TST(revs, SIMPLIFY_HISTORY) || (p->object.flags & UNINTERESTING)) {
 				/* Even if a merge with an uninteresting
 				 * side branch brought the entire change
 				 * we are interested in, we do not want
@@ -384,7 +384,7 @@ static void try_to_simplify_commit(struct rev_info *revs, struct commit *commit)
 			return;
 
 		case REV_TREE_NEW:
-			if (revs->remove_empty_trees &&
+			if (REV_TRAV_TST(revs, REMOVE_EMPTY_TREES) &&
 			    rev_same_tree_as_empty(revs, p->tree)) {
 				/* We are adding all the specified
 				 * paths from this parent, so the
@@ -458,7 +458,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 	 */
 	try_to_simplify_commit(revs, commit);
 
-	if (revs->no_walk)
+	if (REV_TRAV_TST(revs, NO_WALK))
 		return 0;
 
 	left_flag = (commit->object.flags & SYMMETRIC_LEFT);
@@ -473,7 +473,7 @@ static int add_parents_to_list(struct rev_info *revs, struct commit *commit, str
 			p->object.flags |= SEEN;
 			insert_by_date(p, list);
 		}
-		if(revs->first_parent_only)
+		if (REV_TRAV_TST(revs, FIRST_PARENT_ONLY))
 			break;
 	}
 	return 0;
@@ -616,13 +616,13 @@ static int limit_list(struct rev_info *revs)
 			return -1;
 		if (obj->flags & UNINTERESTING) {
 			mark_parents_uninteresting(commit);
-			if (revs->show_all)
+			if (REV_TRAV_TST(revs, SHOW_ALL))
 				p = &commit_list_insert(commit, p)->next;
 			slop = still_interesting(list, date, slop);
 			if (slop)
 				continue;
 			/* If showing all, add the whole pending list to the end */
-			if (revs->show_all)
+			if (REV_TRAV_TST(revs, SHOW_ALL))
 				*p = list;
 			break;
 		}
@@ -638,7 +638,7 @@ static int limit_list(struct rev_info *revs)
 		show(revs, newlist);
 		show_early_output = NULL;
 	}
-	if (revs->cherry_pick)
+	if (REV_TRAV_TST(revs, CHERRY_PICK))
 		cherry_pick_list(newlist, revs);
 
 	revs->commits = newlist;
@@ -750,14 +750,14 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	memset(revs, 0, sizeof(*revs));
 
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = 1;
-	revs->simplify_history = 1;
+	REV_DIFF_SET(revs, IGNORE_MERGES);
 	DIFF_OPT_SET(&revs->pruning, RECURSIVE);
 	DIFF_OPT_SET(&revs->pruning, QUIET);
 	revs->pruning.add_remove = file_add_remove;
 	revs->pruning.change = file_change;
-	revs->lifo = 1;
-	revs->dense = 1;
+	REV_TRAV_SET(revs, SIMPLIFY_HISTORY);
+	REV_TRAV_SET(revs, LIFO);
+	REV_TRAV_SET(revs, DENSE);
 	revs->prefix = prefix;
 	revs->max_age = -1;
 	revs->min_age = -1;
@@ -821,7 +821,7 @@ static void prepare_show_merge(struct rev_info *revs)
 			i++;
 	}
 	revs->prune_data = prune;
-	revs->limited = 1;
+	REV_TRAV_SET(revs, LIMITED);
 }
 
 int handle_revision_arg(const char *arg, struct rev_info *revs,
@@ -1056,7 +1056,7 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 				continue;
 			}
 			if (!strcmp(arg, "--first-parent")) {
-				revs->first_parent_only = 1;
+				REV_TRAV_SET(revs, FIRST_PARENT_ONLY);
 				continue;
 			}
 			if (!strcmp(arg, "--reflog")) {
@@ -1079,17 +1079,17 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 				continue;
 			}
 			if (!strcmp(arg, "--merge")) {
-				revs->show_merge = 1;
+				REV_FMT_SET(revs, SHOW_MERGE);
 				continue;
 			}
 			if (!strcmp(arg, "--topo-order")) {
-				revs->lifo = 1;
-				revs->topo_order = 1;
+				REV_TRAV_SET(revs, LIFO);
+				REV_TRAV_SET(revs, TOPO_ORDER);
 				continue;
 			}
 			if (!strcmp(arg, "--date-order")) {
-				revs->lifo = 0;
-				revs->topo_order = 1;
+				REV_TRAV_CLR(revs, LIFO);
+				REV_TRAV_SET(revs, TOPO_ORDER);
 				continue;
 			}
 			if (!prefixcmp(arg, "--early-output")) {
@@ -1099,131 +1099,131 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 					count = atoi(arg+15);
 					/* Fallthrough */
 				case 0:
-					revs->topo_order = 1;
+					REV_TRAV_SET(revs, TOPO_ORDER);
 					revs->early_output = count;
 					continue;
 				}
 			}
 			if (!strcmp(arg, "--parents")) {
-				revs->rewrite_parents = 1;
-				revs->print_parents = 1;
+				REV_TRAV_SET(revs, REWRITE_PARENTS);
+				REV_TRAV_SET(revs, PRINT_PARENTS);
 				continue;
 			}
 			if (!strcmp(arg, "--dense")) {
-				revs->dense = 1;
+				REV_TRAV_SET(revs, DENSE);
 				continue;
 			}
 			if (!strcmp(arg, "--sparse")) {
-				revs->dense = 0;
+				REV_TRAV_CLR(revs, DENSE);
 				continue;
 			}
 			if (!strcmp(arg, "--show-all")) {
-				revs->show_all = 1;
+				REV_TRAV_SET(revs, SHOW_ALL);
 				continue;
 			}
 			if (!strcmp(arg, "--remove-empty")) {
-				revs->remove_empty_trees = 1;
+				REV_TRAV_SET(revs, REMOVE_EMPTY_TREES);
 				continue;
 			}
 			if (!strcmp(arg, "--no-merges")) {
-				revs->no_merges = 1;
+				REV_TRAV_SET(revs, NO_MERGES);
 				continue;
 			}
 			if (!strcmp(arg, "--boundary")) {
-				revs->boundary = 1;
+				REV_TRAV_SET(revs, BOUNDARY);
 				continue;
 			}
 			if (!strcmp(arg, "--left-right")) {
-				revs->left_right = 1;
+				REV_TRAV_SET(revs, LEFT_RIGHT);
 				continue;
 			}
 			if (!strcmp(arg, "--cherry-pick")) {
-				revs->cherry_pick = 1;
-				revs->limited = 1;
+				REV_TRAV_SET(revs, CHERRY_PICK);
+				REV_TRAV_SET(revs, LIMITED);
 				continue;
 			}
 			if (!strcmp(arg, "--objects")) {
-				revs->tag_objects = 1;
-				revs->tree_objects = 1;
-				revs->blob_objects = 1;
+				REV_TRAV_SET(revs, TAG_OBJECTS);
+				REV_TRAV_SET(revs, TREE_OBJECTS);
+				REV_TRAV_SET(revs, BLOB_OBJECTS);
 				continue;
 			}
 			if (!strcmp(arg, "--objects-edge")) {
-				revs->tag_objects = 1;
-				revs->tree_objects = 1;
-				revs->blob_objects = 1;
-				revs->edge_hint = 1;
+				REV_TRAV_SET(revs, TAG_OBJECTS);
+				REV_TRAV_SET(revs, TREE_OBJECTS);
+				REV_TRAV_SET(revs, BLOB_OBJECTS);
+				REV_TRAV_SET(revs, EDGE_HINT);
 				continue;
 			}
 			if (!strcmp(arg, "--unpacked")) {
-				revs->unpacked = 1;
+				REV_TRAV_SET(revs, UNPACKED);
 				free(revs->ignore_packed);
 				revs->ignore_packed = NULL;
 				revs->num_ignore_packed = 0;
 				continue;
 			}
 			if (!prefixcmp(arg, "--unpacked=")) {
-				revs->unpacked = 1;
+				REV_TRAV_SET(revs, UNPACKED);
 				add_ignore_packed(revs, arg+11);
 				continue;
 			}
 			if (!strcmp(arg, "-r")) {
-				revs->diff = 1;
+				REV_DIFF_SET(revs, DIFF);
 				DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
 				continue;
 			}
 			if (!strcmp(arg, "-t")) {
-				revs->diff = 1;
+				REV_DIFF_SET(revs, DIFF);
 				DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
 				DIFF_OPT_SET(&revs->diffopt, TREE_IN_RECURSIVE);
 				continue;
 			}
 			if (!strcmp(arg, "-m")) {
-				revs->ignore_merges = 0;
+				REV_DIFF_CLR(revs, IGNORE_MERGES);
 				continue;
 			}
 			if (!strcmp(arg, "-c")) {
-				revs->diff = 1;
-				revs->dense_combined_merges = 0;
-				revs->combine_merges = 1;
+				REV_DIFF_SET(revs, DIFF);
+				REV_DIFF_CLR(revs, DENSE_COMBINED_MERGES);
+				REV_DIFF_SET(revs, COMBINE_MERGES);
 				continue;
 			}
 			if (!strcmp(arg, "--cc")) {
-				revs->diff = 1;
-				revs->dense_combined_merges = 1;
-				revs->combine_merges = 1;
+				REV_DIFF_SET(revs, DIFF);
+				REV_DIFF_SET(revs, DENSE_COMBINED_MERGES);
+				REV_DIFF_SET(revs, COMBINE_MERGES);
 				continue;
 			}
 			if (!strcmp(arg, "-v")) {
-				revs->verbose_header = 1;
+				REV_DIFF_SET(revs, VERBOSE_HEADER);
 				continue;
 			}
 			if (!strcmp(arg, "--pretty")) {
-				revs->verbose_header = 1;
+				REV_DIFF_SET(revs, VERBOSE_HEADER);
 				get_commit_format(arg+8, revs);
 				continue;
 			}
 			if (!prefixcmp(arg, "--pretty=")) {
-				revs->verbose_header = 1;
+				REV_DIFF_SET(revs, VERBOSE_HEADER);
 				get_commit_format(arg+9, revs);
 				continue;
 			}
 			if (!strcmp(arg, "--graph")) {
-				revs->topo_order = 1;
-				revs->rewrite_parents = 1;
+				REV_TRAV_SET(revs, TOPO_ORDER);
+				REV_TRAV_SET(revs, REWRITE_PARENTS);
 				revs->graph = graph_init(revs);
 				continue;
 			}
 			if (!strcmp(arg, "--root")) {
-				revs->show_root_diff = 1;
+				REV_DIFF_SET(revs, SHOW_ROOT_DIFF);
 				continue;
 			}
 			if (!strcmp(arg, "--no-commit-id")) {
-				revs->no_commit_id = 1;
+				REV_DIFF_SET(revs, NO_COMMIT_ID);
 				continue;
 			}
 			if (!strcmp(arg, "--always")) {
-				revs->always_show_header = 1;
+				REV_DIFF_SET(revs, ALWAYS_SHOW_HEADER);
 				continue;
 			}
 			if (!strcmp(arg, "--no-abbrev")) {
@@ -1243,16 +1243,16 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 				continue;
 			}
 			if (!strcmp(arg, "--abbrev-commit")) {
-				revs->abbrev_commit = 1;
+				REV_FMT_SET(revs, ABBREV_COMMIT);
 				continue;
 			}
 			if (!strcmp(arg, "--full-diff")) {
-				revs->diff = 1;
-				revs->full_diff = 1;
+				REV_DIFF_SET(revs, DIFF);
+				REV_DIFF_SET(revs, FULL_DIFF);
 				continue;
 			}
 			if (!strcmp(arg, "--full-history")) {
-				revs->simplify_history = 0;
+				REV_TRAV_CLR(revs, SIMPLIFY_HISTORY);
 				continue;
 			}
 			if (!strcmp(arg, "--relative-date")) {
@@ -1311,20 +1311,20 @@ int parse_revisions(int argc, const char **argv, struct rev_info *revs)
 				continue;
 			}
 			if (!strcmp(arg, "--reverse")) {
-				revs->reverse ^= 1;
+				REV_TRAV_XOR(revs, REVERSE);
 				continue;
 			}
 			if (!strcmp(arg, "--no-walk")) {
-				revs->no_walk = 1;
+				REV_TRAV_SET(revs, NO_WALK);
 				continue;
 			}
 			if (!strcmp(arg, "--do-walk")) {
-				revs->no_walk = 0;
+				REV_TRAV_CLR(revs, NO_WALK);
 				continue;
 			}
 			if (!strcmp(arg, "--children")) {
 				revs->children.name = "children";
-				revs->limited = 1;
+				REV_TRAV_SET(revs, LIMITED);
 				continue;
 			}
 
@@ -1370,7 +1370,7 @@ void setup_revisions(struct rev_info *revs, const char *def)
 {
 	if (revs->def == NULL)
 		revs->def = def;
-	if (revs->show_merge)
+	if (REV_FMT_TST(revs, SHOW_MERGE))
 		prepare_show_merge(revs);
 	if (revs->def && !revs->pending.nr) {
 		unsigned char sha1[20];
@@ -1384,28 +1384,28 @@ void setup_revisions(struct rev_info *revs, const char *def)
 
 	/* Did the user ask for any diff output? Run the diff! */
 	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
-		revs->diff = 1;
+		REV_DIFF_SET(revs, DIFF);
 
 	/* Pickaxe, diff-filter and rename following need diffs */
 	if (revs->diffopt.pickaxe ||
 	    revs->diffopt.filter ||
 	    DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
-		revs->diff = 1;
+		REV_DIFF_SET(revs, DIFF);
 
-	if (revs->topo_order)
-		revs->limited = 1;
+	if (REV_TRAV_TST(revs, TOPO_ORDER))
+		REV_TRAV_SET(revs, LIMITED);
 
 	if (revs->prune_data) {
 		diff_tree_setup_paths(revs->prune_data, &revs->pruning);
 		/* Can't prune commits with rename following: the paths change.. */
 		if (!DIFF_OPT_TST(&revs->diffopt, FOLLOW_RENAMES))
-			revs->prune = 1;
-		if (!revs->full_diff)
+			REV_TRAV_SET(revs, PRUNE);
+		if (!REV_DIFF_TST(revs, FULL_DIFF))
 			diff_tree_setup_paths(revs->prune_data, &revs->diffopt);
 	}
-	if (revs->combine_merges) {
-		revs->ignore_merges = 0;
-		if (revs->dense_combined_merges && !revs->diffopt.output_format)
+	if (REV_DIFF_TST(revs, COMBINE_MERGES)) {
+		REV_DIFF_CLR(revs, IGNORE_MERGES);
+		if (REV_DIFF_TST(revs, DENSE_COMBINED_MERGES) && !revs->diffopt.output_format)
 			revs->diffopt.output_format = DIFF_FORMAT_PATCH;
 	}
 	revs->diffopt.abbrev = revs->abbrev;
@@ -1416,15 +1416,15 @@ void setup_revisions(struct rev_info *revs, const char *def)
 		compile_grep_patterns(revs->grep_filter);
 	}
 
-	if (revs->reverse && revs->reflog_info)
+	if (REV_TRAV_TST(revs, REVERSE) && revs->reflog_info)
 		die("cannot combine --reverse with --walk-reflogs");
-	if (revs->rewrite_parents && revs->children.name)
+	if (REV_TRAV_TST(revs, REWRITE_PARENTS) && revs->children.name)
 		die("cannot combine --parents and --children");
 
 	/*
 	 * Limitations on the graph functionality
 	 */
-	if (revs->reverse && revs->graph)
+	if (REV_TRAV_TST(revs, REVERSE) && revs->graph)
 		die("cannot combine --reverse with --graph");
 
 	if (revs->reflog_info && revs->graph)
@@ -1472,13 +1472,13 @@ int prepare_revision_walk(struct rev_info *revs)
 	}
 	free(list);
 
-	if (revs->no_walk)
+	if (REV_TRAV_TST(revs, NO_WALK))
 		return 0;
-	if (revs->limited)
+	if (REV_TRAV_TST(revs, LIMITED))
 		if (limit_list(revs) < 0)
 			return -1;
-	if (revs->topo_order)
-		sort_in_topological_order(&revs->commits, revs->lifo);
+	if (REV_TRAV_TST(revs, TOPO_ORDER))
+		sort_in_topological_order(&revs->commits, REV_TRAV_TST(revs, LIFO));
 	if (revs->children.name)
 		set_children(revs);
 	return 0;
@@ -1494,7 +1494,7 @@ static enum rewrite_result rewrite_one(struct rev_info *revs, struct commit **pp
 {
 	for (;;) {
 		struct commit *p = *pp;
-		if (!revs->limited)
+		if (!REV_TRAV_TST(revs, LIMITED))
 			if (add_parents_to_list(revs, p, &revs->commits) < 0)
 				return rewrite_one_error;
 		if (p->parents && p->parents->next)
@@ -1560,26 +1560,26 @@ static int commit_match(struct commit *commit, struct rev_info *opt)
 
 static inline int want_ancestry(struct rev_info *revs)
 {
-	return (revs->rewrite_parents || revs->children.name);
+	return (REV_TRAV_TST(revs, REWRITE_PARENTS) || revs->children.name);
 }
 
 enum commit_action simplify_commit(struct rev_info *revs, struct commit *commit)
 {
 	if (commit->object.flags & SHOWN)
 		return commit_ignore;
-	if (revs->unpacked && has_sha1_pack(commit->object.sha1, revs->ignore_packed))
+	if (REV_TRAV_TST(revs, UNPACKED) && has_sha1_pack(commit->object.sha1, revs->ignore_packed))
 		return commit_ignore;
-	if (revs->show_all)
+	if (REV_TRAV_TST(revs, SHOW_ALL))
 		return commit_show;
 	if (commit->object.flags & UNINTERESTING)
 		return commit_ignore;
 	if (revs->min_age != -1 && (commit->date > revs->min_age))
 		return commit_ignore;
-	if (revs->no_merges && commit->parents && commit->parents->next)
+	if (REV_TRAV_TST(revs, NO_MERGES) && commit->parents && commit->parents->next)
 		return commit_ignore;
 	if (!commit_match(commit, revs))
 		return commit_ignore;
-	if (revs->prune && revs->dense) {
+	if (REV_TRAV_TST(revs, PRUNE) && REV_TRAV_TST(revs, DENSE)) {
 		/* Commit without changes? */
 		if (commit->object.flags & TREESAME) {
 			/* drop merges unless we want parenthood */
@@ -1615,7 +1615,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 * the parents here. We also need to do the date-based limiting
 		 * that we'd otherwise have done in limit_list().
 		 */
-		if (!revs->limited) {
+		if (!REV_TRAV_TST(revs, LIMITED)) {
 			if (revs->max_age != -1 &&
 			    (commit->date < revs->max_age))
 				continue;
@@ -1694,7 +1694,7 @@ static void create_boundary_commit_list(struct rev_info *revs)
 	 * If revs->topo_order is set, sort the boundary commits
 	 * in topological order
 	 */
-	sort_in_topological_order(&revs->commits, revs->lifo);
+	sort_in_topological_order(&revs->commits, REV_TRAV_TST(revs, LIFO));
 }
 
 static struct commit *get_revision_internal(struct rev_info *revs)
@@ -1702,7 +1702,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	struct commit *c = NULL;
 	struct commit_list *l;
 
-	if (revs->boundary == 2) {
+	if (REV_TRAV_TST(revs, BOUNDARY_OUTPUT)) {
 		/*
 		 * All of the normal commits have already been returned,
 		 * and we are now returning boundary commits.
@@ -1715,7 +1715,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		return c;
 	}
 
-	if (revs->reverse) {
+	if (REV_TRAV_TST(revs, REVERSE)) {
 		int limit = -1;
 
 		if (0 <= revs->max_count) {
@@ -1730,7 +1730,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 				break;
 		}
 		revs->commits = l;
-		revs->reverse = 0;
+		REV_TRAV_CLR(revs, REVERSE);
 		revs->max_count = -1;
 		c = NULL;
 	}
@@ -1764,7 +1764,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 	if (c)
 		c->object.flags |= SHOWN;
 
-	if (!revs->boundary) {
+	if (!REV_TRAV_TST(revs, BOUNDARY)) {
 		return c;
 	}
 
@@ -1774,7 +1774,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 		 * we are done computing the boundaries.
 		 * switch to boundary commits output mode.
 		 */
-		revs->boundary = 2;
+		REV_TRAV_SET(revs, BOUNDARY_OUTPUT);
 
 		/*
 		 * Update revs->commits to contain the list of
diff --git a/revision.h b/revision.h
index 72ab144..5c95b9b 100644
--- a/revision.h
+++ b/revision.h
@@ -15,6 +15,57 @@
 struct rev_info;
 struct log_info;
 
+/* rev_info traversal flags */
+#define REV_TRAV_DENSE               (1u <<  0)
+#define REV_TRAV_PRUNE               (1u <<  1)
+#define REV_TRAV_NO_MERGES           (1u <<  2)
+#define REV_TRAV_NO_WALK             (1u <<  3)
+#define REV_TRAV_SHOW_ALL            (1u <<  4)
+#define REV_TRAV_REMOVE_EMPTY_TREES  (1u <<  5)
+#define REV_TRAV_SIMPLIFY_HISTORY    (1u <<  6)
+#define REV_TRAV_LIFO                (1u <<  7)
+#define REV_TRAV_TOPO_ORDER          (1u <<  8)
+#define REV_TRAV_TAG_OBJECTS         (1u <<  9)
+#define REV_TRAV_TREE_OBJECTS        (1u << 10)
+#define REV_TRAV_BLOB_OBJECTS        (1u << 11)
+#define REV_TRAV_EDGE_HINT           (1u << 12)
+#define REV_TRAV_LIMITED             (1u << 13)
+#define REV_TRAV_UNPACKED            (1u << 14)
+#define REV_TRAV_BOUNDARY            (1u << 15)
+#define REV_TRAV_BOUNDARY_OUTPUT     (1u << 16)
+#define REV_TRAV_LEFT_RIGHT          (1u << 17)
+#define REV_TRAV_REWRITE_PARENTS     (1u << 18)
+#define REV_TRAV_PRINT_PARENTS       (1u << 19)
+#define REV_TRAV_REVERSE             (1u << 20)
+#define REV_TRAV_CHERRY_PICK         (1u << 21)
+#define REV_TRAV_FIRST_PARENT_ONLY   (1u << 22)
+#define REV_TRAV_TST(rev, flag)      ((rev)->trav_flags & REV_TRAV_##flag)
+#define REV_TRAV_SET(rev, flag)      ((rev)->trav_flags |= REV_TRAV_##flag)
+#define REV_TRAV_XOR(rev, flag)      ((rev)->trav_flags ^= REV_TRAV_##flag)
+#define REV_TRAV_CLR(rev, flag)      ((rev)->trav_flags &= ~REV_TRAV_##flag)
+
+#define REV_DIFF_DIFF                   (1u << 0)
+#define REV_DIFF_FULL_DIFF              (1u << 1)
+#define REV_DIFF_SHOW_ROOT_DIFF         (1u << 2)
+#define REV_DIFF_NO_COMMIT_ID           (1u << 3)
+#define REV_DIFF_VERBOSE_HEADER         (1u << 4)
+#define REV_DIFF_IGNORE_MERGES          (1u << 5)
+#define REV_DIFF_COMBINE_MERGES         (1u << 6)
+#define REV_DIFF_DENSE_COMBINED_MERGES  (1u << 7)
+#define REV_DIFF_ALWAYS_SHOW_HEADER     (1u << 8)
+#define REV_DIFF_TST(rev, flag)      ((rev)->diff_flags & REV_DIFF_##flag)
+#define REV_DIFF_SET(rev, flag)      ((rev)->diff_flags |= REV_DIFF_##flag)
+#define REV_DIFF_CLR(rev, flag)      ((rev)->diff_flags &= ~REV_DIFF_##flag)
+
+#define REV_FMT_SHOWN_ONE               (1u << 0)
+#define REV_FMT_SHOW_MERGE              (1u << 1)
+#define REV_FMT_ABBREV_COMMIT           (1u << 2)
+#define REV_FMT_USE_TERMINATOR          (1u << 3)
+#define REV_FMT_MISSING_NEWLINE         (1u << 4)
+#define REV_FMT_TST(rev, flag)       ((rev)->fmt_flags & REV_FMT_##flag)
+#define REV_FMT_SET(rev, flag)       ((rev)->fmt_flags |= REV_FMT_##flag)
+#define REV_FMT_CLR(rev, flag)       ((rev)->fmt_flags &= ~REV_FMT_##flag)
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -29,47 +80,9 @@ struct rev_info {
 	void *prune_data;
 	unsigned int early_output;
 
-	/* Traversal flags */
-	unsigned int	dense:1,
-			prune:1,
-			no_merges:1,
-			no_walk:1,
-			show_all:1,
-			remove_empty_trees:1,
-			simplify_history:1,
-			lifo:1,
-			topo_order:1,
-			tag_objects:1,
-			tree_objects:1,
-			blob_objects:1,
-			edge_hint:1,
-			limited:1,
-			unpacked:1, /* see also ignore_packed below */
-			boundary:2,
-			left_right:1,
-			rewrite_parents:1,
-			print_parents:1,
-			reverse:1,
-			cherry_pick:1,
-			first_parent_only:1;
-
-	/* Diff flags */
-	unsigned int	diff:1,
-			full_diff:1,
-			show_root_diff:1,
-			no_commit_id:1,
-			verbose_header:1,
-			ignore_merges:1,
-			combine_merges:1,
-			dense_combined_merges:1,
-			always_show_header:1;
-
-	/* Format info */
-	unsigned int	shown_one:1,
-			show_merge:1,
-			use_terminator:1,
-			abbrev_commit:1,
-			missing_newline:1;
+	unsigned int trav_flags; /* Traversal flags */
+	unsigned int diff_flags; /* Diff flags */
+	unsigned int fmt_flags;  /* Format info */
 	enum date_mode date_mode;
 
 	const char **ignore_packed; /* pretend objects in these are unpacked */
diff --git a/upload-pack.c b/upload-pack.c
index 9d031fc..78bc4b8 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -108,11 +108,11 @@ static int do_rev_list(int fd, void *create_full_pack)
 	if (create_full_pack)
 		use_thin_pack = 0; /* no point doing it */
 	init_revisions(&revs, NULL);
-	revs.tag_objects = 1;
-	revs.tree_objects = 1;
-	revs.blob_objects = 1;
+	REV_TRAV_SET(&revs, TAG_OBJECTS);
+	REV_TRAV_SET(&revs, BLOB_OBJECTS);
+	REV_TRAV_SET(&revs, TREE_OBJECTS);
 	if (use_thin_pack)
-		revs.edge_hint = 1;
+		REV_TRAV_SET(&revs, EDGE_HINT);
 
 	if (create_full_pack) {
 		const char *args[] = {"rev-list", "--all", NULL};
-- 
1.5.6.rc0.145.gbc48c
