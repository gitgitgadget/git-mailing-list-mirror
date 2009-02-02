From: Keith Cascio <keith@cs.ucla.edu>
Subject: [PATCH git-gui v2 2/2] Hooks for new config variable "diff.primer".
Date: Mon,  2 Feb 2009 11:32:01 -0800
Message-ID: <1233603121-1430-3-git-send-email-keith@cs.ucla.edu>
References: <1233603121-1430-1-git-send-email-keith@cs.ucla.edu>
 <1233603121-1430-2-git-send-email-keith@cs.ucla.edu>
Cc: git@vger.kernel.org
To: Shawn O Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 02 21:08:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU554-0003MF-0C
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 21:07:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753502AbZBBUGR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 15:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753470AbZBBUGQ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 15:06:16 -0500
Received: from Sensitivity.CS.UCLA.EDU ([131.179.176.150]:43881 "EHLO
	sensitivity.cs.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753011AbZBBUGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 15:06:16 -0500
Received: from sensitivity.cs.ucla.edu (localhost.localdomain [127.0.0.1])
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8) with ESMTP id n12K69wH001562;
	Mon, 2 Feb 2009 12:06:09 -0800
Received: (from keith@localhost)
	by sensitivity.cs.ucla.edu (8.13.8/8.13.8/Submit) id n12K69kI001561;
	Mon, 2 Feb 2009 12:06:09 -0800
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1233603121-1430-2-git-send-email-keith@cs.ucla.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108114>

Hooks for new config variable "diff.primer".
Add three checkboxes to both sides of options panel (local/global).  Add a
sub-menu named "White Space" to diff-panel right-click context menu, with
three checkboxes.

Signed-off-by: Keith Cascio <keith@cs.ucla.edu>
---
 git-gui.sh     |   51 ++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/option.tcl |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 103 insertions(+), 5 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index e018e07..5d93351 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3075,10 +3075,43 @@ $ui_diff tag conf d>>>>>>> \
 
 $ui_diff tag raise sel
 
+proc mirror_diff_state {} {
+	global  diff__ignore_space_at_eol diff__ignore_space_change diff__ignore_all_space
+
+	set key  "diff.primer"
+	set ddo [git config --get $key]
+	set diff__ignore_space_at_eol [expr {[string match "*--ignore-space-at-eol*" $ddo] ? "true" : "false"}]
+	set diff__ignore_space_change [expr {[string match "*--ignore-space-change*" $ddo] ? "true" : "false"}]
+	set diff__ignore_all_space    [expr {[string match "*--ignore-all-space*"    $ddo] ? "true" : "false"}]
+}
+
+proc adjust_command_line { flag value str } {
+	if {$value eq "true"} {
+	  if { ! [string match "*$flag*" $str ] } {
+	    set              str [concat $str $flag] }
+	} else { regsub       -- $flag   $str "" str }
+	return                           $str
+}
+
+proc record_diff_state {} {
+	global  diff__ignore_space_at_eol diff__ignore_space_change diff__ignore_all_space
+
+	set key  "diff.primer"
+	set ddo [git config --get $key]
+	set ddo [adjust_command_line --ignore-space-at-eol $diff__ignore_space_at_eol $ddo]
+	set ddo [adjust_command_line --ignore-space-change $diff__ignore_space_change $ddo]
+	set ddo [adjust_command_line --ignore-all-space    $diff__ignore_all_space    $ddo]
+
+	git config $key $ddo
+	reshow_diff
+}
+
 # -- Diff Body Context Menu
 #
 
 proc create_common_diff_popup {ctxm} {
+	global  diff__ignore_space_at_eol diff__ignore_space_change diff__ignore_all_space
+
 	$ctxm add command \
 		-label [mc "Show Less Context"] \
 		-command show_less_context
@@ -3087,6 +3120,24 @@ proc create_common_diff_popup {ctxm} {
 		-label [mc "Show More Context"] \
 		-command show_more_context
 	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+	mirror_diff_state
+	set whitespacemenu $ctxm.ws
+	menu $whitespacemenu -postcommand mirror_diff_state
+	$ctxm add cascade \
+		-label [mc "White Space"] \
+		-menu $whitespacemenu
+	$whitespacemenu add checkbutton \
+		-label [mc "--ignore-space-at-eol"] \
+		-variable diff__ignore_space_at_eol -onvalue "true" -offvalue "false" \
+		-command record_diff_state
+	$whitespacemenu add checkbutton \
+		-label [mc "--ignore-space-change"] \
+		-variable diff__ignore_space_change -onvalue "true" -offvalue "false" \
+		-command record_diff_state
+	$whitespacemenu add checkbutton \
+		-label [mc "--ignore-all-space"   ] \
+		-variable diff__ignore_all_space    -onvalue "true" -offvalue "false" \
+		-command record_diff_state
 	$ctxm add separator
 	$ctxm add command \
 		-label [mc Refresh] \
diff --git a/lib/option.tcl b/lib/option.tcl
index 1d55b49..fbdf4e8 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -28,6 +28,7 @@ proc save_config {} {
 	global repo_config global_config system_config
 	global repo_config_new global_config_new
 	global ui_comm_spell
+	global ddo diff_primer_global diff_primer_repo pseudovariables
 
 	foreach option $font_descs {
 		set name [lindex $option 0]
@@ -46,17 +47,40 @@ proc save_config {} {
 		unset global_config_new(gui.$font^^size)
 	}
 
+	foreach name [get_diff_primer] {
+		set diff_option [string range $name 8 [string length $name]]
+		set ifound      [lsearch     $diff_primer_global $diff_option]
+		if {$global_config_new($name) eq "true"} {
+		  if {$ifound <  0} { lappend diff_primer_global $diff_option }
+		} else {
+		  if {$ifound >= 0} { set     diff_primer_global [lreplace $diff_primer_global $ifound $ifound]}
+		}
+		set ifound      [lsearch     $diff_primer_repo   $diff_option]
+		if {  $repo_config_new($name) eq "true"} {
+		  if {$ifound <  0} { lappend diff_primer_repo   $diff_option }
+		} else {
+		  if {$ifound >= 0} { set     diff_primer_repo   [lreplace $diff_primer_repo   $ifound $ifound]}
+		}
+	}
+	array unset default_config gui.diff--ignore-*
+	set    default_config($ddo) ""
+	set global_config_new($ddo) [join    $diff_primer_global]
+	set   repo_config_new($ddo) [join    $diff_primer_repo  ]
+
 	foreach name [array names default_config] {
 		set value $global_config_new($name)
-		if {$value ne $global_config($name)} {
-			if {$value eq $system_config($name)} {
+		set value_global [expr {[info exists global_config($name)] ? $global_config($name) : ""}]
+		set value_system [expr {[info exists system_config($name)] ? $system_config($name) : ""}]
+		set value_repo   [expr {[info exists   repo_config($name)] ?   $repo_config($name) : ""}]
+		if {$value ne $value_global} {
+			if {$value eq $value_system} {
 				catch {git config --global --unset $name}
 			} else {
 				regsub -all "\[{}\]" $value {"} value
 				git config --global $name $value
 			}
 			set global_config($name) $value
-			if {$value eq $repo_config($name)} {
+			if {$value eq $value_repo} {
 				catch {git config --unset $name}
 				set repo_config($name) $value
 			}
@@ -65,8 +89,10 @@ proc save_config {} {
 
 	foreach name [array names default_config] {
 		set value $repo_config_new($name)
-		if {$value ne $repo_config($name)} {
-			if {$value eq $global_config($name)} {
+		set value_global [expr {[info exists global_config($name)] ? $global_config($name) : ""}]
+		set value_repo   [expr {[info exists   repo_config($name)] ?   $repo_config($name) : ""}]
+		if {$value ne $value_repo} {
+			if {$value eq $value_global} {
 				catch {git config --unset $name}
 			} else {
 				regsub -all "\[{}\]" $value {"} value
@@ -88,10 +114,23 @@ proc save_config {} {
 	}
 }
 
+proc get_diff_primer {} {
+	global repo_config global_config
+	global ddo diff_primer_global diff_primer_repo pseudovariables
+
+	set ddo "diff.primer"
+	set diff_primer_global [expr {[info exists global_config($ddo)] ? [split $global_config($ddo)] : [list]}]
+	set diff_primer_repo   [expr {[info exists   repo_config($ddo)] ? [split   $repo_config($ddo)] : [list]}]
+	set pseudovariables [list "gui.diff--ignore-space-at-eol" "gui.diff--ignore-space-change" "gui.diff--ignore-all-space"]
+
+	return $pseudovariables
+}
+
 proc do_options {} {
 	global repo_config global_config font_descs
 	global repo_config_new global_config_new
 	global ui_comm_spell
+	global ddo diff_primer_global diff_primer_repo pseudovariables
 
 	array unset repo_config_new
 	array unset global_config_new
@@ -108,6 +147,11 @@ proc do_options {} {
 	foreach name [array names global_config] {
 		set global_config_new($name) $global_config($name)
 	}
+	foreach name [get_diff_primer] {
+		set diff_option [string range $name 8 [string length $name]]
+		set global_config_new($name) [expr {[lsearch $diff_primer_global $diff_option] < 0 ? "false" : "true"}]
+		set   repo_config_new($name) [expr {[lsearch $diff_primer_repo   $diff_option] < 0 ? "false" : "true"}]
+	}
 
 	set w .options_editor
 	toplevel $w
@@ -150,6 +194,9 @@ proc do_options {} {
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
 		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
+		{b gui.diff--ignore-space-at-eol {mc "Diff Ignore Trailing White Space"            }}
+		{b gui.diff--ignore-space-change {mc "Diff Ignore Changes In Amount Of White Space"}}
+		{b gui.diff--ignore-all-space    {mc "Diff Ignore All White Space"                 }}
 		{i-0..99 gui.commitmsgwidth {mc "Commit Message Text Width"}}
 		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		{c gui.encoding {mc "Default File Contents Encoding"}}
-- 
1.6.1
