Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C60C41F404
	for <e@80x24.org>; Thu,  5 Apr 2018 17:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751523AbeDERfA (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 13:35:00 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38382 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751439AbeDERey (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 5 Apr 2018 13:34:54 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w35HWY5E021383;
        Thu, 5 Apr 2018 10:34:49 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2h277s7bsn-1;
        Thu, 05 Apr 2018 10:34:48 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id D63022212A74;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
Received: from newren2-linux.yojoe.local (unknown [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id CD5252CDEB1;
        Thu,  5 Apr 2018 10:34:48 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     sxlijin@gmail.com, peff@peff.net, Elijah Newren <newren@gmail.com>
Subject: [RFC PATCH 3/7] t7300: Add some testcases showing failure to clean specified pathspecs
Date:   Thu,  5 Apr 2018 10:34:42 -0700
Message-Id: <20180405173446.32372-4-newren@gmail.com>
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
 mlxlogscore=897 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1711220000 definitions=main-1804050181
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Someone brought me a testcase where multiple git-clean invocations were
required to clean out unwanted files:
  mkdir d{1,2}
  touch d{1,2}/ut
  touch d1/t && git add d1/t
With this setup, the user would need to run
  git clean -ffd */ut
twice to delete both ut files.

A little testing showed some interesting variants:
  * If only one of those two ut files existed (either one), then only one
    clean command would be necessary.
  * If both directories had tracked files, then only one git clean would
    be necessary to clean both files.
  * If both directories had no tracked files then the clean command above
    would never clean either of the untracked files despite the pathspec
    explicitly calling both of them out.

A bisect showed that the failure to clean out the files started with
commit cf424f5fd89b ("clean: respect pathspecs with "-d"", 2014-03-10).
However, that pointed to a separate issue: while the "-d" flag was used
by the original user who showed me this problem, that flag should have
been irrelevant to this problem.  Testing again without the "-d" flag
showed that the same buggy behavior exists without using that flag, and
has in fact existed since before cf424f5fd89b.

Add testcases showing that multiple untracked files within entirely
untracked directories cannot be cleaned when specifying these files to
git clean via pathspecs.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 7b36954d63..3d260e21ea 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -669,4 +669,36 @@ test_expect_success 'git clean -d skips untracked dirs containing ignored files'
 	test_path_is_missing foo/b/bb
 '
 
+test_expect_failure 'git clean handles being told what to clean' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -f */ut &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean handles being told what to clean, with -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -ffd */ut &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean handles being told a glob to clean' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -f "*ut" &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
+test_expect_failure 'git clean handles being told a glob to clean with -d' '
+	mkdir -p d1 d2 &&
+	touch d1/ut d2/ut &&
+	git clean -ffd "*ut" &&
+	test_path_is_missing d1/ut &&
+	test_path_is_missing d2/ut
+'
+
 test_done
-- 
2.17.0.7.g0b50f94d69

