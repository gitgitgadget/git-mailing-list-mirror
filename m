Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 89EC71F404
	for <e@80x24.org>; Thu, 19 Apr 2018 17:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753176AbeDSR65 (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 13:58:57 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:41728 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752824AbeDSR6i (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:38 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHnEVV028661;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdryeas7a-1;
        Thu, 19 Apr 2018 10:58:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7694222175BB;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 6D7CF2CDEED;
        Thu, 19 Apr 2018 10:58:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 30/36] merge-recursive: move more is_dirty handling to merge_content
Date:   Thu, 19 Apr 2018 10:58:17 -0700
Message-Id: <20180419175823.7946-31-newren@gmail.com>
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
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190156
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

conflict_rename_normal() was doing some handling for dirty files that
more naturally belonged in merge_content.  Move it, and rename a
parameter for clarity while at it.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 30 ++++++++++++------------------
 1 file changed, 12 insertions(+), 18 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b0f74cb243..7b0081565a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -2727,7 +2727,7 @@ static int handle_modify_delete(struct merge_options *o,
 
 static int merge_content(struct merge_options *o,
 			 const char *path,
-			 int file_in_way,
+			 int is_dirty,
 			 struct object_id *o_oid, int o_mode,
 			 struct object_id *a_oid, int a_mode,
 			 struct object_id *b_oid, int b_mode,
@@ -2803,7 +2803,7 @@ static int merge_content(struct merge_options *o,
 				return -1;
 	}
 
-	if (df_conflict_remains || file_in_way) {
+	if (df_conflict_remains || is_dirty) {
 		char *new_path;
 		if (o->call_depth) {
 			remove_file_from_cache(path);
@@ -2825,6 +2825,10 @@ static int merge_content(struct merge_options *o,
 
 		}
 		new_path = unique_path(o, path, rename_conflict_info->branch1);
+		if (is_dirty) {
+			output(o, 1, _("Refusing to lose dirty file at %s"),
+			       path);
+		}
 		output(o, 1, _("Adding as %s instead"), new_path);
 		if (update_file(o, 0, &mfi.oid, mfi.mode, new_path)) {
 			free(new_path);
@@ -2834,7 +2838,7 @@ static int merge_content(struct merge_options *o,
 		mfi.clean = 0;
 	} else if (update_file(o, mfi.clean, &mfi.oid, mfi.mode, path))
 		return -1;
-	return mfi.clean;
+	return !is_dirty && mfi.clean;
 }
 
 static int conflict_rename_normal(struct merge_options *o,
@@ -2844,21 +2848,10 @@ static int conflict_rename_normal(struct merge_options *o,
 				  struct object_id *b_oid, unsigned int b_mode,
 				  struct rename_conflict_info *ci)
 {
-	int clean_merge;
-	int file_in_the_way = 0;
-
-	if (was_dirty(o, path)) {
-		file_in_the_way = 1;
-		output(o, 1, _("Refusing to lose dirty file at %s"), path);
-	}
-
 	/* Merge the content and write it out */
-	clean_merge = merge_content(o, path, file_in_the_way,
-				    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
-				    ci);
-	if (clean_merge > 0 && file_in_the_way)
-		clean_merge = 0;
-	return clean_merge;
+	return merge_content(o, path, was_dirty(o, path),
+			     o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
+			     ci);
 }
 
 /* Per entry merge function */
@@ -2981,7 +2974,8 @@ static int process_entry(struct merge_options *o,
 	} else if (a_oid && b_oid) {
 		/* Case C: Added in both (check for same permissions) and */
 		/* case D: Modified in both, but differently. */
-		clean_merge = merge_content(o, path, 0 /* file_in_way */,
+		int is_dirty = 0; /* unpack_trees would have bailed if dirty */
+		clean_merge = merge_content(o, path, is_dirty,
 					    o_oid, o_mode, a_oid, a_mode, b_oid, b_mode,
 					    NULL);
 	} else if (!o_oid && !a_oid && !b_oid) {
-- 
2.17.0.290.ge988e9ce2a

