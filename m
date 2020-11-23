Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76B84C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 11:48:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F38720756
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 11:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728972AbgKWLsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:48:16 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:55040 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728893AbgKWLsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 06:48:16 -0500
Received: from client3368.fritz.box (i5C7462D2.versanet.de [92.116.98.210])
        by dd36226.kasserver.com (Postfix) with ESMTPA id 64F903C018B;
        Mon, 23 Nov 2020 12:48:13 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     serg.partizan@gmail.com
Cc:     me@yadavpratyush.com, git@vger.kernel.org
Subject: [PATCH] git-gui: use gray selection background for inactive text widgets
Date:   Mon, 23 Nov 2020 12:48:05 +0100
Message-Id: <20201123114805.48800-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.18.gf8c967e53c
In-Reply-To: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
References: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22.11.20 18:16, serg.partizan@gmail.com wrote:
> I think calculating that gray color from current selection bg is too much work
> for just one color.
>
> We can just set inactiveSelectBackground to some neutral gray color like
> #707070 or #909090 which will work fine with both dark and light themes.

OK, fine with me. Here's a patch that does this (it sits on top of yours). It
almost works, except for one problem: on Mac, the inactive selection background
is white instead of lightgray, but only for the diff view; for the commit editor
it's correct. On Windows it's also correct for both views. I can't figure out
what's the difference on Mac; do you have an idea what could be wrong?

--- 8< ---

This makes it easier to see at a glance which of the four main views has the
keyboard focus.
---
 git-gui.sh     | 25 +++++++++++++++++++++----
 lib/themed.tcl | 13 +++++++++----
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 867b8ce..a8c5cad 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -721,8 +721,8 @@ proc rmsel_tag {text} {
 		-foreground [$text cget -foreground] \
 		-borderwidth 0
 	$text tag conf in_sel\
-		-background $color::select_bg \
-		-foreground $color::select_fg
+		-background $color::inactive_select_bg \
+		-foreground $color::inactive_select_fg
 	bind $text <Motion> break
 	return $text
 }
@@ -3325,8 +3325,25 @@ if {!$use_ttk} {
 foreach i [list $ui_index $ui_workdir] {
 	rmsel_tag $i
 	$i tag conf in_diff \
-		-background $color::select_bg \
-		-foreground $color::select_fg
+		-background $color::inactive_select_bg \
+		-foreground $color::inactive_select_fg
+
+	if {$use_ttk} {
+		bind $i <FocusIn> {
+			foreach tag [list in_diff in_sel] {
+				%W tag conf $tag \
+					-background $color::select_bg \
+					-foreground $color::select_fg
+			}
+		}
+		bind $i <FocusOut> {
+			foreach tag [list in_diff in_sel] {
+				%W tag conf $tag \
+					-background $color::inactive_select_bg \
+					-foreground $color::inactive_select_fg
+			}
+		}
+	}
 }
 unset i

diff --git a/lib/themed.tcl b/lib/themed.tcl
index eda5f8c..02b15f2 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -6,8 +6,10 @@ namespace eval color {
 	# Variable colors
 	# Preffered way to set widget colors is using add_option.
 	# In some cases, like with tags in_diff/in_sel, we use these colors.
-	variable select_bg		lightgray
-	variable select_fg		black
+	variable select_bg				lightblue
+	variable select_fg				black
+	variable inactive_select_bg		lightgray
+	variable inactive_select_fg		black

 	proc sync_with_theme {} {
 		set base_bg		[ttk::style lookup . -background]
@@ -16,6 +18,9 @@ namespace eval color {
 		set text_fg		[ttk::style lookup Treeview -foreground]
 		set select_bg	[ttk::style lookup Default -selectbackground]
 		set select_fg	[ttk::style lookup Default -selectforeground]
+		# We keep inactive_select_bg as the hard-coded light gray above, as
+		# there doesn't seem to be a way to get it from the theme. Light gray
+		# should work well for light and dark themes.

 		set color::select_bg $select_bg
 		set color::select_fg $select_fg
@@ -36,8 +41,8 @@ namespace eval color {
 		add_option *Text.Foreground $text_fg
 		add_option *Text.selectBackground $select_bg
 		add_option *Text.selectForeground $select_fg
-		add_option *Text.inactiveSelectBackground $select_bg
-		add_option *Text.inactiveSelectForeground $select_fg
+		add_option *Text.inactiveSelectBackground $color::inactive_select_bg
+		add_option *Text.inactiveSelectForeground $color::inactive_select_fg
 	}
 }

--
2.29.0.18.gf8c967e53c

