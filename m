Return-Path: <SRS0=ovBw=4T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0A4CC3F2D1
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:35:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C629720842
	for <git@archiver.kernel.org>; Mon,  2 Mar 2020 18:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbgCBSfw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Mar 2020 13:35:52 -0500
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:41467 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbgCBSfw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Mar 2020 13:35:52 -0500
X-Originating-IP: 103.227.97.205
Received: from localhost.localdomain (unknown [103.227.97.205])
        (Authenticated sender: me@yadavpratyush.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id 9ADE51BF20A;
        Mon,  2 Mar 2020 18:35:39 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Jonathan Gilbert <JonathanG@iQmetrix.com>,
        Benjamin Poirier <benjamin.poirier@gmail.com>
Subject: [PATCH] git-gui: fix error popup when doing blame -> "Show History Context"
Date:   Tue,  3 Mar 2020 00:05:38 +0530
Message-Id: <20200302183538.7195-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In d9c6469 (git-gui: update status bar to track operations, 2019-12-01)
the call to 'ui_status' in 'do_gitk' was updated to create the newly
introduced "status bar operation". This allowed this status text so show
along with other operations happening in parallel, and removed a race
between all these operations.

But in that refactor, the fact that 'ui_status' checks for the existence
of 'main_status' was overlooked. This leads to an error message popping
up when the user selects "Show History Context" from the blame window
context menu on a source line. The error occurs because when running
"blame" 'main_status' is not initialized.

So, add a check for the existence of 'main_status' in 'do_gitk'. This
fix reverts to the original behaviour. In the future, we might want to
look into a better way of telling 'do_gitk' which status bar to use.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index f41ed2e..d939844 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2205,11 +2205,13 @@ proc do_gitk {revs {is_submodule false}} {
 		set env(GIT_WORK_TREE) $_gitworktree
 		cd $pwd

-		set status_operation [$::main_status \
-			start \
-			[mc "Starting %s... please wait..." "gitk"]]
+		if {[info exists main_status]} {
+			set status_operation [$::main_status \
+				start \
+				[mc "Starting %s... please wait..." "gitk"]]

-		after 3500 [list $status_operation stop]
+			after 3500 [list $status_operation stop]
+		}
 	}
 }

--
2.21.1

