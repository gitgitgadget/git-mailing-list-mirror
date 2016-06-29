Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B55341FE4E
	for <e@80x24.org>; Wed, 29 Jun 2016 11:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752346AbcF2LhM (ORCPT <rfc822;e@80x24.org>);
	Wed, 29 Jun 2016 07:37:12 -0400
Received: from mout.gmx.net ([212.227.17.22]:49606 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752299AbcF2LhJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jun 2016 07:37:09 -0400
Received: from virtualbox ([37.24.143.100]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LbPza-1bk6Ul0bTG-00kwFF; Wed, 29 Jun 2016 13:37:05
 +0200
Date:	Wed, 29 Jun 2016 13:37:04 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] merge-recursive: handle return values indicating
 errors
In-Reply-To: <cover.1467199553.git.johannes.schindelin@gmx.de>
Message-ID: <4f2817208cf2f7d4e839ddb6818bf652b0aa633c.1467199553.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:Qgf24O6DFj0PK5BcOtoCLjA6LBFTytaJjRSEOePHbSOTgYUXllN
 YYvtDOldkYgPcTbHyDTporGrjmXH8bj0haEMUSXmohE9fxQW/Ar2NOEg3WZ2Uf4Pz5e0b+y
 gK6/LKmcV3yGiPDjVwJKx+k/JMarZvcTRf2kv80xdJ5ZN4r9xG2Ki5KKg1Y6JS/QlwGiTYC
 qgEcjxu6S+/oRyctLeddQ==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:Yj7MqEpmQ6U=:jUxT2QVKb4lzUIkp+8igl/
 SSFOpMAtF/tymT+SbcHWnA1hefNdRL5+Elfw56I5gtSU7ndlc7FGo9SAbxAVwkOmURArQx1bi
 7itQ4TW96SCy6wxsWuPu6FLUAeoQ9lRWnKQxDJGXIct6KO6hR1w3eKTaEAWw/ui0VKEP24hXY
 lp0/LRk4Z7JWosfvuJlYzzbBMG+gxUDi1NPC1jU5FTbCqrzH/Qq6VQkFfGOi+2h3b8dzFqPmw
 0J7ZrBTrpEjoSzTWpWdK2z57vJgdVsRBzMZievJ9+z95N7gprPx5tgeUp47iju+zbWqiVZtEe
 r6t/PtogRFU4onY10fgs5aImaR8gEhKBrajv3r4cDUIS/BPqFZZvVqo+3K+03f/iWWowTuR1P
 KJoQ9fAITuCVqzyqKZ2TFSpfa481OFkywccD19LbKPNSCRthMI9t5ElTVhunk7PaARk/xuO3x
 xMCpqJ366Vy6IGmpWtyD2aZZJ7e6tSOC9mHZWdWsHZrd5tQO6DjknQQ8G+C39Cj0DvTpx2gKp
 VjydaUUIJyTXbXLnHp02e96o+XO3m99Fw4vCMsFh/RcomnP+nozJkX40uQ7afZdSjPR63OuLn
 xNQMoLko8DPJXgUtYFHKvXx1ASnB/e5DaP95Gp1f1Jk6gxSFhNe5QdcA+IqNb2t8jHZHizjAp
 0FQQArB0BvMXut/2vkXpbucHBvOqv1E8P2cb/+0AuXddUb1Tmn5tds0UY1GYbIOvImF4oExwN
 jXRRCUH0+b040m7pDlR6J5R2A8+7X6HvB0p7fRd2lzyhBX6Pcxp9aL1IH6qI8RyDn0IxgO2QJ
 tJUkNCB
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We are about to libify the recursive merge machinery, where we only
die() in case of a bug or memory contention. To that end, we must heed
negative return values as indicating errors.

This requires our functions to be careful to pass through error
conditions in call chains, and for quite a few functions this means
that they have to return values to begin with.

The next step will be to convert the places where we currently die() to
return negative values (read: -1) instead.

Note that we ignore errors reported by make_room_for_path(), consistent
with the previous behavior (update_file_flags() used the return value of
make_room_for_path() only to indicate an early return, but not a fatal
error): if the error is really a fatal error, we will notice later; If
not, it was not that serious a problem to begin with. (Witnesses in
favor of this reasoning are t4151-am-abort and t7610-mergetool, which
would start failing if we stopped on errors reported by
make_room_for_path()).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 251 ++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 158 insertions(+), 93 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 6ab7dfc..bb075e3 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -266,8 +266,10 @@ struct tree *write_tree_from_memory(struct merge_options *o)
 		active_cache_tree = cache_tree();
 
 	if (!cache_tree_fully_valid(active_cache_tree) &&
-	    cache_tree_update(&the_index, 0) < 0)
-		die(_("error building trees"));
+	    cache_tree_update(&the_index, 0) < 0) {
+		error(_("error building trees"));
+		return NULL;
+	}
 
 	result = lookup_tree(active_cache_tree->sha1);
 
@@ -548,19 +550,17 @@ static int update_stages(const char *path, const struct diff_filespec *o,
 	 */
 	int clear = 1;
 	int options = ADD_CACHE_OK_TO_ADD | ADD_CACHE_SKIP_DFCHECK;
+	int ret = 0;
+
 	if (clear)
-		if (remove_file_from_cache(path))
-			return -1;
-	if (o)
-		if (add_cacheinfo(o->mode, o->sha1, path, 1, 0, options))
-			return -1;
-	if (a)
-		if (add_cacheinfo(a->mode, a->sha1, path, 2, 0, options))
-			return -1;
-	if (b)
-		if (add_cacheinfo(b->mode, b->sha1, path, 3, 0, options))
-			return -1;
-	return 0;
+		ret = remove_file_from_cache(path);
+	if (!ret && o)
+		ret = add_cacheinfo(o->mode, o->sha1, path, 1, 0, options);
+	if (!ret && a)
+		ret = add_cacheinfo(a->mode, a->sha1, path, 2, 0, options);
+	if (!ret && b)
+		ret = add_cacheinfo(b->mode, b->sha1, path, 3, 0, options);
+	return ret;
 }
 
 static void update_entry(struct stage_data *entry,
@@ -736,7 +736,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	return error(msg, path, _(": perhaps a D/F conflict?"));
 }
 
-static void update_file_flags(struct merge_options *o,
+static int update_file_flags(struct merge_options *o,
 			      const unsigned char *sha,
 			      unsigned mode,
 			      const char *path,
@@ -777,8 +777,7 @@ static void update_file_flags(struct merge_options *o,
 
 		if (make_room_for_path(o, path) < 0) {
 			update_wd = 0;
-			free(buf);
-			goto update_index;
+			goto free_buf;
 		}
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
@@ -801,20 +800,22 @@ static void update_file_flags(struct merge_options *o,
 		} else
 			die(_("do not know what to do with %06o %s '%s'"),
 			    mode, sha1_to_hex(sha), path);
+free_buf:
 		free(buf);
 	}
  update_index:
 	if (update_cache)
 		add_cacheinfo(mode, sha, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+	return 0;
 }
 
-static void update_file(struct merge_options *o,
+static int update_file(struct merge_options *o,
 			int clean,
 			const unsigned char *sha,
 			unsigned mode,
 			const char *path)
 {
-	update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->call_depth);
+	return update_file_flags(o, sha, mode, path, o->call_depth || clean, !o->call_depth);
 }
 
 /* Low level file merging, update and removal */
@@ -1010,7 +1011,7 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
-static void handle_change_delete(struct merge_options *o,
+static int handle_change_delete(struct merge_options *o,
 				 const char *path,
 				 const unsigned char *o_sha, int o_mode,
 				 const unsigned char *a_sha, int a_mode,
@@ -1018,6 +1019,7 @@ static void handle_change_delete(struct merge_options *o,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
+	int ret = 0;
 	if (dir_in_way(path, !o->call_depth)) {
 		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 	}
@@ -1028,21 +1030,23 @@ static void handle_change_delete(struct merge_options *o,
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		remove_file_from_cache(path);
-		update_file(o, 0, o_sha, o_mode, renamed ? renamed : path);
+		ret = remove_file_from_cache(path);
+		if (!ret)
+			ret = update_file(o, 0, o_sha, o_mode,
+					  renamed ? renamed : path);
 	} else if (!a_sha) {
 		if (!renamed) {
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree."),
 			       change, path, o->branch1, change_past,
 			       o->branch2, o->branch2, path);
-			update_file(o, 0, b_sha, b_mode, path);
+			ret = update_file(o, 0, b_sha, b_mode, path);
 		} else {
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree at %s."),
 			       change, path, o->branch1, change_past,
 			       o->branch2, o->branch2, path, renamed);
-			update_file(o, 0, b_sha, b_mode, renamed);
+			ret = update_file(o, 0, b_sha, b_mode, renamed);
 		}
 	} else {
 		if (!renamed) {
@@ -1055,7 +1059,7 @@ static void handle_change_delete(struct merge_options *o,
 			       "and %s in %s. Version %s of %s left in tree at %s."),
 			       change, path, o->branch2, change_past,
 			       o->branch1, o->branch1, path, renamed);
-			update_file(o, 0, a_sha, a_mode, renamed);
+			ret = update_file(o, 0, a_sha, a_mode, renamed);
 		}
 		/*
 		 * No need to call update_file() on path when !renamed, since
@@ -1065,9 +1069,11 @@ static void handle_change_delete(struct merge_options *o,
 		 */
 	}
 	free(renamed);
+
+	return ret;
 }
 
-static void conflict_rename_delete(struct merge_options *o,
+static int conflict_rename_delete(struct merge_options *o,
 				   struct diff_filepair *pair,
 				   const char *rename_branch,
 				   const char *other_branch)
@@ -1078,6 +1084,7 @@ static void conflict_rename_delete(struct merge_options *o,
 	const unsigned char *b_sha = NULL;
 	int a_mode = 0;
 	int b_mode = 0;
+	int ret = 0;
 
 	if (rename_branch == o->branch1) {
 		a_sha = dest->sha1;
@@ -1087,21 +1094,22 @@ static void conflict_rename_delete(struct merge_options *o,
 		b_mode = dest->mode;
 	}
 
-	handle_change_delete(o,
+	ret = handle_change_delete(o,
 			     o->call_depth ? orig->path : dest->path,
 			     orig->sha1, orig->mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
 			     _("rename"), _("renamed"));
-
-	if (o->call_depth) {
-		remove_file_from_cache(dest->path);
-	} else {
-		update_stages(dest->path, NULL,
+	if (ret < 0)
+		return ret;
+	if (o->call_depth)
+		ret = remove_file_from_cache(dest->path);
+	else
+		ret = update_stages(dest->path, NULL,
 			      rename_branch == o->branch1 ? dest : NULL,
 			      rename_branch == o->branch1 ? NULL : dest);
-	}
 
+	return ret;
 }
 
 static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
@@ -1117,7 +1125,7 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
-static void handle_file(struct merge_options *o,
+static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
 			int stage,
 			struct rename_conflict_info *ci)
@@ -1127,6 +1135,7 @@ static void handle_file(struct merge_options *o,
 	const char *cur_branch, *other_branch;
 	struct diff_filespec other;
 	struct diff_filespec *add;
+	int ret;
 
 	if (stage == 2) {
 		dst_entry = ci->dst_entry1;
@@ -1141,7 +1150,8 @@ static void handle_file(struct merge_options *o,
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
 		char *add_name = unique_path(o, rename->path, other_branch);
-		update_file(o, 0, add->sha1, add->mode, add_name);
+		if ((ret = update_file(o, 0, add->sha1, add->mode, add_name)))
+			return ret;
 
 		remove_file(o, 0, rename->path, 0);
 		dst_name = unique_path(o, rename->path, cur_branch);
@@ -1152,23 +1162,27 @@ static void handle_file(struct merge_options *o,
 			       rename->path, other_branch, dst_name);
 		}
 	}
-	update_file(o, 0, rename->sha1, rename->mode, dst_name);
-	if (stage == 2)
-		update_stages(rename->path, NULL, rename, add);
+	if ((ret = update_file(o, 0, rename->sha1, rename->mode, dst_name)))
+		; /* fall through, do allow dst_name to be released */
+	else if (stage == 2)
+		ret = update_stages(rename->path, NULL, rename, add);
 	else
-		update_stages(rename->path, NULL, add, rename);
+		ret = update_stages(rename->path, NULL, add, rename);
 
 	if (dst_name != rename->path)
 		free(dst_name);
+
+	return ret;
 }
 
-static void conflict_rename_rename_1to2(struct merge_options *o,
+static int conflict_rename_rename_1to2(struct merge_options *o,
 					struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
 	struct diff_filespec *one = ci->pair1->one;
 	struct diff_filespec *a = ci->pair1->two;
 	struct diff_filespec *b = ci->pair2->two;
+	int ret = 0;
 
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
@@ -1181,12 +1195,12 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		struct diff_filespec other;
 		struct diff_filespec *add;
 
-		if (merge_file_one(o, one->path,
+		if ((ret = merge_file_one(o, one->path,
 				 one->sha1, one->mode,
 				 a->sha1, a->mode,
 				 b->sha1, b->mode,
-				 ci->branch1, ci->branch2, &mfi) < 0)
-			return;
+				 ci->branch1, ci->branch2, &mfi)))
+			return ret;
 
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
@@ -1194,7 +1208,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		update_file(o, 0, mfi.sha, mfi.mode, one->path);
+		if ((ret = update_file(o, 0, mfi.sha, mfi.mode, one->path)))
+			return ret;
 
 		/*
 		 * Above, we put the merged content at the merge-base's
@@ -1205,22 +1220,31 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * resolving the conflict at that path in its favor.
 		 */
 		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
-		if (add)
-			update_file(o, 0, add->sha1, add->mode, a->path);
+		if (add) {
+			if ((ret = update_file(o, 0, add->sha1, add->mode,
+					a->path)))
+				return ret;
+		}
 		else
 			remove_file_from_cache(a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
-		if (add)
-			update_file(o, 0, add->sha1, add->mode, b->path);
+		if (add) {
+			if ((ret = update_file(o, 0, add->sha1, add->mode,
+					b->path)))
+				return ret;
+		}
 		else
 			remove_file_from_cache(b->path);
 	} else {
-		handle_file(o, a, 2, ci);
-		handle_file(o, b, 3, ci);
+		if ((ret = handle_file(o, a, 2, ci)) ||
+		    (ret = handle_file(o, b, 3, ci)))
+			return ret;
 	}
+
+	return ret;
 }
 
-static void conflict_rename_rename_2to1(struct merge_options *o,
+static int conflict_rename_rename_2to1(struct merge_options *o,
 					struct rename_conflict_info *ci)
 {
 	/* Two files, a & b, were renamed to the same thing, c. */
@@ -1231,6 +1255,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	char *path = c1->path; /* == c2->path */
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
+	int ret;
 
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1241,13 +1266,13 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
-	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
+	if ((ret = merge_file_special_markers(o, a, c1, &ci->ren1_other,
 					    o->branch1, c1->path,
-					    o->branch2, ci->ren1_other.path, &mfi_c1) < 0 ||
-	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
+					    o->branch2, ci->ren1_other.path, &mfi_c1)) ||
+	    (ret = merge_file_special_markers(o, b, &ci->ren2_other, c2,
 					    o->branch1, ci->ren2_other.path,
-					    o->branch2, c2->path, &mfi_c2) < 0)
-		return;
+					    o->branch2, c2->path, &mfi_c2)))
+		return ret;
 
 	if (o->call_depth) {
 		/*
@@ -1258,26 +1283,32 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		 * again later for the non-recursive merge.
 		 */
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, a->path);
-		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, b->path);
+		ret = update_file(o, 0, mfi_c1.sha, mfi_c1.mode, a->path);
+		if (!ret)
+			ret = update_file(o, 0, mfi_c2.sha, mfi_c2.mode,
+				b->path);
 	} else {
 		char *new_path1 = unique_path(o, path, ci->branch1);
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
-		update_file(o, 0, mfi_c2.sha, mfi_c2.mode, new_path2);
+		ret = update_file(o, 0, mfi_c1.sha, mfi_c1.mode, new_path1);
+		if (!ret)
+			ret = update_file(o, 0, mfi_c2.sha, mfi_c2.mode,
+				new_path2);
 		free(new_path2);
 		free(new_path1);
 	}
+
+	return ret;
 }
 
 static int process_renames(struct merge_options *o,
 			   struct string_list *a_renames,
 			   struct string_list *b_renames)
 {
-	int clean_merge = 1, i, j;
+	int clean_merge = 1, i, j, ret;
 	struct string_list a_by_dst = STRING_LIST_INIT_NODUP;
 	struct string_list b_by_dst = STRING_LIST_INIT_NODUP;
 	const struct rename *sre;
@@ -1453,12 +1484,14 @@ static int process_renames(struct merge_options *o,
 				 * update_file_flags() instead of
 				 * update_file().
 				 */
-				update_file_flags(o,
+				ret = update_file_flags(o,
 						  ren1->pair->two->sha1,
 						  ren1->pair->two->mode,
 						  ren1_dst,
 						  1, /* update_cache */
 						  0  /* update_wd    */);
+				if (ret)
+					clean_merge = ret;
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
 				clean_merge = 0;
 				try_merge = 1;
@@ -1468,23 +1501,29 @@ static int process_renames(struct merge_options *o,
 				       ren1_dst, branch2);
 				if (o->call_depth) {
 					struct merge_file_info mfi;
-					if (merge_file_one(o, ren1_dst, null_sha1, 0,
+					if ((ret = merge_file_one(o, ren1_dst, null_sha1, 0,
 							 ren1->pair->two->sha1, ren1->pair->two->mode,
 							 dst_other.sha1, dst_other.mode,
-							 branch1, branch2, &mfi) < 0)
-						return -1;
+							 branch1, branch2, &mfi))) {
+						clean_merge = ret;
+						goto cleanup_and_return;
+					}
 					output(o, 1, _("Adding merged %s"), ren1_dst);
-					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
+					if ((ret = update_file(o, 0, mfi.sha, mfi.mode, ren1_dst)))
+						clean_merge = ret;
 					try_merge = 0;
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
 					output(o, 1, _("Adding as %s instead"), new_path);
-					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
+					if ((ret = update_file(o, 0, dst_other.sha1, dst_other.mode, new_path)))
+						clean_merge = ret;
 					free(new_path);
 				}
 			} else
 				try_merge = 1;
 
+			if (clean_merge < 0)
+				goto cleanup_and_return;
 			if (try_merge) {
 				struct diff_filespec *one, *a, *b;
 				src_other.path = (char *)ren1_src;
@@ -1511,6 +1550,7 @@ static int process_renames(struct merge_options *o,
 			}
 		}
 	}
+cleanup_and_return:
 	string_list_clear(&a_by_dst, 0);
 	string_list_clear(&b_by_dst, 0);
 
@@ -1573,13 +1613,13 @@ error_return:
 	return ret;
 }
 
-static void handle_modify_delete(struct merge_options *o,
+static int handle_modify_delete(struct merge_options *o,
 				 const char *path,
 				 unsigned char *o_sha, int o_mode,
 				 unsigned char *a_sha, int a_mode,
 				 unsigned char *b_sha, int b_mode)
 {
-	handle_change_delete(o,
+	return handle_change_delete(o,
 			     path,
 			     o_sha, o_mode,
 			     a_sha, a_mode,
@@ -1599,6 +1639,7 @@ static int merge_content(struct merge_options *o,
 	struct merge_file_info mfi;
 	struct diff_filespec one, a, b;
 	unsigned df_conflict_remains = 0;
+	int ret;
 
 	if (!o_sha) {
 		reason = _("add/add");
@@ -1628,10 +1669,10 @@ static int merge_content(struct merge_options *o,
 		if (dir_in_way(path, !o->call_depth))
 			df_conflict_remains = 1;
 	}
-	if (merge_file_special_markers(o, &one, &a, &b,
+	if ((ret = merge_file_special_markers(o, &one, &a, &b,
 					 o->branch1, path1,
-					 o->branch2, path2, &mfi) < 0)
-		return -1;
+					 o->branch2, path2, &mfi)))
+		return ret;
 
 	if (mfi.clean && !df_conflict_remains &&
 	    sha_eq(mfi.sha, a_sha) && mfi.mode == a_mode) {
@@ -1658,7 +1699,8 @@ static int merge_content(struct merge_options *o,
 		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
-			update_stages(path, &one, &a, &b);
+			if ((ret = update_stages(path, &one, &a, &b)))
+				return ret;
 	}
 
 	if (df_conflict_remains) {
@@ -1666,27 +1708,33 @@ static int merge_content(struct merge_options *o,
 		if (o->call_depth) {
 			remove_file_from_cache(path);
 		} else {
-			if (!mfi.clean)
-				update_stages(path, &one, &a, &b);
-			else {
+			if (!mfi.clean) {
+				if ((ret = update_stages(path, &one, &a, &b)))
+					return ret;
+			} else {
 				int file_from_stage2 = was_tracked(path);
 				struct diff_filespec merged;
 				hashcpy(merged.sha1, mfi.sha);
 				merged.mode = mfi.mode;
 
-				update_stages(path, NULL,
+				if ((ret = update_stages(path, NULL,
 					      file_from_stage2 ? &merged : NULL,
-					      file_from_stage2 ? NULL : &merged);
+					      file_from_stage2 ? NULL : &merged)))
+					return ret;
 			}
 
 		}
 		new_path = unique_path(o, path, rename_conflict_info->branch1);
 		output(o, 1, _("Adding as %s instead"), new_path);
-		update_file(o, 0, mfi.sha, mfi.mode, new_path);
+		if ((ret = update_file(o, 0, mfi.sha, mfi.mode, new_path))) {
+			free(new_path);
+			return ret;
+		}
 		free(new_path);
 		mfi.clean = 0;
 	} else {
-		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
+		if ((ret = update_file(o, mfi.clean, mfi.sha, mfi.mode, path)))
+			return ret;
 	}
 	return mfi.clean;
 
@@ -1696,7 +1744,7 @@ static int merge_content(struct merge_options *o,
 static int process_entry(struct merge_options *o,
 			 const char *path, struct stage_data *entry)
 {
-	int clean_merge = 1;
+	int clean_merge = 1, ret;
 	int normalize = o->renormalize;
 	unsigned o_mode = entry->stages[1].mode;
 	unsigned a_mode = entry->stages[2].mode;
@@ -1717,17 +1765,23 @@ static int process_entry(struct merge_options *o,
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
-			conflict_rename_delete(o, conflict_info->pair1,
+			if ((ret = conflict_rename_delete(o,
+					       conflict_info->pair1,
 					       conflict_info->branch1,
-					       conflict_info->branch2);
+					       conflict_info->branch2)))
+				clean_merge = ret;
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			clean_merge = 0;
-			conflict_rename_rename_1to2(o, conflict_info);
+			if ((ret = conflict_rename_rename_1to2(o,
+					conflict_info)))
+				clean_merge = ret;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
 			clean_merge = 0;
-			conflict_rename_rename_2to1(o, conflict_info);
+			if ((ret = conflict_rename_rename_2to1(o,
+					conflict_info)))
+				clean_merge = ret;
 			break;
 		default:
 			entry->processed = 0;
@@ -1747,8 +1801,9 @@ static int process_entry(struct merge_options *o,
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			handle_modify_delete(o, path, o_sha, o_mode,
-					     a_sha, a_mode, b_sha, b_mode);
+			if ((ret = handle_modify_delete(o, path, o_sha, o_mode,
+					a_sha, a_mode, b_sha, b_mode)))
+				clean_merge = ret;
 		}
 	} else if ((!o_sha && a_sha && !b_sha) ||
 		   (!o_sha && !a_sha && b_sha)) {
@@ -1780,14 +1835,18 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			update_file(o, 0, sha, mode, new_path);
-			if (o->call_depth)
+			ret = update_file(o, 0, sha, mode, new_path);
+			if (ret)
+				clean_merge = ret;
+			else if (o->call_depth)
 				remove_file_from_cache(path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
 			/* do not overwrite file if already present */
-			update_file_flags(o, sha, mode, path, 1, !a_sha);
+			if ((ret = update_file_flags(o, sha, mode, path, 1,
+					!a_sha)))
+				clean_merge = ret;
 		}
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
@@ -1850,12 +1909,18 @@ int merge_trees(struct merge_options *o,
 		re_head  = get_renames(o, head, common, head, merge, entries);
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
+		if (clean < 0)
+			return clean;
 		for (i = entries->nr-1; 0 <= i; i--) {
 			const char *path = entries->items[i].string;
 			struct stage_data *e = entries->items[i].util;
-			if (!e->processed
-				&& !process_entry(o, path, e))
-				clean = 0;
+			if (!e->processed) {
+				int ret = process_entry(o, path, e);
+				if (!ret)
+					clean = 0;
+				else if (ret < 0)
+					return ret;
+			}
 		}
 		for (i = 0; i < entries->nr; i++) {
 			struct stage_data *e = entries->items[i].util;
-- 
2.9.0.268.gcabc8b0


