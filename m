Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 897881F97E
	for <e@80x24.org>; Sun, 14 Oct 2018 02:05:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbeJNJpN (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Oct 2018 05:45:13 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58056 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbeJNJpM (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 14 Oct 2018 05:45:12 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9E22OBS023995;
        Sat, 13 Oct 2018 19:05:54 -0700
Received: from mail.palantir.com (mxw2.palantir.com [66.70.54.22] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2n3dkjgs4h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Sat, 13 Oct 2018 19:05:53 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Sat, 13 Oct 2018 19:05:52 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Sat, 13 Oct 2018 19:05:52 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Sat, 13 Oct 2018 19:05:47 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 180722101E93;  Sat, 13 Oct 2018 19:05:46 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 5/7] merge-recursive: improve handling for rename/rename(2to1) conflicts
Date:   Sat, 13 Oct 2018 19:05:35 -0700
Message-ID: <20181014020537.17991-6-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.3.g98f21ceff2.dirty
In-Reply-To: <20181014020537.17991-1-newren@gmail.com>
References: <20181014020537.17991-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-14_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810140017
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the rename/rename(2to1) conflicts use the new
handle_file_collision() function.  Since that function was based
originally on the rename/rename(2to1) handling code, the main
differences here are in what was added.  In particular:

  * Instead of storing files at collide_path~HEAD and collide_path~MERGE,
    the files are two-way merged and recorded at collide_path.

  * Instead of recording the version of the renamed file that existed
    on the renamed side in the index (thus ignoring any changes that
    were made to the file on the side of history without the rename),
    we do a three-way content merge on the renamed path, then store
    that at either stage 2 or stage 3.

  * Note that since the content merge for each rename may have conflicts,
    and then we have to merge the two renamed files, we can end up with
    nested conflict markers.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    | 104 ++++-----------------------
 t/t6036-recursive-corner-cases.sh    |  12 +---
 t/t6042-merge-rename-corner-cases.sh |  38 ++++++----
 t/t6043-merge-rename-directories.sh  |  83 ++++++++++++---------
 4 files changed, 89 insertions(+), 148 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 0805095168..ead6054a75 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -696,27 +696,6 @@ static int update_stages(struct merge_options *opt, const char *path,
 	return 0;
 }
 
-static int update_stages_for_stage_data(struct merge_options *opt,
-					const char *path,
-					const struct stage_data *stage_data)
-{
-	struct diff_filespec o, a, b;
-
-	o.mode = stage_data->stages[1].mode;
-	oidcpy(&o.oid, &stage_data->stages[1].oid);
-
-	a.mode = stage_data->stages[2].mode;
-	oidcpy(&a.oid, &stage_data->stages[2].oid);
-
-	b.mode = stage_data->stages[3].mode;
-	oidcpy(&b.oid, &stage_data->stages[3].oid);
-
-	return update_stages(opt, path,
-			     is_null_oid(&o.oid) ? NULL : &o,
-			     is_null_oid(&a.oid) ? NULL : &a,
-			     is_null_oid(&b.oid) ? NULL : &b);
-}
-
 static void update_entry(struct stage_data *entry,
 			 struct diff_filespec *o,
 			 struct diff_filespec *a,
@@ -1870,7 +1849,6 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	char *path_side_2_desc;
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
-	int ret;
 
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename %s->%s in %s. "
@@ -1878,81 +1856,22 @@ static int handle_rename_rename_2to1(struct merge_options *o,
 	       a->path, c1->path, ci->branch1,
 	       b->path, c2->path, ci->branch2);
 
-	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
-	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
-
 	path_side_1_desc = xstrfmt("version of %s from %s", path, a->path);
 	path_side_2_desc = xstrfmt("version of %s from %s", path, b->path);
 	if (merge_mode_and_contents(o, a, c1, &ci->ren1_other, path_side_1_desc,
 				    o->branch1, o->branch2,
-				    o->call_depth * 2, &mfi_c1) ||
+				    1 + o->call_depth * 2, &mfi_c1) ||
 	    merge_mode_and_contents(o, b, &ci->ren2_other, c2, path_side_2_desc,
 				    o->branch1, o->branch2,
-				    o->call_depth * 2, &mfi_c2))
+				    1 + o->call_depth * 2, &mfi_c2))
 		return -1;
 	free(path_side_1_desc);
 	free(path_side_2_desc);
 
-	if (o->call_depth) {
-		/*
-		 * If mfi_c1.clean && mfi_c2.clean, then it might make
-		 * sense to do a two-way merge of those results.  But, I
-		 * think in all cases, it makes sense to have the virtual
-		 * merge base just undo the renames; they can be detected
-		 * again later for the non-recursive merge.
-		 */
-		remove_file(o, 0, path, 0);
-		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, a->path);
-		if (!ret)
-			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
-					  b->path);
-	} else {
-		char *new_path1 = unique_path(o, path, ci->branch1);
-		char *new_path2 = unique_path(o, path, ci->branch2);
-		output(o, 1, _("Renaming %s to %s and %s to %s instead"),
-		       a->path, new_path1, b->path, new_path2);
-		if (was_dirty(o, path))
-			output(o, 1, _("Refusing to lose dirty file at %s"),
-			       path);
-		else if (would_lose_untracked(path))
-			/*
-			 * Only way we get here is if both renames were from
-			 * a directory rename AND user had an untracked file
-			 * at the location where both files end up after the
-			 * two directory renames.  See testcase 10d of t6043.
-			 */
-			output(o, 1, _("Refusing to lose untracked file at "
-				       "%s, even though it's in the way."),
-			       path);
-		else
-			remove_file(o, 0, path, 0);
-		ret = update_file(o, 0, &mfi_c1.oid, mfi_c1.mode, new_path1);
-		if (!ret)
-			ret = update_file(o, 0, &mfi_c2.oid, mfi_c2.mode,
-					  new_path2);
-		/*
-		 * unpack_trees() actually populates the index for us for
-		 * "normal" rename/rename(2to1) situtations so that the
-		 * correct entries are at the higher stages, which would
-		 * make the call below to update_stages_for_stage_data
-		 * unnecessary.  However, if either of the renames came
-		 * from a directory rename, then unpack_trees() will not
-		 * have gotten the right data loaded into the index, so we
-		 * need to do so now.  (While it'd be tempting to move this
-		 * call to update_stages_for_stage_data() to
-		 * apply_directory_rename_modifications(), that would break
-		 * our intermediate calls to would_lose_untracked() since
-		 * those rely on the current in-memory index.  See also the
-		 * big "NOTE" in update_stages()).
-		 */
-		if (update_stages_for_stage_data(o, path, ci->dst_entry1))
-			ret = -1;
-
-		free(new_path2);
-		free(new_path1);
-	}
-
-	return ret;
+	return handle_file_collision(o, path, a->path, b->path,
+				     ci->branch1, ci->branch2,
+				     &mfi_c1.oid, mfi_c1.mode,
+				     &mfi_c2.oid, mfi_c2.mode);
 }
 
 /*
@@ -3361,9 +3280,14 @@ static int process_entry(struct merge_options *o,
 				clean_merge = -1;
 			break;
 		case RENAME_TWO_FILES_TO_ONE:
-			clean_merge = 0;
-			if (handle_rename_rename_2to1(o, conflict_info))
-				clean_merge = -1;
+			/*
+			 * Probably unclean merge, but if the two renamed
+			 * files merge cleanly and the two resulting files
+			 * can then be two-way merged cleanly, I guess it's
+			 * a clean merge?
+			 */
+			clean_merge = handle_rename_rename_2to1(o,
+								conflict_info);
 			break;
 		default:
 			entry->processed = 0;
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index de35ae81ba..aebc74f921 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -64,15 +64,12 @@ test_expect_success 'merge simple rename+criss-cross with no modifications' '
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		test_line_count = 1 out &&
 
 		git rev-parse >expect       \
-			L2:three   R2:three \
 			L2:three   R2:three &&
 		git rev-parse   >actual     \
 			:2:three   :3:three &&
-		git hash-object >>actual    \
-			three~HEAD three~R2^0 &&
 		test_cmp expect actual
 	)
 '
@@ -140,15 +137,12 @@ test_expect_success 'merge criss-cross + rename merges with basic modification'
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		test_line_count = 1 out &&
 
 		git rev-parse >expect       \
-			L2:three   R2:three \
 			L2:three   R2:three &&
 		git rev-parse   >actual     \
 			:2:three   :3:three &&
-		git hash-object >>actual    \
-			three~HEAD three~R2^0 &&
 		test_cmp expect actual
 	)
 '
@@ -1663,7 +1657,7 @@ test_expect_success "setup nested conflicts" '
 	)
 '
 
-test_expect_failure "check nested conflicts" '
+test_expect_success "check nested conflicts" '
 	(
 		cd nested_conflicts &&
 
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index f1c4a06dd6..4cfcde3082 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -464,17 +464,28 @@ test_expect_success 'handle rename/rename (2to1) conflict correctly' '
 		git ls-files -u c >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		test_line_count = 1 out &&
 
 		test_path_is_missing a &&
 		test_path_is_missing b &&
-		test_path_is_file c~HEAD &&
-		test_path_is_file c~C^0 &&
 
-		git rev-parse >expect   \
-			C:a     B:b     &&
-		git hash-object >actual \
-			c~HEAD  c~C^0   &&
+		git rev-parse >expect  \
+			C:a     B:b    &&
+		git rev-parse >actual  \
+			:2:c    :3:c   &&
+		test_cmp expect actual &&
+
+		# Test that the two-way merge in new_a is as expected
+		git cat-file -p :2:c >>ours &&
+		git cat-file -p :3:c >>theirs &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "C^0" \
+			ours empty theirs &&
+		git hash-object c >actual &&
+		git hash-object ours >expect &&
 		test_cmp expect actual
 	)
 '
@@ -940,7 +951,6 @@ test_expect_failure 'mod6-check: chains of rename/rename(1to2) and rename/rename
 test_conflicts_with_adds_and_renames() {
 	sideL=$1
 	sideR=$2
-	expect=$3
 
 	# Setup:
 	#          L
@@ -1048,7 +1058,7 @@ test_conflicts_with_adds_and_renames() {
 		)
 	'
 
-	test_expect_$expect "check simple $sideL/$sideR conflict" '
+	test_expect_success "check simple $sideL/$sideR conflict" '
 		(
 			cd simple_${sideL}_${sideR} &&
 
@@ -1094,10 +1104,10 @@ test_conflicts_with_adds_and_renames() {
 	'
 }
 
-test_conflicts_with_adds_and_renames rename rename failure
-test_conflicts_with_adds_and_renames rename add    success
-test_conflicts_with_adds_and_renames add    rename success
-test_conflicts_with_adds_and_renames add    add    success
+test_conflicts_with_adds_and_renames rename rename
+test_conflicts_with_adds_and_renames rename add
+test_conflicts_with_adds_and_renames add    rename
+test_conflicts_with_adds_and_renames add    add
 
 # Setup:
 #          L
@@ -1168,7 +1178,7 @@ test_expect_success "setup nested conflicts from rename/rename(2to1)" '
 	)
 '
 
-test_expect_failure "check nested conflicts from rename/rename(2to1)" '
+test_expect_success "check nested conflicts from rename/rename(2to1)" '
 	(
 		cd nested_conflicts_from_rename_rename &&
 
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index 4a71f17edd..fedaeafc55 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -278,7 +278,7 @@ test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) con
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		test_line_count = 1 out &&
 
 		git rev-parse >actual \
 			:0:x/b :0:x/c :0:x/d :0:x/e :0:x/m :0:x/n &&
@@ -293,15 +293,16 @@ test_expect_success '1d-check: Directory renames cause a rename/rename(2to1) con
 			 A:y/wham  B:z/wham &&
 		test_cmp expect actual &&
 
-		test_path_is_missing x/wham &&
-		test_path_is_file x/wham~HEAD &&
-		test_path_is_file x/wham~B^0 &&
-
-		git hash-object >actual \
-			x/wham~HEAD x/wham~B^0 &&
-		git rev-parse >expect \
-			A:y/wham    B:z/wham &&
-		test_cmp expect actual
+		# Test that the two-way merge in x/wham is as expected
+		git cat-file -p :2:x/wham >expect &&
+		git cat-file -p :3:x/wham >other &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			expect empty other &&
+		test_cmp expect x/wham
 	)
 '
 
@@ -1670,7 +1671,7 @@ test_expect_success '7b-check: rename/rename(2to1), but only due to transitive r
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		test_line_count = 1 out &&
 
 		git rev-parse >actual \
 			:0:y/b :0:y/c :2:y/d :3:y/d &&
@@ -1678,15 +1679,16 @@ test_expect_success '7b-check: rename/rename(2to1), but only due to transitive r
 			 O:z/b  O:z/c  O:w/d  O:x/d &&
 		test_cmp expect actual &&
 
-		test_path_is_missing y/d &&
-		test_path_is_file y/d~HEAD &&
-		test_path_is_file y/d~B^0 &&
-
-		git hash-object >actual \
-			y/d~HEAD y/d~B^0 &&
-		git rev-parse >expect \
-			O:w/d    O:x/d &&
-		test_cmp expect actual
+		# Test that the two-way merge in y/d is as expected
+		git cat-file -p :2:y/d >expect &&
+		git cat-file -p :3:y/d >other &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			expect empty other &&
+		test_cmp expect y/d
 	)
 '
 
@@ -3165,7 +3167,7 @@ test_expect_success '10c-check: Overwrite untracked with dir rename/rename(1to2)
 #   Commit O: z/{a,b,c_1},        x/{d,e,f_2}
 #   Commit A: y/{a,b},            x/{d,e,f_2,wham_1} + untracked y/wham
 #   Commit B: z/{a,b,c_1,wham_2}, y/{d,e}
-#   Expected: Failed Merge; y/{a,b,d,e} + untracked y/{wham,wham~B^0,wham~HEAD}+
+#   Expected: Failed Merge; y/{a,b,d,e} + untracked y/{wham,wham~merged}+
 #             CONFLICT(rename/rename) z/c_1 vs x/f_2 -> y/wham
 #             ERROR_MSG(Refusing to lose untracked file at y/wham)
 
@@ -3219,7 +3221,7 @@ test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 4 out &&
+		test_line_count = 3 out &&
 
 		git rev-parse >actual \
 			:0:y/a :0:y/b :0:y/d :0:y/e :2:y/wham :3:y/wham &&
@@ -3232,11 +3234,16 @@ test_expect_success '10d-check: Delete untracked with dir rename/rename(2to1)' '
 		echo important >expect &&
 		test_cmp expect y/wham &&
 
-		git hash-object >actual \
-			y/wham~B^0 y/wham~HEAD &&
-		git rev-parse >expect \
-			O:x/f      O:z/c &&
-		test_cmp expect actual
+		# Test that the two-way merge in y/wham~merged is as expected
+		git cat-file -p :2:y/wham >expect &&
+		git cat-file -p :3:y/wham >other &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			expect empty other &&
+		test_cmp expect y/wham~merged
 	)
 '
 
@@ -3689,7 +3696,7 @@ test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rena
 #   Commit O: z/{a,b},        x/{c_1,d_2}
 #   Commit A: y/{a,b,wham_1}, x/d_2, except y/wham has uncommitted mods
 #   Commit B: z/{a,b,wham_2}, x/c_1
-#   Expected: Failed Merge; y/{a,b} + untracked y/{wham~B^0,wham~B^HEAD} +
+#   Expected: Failed Merge; y/{a,b} + untracked y/{wham~merged} +
 #             y/wham with dirty changes from before merge +
 #             CONFLICT(rename/rename) x/c vs x/d -> y/wham
 #             ERROR_MSG(Refusing to lose dirty file at y/wham)
@@ -3741,24 +3748,30 @@ test_expect_success '11f-check: Avoid deleting not-uptodate with dir rename/rena
 		git ls-files -u >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 4 out &&
+		test_line_count = 3 out &&
 
 		test_seq 1 10 >expected &&
 		echo important >>expected &&
 		test_cmp expected y/wham &&
 
 		test_must_fail git rev-parse :1:y/wham &&
-		git hash-object >actual \
-			y/wham~B^0 y/wham~HEAD &&
-		git rev-parse >expect \
-			O:x/d      O:x/c &&
-		test_cmp expect actual &&
 
 		git rev-parse >actual \
 			:0:y/a :0:y/b :2:y/wham :3:y/wham &&
 		git rev-parse >expect \
 			 O:z/a  O:z/b  O:x/c     O:x/d &&
-		test_cmp expect actual
+		test_cmp expect actual &&
+
+		# Test that the two-way merge in y/wham~merged is as expected
+		git cat-file -p :2:y/wham >expect &&
+		git cat-file -p :3:y/wham >other &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			expect empty other &&
+		test_cmp expect y/wham~merged
 	)
 '
 
-- 
2.19.0.3.g98f21ceff2.dirty

