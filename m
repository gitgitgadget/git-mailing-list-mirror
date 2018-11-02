Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAB1B1F453
	for <e@80x24.org>; Fri,  2 Nov 2018 18:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731114AbeKCEBq (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 00:01:46 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:35680 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731090AbeKCEBo (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 3 Nov 2018 00:01:44 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.23/8.16.0.23) with SMTP id wA2In3Va009763;
        Fri, 2 Nov 2018 11:53:26 -0700
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2ncnvk80vq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 02 Nov 2018 11:53:26 -0700
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-02.YOJOE.local (10.129.18.29) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Fri, 2 Nov 2018 11:53:17 -0700
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Fri, 2 Nov 2018 11:53:35 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id B5B9D210196E;
        Fri,  2 Nov 2018 11:53:24 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 07/10] merge-recursive: use handle_file_collision for add/add conflicts
Date:   Fri, 2 Nov 2018 11:53:15 -0700
Message-ID: <20181102185317.31015-8-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.232.gd14c2061fc
In-Reply-To: <20181102185317.31015-1-newren@gmail.com>
References: <20181019193111.12051-1-newren@gmail.com>
 <20181102185317.31015-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-11-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=749 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1811020166
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
index ead6054a75..c78b347112 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3355,14 +3355,27 @@ static int process_entry(struct merge_options *o,
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
2.19.0.232.gd14c2061fc

