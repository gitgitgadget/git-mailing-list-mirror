Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5004F1F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:41:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbeKHOO2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:14:28 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44920 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728499AbeKHOON (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 09:14:13 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA84eIA0025054;
        Wed, 7 Nov 2018 20:40:36 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm96drdsh-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 20:40:36 -0800
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 20:40:34 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 20:40:34 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 186F22101E97;
        Wed,  7 Nov 2018 20:40:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 08/10] merge-recursive: improve rename/rename(1to2)/add[/add] handling
Date:   Wed, 7 Nov 2018 20:40:29 -0800
Message-ID: <20181108044031.25885-9-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
In-Reply-To: <20181108044031.25885-1-newren@gmail.com>
References: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
 <20181108044031.25885-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we have a rename/rename(1to2) conflict, each of the renames can
collide with a file addition.  Each of these rename/add conflicts suffered
from the same kinds of problems that normal rename/add suffered from.
Make the code use handle_file_conflicts() as well so that we get all the
same fixes and consistent behavior between the different conflict types.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    | 154 +++++++++++++--------------
 t/t6042-merge-rename-corner-cases.sh |  29 +++--
 t/t6043-merge-rename-directories.sh  |  24 +++--
 3 files changed, 113 insertions(+), 94 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 88e9e1166a..3e2a63d094 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1710,80 +1710,17 @@ static int handle_rename_add(struct merge_options *o,
 				     ci->dst_entry1->stages[other_stage].mode);
 }
 
-static int handle_file(struct merge_options *o,
-			struct diff_filespec *rename,
-			int stage,
-			struct rename_conflict_info *ci)
-{
-	char *dst_name = rename->path;
-	struct stage_data *dst_entry;
-	const char *cur_branch, *other_branch;
-	struct diff_filespec other;
-	struct diff_filespec *add;
-	int ret;
-
-	if (stage == 2) {
-		dst_entry = ci->dst_entry1;
-		cur_branch = ci->branch1;
-		other_branch = ci->branch2;
-	} else {
-		dst_entry = ci->dst_entry2;
-		cur_branch = ci->branch2;
-		other_branch = ci->branch1;
-	}
-
-	add = filespec_from_entry(&other, dst_entry, stage ^ 1);
-	if (add) {
-		int ren_src_was_dirty = was_dirty(o, rename->path);
-		char *add_name = unique_path(o, rename->path, other_branch);
-		if (update_file(o, 0, &add->oid, add->mode, add_name))
-			return -1;
-
-		if (ren_src_was_dirty) {
-			output(o, 1, _("Refusing to lose dirty file at %s"),
-			       rename->path);
-		}
-		/*
-		 * Because the double negatives somehow keep confusing me...
-		 *    1) update_wd iff !ren_src_was_dirty.
-		 *    2) no_wd iff !update_wd
-		 *    3) so, no_wd == !!ren_src_was_dirty == ren_src_was_dirty
-		 */
-		remove_file(o, 0, rename->path, ren_src_was_dirty);
-		dst_name = unique_path(o, rename->path, cur_branch);
-	} else {
-		if (dir_in_way(rename->path, !o->call_depth, 0)) {
-			dst_name = unique_path(o, rename->path, cur_branch);
-			output(o, 1, _("%s is a directory in %s adding as %s instead"),
-			       rename->path, other_branch, dst_name);
-		} else if (!o->call_depth &&
-			   would_lose_untracked(rename->path)) {
-			dst_name = unique_path(o, rename->path, cur_branch);
-			output(o, 1, _("Refusing to lose untracked file at %s; "
-				       "adding as %s instead"),
-			       rename->path, dst_name);
-		}
-	}
-	if ((ret = update_file(o, 0, &rename->oid, rename->mode, dst_name)))
-		; /* fall through, do allow dst_name to be released */
-	else if (stage == 2)
-		ret = update_stages(o, rename->path, NULL, rename, add);
-	else
-		ret = update_stages(o, rename->path, NULL, add, rename);
-
-	if (dst_name != rename->path)
-		free(dst_name);
-
-	return ret;
-}
-
 static int handle_rename_rename_1to2(struct merge_options *o,
 				     struct rename_conflict_info *ci)
 {
 	/* One file was renamed in both branches, but to different names. */
+	struct merge_file_info mfi;
+	struct diff_filespec other;
+	struct diff_filespec *add;
 	struct diff_filespec *one = ci->pair1->one;
 	struct diff_filespec *a = ci->pair1->two;
 	struct diff_filespec *b = ci->pair2->two;
+	char *path_desc;
 
 	output(o, 1, _("CONFLICT (rename/rename): "
 	       "Rename \"%s\"->\"%s\" in branch \"%s\" "
@@ -1791,15 +1728,16 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 	       one->path, a->path, ci->branch1,
 	       one->path, b->path, ci->branch2,
 	       o->call_depth ? _(" (left unresolved)") : "");
-	if (o->call_depth) {
-		struct merge_file_info mfi;
-		struct diff_filespec other;
-		struct diff_filespec *add;
-		if (merge_mode_and_contents(o, one, a, b, one->path,
-					    ci->branch1, ci->branch2,
-					    o->call_depth * 2, &mfi))
-			return -1;
 
+	path_desc = xstrfmt("%s and %s, both renamed from %s",
+			    a->path, b->path, one->path);
+	if (merge_mode_and_contents(o, one, a, b, path_desc,
+				    ci->branch1, ci->branch2,
+				    o->call_depth * 2, &mfi))
+		return -1;
+	free(path_desc);
+
+	if (o->call_depth) {
 		/*
 		 * FIXME: For rename/add-source conflicts (if we could detect
 		 * such), this is wrong.  We should instead find a unique
@@ -1831,8 +1769,70 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 		}
 		else
 			remove_file_from_cache(b->path);
-	} else if (handle_file(o, a, 2, ci) || handle_file(o, b, 3, ci))
-		return -1;
+	} else {
+		/*
+		 * For each destination path, we need to see if there is a
+		 * rename/add collision.  If not, we can write the file out
+		 * to the specified location.
+		 */
+		add = filespec_from_entry(&other, ci->dst_entry1, 2 ^ 1);
+		if (add) {
+			if (handle_file_collision(o, a->path,
+						  NULL, NULL,
+						  ci->branch1, ci->branch2,
+						  &mfi.oid, mfi.mode,
+						  &add->oid, add->mode) < 0)
+				return -1;
+		} else {
+			char *new_path = NULL;
+			if (dir_in_way(a->path, !o->call_depth, 0)) {
+				new_path = unique_path(o, a->path, ci->branch1);
+				output(o, 1, _("%s is a directory in %s adding "
+					       "as %s instead"),
+				       a->path, ci->branch2, new_path);
+			} else if (would_lose_untracked(a->path)) {
+				new_path = unique_path(o, a->path, ci->branch1);
+				output(o, 1, _("Refusing to lose untracked file"
+					       " at %s; adding as %s instead"),
+				       a->path, new_path);
+			}
+
+			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : a->path))
+				return -1;
+			free(new_path);
+			if (update_stages(o, a->path, NULL, a, NULL))
+				return -1;
+		}
+
+		add = filespec_from_entry(&other, ci->dst_entry2, 3 ^ 1);
+		if (add) {
+			if (handle_file_collision(o, b->path,
+						  NULL, NULL,
+						  ci->branch1, ci->branch2,
+						  &add->oid, add->mode,
+						  &mfi.oid, mfi.mode) < 0)
+				return -1;
+		} else {
+			char *new_path = NULL;
+			if (dir_in_way(b->path, !o->call_depth, 0)) {
+				new_path = unique_path(o, b->path, ci->branch2);
+				output(o, 1, _("%s is a directory in %s adding "
+					       "as %s instead"),
+				       b->path, ci->branch1, new_path);
+			} else if (would_lose_untracked(b->path)) {
+				new_path = unique_path(o, b->path, ci->branch2);
+				output(o, 1, _("Refusing to lose untracked file"
+					       " at %s; adding as %s instead"),
+				       b->path, new_path);
+			}
+
+			if (update_file(o, 0, &mfi.oid, mfi.mode, new_path ? new_path : b->path))
+				return -1;
+			free(new_path);
+			if (update_stages(o, b->path, NULL, NULL, b))
+				return -1;
+		}
+	}
 
 	return 0;
 }
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index b93139f628..7cc34e7579 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -684,7 +684,7 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 		git ls-files -u c >out &&
 		test_line_count = 2 out &&
 		git ls-files -o >out &&
-		test_line_count = 5 out &&
+		test_line_count = 1 out &&
 
 		git rev-parse >expect               \
 			A:a   C:b   B:b   C:c   B:c &&
@@ -692,14 +692,27 @@ test_expect_success 'rename/rename/add-dest merge still knows about conflicting
 			:1:a  :2:b  :3:b  :2:c  :3:c &&
 		test_cmp expect actual &&
 
-		git rev-parse >expect               \
-			C:c     B:c     C:b     B:b &&
-		git hash-object >actual                \
-			c~HEAD  c~B\^0  b~HEAD  b~B\^0 &&
-		test_cmp expect actual &&
+		# Record some contents for re-doing merges
+		git cat-file -p A:a >stuff &&
+		git cat-file -p C:b >important_info &&
+		git cat-file -p B:c >precious_data &&
+		>empty &&
 
-		test_path_is_missing b &&
-		test_path_is_missing c
+		# Test the merge in b
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			important_info empty stuff &&
+		test_cmp important_info b &&
+
+		# Test the merge in c
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			stuff empty precious_data &&
+		test_cmp stuff c
 	)
 '
 
diff --git a/t/t6043-merge-rename-directories.sh b/t/t6043-merge-rename-directories.sh
index fedaeafc55..5c01a0c14a 100755
--- a/t/t6043-merge-rename-directories.sh
+++ b/t/t6043-merge-rename-directories.sh
@@ -1078,7 +1078,7 @@ test_expect_success '5c-check: Transitive rename would cause rename/rename/renam
 		git ls-files -u >out &&
 		test_line_count = 6 out &&
 		git ls-files -o >out &&
-		test_line_count = 3 out &&
+		test_line_count = 1 out &&
 
 		git rev-parse >actual \
 			:0:y/b :0:y/c :0:y/e &&
@@ -1094,9 +1094,9 @@ test_expect_success '5c-check: Transitive rename would cause rename/rename/renam
 		test_cmp expect actual &&
 
 		git hash-object >actual \
-			w/d~HEAD w/d~B^0 z/d &&
+			z/d &&
 		git rev-parse >expect \
-			O:x/d    B:w/d   O:x/d &&
+			O:x/d &&
 		test_cmp expect actual &&
 		test_path_is_missing x/d &&
 		test_path_is_file y/d &&
@@ -3672,7 +3672,7 @@ test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rena
 		git ls-files -u >out &&
 		test_line_count = 4 out &&
 		git ls-files -o >out &&
-		test_line_count = 4 out &&
+		test_line_count = 3 out &&
 
 		echo different >expected &&
 		echo mods >>expected &&
@@ -3684,11 +3684,17 @@ test_expect_success '11e-check: Avoid deleting not-uptodate with dir rename/rena
 			 O:z/a  O:z/b  O:x/d  O:x/c  O:x/c  A:y/c  O:x/c &&
 		test_cmp expect actual &&
 
-		git hash-object >actual \
-			y/c~B^0 y/c~HEAD &&
-		git rev-parse >expect \
-			O:x/c   A:y/c &&
-		test_cmp expect actual
+		# See if y/c~merged has expected contents; requires manually
+		# doing the expected file merge
+		git cat-file -p A:y/c >c1 &&
+		git cat-file -p B:z/c >c2 &&
+		>empty &&
+		test_must_fail git merge-file \
+			-L "HEAD" \
+			-L "" \
+			-L "B^0" \
+			c1 empty c2 &&
+		test_cmp c1 y/c~merged
 	)
 '
 
-- 
2.19.1.858.g526e8fe740.dirty

