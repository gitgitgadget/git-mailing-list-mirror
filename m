From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 5/8] Fold all merge diff variants into an enum
Date: Sat, 22 Feb 2014 10:17:53 +0100
Message-ID: <72dad5aa67ca5700696cfa408b91a079141f7dc7.1393059605.git.tr@thomasrast.ch>
References: <cover.1393059605.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 10:18:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8j7-0003aH-1D
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:18:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbaBVJSY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:18:24 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34871 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751759AbaBVJSN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:18:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 89E994D65CF;
	Sat, 22 Feb 2014 10:18:12 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id eJBDxlhido7P; Sat, 22 Feb 2014 10:18:02 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id ED4E24D65E6;
	Sat, 22 Feb 2014 10:18:01 +0100 (CET)
X-Mailer: git-send-email 1.9.0.313.g3d0a325
In-Reply-To: <cover.1393059605.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242518>

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
index be6417d..2950f80 100644
--- a/builtin/diff-tree.c
+++ b/builtin/diff-tree.c
@@ -96,7 +96,7 @@ static int diff_tree_stdin(char *line)
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
index 3906eda..2deeacd 100644
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
index b97373d..cebebea 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -499,13 +499,12 @@ static int show_tree_object(const unsigned char *sha1,
 
 static void show_rev_tweak_rev(struct rev_info *rev, struct setup_revision_opt *opt)
 {
-	if (rev->ignore_merges) {
+	if (!rev->merge_diff_mode) {
 		/* There was no "-m" on the command line */
-		rev->ignore_merges = 0;
-		if (!rev->first_parent_only && !rev->combine_merges) {
+		rev->merge_diff_mode = MERGE_DIFF_EACH;
+		if (!rev->first_parent_only) {
 			/* No "--first-parent", "-c", nor "--cc" */
-			rev->combine_merges = 1;
-			rev->dense_combined_merges = 1;
+			rev->merge_diff_mode = MERGE_DIFF_COMBINED_CONDENSED;
 		}
 	}
 	if (!rev->diffopt.output_format)
diff --git a/builtin/merge.c b/builtin/merge.c
index e576a7f..6977af7 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -343,7 +343,6 @@ static void squash_message(struct commit *commit, struct commit_list *remotehead
 		die_errno(_("Could not write to '%s'"), filename);
 
 	init_revisions(&rev, NULL);
-	rev.ignore_merges = 1;
 	rev.commit_format = CMIT_FMT_MEDIUM;
 
 	commit->object.flags |= UNINTERESTING;
diff --git a/combine-diff.c b/combine-diff.c
index 6e80a73..3fae2dd 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -967,7 +967,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	struct userdiff_driver *textconv = NULL;
 	int is_binary;
 	const char *line_prefix = diff_line_prefix(opt);
-	int dense = rev->dense_combined_merges;
+	int dense = (rev->merge_diff_mode == MERGE_DIFF_COMBINED_CONDENSED);
 
 	context = opt->context;
 	userdiff = userdiff_find_by_path(elem->path);
diff --git a/diff-lib.c b/diff-lib.c
index 8d0f572..e2700eb 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -173,7 +173,8 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			 */
 			i--;
 
-			if (revs->combine_merges && num_compare_stages == 2) {
+			if (merge_diff_mode_is_any_combined(revs) &&
+			    num_compare_stages == 2) {
 				show_combined_diff(dpath, 2, revs);
 				free(dpath);
 				continue;
@@ -316,7 +317,7 @@ static int show_modified(struct rev_info *revs,
 		return -1;
 	}
 
-	if (revs->combine_merges && !cached &&
+	if (merge_diff_mode_is_any_combined(revs) && !cached &&
 	    (hashcmp(sha1, old->sha1) || hashcmp(old->sha1, new->sha1))) {
 		struct combine_diff_path *p;
 		int pathlen = ce_namelen(new);
@@ -375,7 +376,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
 	 * But with the revision flag parsing, that's found in
 	 * "!revs->ignore_merges".
 	 */
-	match_missing = !revs->ignore_merges;
+	match_missing = (revs->merge_diff_mode == MERGE_DIFF_EACH);
 
 	if (cached && idx && ce_stage(idx)) {
 		struct diff_filepair *pair;
diff --git a/log-tree.c b/log-tree.c
index 4c04812..30b3063 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -751,9 +751,9 @@ static int log_tree_diff(struct rev_info *opt, struct commit *commit, struct log
 
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
index a0df72f..127b75a 100644
--- a/revision.c
+++ b/revision.c
@@ -1329,7 +1329,6 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	memset(revs, 0, sizeof(*revs));
 
 	revs->abbrev = DEFAULT_ABBREV;
-	revs->ignore_merges = 1;
 	revs->simplify_history = 1;
 	DIFF_OPT_SET(&revs->pruning, RECURSIVE);
 	DIFF_OPT_SET(&revs->pruning, QUICK);
@@ -1807,15 +1806,11 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
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
@@ -2228,8 +2223,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 			copy_pathspec(&revs->diffopt.pathspec,
 				      &revs->prune_data);
 	}
-	if (revs->combine_merges)
-		revs->ignore_merges = 0;
 	revs->diffopt.abbrev = revs->abbrev;
 
 	if (revs->line_level_traverse) {
diff --git a/revision.h b/revision.h
index 88967d6..0847902 100644
--- a/revision.h
+++ b/revision.h
@@ -50,6 +50,17 @@ struct rev_cmdline_info {
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
@@ -116,11 +127,10 @@ struct rev_info {
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
@@ -197,6 +207,12 @@ struct rev_info {
 	struct saved_parents *saved_parents_slab;
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
index 83b80fb..38973f2 100644
--- a/submodule.c
+++ b/submodule.c
@@ -505,9 +505,7 @@ static void find_unpushed_submodule_commits(struct commit *commit,
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
1.9.0.313.g3d0a325
