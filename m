Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8B41F42D
	for <e@80x24.org>; Wed, 23 May 2018 20:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934642AbeEWUqZ (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 May 2018 16:46:25 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:40566 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934241AbeEWUqW (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 23 May 2018 16:46:22 -0400
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w4NKcRfv019197;
        Wed, 23 May 2018 13:46:17 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2j2hsk61qf-1;
        Wed, 23 May 2018 13:46:16 -0700
Received: from mxw1.palantir.com (new-smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 93AB7239165C;
        Wed, 23 May 2018 13:46:16 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 8B6032CDEEA;
        Wed, 23 May 2018 13:46:16 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, B.Steinbrink@gmx.de,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH 2/2] rev-parse: verify that commit looked up is not NULL
Date:   Wed, 23 May 2018 13:46:13 -0700
Message-Id: <20180523204613.11333-2-newren@gmail.com>
X-Mailer: git-send-email 2.17.0.1025.g36b5c64692
In-Reply-To: <20180523204613.11333-1-newren@gmail.com>
References: <CABPp-BFOwWvDpfLFa2yrUDU_3BU6F68oLTtO5FvQo8nr62_WtQ@mail.gmail.com>
 <20180523204613.11333-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=792 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1805230202
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 2122f8b963d4 ("rev-parse: Add support for the ^! and ^@ syntax",
2008-07-26), try_parent_shorthands() was introduced to parse the special
^! and ^@ syntax.  However, it did not check the commit returned from
lookup_commit_reference() before proceeding to use it.  If it is NULL,
bail early and notify the caller that this cannot be a valid revision
range.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rev-parse.c          | 2 ++
 t/t6101-rev-parse-parents.sh | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index 55c0b90441..4e9ba9641a 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -334,6 +334,8 @@ static int try_parent_shorthands(const char *arg)
 	}
 
 	commit = lookup_commit_reference(&oid);
+	if (!commit)
+		return 1;
 	if (exclude_parent &&
 	    exclude_parent > commit_list_count(commit->parents)) {
 		*dotdot = '^';
diff --git a/t/t6101-rev-parse-parents.sh b/t/t6101-rev-parse-parents.sh
index 7b1b2dbdf2..f91cc417bd 100755
--- a/t/t6101-rev-parse-parents.sh
+++ b/t/t6101-rev-parse-parents.sh
@@ -214,7 +214,7 @@ test_expect_success 'rev-list merge^-1x (garbage after ^-1)' '
 	test_must_fail git rev-list merge^-1x
 '
 
-test_expect_failure 'rev-parse $garbage^@ should not segfault' '
+test_expect_success 'rev-parse $garbage^@ should not segfault' '
 	git rev-parse ffffffffffffffffffffffffffffffffffffffff^@
 '
 
-- 
2.17.0.1025.g36b5c64692

