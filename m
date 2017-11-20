Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C0D202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 22:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751803AbdKTWDe (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 17:03:34 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:58154 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751360AbdKTWCO (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Nov 2017 17:02:14 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id vAKLw4MX028709;
        Mon, 20 Nov 2017 14:02:09 -0800
Authentication-Results: ppops.net;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2eajmr3cp8-1;
        Mon, 20 Nov 2017 14:02:09 -0800
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 7A2B622F41A2;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
Received: from newren2-linux.yojoe.local (newren2-linux.dyn.yojoe.local [10.100.68.32])
        by smtp.yojoe.local (Postfix) with ESMTP id 7676A2CDE75;
        Mon, 20 Nov 2017 14:02:09 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 02/33] merge-recursive: fix logic ordering issue
Date:   Mon, 20 Nov 2017 14:01:38 -0800
Message-Id: <20171120220209.15111-3-newren@gmail.com>
X-Mailer: git-send-email 2.15.0.323.g31fe956618
In-Reply-To: <20171120220209.15111-1-newren@gmail.com>
References: <20171120220209.15111-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2017-11-20_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1711200295
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_trees() did a variety of work, including:
  * Calling get_unmerged() to get unmerged entries
  * Calling record_df_conflict_files() with all unmerged entries to
    do some work to ensure we could handle D/F conflicts correctly
  * Calling get_renames() to check for renames.

An easily overlooked issue is that get_renames() can create more
unmerged entries and add them to the list, which have the possibility of
being involved in D/F conflicts.  So the call to
record_df_conflict_files() should really be moved after all the rename
detection.  I didn't come up with any testcases demonstrating any bugs
with the old ordering, but I suspect there were some for both normal
renames and for directory renames.  Fix the ordering.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b48b15a6fd..944f938ec8 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1981,10 +1981,10 @@ int merge_trees(struct merge_options *o,
 		get_files_dirs(o, merge);
 
 		entries = get_unmerged();
-		record_df_conflict_files(o, entries);
 		re_head  = get_renames(o, head, common, head, merge, entries);
 		re_merge = get_renames(o, merge, common, head, merge, entries);
 		clean = process_renames(o, re_head, re_merge);
+		record_df_conflict_files(o, entries);
 		if (clean < 0)
 			goto cleanup;
 		for (i = entries->nr-1; 0 <= i; i--) {
-- 
2.15.0.309.g00c152f825

