Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A55A81F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 19:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753928AbdKJTGR (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 14:06:17 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51758 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753765AbdKJTGC (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 14:06:02 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAJ2vPK017477;
        Fri, 10 Nov 2017 11:06:01 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1cdf-1;
        Fri, 10 Nov 2017 11:06:01 -0800
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 113ED22F6290;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 0A8D92CDEEA;
        Fri, 10 Nov 2017 11:06:01 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 19/30] merge-recursive: Split out code for determining diff_filepairs
Date:   Fri, 10 Nov 2017 11:05:39 -0800
Message-Id: <20171110190550.27059-20-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.5.g9567be9905
In-Reply-To: <20171110190550.27059-1-newren@gmail.com>
References: <20171110190550.27059-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100261
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new function, get_diffpairs() to compute the diff_filepairs
between two trees.  While these are currently only used in
get_renames(), I want them to be available to some new functions.  No
actual logic changes yet.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 81 ++++++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 60 insertions(+), 21 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index f40c70990c..8c9543d85c 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1315,24 +1315,15 @@ static int conflict_rename_rename_2to1(struct merge_options *o,
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
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	DIFF_OPT_CLR(&opts, RENAME_EMPTY);
@@ -1348,10 +1339,43 @@ static struct string_list *get_renames(struct merge_options *o,
 	diffcore_std(&opts);
 	if (opts.needed_rename_limit > o->needed_rename_limit)
 		o->needed_rename_limit = opts.needed_rename_limit;
-	for (i = 0; i < diff_queued_diff.nr; ++i) {
+
+	ret = malloc(sizeof(struct diff_queue_struct));
+	ret->queue = diff_queued_diff.queue;
+	ret->nr = diff_queued_diff.nr;
+	// Ignore diff_queued_diff.alloc; we won't be changing the size at all
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
 			continue;
@@ -1375,9 +1399,6 @@ static struct string_list *get_renames(struct merge_options *o,
 		item = string_list_insert(renames, pair->one->path);
 		item->util = re;
 	}
-	opts.output_format = DIFF_FORMAT_NO_OUTPUT;
-	diff_queued_diff.nr = 0;
-	diff_flush(&opts);
 	return renames;
 }
 
@@ -1649,15 +1670,33 @@ static struct rename_info *handle_renames(struct merge_options *o,
 					  int *clean)
 {
 	struct rename_info *rei = xcalloc(1, sizeof(struct rename_info));
+	struct diff_queue_struct *head_pairs, *merge_pairs;
 
 	*clean = 1;
 	if (!o->detect_rename)
 		return NULL;
 
-	rei->head_renames  = get_renames(o, head, common, head, merge, entries);
-	rei->merge_renames = get_renames(o, merge, common, head, merge, entries);
+	head_pairs = get_diffpairs(o, common, head);
+	merge_pairs = get_diffpairs(o, common, merge);
+
+	rei->head_renames  = get_renames(o, head_pairs, head,
+					 common, head, merge, entries);
+	rei->merge_renames = get_renames(o, merge_pairs, merge,
+					 common, head, merge, entries);
 	*clean = process_renames(o, rei->head_renames, rei->merge_renames);
 
+cleanup:
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
 	return rei;
 }
 
-- 
2.15.0.5.g9567be9905

