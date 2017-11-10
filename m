Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB17D1F42B
	for <e@80x24.org>; Fri, 10 Nov 2017 22:22:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754587AbdKJWWO (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Nov 2017 17:22:14 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:50374 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754526AbdKJWWF (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 10 Nov 2017 17:22:05 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAAMCcD6030104;
        Fri, 10 Nov 2017 14:22:04 -0800
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2e535n1nda-1;
        Fri, 10 Nov 2017 14:22:04 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id EE6C822F94DE;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id E39F72CDE6A;
        Fri, 10 Nov 2017 14:22:03 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 9/9] diffcore-rename: Filter rename_src list when possible
Date:   Fri, 10 Nov 2017 14:21:56 -0800
Message-Id: <20171110222156.23221-10-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.46.g41dca04efb
In-Reply-To: <20171110222156.23221-1-newren@gmail.com>
References: <20171110222156.23221-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-10_11:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1707230000
 definitions=main-1711100306
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have to look at each entry in rename_src a total of rename_dst_nr
times.  When we're not detecting copies, any exact renames or ignorable
rename paths will just be skipped over.  While checking that these can
be skipped over is a relatively cheap check, it's still a waste of time
to do that check more than once, let alone rename_dst_nr times.  When
rename_src_nr is a few thousand times bigger than the number of relevant
sources (such as when cherry-picking a commit that only touched a
handful of files, but from a side of history that has different names
for some high level directories), this time can add up.

First make an initial pass over the rename_src array and move all the
relevant entries to the front, so that we can iterate over just those
relevant entries.

In one particular testcase involving a large repository and some
high-level directories having been renamed, this cut the time necessary
for a cherry-pick down by a factor of about 2 (from around 34 seconds
down to just under 16 seconds)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 47 +++++++++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 16 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index aa8e0e4d4a..f6fc084891 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -437,16 +437,14 @@ static int find_renames(struct diff_score *mx, int dst_cnt, int minimum_score, i
 	return count;
 }
 
-static int handle_rename_ignores(struct diff_options *options)
+static void handle_rename_ignores(struct diff_options *options)
 {
-	int detect_rename = options->detect_rename;
 	struct string_list *ignores = options->ignore_for_renames;
-	int ignored = 0;
 	int i, j;
 
 	/* rename_ignores onlhy relevant when we're not detecting copies */
-	if (ignores == NULL || detect_rename == DIFF_DETECT_COPY)
-		return 0;
+	if (ignores == NULL)
+		return;
 
 	for (i = 0, j = 0; i < ignores->nr && j < rename_src_nr;) {
 		struct diff_filespec *one = rename_src[j].p->one;
@@ -464,11 +462,27 @@ static int handle_rename_ignores(struct diff_options *options)
 			j++;
 		else {
 			one->rename_used++;
-			ignored++;
+			i++;
+			j++;
 		}
 	}
+}
+
+static int remove_renames_from_src()
+{
+	int j, new_j;
+
+	for (j = 0, new_j = 0; j < rename_src_nr; j++) {
+		if (rename_src[j].p->one->rename_used)
+			continue;
+
+		if (new_j < j)
+			memcpy(&rename_src[new_j], &rename_src[j],
+			       sizeof(struct diff_rename_src));
+		new_j++;
+	}
 
-	return ignored;
+	return new_j;
 }
 
 void diffcore_rename(struct diff_options *options)
@@ -479,7 +493,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
-	int num_create, dst_cnt, num_src, ignore_count;
+	int num_create, dst_cnt, num_src;
 	struct progress *progress = NULL;
 
 	if (!minimum_score)
@@ -542,18 +556,19 @@ void diffcore_rename(struct diff_options *options)
 
 	/*
 	 * Mark source files as used if they are found in the
-	 * ignore_for_renames list.
+	 * ignore_for_renames list, and clean out files from rename_src
+	 * that we don't need to continue considering.
 	 */
-	ignore_count = handle_rename_ignores(options);
+	num_src = rename_src_nr;
+	if (detect_rename != DIFF_DETECT_COPY) {
+		handle_rename_ignores(options);
+		num_src = remove_renames_from_src();
+	}
 
 	/*
-	 * Calculate how many renames are left (but all the source
-	 * files still remain as options for rename/copies!)
+	 * Calculate how many renames are left
 	 */
 	num_create = (rename_dst_nr - rename_count);
-	num_src = (detect_rename == DIFF_DETECT_COPY ?
-		   rename_src_nr : rename_src_nr - rename_count);
-	num_src -= ignore_count;
 
 	/* All done? */
 	if (!num_create)
@@ -588,7 +603,7 @@ void diffcore_rename(struct diff_options *options)
 		for (j = 0; j < NUM_CANDIDATE_PER_DST; j++)
 			m[j].dst = -1;
 
-		for (j = 0; j < rename_src_nr; j++) {
+		for (j = 0; j < num_src; j++) {
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 
-- 
2.15.0.46.g41dca04efb

