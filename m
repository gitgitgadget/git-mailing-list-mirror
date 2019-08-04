Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 569E31F731
	for <e@80x24.org>; Sun,  4 Aug 2019 14:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfHDOjb (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Aug 2019 10:39:31 -0400
Received: from relay6-d.mail.gandi.net ([217.70.183.198]:42413 "EHLO
        relay6-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbfHDOjb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Aug 2019 10:39:31 -0400
X-Originating-IP: 1.186.12.38
Received: from localhost.localdomain (unknown [1.186.12.38])
        (Authenticated sender: me@yadavpratyush.com)
        by relay6-d.mail.gandi.net (Postfix) with ESMTPSA id 1B049C0003;
        Sun,  4 Aug 2019 14:39:27 +0000 (UTC)
From:   Pratyush Yadav <me@yadavpratyush.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Pratyush Yadav <me@yadavpratyush.com>
Subject: [PATCH] git-gui: Call do_quit before destroying the main window
Date:   Sun,  4 Aug 2019 20:09:19 +0530
Message-Id: <20190804143919.10732-1-me@yadavpratyush.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the toplevel window for the window being destroyed is the main window
(aka "."), then simply destroying it means the cleanup tasks are not
executed like saving the commit message buffer, saving window state,
etc. All this is handled by do_quit so, call it instead of directly
destroying the main window. For other toplevel windows, the old behavior
remains.

Signed-off-by: Pratyush Yadav <me@yadavpratyush.com>
---
 git-gui/git-gui.sh | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 6de74ce639..6ec562d5da 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3030,8 +3030,23 @@ unset doc_path doc_url
 wm protocol . WM_DELETE_WINDOW do_quit
 bind all <$M1B-Key-q> do_quit
 bind all <$M1B-Key-Q> do_quit
-bind all <$M1B-Key-w> {destroy [winfo toplevel %W]}
-bind all <$M1B-Key-W> {destroy [winfo toplevel %W]}
+
+set m1b_w_script {
+	set toplvl_win [winfo toplevel %W]
+
+	# If we are destroying the main window, we should call do_quit to take
+	# care of cleanup before exiting the program.
+	if {$toplvl_win eq "."} {
+		do_quit
+	} else {
+		destroy $toplvl_win
+	}
+}
+
+bind all <$M1B-Key-w> $m1b_w_script
+bind all <$M1B-Key-W> $m1b_w_script
+
+unset m1b_w_script
 
 set subcommand_args {}
 proc usage {} {
-- 
2.21.0

