Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E8FC4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 09:44:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D9423A63
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 09:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389020AbgLRJos (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 04:44:48 -0500
Received: from dd36226.kasserver.com ([85.13.153.21]:51520 "EHLO
        dd36226.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgLRJoq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 04:44:46 -0500
Received: from client3368.fritz.box (i5C747512.versanet.de [92.116.117.18])
        by dd36226.kasserver.com (Postfix) with ESMTPA id CD9673C01DE;
        Fri, 18 Dec 2020 10:44:00 +0100 (CET)
From:   Stefan Haller <stefan@haller-berlin.de>
To:     me@yadavpratyush.com
Cc:     serg.partizan@gmail.com, git@vger.kernel.org
Subject: [PATCH v3] git-gui: use gray background for inactive text widgets
Date:   Fri, 18 Dec 2020 10:43:14 +0100
Message-Id: <20201218094314.22138-1-stefan@haller-berlin.de>
X-Mailer: git-send-email 2.29.0.21.g59e7d82785.dirty
In-Reply-To: <20201217214912.ycp7bidcyqwzslxy@yadavpratyush.com>
References: <20201217214912.ycp7bidcyqwzslxy@yadavpratyush.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This makes it easier to see at a glance which of the four main views has the
keyboard focus.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
Hi Pratyush,

here's a rerolled version with added Signed-off-by and using local variables for
inactive_select_bg and inactive_select_bg, hoping this might save you some time.
Let me know if this is what you had in mind, I wasn't totally sure.

 git-gui.sh     | 18 ++++++++++++------
 lib/themed.tcl | 35 +++++++++++++++++++++++++----------
 2 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index cc6c2aa..201524c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -720,9 +720,6 @@ proc rmsel_tag {text} {
 		-background [$text cget -background] \
 		-foreground [$text cget -foreground] \
 		-borderwidth 0
-	$text tag conf in_sel\
-		-background $color::select_bg \
-		-foreground $color::select_fg
 	bind $text <Motion> break
 	return $text
 }
@@ -3328,11 +3325,20 @@ if {!$use_ttk} {
 	.vpane.files paneconfigure .vpane.files.index -sticky news
 }

+proc set_selection_colors {w has_focus} {
+	foreach tag [list in_diff in_sel] {
+		$w tag conf $tag \
+			-background [expr {$has_focus ? $color::select_bg : $color::inactive_select_bg}] \
+			-foreground [expr {$has_focus ? $color::select_fg : $color::inactive_select_fg}]
+	}
+}
+
 foreach i [list $ui_index $ui_workdir] {
 	rmsel_tag $i
-	$i tag conf in_diff \
-		-background $color::select_bg \
-		-foreground $color::select_fg
+
+	set_selection_colors $i 0
+	bind $i <FocusIn>	{ set_selection_colors %W 1 }
+	bind $i <FocusOut>	{ set_selection_colors %W 0 }
 }
 unset i

diff --git a/lib/themed.tcl b/lib/themed.tcl
index 244c061..0f6575a 100644
--- a/lib/themed.tcl
+++ b/lib/themed.tcl
@@ -6,19 +6,25 @@ namespace eval color {
 	# Variable colors
 	# Preffered way to set widget colors is using add_option.
 	# In some cases, like with tags in_diff/in_sel, we use these colors.
-	variable select_bg		lightgray
-	variable select_fg		black
+	variable select_bg				lightgray
+	variable select_fg				black
+	variable inactive_select_bg		lightgray
+	variable inactive_select_fg		black

 	proc sync_with_theme {} {
-		set base_bg		[ttk::style lookup . -background]
-		set base_fg		[ttk::style lookup . -foreground]
-		set text_bg		[ttk::style lookup Treeview -background]
-		set text_fg		[ttk::style lookup Treeview -foreground]
-		set select_bg	[ttk::style lookup Default -selectbackground]
-		set select_fg	[ttk::style lookup Default -selectforeground]
+		set base_bg		        [ttk::style lookup . -background]
+		set base_fg		        [ttk::style lookup . -foreground]
+		set text_bg		        [ttk::style lookup Treeview -background]
+		set text_fg		        [ttk::style lookup Treeview -foreground]
+		set select_bg	        [ttk::style lookup Default -selectbackground]
+		set select_fg	        [ttk::style lookup Default -selectforeground]
+		set inactive_select_bg	[convert_rgb_to_gray $select_bg]
+		set inactive_select_fg 	$select_fg

 		set color::select_bg $select_bg
 		set color::select_fg $select_fg
+		set color::inactive_select_bg $inactive_select_bg
+		set color::inactive_select_fg $inactive_select_fg

 		proc add_option {key val} {
 			option add $key $val widgetDefault
@@ -36,11 +42,20 @@ namespace eval color {
 		add_option *Text.Foreground $text_fg
 		add_option *Text.selectBackground $select_bg
 		add_option *Text.selectForeground $select_fg
-		add_option *Text.inactiveSelectBackground $select_bg
-		add_option *Text.inactiveSelectForeground $select_fg
+		add_option *Text.inactiveSelectBackground $inactive_select_bg
+		add_option *Text.inactiveSelectForeground $inactive_select_fg
 	}
 }

+proc convert_rgb_to_gray {rgb} {
+	# Simply take the average of red, green and blue. This wouldn't be good
+	# enough for, say, converting a photo to grayscale, but for this simple
+	# purpose of approximating the brightness of a color it's good enough.
+	lassign [winfo rgb . $rgb] r g b
+	set gray [expr {($r / 256 + $g / 256 + $b / 256) / 3}]
+	return [format "#%2.2X%2.2X%2.2X" $gray $gray $gray]
+}
+
 proc ttk_get_current_theme {} {
 	# Handle either current Tk or older versions of 8.5
 	if {[catch {set theme [ttk::style theme use]}]} {
--
2.29.0.21.g59e7d82785.dirty

