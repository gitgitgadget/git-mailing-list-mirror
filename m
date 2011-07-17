From: David Fries <david@fries.net>
Subject: Re: [PATCH 1/2] git-gui blame, add a Control-G goto line option
Date: Sat, 16 Jul 2011 20:47:14 -0500
Message-ID: <20110717014714.GD26701@spacedout.fries.net>
References: <20110716165850.GA9694@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 17 03:47:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QiGSE-0002gL-B8
	for gcvg-git-2@lo.gmane.org; Sun, 17 Jul 2011 03:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab1GQBrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 21:47:20 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:58514 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755619Ab1GQBrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 21:47:18 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id p6H1lFs1015768
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 16 Jul 2011 20:47:15 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id p6H1lEkF015767;
	Sat, 16 Jul 2011 20:47:14 -0500
Content-Disposition: inline
In-Reply-To: <20110716165850.GA9694@spacedout.fries.net>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Sat, 16 Jul 2011 20:47:15 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177289>

Add a goto input field to jump to the specified line similar to the             current search field.

Signed-off-by: David Fries <David@Fries.net>
---
This version hides the goto widget when pressing return or escape.
Patch 2/2 is unchanged.

 git-gui/lib/blame.tcl |   11 ++++++++
 git-gui/lib/line.tcl  |   64 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 0 deletions(-)
 create mode 100644 git-gui/lib/line.tcl

diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
index 61e358f..062091b 100644
--- a/git-gui/lib/blame.tcl
+++ b/git-gui/lib/blame.tcl
@@ -22,6 +22,7 @@ field w_asim     ; # text column: annotations (simple computation)
 field w_file     ; # text column: actual file data
 field w_cviewer  ; # pane showing commit message
 field finder     ; # find mini-dialog frame
+field gotoline   ; # line goto mini-dialog frame
 field status     ; # status mega-widget instance
 field old_height ; # last known height of $w.file_pane
 
@@ -231,6 +232,11 @@ constructor new {i_commit i_path i_jump} {
 		-column [expr {[llength $w_columns] - 1}] \
 		]
 
+	set gotoline [::linebar::new \
+		$w.file_pane.out.lf $w_file \
+		-column [expr {[llength $w_columns] - 1}] \
+		]
+
 	set w_cviewer $w.file_pane.cm.t
 	text $w_cviewer \
 		-background white \
@@ -275,6 +281,10 @@ constructor new {i_commit i_path i_jump} {
 		-label [mc "Find Text..."] \
 		-accelerator F7 \
 		-command [list searchbar::show $finder]
+	$w.ctxm add command \
+		-label [mc "Goto Line..."] \
+		-accelerator Control-Key-g \
+		-command [list linebar::show $gotoline]
 	menu $w.ctxm.enc
 	build_encoding_menu $w.ctxm.enc [cb _setencoding]
 	$w.ctxm add cascade \
@@ -345,6 +355,7 @@ constructor new {i_commit i_path i_jump} {
 	bind $top       <Escape>     [list searchbar::hide $finder]
 	bind $top       <F3>         [list searchbar::find_next $finder]
 	bind $top       <Shift-F3>   [list searchbar::find_prev $finder]
+	bind $top    <Control-Key-g> [list linebar::show $gotoline]
 	catch { bind $top <Shift-Key-XF86_Switch_VT_3> [list searchbar::find_prev $finder] }
 
 	grid configure $w.header -sticky ew
diff --git a/git-gui/lib/line.tcl b/git-gui/lib/line.tcl
new file mode 100644
index 0000000..4913bdd
--- /dev/null
+++ b/git-gui/lib/line.tcl
@@ -0,0 +1,64 @@
+# goto line number
+# based on code from gitk, Copyright (C) Paul Mackerras
+
+class linebar {
+
+field w
+field ctext
+
+field linenum   {}
+
+constructor new {i_w i_text args} {
+	global use_ttk NS
+	set w      $i_w
+	set ctext  $i_text
+
+	${NS}::frame  $w
+	${NS}::label  $w.l       -text [mc "Goto Line:"]
+	entry  $w.ent -textvariable ${__this}::linenum -background lightgreen
+	${NS}::button $w.bn      -text [mc Go] -command [cb _incrgoto]
+
+	pack   $w.l   -side left
+	pack   $w.bn  -side right
+	pack   $w.ent -side left -expand 1 -fill x
+
+	eval grid conf $w -sticky we $args
+	grid remove $w
+
+	bind $w.ent <Return> [cb _incrgoto]
+	bind $w.ent <Escape> [list linebar::hide $this]
+
+	bind $w <Destroy> [list delete_this $this]
+	return $this
+}
+
+method show {} {
+	if {![visible $this]} {
+		grid $w
+	}
+	focus -force $w.ent
+}
+
+method hide {} {
+	if {[visible $this]} {
+		focus $ctext
+		grid remove $w
+	}
+}
+
+method visible {} {
+	return [winfo ismapped $w]
+}
+
+method editor {} {
+	return $w.ent
+}
+
+method _incrgoto {} {
+	if {$linenum ne {}} {
+		$ctext see $linenum.0
+		hide $this
+	}
+}
+
+}
-- 
1.7.2.5
