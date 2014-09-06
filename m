From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH v3 2/8] merge-recursive: internal flag to avoid touching the worktree
Date: Sat,  6 Sep 2014 19:57:00 +0200
Message-ID: <5bd5960659d85943477d2a5fbca3dd5ccd0da686.1409860234.git.tr@thomasrast.ch>
References: <cover.1409860234.git.tr@thomasrast.ch>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 06 19:57:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQKEt-0005gm-63
	for gcvg-git-2@plane.gmane.org; Sat, 06 Sep 2014 19:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752003AbaIFR50 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Sep 2014 13:57:26 -0400
Received: from ip1.thgersdorf.net ([148.251.9.194]:40772 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756AbaIFR5Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Sep 2014 13:57:25 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id BCDF54D65CD;
	Sat,  6 Sep 2014 19:57:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id mLHiney6KkTr; Sat,  6 Sep 2014 19:57:10 +0200 (CEST)
Received: from linux.local (unknown [65.50.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 67C494D6686;
	Sat,  6 Sep 2014 19:57:09 +0200 (CEST)
X-Mailer: git-send-email 2.1.0.72.g9b94086
In-Reply-To: <cover.1409860234.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256592>

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
index 4459607..059ad03 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -410,10 +410,10 @@ static void record_df_conflict_files(struct merge_options *o,
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
@@ -743,7 +743,7 @@ static void update_file_flags(struct merge_options *o,
 			      int update_cache,
 			      int update_wd)
 {
-	if (o->call_depth)
+	if (o->call_depth || o->no_worktree)
 		update_wd = 0;
 
 	if (update_wd) {
@@ -950,7 +950,8 @@ static struct merge_file_info merge_file_1(struct merge_options *o,
 			result.clean = merge_submodule(result.sha,
 						       one->path, one->sha1,
 						       a->sha1, b->sha1,
-						       !o->call_depth);
+						       !(o->call_depth ||
+							 o->no_worktree));
 		} else if (S_ISLNK(a->mode)) {
 			hashcpy(result.sha, a->sha1);
 
@@ -1018,7 +1019,7 @@ static void handle_change_delete(struct merge_options *o,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
-	if (dir_in_way(path, !o->call_depth)) {
+	if (dir_in_way(path, !(o->call_depth || o->no_worktree))) {
 		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 	}
 
@@ -1143,10 +1144,10 @@ static void handle_file(struct merge_options *o,
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
@@ -1253,7 +1254,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		 * merge base just undo the renames; they can be detected
 		 * again later for the non-recursive merge.
 		 */
-		remove_file(o, 0, path, 0);
+		remove_file(o, 0, path, o->call_depth || o->no_worktree);
 		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, a->path);
 		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, b->path);
 	} else {
@@ -1261,7 +1262,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
-		remove_file(o, 0, path, 0);
+		remove_file(o, 0, path, o->call_depth || o->no_worktree);
 		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
 		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, new_path2);
 		free(new_path2);
@@ -1420,6 +1421,7 @@ static int process_renames(struct merge_options *o,
 			 * add-source case).
 			 */
 			remove_file(o, 1, ren1_src,
+				    o->call_depth || o->no_worktree ||
 				    renamed_stage == 2 || !was_tracked(ren1_src));
 
 			hashcpy(src_other.sha1, ren1->src_entry->stages[other_stage].sha);
@@ -1616,7 +1618,7 @@ static int merge_content(struct merge_options *o,
 			 o->branch2 == rename_conflict_info->branch1) ?
 			pair1->two->path : pair1->one->path;
 
-		if (dir_in_way(path, !o->call_depth))
+		if (dir_in_way(path, !(o->call_depth || o->no_worktree)))
 			df_conflict_remains = 1;
 	}
 	mfi = merge_file_special_markers(o, &one, &a, &b,
@@ -1636,7 +1638,7 @@ static int merge_content(struct merge_options *o,
 		path_renamed_outside_HEAD = !path2 || !strcmp(path, path2);
 		if (!path_renamed_outside_HEAD) {
 			add_cacheinfo(mfi.mode, mfi.sha, path,
-				      0, (!o->call_depth), 0);
+				      0, !(o->call_depth || o->no_worktree), 0);
 			return mfi.clean;
 		}
 	} else
@@ -1737,7 +1739,8 @@ static int process_entry(struct merge_options *o,
 			if (a_sha)
 				output(o, 2, _("Removing %s"), path);
 			/* do not touch working file if it did not exist */
-			remove_file(o, 1, path, !a_sha);
+			remove_file(o, 1, path,
+				    o->call_depth || o->no_worktree || !a_sha);
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
@@ -1768,7 +1771,7 @@ static int process_entry(struct merge_options *o,
 			sha = b_sha;
 			conf = _("directory/file");
 		}
-		if (dir_in_way(path, !o->call_depth)) {
+		if (dir_in_way(path, !(o->call_depth || o->no_worktree))) {
 			char *new_path = unique_path(o, path, add_branch);
 			clean_merge = 0;
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
@@ -1796,7 +1799,8 @@ static int process_entry(struct merge_options *o,
 		 * this entry was deleted altogether. a_mode == 0 means
 		 * we had that path and want to actively remove it.
 		 */
-		remove_file(o, 1, path, !a_mode);
+		remove_file(o, 1, path,
+			    o->call_depth || o->no_worktree || !a_mode);
 	} else
 		die(_("Fatal merge failure, shouldn't happen."));
 
@@ -1822,7 +1826,8 @@ int merge_trees(struct merge_options *o,
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
2.1.0.72.g9b94086
