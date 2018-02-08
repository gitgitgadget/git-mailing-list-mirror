Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1414E1F404
	for <e@80x24.org>; Thu,  8 Feb 2018 20:43:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752218AbeBHUnh (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 15:43:37 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:48786 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751756AbeBHUng (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 15:43:36 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w18Kg9br134593
        for <git@vger.kernel.org>; Thu, 8 Feb 2018 20:43:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2017-10-26;
 bh=bg811kCaKepgtErxr0uuqjdACDI4XHzsh9G8NN0qbME=;
 b=o4lYR0ZRXD5KiIFdrHU8V/riBFisrgvIiAjTdb+HHkDw0RCZVDzVxXAu4POqLGhgnBTK
 F8gBacpsqBlv9XUPeWgWFuZoaUHbfmmSSK3+DZnluqZsoc0VvBabkmnipIol5i80ESkb
 Eg4B0jzU9mXvtRA6d8IVwPgMV1xXPg7+rt+5b4gUSBks8NP/SWEA1uCsJFHEmnQICwFA
 F0VDNsPvXWZN2u40tGbKpyy+q3Ff8m41RzzyNCHr/77ejaZpXGXNeZ+6NkABGk0PA6F2
 lTcK8MzwAZWL/Ev2Pw4QTrrATIhIUCt6n3x8dk+ikBG4hxby0l0WnFYcBqD3CYOCD1mo dg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2g0vs08aj9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 20:43:35 +0000
Received: from localhost.localdomain (dhcp-10-175-2-118.vpn.oracle.com [10.175.2.118])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w18KhXUX025833;
        Thu, 8 Feb 2018 20:43:34 GMT
From:   gregory.herrero@oracle.com
To:     git@vger.kernel.org
Cc:     Gregory Herrero <gregory.herrero@oracle.com>
Subject: [PATCH] rebase -p: fix incorrect commit message when calling `git merge`.
Date:   Thu,  8 Feb 2018 21:42:41 +0100
Message-Id: <20180208204241.19324-1-gregory.herrero@oracle.com>
X-Mailer: git-send-email 2.16.1
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8799 signatures=668665
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=48 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802080239
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gregory Herrero <gregory.herrero@oracle.com>

Since commit dd6fb0053 ("rebase -p: fix quoting when calling `git
merge`"), commit message of the merge commit being rebased is passed to
the merge command using a subshell executing 'git rev-parse --sq-quote'.

Double quotes are needed around this subshell so that, newlines are
kept for the git merge command.

Before this patch, following merge message:

    "Merge mybranch into mynewbranch

    Awesome commit."

becomes:

    "Merge mybranch into mynewbranch Awesome commit."

after a rebase -p.

Fixes: "dd6fb0053 rebase -p: fix quoting when calling `git merge`"
Reported-by: Jamie Iles <jamie.iles@oracle.com>
Suggested-by: Vegard Nossum <vegard.nossum@oracle.com>
Suggested-by: Quentin Casasnovas <quentin.casasnovas@oracle.com>
Signed-off-by: Gregory Herrero <gregory.herrero@oracle.com>
---
 git-rebase--interactive.sh   |  2 +-
 t/t3408-rebase-multi-line.sh | 26 +++++++++++++++++++++++++-
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index d47bd2959..ab6a5883e 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -396,7 +396,7 @@ pick_one_preserving_merges () {
 					--sq-quote "$gpg_sign_opt")} \
 				$allow_rerere_autoupdate "$merge_args" \
 				"$strategy_args" \
-				-m $(git rev-parse --sq-quote "$msg_content") \
+				-m "$(git rev-parse --sq-quote "$msg_content")" \
 				"$new_parents"
 			then
 				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
diff --git a/t/t3408-rebase-multi-line.sh b/t/t3408-rebase-multi-line.sh
index 6b84e6042..e217fb4fb 100755
--- a/t/t3408-rebase-multi-line.sh
+++ b/t/t3408-rebase-multi-line.sh
@@ -24,8 +24,23 @@ But otherwise with a sane description." &&
 	>elif &&
 	git add elif &&
 	test_tick &&
-	git commit -m second
+	git commit -m second &&
 
+	git checkout -b side2 &&
+	>afile &&
+	git add afile &&
+	test_tick &&
+	git commit -m third &&
+	echo hello > afile &&
+	test_tick &&
+	git commit -a -m fourth &&
+	git checkout -b side-merge &&
+	git reset --hard HEAD^^ &&
+	git merge --no-ff -m "A merge commit log message that has a long
+summary that spills over multiple lines.
+
+But otherwise with a sane description." side2 &&
+	git branch side-merge-original
 '
 
 test_expect_success rebase '
@@ -36,6 +51,15 @@ test_expect_success rebase '
 	git cat-file commit side@{1} | sed -e "1,/^\$/d" >expect &&
 	test_cmp expect actual
 
+'
+test_expect_success rebasep '
+
+	git checkout side-merge &&
+	git rebase -p side &&
+	git cat-file commit HEAD | sed -e "1,/^\$/d" >actual &&
+	git cat-file commit side-merge-original | sed -e "1,/^\$/d" >expect &&
+	test_cmp expect actual
+
 '
 
 test_done
-- 
2.16.1

