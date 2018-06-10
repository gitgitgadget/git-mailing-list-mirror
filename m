Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AB021F403
	for <e@80x24.org>; Sun, 10 Jun 2018 04:16:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932110AbeFJEQb (ORCPT <rfc822;e@80x24.org>);
        Sun, 10 Jun 2018 00:16:31 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35426 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753658AbeFJEQ0 (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 10 Jun 2018 00:16:26 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5A4CN2r003718;
        Sat, 9 Jun 2018 21:16:19 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2jgbsksa1q-1;
        Sat, 09 Jun 2018 21:16:18 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 760AE220D18A;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 7079B2CDE75;
        Sat,  9 Jun 2018 21:16:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3 4/6] merge-recursive: clarify the rename_dir/RENAME_DIR meaning
Date:   Sat,  9 Jun 2018 21:16:14 -0700
Message-Id: <20180610041616.4448-5-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.rc1.6.gffeb3ef585
In-Reply-To: <20180610041616.4448-1-newren@gmail.com>
References: <20180522004327.13085-1-newren@gmail.com>
 <20180610041616.4448-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-10_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1805220000 definitions=main-1806100048
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We had an enum of rename types which included RENAME_DIR; this name felt
misleading since it was not about an entire directory but was a status for
each individual file add that occurred within a renamed directory.

Since this type is for signifying that the files in question were being
renamed due to directory rename detection, rename this enum value to
RENAME_VIA_DIR.

Make a similar change to the conflict_rename_dir() function, and add a
comment to the top of that function explaining its purpose (it may not be
quite as obvious as for the other conflict_rename_*() functions).

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5538038178..910f0b70f0 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -181,7 +181,7 @@ static int oid_eq(const struct object_id *a, const struct object_id *b)
 
 enum rename_type {
 	RENAME_NORMAL = 0,
-	RENAME_DIR,
+	RENAME_VIA_DIR,
 	RENAME_DELETE,
 	RENAME_ONE_FILE_TO_ONE,
 	RENAME_ONE_FILE_TO_TWO,
@@ -1410,11 +1410,17 @@ static int merge_file_one(struct merge_options *o,
 	return merge_file_1(o, &one, &a, &b, path, branch1, branch2, mfi);
 }
 
-static int conflict_rename_dir(struct merge_options *o,
-			       struct diff_filepair *pair,
-			       const char *rename_branch,
-			       const char *other_branch)
+static int conflict_rename_via_dir(struct merge_options *o,
+				   struct diff_filepair *pair,
+				   const char *rename_branch,
+				   const char *other_branch)
 {
+	/*
+	 * Handle file adds that need to be renamed due to directory rename
+	 * detection.  This differs from handle_rename_normal, because
+	 * there is no content merge to do; just move the file into the
+	 * desired final location.
+	 */
 	const struct diff_filespec *dest = pair->two;
 
 	if (!o->call_depth && would_lose_untracked(dest->path)) {
@@ -2692,7 +2698,7 @@ static int process_renames(struct merge_options *o,
 
 			if (oid_eq(&src_other.oid, &null_oid) &&
 			    ren1->add_turned_into_rename) {
-				setup_rename_conflict_info(RENAME_DIR,
+				setup_rename_conflict_info(RENAME_VIA_DIR,
 							   ren1->pair,
 							   NULL,
 							   branch1,
@@ -3138,12 +3144,12 @@ static int process_entry(struct merge_options *o,
 							     b_oid, b_mode,
 							     conflict_info);
 			break;
-		case RENAME_DIR:
+		case RENAME_VIA_DIR:
 			clean_merge = 1;
-			if (conflict_rename_dir(o,
-						conflict_info->pair1,
-						conflict_info->branch1,
-						conflict_info->branch2))
+			if (conflict_rename_via_dir(o,
+						    conflict_info->pair1,
+						    conflict_info->branch1,
+						    conflict_info->branch2))
 				clean_merge = -1;
 			break;
 		case RENAME_DELETE:
-- 
2.18.0.rc1.6.gffeb3ef585

