Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A763C1F453
	for <e@80x24.org>; Wed, 19 Sep 2018 16:14:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbeISVxQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Sep 2018 17:53:16 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:44156 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732158AbeISVxQ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 Sep 2018 17:53:16 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w8JGDNTV004983;
        Wed, 19 Sep 2018 09:14:38 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2mgxyj7gq7-1;
        Wed, 19 Sep 2018 09:14:38 -0700
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 14953228A04E;
        Wed, 19 Sep 2018 09:14:38 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/4] merge-recursive: avoid wrapper function when unnecessary and wasteful
Date:   Wed, 19 Sep 2018 09:14:32 -0700
Message-Id: <20180919161434.3272-3-newren@gmail.com>
X-Mailer: git-send-email 2.19.0.12.gc6760fd9a9
In-Reply-To: <20180919161434.3272-1-newren@gmail.com>
References: <20180919161434.3272-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-09-19_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1807170000 definitions=main-1809190158
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

merge_file_one() is a convenience function taking a bunch of oids and
modes, combining each pair into a diff_filespec, and then calling
merge_file_1().  When we already start with diff_filespec's, we can
just call merge_file_1() directly instead of splitting out the oids
and modes for the wrapper to recombine into what we already had.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 99a7ac5ec7..9e4e3da672 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -1630,10 +1630,7 @@ static int handle_rename_rename_1to2(struct merge_options *o,
 		struct merge_file_info mfi;
 		struct diff_filespec other;
 		struct diff_filespec *add;
-		if (merge_file_one(o, one->path,
-				 &one->oid, one->mode,
-				 &a->oid, a->mode,
-				 &b->oid, b->mode,
+		if (merge_file_1(o, one, a, b, one->path,
 				 ci->branch1, ci->branch2, &mfi))
 			return -1;
 
-- 
2.19.0.12.gc6760fd9a9

