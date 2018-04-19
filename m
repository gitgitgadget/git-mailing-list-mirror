Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F4441F404
	for <e@80x24.org>; Thu, 19 Apr 2018 18:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbeDSSAa (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Apr 2018 14:00:30 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:42122 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752497AbeDSR6g (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 19 Apr 2018 13:58:36 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3JHw4P2014666;
        Thu, 19 Apr 2018 10:58:30 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hdry1au88-1;
        Thu, 19 Apr 2018 10:58:29 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id DBAEC22175B6;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id D31362CDE6F;
        Thu, 19 Apr 2018 10:58:28 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        torvalds@linux-foundation.org, Elijah Newren <newren@gmail.com>
Subject: [PATCH v10 16/36] merge-recursive: split out code for determining diff_filepairs
Date:   Thu, 19 Apr 2018 10:58:03 -0700
Message-Id: <20180419175823.7946-17-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.290.ge988e9ce2a
In-Reply-To: <20180419175823.7946-1-newren@gmail.com>
References: <20180419175823.7946-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804190157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new function, get_diffpairs() to compute the diff_filepairs
between two trees.  While these are currently only used in
get_renames(), I want them to be available to some new functions.  No
actual logic changes yet.

Reviewed-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 merge-recursive.c | 84 ++++++++++++++++++++++++++++++++++-------------
 1 file changed, 62 insertions(+), 22 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 5da60b9516..55a8ace948 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1322,24 +1322,15 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
 }
 
 /*
- * Get information of all renames which occurred between 'o_tree' and
- * 'tree'. We need the three trees in the merge ('o_tree', 'a_tree' and
- * 'b_tree') to be able to associate the correct cache entries with
- * the rename information. 'tree' is always equal to either a_tree or b_tree.
+ * Get the diff_filepairs changed between o_tree and tree.
  */
-static struct string_list *get_renames(struct merge_options *o,
-				       struct tree *tree,
-				       struct tree *o_tree,
-				       struct tree *a_tree,
-				       struct tree *b_tree,
-				       struct string_list *entries)
+static struct diff_queue_struct *get_diffpairs(struct merge_options *o,
+					       struct tree *o_tree,
+					       struct tree *tree)
 {
-	int i;
-	struct string_list *renames;
+	struct diff_queue_struct *ret;
 	struct diff_options opts;
 
-	renames = xcalloc(1, sizeof(struct string_list));
-
 	diff_setup(&opts);
 	opts.flags.recursive = 1;
 	opts.flags.rename_empty = 0;
@@ -1355,10 +1346,41 @@ static struct string_list *get_renames(struct merge_options *o,
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
 		o->needed_rename_limit = opts.needed_rename_limit;
-	for (i = 0; i < diff_queued_diff.nr; ++i) {
+
+	ret = xmalloc(sizeof(*ret));
+	*ret = diff_queued_diff;
+
+	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
+	diff_queued_diff.nr = 0;
+	diff_queued_diff.queue = NULL;
+	diff_flush(&opts);
+	return ret;
+}
+
+/*
+ * Get information of all renames which occurred in 'pairs', making use of
+ * any implicit directory renames inferred from the other side of history.
+ * We need the three trees in the merge ('o_tree', 'a_tree' and 'b_tree')
+ * to be able to associate the correct cache entries with the rename
+ * information; tree is always equal to either a_tree or b_tree.
+ */
+static struct string_list *get_renames(struct merge_options *o,
+				       struct diff_queue_struct *pairs,
+				       struct tree *tree,
+				       struct tree *o_tree,
+				       struct tree *a_tree,
+				       struct tree *b_tree,
+				       struct string_list *entries)
+{
+	int i;
+	struct string_list *renames;
+
+	renames = xcalloc(1, sizeof(struct string_list));
+
+	for (i = 0; i < pairs->nr; ++i) {
 		struct string_list_item *item;
 		struct rename *re;
-		struct diff_filepair *pair = diff_queued_diff.queue[i];
+		struct diff_filepair *pair = pairs->queue[i];
 
 		if (pair->status != 'R') {
 			diff_free_filepair(pair);
@@ -1383,9 +1405,6 @@ static struct string_list *get_renames(struct merge_options *o,
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
 	}
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr = 0;
-	diff_flush(&opts);
 	return renames;
 }
 
@@ -1656,15 +1675,36 @@ static int handle_renames(struct merge_options *o,
 			  struct string_list *entries,
 			  struct rename_info *ri)
 {
+	struct diff_queue_struct *head_pairs, *merge_pairs;
+	int clean;
+
 	ri->head_renames = NULL;
 	ri->merge_renames = NULL;
 
 	if (!o->detect_rename)
 		return 1;
 
-	ri->head_renames  = get_renames(o, head, common, head, merge, entries);
-	ri->merge_renames = get_renames(o, merge, common, head, merge, entries);
-	return process_renames(o, ri->head_renames, ri->merge_renames);
+	head_pairs = get_diffpairs(o, common, head);
+	merge_pairs = get_diffpairs(o, common, merge);
+
+	ri->head_renames  = get_renames(o, head_pairs, head,
+					 common, head, merge, entries);
+	ri->merge_renames = get_renames(o, merge_pairs, merge,
+					 common, head, merge, entries);
+	clean = process_renames(o, ri->head_renames, ri->merge_renames);
+
+	/*
+	 * Some cleanup is deferred until cleanup_renames() because the
+	 * data structures are still needed and referenced in
+	 * process_entry().  But there are a few things we can free now.
+	 */
+
+	free(head_pairs->queue);
+	free(head_pairs);
+	free(merge_pairs->queue);
+	free(merge_pairs);
+
+	return clean;
 }
 
 static void cleanup_rename(struct string_list *rename)
-- 
2.17.0.290.ge988e9ce2a

