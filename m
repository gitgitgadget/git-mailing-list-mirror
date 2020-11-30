Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 619B8C63777
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:19:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14263207F7
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 20:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbgK3UTc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 15:19:32 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:44616 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbgK3UTc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 15:19:32 -0500
Received: from client3368.fritz.box (i5C746518.versanet.de [92.116.101.24])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 950AD3C2024;
        Mon, 30 Nov 2020 21:18:50 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     serg.partizan@gmail.com, git@vger.kernel.org
Subject: [PATCH] git-gui: keep showing selection when diff view gets deactivated on Mac
Date:   Mon, 30 Nov 2020 21:18:37 +0100
Message-Id: <20201130201837.19091-2-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.21.g59e7d82785.dirty
In-Reply-To: <20201130201837.19091-1-stefan@haller-berlin.de>
References: <20201130180827.2oimhr3vmjq7tzaq@yadavpratyush.com>
 <20201130201837.19091-1-stefan@haller-berlin.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mac, Tk text widgets don't draw the selection when they are inactive and
disabled [1]. This causes the diff selection to disappear on Mac when the diff
view loses focus.

To work around that, we configure text views to be enabled when they become
deactivated. While this feels wrong, there's not problem with it because as soon
as the user tries to interact with the view, the first thing that happens is
that it gets disabled again.

[1] https://github.com/tcltk/tk/blob/main/generic/tkTextDisp.c#L847

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 lib/themed.tcl | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/lib/themed.tcl b/lib/themed.tcl
index db49085..eeb5bf8 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -302,6 +302,38 @@ proc tspinbox {w args} {
 	}
 }

+proc focus_text {w} {
+	global text_states
+
+	[winfo parent $w] state focus
+
+	if {[is_MacOSX]} {
+		# Restore the disabled state that we remembered for this widget when it
+		# got deactivated last. If there's no remembered state, then this is the
+		# first time we are being activated right after construction, and
+		# there's no need to change the state.
+		if {[info exists text_states($w)]} {
+			$w configure -state $text_states($w)
+			unset text_states($w)
+		}
+	}
+}
+
+proc unfocus_text {w} {
+	global text_states
+
+	[winfo parent $w] state !focus
+
+	if {[is_MacOSX]} {
+		# On Mac, the selection is not drawn when a text widget is inactive and
+		# disabled. To work around that, set the disabled state back to normal
+		# when deactivating the widget. Remember the disabled state so that we
+		# can restore it when we become active again.
+		set text_states($w) [lindex [$w configure -state] end]
+		$w configure -state normal
+	}
+}
+
 # Create a text widget with any theme specific properties.
 proc ttext {w args} {
 	global use_ttk
@@ -315,8 +347,8 @@ proc ttext {w args} {
 	set w [eval [linsert $args 0 text $w]]
 	if {$use_ttk} {
 		if {[winfo class [winfo parent $w]] eq "EntryFrame"} {
-			bind $w <FocusIn> {[winfo parent %W] state focus}
-			bind $w <FocusOut> {[winfo parent %W] state !focus}
+			bind $w <FocusIn> {focus_text %W}
+			bind $w <FocusOut> {unfocus_text %W}
 		}
 	}
 	return $w
--
2.29.0.21.g59e7d82785.dirty

