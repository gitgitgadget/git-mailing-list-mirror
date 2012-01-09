From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [RFC/PATCH 3/3] git-gui: support for reverting hunks and lines
Date: Mon,  9 Jan 2012 14:43:19 +0100
Message-ID: <a9ba4550a29d7f3c653561e7029f0920bf8eb008.1326116492.git.bert.wesarg@googlemail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
 <37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Jan 09 14:43:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkFVc-0001th-Tf
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 14:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754703Ab2AINn2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 08:43:28 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51872 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752632Ab2AINn0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 08:43:26 -0500
Received: by mail-bk0-f46.google.com with SMTP id jm19so1466451bkc.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 05:43:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :in-reply-to:references;
        bh=oP5OouFU/1r/dibUzoW3OqzvIVkYtjqrLwlVEKHuKes=;
        b=Y5U2XBGLd3vvx38opul6kQcROhh9yBrzusJIZm6OyasdFm3Go6PGHF7Bpl/fqHfgQ1
         nyZYW8iRCm9kEM5rOcgzdJ8HZ1F565UzIEPtQie2iSPgtJGZL0cKvRmG5fDvqX/018cS
         x45KFzsxArmOLkt1m8piRzRN6BHSJr3lNY0aA=
Received: by 10.205.138.20 with SMTP id iq20mr7124253bkc.86.1326116605643;
        Mon, 09 Jan 2012 05:43:25 -0800 (PST)
Received: from localhost ([141.76.90.220])
        by mx.google.com with ESMTPS id ck14sm60281203bkb.2.2012.01.09.05.43.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 09 Jan 2012 05:43:24 -0800 (PST)
X-Mailer: git-send-email 1.7.8.1.873.gfea665
In-Reply-To: <37339be035746797fcec7634e3560ffcd5b26cf3.1326116492.git.bert.wesarg@googlemail.com>
In-Reply-To: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
References: <cccd6193cf3bfe170e14270204d735a842bb8563.1326116492.git.bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188171>

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh   |  106 +++++++++++++++++++++++++++++++++++++++------------------
 lib/diff.tcl |   23 ++++++++++---
 2 files changed, 90 insertions(+), 39 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index ba4e5c1..955cbf8 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3289,36 +3289,35 @@ pack .vpane.lower.commarea.buffer -side left -fill y
 
 # -- Commit Message Buffer Context Menu
 #
-set ctxm .vpane.lower.commarea.buffer.ctxm
-menu $ctxm -tearoff 0
-$ctxm add command \
+set ui_comm_ctxm .vpane.lower.commarea.buffer.ctxm
+menu $ui_comm_ctxm -tearoff 0
+$ui_comm_ctxm add command \
 	-label [mc Cut] \
 	-command {tk_textCut $ui_comm}
-$ctxm add command \
+$ui_comm_ctxm add command \
 	-label [mc Copy] \
 	-command {tk_textCopy $ui_comm}
-$ctxm add command \
+$ui_comm_ctxm add command \
 	-label [mc Paste] \
 	-command {tk_textPaste $ui_comm}
-$ctxm add command \
+$ui_comm_ctxm add command \
 	-label [mc Delete] \
 	-command {catch {$ui_comm delete sel.first sel.last}}
-$ctxm add separator
-$ctxm add command \
+$ui_comm_ctxm add separator
+$ui_comm_ctxm add command \
 	-label [mc "Select All"] \
 	-command {focus $ui_comm;$ui_comm tag add sel 0.0 end}
-$ctxm add command \
+$ui_comm_ctxm add command \
 	-label [mc "Copy All"] \
 	-command {
 		$ui_comm tag add sel 0.0 end
 		tk_textCopy $ui_comm
 		$ui_comm tag remove sel 0.0 end
 	}
-$ctxm add separator
-$ctxm add command \
+$ui_comm_ctxm add separator
+$ui_comm_ctxm add command \
 	-label [mc "Sign Off"] \
 	-command do_signoff
-set ui_comm_ctxm $ctxm
 
 # -- Diff Header
 #
@@ -3366,9 +3365,9 @@ tlabel .vpane.lower.diff.header.path \
 pack .vpane.lower.diff.header.status -side left
 pack .vpane.lower.diff.header.file -side left
 pack .vpane.lower.diff.header.path -fill x
-set ctxm .vpane.lower.diff.header.ctxm
-menu $ctxm -tearoff 0
-$ctxm add command \
+set hctxm .vpane.lower.diff.header.ctxm
+menu $hctxm -tearoff 0
+$hctxm add command \
 	-label [mc Copy] \
 	-command {
 		clipboard clear
@@ -3377,8 +3376,8 @@ $ctxm add command \
 			-type STRING \
 			-- $current_diff_path
 	}
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
+lappend diff_actions [list $hctxm entryconf [$hctxm index last] -state]
+bind_button3 .vpane.lower.diff.header.path "tk_popup $hctxm %X %Y"
 
 # -- Diff Body
 #
@@ -3491,29 +3490,61 @@ proc create_common_diff_popup {ctxm} {
 		-command do_options
 }
 
-set ctxm .vpane.lower.diff.body.ctxm
-menu $ctxm -tearoff 0
-$ctxm add command \
+set ctxmw .vpane.lower.diff.body.ctxmw
+menu $ctxmw -tearoff 0
+$ctxmw add command \
 	-label [mc "Apply/Reverse Hunk"] \
 	-command {apply_hunk $cursorX $cursorY}
-set ui_diff_applyhunk [$ctxm index last]
-lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
-$ctxm add command \
+set ui_diff_applyhunk [$ctxmw index last]
+lappend diff_actions [list $ctxmw entryconf $ui_diff_applyhunk -state]
+$ctxmw add command \
 	-label [mc "Apply/Reverse Line"] \
 	-command {apply_range_or_line $cursorX $cursorY; do_rescan}
-set ui_diff_applyline [$ctxm index last]
-lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
-$ctxm add separator
-$ctxm add command \
+set ui_diff_applyline [$ctxmw index last]
+lappend diff_actions [list $ctxmw entryconf $ui_diff_applyline -state]
+$ctxmw add separator
+$ctxmw add command \
+	-label [mc "Revert Hunk"] \
+	-command {apply_hunk $cursorX $cursorY 1}
+lappend diff_actions [list $ctxmw entryconf $ui_diff_applyhunk -state]
+$ctxmw add command \
+	-label [mc "Revert Line"] \
+	-command {apply_range_or_line $cursorX $cursorY 1; do_rescan}
+set ui_diff_revertline [$ctxmw index last]
+lappend diff_actions [list $ctxmw entryconf $ui_diff_applyline -state]
+$ctxmw add separator
+$ctxmw add command \
 	-label [mc "Show Less Context"] \
 	-command show_less_context
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add command \
+lappend diff_actions [list $ctxmw entryconf [$ctxmw index last] -state]
+$ctxmw add command \
 	-label [mc "Show More Context"] \
 	-command show_more_context
-lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-$ctxm add separator
-create_common_diff_popup $ctxm
+lappend diff_actions [list $ctxmw entryconf [$ctxmw index last] -state]
+$ctxmw add separator
+create_common_diff_popup $ctxmw
+
+set ctxmi .vpane.lower.diff.body.ctxmi
+menu $ctxmi -tearoff 0
+$ctxmi add command \
+	-label [mc "Apply/Reverse Hunk"] \
+	-command {apply_hunk $cursorX $cursorY}
+lappend diff_actions [list $ctxmi entryconf $ui_diff_applyhunk -state]
+$ctxmi add command \
+	-label [mc "Apply/Reverse Line"] \
+	-command {apply_range_or_line $cursorX $cursorY; do_rescan}
+lappend diff_actions [list $ctxmi entryconf $ui_diff_applyline -state]
+$ctxmi add separator
+$ctxmi add command \
+	-label [mc "Show Less Context"] \
+	-command show_less_context
+lappend diff_actions [list $ctxmi entryconf [$ctxmi index last] -state]
+$ctxmi add command \
+	-label [mc "Show More Context"] \
+	-command show_more_context
+lappend diff_actions [list $ctxmi entryconf [$ctxmi index last] -state]
+$ctxmi add separator
+create_common_diff_popup $ctxmi
 
 set ctxmmg .vpane.lower.diff.body.ctxmmg
 menu $ctxmmg -tearoff 0
@@ -3581,7 +3612,7 @@ proc has_textconv {path} {
 	}
 }
 
-proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
+proc popup_diff_menu {ctxmw ctxmi ctxmmg ctxmsm x y X Y} {
 	global current_diff_path file_states
 	set ::cursorX $x
 	set ::cursorY $y
@@ -3597,6 +3628,7 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 	} else {
 		set has_range [expr {[$::ui_diff tag nextrange sel 0.0] != {}}]
 		if {$::ui_index eq $::current_diff_side} {
+			set ctxm $ctxmi
 			set l [mc "Unstage Hunk From Commit"]
 			if {$has_range} {
 				set t [mc "Unstage Lines From Commit"]
@@ -3604,11 +3636,14 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 				set t [mc "Unstage Line From Commit"]
 			}
 		} else {
+			set ctxm $ctxmw
 			set l [mc "Stage Hunk For Commit"]
 			if {$has_range} {
 				set t [mc "Stage Lines For Commit"]
+				set r [mc "Revert Lines"]
 			} else {
 				set t [mc "Stage Line For Commit"]
+				set r [mc "Revert Line"]
 			}
 		}
 		if {$::is_3way_diff
@@ -3624,10 +3659,13 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 		}
 		$ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
 		$ctxm entryconf $::ui_diff_applyline -state $s -label $t
+		if {$::ui_workdir eq $::current_diff_side} {
+			$ctxm entryconf $::ui_diff_revertline -state $s -label $r
+		}
 		tk_popup $ctxm $X $Y
 	}
 }
-bind_button3 $ui_diff [list popup_diff_menu $ctxm $ctxmmg $ctxmsm %x %y %X %Y]
+bind_button3 $ui_diff [list popup_diff_menu $ctxmw $ctxmi $ctxmmg $ctxmsm %x %y %X %Y]
 
 # -- Status Bar
 #
diff --git a/lib/diff.tcl b/lib/diff.tcl
index a750ea7..83e6f6a 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -544,7 +544,7 @@ proc read_diff {fd conflict_size cont_info} {
 	}
 }
 
-proc apply_hunk {x y} {
+proc apply_hunk {x y {revert 0}} {
 	global current_diff_path current_diff_header current_diff_side
 	global ui_diff ui_index file_states
 
@@ -561,7 +561,12 @@ proc apply_hunk {x y} {
 			return
 		}
 	} else {
-		set failed_msg [mc "Failed to stage selected hunk."]
+		if {$revert} {
+			set failed_msg [mc "Failed to revert selected hunk."]
+			set apply_cmd {apply --reverse --whitespace=nowarn}
+		} else {
+			set failed_msg [mc "Failed to stage selected hunk."]
+		}
 		if {[string index $mi 1] ne {M}} {
 			unlock_index
 			return
@@ -604,6 +609,8 @@ proc apply_hunk {x y} {
 
 	if {$current_diff_side eq $ui_index} {
 		set mi ${o}M
+	} elseif {$revert} {
+		set mi "[string index $mi 0]$o"
 	} elseif {[string index $mi 0] eq {_}} {
 		set mi M$o
 	} else {
@@ -617,7 +624,7 @@ proc apply_hunk {x y} {
 	}
 }
 
-proc apply_range_or_line {x y} {
+proc apply_range_or_line {x y {revert 0}} {
 	global current_diff_path current_diff_header current_diff_side
 	global ui_diff ui_index file_states
 
@@ -654,8 +661,14 @@ proc apply_range_or_line {x y} {
 			return
 		}
 	} else {
-		set failed_msg [mc "Failed to stage selected line."]
-		set to_context {-}
+		if {$revert} {
+			set failed_msg [mc "Failed to revert selected line."]
+			set apply_cmd {apply --reverse --whitespace=nowarn}
+			set to_context {+}
+		} else {
+			set failed_msg [mc "Failed to stage selected line."]
+			set to_context {-}
+		}
 		if {[string index $mi 1] ne {M}} {
 			unlock_index
 			return
-- 
1.7.8.1.873.gfea665
