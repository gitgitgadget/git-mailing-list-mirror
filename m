Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4A21F404
	for <e@80x24.org>; Tue, 24 Apr 2018 06:50:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755907AbeDXGuy (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 02:50:54 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39178 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755614AbeDXGux (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 24 Apr 2018 02:50:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w3O6n8OE011413;
        Mon, 23 Apr 2018 23:50:50 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2hg35h3acm-1;
        Mon, 23 Apr 2018 23:50:50 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 4A73722128B5;
        Mon, 23 Apr 2018 23:50:50 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 42DFB2CDE67;
        Mon, 23 Apr 2018 23:50:50 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v3] unpack_trees: fix breakage when o->src_index != o->dst_index
Date:   Mon, 23 Apr 2018 23:50:45 -0700
Message-Id: <20180424065045.13905-1-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.253.g32393f1d0a
In-Reply-To: <xmqq604h717y.fsf@gitster-ct.c.googlers.com>
References: <xmqq604h717y.fsf@gitster-ct.c.googlers.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-24_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=15 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804240069
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
moving the index extensions from there.

Signed-off-by: Elijah Newren <newren@gmail.com>
---

Differences from v2:
  - Don't NULLify src_index until we're done using it
  - Actually built and tested[1]

But it now passes the testsuite on both linux and mac[2], and I even re-merged
all 53288 merge commits in linux.git (with a merge of this patch together with
the directory rename detection series) for good measure.  [Only 7 commits
showed a difference, all due to directory rename detection kicking in.]

[1] Turns out that getting all fancy with an m4.10xlarge and nice levels of
parallelization are great until you realize that your new setup omitted a
critical step, leaving you running a slightly stale version of git instead...
:-(

[2] Actually, I get two test failures on mac from t0050-filesystem.sh, both
with unicode normalization tests, but those two tests fail before my changes
too.  All the other tests pass.

 unpack-trees.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index e73745051e..49526d70aa 100644
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
@@ -1401,7 +1412,6 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 	}
 
-	o->src_index = NULL;
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index) {
 		if (!ret) {
@@ -1412,12 +1422,13 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 						  WRITE_TREE_SILENT |
 						  WRITE_TREE_REPAIR);
 		}
-		move_index_extensions(&o->result, o->dst_index);
+		move_index_extensions(&o->result, o->src_index);
 		discard_index(o->dst_index);
 		*o->dst_index = o->result;
 	} else {
 		discard_index(&o->result);
 	}
+	o->src_index = NULL;
 
 done:
 	clear_exclude_list(&el);
-- 
2.17.0.253.g32393f1d0a

