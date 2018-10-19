Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C28921F453
	for <e@80x24.org>; Fri, 19 Oct 2018 19:31:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbeJTDiw (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Oct 2018 23:38:52 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:33252 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbeJTDiv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 19 Oct 2018 23:38:51 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id w9JJNg6F028015;
        Fri, 19 Oct 2018 12:31:22 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2n6h853fnr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 Oct 2018 12:31:22 -0700
Received: from sj-prod-exch-02.YOJOE.local (10.129.18.29) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 19 Oct 2018 12:31:20 -0700
Received: from EX02-WEST.YOJOE.local (10.160.10.131) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1531.3
 via Frontend Transport; Fri, 19 Oct 2018 12:31:20 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 EX02-WEST.YOJOE.local (10.160.10.131) with Microsoft SMTP Server id
 14.3.319.2; Fri, 19 Oct 2018 12:31:15 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech
 [10.100.71.66])        by smtp-transport.yojoe.local (Postfix) with ESMTPS id
 5A2602101E93;  Fri, 19 Oct 2018 12:31:14 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 5/8] merge-recursive: fix rename/add conflict handling
Date:   Fri, 19 Oct 2018 12:31:08 -0700
Message-ID: <20181019193111.12051-6-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.230.g45940724d5
In-Reply-To: <20181019193111.12051-1-newren@gmail.com>
References: <20181014020537.17991-1-newren@gmail.com>
 <20181019193111.12051-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-10-19_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1810190172
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes the rename/add conflict handling make use of the new
handle_file_collision() function, which fixes several bugs and improves
things for the rename/add case significantly.  Previously, rename/add
would:

  * Not leave any higher order stage entries in the index, making it
    appear as if there were no conflict.
  * Would place the rename file at the colliding path, and move the
    added file elsewhere, which combined with the lack of higher order
    stage entries felt really odd.  It's not clear to me why the
    rename should take precedence over the add; if one should be moved
    out of the way, they both probably should.
  * In the recursive case, it would do a two way merge of the added
    file and the version of the renamed file on the renamed side,
    completely excluding modifications to the renamed file on the
    unrenamed side of history.

Use the new handle_file_collision() to fix all of these issues.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                    | 137 +++++++++++++++++----------
 t/t6036-recursive-corner-cases.sh    |  24 ++---
 t/t6042-merge-rename-corner-cases.sh |   4 +-
 3 files changed, 101 insertions(+), 64 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 24d979022e..0805095168 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -186,6 +186,7 @@ static int oid_eq(const struct object_id *a, const struct object_id *b)
 enum rename_type {
 	RENAME_NORMAL = 0,
 	RENAME_VIA_DIR,
+	RENAME_ADD,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -228,6 +229,7 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      struct stage_data *src_entry1,
 					      struct stage_data *src_entry2)
 {
+	int ostage1 = 0, ostage2;
 	struct rename_conflict_info *ci;
 
 	/*
@@ -264,18 +266,22 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 		dst_entry2->rename_conflict_info = ci;
 	}
 
-	if (rename_type == RENAME_TWO_FILES_TO_ONE) {
-		/*
-		 * For each rename, there could have been
-		 * modifications on the side of history where that
-		 * file was not renamed.
-		 */
-		int ostage1 = o->branch1 == branch1 ? 3 : 2;
-		int ostage2 = ostage1 ^ 1;
+	/*
+	 * For each rename, there could have been
+	 * modifications on the side of history where that
+	 * file was not renamed.
+	 */
+	if (rename_type == RENAME_ADD ||
+	    rename_type == RENAME_TWO_FILES_TO_ONE) {
+		ostage1 = o->branch1 == branch1 ? 3 : 2;
 
 		ci->ren1_other.path = pair1->one->path;
 		oidcpy(&ci->ren1_other.oid, &src_entry1->stages[ostage1].oid);
 		ci->ren1_other.mode = src_entry1->stages[ostage1].mode;
+	}
+
+	if (rename_type == RENAME_TWO_FILES_TO_ONE) {
+		ostage2 = ostage1 ^ 1;
 
 		ci->ren2_other.path = pair2->one->path;
 		oidcpy(&ci->ren2_other.oid, &src_entry2->stages[ostage2].oid);
@@ -1559,7 +1565,6 @@ static struct diff_filespec *filespec_from_entry(struct diff_filespec *target,
 	return target;
 }
 
-#if 0 // #if-0-ing avoids unused function warning; will make live in next commit
 static int handle_file_collision(struct merge_options *o,
 				 const char *collide_path,
 				 const char *prev_path1,
@@ -1575,6 +1580,20 @@ static int handle_file_collision(struct merge_options *o,
 	char *alt_path = NULL;
 	const char *update_path = collide_path;
 
+	/*
+	 * It's easiest to get the correct things into stage 2 and 3, and
+	 * to make sure that the content merge puts HEAD before the other
+	 * branch if we just ensure that branch1 == o->branch1.  So, simply
+	 * flip arguments around if we don't have that.
+	 */
+	if (branch1 != o->branch1) {
+		return handle_file_collision(o, collide_path,
+					     prev_path2, prev_path1,
+					     branch2, branch1,
+					     b_oid, b_mode,
+					     a_oid, a_mode);
+	}
+
 	/*
 	 * In the recursive case, we just opt to undo renames
 	 */
@@ -1678,7 +1697,38 @@ static int handle_file_collision(struct merge_options *o,
 	 */
 	return mfi.clean;
 }
-#endif
+
+static int handle_rename_add(struct merge_options *o,
+			     struct rename_conflict_info *ci)
+{
+	/* a was renamed to c, and a separate c was added. */
+	struct diff_filespec *a = ci->pair1->one;
+	struct diff_filespec *c = ci->pair1->two;
+	char *path = c->path;
+	char *prev_path_desc;
+	struct merge_file_info mfi;
+
+	int other_stage = (ci->branch1 == o->branch1 ? 3 : 2);
+
+	output(o, 1, _("CONFLICT (rename/add): "
+	       "Rename %s->%s in %s.  Added %s in %s"),
+	       a->path, c->path, ci->branch1,
+	       c->path, ci->branch2);
+
+	prev_path_desc = xstrfmt("version of %s from %s", path, a->path);
+	if (merge_mode_and_contents(o, a, c, &ci->ren1_other, prev_path_desc,
+				    o->branch1, o->branch2,
+				    1 + o->call_depth * 2, &mfi))
+		return -1;
+	free(prev_path_desc);
+
+	return handle_file_collision(o,
+				     c->path, a->path, NULL,
+				     ci->branch1, ci->branch2,
+				     &mfi.oid, mfi.mode,
+				     &ci->dst_entry1->stages[other_stage].oid,
+				     ci->dst_entry1->stages[other_stage].mode);
+}
 
 static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
@@ -2860,47 +2910,23 @@ static int process_renames(struct merge_options *o,
 						      0  /* update_wd    */))
 					clean_merge = -1;
 			} else if (!oid_eq(&dst_other.oid, &null_oid)) {
-				clean_merge = 0;
-				try_merge = 1;
-				output(o, 1, _("CONFLICT (rename/add): Rename %s->%s in %s. "
-				       "%s added in %s"),
-				       ren1_src, ren1_dst, branch1,
-				       ren1_dst, branch2);
-				if (o->call_depth) {
-					struct merge_file_info mfi;
-					struct diff_filespec one, a, b;
-
-					oidcpy(&one.oid, &null_oid);
-					one.mode = 0;
-					one.path = ren1->pair->two->path;
-
-					oidcpy(&a.oid, &ren1->pair->two->oid);
-					a.mode = ren1->pair->two->mode;
-					a.path = one.path;
-
-					oidcpy(&b.oid, &dst_other.oid);
-					b.mode = dst_other.mode;
-					b.path = one.path;
-
-					if (merge_mode_and_contents(o, &one, &a, &b, ren1_dst,
-								    branch1, branch2,
-								    o->call_depth * 2, &mfi)) {
-						clean_merge = -1;
-						goto cleanup_and_return;
-					}
-					output(o, 1, _("Adding merged %s"), ren1_dst);
-					if (update_file(o, 0, &mfi.oid,
-							mfi.mode, ren1_dst))
-						clean_merge = -1;
-					try_merge = 0;
-				} else {
-					char *new_path = unique_path(o, ren1_dst, branch2);
-					output(o, 1, _("Adding as %s instead"), new_path);
-					if (update_file(o, 0, &dst_other.oid,
-							dst_other.mode, new_path))
-						clean_merge = -1;
-					free(new_path);
-				}
+				/*
+				 * Probably not a clean merge, but it's
+				 * premature to set clean_merge to 0 here,
+				 * because if the rename merges cleanly and
+				 * the merge exactly matches the newly added
+				 * file, then the merge will be clean.
+				 */
+				setup_rename_conflict_info(RENAME_ADD,
+							   ren1->pair,
+							   NULL,
+							   branch1,
+							   branch2,
+							   ren1->dst_entry,
+							   NULL,
+							   o,
+							   ren1->src_entry,
+							   NULL);
 			} else
 				try_merge = 1;
 
@@ -3312,6 +3338,15 @@ static int process_entry(struct merge_options *o,
 						  conflict_info->branch2))
 				clean_merge = -1;
 			break;
+		case RENAME_ADD:
+			/*
+			 * Probably unclean merge, but if the renamed file
+			 * merges cleanly and the result can then be
+			 * two-way merged cleanly with the added file, I
+			 * guess it's a clean merge?
+			 */
+			clean_merge = handle_rename_add(o, conflict_info);
+			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
 			if (handle_rename_delete(o,
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 32fd0a2995..44807603e3 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -185,7 +185,7 @@ test_expect_success 'setup differently handled merges of rename/add conflict' '
 		git branch B &&
 		git checkout -b C &&
 		echo 10 >>a &&
-		echo "other content" >>new_a &&
+		test_write_lines 0 1 2 3 4 5 6 7 foobar >new_a &&
 		git add a new_a &&
 		test_tick && git commit -m C &&
 
@@ -195,14 +195,14 @@ test_expect_success 'setup differently handled merges of rename/add conflict' '
 
 		git checkout B^0 &&
 		test_must_fail git merge C &&
-		git clean -f &&
+		git show :2:new_a >new_a &&
+		git add new_a &&
 		test_tick && git commit -m D &&
 		git tag D &&
 
 		git checkout C^0 &&
 		test_must_fail git merge B &&
-		rm new_a~HEAD new_a &&
-		printf "Incorrectly merged content" >>new_a &&
+		test_write_lines 0 1 2 3 4 5 6 7 bad_merge >new_a &&
 		git add -u &&
 		test_tick && git commit -m E &&
 		git tag E
@@ -225,21 +225,23 @@ test_expect_success 'git detects differently handled merges conflict' '
 		test_line_count = 1 out &&
 
 		git rev-parse >expect       \
-			D:new_a  E:new_a &&
+			C:new_a  D:new_a  E:new_a &&
 		git rev-parse   >actual     \
-			:2:new_a :3:new_a &&
+			:1:new_a :2:new_a :3:new_a &&
 		test_cmp expect actual &&
 
-		git cat-file -p C:new_a >ours &&
-		git cat-file -p B:new_a >theirs &&
+		# Test that the two-way merge in new_a is as expected
+		git cat-file -p D:new_a >ours &&
+		git cat-file -p E:new_a >theirs &&
 		>empty &&
 		test_must_fail git merge-file \
-			-L "Temporary merge branch 1" \
+			-L "HEAD" \
 			-L "" \
-			-L "Temporary merge branch 2" \
+			-L "E^0" \
 			ours empty theirs &&
 		sed -e "s/^\([<=>]\)/\1\1\1/" ours >expect &&
-		git cat-file -p :1:new_a >actual &&
+		git hash-object new_a >actual &&
+		git hash-object ours  >expect &&
 		test_cmp expect actual
 	)
 '
diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-rename-corner-cases.sh
index 5e69e60b48..f1c4a06dd6 100755
--- a/t/t6042-merge-rename-corner-cases.sh
+++ b/t/t6042-merge-rename-corner-cases.sh
@@ -1095,8 +1095,8 @@ test_conflicts_with_adds_and_renames() {
 }
 
 test_conflicts_with_adds_and_renames rename rename failure
-test_conflicts_with_adds_and_renames rename add    failure
-test_conflicts_with_adds_and_renames add    rename failure
+test_conflicts_with_adds_and_renames rename add    success
+test_conflicts_with_adds_and_renames add    rename success
 test_conflicts_with_adds_and_renames add    add    success
 
 # Setup:
-- 
2.19.1.1079.gae8ff35a65

