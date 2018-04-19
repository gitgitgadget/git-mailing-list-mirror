Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C1211F404
	for <e@80x24.org>; Thu, 19 Apr 2018 18:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753447AbeDSSAc (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 14:00:32 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42116 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752288AbeDSR6g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw4P1014666;
        Thu, 19 Apr 2018 10:58:29 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au87-2;
        Thu, 19 Apr 2018 10:58:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id E5FB922175A5;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id DCB1D2CDE6F;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 17/36] merge-recursive: make a helper function for cleanup for handle_renames
Date:   Thu, 19 Apr 2018 10:58:04 -0700
Message-Id: <20180419175823.7946-18-newren@gmail.com>
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

In anticipation of more involved cleanup to come, make a helper function
for doing the cleanup at the end of handle_renames.  Rename the already
existing cleanup_rename[s]() to final_cleanup_rename[s](), name the new
helper initial_cleanup_rename(), and leave the big comment in the code
about why we can't do all the cleanup at once.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 55a8ace948..30894c1cc7 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1668,6 +1668,12 @@ struct rename_info {
 	struct string_list *merge_renames;
 };
 
+static void initial_cleanup_rename(struct diff_queue_struct *pairs)
+{
+	free(pairs->queue);
+	free(pairs);
+}
+
 static int handle_renames(struct merge_options *o,
 			  struct tree *common,
 			  struct tree *head,
@@ -1698,16 +1704,13 @@ static int handle_renames(struct merge_options *o,
 	 * data structures are still needed and referenced in
 	 * process_entry().  But there are a few things we can free now.
 	 */
-
-	free(head_pairs->queue);
-	free(head_pairs);
-	free(merge_pairs->queue);
-	free(merge_pairs);
+	initial_cleanup_rename(head_pairs);
+	initial_cleanup_rename(merge_pairs);
 
 	return clean;
 }
 
-static void cleanup_rename(struct string_list *rename)
+static void final_cleanup_rename(struct string_list *rename)
 {
 	const struct rename *re;
 	int i;
@@ -1723,10 +1726,10 @@ static void cleanup_rename(struct string_list *rename)
 	free(rename);
 }
 
-static void cleanup_renames(struct rename_info *re_info)
+static void final_cleanup_renames(struct rename_info *re_info)
 {
-	cleanup_rename(re_info->head_renames);
-	cleanup_rename(re_info->merge_renames);
+	final_cleanup_rename(re_info->head_renames);
+	final_cleanup_rename(re_info->merge_renames);
 }
 
 static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
@@ -2129,7 +2132,7 @@ int merge_trees(struct merge_options *o,
 		}
 
 cleanup:
-		cleanup_renames(&re_info);
+		final_cleanup_renames(&re_info);
 
 		string_list_clear(entries, 1);
 		free(entries);
-- 
2.17.0.290.ge988e9ce2a

