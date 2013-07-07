From: Thomas Rast <trast@inf.ethz.ch>
Subject: [PATCH 2/3] merge-recursive: untangle double meaning of o->call_depth
Date: Sun, 7 Jul 2013 20:02:39 +0200
Message-ID: <7e823a9faedf1980912628c3a3f083e26fb0c650.1373219466.git.trast@inf.ethz.ch>
References: <cover.1373219466.git.trast@inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Michael Haggerty <mhagger@alum.mit.edu>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jul 07 20:03:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UvtId-0000Tt-IV
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 20:03:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab3GGSCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 14:02:54 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:57195 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752856Ab3GGSCv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 14:02:51 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:34 +0200
Received: from hexa.v.cablecom.net (46.126.8.85) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.2.298.4; Sun, 7 Jul
 2013 20:02:47 +0200
X-Mailer: git-send-email 1.8.3.2.908.gbd0dbd0
In-Reply-To: <cover.1373219466.git.trast@inf.ethz.ch>
X-Originating-IP: [46.126.8.85]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229789>

o->call_depth has a double function: a nonzero call_depth means we
want to construct virtual merge bases, but it also means we want to
avoid touching the worktree.  Introduce a new flag o->no_worktree for
the latter.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
---
 merge-recursive.c | 38 +++++++++++++++++++++-----------------
 merge-recursive.h |  1 +
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0b9cafb..b93b762 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -407,10 +407,10 @@ static void record_df_conflict_files(struct merge_options *o,
 	int i;
 
 	/*
-	 * If we're merging merge-bases, we don't want to bother with
-	 * any working directory changes.
+	 * If we're working in-core only (e.g., merging merge-bases),
+	 * we don't want to bother with any working directory changes.
 	 */
-	if (o->call_depth)
+	if (o->no_worktree)
 		return;
 
 	/* Ensure D/F conflicts are adjacent in the entries list. */
@@ -723,7 +723,7 @@ static void update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
-	if (o->call_depth)
+	if (o->no_worktree)
 		update_wd = 0;
 
 	if (update_wd) {
@@ -930,7 +930,7 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			result.clean = merge_submodule(result.sha,
 						       one->path, one->sha1,
 						       a->sha1, b->sha1,
-						       !o->call_depth);
+						       !o->no_worktree);
 		} else if (S_ISLNK(a->mode)) {
 			hashcpy(result.sha, a->sha1);
 
@@ -1002,7 +1002,7 @@ static void handle_change_delete(struct merge_options *o,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
-	if (dir_in_way(path, !o->call_depth)) {
+	if (dir_in_way(path, !o->no_worktree)) {
 		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 	}
 
@@ -1127,10 +1127,10 @@ static void handle_file(struct merge_options *o,
 		char *add_name = unique_path(o, rename->path, other_branch);
 		update_file(o, 0, add->sha1, add->mode, add_name);
 
-		remove_file(o, 0, rename->path, 0);
+		remove_file(o, 0, rename->path, o->no_worktree);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
-		if (dir_in_way(rename->path, !o->call_depth)) {
+		if (dir_in_way(rename->path, !o->no_worktree)) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
@@ -1237,7 +1237,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		 * merge base just undo the renames; they can be detected
 		 * again later for the non-recursive merge.
 		 */
-		remove_file(o, 0, path, 0);
+		remove_file(o, 0, path, o->no_worktree);
 		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, a->path);
 		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, b->path);
 	} else {
@@ -1245,7 +1245,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		remove_file(o, 0, path, 0);
+		remove_file(o, 0, path, o->no_worktree);
 		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
 		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, new_path2);
 		free(new_path2);
@@ -1404,7 +1404,7 @@ static int process_renames(struct merge_options *o,
 			 * add-source case).
 			 */
 			remove_file(o, 1, ren1_src,
-				    renamed_stage == 2 || !was_tracked(ren1_src));
+				    o->no_worktree || renamed_stage == 2 || !was_tracked(ren1_src));
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
 			src_other.mode = ren1->src_entry->stages[other_stage].mode;
@@ -1600,7 +1600,7 @@ static int merge_content(struct merge_options *o,
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 
-		if (dir_in_way(path, !o->call_depth))
+		if (dir_in_way(path, !o->no_worktree))
 			df_conflict_remains = 1;
 	}
 	mfi = merge_file_special_markers(o, &one, &a, &b,
@@ -1620,7 +1620,7 @@ static int merge_content(struct merge_options *o,
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
 			add_cacheinfo(mfi.mode, mfi.sha, path,
-				      0, (!o->call_depth), 0);
+				      0, (!o->no_worktree), 0);
 			return mfi.clean;
 		}
 	} else
@@ -1721,7 +1721,7 @@ static int process_entry(struct merge_options *o,
 			if (a_sha)
 				output(o, 2, _("Removing %s"), path);
 			/* do not touch working file if it did not exist */
-			remove_file(o, 1, path, !a_sha);
+			remove_file(o, 1, path, o->no_worktree || !a_sha);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
@@ -1752,7 +1752,7 @@ static int process_entry(struct merge_options *o,
 			sha = b_sha;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path, !o->call_depth)) {
+		if (dir_in_way(path, !o->no_worktree)) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
@@ -1780,7 +1780,7 @@ static int process_entry(struct merge_options *o,
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
 		 */
-		remove_file(o, 1, path, !a_mode);
+		remove_file(o, 1, path, o->no_worktree || !a_mode);
 	} else
 		die(_("Fatal merge failure, shouldn't happen."));
 
@@ -1806,7 +1806,7 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o->call_depth, common, head, merge);
+	code = git_merge_trees(o->no_worktree, common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
@@ -1915,6 +1915,7 @@ int merge_recursive(struct merge_options *o,
 
 	for (iter = ca; iter; iter = iter->next) {
 		const char *saved_b1, *saved_b2;
+		unsigned saved_no_worktree;
 		o->call_depth++;
 		/*
 		 * When the merge fails, the result contains files
@@ -1924,6 +1925,8 @@ int merge_recursive(struct merge_options *o,
 		 * "conflicts" were already resolved.
 		 */
 		discard_cache();
+		saved_no_worktree = o->no_worktree;
+		o->no_worktree = 1;
 		saved_b1 = o->branch1;
 		saved_b2 = o->branch2;
 		o->branch1 = "Temporary merge branch 1";
@@ -1932,6 +1935,7 @@ int merge_recursive(struct merge_options *o,
 				NULL, &merged_common_ancestors);
 		o->branch1 = saved_b1;
 		o->branch2 = saved_b2;
+		o->no_worktree = saved_no_worktree;
 		o->call_depth--;
 
 		if (!merged_common_ancestors)
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e090a3..d8dd7a1 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -15,6 +15,7 @@ struct merge_options {
 	const char *subtree_shift;
 	unsigned buffer_output : 1;
 	unsigned renormalize : 1;
+	unsigned no_worktree : 1; /* do not touch worktree */
 	long xdl_opts;
 	int verbosity;
 	int diff_rename_limit;
-- 
1.8.3.2.908.gbd0dbd0
