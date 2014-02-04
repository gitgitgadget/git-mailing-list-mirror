From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 6/9] combine-diff: do not pass revs->dense_combined_merges redundantly
Date: Tue,  4 Feb 2014 23:17:35 +0100
Message-ID: <e91b1c369bc8c77fb0627f2c053977cd8bcf5897.1391549294.git.tr@thomasrast.ch>
References: <cover.1391549294.git.tr@thomasrast.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 04 23:18:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WAoK2-0001w8-3i
	for gcvg-git-2@plane.gmane.org; Tue, 04 Feb 2014 23:18:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935214AbaBDWSW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Feb 2014 17:18:22 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:54788 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935029AbaBDWSA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Feb 2014 17:18:00 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id A8F1A4D65EB
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id Iyw7Vdlww9f1 for <git@vger.kernel.org>;
	Tue,  4 Feb 2014 23:17:50 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 721E24D65EA
	for <git@vger.kernel.org>; Tue,  4 Feb 2014 23:17:42 +0100 (CET)
X-Mailer: git-send-email 1.9.rc2.232.gdd31389
In-Reply-To: <cover.1391549294.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241571>

The existing code passed revs->dense_combined_merges along revs itself
into the combine-diff functions, which is rather redundant.  Remove
the 'dense' argument until much further down the callchain to simplify
callers.

Note that while the caller in submodule.c needs to do extra work now,
the next commit will simplify this to a single setting again.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 builtin/diff.c |  3 +--
 combine-diff.c | 13 ++++++-------
 diff-lib.c     |  6 ++----
 diff.h         |  6 +++---
 log-tree.c     |  2 +-
 submodule.c    |  5 ++++-
 6 files changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/diff.c b/builtin/diff.c
index 0f247d2..47f663b 100644
--- a/builtin/diff.c
+++ b/builtin/diff.c
@@ -196,8 +196,7 @@ static int builtin_diff_combined(struct rev_info *revs,
 		revs->dense_combined_merges = revs->combine_merges = 1;
 	for (i = 1; i < ents; i++)
 		sha1_array_append(&parents, ent[i].item->sha1);
-	diff_tree_combined(ent[0].item->sha1, &parents,
-			   revs->dense_combined_merges, revs);
+	diff_tree_combined(ent[0].item->sha1, &parents, revs);
 	sha1_array_clear(&parents);
 	return 0;
 }
diff --git a/combine-diff.c b/combine-diff.c
index 3b92c448..6e80a73 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -952,7 +952,7 @@ static void show_combined_header(struct combine_diff_path *elem,
 }
 
 static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
-			    int dense, int working_tree_file,
+			    int working_tree_file,
 			    struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
@@ -967,6 +967,7 @@ static void show_patch_diff(struct combine_diff_path *elem, int num_parent,
 	struct userdiff_driver *textconv = NULL;
 	int is_binary;
 	const char *line_prefix = diff_line_prefix(opt);
+	int dense = rev->dense_combined_merges;
 
 	context = opt->context;
 	userdiff = userdiff_find_by_path(elem->path);
@@ -1214,7 +1215,6 @@ static void show_raw_diff(struct combine_diff_path *p, int num_parent, struct re
  */
 void show_combined_diff(struct combine_diff_path *p,
 		       int num_parent,
-		       int dense,
 		       struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
@@ -1226,7 +1226,7 @@ void show_combined_diff(struct combine_diff_path *p,
 				  DIFF_FORMAT_NAME_STATUS))
 		show_raw_diff(p, num_parent, rev);
 	else if (opt->output_format & DIFF_FORMAT_PATCH)
-		show_patch_diff(p, num_parent, dense, 1, rev);
+		show_patch_diff(p, num_parent, 1, rev);
 }
 
 static void free_combined_pair(struct diff_filepair *pair)
@@ -1297,7 +1297,6 @@ static void handle_combined_callback(struct diff_options *opt,
 
 void diff_tree_combined(const unsigned char *sha1,
 			const struct sha1_array *parents,
-			int dense,
 			struct rev_info *rev)
 {
 	struct diff_options *opt = &rev->diffopt;
@@ -1365,7 +1364,7 @@ void diff_tree_combined(const unsigned char *sha1,
 				       opt->line_termination);
 			for (p = paths; p; p = p->next) {
 				if (p->len)
-					show_patch_diff(p, num_parent, dense,
+					show_patch_diff(p, num_parent,
 							0, rev);
 			}
 		}
@@ -1381,7 +1380,7 @@ void diff_tree_combined(const unsigned char *sha1,
 	free_pathspec(&diffopts.pathspec);
 }
 
-void diff_tree_combined_merge(const struct commit *commit, int dense,
+void diff_tree_combined_merge(const struct commit *commit,
 			      struct rev_info *rev)
 {
 	struct commit_list *parent = get_saved_parents(rev, commit);
@@ -1391,6 +1390,6 @@ void diff_tree_combined_merge(const struct commit *commit, int dense,
 		sha1_array_append(&parents, parent->item->object.sha1);
 		parent = parent->next;
 	}
-	diff_tree_combined(commit->object.sha1, &parents, dense, rev);
+	diff_tree_combined(commit->object.sha1, &parents, rev);
 	sha1_array_clear(&parents);
 }
diff --git a/diff-lib.c b/diff-lib.c
index 346cac6..8d0f572 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -174,9 +174,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
 			i--;
 
 			if (revs->combine_merges && num_compare_stages == 2) {
-				show_combined_diff(dpath, 2,
-						   revs->dense_combined_merges,
-						   revs);
+				show_combined_diff(dpath, 2, revs);
 				free(dpath);
 				continue;
 			}
@@ -338,7 +336,7 @@ static int show_modified(struct rev_info *revs,
 		p->parent[1].status = DIFF_STATUS_MODIFIED;
 		p->parent[1].mode = old->ce_mode;
 		hashcpy(p->parent[1].sha1, old->sha1);
-		show_combined_diff(p, 2, revs->dense_combined_merges, revs);
+		show_combined_diff(p, 2, revs);
 		free(p);
 		return 0;
 	}
diff --git a/diff.h b/diff.h
index ce123fa..ff77802 100644
--- a/diff.h
+++ b/diff.h
@@ -213,11 +213,11 @@ struct combine_diff_path {
 	 sizeof(struct combine_diff_parent) * (n) + (l) + 1)
 
 extern void show_combined_diff(struct combine_diff_path *elem, int num_parent,
-			      int dense, struct rev_info *);
+			       struct rev_info *);
 
-extern void diff_tree_combined(const unsigned char *sha1, const struct sha1_array *parents, int dense, struct rev_info *rev);
+extern void diff_tree_combined(const unsigned char *sha1, const struct sha1_array *parents, struct rev_info *rev);
 
-extern void diff_tree_combined_merge(const struct commit *commit, int dense, struct rev_info *rev);
+extern void diff_tree_combined_merge(const struct commit *commit, struct rev_info *rev);
 
 void diff_set_mnemonic_prefix(struct diff_options *options, const char *a, const char *b);
 
diff --git a/log-tree.c b/log-tree.c
index 080f412..2fcca45 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -721,7 +721,7 @@ int log_tree_diff_flush(struct rev_info *opt)
 
 static int do_diff_combined(struct rev_info *opt, struct commit *commit)
 {
-	diff_tree_combined_merge(commit, opt->dense_combined_merges, opt);
+	diff_tree_combined_merge(commit, opt);
 	return !opt->loginfo;
 }
 
diff --git a/submodule.c b/submodule.c
index 613857e..83b80fb 100644
--- a/submodule.c
+++ b/submodule.c
@@ -505,10 +505,13 @@ static void find_unpushed_submodule_commits(struct commit *commit,
 	struct rev_info rev;
 
 	init_revisions(&rev, NULL);
+	rev.ignore_merges = 0;
+	rev.combined_merges = 1;
+	rev.dense_combined_merges = 1;
 	rev.diffopt.output_format |= DIFF_FORMAT_CALLBACK;
 	rev.diffopt.format_callback = collect_submodules_from_diff;
 	rev.diffopt.format_callback_data = needs_pushing;
-	diff_tree_combined_merge(commit, 1, &rev);
+	diff_tree_combined_merge(commit, &rev);
 }
 
 int find_unpushed_submodules(unsigned char new_sha1[20],
-- 
1.9.rc2.232.gdd31389
