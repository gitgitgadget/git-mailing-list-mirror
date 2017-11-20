Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 083A9202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751252AbdKTWTr (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:19:47 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:33216 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751109AbdKTWTq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:19:46 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKMI8pF011610;
        Mon, 20 Nov 2017 14:19:44 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr3dny-1;
        Mon, 20 Nov 2017 14:19:44 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 816F322F464A;
        Mon, 20 Nov 2017 14:19:44 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 6F5C32CDEB1;
        Mon, 20 Nov 2017 14:19:44 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v2 1/9] diffcore-rename: no point trying to find a match better than exact
Date:   Mon, 20 Nov 2017 14:19:36 -0800
Message-Id: <20171120221944.15431-2-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120221944.15431-1-newren@gmail.com>
References: <20171120221944.15431-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200299
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

diffcore_rename() had some code to avoid having destination paths that
already had an exact rename detected from being re-checked for other
renames.  Source paths, however, were re-checked because we wanted to
allow the possibility of detecting copies.  But if copy detection isn't
turned on, then this merely amounts to attempting to find a
better-than-exact match, which naturally ends up being an expensive
no-op.  In particular, copy detection is never turned on by the merge
recursive machinery.

In a large repository (~50k files, about 60% of which was java) that had
a number of high level directories involved in renames, this cut the time
necessary for a cherry-pick down by about 50% (from around 9 minutes to
4.5 minutes).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diffcore-rename.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index 9ca0eaec70..fe37e3b861 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -377,11 +377,10 @@ static void record_if_better(struct diff_score m[], struct diff_score *o)
  * 1 if we need to disable inexact rename detection;
  * 2 if we would be under the limit if we were given -C instead of -C -C.
  */
-static int too_many_rename_candidates(int num_create,
+static int too_many_rename_candidates(int num_create, int num_src,
 				      struct diff_options *options)
 {
 	int rename_limit = options->rename_limit;
-	int num_src = rename_src_nr;
 	int i;
 
 	options->needed_rename_limit = 0;
@@ -446,7 +445,7 @@ void diffcore_rename(struct diff_options *options)
 	struct diff_queue_struct outq;
 	struct diff_score *mx;
 	int i, j, rename_count, skip_unmodified = 0;
-	int num_create, dst_cnt;
+	int num_create, dst_cnt, num_src;
 	struct progress *progress = NULL;
 
 	if (!minimum_score)
@@ -512,12 +511,14 @@ void diffcore_rename(struct diff_options *options)
 	 * files still remain as options for rename/copies!)
 	 */
 	num_create = (rename_dst_nr - rename_count);
+	num_src = (detect_rename == DIFF_DETECT_COPY ?
+		   rename_src_nr : rename_src_nr - rename_count);
 
 	/* All done? */
 	if (!num_create)
 		goto cleanup;
 
-	switch (too_many_rename_candidates(num_create, options)) {
+	switch (too_many_rename_candidates(num_create, num_src, options)) {
 	case 1:
 		goto cleanup;
 	case 2:
@@ -531,7 +532,7 @@ void diffcore_rename(struct diff_options *options)
 	if (options->show_rename_progress) {
 		progress = start_delayed_progress(
 				_("Performing inexact rename detection"),
-				(uint64_t)rename_dst_nr * (uint64_t)rename_src_nr);
+				(uint64_t)num_create * (uint64_t)num_src);
 	}
 
 	mx = xcalloc(st_mult(NUM_CANDIDATE_PER_DST, num_create), sizeof(*mx));
@@ -550,6 +551,10 @@ void diffcore_rename(struct diff_options *options)
 			struct diff_filespec *one = rename_src[j].p->one;
 			struct diff_score this_src;
 
+			if (one->rename_used &&
+			    detect_rename != DIFF_DETECT_COPY)
+				continue;
+
 			if (skip_unmodified &&
 			    diff_unmodified_pair(rename_src[j].p))
 				continue;
@@ -568,7 +573,7 @@ void diffcore_rename(struct diff_options *options)
 			diff_free_filespec_blob(two);
 		}
 		dst_cnt++;
-		display_progress(progress, (uint64_t)(i+1)*(uint64_t)rename_src_nr);
+		display_progress(progress, (uint64_t)dst_cnt*(uint64_t)num_src);
 	}
 	stop_progress(&progress);
 
-- 
2.15.0.323.g31fe956618

