From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [PATCH 2/2] git-gui: Add a special diff popup menu for submodules
Date: Sat, 02 Jan 2010 17:58:49 +0100
Message-ID: <4B3F7B49.2030100@web.de>
References: <4B3F7AE2.10007@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Jan 02 17:58:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR7JX-0003Oi-Ud
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 17:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752829Ab0ABQ6v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 11:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752810Ab0ABQ6v
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 11:58:51 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:36786 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752809Ab0ABQ6u (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 11:58:50 -0500
Received: from smtp07.web.de (fmsmtp07.dlan.cinetic.de [172.20.5.215])
	by fmmailgate02.web.de (Postfix) with ESMTP id B000A14AF705A;
	Sat,  2 Jan 2010 17:58:49 +0100 (CET)
Received: from [80.128.99.24] (helo=[192.168.178.26])
	by smtp07.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NR7JR-0007JN-00; Sat, 02 Jan 2010 17:58:49 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <4B3F7AE2.10007@web.de>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX19boXBUH3PUUkUecOw7EWtMAxBDbDn6dDlFH9e2
	vy8Kw69pEzDzs/UocjAOUmh+wMijj85yRQJfSoa/z6w0xlqygv
	kO+EKxs81FyjdmggRQhg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136033>

To make it easier for users to deal with submodules, a special diff popup
menu has been added for submodules. The "Show Less Context" and "Show More
Context" entries have been removed, as they don't make any sense for a
submodule summary. Four new entries are added to the top of the popup menu
to gain access to more detailed information about the changes in a
submodule than the plain summary does offer. These are:
- "Visualize These Changes In The Submodule"
  starts gitk showing the selected commit range
- "Visualize These Changes In The Submodule"
  starts gitk showing the whole submodule history of the current branch
- "Visualize All Branch History In The Submodule"
  starts gitk --all in the submodule
- "Start git gui In The Submodule"
  guess what :-)

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
 git-gui/git-gui.sh |  127 +++++++++++++++++++++++++++++++++++++++++++++-------
 1 files changed, 110 insertions(+), 17 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index e0dd5b5..ee80d7d 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1923,7 +1923,9 @@ proc incr_font_size {font {amt 1}} {

 set starting_gitk_msg [mc "Starting gitk... please wait..."]

-proc do_gitk {revs} {
+proc do_gitk {revs {is_submodule false}} {
+	global current_diff_path file_states current_diff_side ui_index
+
 	# -- Always start gitk through whatever we were loaded with.  This
 	#    lets us bypass using shell process on Windows systems.
 	#
@@ -1941,14 +1943,72 @@ proc do_gitk {revs} {
 		}

 		set pwd [pwd]
-		cd [file dirname [gitdir]]
-		set env(GIT_DIR) [file tail [gitdir]]
-
+		if {!$is_submodule} {
+			cd [file dirname [gitdir]]
+			set env(GIT_DIR) [file tail [gitdir]]
+		} else {
+			cd $current_diff_path
+			if {$revs eq {--}} {
+				set s $file_states($current_diff_path)
+				set old_sha1 {}
+				set new_sha1 {}
+				switch -glob -- [lindex $s 0] {
+				M_ { set old_sha1 [lindex [lindex $s 2] 1] }
+				_M { set old_sha1 [lindex [lindex $s 3] 1] }
+				MM {
+					if {$current_diff_side eq $ui_index} {
+						set old_sha1 [lindex [lindex $s 2] 1]
+						set new_sha1 [lindex [lindex $s 3] 1]
+					} else {
+						set old_sha1 [lindex [lindex $s 3] 1]
+					}
+				}
+				}
+				set revs $old_sha1...$new_sha1
+			}
+			if {[info exists env(GIT_DIR)]} {
+				unset env(GIT_DIR)
+			}
+		}
 		eval exec $cmd $revs &

-		if {$old_GIT_DIR eq {}} {
+		if {$old_GIT_DIR ne {}} {
+			set env(GIT_DIR) $old_GIT_DIR
+		}
+		cd $pwd
+
+		ui_status $::starting_gitk_msg
+		after 10000 {
+			ui_ready $starting_gitk_msg
+		}
+	}
+}
+
+proc do_git_gui {} {
+	global current_diff_path
+
+	# -- Always start git gui through whatever we were loaded with.  This
+	#    lets us bypass using shell process on Windows systems.
+	#
+	set exe [_which git]
+	if {$exe eq {}} {
+		error_popup [mc "Couldn't find git gui in PATH"]
+	} else {
+		global env
+
+		if {[info exists env(GIT_DIR)]} {
+			set old_GIT_DIR $env(GIT_DIR)
 			unset env(GIT_DIR)
 		} else {
+			set old_GIT_DIR {}
+		}
+
+		set pwd [pwd]
+		cd $current_diff_path
+
+		eval exec $exe gui &
+
+		if {$old_GIT_DIR ne {}} {
 			set env(GIT_DIR) $old_GIT_DIR
 		}
 		cd $pwd
@@ -3143,15 +3203,6 @@ $ui_diff tag raise sel

 proc create_common_diff_popup {ctxm} {
 	$ctxm add command \
-		-label [mc "Show Less Context"] \
-		-command show_less_context
-	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-	$ctxm add command \
-		-label [mc "Show More Context"] \
-		-command show_more_context
-	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
-	$ctxm add separator
-	$ctxm add command \
 		-label [mc Refresh] \
 		-command reshow_diff
 	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
@@ -3206,6 +3257,15 @@ $ctxm add command \
 set ui_diff_applyline [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyline -state]
 $ctxm add separator
+$ctxm add command \
+	-label [mc "Show Less Context"] \
+	-command show_less_context
+lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+$ctxm add command \
+	-label [mc "Show More Context"] \
+	-command show_more_context
+lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+$ctxm add separator
 create_common_diff_popup $ctxm

 set ctxmmg .vpane.lower.diff.body.ctxmmg
@@ -3228,9 +3288,40 @@ $ctxmmg add command \
 	-command {merge_resolve_one 1}
 lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
 $ctxmmg add separator
+$ctxmmg add command \
+	-label [mc "Show Less Context"] \
+	-command show_less_context
+lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
+$ctxmmg add command \
+	-label [mc "Show More Context"] \
+	-command show_more_context
+lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
+$ctxmmg add separator
 create_common_diff_popup $ctxmmg

-proc popup_diff_menu {ctxm ctxmmg x y X Y} {
+set ctxmsm .vpane.lower.diff.body.ctxmsm
+menu $ctxmsm -tearoff 0
+$ctxmsm add command \
+	-label [mc "Visualize These Changes In The Submodule"] \
+	-command {do_gitk -- true}
+lappend diff_actions [list $ctxmsm entryconf [$ctxmsm index last] -state]
+$ctxmsm add command \
+	-label [mc "Visualize Current Branch History In The Submodule"] \
+	-command {do_gitk {} true}
+lappend diff_actions [list $ctxmsm entryconf [$ctxmsm index last] -state]
+$ctxmsm add command \
+	-label [mc "Visualize All Branch History In The Submodule"] \
+	-command {do_gitk --all true}
+lappend diff_actions [list $ctxmsm entryconf [$ctxmsm index last] -state]
+$ctxmsm add separator
+$ctxmsm add command \
+	-label [mc "Start git gui In The Submodule"] \
+	-command {do_git_gui}
+lappend diff_actions [list $ctxmsm entryconf [$ctxmsm index last] -state]
+$ctxmsm add separator
+create_common_diff_popup $ctxmsm
+
+proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 	global current_diff_path file_states
 	set ::cursorX $x
 	set ::cursorY $y
@@ -3241,6 +3332,8 @@ proc popup_diff_menu {ctxm ctxmmg x y X Y} {
 	}
 	if {[string first {U} $state] >= 0} {
 		tk_popup $ctxmmg $X $Y
+	} elseif {$::is_submodule_diff} {
+		tk_popup $ctxmsm $X $Y
 	} else {
 		if {$::ui_index eq $::current_diff_side} {
 			set l [mc "Unstage Hunk From Commit"]
@@ -3249,7 +3342,7 @@ proc popup_diff_menu {ctxm ctxmmg x y X Y} {
 			set l [mc "Stage Hunk For Commit"]
 			set t [mc "Stage Line For Commit"]
 		}
-		if {$::is_3way_diff || $::is_submodule_diff
+		if {$::is_3way_diff
 			|| $current_diff_path eq {}
 			|| {__} eq $state
 			|| {_O} eq $state
@@ -3264,7 +3357,7 @@ proc popup_diff_menu {ctxm ctxmmg x y X Y} {
 		tk_popup $ctxm $X $Y
 	}
 }
-bind_button3 $ui_diff [list popup_diff_menu $ctxm $ctxmmg %x %y %X %Y]
+bind_button3 $ui_diff [list popup_diff_menu $ctxm $ctxmmg $ctxmsm %x %y %X %Y]

 # -- Status Bar
 #
-- 
1.6.6.339.g7cacc
