From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v2 2/8] merge-recursive: internal flag to avoid touching the worktree
Date: Sat, 22 Feb 2014 10:17:50 +0100
Message-ID: <4247dd8849480718f515a133d26fecbd2615bd40.1393059605.git.tr@thomasrast.ch>
References: <cover.1393059605.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>, Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 22 10:18:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WH8j0-0003Xh-Gd
	for gcvg-git-2@plane.gmane.org; Sat, 22 Feb 2014 10:18:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbaBVJSQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Feb 2014 04:18:16 -0500
Received: from ip1.thgersdorf.net ([148.251.9.194]:34859 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751534AbaBVJSL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Feb 2014 04:18:11 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 856C04D6590;
	Sat, 22 Feb 2014 10:18:10 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JQxnmH41dK19; Sat, 22 Feb 2014 10:18:00 +0100 (CET)
Received: from linux.local (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 79AD04D659D;
	Sat, 22 Feb 2014 10:17:59 +0100 (CET)
X-Mailer: git-send-email 1.9.0.313.g3d0a325
In-Reply-To: <cover.1393059605.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242516>

From: Thomas Rast <trast@inf.ethz.ch>

o->call_depth has a double function: a nonzero call_depth means we
want to construct virtual merge bases, but it also means we want to
avoid touching the worktree.  Introduce a new flag o->no_worktree to
trigger only the latter.

Signed-off-by: Thomas Rast <trast@inf.ethz.ch>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 37 +++++++++++++++++++++----------------
 merge-recursive.h |  1 +
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index c36dc79..35be144 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -408,10 +408,10 @@ static void record_df_conflict_files(struct merge_options *o,
 	int i;
 
 	/*
-	 * If we're merging merge-bases, we don't want to bother with
-	 * any working directory changes.
+	 * If we're working in-core only (e.g., merging merge-bases),
+	 * we don't want to bother with any working directory changes.
 	 */
-	if (o->call_depth)
+	if (o->call_depth || o->no_worktree)
 		return;
 
 	/* Ensure D/F conflicts are adjacent in the entries list. */
@@ -724,7 +724,7 @@ static void update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
-	if (o->call_depth)
+	if (o->call_depth || o->no_worktree)
 		update_wd = 0;
 
 	if (update_wd) {
@@ -931,7 +931,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			result.clean = merge_submodule(result.sha,
 						       one->path, one->sha1,
 						       a->sha1, b->sha1,
-						       !o->call_depth);
+						       !(o->call_depth ||
+							 o->no_worktree));
 		} else if (S_ISLNK(a->mode)) {
 			hashcpy(result.sha, a->sha1);
 
@@ -1003,7 +1004,7 @@ static void handle_change_delete(struct merge_options *o,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
-	if (dir_in_way(path, !o->call_depth)) {
+	if (dir_in_way(path, !(o->call_depth || o->no_worktree))) {
 		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 	}
 
@@ -1128,10 +1129,10 @@ static void handle_file(struct merge_options *o,
 		char *add_name = unique_path(o, rename->path, other_branch);
 		update_file(o, 0, add->sha1, add->mode, add_name);
 
-		remove_file(o, 0, rename->path, 0);
+		remove_file(o, 0, rename->path, o->call_depth || o->no_worktree);
 		dst_name = unique_path(o, rename->path, cur_branch);
 	} else {
-		if (dir_in_way(rename->path, !o->call_depth)) {
+		if (dir_in_way(rename->path, !(o->call_depth || o->no_worktree))) {
 			dst_name = unique_path(o, rename->path, cur_branch);
 			output(o, 1, _("%s is a directory in %s adding as %s instead"),
 			       rename->path, other_branch, dst_name);
@@ -1238,7 +1239,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		 * merge base just undo the renames; they can be detected
 		 * again later for the non-recursive merge.
 		 */
-		remove_file(o, 0, path, 0);
+		remove_file(o, 0, path, o->call_depth || o->no_worktree);
 		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, a->path);
 		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, b->path);
 	} else {
@@ -1246,7 +1247,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		remove_file(o, 0, path, 0);
+		remove_file(o, 0, path, o->call_depth || o->no_worktree);
 		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
 		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, new_path2);
 		free(new_path2);
@@ -1405,6 +1406,7 @@ static int process_renames(struct merge_options *o,
 			 * add-source case).
 			 */
 			remove_file(o, 1, ren1_src,
+				    o->call_depth || o->no_worktree ||
 				    renamed_stage == 2 || !was_tracked(ren1_src));
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
@@ -1601,7 +1603,7 @@ static int merge_content(struct merge_options *o,
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 
-		if (dir_in_way(path, !o->call_depth))
+		if (dir_in_way(path, !(o->call_depth || o->no_worktree)))
 			df_conflict_remains = 1;
 	}
 	mfi = merge_file_special_markers(o, &one, &a, &b,
@@ -1621,7 +1623,7 @@ static int merge_content(struct merge_options *o,
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
 			add_cacheinfo(mfi.mode, mfi.sha, path,
-				      0, (!o->call_depth), 0);
+				      0, !(o->call_depth || o->no_worktree), 0);
 			return mfi.clean;
 		}
 	} else
@@ -1722,7 +1724,8 @@ static int process_entry(struct merge_options *o,
 			if (a_sha)
 				output(o, 2, _("Removing %s"), path);
 			/* do not touch working file if it did not exist */
-			remove_file(o, 1, path, !a_sha);
+			remove_file(o, 1, path,
+				    o->call_depth || o->no_worktree || !a_sha);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
@@ -1753,7 +1756,7 @@ static int process_entry(struct merge_options *o,
 			sha = b_sha;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path, !o->call_depth)) {
+		if (dir_in_way(path, !(o->call_depth || o->no_worktree))) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
@@ -1781,7 +1784,8 @@ static int process_entry(struct merge_options *o,
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
 		 */
-		remove_file(o, 1, path, !a_mode);
+		remove_file(o, 1, path,
+			    o->call_depth || o->no_worktree || !a_mode);
 	} else
 		die(_("Fatal merge failure, shouldn't happen."));
 
@@ -1807,7 +1811,8 @@ int merge_trees(struct merge_options *o,
 		return 1;
 	}
 
-	code = git_merge_trees(o->call_depth, common, head, merge);
+	code = git_merge_trees(o->call_depth || o->no_worktree,
+			       common, head, merge);
 
 	if (code != 0) {
 		if (show(o, 4) || o->call_depth)
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
1.9.0.313.g3d0a325
