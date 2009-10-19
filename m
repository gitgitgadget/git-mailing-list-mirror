From: Jeff Epler <jepler@unpythonic.net>
Subject: [RFC PATCH] git-gui: Allow staging multiple lines at once
Date: Mon, 19 Oct 2009 14:54:57 -0500
Message-ID: <20091019195456.GA11121@unpythonic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 19 22:01:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MzyPx-00086V-9c
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 22:01:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757361AbZJSUBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 16:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755220AbZJSUBG
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 16:01:06 -0400
Received: from dsl.unpythonic.net ([206.222.212.217]:44969 "EHLO
	unpythonic.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751103AbZJSUBF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 16:01:05 -0400
X-Greylist: delayed 362 seconds by postgrey-1.27 at vger.kernel.org; Mon, 19 Oct 2009 16:01:05 EDT
Received: by unpythonic.net (Postfix, from userid 1000)
	id 088A911456C; Mon, 19 Oct 2009 14:54:57 -0500 (CDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130732>

When applying less than a full hunk, it's still often desirable to apply
a number of consecutive lines.

This change makes it possible to sweep out a range of lines in the diff view
with the left mouse button, then right click and "Stage Lines For Commit".

The selected lines may span multiple hunks.

Signed-off-by: Jeff Epler <jepler@unpythonic.net>
---
The diff looks bigger than it is because it changed the indentation level
of about 80 lines, and that made it necessary to reflow a lengthy comment
block as well.

This introduces new user interface strings.  I felt this was probably a
better decision than using the inaccurate "Stage Line For Commit" when
a block of text was swept out.

I wonder a bit about the message [mc "Apply/Reverse Line"] -- as far as
I can tell, it is never shown to a user, so why is it translated?

 git-gui/git-gui.sh   |   15 +++-
 git-gui/lib/diff.tcl |  222 +++++++++++++++++++++++++++----------------------
 2 files changed, 134 insertions(+), 103 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 14b92ba..a80ed0d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3165,7 +3165,7 @@ set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add command \
 	-label [mc "Apply/Reverse Line"] \
-	-command {apply_line $cursorX $cursorY; do_rescan}
+	-command {apply_range_or_line $cursorX $cursorY; do_rescan}
 set ui_diff_applyline [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
 $ctxm add separator
@@ -3205,12 +3205,21 @@ proc popup_diff_menu {ctxm ctxmmg x y X Y} {
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
 		if {$::is_3way_diff
 			|| $current_diff_path eq {}
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index 925b3f5..30ac659 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -505,10 +505,23 @@ proc apply_hunk {x y} {
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
 
@@ -531,119 +544,128 @@ proc apply_line {x y} {
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
+
+		# This is non-empty if and only if we are _staging_ changes;
+		# then it accumulates the consecutive "-" lines (after
+		# converting them to context lines) in order to be moved after
+		# the "+" change line.
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
+				# the line to stage/unstage
+				set ln [$ui_diff get $i_l $next_l]
+				if {$c1 eq {-}} {
+					set n [expr $n+1]
+					set patch "$patch$pre_context$ln"
+				} else {
+					set m [expr $m+1]
+					set patch "$patch$ln$pre_context"
+				}
+				set pre_context {}
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
 			}
-			set n [expr $n+1]
+			set i_l $next_l
 		}
-		set i_l $next_l
+		set wholepatch "$wholepatch@@ -$hln,$n +$hln,$m @@\n$patch"
+		set first_l [$ui_diff index "$next_l + 1 lines"]
 	}
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
1.6.5.rc1.49.ge970
