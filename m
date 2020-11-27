Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F407C63798
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 14:59:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6B952223F
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 14:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731012AbgK0O75 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Nov 2020 09:59:57 -0500
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42409 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbgK0O74 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Nov 2020 09:59:56 -0500
X-Originating-IP: 103.82.80.46
Received: from localhost.localdomain (unknown [103.82.80.46])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 7AFEBC0011;
        Fri, 27 Nov 2020 14:59:54 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     =?UTF-8?q?Martin=20Sch=C3=B6n?= 
        <Martin.Schoen@loewensteinmedical.de>
Subject: [PATCH v2 1/2] git-gui: Only touch GITGUI_MSG when needed
Date:   Fri, 27 Nov 2020 20:29:26 +0530
Message-Id: <20201127145927.26222-2-me@yadavpratyush.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201127145927.26222-1-me@yadavpratyush.com>
References: <20201127145927.26222-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 4e55d19 (git-gui: Cleanup end-of-line whitespace in commit messages.,
2007-01-25), the logic to decide if GITGUI_MSG should be saved or
deleted was updated to not require the commit message buffer to be
modified. This fixes a situation where if the user quits and restarts
git-gui multiple times the commit message buffer was lost.

Unfortunately, the fix was not quite correct. The check for whether the
commit message buffer has been modified is useless. If the commit is
_not_ amend, then the check is never performed. If the commit is amend,
then saving the message does not matter anyway. Amend state is destroyed
on exit and the next time git-gui is opened it starts from scratch, but
with the older message retained in the buffer. If amend is selected,
the current message is over-written by the amend commit's message.

The correct fix would be to not touch GITGUI_MSG at all if the commit
message buffer is not modified. This way, the file is not deleted even
on multiple restarts. It has the added benefit of not writing the file
unnecessarily on every exit.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 867b8ce..8ee67e6 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2305,11 +2305,10 @@ proc do_quit {{rc {1}}} {
 		if {$GITGUI_BCK_exists && ![$ui_comm edit modified]} {
 			file rename -force [gitdir GITGUI_BCK] $save
 			set GITGUI_BCK_exists 0
-		} else {
+		} elseif {[$ui_comm edit modified]} {
 			set msg [string trim [$ui_comm get 0.0 end]]
 			regsub -all -line {[ \r\t]+$} $msg {} msg
-			if {(![string match amend* $commit_type]
-				|| [$ui_comm edit modified])
+			if {![string match amend* $commit_type]
 				&& $msg ne {}} {
 				catch {
 					set fd [open $save w]
-- 
2.29.2

