Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3369D1F453
	for <e@80x24.org>; Tue, 29 Jan 2019 01:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbfA2BkG (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 20:40:06 -0500
Received: from mx0a-00153501.pphosted.com ([67.231.148.48]:37306 "EHLO
        mx0a-00153501.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726867AbfA2Bj4 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jan 2019 20:39:56 -0500
Received: from pps.filterd (m0096528.ppops.net [127.0.0.1])
        by mx0a-00153501.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x0T1be0C007205;
        Mon, 28 Jan 2019 17:39:50 -0800
Received: from mail.palantir.com ([198.97.14.70])
        by mx0a-00153501.pphosted.com with ESMTP id 2q8nartuhc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Mon, 28 Jan 2019 17:39:50 -0800
Received: from dc-prod-exch-01.YOJOE.local (10.193.18.14) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1531.3; Mon, 28 Jan 2019 20:39:48 -0500
Received: from smtp-transport.yojoe.local (10.129.56.124) by
 dc-prod-exch-01.YOJOE.local (10.193.18.14) with Microsoft SMTP Server id
 15.1.1531.3 via Frontend Transport; Mon, 28 Jan 2019 20:39:48 -0500
Received: from newren2-linux.yojoe.local (newren2-linux.pa.palantir.tech [10.100.71.66])
        by smtp-transport.yojoe.local (Postfix) with ESMTPS id D8978220F6DC;
        Mon, 28 Jan 2019 17:39:47 -0800 (PST)
From:   Elijah Newren <newren@gmail.com>
To:     <gitster@pobox.com>
CC:     <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v5 3/8] t5407: add a test demonstrating how interactive handles --skip differently
Date:   Mon, 28 Jan 2019 17:39:40 -0800
Message-ID: <20190129013945.17336-4-newren@gmail.com>
X-Mailer: git-send-email 2.20.1.310.g17ca096f17
In-Reply-To: <20190129013945.17336-1-newren@gmail.com>
References: <20181211161139.31686-1-newren@gmail.com>
 <20190129013945.17336-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-01-29_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=4 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1034 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1901290009
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

Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
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
2.20.1.310.g17ca096f17

