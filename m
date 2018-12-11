Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7241120A1E
	for <e@80x24.org>; Tue, 11 Dec 2018 16:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730068AbeLKQME (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Dec 2018 11:12:04 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:48382 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729854AbeLKQLx (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 11 Dec 2018 11:11:53 -0500
Received: from pps.filterd (m0131697.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id wBBG8wKQ000913;
        Tue, 11 Dec 2018 08:11:46 -0800
Received: from mail.palantir.com ([8.4.231.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2p8cpp3qxq-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Tue, 11 Dec 2018 08:11:45 -0800
Received: from sj-prod-exch-01.YOJOE.local (10.129.18.26) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Tue, 11 Dec 2018 08:11:41 -0800
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 sj-prod-exch-01.YOJOE.local (10.129.18.26) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Tue, 11 Dec 2018 08:11:41 -0800
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id 167AF220EE0D;
        Tue, 11 Dec 2018 08:11:42 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <git@vger.kernel.org>
CC:     <gitster@pobox.com>, <Johannes.Schindelin@gmx.de>,
        <predatoramigo@gmail.com>, <phillip.wood@talktalk.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 3/8] t5407: add a test demonstrating how interactive handles --skip differently
Date:   Tue, 11 Dec 2018 08:11:34 -0800
Message-ID: <20181211161139.31686-4-newren@gmail.com>
X-Mailer: git-send-email 2.20.0.8.g5de428d695
In-Reply-To: <20181211161139.31686-1-newren@gmail.com>
References: <20181122044841.20993-1-newren@gmail.com>
 <20181211161139.31686-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-12-11_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1812110146
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The post-rewrite hook is documented as being invoked by commands that
rewrite commits such as commit --amend and rebase, and that it will
be called for each rewritten commit.

Apparently, the three backends handled --skip'ed commits differently:
  am: treat the skipped commit as though it weren't rewritten
  merge: same as 'am' backend
  interactive: treat skipped commits as having been rewritten to empty
     (view them as an empty fixup to their parent)

For now, just add a testcase documenting the different behavior (use
--keep to force usage of the interactive machinery even though we have
no empty commits).  A subsequent commit will remove the inconsistency in
--skip handling.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5407-post-rewrite-hook.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
index 9b2a274c71..6426ec8991 100755
--- a/t/t5407-post-rewrite-hook.sh
+++ b/t/t5407-post-rewrite-hook.sh
@@ -125,6 +125,37 @@ test_expect_success 'git rebase -m --skip' '
 	verify_hook_input
 '
 
+test_expect_success 'git rebase with implicit use of interactive backend' '
+	git reset --hard D &&
+	clear_hook_input &&
+	test_must_fail git rebase --keep --onto A B &&
+	echo C > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
+	verify_hook_input
+'
+
+test_expect_success 'git rebase --skip with implicit use of interactive backend' '
+	git reset --hard D &&
+	clear_hook_input &&
+	test_must_fail git rebase --keep --onto A B &&
+	test_must_fail git rebase --skip &&
+	echo D > foo &&
+	git add foo &&
+	git rebase --continue &&
+	echo rebase >expected.args &&
+	cat >expected.data <<-EOF &&
+	$(git rev-parse C) $(git rev-parse HEAD^)
+	$(git rev-parse D) $(git rev-parse HEAD)
+	EOF
+	verify_hook_input
+'
+
 . "$TEST_DIRECTORY"/lib-rebase.sh
 
 set_fake_editor
-- 
2.20.0.8.g5de428d695

