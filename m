Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 126C21F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:35:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751463AbeDERez (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:34:55 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39126 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750786AbeDERex (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:34:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HYFZN006042;
        Thu, 5 Apr 2018 10:34:49 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h286rvn7q-1;
        Thu, 05 Apr 2018 10:34:48 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id CC5212212A6E;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id C2E862CDEB1;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 2/7] dir.c: fix off-by-one error in match_pathspec_item
Date:   Thu,  5 Apr 2018 10:34:41 -0700
Message-Id: <20180405173446.32372-3-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.7.g0b50f94d69
In-Reply-To: <20180405173446.32372-1-newren@gmail.com>
References: <20180405173446.32372-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-04-05_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For a pathspec like 'foo/bar' comparing against a path named "foo/",
namelen will be 4, and match[namelen] will be 'b'.  The correct location
of the directory separator is namelen-1.

The reason the code worked anyway was that the following code immediately
checked whether the first matchlen characters matched (which they do) and
then bailed and return MATCHED_RECURSIVELY anyway since wildmatch doesn't
have the ability to check if "name" can be matched as a directory (or
prefix) against the pathspec.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 19212129f0..c915a69385 100644
--- a/dir.c
+++ b/dir.c
@@ -384,7 +384,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 	if (flags & DO_MATCH_SUBMODULE) {
 		/* name is a literal prefix of the pathspec */
 		if ((namelen < matchlen) &&
-		    (match[namelen] == '/') &&
+		    (match[namelen-1] == '/') &&
 		    !ps_strncmp(item, match, name, namelen))
 			return MATCHED_RECURSIVELY;
 
-- 
2.17.0.7.g0b50f94d69

