Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 314251F404
	for <e@80x24.org>; Sat, 21 Apr 2018 19:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753236AbeDUTiK (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Apr 2018 15:38:10 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:51598 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753183AbeDUTiJ (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 21 Apr 2018 15:38:09 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3LJYAkW009052;
        Sat, 21 Apr 2018 12:38:04 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hg35h0bqc-1;
        Sat, 21 Apr 2018 12:38:04 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id B4B782212A89;
        Sat, 21 Apr 2018 12:38:04 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id A13EF2CDE6F;
        Sat, 21 Apr 2018 12:38:04 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, szeder.dev@gmail.com,
        martin.agren@gmail.com, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH v10 32.5/36] unpack_trees: fix memory corruption with split_index when src != dst
Date:   Sat, 21 Apr 2018 12:37:36 -0700
Message-Id: <20180421193736.12722-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.296.gaac25b4b81
In-Reply-To: <20180420122355.21416-1-szeder.dev@gmail.com>
References: <20180420122355.21416-1-szeder.dev@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-21_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=13 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=907 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804210215
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently, all callers of unpack_trees() set o->src_index == o->dst_index.
Since we create a temporary index in o->result, then discard o->dst_index
and overwrite it with o->result, when o->src_index == o->dst_index it is
safe to just reuse o->src_index's split_index for o->result.  However,
o->src_index and o->dst_index are specified separately in order to allow
callers to have these be different.  In such a case, reusing
o->src_index's split_index for o->result will cause the split_index to be
shared.  If either index then has entries replaced or removed, it will
result in the other index referring to free()'d memory.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

I still haven't wrapped my head around the split_index stuff entirely, so
it's possible that

  - the performance optimization isn't even valid when src == dst.  Could
    the original index be different enough from the result that we don't
    want its split_index?

  - there's a better, more performant fix or there is some way to actually
    share a split_index between two independent index_state objects.

However, with this fix, all the tests pass both normally and under
GIT_TEST_SPLIT_INDEX=DareISayYes.  Without this patch, when
GIT_TEST_SPLIT_INDEX is set, my directory rename detection series will fail
several tests, as reported by SZEDER.

 unpack-trees.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 79fd97074e..b670415d4c 100644
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
-- 
2.17.0.296.gaac25b4b81

