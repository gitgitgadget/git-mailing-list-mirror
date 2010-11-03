From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PULL] request pull for git-gui
Date: Wed, 03 Nov 2010 19:17:19 +0000
Message-ID: <87bp66nrnk.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 03 20:17:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PDips-0003HS-Uk
	for gcvg-git-2@lo.gmane.org; Wed, 03 Nov 2010 20:17:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755545Ab0KCTRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Nov 2010 15:17:23 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:52095 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752743Ab0KCTRW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Nov 2010 15:17:22 -0400
Received: from [172.23.144.245] (helo=asmtp-out1.blueyonder.co.uk)
	by smtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PDipk-0003cf-Hd; Wed, 03 Nov 2010 19:17:20 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out1.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PDipk-0000QC-9V; Wed, 03 Nov 2010 19:17:20 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 69711201D8; Wed,  3 Nov 2010 19:17:19 +0000 (GMT)
Cc: msysgit@googlegroups.com
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160635>

Junio, please pull the master branch from the git-gui repository. This
contains some fixes for Windows and the color parsing that was discussed
on list recently.

The following changes since commit 00e9de72c8f9b7c048bb56a59be9567d69dc1e01:

  git-gui 0.13 (2010-09-14 22:42:37 +0100)

are available in the git repository at:
  git://repo.or.cz/git-gui.git master

Pat Thoyts (7):
      git-gui: show command-line errors in a messagebox on Windows
      git-gui: enable the Tk console when tracing/debugging on Windows
      git-gui: generic version trimming
      git-gui: use full dialog width for old name when renaming branch
      git-gui: correct assignment of work-tree
      git-gui: use wordprocessor tab style to ensure tabs work as expected
      git-gui: apply color information from git diff output

Sebastian Schuberth (1):
      On Windows, avoid git-gui to call Cygwin's nice utility

 git-gui.sh            |   77 +++++++++++++++++++++++++++++++++++-------------
 lib/branch_rename.tcl |    2 +-
 lib/diff.tcl          |   34 +++++++++++++++++++++-
 3 files changed, 90 insertions(+), 23 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 4617f29..d3acf0d 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -83,6 +83,7 @@ if {![catch {set _verbose $env(GITGUI_VERBOSE)}]} {
 		puts stderr "source    $name"
 		uplevel 1 real__source $name
 	}
+	if {[tk windowingsystem] eq "win32"} { console show }
 }
 
 ######################################################################
@@ -444,6 +445,8 @@ proc _lappend_nice {cmd_var} {
 		set _nice [_which nice]
 		if {[catch {exec $_nice git version}]} {
 			set _nice {}
+		} elseif {[is_Windows] && [file dirname $_nice] ne [file dirname $::_git]} {
+			set _nice {}
 		}
 	}
 	if {$_nice ne {}} {
@@ -673,6 +676,7 @@ bind . <Visibility> {
 if {[is_Windows]} {
 	wm iconbitmap . -default $oguilib/git-gui.ico
 	set ::tk::AlwaysShowSelection 1
+	bind . <Control-F2> {console show}
 
 	# Spoof an X11 display for SSH
 	if {![info exists env(DISPLAY)]} {
@@ -874,12 +878,19 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
 	exit 1
 }
 
+proc get_trimmed_version {s} {
+    set r {}
+    foreach x [split $s -._] {
+        if {[string is integer -strict $x]} {
+            lappend r $x
+        } else {
+            break
+        }
+    }
+    return [join $r .]
+}
 set _real_git_version $_git_version
-regsub -- {[\-\.]dirty$} $_git_version {} _git_version
-regsub {\.[0-9]+\.g[0-9a-f]+$} $_git_version {} _git_version
-regsub {\.[a-zA-Z]+\.?[0-9]+$} $_git_version {} _git_version
-regsub {\.GIT$} $_git_version {} _git_version
-regsub {\.[a-zA-Z]+\.?[0-9]+$} $_git_version {} _git_version
+set _git_version [get_trimmed_version $_git_version]
 
 if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
 	catch {wm withdraw .}
@@ -1183,13 +1194,22 @@ if {![file isdirectory $_gitdir]} {
 # _gitdir exists, so try loading the config
 load_config 0
 apply_config
-# try to set work tree from environment, falling back to core.worktree
-if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
-	set _gitworktree [get_config core.worktree]
-	if {$_gitworktree eq ""} {
-		set _gitworktree [file dirname [file normalize $_gitdir]]
+
+# v1.7.0 introduced --show-toplevel to return the canonical work-tree
+if {[package vsatisfies $_git_version 1.7.0]} {
+	set _gitworktree [git rev-parse --show-toplevel]
+} else {
+	# try to set work tree from environment, core.worktree or use
+	# cdup to obtain a relative path to the top of the worktree. If
+	# run from the top, the ./ prefix ensures normalize expands pwd.
+	if {[catch { set _gitworktree $env(GIT_WORK_TREE) }]} {
+		set _gitworktree [get_config core.worktree]
+		if {$_gitworktree eq ""} {
+			set _gitworktree [file normalize ./[git rev-parse --show-cdup]]
+		}
 	}
 }
+
 if {$_prefix ne {}} {
 	if {$_gitworktree eq {}} {
 		regsub -all {[^/]+/} $_prefix ../ cdup
@@ -2861,7 +2881,8 @@ proc usage {} {
 	set s "usage: $::argv0 $::subcommand $::subcommand_args"
 	if {[tk windowingsystem] eq "win32"} {
 		wm withdraw .
-		tk_messageBox -icon info -title "Usage" -message $s
+		tk_messageBox -icon info -message $s \
+			-title [mc "Usage"]
 	} else {
 		puts stderr $s
 	}
@@ -2934,7 +2955,11 @@ blame {
 			if {[catch {
 					set head [git rev-parse --verify $head]
 				} err]} {
-				puts stderr $err
+				if {[tk windowingsystem] eq "win32"} {
+					tk_messageBox -icon error -title [mc Error] -message $err
+				} else {
+					puts stderr $err
+				}
 				exit 1
 			}
 		}
@@ -2973,18 +2998,19 @@ blame {
 citool -
 gui {
 	if {[llength $argv] != 0} {
-		puts -nonewline stderr "usage: $argv0"
-		if {$subcommand ne {gui}
-			&& [file tail $argv0] ne "git-$subcommand"} {
-			puts -nonewline stderr " $subcommand"
-		}
-		puts stderr {}
-		exit 1
+		usage
 	}
 	# fall through to setup UI for commits
 }
 default {
-	puts stderr "usage: $argv0 \[{blame|browser|citool}\]"
+	set err "usage: $argv0 \[{blame|browser|citool}\]"
+	if {[tk windowingsystem] eq "win32"} {
+		wm withdraw .
+		tk_messageBox -icon error -message $err \
+			-title [mc "Usage"]
+	} else {
+		puts stderr $err
+	}
 	exit 1
 }
 }
@@ -3286,6 +3312,7 @@ text $ui_diff -background white -foreground black \
 	-xscrollcommand {.vpane.lower.diff.body.sbx set} \
 	-yscrollcommand {.vpane.lower.diff.body.sby set} \
 	-state disabled
+catch {$ui_diff configure -tabstyle wordprocessor}
 ${NS}::scrollbar .vpane.lower.diff.body.sbx -orient horizontal \
 	-command [list $ui_diff xview]
 ${NS}::scrollbar .vpane.lower.diff.body.sby -orient vertical \
@@ -3296,8 +3323,16 @@ pack $ui_diff -side left -fill both -expand 1
 pack .vpane.lower.diff.header -side top -fill x
 pack .vpane.lower.diff.body -side bottom -fill both -expand 1
 
+foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 grey60} {
+	$ui_diff tag configure clr4$n -background $c
+	$ui_diff tag configure clri4$n -foreground $c
+	$ui_diff tag configure clr3$n -foreground $c
+	$ui_diff tag configure clri3$n -background $c
+}
+$ui_diff tag configure clr1 -font font_diffbold
+
 $ui_diff tag conf d_cr -elide true
-$ui_diff tag conf d_@ -foreground blue -font font_diffbold
+$ui_diff tag conf d_@ -font font_diffbold
 $ui_diff tag conf d_+ -foreground {#00a000}
 $ui_diff tag conf d_- -foreground red
 
diff --git a/lib/branch_rename.tcl b/lib/branch_rename.tcl
index 6398877..6e510ec 100644
--- a/lib/branch_rename.tcl
+++ b/lib/branch_rename.tcl
@@ -53,7 +53,7 @@ constructor dialog {} {
 			return 1
 		}
 
-	grid $w.rename.oldname_l $w.rename.oldname_m -sticky w  -padx {0 5}
+	grid $w.rename.oldname_l $w.rename.oldname_m -sticky we -padx {0 5}
 	grid $w.rename.newname_l $w.rename.newname_t -sticky we -padx {0 5}
 	grid columnconfigure $w.rename 1 -weight 1
 	pack $w.rename -anchor nw -fill x -pady 5 -padx 5
diff --git a/lib/diff.tcl b/lib/diff.tcl
index c628750..dcf0711 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -294,7 +294,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	lappend cmd -p
-	lappend cmd --no-color
+	lappend cmd --color
 	if {$repo_config(gui.diffcontext) >= 1} {
 		lappend cmd "-U$repo_config(gui.diffcontext)"
 	}
@@ -332,6 +332,23 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	fileevent $fd readable [list read_diff $fd $cont_info]
 }
 
+proc parse_color_line {line} {
+	set start 0
+	set result ""
+	set markup [list]
+	set regexp {\033\[((?:\d+;)*\d+)?m}
+	while {[regexp -indices -start $start $regexp $line match code]} {
+		foreach {begin end} $match break
+		append result [string range $line $start [expr {$begin - 1}]]
+		lappend markup [string length $result] \
+			[eval [linsert $code 0 string range $line]]
+		set start [incr end]
+	}
+	append result [string range $line $start end]
+	if {[llength $markup] < 4} {set markup {}}
+	return [list $result $markup]
+}
+
 proc read_diff {fd cont_info} {
 	global ui_diff diff_active is_submodule_diff
 	global is_3way_diff is_conflict_diff current_diff_header
@@ -340,6 +357,9 @@ proc read_diff {fd cont_info} {
 
 	$ui_diff conf -state normal
 	while {[gets $fd line] >= 0} {
+		foreach {line markup} [parse_color_line $line] break
+		set line [string map {\033 ^} $line]
+
 		# -- Cleanup uninteresting diff header lines.
 		#
 		if {$::current_diff_inheader} {
@@ -434,11 +454,23 @@ proc read_diff {fd cont_info} {
 			}
 			}
 		}
+		set mark [$ui_diff index "end - 1 line linestart"]
 		$ui_diff insert end $line $tags
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
 		}
 		$ui_diff insert end "\n" $tags
+
+		foreach {posbegin colbegin posend colend} $markup {
+			set prefix clr
+			foreach style [split $colbegin ";"] {
+				if {$style eq "7"} {append prefix i; continue}
+				if {$style < 30 || $style > 47} {continue}
+				set a "$mark linestart + $posbegin chars"
+				set b "$mark linestart + $posend chars"
+				catch {$ui_diff tag add $prefix$style $a $b}
+			}
+		}
 	}
 	$ui_diff conf -state disabled
 
