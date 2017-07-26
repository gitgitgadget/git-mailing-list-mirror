Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7885320899
	for <e@80x24.org>; Wed, 26 Jul 2017 10:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751790AbdGZK1s (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 06:27:48 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:8741 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751446AbdGZK1m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 06:27:42 -0400
Received: from lindisfarne.localdomain ([92.22.28.33])
        by smtp.talktalk.net with SMTP
        id aJXGd63uhZtcPaJXYd3j2R; Wed, 26 Jul 2017 11:27:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net; s=1605;
        t=1501064861; bh=XBInHtIPCxajeaorSJKOBcru/Z7Pn2zyq4yeO4gJtbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:Reply-To;
        b=t237JJfjeg4AkCqjiQkcPzDEksUDpwkuqw6MmMrSDL+7faHzIYxrIUJ4aSkuABJ0K
         Vkt1U8PdYTC0tcR6ECLpdU7d884HRMW6gCi5GgAECc8qw6Tf/WkVk858JR5dU60evt
         hIJMvaXAMes2qjPzyZ7sOGz1o2F56xLcp6NyzBmc=
X-Originating-IP: [92.22.28.33]
X-Spam: 0
X-OAuthority: v=2.2 cv=QqEc5h6d c=1 sm=1 tr=0 a=BeSdjzhxhZnKGFP9cxuqMA==:117
 a=BeSdjzhxhZnKGFP9cxuqMA==:17 a=evINK-nbAAAA:8 a=LxcRjRspXMipnZN7BDUA:9
 a=XkY4GQz6Tx3TGL4s:21 a=xbthA605ZwEyxH9X:21 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [RFC PATCH 5/5] Add rebase.continue.autostage config setting
Date:   Wed, 26 Jul 2017 11:27:20 +0100
Message-Id: <20170726102720.15274-6-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170726102720.15274-1-phillip.wood@talktalk.net>
References: <20170726102720.15274-1-phillip.wood@talktalk.net>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfI1tAoxYT+HYhMj6t0J6e5sbSXbyxjSsVDjPTqJsCBF86u5NIF9B8ZPQQXiAYF4WtSnk8Ai7dWKDhNu96Ofmnmmup2Rkya4AvycCeCE52zdBksfdCccf
 8XzkZwDVhNIYM2wNeSiVhWY9JM+WGey949eIEHQei5tnXch2Hfi5PPd/IRZ+N1/wjV+4XGRVZsoxLOWee+Hkbu5/226VkeWHk1V9AJBOTgx6H4ilLLp0x+C5
 embbJZdNtYJcqlzPDFY6HyBh0oPS3aJkTOncSXwf8JPuY35CjiJ+YFtddCzrx098
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

This enables the user to always specify --autostage with --continue

The tests check that setting rebase.continue.autostage=true results in
'git rebase --continue' autostaging unstaged changes and that
'--no-autostage' overrides it.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-rebase.sh              |  2 +-
 t/t3418-rebase-continue.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index 9ca387349b1cde440c4244de9125446fd35a7b67..632a19079ba1d88092f47121c7a0797af079aaf5 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -70,7 +70,7 @@ merge_dir="$GIT_DIR"/rebase-merge
 apply_dir="$GIT_DIR"/rebase-apply
 verbose=
 diffstat=
-autostage=false
+autostage=$(git config --bool --get rebase.continue.autostage || echo false)
 test "$(git config --bool rebase.stat)" = true && diffstat=t
 autostash="$(git config --bool rebase.autostash || echo false)"
 fork_point=auto
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index 4e71e5d5c2f26866cd5d32bfea445f899398d6c9..7c2a30a3cd8ba7e33519bd68a3f89e90409169da 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -67,6 +67,21 @@ test_autostage () {
 		git reset -- F2 &&
 		test_must_fail git rebase --continue --autostage
 	'
+
+	test_expect_success "rebase.continue.autostage rebase $action works" '
+		reset &&
+		test_must_fail git rebase $action --onto master master topic &&
+		echo "Resolved" >F2 &&
+		git -c rebase.continue.autostage=true rebase --continue
+'
+
+	test_expect_success "rebase $action --continue --no-autostage works" '
+		reset &&
+		test_must_fail git rebase $action --onto master master topic &&
+		echo "Resolved" >F2 &&
+		test_must_fail git -c rebase.continue.autostage=true rebase --continue --no-autostage
+'
+
 }
 
 test_autostage
-- 
2.13.3

