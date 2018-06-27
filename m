Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 022DD1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 07:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753372AbeF0Hgf (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 03:36:35 -0400
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:38190 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752997AbeF0Hge (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 27 Jun 2018 03:36:34 -0400
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w5R7WaFU031173;
        Wed, 27 Jun 2018 00:36:25 -0700
Authentication-Results: palantir.com;
        spf=softfail smtp.mailfrom=newren@gmail.com
Received: from smtp-transport.yojoe.local (mxw3.palantir.com [66.70.54.23] (may be forged))
        by mx0a-00153501.pphosted.com with ESMTP id 2ju94mth2t-1;
        Wed, 27 Jun 2018 00:36:25 -0700
Received: from mxw1.palantir.com (smtp.yojoe.local [172.19.0.45])
        by smtp-transport.yojoe.local (Postfix) with ESMTP id 9CBC42230EC9;
        Wed, 27 Jun 2018 00:36:25 -0700 (PDT)
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp.yojoe.local (Postfix) with ESMTP id 915812CDEEA;
        Wed, 27 Jun 2018 00:36:25 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        johannes.schindelin@gmx.de, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 1/2] t3418: add testcase showing problems with rebase -i and strategy options
Date:   Wed, 27 Jun 2018 00:36:22 -0700
Message-Id: <20180627073623.31725-2-newren@gmail.com>
X-Mailer: git-send-email 2.18.0.9.g431b2c36d5
In-Reply-To: <20180627073623.31725-1-newren@gmail.com>
References: <20180607050845.19779-1-newren@gmail.com>
 <20180627073623.31725-1-newren@gmail.com>
X-Proofpoint-SPF-Result: softfail
X-Proofpoint-SPF-Record: v=spf1 redirect=_spf.google.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-27_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1806210000 definitions=main-1806270089
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We are not passing the same args to merge strategies when we are doing an
--interactive rebase as we do with a --merge rebase.  The merge strategy
should not need to be aware of which type of rebase is in effect.  Add a
testcase which checks for the appropriate args.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3418-rebase-continue.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 03bf1b8a3b..872022106f 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -74,6 +74,38 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
 	test -f funny.was.run
 '
 
+test_expect_failure 'rebase -i --continue handles merge strategy and options' '
+	rm -fr .git/rebase-* &&
+	git reset --hard commit-new-file-F2-on-topic-branch &&
+	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&
+	test_when_finished "rm -fr test-bin funny.was.run funny.args" &&
+	mkdir test-bin &&
+	cat >test-bin/git-merge-funny <<-EOF &&
+	#!$SHELL_PATH
+	echo "\$@" >>funny.args
+	case "\$1" in --opt) ;; *) exit 2 ;; esac
+	case "\$2" in --foo) ;; *) exit 2 ;; esac
+	case "\$4" in --) ;; *) exit 2 ;; esac
+	shift 2 &&
+	>funny.was.run &&
+	exec git merge-recursive "\$@"
+	EOF
+	chmod +x test-bin/git-merge-funny &&
+	(
+		PATH=./test-bin:$PATH
+		test_must_fail git rebase -i -s funny -Xopt -Xfoo master topic
+	) &&
+	test -f funny.was.run &&
+	rm funny.was.run &&
+	echo "Resolved" >F2 &&
+	git add F2 &&
+	(
+		PATH=./test-bin:$PATH
+		git rebase --continue
+	) &&
+	test -f funny.was.run
+'
+
 test_expect_success 'rebase passes merge strategy options correctly' '
 	rm -fr .git/rebase-* &&
 	git reset --hard commit-new-file-F3-on-topic-branch &&
-- 
2.18.0.9.g431b2c36d5

