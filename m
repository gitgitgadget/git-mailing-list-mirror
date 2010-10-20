From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: support core.whitespace rules in diff view
Date: Wed, 20 Oct 2010 23:05:43 +0100
Message-ID: <87pqv4fqqz.fsf_-_@fox.patthoyts.tk>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	<87hbgh7paf.fsf@fox.patthoyts.tk>
	<AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 21 00:23:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8h4D-0002hO-T8
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 00:23:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755803Ab0JTWXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Oct 2010 18:23:24 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:57929 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754663Ab0JTWXY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 18:23:24 -0400
Received: from [172.23.170.144] (helo=anti-virus03-07)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P8h46-0003hB-9Z; Wed, 20 Oct 2010 23:23:22 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out5.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P8h41-00024q-KU; Wed, 20 Oct 2010 23:23:17 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id BD51025EF5; Wed, 20 Oct 2010 23:23:16 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTimrrxbKSYib7g0O5TXXwt5yDTdkt_bycs69mKT7@mail.gmail.com>
	(Tor Arvid Lund's message of "Wed, 20 Oct 2010 17:30:26 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159444>

This is a rather more complete implementation of whitespace highlighting
according to the core.whitespace setting. The diff view whitespace
highlights should match what you see with 'git diff' when color is
enabled for all the whitespace rules except cr-at-eol where there is
currently a rule to hide these.

Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

 git-gui.sh   |   27 +++++++++++++++++++++++++++
 lib/diff.tcl |   58 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 83 insertions(+), 2 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 5e8378f..134afba 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -806,6 +806,7 @@ proc apply_config {} {
 }
 
 set default_config(branch.autosetupmerge) true
+set default_config(core.whitespace) ""
 set default_config(merge.tool) {}
 set default_config(mergetool.keepbackup) true
 set default_config(merge.diffstat) true
@@ -836,6 +837,13 @@ set font_descs {
 	{fontdiff font_diff {mc "Diff/Console Font"}}
 }
 
+set whitespace_config(blank-at-eol) 1
+set whitespace_config(space-before-tab) 1
+set whitespace_config(indent-with-non-tab) 0
+set whitespace_config(tab-in-indent) 0
+set whitespace_config(blank-at-eof) 1
+set whitespace_config(cr-at-eol) 0
+
 ######################################################################
 ##
 ## find git
@@ -1060,6 +1068,7 @@ git-version proc _parse_config {arr_name args} {
 
 proc load_config {include_global} {
 	global repo_config global_config system_config default_config
+	global whitespace_config
 
 	if {$include_global} {
 		_parse_config system_config --system
@@ -1080,6 +1089,23 @@ proc load_config {include_global} {
 			set repo_config($name) $system_config($name)
 		}
 	}
+	set whitespace ""
+	foreach cf {default_config system_config global_config repo_config} {
+		upvar #0 $cf config
+		if {[info exists config(core.whitespace)]} {
+			set whitespace $config(core.whitespace)
+		}
+	}
+	foreach var [split $whitespace ,] {
+		set state [expr {![string match -* $var]}]
+		set var [string trimleft $var -]
+		if {[string match "trailing-space" $var]} {
+			set whitespace_config(blank-at-eol) $state
+			set whitespace_config(blank-at-eof) $state
+		} else {
+			set whitespace_config($var) $state
+		}
+	}
 }
 
 ######################################################################
@@ -3323,6 +3349,7 @@ pack .vpane.lower.diff.header -side top -fill x
 pack .vpane.lower.diff.body -side bottom -fill both -expand 1
 
 $ui_diff tag conf d_cr -elide true
+$ui_diff tag conf ws -background red
 $ui_diff tag conf d_@ -foreground blue -font font_diffbold
 $ui_diff tag conf d_+ -foreground {#00a000}
 $ui_diff tag conf d_- -foreground red
diff --git a/lib/diff.tcl b/lib/diff.tcl
index c628750..e174faf 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -332,11 +332,17 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	fileevent $fd readable [list read_diff $fd $cont_info]
 }
 
+proc add_tag {w tag pos ndx} {
+	set begin "$pos + [lindex $ndx 0] chars"
+	set end "$pos + [expr {[lindex $ndx 1] + 1}] chars"
+	$w tag add $tag $begin $end
+}
+
 proc read_diff {fd cont_info} {
 	global ui_diff diff_active is_submodule_diff
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
-	global diff_empty_count
+	global diff_empty_count whitespace_config
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
@@ -434,7 +440,38 @@ proc read_diff {fd cont_info} {
 			}
 			}
 		}
-		$ui_diff insert end $line $tags
+		set insertion [list $line $tags]
+		if {$whitespace_config(blank-at-eol)} {
+			if {[regexp -indices {^[+-](?:.*\S)?(\s+)$} $line -> ndx]} {
+				set ndx [expr {[lindex $ndx 0] - 1}]
+				set insertion [list [string range $line 0 $ndx] $tags\
+								   [string range $line [incr ndx] end]\
+								   [concat $tags ws]]
+			}
+		}
+		set pos [$ui_diff index "end - 1 line linestart"]
+		eval [linsert $insertion 0 $ui_diff insert end]
+		if {[regexp {^[+-](\s*)\S} [lindex $insertion 0] -> initial]} {
+			if {$whitespace_config(indent-with-non-tab)} {
+				if {[regexp -indices {^x( {8,})} x$initial -> ndx]} {
+					add_tag $ui_diff ws $pos $ndx
+				}
+			}
+			if {$whitespace_config(space-before-tab)} {
+				set start 0
+				while {[regexp -indices -start $start {( +)\t} x$initial -> ndx]} {
+					add_tag $ui_diff ws $pos $ndx
+					set start [expr {[lindex $ndx 1] + 1}]
+				}
+			}
+			if {$whitespace_config(tab-in-indent)} {
+				set start 0
+				while {[regexp -indices -start $start {\t} x$initial ndx]} {
+					add_tag $ui_diff ws $pos $ndx
+					set start [expr {[lindex $ndx 1] + 1}]
+				}
+			}
+		}
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
 		}
@@ -450,6 +487,16 @@ proc read_diff {fd cont_info} {
 			return
 		}
 
+		if {$whitespace_config(blank-at-eof)} {
+			set n 2
+			$ui_diff configure -state normal
+			while {[regexp {^[+-]$} [$ui_diff get "end - $n line linestart" "end - $n line lineend"]]} {
+				$ui_diff tag add ws "end - $n line linestart" "end - $n line lineend"
+				incr n
+			}
+			$ui_diff configure -state disabled
+		}
+
 		set diff_active 0
 		unlock_index
 		set scroll_pos [lindex $cont_info 0]
@@ -731,3 +778,10 @@ proc apply_range_or_line {x y} {
 
 	unlock_index
 }
+
+# Local variables:
+# mode: tcl
+# indent-tabs-mode: t
+# tcl-indent-level: 4
+# tab-width: 4
+# End:
-- 
1.7.3.1.msysgit.0
