Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 65C892023C
	for <e@80x24.org>; Tue,  5 Jul 2016 11:24:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932907AbcGELYK (ORCPT <rfc822;e@80x24.org>);
	Tue, 5 Jul 2016 07:24:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:53957 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932694AbcGELYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2016 07:24:01 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MfVU3-1avPrC3caZ-00P3Ay; Tue, 05 Jul 2016 13:23:50
 +0200
Date:	Tue, 5 Jul 2016 13:23:47 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH v2 09/17] merge-recursive: handle return values indicating
 errors
In-Reply-To: <cover.1467717729.git.johannes.schindelin@gmx.de>
Message-ID: <aff644a7766787d3538eeec55b8165004403f860.1467717730.git.johannes.schindelin@gmx.de>
References: <cover.1467199553.git.johannes.schindelin@gmx.de> <cover.1467717729.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:ndMOizjbmc8EanFYvl25n9eV+uEeTn6LDRXxeNxpH16WGuiZA98
 UEHrp8VivVbwnki8xk+dbo++iTcgzKkOflcCdGbJ9Zlg7tH3X1j094ffljcl8nBxWCXa1qg
 ePeyve9t+yMR9aN75UhEu5wK5NX2WEnMxbrTiGIRUSSdgkrXahgevall83ZueXp8WLjr2fw
 W6sknYWwKKngsfLYkWE0Q==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:YQCbbV9kddQ=:RBO3fCrl7MPDtpdD913rNT
 uFwq+Ljo/QtrmC50gT+F7Enomi1AWa+jvkh1Vo8jQsmbn1+OQs1uxGkRAFVG9C8/VAjTD6vZX
 H4Pafc3/xIACjqPink6hXv263jNcDHP+ghqO2Ehi+4g66gzLggCJg5YtVNb0tQxO3sxOseJR8
 6/6/sgQmmIvDsTWOtIhlBhnH33bYiKhTvav9u+vP9LHhgXRQvZBHNKNpliQjKPE6n3ERvLLGs
 9UJ9Xxq55x8heA2DRXQz3JZDuuouSeO415cQ2DcMoOW1HBpgKvUCmEFfHxIPJV9l8b29luvaJ
 O2Vlr8/AOCUz+AZHQG9x+TVt7Zby3BLu4DIwx+V2i132TyVqrSCuyjDVAZoTS8u+/BdvalmEK
 kXDi1ZjNkTx4mIgELbd5+LH0LhW/GV5wBIGLtfgyWJgIdg4bk5KVMtHb1yB4qfYUuv9/jYx9H
 d8x8woD80bpN3kL8YzsSVu0y6BCWByZRkj7ubxtV84IY4apr55f8Cme8Qk1OliZAk8KL0OEh2
 paaUgOz0XSil36sMuKxQdDyOfTDjm/RUJ1w57hZDeGM7SFzdLwSZ/yuxfER2YLSUR5KZHD4pp
 JIcjOPKMN/V/lBRGHdUarOs9jlWPfC/2JaDgNR1YbBAO75H2eCWK31G4g2hrj9+N4VTRbReFy
 HpU5VHwC4Ce2sd8s2pxl5gCtJyMlzaCwnbDMcAOimj0psmz/eWh5/XtUufZXdvgW984lm9KdP
 uhGJ0kU9YgN3LcR7fQGwsMAyzZ5Rhl6NvVUIFtmqJ/xCPC6r/MauBgBir+iK/IBkMABwHIWDq
 4CknnUy
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

Note: while this patch makes the code slightly less readable in
update_file_flags() (we introduce a new "goto free_buf;" instead of
an explicit "free(buf); return;"), it is a preparatory change for
the next patch where we will convert all of the die() calls in the same
function to go through the free_buf return path instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 merge-recursive.c | 196 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 121 insertions(+), 75 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 99f4202..209427c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -734,7 +734,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	return error(msg, path, _(": perhaps a D/F conflict?"));
 }
 
-static void update_file_flags(struct merge_options *o,
+static int update_file_flags(struct merge_options *o,
 			      const unsigned char *sha,
 			      unsigned mode,
 			      const char *path,
@@ -775,8 +775,7 @@ static void update_file_flags(struct merge_options *o,
 
 		if (make_room_for_path(o, path) < 0) {
 			update_wd = 0;
-			free(buf);
-			goto update_index;
+			goto free_buf;
 		}
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
@@ -799,20 +798,22 @@ static void update_file_flags(struct merge_options *o,
 		} else
 			die(_("do not know what to do with %06o %s '%s'"),
 			    mode, sha1_to_hex(sha), path);
+ free_buf:
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
@@ -1008,7 +1009,7 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
-static void handle_change_delete(struct merge_options *o,
+static int handle_change_delete(struct merge_options *o,
 				 const char *path,
 				 const unsigned char *o_sha, int o_mode,
 				 const unsigned char *a_sha, int a_mode,
@@ -1016,6 +1017,7 @@ static void handle_change_delete(struct merge_options *o,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
+	int ret = 0;
 	if (dir_in_way(path, !o->call_depth)) {
 		renamed = unique_path(o, path, a_sha ? o->branch1 : o->branch2);
 	}
@@ -1026,21 +1028,23 @@ static void handle_change_delete(struct merge_options *o,
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
@@ -1053,7 +1057,7 @@ static void handle_change_delete(struct merge_options *o,
 			       "and %s in %s. Version %s of %s left in tree at %s."),
 			       change, path, o->branch2, change_past,
 			       o->branch1, o->branch1, path, renamed);
-			update_file(o, 0, a_sha, a_mode, renamed);
+			ret = update_file(o, 0, a_sha, a_mode, renamed);
 		}
 		/*
 		 * No need to call update_file() on path when !renamed, since
@@ -1063,9 +1067,11 @@ static void handle_change_delete(struct merge_options *o,
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
@@ -1085,21 +1091,19 @@ static void conflict_rename_delete(struct merge_options *o,
 		b_mode = dest->mode;
 	}
 
-	handle_change_delete(o,
+	if (handle_change_delete(o,
 			     o->call_depth ? orig->path : dest->path,
 			     orig->sha1, orig->mode,
 			     a_sha, a_mode,
 			     b_sha, b_mode,
-			     _("rename"), _("renamed"));
-
-	if (o->call_depth) {
-		remove_file_from_cache(dest->path);
-	} else {
-		update_stages(dest->path, NULL,
+			     _("rename"), _("renamed")))
+		return -1;
+	if (o->call_depth)
+		return remove_file_from_cache(dest->path);
+	else
+		return update_stages(dest->path, NULL,
 			      rename_branch == o->branch1 ? dest : NULL,
 			      rename_branch == o->branch1 ? NULL : dest);
-	}
-
 }
 
 static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
@@ -1115,7 +1119,7 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
-static void handle_file(struct merge_options *o,
+static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
 			int stage,
 			struct rename_conflict_info *ci)
@@ -1125,6 +1129,7 @@ static void handle_file(struct merge_options *o,
 	const char *cur_branch, *other_branch;
 	struct diff_filespec other;
 	struct diff_filespec *add;
+	int ret;
 
 	if (stage == 2) {
 		dst_entry = ci->dst_entry1;
@@ -1139,7 +1144,8 @@ static void handle_file(struct merge_options *o,
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
 		char *add_name = unique_path(o, rename->path, other_branch);
-		update_file(o, 0, add->sha1, add->mode, add_name);
+		if (update_file(o, 0, add->sha1, add->mode, add_name))
+			return -1;
 
 		remove_file(o, 0, rename->path, 0);
 		dst_name = unique_path(o, rename->path, cur_branch);
@@ -1150,17 +1156,20 @@ static void handle_file(struct merge_options *o,
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
@@ -1184,7 +1193,7 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 				 a->sha1, a->mode,
 				 b->sha1, b->mode,
 				 ci->branch1, ci->branch2, &mfi))
-			return;
+			return -1;
 
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
@@ -1192,7 +1201,8 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		update_file(o, 0, mfi.sha, mfi.mode, one->path);
+		if (update_file(o, 0, mfi.sha, mfi.mode, one->path))
+			return -1;
 
 		/*
 		 * Above, we put the merged content at the merge-base's
@@ -1203,22 +1213,26 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * resolving the conflict at that path in its favor.
 		 */
 		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
-		if (add)
-			update_file(o, 0, add->sha1, add->mode, a->path);
+		if (add) {
+			if (update_file(o, 0, add->sha1, add->mode, a->path))
+				return -1;
+		}
 		else
 			remove_file_from_cache(a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
-		if (add)
-			update_file(o, 0, add->sha1, add->mode, b->path);
+		if (add) {
+			if (update_file(o, 0, add->sha1, add->mode, b->path))
+				return -1;
+		}
 		else
 			remove_file_from_cache(b->path);
-	} else {
-		handle_file(o, a, 2, ci);
-		handle_file(o, b, 3, ci);
-	}
+	} else if (handle_file(o, a, 2, ci) || handle_file(o, b, 3, ci))
+		return -1;
+
+	return 0;
 }
 
-static void conflict_rename_rename_2to1(struct merge_options *o,
+static int conflict_rename_rename_2to1(struct merge_options *o,
 					struct rename_conflict_info *ci)
 {
 	/* Two files, a & b, were renamed to the same thing, c. */
@@ -1229,6 +1243,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	char *path = c1->path; /* == c2->path */
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
+	int ret;
 
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1245,7 +1260,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
 					    o->branch1, ci->ren2_other.path,
 					    o->branch2, c2->path, &mfi_c2))
-		return;
+		return -1;
 
 	if (o->call_depth) {
 		/*
@@ -1256,19 +1271,25 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
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
@@ -1451,12 +1472,13 @@ static int process_renames(struct merge_options *o,
 				 * update_file_flags() instead of
 				 * update_file().
 				 */
-				update_file_flags(o,
+				if (update_file_flags(o,
 						  ren1->pair->two->sha1,
 						  ren1->pair->two->mode,
 						  ren1_dst,
 						  1, /* update_cache */
-						  0  /* update_wd    */);
+						  0  /* update_wd    */))
+					clean_merge = -1;
 			} else if (!sha_eq(dst_other.sha1, null_sha1)) {
 				clean_merge = 0;
 				try_merge = 1;
@@ -1469,20 +1491,26 @@ static int process_renames(struct merge_options *o,
 					if (merge_file_one(o, ren1_dst, null_sha1, 0,
 							 ren1->pair->two->sha1, ren1->pair->two->mode,
 							 dst_other.sha1, dst_other.mode,
-							 branch1, branch2, &mfi))
-						return -1;
+							 branch1, branch2, &mfi)) {
+						clean_merge = -1;
+						goto cleanup_and_return;
+					}
 					output(o, 1, _("Adding merged %s"), ren1_dst);
-					update_file(o, 0, mfi.sha, mfi.mode, ren1_dst);
+					if (update_file(o, 0, mfi.sha, mfi.mode, ren1_dst))
+						clean_merge = -1;
 					try_merge = 0;
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
 					output(o, 1, _("Adding as %s instead"), new_path);
-					update_file(o, 0, dst_other.sha1, dst_other.mode, new_path);
+					if (update_file(o, 0, dst_other.sha1, dst_other.mode, new_path))
+						clean_merge = -1;
 					free(new_path);
 				}
 			} else
 				try_merge = 1;
 
+			if (clean_merge < 0)
+				goto cleanup_and_return;
 			if (try_merge) {
 				struct diff_filespec *one, *a, *b;
 				src_other.path = (char *)ren1_src;
@@ -1509,6 +1537,7 @@ static int process_renames(struct merge_options *o,
 			}
 		}
 	}
+cleanup_and_return:
 	string_list_clear(&a_by_dst, 0);
 	string_list_clear(&b_by_dst, 0);
 
@@ -1571,13 +1600,13 @@ error_return:
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
@@ -1656,7 +1685,8 @@ static int merge_content(struct merge_options *o,
 		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
-			update_stages(path, &one, &a, &b);
+			if (update_stages(path, &one, &a, &b))
+				return -1;
 	}
 
 	if (df_conflict_remains) {
@@ -1664,30 +1694,33 @@ static int merge_content(struct merge_options *o,
 		if (o->call_depth) {
 			remove_file_from_cache(path);
 		} else {
-			if (!mfi.clean)
-				update_stages(path, &one, &a, &b);
-			else {
+			if (!mfi.clean) {
+				if (update_stages(path, &one, &a, &b))
+					return -1;
+			} else {
 				int file_from_stage2 = was_tracked(path);
 				struct diff_filespec merged;
 				hashcpy(merged.sha1, mfi.sha);
 				merged.mode = mfi.mode;
 
-				update_stages(path, NULL,
+				if (update_stages(path, NULL,
 					      file_from_stage2 ? &merged : NULL,
-					      file_from_stage2 ? NULL : &merged);
+					      file_from_stage2 ? NULL : &merged))
+					return -1;
 			}
 
 		}
 		new_path = unique_path(o, path, rename_conflict_info->branch1);
 		output(o, 1, _("Adding as %s instead"), new_path);
-		update_file(o, 0, mfi.sha, mfi.mode, new_path);
+		if (update_file(o, 0, mfi.sha, mfi.mode, new_path)) {
+			free(new_path);
+			return -1;
+		}
 		free(new_path);
 		mfi.clean = 0;
-	} else {
-		update_file(o, mfi.clean, mfi.sha, mfi.mode, path);
-	}
+	} else if (update_file(o, mfi.clean, mfi.sha, mfi.mode, path))
+		return -1;
 	return mfi.clean;
-
 }
 
 /* Per entry merge function */
@@ -1715,17 +1748,21 @@ static int process_entry(struct merge_options *o,
 			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
-			conflict_rename_delete(o, conflict_info->pair1,
+			if (conflict_rename_delete(o,
+					       conflict_info->pair1,
 					       conflict_info->branch1,
-					       conflict_info->branch2);
+					       conflict_info->branch2))
+				clean_merge = -1;
 			break;
 		case RENAME_ONE_FILE_TO_TWO:
 			clean_merge = 0;
-			conflict_rename_rename_1to2(o, conflict_info);
+			if (conflict_rename_rename_1to2(o, conflict_info))
+				clean_merge = -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
 			clean_merge = 0;
-			conflict_rename_rename_2to1(o, conflict_info);
+			if (conflict_rename_rename_2to1(o, conflict_info))
+				clean_merge = -1;
 			break;
 		default:
 			entry->processed = 0;
@@ -1745,8 +1782,9 @@ static int process_entry(struct merge_options *o,
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			handle_modify_delete(o, path, o_sha, o_mode,
-					     a_sha, a_mode, b_sha, b_mode);
+			if (handle_modify_delete(o, path, o_sha, o_mode,
+						 a_sha, a_mode, b_sha, b_mode))
+				clean_merge = -1;
 		}
 	} else if ((!o_sha && a_sha && !b_sha) ||
 		   (!o_sha && !a_sha && b_sha)) {
@@ -1778,14 +1816,16 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			update_file(o, 0, sha, mode, new_path);
-			if (o->call_depth)
+			if (update_file(o, 0, sha, mode, new_path))
+				clean_merge = -1;
+			else if (o->call_depth)
 				remove_file_from_cache(path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
 			/* do not overwrite file if already present */
-			update_file_flags(o, sha, mode, path, 1, !a_sha);
+			if (update_file_flags(o, sha, mode, path, 1, !a_sha))
+				clean_merge = -1;
 		}
 	} else if (a_sha && b_sha) {
 		/* Case C: Added in both (check for same permissions) and */
@@ -1848,12 +1888,18 @@ int merge_trees(struct merge_options *o,
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
2.9.0.280.g32e2a70


