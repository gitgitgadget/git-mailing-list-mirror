From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 04/22] teach diff-index.c about cache iterators
Date: Mon, 12 Sep 2005 10:55:52 -0400
Message-ID: <20050912145552.28120.21880.stgit@dexter.citi.umich.edu>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
X-From: git-owner@vger.kernel.org Mon Sep 12 17:03:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEpll-0001hk-12
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 16:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbVILO44 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 10:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbVILO4y
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 10:56:54 -0400
Received: from citi.umich.edu ([141.211.133.111]:50774 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751286AbVILOzw (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 12 Sep 2005 10:55:52 -0400
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 238CC1BAF3
	for <git@vger.kernel.org>; Mon, 12 Sep 2005 10:55:52 -0400 (EDT)
To: git@vger.kernel.org
In-Reply-To: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8403>

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 diff-index.c |  126 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/diff-index.c b/diff-index.c
--- a/diff-index.c
+++ b/diff-index.c
@@ -14,9 +14,10 @@ static int pickaxe_opts = 0;
 static int diff_break_opt = -1;
 static const char *orderfile = NULL;
 static const char *diff_filter = NULL;
+static const char **pathspec = NULL;
 
 /* A file entry went away or appeared */
-static void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
+static inline void show_file(const char *prefix, struct cache_entry *ce, unsigned char *sha1, unsigned int mode)
 {
 	diff_addremove(prefix[0], ntohl(mode), sha1, ce->name, NULL);
 }
@@ -88,62 +89,63 @@ static int show_modified(struct cache_en
 	return 0;
 }
 
-static int diff_cache(struct cache_entry **ac, int entries, const char **pathspec)
+static int diff_one(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	while (entries) {
-		struct cache_entry *ce = *ac;
-		int same = (entries > 1) && ce_same_name(ce, ac[1]);
-
-		if (!ce_path_match(ce, pathspec))
-			goto skip_entry;
-
-		switch (ce_stage(ce)) {
-		case 0:
-			/* No stage 1 entry? That means it's a new file */
-			if (!same) {
-				show_new_file(ce);
-				break;
-			}
-			/* Show difference between old and new */
-			show_modified(ac[1], ce, 1);
+	struct cache_entry *next;
+	int same;
+
+	if (!ce_path_match(ce, pathspec))
+		goto skip_entry;
+
+	next_cc(cc);
+	next = cc_to_ce(cc);
+	/* check eof here to skip the last entry in the cache */
+	same = (!cache_eof(cc) && ce_same_name(ce, next));
+	prev_cc(cc);
+
+	switch (ce_stage(ce)) {
+	case 0:
+		/* No stage 1 entry? That means it's a new file */
+		if (!same) {
+			show_new_file(ce);
 			break;
-		case 1:
-			/* No stage 3 (merge) entry? That means it's been deleted */
-			if (!same) {
-				show_file("-", ce, ce->sha1, ce->ce_mode);
-				break;
-			}
-			/* We come here with ce pointing at stage 1
-			 * (original tree) and ac[1] pointing at stage
-			 * 3 (unmerged).  show-modified with
-			 * report-mising set to false does not say the
-			 * file is deleted but reports true if work
-			 * tree does not have it, in which case we
-			 * fall through to report the unmerged state.
-			 * Otherwise, we show the differences between
-			 * the original tree and the work tree.
-			 */
-			if (!cached_only && !show_modified(ce, ac[1], 0))
-				break;
-			/* fallthru */
-		case 3:
-			diff_unmerge(ce->name);
+		}
+		/* Show difference between old and new */
+		show_modified(next, ce, 1);
+		break;
+	case 1:
+		/* No stage 3 (merge) entry? That means it's been deleted */
+		if (!same) {
+			show_file("-", ce, ce->sha1, ce->ce_mode);
 			break;
-
-		default:
-			die("impossible cache entry stage");
 		}
-
-skip_entry:
-		/*
-		 * Ignore all the different stages for this file,
-		 * we've handled the relevant cases now.
+		/* We come here with ce pointing at stage 1
+		 * (original tree) and next pointing at stage
+		 * 3 (unmerged).  show-modified with
+		 * report-mising set to false does not say the
+		 * file is deleted but reports true if work
+		 * tree does not have it, in which case we
+		 * fall through to report the unmerged state.
+		 * Otherwise, we show the differences between
+		 * the original tree and the work tree.
 		 */
-		do {
-			ac++;
-			entries--;
-		} while (entries && ce_same_name(ce, ac[0]));
+		if (!cached_only && !show_modified(ce, next, 0))
+			break;
+		/* fallthru */
+	case 3:
+		diff_unmerge(ce->name);
+		break;
+	default:
+		die("impossible cache entry stage");
+		break;
 	}
+
+skip_entry:
+	/*
+	 * Ignore all the different stages for this file,
+	 * we've handled the relevant cases now.
+	 */
+	next_name(cc, ce);
 	return 0;
 }
 
@@ -152,15 +154,12 @@ skip_entry:
  * when we read in the new tree (into "stage 1"), we won't lose sight
  * of the fact that we had unmerged entries.
  */
-static void mark_merge_entries(void)
+static int mark_one_entry(struct cache_cursor *cc, struct cache_entry *ce)
 {
-	int i;
-	for (i = 0; i < active_nr; i++) {
-		struct cache_entry *ce = active_cache[i];
-		if (!ce_stage(ce))
-			continue;
+	if (ce_stage(ce))
 		ce->ce_flags |= htons(CE_STAGEMASK);
-	}
+	next_cc(cc);
+	return 0;
 }
 
 static const char diff_cache_usage[] =
@@ -173,10 +172,8 @@ int main(int argc, char **argv)
 	const char *tree_name = NULL;
 	unsigned char sha1[20];
 	const char *prefix = setup_git_directory();
-	const char **pathspec = NULL;
 	void *tree;
 	unsigned long size;
-	int ret;
 	int allow_options = 1;
 	int i;
 
@@ -271,12 +268,13 @@ int main(int argc, char **argv)
 	if (!tree_name || get_sha1(tree_name, sha1))
 		usage(diff_cache_usage);
 
-	read_cache();
+	if (read_cache() < 0)
+		die("unable to read index file");
 
 	/* The rest is for paths restriction. */
 	diff_setup(diff_setup_opt);
 
-	mark_merge_entries();
+	walk_cache(mark_one_entry);
 
 	tree = read_object_with_reference(sha1, "tree", &size, NULL);
 	if (!tree)
@@ -284,7 +282,7 @@ int main(int argc, char **argv)
 	if (read_tree(tree, size, 1, pathspec))
 		die("unable to read tree object %s", tree_name);
 
-	ret = diff_cache(active_cache, active_nr, pathspec);
+	walk_cache(diff_one);
 
 	diffcore_std(pathspec,
 		     detect_rename, diff_score_opt,
@@ -292,5 +290,5 @@ int main(int argc, char **argv)
 		     diff_break_opt,
 		     orderfile, diff_filter);
 	diff_flush(diff_output_format, diff_line_termination);
-	return ret;
+	return 0;
 }
