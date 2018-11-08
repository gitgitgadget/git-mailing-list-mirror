Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B89061F453
	for <e@80x24.org>; Thu,  8 Nov 2018 04:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbeKHOOP (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Nov 2018 09:14:15 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:47298 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726145AbeKHOOO (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 8 Nov 2018 09:14:14 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wA84bwu7026337;
        Wed, 7 Nov 2018 20:40:37 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2nm9610eb8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Wed, 07 Nov 2018 20:40:37 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Wed, 7 Nov 2018 23:40:34 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Wed, 7 Nov 2018 23:40:34 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 0A2DF2101E96;
        Wed,  7 Nov 2018 20:40:34 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 07/10] merge-recursive: use handle_file_collision for add/add conflicts
Date:   Wed, 7 Nov 2018 20:40:28 -0800
Message-ID: <20181108044031.25885-8-newren@gmail.com>
X-Mailer: git-send-email 2.19.1.858.g526e8fe740.dirty
In-Reply-To: <20181108044031.25885-1-newren@gmail.com>
References: <CABPp-BG2rFEeKVe8ok+a-jLFvPBfnZs1b3Mp2Jfi2JgNZcO8gA@mail.gmail.com>
 <20181108044031.25885-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-08_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=820 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811080038
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This results in no-net change of behavior, it simply ensures that all
file-collision conflict handling types are being handled the same by
calling the same function.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 62eab9e4cc..88e9e1166a 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3356,14 +3356,27 @@ static int process_entry(struct merge_options *o,
 				clean_merge = -1;
 		}
 	} else if (a_oid && b_oid) {
-		/* Case C: Added in both (check for same permissions) and */
-		/* case D: Modified in both, but differently. */
-		int is_dirty = 0; /* unpack_trees would have bailed if dirty */
-		clean_merge = handle_content_merge(o, path, is_dirty,
-						   o_oid, o_mode,
-						   a_oid, a_mode,
-						   b_oid, b_mode,
-						   NULL);
+		if (!o_oid) {
+			/* Case C: Added in both (check for same permissions) */
+			output(o, 1,
+			       _("CONFLICT (add/add): Merge conflict in %s"),
+			       path);
+			clean_merge = handle_file_collision(o,
+							    path, NULL, NULL,
+							    o->branch1,
+							    o->branch2,
+							    a_oid, a_mode,
+							    b_oid, b_mode);
+		} else {
+			/* case D: Modified in both, but differently. */
+			int is_dirty = 0; /* unpack_trees would have bailed if dirty */
+			clean_merge = handle_content_merge(o, path,
+							   is_dirty,
+							   o_oid, o_mode,
+							   a_oid, a_mode,
+							   b_oid, b_mode,
+							   NULL);
+		}
 	} else if (!o_oid && !a_oid && !b_oid) {
 		/*
 		 * this entry was deleted altogether. a_mode == 0 means
-- 
2.19.1.858.g526e8fe740.dirty

