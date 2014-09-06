From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 5/8] Fold all merge diff variants into an enum
Date: Sat,  6 Sep 2014 19:57:03 +0200
Message-ID: <e95adf985efac162da72ac27220b904659dbb02d.1409860234.git.tr@thomasrast.ch>
References: <cover.1409860234.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 19:57:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQKF1-0005nG-S6
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 19:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbaIFR5d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 13:57:33 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:40799 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaIFR5b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 13:57:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 5F77D4D65CD;
	Sat,  6 Sep 2014 19:57:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id jqBA8tC1bQZ6; Sat,  6 Sep 2014 19:57:17 +0200 (CEST)
Received: from linux.local (unknown [65.50.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id DF1B44D669D;
	Sat,  6 Sep 2014 19:57:14 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.72.g9b94086
In-Reply-To: <cover.1409860234.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256595>

The four ways of displaying merge diffs,

* none: no diff
* -m: against each parent
* -c: combined
* --cc: combined-condensed

were encoded in three flag bits in struct rev_info.  Fold them all
into a single enum field that captures the variants.

This makes it easier to add new merge diff variants without yet more
special casing.  It should also be slightly easier to read because one
does not have to ensure that the flag bits are set in an expected
combination.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 builtin/diff-files.c    |  5 +++--
 builtin/diff-tree.c     |  2 +-
 builtin/diff.c          |  9 +++++----
 builtin/fmt-merge-msg.c |  2 +-
 builtin/log.c           |  9 ++++-----
 builtin/merge.c         |  1 -
 combine-diff.c          |  2 +-
 diff-lib.c              |  7 ++++---
 log-tree.c              |  4 ++--
 revision.c              | 13 +++----------
 revision.h              | 22 +++++++++++++++++++---
 submodule.c             |  4 +---
 12 files changed, 44 insertions(+), 36 deletions(-)

diff --git a/builtin/diff-files.c b/builtin/diff-files.c
index 9200069..172b50d 100644
--- a/builtin/diff-files.c
+++ b/builtin/diff-files.c
@@ -57,9 +57,10 @@ int cmd_diff_files(int argc, const char **argv, const char *prefix)
 	 * was not asked to.  "diff-files -c -p" should not densify
 	 * (the user should ask with "diff-files --cc" explicitly).
 	 */
-	if (rev.max_count == -1 && !rev.combine_merges &&
+	if (rev.max_count == -1 &&
+	    !merge_diff_mode_is_any_combined(&rev) &&
 	    (rev.diffopt.output_format & DIFF_FORMAT_PATCH))
-		rev.combine_merges = rev.dense_combined_merges = 1;
+		rev.merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
 
 	if (read_cache_preload(&rev.diffopt.pathspec) < 0) {
 		perror("read_cache_preload");
diff --git a/builtin/diff-tree.c b/builtin/diff-tree.c
index 1c4ad62..1a4bcf1 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -90,7 +90,7 @@ COMMON_DIFF_OPTIONS_HELP;
 static void diff_tree_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
 	if (!rev->diffopt.output_format) {
-		if (rev->dense_combined_merges)
+		if (rev->merge_diff_mode == MERGE_DIFF_COMBINED_CONDENSED)
 			rev->diffopt.output_format = DIFF_FORMAT_PATCH;
 		else
 			rev->diffopt.output_format = DIFF_FORMAT_RAW;
diff --git a/builtin/diff.c b/builtin/diff.c
index 47f663b..fd4c75f 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -192,8 +192,8 @@ static int builtin_diff_combined(struct rev_info *revs,
 	if (argc > 1)
 		usage(builtin_diff_usage);
 
-	if (!revs->dense_combined_merges && !revs->combine_merges)
-		revs->dense_combined_merges = revs->combine_merges = 1;
+	if (!merge_diff_mode_is_any_combined(revs))
+		revs->merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
 	for (i = 1; i < ents; i++)
 		sha1_array_append(&parents, ent[i].item->sha1);
 	diff_tree_combined(ent[0].item->sha1, &parents, revs);
@@ -242,9 +242,10 @@ static int builtin_diff_files(struct rev_info *revs, int argc, const char **argv
 	 * dense one, --cc can be explicitly asked for, or just rely
 	 * on the default).
 	 */
-	if (revs->max_count == -1 && !revs->combine_merges &&
+	if (revs->max_count == -1 &&
+	    !merge_diff_mode_is_any_combined(revs) &&
 	    (revs->diffopt.output_format & DIFF_FORMAT_PATCH))
-		revs->combine_merges = revs->dense_combined_merges = 1;
+		revs->merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
 
 	setup_work_tree();
 	if (read_cache_preload(&revs->diffopt.pathspec) < 0) {
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index 79df05e..db23626 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -637,7 +637,7 @@ int fmt_merge_msg(struct strbuf *in, struct strbuf *out,
 		head = lookup_commit_or_die(head_sha1, "HEAD");
 		init_revisions(&rev, NULL);
 		rev.commit_format = CMIT_FMT_ONELINE;
-		rev.ignore_merges = 1;
+		rev.merge_diff_mode = MERGE_DIFF_IGNORE;
 		rev.limited = 1;
 
 		strbuf_complete_line(out);
diff --git a/builtin/log.c b/builtin/log.c
index 4389722..ba057d5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -496,13 +496,12 @@ static int show_tree_object(const unsigned char *sha1,
 
 static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
-	if (rev->ignore_merges) {
+	if (!rev->merge_diff_mode) {
 		/* There was no "-m" on the command line */
-		rev->ignore_merges = 0;
-		if (!rev->first_parent_only && !rev->combine_merges) {
+		rev->merge_diff_mode = MERGE_DIFF_EACH;
+		if (!rev->first_parent_only) {
 			/* No "--first-parent", "-c", or "--cc" */
-			rev->combine_merges = 1;
-			rev->dense_combined_merges = 1;
+			rev->merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
 		}
 	}
 	if (!rev->diffopt.output_format)
diff --git a/builtin/merge.c b/builtin/merge.c
index ce82eb2..f3e568a 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -343,7 +343,6 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 		die_errno(_("Could not write to '%s'"), filename);
 
 	init_revisions(&rev, NULL);
-	rev.ignore_merges = 1;
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
 	commit->object.flags |= UNINTERESTING;
diff --git a/combine-diff.c b/combine-diff.c
index 221ab22..d590485 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -981,7 +981,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	struct userdiff_driver *textconv = NULL;
 	int is_binary;
 	const char *line_prefix = diff_line_prefix(opt);
-	int dense = rev->dense_combined_merges;
+	int dense = (rev->merge_diff_mode == MERGE_DIFF_COMBINED_CONDENSED);
 
 	context = opt->context;
 	userdiff = userdiff_find_by_path(elem->path);
diff --git a/diff-lib.c b/diff-lib.c
index 3e533d2..683bb44 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -170,7 +170,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			 */
 			i--;
 
-			if (revs->combine_merges && num_compare_stages == 2) {
+			if (merge_diff_mode_is_any_combined(revs) &&
+			    num_compare_stages == 2) {
 				show_combined_diff(dpath, 2, revs);
 				free(dpath);
 				continue;
@@ -322,7 +323,7 @@ static int show_modified(struct rev_info *revs,
 		return -1;
 	}
 
-	if (revs->combine_merges && !cached &&
+	if (merge_diff_mode_is_any_combined(revs) && !cached &&
 	    (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
 		struct combine_diff_path *p;
 		int pathlen = ce_namelen(new);
@@ -380,7 +381,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	match_missing = !revs->ignore_merges;
+	match_missing = (revs->merge_diff_mode == MERGE_DIFF_EACH);
 
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
diff --git a/log-tree.c b/log-tree.c
index 40a9db1..8f57651 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -747,9 +747,9 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
 	/* More than one parent? */
 	if (parents && parents->next) {
-		if (opt->ignore_merges)
+		if (opt->merge_diff_mode == MERGE_DIFF_IGNORE)
 			return 0;
-		else if (opt->combine_merges)
+		else if (merge_diff_mode_is_any_combined(opt))
 			return do_diff_combined(opt, commit);
 		else if (opt->first_parent_only) {
 			/*
diff --git a/revision.c b/revision.c
index 615535c..7a9a141 100644
--- a/revision.c
+++ b/revision.c
@@ -1324,7 +1324,6 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	memset(revs, 0, sizeof(*revs));
 
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
 	DIFF_OPT_SET(&revs->pruning, RECURSIVE);
 	DIFF_OPT_SET(&revs->pruning, QUICK);
@@ -1811,15 +1810,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		DIFF_OPT_SET(&revs->diffopt, RECURSIVE);
 		DIFF_OPT_SET(&revs->diffopt, TREE_IN_RECURSIVE);
 	} else if (!strcmp(arg, "-m")) {
-		revs->ignore_merges = 0;
+		revs->merge_diff_mode = MERGE_DIFF_EACH;
 	} else if (!strcmp(arg, "-c")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 0;
-		revs->combine_merges = 1;
+		revs->merge_diff_mode = MERGE_DIFF_COMBINED;
 	} else if (!strcmp(arg, "--cc")) {
-		revs->diff = 1;
-		revs->dense_combined_merges = 1;
-		revs->combine_merges = 1;
+		revs->merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
 	} else if (!strcmp(arg, "-v")) {
 		revs->verbose_header = 1;
 	} else if (!strcmp(arg, "--pretty")) {
@@ -2242,8 +2237,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			copy_pathspec(&revs->diffopt.pathspec,
 				      &revs->prune_data);
 	}
-	if (revs->combine_merges)
-		revs->ignore_merges = 0;
 	revs->diffopt.abbrev = revs->abbrev;
 
 	if (revs->line_level_traverse) {
diff --git a/revision.h b/revision.h
index a620530..0eb34c2 100644
--- a/revision.h
+++ b/revision.h
@@ -52,6 +52,17 @@ struct rev_cmdline_info {
 #define REVISION_WALK_NO_WALK_SORTED 1
 #define REVISION_WALK_NO_WALK_UNSORTED 2
 
+enum merge_diff_mode {
+	/* default: do not show diffs for merge */
+	MERGE_DIFF_IGNORE = 0,
+	/* diff against each side (-m) */
+	MERGE_DIFF_EACH,
+	/* combined format (-c) */
+	MERGE_DIFF_COMBINED,
+	/* combined-condensed format (-cc) */
+	MERGE_DIFF_COMBINED_CONDENSED
+};
+
 struct rev_info {
 	/* Starting list */
 	struct commit_list *commits;
@@ -119,11 +130,10 @@ struct rev_info {
 			show_root_diff:1,
 			no_commit_id:1,
 			verbose_header:1,
-			ignore_merges:1,
-			combine_merges:1,
-			dense_combined_merges:1,
 			always_show_header:1;
 
+	enum merge_diff_mode merge_diff_mode;
+
 	/* Format info */
 	unsigned int	shown_one:1,
 			shown_dashes:1,
@@ -209,6 +219,12 @@ struct rev_info {
 	const char *break_bar;
 };
 
+static inline int merge_diff_mode_is_any_combined(struct rev_info *revs)
+{
+	return (revs->merge_diff_mode == MERGE_DIFF_COMBINED ||
+		revs->merge_diff_mode == MERGE_DIFF_COMBINED_CONDENSED);
+}
+
 extern int ref_excluded(struct string_list *, const char *path);
 void clear_ref_exclusion(struct string_list **);
 void add_ref_exclusion(struct string_list **, const char *exclude);
diff --git a/submodule.c b/submodule.c
index 0499de6..aa5eac3 100644
--- a/submodule.c
+++ b/submodule.c
@@ -482,9 +482,7 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	struct rev_info rev;
 
 	init_revisions(&rev, NULL);
-	rev.ignore_merges = 0;
-	rev.combined_merges = 1;
-	rev.dense_combined_merges = 1;
+	rev.merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = collect_submodules_from_diff;
 	rev.diffopt.format_callback_data = needs_pushing;
-- 
2.1.0.72.g9b94086
