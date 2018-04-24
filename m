Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E6EA91F424
	for <e@80x24.org>; Tue, 24 Apr 2018 00:24:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932633AbeDXAYc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 20:24:32 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:34586 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932574AbeDXAYc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Apr 2018 20:24:32 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3O0O9HW006996;
        Mon, 23 Apr 2018 17:24:29 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hg35h30rv-1;
        Mon, 23 Apr 2018 17:24:29 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 46210225320F;
        Mon, 23 Apr 2018 17:24:29 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 3746D2CDE67;
        Mon, 23 Apr 2018 17:24:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com, gitster@pobox.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] unpack_trees: fix breakage when o->src_index != o->dst_index
Date:   Mon, 23 Apr 2018 17:24:23 -0700
Message-Id: <20180424002423.11373-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.296.gaac25b4b81
In-Reply-To: <CABPp-BGQy=-k1TN-i2U89x7gJ7z8_ciTM3DJzTnVKsvi94LpBg@mail.gmail.com>
References: <CABPp-BGQy=-k1TN-i2U89x7gJ7z8_ciTM3DJzTnVKsvi94LpBg@mail.gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-23_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=12 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804240002
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, all callers of unpack_trees() set o->src_index == o->dst_index.
The code in unpack_trees() does not correctly handle them being different.
There are two separate issues:

First, there is the possibility of memory corruption.  Since
unpack_trees() creates a temporary index in o->result and then discards
o->dst_index and overwrites it with o->result, in the special case that
o->src_index == o->dst_index, it is safe to just reuse o->src_index's
split_index for o->result.  However, when src and dst are different,
reusing o->src_index's split_index for o->result will cause the
split_index to be shared.  If either index then has entries replaced or
removed, it will result in the other index referring to free()'d memory.

Second, we can drop the index extensions.  Previously, we were moving
index extensions from o->dst_index to o->result.  Since o->src_index is
the one that will have the necessary extensions (o->dst_index is likely to
be a new index temporary index created to store the results), we should be
moving the index extensions from there.  (Thanks to Duy Nguyen for
noticing and suggesting this fix.)

Helped by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---

Marked as PATCH v2, though I marked the previous one as "RFC PATCH v10
32.5/36" because I thought I was going to put it in my series.  But it is
an independent fix that my series needs.

Also, I reran my merge-all-linux.git merges comparison[1]; as expected,
this updated patch didn't change the results.

[1] https://public-inbox.org/git/CABPp-BHMt1Hjr8A_wkxvSExV9ALgG5032vV5uEE2-HtpYuA9QQ@mail.gmail.com/

 unpack-trees.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051e..08f6cab82e 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1284,9 +1284,20 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	o->result.timestamp.sec = o->src_index->timestamp.sec;
 	o->result.timestamp.nsec = o->src_index->timestamp.nsec;
 	o->result.version = o->src_index->version;
-	o->result.split_index = o->src_index->split_index;
-	if (o->result.split_index)
+	if (!o->src_index->split_index) {
+		o->result.split_index = NULL;
+	} else if (o->src_index == o->dst_index) {
+		/*
+		 * o->dst_index (and thus o->src_index) will be discarded
+		 * and overwritten with o->result at the end of this function,
+		 * so just use src_index's split_index to avoid having to
+		 * create a new one.
+		 */
+		o->result.split_index = o->src_index->split_index;
 		o->result.split_index->refcount++;
+	} else {
+		o->result.split_index = init_split_index(&o->result);
+	}
 	hashcpy(o->result.sha1, o->src_index->sha1);
 	o->merge_size = len;
 	mark_all_ce_unused(o->src_index);
@@ -1412,7 +1423,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
-		move_index_extensions(&o->result, o->dst_index);
+		move_index_extensions(&o->result, o->src_index);
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
-- 
2.17.0.296.gaac25b4b81

