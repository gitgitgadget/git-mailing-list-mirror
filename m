Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B8171F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:59:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753117AbeDSR67 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:59 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42142 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752778AbeDSR6h (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:37 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw3B2014663;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au84-2;
        Thu, 19 Apr 2018 10:58:30 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id AD9CF22175C9;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id A1D0D2CDE6F;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 35/36] merge-recursive: make "Auto-merging" comment show for other merges
Date:   Thu, 19 Apr 2018 10:58:22 -0700
Message-Id: <20180419175823.7946-36-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, merge_content() would print "Auto-merging" whenever the final
content and mode aren't already available from HEAD.  There are a few
problems with this:

  1) There are other code paths doing merges that should probably have the
     same message printed, in particular rename/rename(2to1) which cannot
     call into the normal rename logic.

  2) If both sides of the merge have modifications, then a content merge
     is needed.  It may turn out that the end result matches one of the
     sides (because the other only had a subset of the same changes), but
     the merge was still needed.  Currently, the message will not print in
     that case, though it seems like it should.

Move the printing of this message to merge_file_1() in order to address
both issues.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

Part of the size of the diff was due to fixing the alignment of
function arguments while I was adding another argument to the list...

 merge-recursive.c | 65 ++++++++++++++++++++++++++++-------------------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 1a481fa3dc..212d34d268 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1063,12 +1063,13 @@ static int merge_3way(struct merge_options *o,
 }
 
 static int merge_file_1(struct merge_options *o,
-					   const struct diff_filespec *one,
-					   const struct diff_filespec *a,
-					   const struct diff_filespec *b,
-					   const char *branch1,
-					   const char *branch2,
-					   struct merge_file_info *result)
+			const struct diff_filespec *one,
+			const struct diff_filespec *a,
+			const struct diff_filespec *b,
+			const char *filename,
+			const char *branch1,
+			const char *branch2,
+			struct merge_file_info *result)
 {
 	result->merge = 0;
 	result->clean = 1;
@@ -1148,18 +1149,22 @@ static int merge_file_1(struct merge_options *o,
 			die("BUG: unsupported object type in the tree");
 	}
 
+	if (result->merge)
+		output(o, 2, _("Auto-merging %s"), filename);
+
 	return 0;
 }
 
 static int merge_file_special_markers(struct merge_options *o,
-			   const struct diff_filespec *one,
-			   const struct diff_filespec *a,
-			   const struct diff_filespec *b,
-			   const char *branch1,
-			   const char *filename1,
-			   const char *branch2,
-			   const char *filename2,
-			   struct merge_file_info *mfi)
+				      const struct diff_filespec *one,
+				      const struct diff_filespec *a,
+				      const struct diff_filespec *b,
+				      const char *target_filename,
+				      const char *branch1,
+				      const char *filename1,
+				      const char *branch2,
+				      const char *filename2,
+				      struct merge_file_info *mfi)
 {
 	char *side1 = NULL;
 	char *side2 = NULL;
@@ -1170,22 +1175,23 @@ static int merge_file_special_markers(struct merge_options *o,
 	if (filename2)
 		side2 = xstrfmt("%s:%s", branch2, filename2);
 
-	ret = merge_file_1(o, one, a, b,
+	ret = merge_file_1(o, one, a, b, target_filename,
 			   side1 ? side1 : branch1,
 			   side2 ? side2 : branch2, mfi);
+
 	free(side1);
 	free(side2);
 	return ret;
 }
 
 static int merge_file_one(struct merge_options *o,
-					 const char *path,
-					 const struct object_id *o_oid, int o_mode,
-					 const struct object_id *a_oid, int a_mode,
-					 const struct object_id *b_oid, int b_mode,
-					 const char *branch1,
-					 const char *branch2,
-					 struct merge_file_info *mfi)
+			  const char *path,
+			  const struct object_id *o_oid, int o_mode,
+			  const struct object_id *a_oid, int a_mode,
+			  const struct object_id *b_oid, int b_mode,
+			  const char *branch1,
+			  const char *branch2,
+			  struct merge_file_info *mfi)
 {
 	struct diff_filespec one, a, b;
 
@@ -1196,7 +1202,7 @@ static int merge_file_one(struct merge_options *o,
 	a.mode = a_mode;
 	oidcpy(&b.oid, b_oid);
 	b.mode = b_mode;
-	return merge_file_1(o, &one, &a, &b, branch1, branch2, mfi);
+	return merge_file_1(o, &one, &a, &b, path, branch1, branch2, mfi);
 }
 
 static int conflict_rename_dir(struct merge_options *o,
@@ -1474,6 +1480,8 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	struct diff_filespec *c1 = ci->pair1->two;
 	struct diff_filespec *c2 = ci->pair2->two;
 	char *path = c1->path; /* == c2->path */
+	char *path_side_1_desc;
+	char *path_side_2_desc;
 	struct merge_file_info mfi_c1;
 	struct merge_file_info mfi_c2;
 	int ret;
@@ -1487,13 +1495,19 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 	remove_file(o, 1, a->path, o->call_depth || would_lose_untracked(a->path));
 	remove_file(o, 1, b->path, o->call_depth || would_lose_untracked(b->path));
 
+	path_side_1_desc = xstrfmt("%s (was %s)", path, a->path);
+	path_side_2_desc = xstrfmt("%s (was %s)", path, b->path);
 	if (merge_file_special_markers(o, a, c1, &ci->ren1_other,
+				       path_side_1_desc,
 				       o->branch1, c1->path,
 				       o->branch2, ci->ren1_other.path, &mfi_c1) ||
 	    merge_file_special_markers(o, b, &ci->ren2_other, c2,
+				       path_side_2_desc,
 				       o->branch1, ci->ren2_other.path,
 				       o->branch2, c2->path, &mfi_c2))
 		return -1;
+	free(path_side_1_desc);
+	free(path_side_2_desc);
 
 	if (o->call_depth) {
 		/*
@@ -2802,7 +2816,7 @@ static int merge_content(struct merge_options *o,
 			       S_ISGITLINK(pair1->two->mode)))
 			df_conflict_remains = 1;
 	}
-	if (merge_file_special_markers(o, &one, &a, &b,
+	if (merge_file_special_markers(o, &one, &a, &b, path,
 				       o->branch1, path1,
 				       o->branch2, path2, &mfi))
 		return -1;
@@ -2824,8 +2838,7 @@ static int merge_content(struct merge_options *o,
 				return -1;
 			return mfi.clean;
 		}
-	} else
-		output(o, 2, _("Auto-merging %s"), path);
+	}
 
 	if (!mfi.clean) {
 		if (S_ISGITLINK(mfi.mode))
-- 
2.17.0.290.ge988e9ce2a

