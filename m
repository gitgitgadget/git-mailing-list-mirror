Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACB871F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754608AbdKJWWP (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:22:15 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:45962 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754507AbdKJWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 17:22:05 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAMDS7e002348;
        Fri, 10 Nov 2017 14:22:04 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e53631me1-1;
        Fri, 10 Nov 2017 14:22:03 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B396522F94CA;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id AA5B32CDEC1;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 5/9] merge-recursive: Fix rename/add conflict handling
Date:   Fri, 10 Nov 2017 14:21:52 -0800
Message-Id: <20171110222156.23221-6-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.46.g41dca04efb
In-Reply-To: <20171110222156.23221-1-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100306
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

Using the new handle_file_collision() fixes all of these issues, and
adds smarts to allow two-way merge OR move colliding files to separate
paths depending on the similarity of the colliding files.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c                 | 135 +++++++++++++++++++++++++++-----------
 t/t6036-recursive-corner-cases.sh |  11 ++--
 2 files changed, 104 insertions(+), 42 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 345479ad50..f29cbd1240 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -167,6 +167,7 @@ static int oid_eq(const struct object_id *a, const struct object_id *b)
 enum rename_type {
 	RENAME_NORMAL = 0,
 	RENAME_DIR,
+	RENAME_ADD,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -209,6 +210,7 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
 					      struct stage_data *src_entry1,
 					      struct stage_data *src_entry2)
 {
+	int ostage1, ostage2;
 	struct rename_conflict_info *ci = xcalloc(1, sizeof(struct rename_conflict_info));
 	ci->rename_type = rename_type;
 	ci->pair1 = pair1;
@@ -226,18 +228,22 @@ static inline void setup_rename_conflict_info(enum rename_type rename_type,
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
@@ -1104,6 +1110,18 @@ static int merge_file_special_markers(struct merge_options *o,
 			   const char *filename2,
 			   struct merge_file_info *mfi)
 {
+	if (o->branch1 != branch1) {
+		/*
+		 * It's weird getting a reverse merge with HEAD on the bottom
+		 * and the other branch on the top.  Fix that.
+		 */
+		return merge_file_special_markers(o,
+						  one, b, a,
+						  branch2, filename2,
+						  branch1, filename1,
+						  mfi);
+	}
+
 	char *side1 = NULL;
 	char *side2 = NULL;
 	int ret;
@@ -1291,6 +1309,21 @@ static int handle_file_collision(struct merge_options *o,
 	struct diff_filespec null, a, b;
 	int minimum_score;
 
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
+					     a_oid, a_mode,
+					     conflict_markers_already_present);
+	}
+
 	/* Remove rename sources if this was rename/add or rename/rename(2to1) */
 	if (prev_path1)
 		remove_file(o, 1, prev_path1,
@@ -1396,6 +1429,36 @@ static int handle_file_collision(struct merge_options *o,
 	return 0; /* not clean */
 }
 
+static int conflict_rename_add(struct merge_options *o,
+			       struct rename_conflict_info *ci)
+{
+	/* a was renamed to c, and a separate c was added. */
+	struct diff_filespec *a = ci->pair1->one;
+	struct diff_filespec *c = ci->pair1->two;
+	char *path = c->path;
+	struct merge_file_info mfi;
+
+	int other_stage = (ci->branch1 == o->branch1 ? 3 : 2);
+
+	output(o, 1, _("CONFLICT (rename/add): "
+	       "Rename %s->%s in %s.  Added %s in %s"),
+	       a->path, c->path, ci->branch1,
+	       c->path, ci->branch2);
+
+	if (merge_file_special_markers(o, a, c, &ci->ren1_other,
+				       o->branch1, path,
+				       o->branch2, ci->ren1_other.path, &mfi))
+		return -1;
+
+	return handle_file_collision(o,
+				     c->path, a->path, NULL,
+				     ci->branch1, ci->branch2,
+				     &mfi.oid, mfi.mode,
+				     &ci->dst_entry1->stages[other_stage].oid,
+				     ci->dst_entry1->stages[other_stage].mode,
+				     !mfi.clean);
+}
+
 static int handle_file(struct merge_options *o,
 			struct diff_filespec *rename,
 			int stage,
@@ -2529,36 +2592,23 @@ static int process_renames(struct merge_options *o,
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
-					if (merge_file_one(o, ren1_dst, &null_oid, 0,
-							   &ren1->pair->two->oid,
-							   ren1->pair->two->mode,
-							   &dst_other.oid,
-							   dst_other.mode,
-							   branch1, branch2, &mfi)) {
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
 
@@ -2961,6 +3011,15 @@ static int process_entry(struct merge_options *o,
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
+			clean_merge = conflict_rename_add(o, conflict_info);
+			break;
 		case RENAME_DELETE:
 			clean_merge = 0;
 			if (conflict_rename_delete(o,
diff --git a/t/t6036-recursive-corner-cases.sh b/t/t6036-recursive-corner-cases.sh
index 8485e04b9b..09accbc62a 100755
--- a/t/t6036-recursive-corner-cases.sh
+++ b/t/t6036-recursive-corner-cases.sh
@@ -168,7 +168,7 @@ test_expect_success 'setup differently handled merges of rename/add conflict' '
 	git branch B &&
 	git checkout -b C &&
 	echo 10 >>a &&
-	echo "other content" >>new_a &&
+	printf "0\n1\n2\n3\n4\n5\n6\n7\nfoobar" >new_a &&
 	git add a new_a &&
 	test_tick && git commit -m C &&
 
@@ -179,13 +179,13 @@ test_expect_success 'setup differently handled merges of rename/add conflict' '
 	git checkout B^0 &&
 	test_must_fail git merge C &&
 	git clean -f &&
+	git add new_a &&
 	test_tick && git commit -m D &&
 	git tag D &&
 
 	git checkout C^0 &&
 	test_must_fail git merge B &&
-	rm new_a~HEAD new_a &&
-	printf "Incorrectly merged content" >>new_a &&
+	printf "0\n1\n2\n3\n4\n5\n6\n7\nbad merge" >new_a &&
 	git add -u &&
 	test_tick && git commit -m E &&
 	git tag E
@@ -204,7 +204,10 @@ test_expect_success 'git detects differently handled merges conflict' '
 	test $(git rev-parse :2:new_a) = $(git rev-parse D:new_a) &&
 	test $(git rev-parse :3:new_a) = $(git rev-parse E:new_a) &&
 
-	git cat-file -p B:new_a >>merged &&
+	# Since A:a == B:new_a, the three-way merge of A:a, B:new_a, and
+	# C:a is just C:a.  Then we do a two-way merge of that with
+	# C:new_a.
+	git cat-file -p C:a >>merged &&
 	git cat-file -p C:new_a >>merge-me &&
 	>empty &&
 	test_must_fail git merge-file \
-- 
2.15.0.46.g41dca04efb

