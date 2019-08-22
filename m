Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2BAED1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 22:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404836AbfHVWBV (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 18:01:21 -0400
Received: from relay10.mail.gandi.net ([217.70.178.230]:43627 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404199AbfHVWBT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 18:01:19 -0400
Received: from localhost.localdomain (unknown [1.186.12.26])
        (Authenticated sender: me@yadavpratyush.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 611BA240008;
        Thu, 22 Aug 2019 22:01:16 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     <git@vger.kernel.org>
Cc:     Pratyush Yadav <me@yadavpratyush.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH v2 2/4] git-gui: Add option to disable the revert confirmation prompt
Date:   Fri, 23 Aug 2019 03:31:05 +0530
Message-Id: <20190822220107.4153-3-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190822220107.4153-1-me@yadavpratyush.com>
References: <20190819214110.26461-1-me@yadavpratyush.com>
 <20190822220107.4153-1-me@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When reverting files (or hunks or lines that future commits will add), a
confirmation dialog is shown to make sure the user actually wanted to
revert, and did not accidentally click revert.

But for some people's workflow this is an hindrance. So add an option to
disable this behaviour for people who are comfortable risking accidental
reverts.

The default behaviour is to ask for confirmation.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui.sh     |  1 +
 lib/index.tcl  | 22 +++++++++++++---------
 lib/option.tcl |  1 +
 3 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5bc21b8..b7811d8 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -903,6 +903,7 @@ set font_descs {
 }
 set default_config(gui.stageuntracked) ask
 set default_config(gui.displayuntracked) true
+set default_config(gui.revertaskconfirmation) true
 
 ######################################################################
 ##
diff --git a/lib/index.tcl b/lib/index.tcl
index cb7f74a..dd694d1 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -389,15 +389,19 @@ proc do_add_all {} {
 }
 
 proc revert_dialog {query} {
-	return [tk_dialog \
-		.confirm_revert \
-		"[appname] ([reponame])" \
-		"$query" \
-		question \
-		1 \
-		[mc "Do Nothing"] \
-		[mc "Revert Changes"] \
-		]
+	if {[is_config_true gui.revertaskconfirmation]} {
+		return [tk_dialog \
+			.confirm_revert \
+			"[appname] ([reponame])" \
+			"$query" \
+			question \
+			1 \
+			[mc "Do Nothing"] \
+			[mc "Revert Changes"] \
+			]
+	} else {
+		return 1
+	}
 }
 
 proc revert_helper {txt paths} {
diff --git a/lib/option.tcl b/lib/option.tcl
index e43971b..cb62d5d 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -162,6 +162,7 @@ proc do_options {} {
 		{s gui.stageuntracked {mc "Staging of untracked files"} {list "yes" "no" "ask"}}
 		{b gui.displayuntracked {mc "Show untracked files"}}
 		{i-1..99 gui.tabsize {mc "Tab spacing"}}
+		{b gui.revertaskconfirmation {mc "Ask for confirmation when reverting changes"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
-- 
2.21.0

