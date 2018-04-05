Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 252A61F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751506AbeDERe6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:34:58 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:39116 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751412AbeDERex (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:34:53 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HYngK006435;
        Thu, 5 Apr 2018 10:34:51 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h286rvn7t-1;
        Thu, 05 Apr 2018 10:34:49 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id F3C452212A82;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id EA6EF2CDEB1;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 5/7] dir: Make the DO_MATCH_SUBMODULE code reusable for a non-submodule case
Date:   Thu,  5 Apr 2018 10:34:44 -0700
Message-Id: <20180405173446.32372-6-newren@gmail.com>
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

The specific checks done in match_pathspec_item for the DO_MATCH_SUBMODULE
case are useful for other cases which have nothing to do with submodules.
Rename this constant; a subsequent commit will make use of this change.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 dir.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/dir.c b/dir.c
index e783431948..b0bca179fd 100644
--- a/dir.c
+++ b/dir.c
@@ -272,7 +272,7 @@ static int do_read_blob(const struct object_id *oid, struct oid_stat *oid_stat,
 
 #define DO_MATCH_EXCLUDE   (1<<0)
 #define DO_MATCH_DIRECTORY (1<<1)
-#define DO_MATCH_SUBMODULE (1<<2)
+#define DO_MATCH_LEADING_PATHSPEC (1<<2)
 
 static int match_attrs(const char *name, int namelen,
 		       const struct pathspec_item *item)
@@ -381,7 +381,7 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
 		return MATCHED_FNMATCH;
 
 	/* Perform checks to see if "name" is a super set of the pathspec */
-	if (flags & DO_MATCH_SUBMODULE) {
+	if (flags & DO_MATCH_LEADING_PATHSPEC) {
 		/* name is a literal prefix of the pathspec */
 		if ((namelen < matchlen) &&
 		    (match[namelen-1] == '/') &&
@@ -521,7 +521,7 @@ int submodule_path_match(const struct pathspec *ps,
 					strlen(submodule_name),
 					0, seen,
 					DO_MATCH_DIRECTORY |
-					DO_MATCH_SUBMODULE);
+					DO_MATCH_LEADING_PATHSPEC);
 	return matched;
 }
 
-- 
2.17.0.7.g0b50f94d69

