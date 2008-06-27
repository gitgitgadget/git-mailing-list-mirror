From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH] git-gui: Implement "Stage/Unstage Line"
Date: Fri, 27 Jun 2008 09:22:01 +0200
Message-ID: <48649519.1010307@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 27 09:23:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KC8IU-0006Mc-EY
	for gcvg-git-2@gmane.org; Fri, 27 Jun 2008 09:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753518AbYF0HWJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 03:22:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752320AbYF0HWI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 03:22:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:35269 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751429AbYF0HWG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 03:22:06 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KC8HR-00037G-Oj; Fri, 27 Jun 2008 09:22:02 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 5F51954D; Fri, 27 Jun 2008 09:22:01 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86529>

From: Johannes Sixt <johannes.sixt@telecom.at>

This adds a context menu entry below "Stage/Unstage Hunk" that stages or
unstages just the line under the mouse pointer.

This is by itself useful, for example, if there are unrelated changes in
the same hunk and the hunk cannot be split by reducing the context.

The feature can also be used to split a hunk by staging a number of
additions (or unstaging a number of removals) until there are enough
context lines that the hunk gets split.

The implementation reads the complete hunk that the line lives in, and
constructs a new hunk by picking existing context lines, removing unneeded
change lines and transforming other change lines to context lines. The
resulting hunk is fed through 'git apply' just like in the "Stage/Unstage
Hunk" case.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	Disclaimer: I'm Tcl/Tk illiterate. Feel free to munge the patch
	to your taste.

	The 'do_rescan' is probably a bit heavy-weight. But editing the
	diff window like we do in "Stage Hunk" would be a bit complex, and
	just redisplaying the diff is easier.

	Furthermore, I don't know why I have to do the loop until
	"end - 1 chars". If it goes until "end", then the hunk contains
	an extra line, so that the patch in general does not apply.
	Is there an extra newline in the diff view that is not in the
	git diff output?

	-- Hannes

 git-gui.sh   |    8 +++++
 lib/diff.tcl |   87 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 95 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 1bbae15..d89f156 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2666,6 +2666,11 @@ $ctxm add command \
 	-command {apply_hunk $cursorX $cursorY}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
+$ctxm add command \
+	-label [mc "Apply/Reverse Line"] \
+	-command {apply_line $cursorX $cursorY; do_rescan}
+set ui_diff_applyline [$ctxm index last]
+lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
 $ctxm add separator
 $ctxm add command \
 	-label [mc "Show Less Context"] \
@@ -2714,8 +2719,10 @@ proc popup_diff_menu {ctxm x y X Y} {
 	set ::cursorY $y
 	if {$::ui_index eq $::current_diff_side} {
 		set l [mc "Unstage Hunk From Commit"]
+		set t [mc "Unstage Line From Commit"]
 	} else {
 		set l [mc "Stage Hunk For Commit"]
+		set t [mc "Stage Line For Commit"]
 	}
 	if {$::is_3way_diff
 		|| $current_diff_path eq {}
@@ -2726,6 +2733,7 @@ proc popup_diff_menu {ctxm x y X Y} {
 		set s normal
 	}
 	$ctxm entryconf $::ui_diff_applyhunk -state $s -label $l
+	$ctxm entryconf $::ui_diff_applyline -state $s -label $t
 	tk_popup $ctxm $X $Y
 }
 bind_button3 $ui_diff [list popup_diff_menu $ctxm %x %y %X %Y]
diff --git a/lib/diff.tcl b/lib/diff.tcl
index d04f6db..96ba949 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -362,3 +362,90 @@ proc apply_hunk {x y} {
 		set current_diff_path $current_diff_path
 	}
 }
+
+proc apply_line {x y} {
+	global current_diff_path current_diff_header current_diff_side
+	global ui_diff ui_index file_states
+
+	if {$current_diff_path eq {} || $current_diff_header eq {}} return
+	if {![lock_index apply_hunk]} return
+
+	set apply_cmd {apply --cached --whitespace=nowarn}
+	set mi [lindex $file_states($current_diff_path) 0]
+	if {$current_diff_side eq $ui_index} {
+		set failed_msg [mc "Failed to unstage selected line."]
+		set to_context {+}
+		lappend apply_cmd --reverse
+		if {[string index $mi 0] ne {M}} {
+			unlock_index
+			return
+		}
+	} else {
+		set failed_msg [mc "Failed to stage selected line."]
+		set to_context {-}
+		if {[string index $mi 1] ne {M}} {
+			unlock_index
+			return
+		}
+	}
+
+	set the_l [$ui_diff index @$x,$y]
+
+	# operate only on change lines
+	set c1 [$ui_diff get "$the_l linestart"]
+	if {$c1 ne {+} && $c1 ne {-}} {
+		unlock_index
+		return
+	}
+	set sign $c1
+
+	set i_l [$ui_diff search -backwards -regexp ^@@ $the_l 0.0]
+	if {$i_l eq {}} {
+		unlock_index
+		return
+	}
+	# $i_l is now at the beginning of a line
+
+	# pick start line number from hunk header
+	set hh [$ui_diff get $i_l "$i_l + 1 lines"]
+	set hh [lindex [split $hh ,] 0]
+	set hln [lindex [split $hh -] 1]
+
+	set n 0
+	set i_l [$ui_diff index "$i_l + 1 lines"]
+	set patch {}
+	while {[$ui_diff compare $i_l < "end - 1 chars"] &&
+	       [$ui_diff get $i_l "$i_l + 2 chars"] ne {@@}} {
+		set next_l [$ui_diff index "$i_l + 1 lines"]
+		set c1 [$ui_diff get $i_l]
+		if {[$ui_diff compare $i_l <= $the_l] &&
+		    [$ui_diff compare $the_l < $next_l]} {
+			# the line to stage/unstage
+			set ln [$ui_diff get $i_l $next_l]
+			set patch "$patch$ln"
+		} elseif {$c1 ne {-} && $c1 ne {+}} {
+			# context line
+			set ln [$ui_diff get $i_l $next_l]
+			set patch "$patch$ln"
+			set n [expr $n+1]
+		} elseif {$c1 eq $to_context} {
+			# turn change line into context line
+			set ln [$ui_diff get "$i_l + 1 chars" $next_l]
+			set patch "$patch $ln"
+			set n [expr $n+1]
+		}
+		set i_l $next_l
+	}
+	set patch "@@ -$hln,$n +$hln,[eval expr $n $sign 1] @@\n$patch"
+
+	if {[catch {
+		set p [eval git_write $apply_cmd]
+		fconfigure $p -translation binary -encoding binary
+		puts -nonewline $p $current_diff_header
+		puts -nonewline $p $patch
+		close $p} err]} {
+		error_popup [append $failed_msg "\n\n$err"]
+	}
+
+	unlock_index
+}
-- 
1.5.6.918.g8a69
