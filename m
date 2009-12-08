From: jepler@unpythonic.net
Subject: [PATCH 2/2] Make it possible to apply a range of changes at once
Date: Mon,  7 Dec 2009 18:22:43 -0600
Message-ID: <1260231763-19194-3-git-send-email-jepler@unpythonic.net>
References: <1260231763-19194-1-git-send-email-jepler@unpythonic.net>
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>,
	Peter Baumann <waste.manager@gmx.de>,
	Jeff Epler <jepler@unpythonic.net>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Dec 08 01:52:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHoJu-00028L-DM
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 01:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965301AbZLHAwb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 19:52:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965288AbZLHAwb
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 19:52:31 -0500
Received: from zuul.dsndata.com ([162.40.127.30]:59024 "EHLO zuul.dsndata.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965277AbZLHAw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Dec 2009 19:52:27 -0500
X-Greylist: delayed 1770 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Dec 2009 19:52:24 EST
Received: from lucky2.dsndata.com (lucky2.dsndata.com [198.183.6.22])
	by zuul.dsndata.com (8.13.8/8.13.8) with ESMTP id nB80MpaM038320;
	Mon, 7 Dec 2009 18:22:51 -0600 (CST)
	(envelope-from jepler@dsndata.com)
Received: from jepler by lucky2.dsndata.com with local (Exim 4.69)
	(envelope-from <jepler@lucky2.dsndata.com>)
	id 1NHnqt-00050s-Dg; Mon, 07 Dec 2009 18:22:51 -0600
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1260231763-19194-1-git-send-email-jepler@unpythonic.net>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-3.0 (zuul.dsndata.com [162.40.127.30]); Mon, 07 Dec 2009 18:22:54 -0600 (CST)
X-Scanned-By: MIMEDefang 2.61 on 162.40.127.30
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134796>

From: Jeff Epler <jepler@unpythonic.net>

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
---
 git-gui.sh   |   15 +++-
 lib/diff.tcl |  242 ++++++++++++++++++++++++++++++++++------------------------
 2 files changed, 153 insertions(+), 104 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 718277a..803423f 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3199,7 +3199,7 @@ set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add command \
 	-label [mc "Apply/Reverse Line"] \
-	-command {apply_line $cursorX $cursorY; do_rescan}
+	-command {apply_range_or_line $cursorX $cursorY; do_rescan}
 set ui_diff_applyline [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
 $ctxm add separator
@@ -3239,12 +3239,21 @@ proc popup_diff_menu {ctxm ctxmmg x y X Y} {
 	if {[string first {U} $state] >= 0} {
 		tk_popup $ctxmmg $X $Y
 	} else {
+		set has_range [expr {[$::ui_diff tag nextrange sel 0.0] != {}}]
 		if {$::ui_index eq $::current_diff_side} {
 			set l [mc "Unstage Hunk From Commit"]
-			set t [mc "Unstage Line From Commit"]
+			if {$has_range} {
+				set t [mc "Unstage Lines From Commit"]
+			} else {
+				set t [mc "Unstage Line From Commit"]
+			}
 		} else {
 			set l [mc "Stage Hunk For Commit"]
-			set t [mc "Stage Line For Commit"]
+			if {$has_range} {
+				set t [mc "Stage Lines For Commit"]
+			} else {
+				set t [mc "Stage Line For Commit"]
+			}
 		}
 		if {$::is_3way_diff || $::is_submodule_diff
 			|| $current_diff_path eq {}
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 066755b..5e738e2 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -533,10 +533,23 @@ proc apply_hunk {x y} {
 	}
 }
 
-proc apply_line {x y} {
+proc apply_range_or_line {x y} {
 	global current_diff_path current_diff_header current_diff_side
 	global ui_diff ui_index file_states
 
+	set selected [$ui_diff tag nextrange sel 0.0]
+
+	if {$selected == {}} {
+		set first [$ui_diff index "@$x,$y"]
+		set last $first
+	} else {
+		set first [lindex $selected 0]
+		set last [lindex $selected 1]
+	}
+
+	set first_l [$ui_diff index "$first linestart"]
+	set last_l [$ui_diff index "$last lineend"]
+
 	if {$current_diff_path eq {} || $current_diff_header eq {}} return
 	if {![lock_index apply_hunk]} return
 
@@ -559,120 +572,147 @@ proc apply_line {x y} {
 		}
 	}
 
-	set the_l [$ui_diff index @$x,$y]
+	set wholepatch {}
 
-	# operate only on change lines
-	set c1 [$ui_diff get "$the_l linestart"]
-	if {$c1 ne {+} && $c1 ne {-}} {
-		unlock_index
-		return
-	}
-	set sign $c1
-
-	set i_l [$ui_diff search -backwards -regexp ^@@ $the_l 0.0]
-	if {$i_l eq {}} {
-		unlock_index
-		return
-	}
-	# $i_l is now at the beginning of a line
+	while {$first_l < $last_l} {
+		set i_l [$ui_diff search -backwards -regexp ^@@ $first_l 0.0]
+		if {$i_l eq {}} {
+			# If there's not a @@ above, then the selected range
+			# must have come before the first_l @@
+			set i_l [$ui_diff search -regexp ^@@ $first_l $last_l]
+		}
+		if {$i_l eq {}} {
+			unlock_index
+			return
+		}
+		# $i_l is now at the beginning of a line
 
-	# pick start line number from hunk header
-	set hh [$ui_diff get $i_l "$i_l + 1 lines"]
-	set hh [lindex [split $hh ,] 0]
-	set hln [lindex [split $hh -] 1]
+		# pick start line number from hunk header
+		set hh [$ui_diff get $i_l "$i_l + 1 lines"]
+		set hh [lindex [split $hh ,] 0]
+		set hln [lindex [split $hh -] 1]
 
-	# There is a special situation to take care of. Consider this hunk:
-	#
-	#    @@ -10,4 +10,4 @@
-	#     context before
-	#    -old 1
-	#    -old 2
-	#    +new 1
-	#    +new 2
-	#     context after
-	#
-	# We used to keep the context lines in the order they appear in the
-	# hunk. But then it is not possible to correctly stage only
-	# "-old 1" and "+new 1" - it would result in this staged text:
-	#
-	#    context before
-	#    old 2
-	#    new 1
-	#    context after
-	#
-	# (By symmetry it is not possible to *un*stage "old 2" and "new 2".)
-	#
-	# We resolve the problem by introducing an asymmetry, namely, when
-	# a "+" line is *staged*, it is moved in front of the context lines
-	# that are generated from the "-" lines that are immediately before
-	# the "+" block. That is, we construct this patch:
-	#
-	#    @@ -10,4 +10,5 @@
-	#     context before
-	#    +new 1
-	#     old 1
-	#     old 2
-	#     context after
-	#
-	# But we do *not* treat "-" lines that are *un*staged in a special
-	# way.
-	#
-	# With this asymmetry it is possible to stage the change
-	# "old 1" -> "new 1" directly, and to stage the change
-	# "old 2" -> "new 2" by first staging the entire hunk and
-	# then unstaging the change "old 1" -> "new 1".
-
-	# This is non-empty if and only if we are _staging_ changes;
-	# then it accumulates the consecutive "-" lines (after converting
-	# them to context lines) in order to be moved after the "+" change
-	# line.
-	set pre_context {}
-
-	set n 0
-	set i_l [$ui_diff index "$i_l + 1 lines"]
-	set patch {}
-	while {[$ui_diff compare $i_l < "end - 1 chars"] &&
-	       [$ui_diff get $i_l "$i_l + 2 chars"] ne {@@}} {
-		set next_l [$ui_diff index "$i_l + 1 lines"]
-		set c1 [$ui_diff get $i_l]
-		if {[$ui_diff compare $i_l <= $the_l] &&
-		    [$ui_diff compare $the_l < $next_l]} {
-			# the line to stage/unstage
-			set ln [$ui_diff get $i_l $next_l]
-			if {$c1 eq {-}} {
-				set n [expr $n+1]
+		# There is a special situation to take care of. Consider this
+		# hunk:
+		#
+		#    @@ -10,4 +10,4 @@
+		#     context before
+		#    -old 1
+		#    -old 2
+		#    +new 1
+		#    +new 2
+		#     context after
+		#
+		# We used to keep the context lines in the order they appear in
+		# the hunk. But then it is not possible to correctly stage only
+		# "-old 1" and "+new 1" - it would result in this staged text:
+		#
+		#    context before
+		#    old 2
+		#    new 1
+		#    context after
+		#
+		# (By symmetry it is not possible to *un*stage "old 2" and "new
+		# 2".)
+		#
+		# We resolve the problem by introducing an asymmetry, namely,
+		# when a "+" line is *staged*, it is moved in front of the
+		# context lines that are generated from the "-" lines that are
+		# immediately before the "+" block. That is, we construct this
+		# patch:
+		#
+		#    @@ -10,4 +10,5 @@
+		#     context before
+		#    +new 1
+		#     old 1
+		#     old 2
+		#     context after
+		#
+		# But we do *not* treat "-" lines that are *un*staged in a
+		# special way.
+		#
+		# With this asymmetry it is possible to stage the change "old
+		# 1" -> "new 1" directly, and to stage the change "old 2" ->
+		# "new 2" by first staging the entire hunk and then unstaging
+		# the change "old 1" -> "new 1".
+		#
+		# Applying multiple lines adds complexity to the special
+		# situation.  The pre_context must be moved after the entire
+		# first block of consecutive staged "+" lines, so that
+		# staging both additions gives the following patch:
+		#
+		#    @@ -10,4 +10,6 @@
+		#     context before
+		#    +new 1
+		#    +new 2
+		#     old 1
+		#     old 2
+		#     context after
+
+		# This is non-empty if and only if we are _staging_ changes;
+		# then it accumulates the consecutive "-" lines (after
+		# converting them to context lines) in order to be moved after
+		# "+" change lines.
+		set pre_context {}
+
+		set n 0
+		set m 0
+		set i_l [$ui_diff index "$i_l + 1 lines"]
+		set patch {}
+		while {[$ui_diff compare $i_l < "end - 1 chars"] &&
+		       [$ui_diff get $i_l "$i_l + 2 chars"] ne {@@}} {
+			set next_l [$ui_diff index "$i_l + 1 lines"]
+			set c1 [$ui_diff get $i_l]
+			if {[$ui_diff compare $first_l <= $i_l] &&
+			    [$ui_diff compare $i_l < $last_l] &&
+			    ($c1 eq {-} || $c1 eq {+})} {
+				# a line to stage/unstage
+				set ln [$ui_diff get $i_l $next_l]
+				if {$c1 eq {-}} {
+					set n [expr $n+1]
+					set patch "$patch$pre_context$ln"
+					set pre_context {}
+				} else {
+					set m [expr $m+1]
+					set patch "$patch$ln"
+				}
+			} elseif {$c1 ne {-} && $c1 ne {+}} {
+				# context line
+				set ln [$ui_diff get $i_l $next_l]
 				set patch "$patch$pre_context$ln"
+				set n [expr $n+1]
+				set m [expr $m+1]
+				set pre_context {}
+			} elseif {$c1 eq $to_context} {
+				# turn change line into context line
+				set ln [$ui_diff get "$i_l + 1 chars" $next_l]
+				if {$c1 eq {-}} {
+					set pre_context "$pre_context $ln"
+				} else {
+					set patch "$patch $ln"
+				}
+				set n [expr $n+1]
+				set m [expr $m+1]
 			} else {
-				set patch "$patch$ln$pre_context"
-			}
-			set pre_context {}
-		} elseif {$c1 ne {-} && $c1 ne {+}} {
-			# context line
-			set ln [$ui_diff get $i_l $next_l]
-			set patch "$patch$pre_context$ln"
-			set n [expr $n+1]
-			set pre_context {}
-		} elseif {$c1 eq $to_context} {
-			# turn change line into context line
-			set ln [$ui_diff get "$i_l + 1 chars" $next_l]
-			if {$c1 eq {-}} {
-				set pre_context "$pre_context $ln"
-			} else {
-				set patch "$patch $ln"
+				# a change in the opposite direction of
+				# to_context which is outside the range of
+				# lines to apply.
+				set patch "$patch$pre_context"
+				set pre_context {}
 			}
-			set n [expr $n+1]
+			set i_l $next_l
 		}
-		set i_l $next_l
+		set patch "$patch$pre_context"
+		set wholepatch "$wholepatch@@ -$hln,$n +$hln,$m @@\n$patch"
+		set first_l [$ui_diff index "$next_l + 1 lines"]
 	}
-	set patch "$patch$pre_context"
-	set patch "@@ -$hln,$n +$hln,[eval expr $n $sign 1] @@\n$patch"
 
 	if {[catch {
 		set enc [get_path_encoding $current_diff_path]
 		set p [eval git_write $apply_cmd]
 		fconfigure $p -translation binary -encoding $enc
 		puts -nonewline $p $current_diff_header
-		puts -nonewline $p $patch
+		puts -nonewline $p $wholepatch
 		close $p} err]} {
 		error_popup [append $failed_msg "\n\n$err"]
 	}
-- 
1.6.3.3
