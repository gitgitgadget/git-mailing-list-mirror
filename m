Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BFD8B2070F
	for <e@80x24.org>; Thu,  7 Jul 2016 14:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752678AbcGGOgG (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 10:36:06 -0400
Received: from mout.gmx.net ([212.227.15.15]:56561 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752655AbcGGOgB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 10:36:01 -0400
Received: from virtualbox ([37.24.141.253]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MhRUQ-1ayZJl0q6E-00McLS; Thu, 07 Jul 2016 16:35:51
 +0200
Date:	Thu, 7 Jul 2016 16:35:50 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>
Subject: [PATCH v3 09/16] merge-recursive: handle return values indicating
 errors
In-Reply-To: <cover.1467902082.git.johannes.schindelin@gmx.de>
Message-ID: <0561daa9da77b6ee0fcfabc0fa8a7c77e511f1e5.1467902083.git.johannes.schindelin@gmx.de>
References: <cover.1467717729.git.johannes.schindelin@gmx.de> <cover.1467902082.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:+FhDdO9q7Sa01Q9gTa1cTHEBWlw18AiqdXhINafYSbjo8QPO+1W
 tk1LHmUcN3ayMwaUojebOqOnFhoqHvyUXPXrvPPKx9+40mc0lAPm3sAqsIRa4fj6c+pv+22
 8XUlukzmgln9Kfvuv33EBtVZ466i/uTRMKwllVbnTwq8qp1NYeLI7GXN3gjjtX0VqN/dTWp
 py9e1lYrgkCwqZJ6LcLsg==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:X65fWuVvB3E=:zRU4/cCSuf5nz+RpmP8WhO
 aVXQtpoQJfAczCZmSaeymsUirY7/ZLIoZ+ijPwGOsUA8clCgA1tRcNSfLPQu4TkbRj9maurz7
 JVzBQiE/PFN7pOd2+CkHRhNnETMv1qXXsmfeQmmDJ95pZEHevm0WbjGqe2VwmLlZPDH+DR0DA
 qw/RBkVX0XBcae8JV069RTJrClkt2h9Cbh3hwCg4Nux9GkrUX08F1pvn4xyTRgOcYCrk7BdaQ
 6RkXS1pMNWkgL4ps++5MAcuongMzuOopam0UNAHcvWXBuC1IGfWPYOTdvlXoKBXDV08Vl+Rsn
 7LGKzxmReDpH+6o5xmQNvl3RVbr9yCOTwUnJihxFv9G1wYfcpmOFXOHf6VADZak9ai+bFmpq6
 t7JHZKXPuVVTI0NigR3+e29LomYpAp14HyDTYV+1FUca/jhMQ3E1vI2JHws+dXGAFotx+uOEY
 ZFwZBlehRJOJj/H8UljzAKzbiDFu1c3B+eCIMhI4ZBWWlgdxm4szL8grP2II6w44++w7GaB9d
 vkzWNlF5cIuO0YNf24Vo7i64peu8UfCOJ7i6DlUbaGwnhnJC38KR5rXAXUoyvFWAdmtGk5SGR
 H2eYHTu2E8PfQ3RYi0XHtZRu7qsTdTVU9ZcRlPuRkJZmc4eToS8zOPL58i09Jv5kJBgqUgyPF
 dfU11zmq5pjRm6WnAUL3G1lxeYvHlsC7wXidX+brYujDypvyeaLj3oGl1tZHaJ4OI9uQXzjM1
 HJbMlPOOfdHUSOciqK2j5mExNT/lpHumImh0R79jXbBxhnpvGwsebBgc1/jylP75984xY6OTa
 kO/gykA
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
 merge-recursive.c | 199 +++++++++++++++++++++++++++++++++---------------------
 1 file changed, 123 insertions(+), 76 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 09f4e27..89eb937 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -733,7 +733,7 @@ static int make_room_for_path(struct merge_options *o, const char *path)
 	return error(msg, path, _(": perhaps a D/F conflict?"));
 }
 
-static void update_file_flags(struct merge_options *o,
+static int update_file_flags(struct merge_options *o,
 			      const struct object_id *oid,
 			      unsigned mode,
 			      const char *path,
@@ -766,8 +766,7 @@ static void update_file_flags(struct merge_options *o,
 
 		if (make_room_for_path(o, path) < 0) {
 			update_wd = 0;
-			free(buf);
-			goto update_index;
+			goto free_buf;
 		}
 		if (S_ISREG(mode) || (!has_symlinks && S_ISLNK(mode))) {
 			int fd;
@@ -823,20 +822,22 @@ static void update_file_flags(struct merge_options *o,
 		} else
 			die(_("do not know what to do with %06o %s '%s'"),
 			    mode, oid_to_hex(oid), path);
+ free_buf:
 		free(buf);
 	}
  update_index:
 	if (update_cache)
 		add_cacheinfo(mode, oid, path, 0, update_wd, ADD_CACHE_OK_TO_ADD);
+	return 0;
 }
 
-static void update_file(struct merge_options *o,
+static int update_file(struct merge_options *o,
 			int clean,
 			const struct object_id *oid,
 			unsigned mode,
 			const char *path)
 {
-	update_file_flags(o, oid, mode, path, o->call_depth || clean, !o->call_depth);
+	return update_file_flags(o, oid, mode, path, o->call_depth || clean, !o->call_depth);
 }
 
 /* Low level file merging, update and removal */
@@ -1034,7 +1035,7 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
 }
 
-static void handle_change_delete(struct merge_options *o,
+static int handle_change_delete(struct merge_options *o,
 				 const char *path,
 				 const struct object_id *o_oid, int o_mode,
 				 const struct object_id *a_oid, int a_mode,
@@ -1042,6 +1043,7 @@ static void handle_change_delete(struct merge_options *o,
 				 const char *change, const char *change_past)
 {
 	char *renamed = NULL;
+	int ret = 0;
 	if (dir_in_way(path, !o->call_depth)) {
 		renamed = unique_path(o, path, a_oid ? o->branch1 : o->branch2);
 	}
@@ -1052,21 +1054,22 @@ static void handle_change_delete(struct merge_options *o,
 		 * correct; since there is no true "middle point" between
 		 * them, simply reuse the base version for virtual merge base.
 		 */
-		remove_file_from_cache(path);
-		update_file(o, 0, o_oid, o_mode, renamed ? renamed : path);
+		ret = remove_file_from_cache(path);
+		if (!ret)
+			ret = update_file(o, 0, o_oid, o_mode, renamed ? renamed : path);
 	} else if (!a_oid) {
 		if (!renamed) {
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree."),
 			       change, path, o->branch1, change_past,
 			       o->branch2, o->branch2, path);
-			update_file(o, 0, b_oid, b_mode, path);
+			ret = update_file(o, 0, b_oid, b_mode, path);
 		} else {
 			output(o, 1, _("CONFLICT (%s/delete): %s deleted in %s "
 			       "and %s in %s. Version %s of %s left in tree at %s."),
 			       change, path, o->branch1, change_past,
 			       o->branch2, o->branch2, path, renamed);
-			update_file(o, 0, b_oid, b_mode, renamed);
+			ret = update_file(o, 0, b_oid, b_mode, renamed);
 		}
 	} else {
 		if (!renamed) {
@@ -1079,7 +1082,7 @@ static void handle_change_delete(struct merge_options *o,
 			       "and %s in %s. Version %s of %s left in tree at %s."),
 			       change, path, o->branch2, change_past,
 			       o->branch1, o->branch1, path, renamed);
-			update_file(o, 0, a_oid, a_mode, renamed);
+			ret = update_file(o, 0, a_oid, a_mode, renamed);
 		}
 		/*
 		 * No need to call update_file() on path when !renamed, since
@@ -1089,9 +1092,11 @@ static void handle_change_delete(struct merge_options *o,
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
@@ -1111,21 +1116,20 @@ static void conflict_rename_delete(struct merge_options *o,
 		b_mode = dest->mode;
 	}
 
-	handle_change_delete(o,
+	if (handle_change_delete(o,
 			     o->call_depth ? orig->path : dest->path,
 			     &orig->oid, orig->mode,
 			     a_oid, a_mode,
 			     b_oid, b_mode,
-			     _("rename"), _("renamed"));
+			     _("rename"), _("renamed")))
+		return -1;
 
-	if (o->call_depth) {
-		remove_file_from_cache(dest->path);
-	} else {
-		update_stages(dest->path, NULL,
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
@@ -1141,7 +1145,7 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
-static void handle_file(struct merge_options *o,
+static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
 			int stage,
 			struct rename_conflict_info *ci)
@@ -1151,6 +1155,7 @@ static void handle_file(struct merge_options *o,
 	const char *cur_branch, *other_branch;
 	struct diff_filespec other;
 	struct diff_filespec *add;
+	int ret;
 
 	if (stage == 2) {
 		dst_entry = ci->dst_entry1;
@@ -1165,7 +1170,8 @@ static void handle_file(struct merge_options *o,
 	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
 	if (add) {
 		char *add_name = unique_path(o, rename->path, other_branch);
-		update_file(o, 0, &add->oid, add->mode, add_name);
+		if (update_file(o, 0, &add->oid, add->mode, add_name))
+			return -1;
 
 		remove_file(o, 0, rename->path, 0);
 		dst_name = unique_path(o, rename->path, cur_branch);
@@ -1176,17 +1182,20 @@ static void handle_file(struct merge_options *o,
 			       rename->path, other_branch, dst_name);
 		}
 	}
-	update_file(o, 0, &rename->oid, rename->mode, dst_name);
-	if (stage == 2)
-		update_stages(rename->path, NULL, rename, add);
+	if ((ret = update_file(o, 0, &rename->oid, rename->mode, dst_name)))
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
@@ -1209,14 +1218,16 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 				 &a->oid, a->mode,
 				 &b->oid, b->mode,
 				 ci->branch1, ci->branch2, &mfi))
-			return;
+			return -1;
+
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
 		 * pathname and then either rename the add-source file to that
 		 * unique path, or use that unique path instead of src here.
 		 */
-		update_file(o, 0, &mfi.oid, mfi.mode, one->path);
+		if (update_file(o, 0, &mfi.oid, mfi.mode, one->path))
+			return -1;
 
 		/*
 		 * Above, we put the merged content at the merge-base's
@@ -1227,22 +1238,26 @@ static void conflict_rename_rename_1to2(struct merge_options *o,
 		 * resolving the conflict at that path in its favor.
 		 */
 		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
-		if (add)
-			update_file(o, 0, &add->oid, add->mode, a->path);
+		if (add) {
+			if (update_file(o, 0, &add->oid, add->mode, a->path))
+				return -1;
+		}
 		else
 			remove_file_from_cache(a->path);
 		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
-		if (add)
-			update_file(o, 0, &add->oid, add->mode, b->path);
+		if (add) {
+			if (update_file(o, 0, &add->oid, add->mode, b->path))
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
@@ -1253,6 +1268,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	char *path = c1->path; /* == c2->path */
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
+	int ret;
 
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1269,7 +1285,7 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
 					    o->branch1, ci->ren2_other.path,
 					    o->branch2, c2->path, &mfi_c2))
-		return;
+		return -1;
 
 	if (o->call_depth) {
 		/*
@@ -1280,19 +1296,25 @@ static void conflict_rename_rename_2to1(struct merge_options *o,
 		 * again later for the non-recursive merge.
 		 */
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, a->path);
-		update_file(o, 0, &mfi_c2.oid, mfi_c2.mode, b->path);
+		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, a->path);
+		if (!ret)
+			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
+				b->path);
 	} else {
 		char *new_path1 = unique_path(o, path, ci->branch1);
 		char *new_path2 = unique_path(o, path, ci->branch2);
 		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
 		       a->path, new_path1, b->path, new_path2);
 		remove_file(o, 0, path, 0);
-		update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
-		update_file(o, 0, &mfi_c2.oid, mfi_c2.mode, new_path2);
+		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
+		if (!ret)
+			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
+				new_path2);
 		free(new_path2);
 		free(new_path1);
 	}
+
+	return ret;
 }
 
 static int process_renames(struct merge_options *o,
@@ -1477,12 +1499,13 @@ static int process_renames(struct merge_options *o,
 				 * update_file_flags() instead of
 				 * update_file().
 				 */
-				update_file_flags(o,
+				if (update_file_flags(o,
 						  &ren1->pair->two->oid,
 						  ren1->pair->two->mode,
 						  ren1_dst,
 						  1, /* update_cache */
-						  0  /* update_wd    */);
+						  0  /* update_wd    */))
+					clean_merge = -1;
 			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
 				clean_merge = 0;
 				try_merge = 1;
@@ -1497,22 +1520,28 @@ static int process_renames(struct merge_options *o,
 							 ren1->pair->two->mode,
 							 &dst_other.oid,
 							 dst_other.mode,
-							 branch1, branch2, &mfi))
-						return -1;
+							 branch1, branch2, &mfi)) {
+						clean_merge = -1;
+						goto cleanup_and_return;
+					}
 					output(o, 1, _("Adding merged %s"), ren1_dst);
-					update_file(o, 0, &mfi.oid,
-						    mfi.mode, ren1_dst);
+					if (update_file(o, 0, &mfi.oid,
+							mfi.mode, ren1_dst))
+						clean_merge = -1;
 					try_merge = 0;
 				} else {
 					char *new_path = unique_path(o, ren1_dst, branch2);
 					output(o, 1, _("Adding as %s instead"), new_path);
-					update_file(o, 0, &dst_other.oid,
-						    dst_other.mode, new_path);
+					if (update_file(o, 0, &dst_other.oid,
+						    dst_other.mode, new_path))
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
@@ -1539,6 +1568,7 @@ static int process_renames(struct merge_options *o,
 			}
 		}
 	}
+cleanup_and_return:
 	string_list_clear(&a_by_dst, 0);
 	string_list_clear(&b_by_dst, 0);
 
@@ -1601,13 +1631,13 @@ error_return:
 	return ret;
 }
 
-static void handle_modify_delete(struct merge_options *o,
+static int handle_modify_delete(struct merge_options *o,
 				 const char *path,
 				 struct object_id *o_oid, int o_mode,
 				 struct object_id *a_oid, int a_mode,
 				 struct object_id *b_oid, int b_mode)
 {
-	handle_change_delete(o,
+	return handle_change_delete(o,
 			     path,
 			     o_oid, o_mode,
 			     a_oid, a_mode,
@@ -1686,7 +1716,8 @@ static int merge_content(struct merge_options *o,
 		output(o, 1, _("CONFLICT (%s): Merge conflict in %s"),
 				reason, path);
 		if (rename_conflict_info && !df_conflict_remains)
-			update_stages(path, &one, &a, &b);
+			if (update_stages(path, &one, &a, &b))
+				return -1;
 	}
 
 	if (df_conflict_remains) {
@@ -1694,30 +1725,33 @@ static int merge_content(struct merge_options *o,
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
 				oidcpy(&merged.oid, &mfi.oid);
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
-		update_file(o, 0, &mfi.oid, mfi.mode, new_path);
+		if (update_file(o, 0, &mfi.oid, mfi.mode, new_path)) {
+			free(new_path);
+			return -1;
+		}
 		free(new_path);
 		mfi.clean = 0;
-	} else {
-		update_file(o, mfi.clean, &mfi.oid, mfi.mode, path);
-	}
+	} else if (update_file(o, mfi.clean, &mfi.oid, mfi.mode, path))
+		return -1;
 	return mfi.clean;
-
 }
 
 /* Per entry merge function */
@@ -1745,17 +1779,21 @@ static int process_entry(struct merge_options *o,
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
@@ -1775,8 +1813,9 @@ static int process_entry(struct merge_options *o,
 		} else {
 			/* Modify/delete; deleted side may have put a directory in the way */
 			clean_merge = 0;
-			handle_modify_delete(o, path, o_oid, o_mode,
-					     a_oid, a_mode, b_oid, b_mode);
+			if (handle_modify_delete(o, path, o_oid, o_mode,
+					     a_oid, a_mode, b_oid, b_mode))
+				clean_merge = -1;
 		}
 	} else if ((!o_oid && a_oid && !b_oid) ||
 		   (!o_oid && !a_oid && b_oid)) {
@@ -1808,14 +1847,16 @@ static int process_entry(struct merge_options *o,
 			output(o, 1, _("CONFLICT (%s): There is a directory with name %s in %s. "
 			       "Adding %s as %s"),
 			       conf, path, other_branch, path, new_path);
-			update_file(o, 0, oid, mode, new_path);
-			if (o->call_depth)
+			if (update_file(o, 0, oid, mode, new_path))
+				clean_merge = -1;
+			else if (o->call_depth)
 				remove_file_from_cache(path);
 			free(new_path);
 		} else {
 			output(o, 2, _("Adding %s"), path);
 			/* do not overwrite file if already present */
-			update_file_flags(o, oid, mode, path, 1, !a_oid);
+			if (update_file_flags(o, oid, mode, path, 1, !a_oid))
+				clean_merge = -1;
 		}
 	} else if (a_oid && b_oid) {
 		/* Case C: Added in both (check for same permissions) and */
@@ -1878,12 +1919,18 @@ int merge_trees(struct merge_options *o,
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
2.9.0.278.g1caae67


