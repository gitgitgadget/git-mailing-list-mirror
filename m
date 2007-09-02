From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 01/15] Mark strings for translation.
Date: Sun, 2 Sep 2007 17:25:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021724440.28586@racer.site>
References: <Pine.LNX.4.64.0709021719380.28586@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 02 18:25:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRsGM-0003WU-A9
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 18:25:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757062AbXIBQZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 12:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755782AbXIBQZU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 12:25:20 -0400
Received: from mail.gmx.net ([213.165.64.20]:39105 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755932AbXIBQZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 12:25:12 -0400
Received: (qmail invoked by alias); 02 Sep 2007 16:25:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 02 Sep 2007 18:25:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0lQZMyHT0RWmjEBFnPk5b5x8KGlk3iwPT8NsFE7
	XyHeAv+gbX8AIY
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0709021719380.28586@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57346>


The procedure [mc ...] will translate the strings through msgcat.
Strings must be enclosed in quotes, not in braces, because otherwise
xgettext cannot extract them properly, although on the Tcl side both
delimiters would work fine.

[jes: I merged the later patches to that end.]

Signed-off-by: Christian Stimming <stimming@tuhh.de>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 git-gui.sh                   |  265 +++++++++++++++++++++---------------------
 lib/blame.tcl                |   10 +-
 lib/branch_checkout.tcl      |   16 ++--
 lib/branch_create.tcl        |   38 +++---
 lib/branch_delete.tcl        |   22 ++--
 lib/branch_rename.tcl        |   22 ++--
 lib/browser.tcl              |   22 ++--
 lib/checkout_op.tcl          |   48 ++++----
 lib/choose_rev.tcl           |   16 ++--
 lib/commit.tcl               |   52 ++++----
 lib/console.tcl              |   14 +-
 lib/database.tcl             |   28 +++---
 lib/diff.tcl                 |   16 ++--
 lib/error.tcl                |    8 +-
 lib/index.tcl                |   23 +++-
 lib/merge.tcl                |   60 +++++-----
 lib/option.tcl               |   49 ++++----
 lib/remote.tcl               |    6 +-
 lib/remote_branch_delete.tcl |   42 +++----
 lib/shortcut.tcl             |   12 +-
 lib/status_bar.tcl           |    2 +-
 lib/transport.tcl            |   30 +++---
 22 files changed, 403 insertions(+), 398 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 486d36e..913ba68 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -502,7 +502,7 @@ proc tk_optionMenu {w varName args} {
 set _git  [_which git]
 if {$_git eq {}} {
 	catch {wm withdraw .}
-	error_popup "Cannot find git in PATH."
+	error_popup [mc "Cannot find git in PATH."]
 	exit 1
 }
 
@@ -529,7 +529,7 @@ if {![regsub {^git version } $_git_version {} _git_version]} {
 		-icon error \
 		-type ok \
 		-title "git-gui: fatal error" \
-		-message "Cannot parse Git version string:\n\n$_git_version"
+		-message [append [mc "Cannot parse Git version string:"] "\n\n$_git_version"]
 	exit 1
 }
 
@@ -546,14 +546,14 @@ if {![regexp {^[1-9]+(\.[0-9]+)+$} $_git_version]} {
 		-type yesno \
 		-default no \
 		-title "[appname]: warning" \
-		-message "Git version cannot be determined.
+		 -message [mc "Git version cannot be determined.
 
-$_git claims it is version '$_real_git_version'.
+%s claims it is version '%s'.
 
-[appname] requires at least Git 1.5.0 or later.
+%s requires at least Git 1.5.0 or later.
 
-Assume '$_real_git_version' is version 1.5.0?
-"] eq {yes}} {
+Assume '%s' is version 1.5.0?
+" $_git $_real_git_version [appname] $_real_git_version]] eq {yes}} {
 		set _git_version 1.5.0
 	} else {
 		exit 1
@@ -711,7 +711,7 @@ if {[catch {
 		set _prefix [git rev-parse --show-prefix]
 	} err]} {
 	catch {wm withdraw .}
-	error_popup "Cannot find the git directory:\n\n$err"
+	error_popup [append [mc "Cannot find the git directory:"] "\n\n$err"]
 	exit 1
 }
 if {![file isdirectory $_gitdir] && [is_Cygwin]} {
@@ -719,7 +719,7 @@ if {![file isdirectory $_gitdir] && [is_Cygwin]} {
 }
 if {![file isdirectory $_gitdir]} {
 	catch {wm withdraw .}
-	error_popup "Git directory not found:\n\n$_gitdir"
+	error_popup [append [mc "Git directory not found:"] "\n\n$_gitdir"]
 	exit 1
 }
 if {$_prefix ne {}} {
@@ -733,12 +733,12 @@ if {$_prefix ne {}} {
 } elseif {![is_enabled bare]} {
 	if {[lindex [file split $_gitdir] end] ne {.git}} {
 		catch {wm withdraw .}
-		error_popup "Cannot use funny .git directory:\n\n$_gitdir"
+		error_popup [append [mc "Cannot use funny .git directory:"] "\n\n$_gitdir"]
 		exit 1
 	}
 	if {[catch {cd [file dirname $_gitdir]} err]} {
 		catch {wm withdraw .}
-		error_popup "No working directory [file dirname $_gitdir]:\n\n$err"
+		error_popup [append [mc "No working directory"] " [file dirname $_gitdir]:\n\n$err"]
 		exit 1
 	}
 }
@@ -885,7 +885,7 @@ proc rescan {after {honor_trustmtime 1}} {
 		rescan_stage2 {} $after
 	} else {
 		set rescan_active 1
-		ui_status {Refreshing file status...}
+		ui_status [mc "Refreshing file status..."]
 		set fd_rf [git_read update-index \
 			-q \
 			--unmerged \
@@ -922,7 +922,7 @@ proc rescan_stage2 {fd after} {
 	set buf_rlo {}
 
 	set rescan_active 3
-	ui_status {Scanning for modified files ...}
+	ui_status [mc "Scanning for modified files ..."]
 	set fd_di [git_read diff-index --cached -z [PARENT]]
 	set fd_df [git_read diff-files -z]
 	set fd_lo [eval git_read ls-files --others -z $ls_others]
@@ -1088,7 +1088,7 @@ proc ui_status {msg} {
 }
 
 proc ui_ready {{test {}}} {
-	$::main_status show {Ready.} $test
+	$::main_status show [mc "Ready."] $test
 }
 
 proc escape_path {path} {
@@ -1353,31 +1353,32 @@ set all_icons(O$ui_workdir) file_plain
 
 set max_status_desc 0
 foreach i {
-		{__ "Unmodified"}
-
-		{_M "Modified, not staged"}
-		{M_ "Staged for commit"}
-		{MM "Portions staged for commit"}
-		{MD "Staged for commit, missing"}
-
-		{_O "Untracked, not staged"}
-		{A_ "Staged for commit"}
-		{AM "Portions staged for commit"}
-		{AD "Staged for commit, missing"}
-
-		{_D "Missing"}
-		{D_ "Staged for removal"}
-		{DO "Staged for removal, still present"}
-
-		{U_ "Requires merge resolution"}
-		{UU "Requires merge resolution"}
-		{UM "Requires merge resolution"}
-		{UD "Requires merge resolution"}
+		{__ {mc "Unmodified"}}
+
+		{_M {mc "Modified, not staged"}}
+		{M_ {mc "Staged for commit"}}
+		{MM {mc "Portions staged for commit"}}
+		{MD {mc "Staged for commit, missing"}}
+
+		{_O {mc "Untracked, not staged"}}
+		{A_ {mc "Staged for commit"}}
+		{AM {mc "Portions staged for commit"}}
+		{AD {mc "Staged for commit, missing"}}
+
+		{_D {mc "Missing"}}
+		{D_ {mc "Staged for removal"}}
+		{DO {mc "Staged for removal, still present"}}
+
+		{U_ {mc "Requires merge resolution"}}
+		{UU {mc "Requires merge resolution"}}
+		{UM {mc "Requires merge resolution"}}
+		{UD {mc "Requires merge resolution"}}
 	} {
-	if {$max_status_desc < [string length [lindex $i 1]]} {
-		set max_status_desc [string length [lindex $i 1]]
+	set text [eval [lindex $i 1]]
+	if {$max_status_desc < [string length $text]} {
+		set max_status_desc [string length $text]
 	}
-	set all_descs([lindex $i 0]) [lindex $i 1]
+	set all_descs([lindex $i 0]) $text
 }
 unset i
 
@@ -1416,7 +1417,7 @@ proc incr_font_size {font {amt 1}} {
 ##
 ## ui commands
 
-set starting_gitk_msg {Starting gitk... please wait...}
+set starting_gitk_msg [mc "Starting gitk... please wait..."]
 
 proc do_gitk {revs} {
 	# -- Always start gitk through whatever we were loaded with.  This
@@ -1425,7 +1426,7 @@ proc do_gitk {revs} {
 	set exe [file join [file dirname $::_git] gitk]
 	set cmd [list [info nameofexecutable] $exe]
 	if {! [file exists $exe]} {
-		error_popup "Unable to start gitk:\n\n$exe does not exist"
+		error_popup [mc "Unable to start gitk:\n\n%s does not exist" $exe]
 	} else {
 		eval exec $cmd $revs &
 		ui_status $::starting_gitk_msg
@@ -1642,7 +1643,7 @@ proc apply_config {} {
 				font configure $font $cn $cv
 			}
 			} err]} {
-			error_popup "Invalid font specified in gui.$name:\n\n$err"
+			error_popup [append [mc "Invalid font specified in gui.%s:" $name] "\n\n$err"]
 		}
 		foreach {cn cv} [font configure $font] {
 			font configure ${font}bold $cn $cv
@@ -1667,8 +1668,8 @@ set default_config(gui.newbranchtemplate) {}
 set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
 set font_descs {
-	{fontui   font_ui   {Main Font}}
-	{fontdiff font_diff {Diff/Console Font}}
+	{fontui   font_ui   {mc "Main Font"}}
+	{fontdiff font_diff {mc "Diff/Console Font"}}
 }
 load_config 0
 apply_config
@@ -1682,18 +1683,18 @@ set ui_comm {}
 # -- Menu Bar
 #
 menu .mbar -tearoff 0
-.mbar add cascade -label Repository -menu .mbar.repository
-.mbar add cascade -label Edit -menu .mbar.edit
+.mbar add cascade -label [mc Repository] -menu .mbar.repository
+.mbar add cascade -label [mc Edit] -menu .mbar.edit
 if {[is_enabled branch]} {
-	.mbar add cascade -label Branch -menu .mbar.branch
+	.mbar add cascade -label [mc Branch] -menu .mbar.branch
 }
 if {[is_enabled multicommit] || [is_enabled singlecommit]} {
-	.mbar add cascade -label Commit -menu .mbar.commit
+	.mbar add cascade -label [mc Commit] -menu .mbar.commit
 }
 if {[is_enabled transport]} {
-	.mbar add cascade -label Merge -menu .mbar.merge
-	.mbar add cascade -label Fetch -menu .mbar.fetch
-	.mbar add cascade -label Push -menu .mbar.push
+	.mbar add cascade -label [mc Merge] -menu .mbar.merge
+	.mbar add cascade -label [mc Fetch] -menu .mbar.fetch
+	.mbar add cascade -label [mc Push] -menu .mbar.push
 }
 . configure -menu .mbar
 
@@ -1702,87 +1703,87 @@ if {[is_enabled transport]} {
 menu .mbar.repository
 
 .mbar.repository add command \
-	-label {Browse Current Branch's Files} \
+	-label [mc "Browse Current Branch's Files"] \
 	-command {browser::new $current_branch}
 set ui_browse_current [.mbar.repository index last]
 .mbar.repository add command \
-	-label {Browse Branch Files...} \
+	-label [mc "Browse Branch Files..."] \
 	-command browser_open::dialog
 .mbar.repository add separator
 
 .mbar.repository add command \
-	-label {Visualize Current Branch's History} \
+	-label [mc "Visualize Current Branch's History"] \
 	-command {do_gitk $current_branch}
 set ui_visualize_current [.mbar.repository index last]
 .mbar.repository add command \
-	-label {Visualize All Branch History} \
+	-label [mc "Visualize All Branch History"] \
 	-command {do_gitk --all}
 .mbar.repository add separator
 
 proc current_branch_write {args} {
 	global current_branch
 	.mbar.repository entryconf $::ui_browse_current \
-		-label "Browse $current_branch's Files"
+		-label [mc "Browse %s's Files" $current_branch]
 	.mbar.repository entryconf $::ui_visualize_current \
-		-label "Visualize $current_branch's History"
+		-label [mc "Visualize %s's History" $current_branch]
 }
 trace add variable current_branch write current_branch_write
 
 if {[is_enabled multicommit]} {
-	.mbar.repository add command -label {Database Statistics} \
+	.mbar.repository add command -label [mc "Database Statistics"] \
 		-command do_stats
 
-	.mbar.repository add command -label {Compress Database} \
+	.mbar.repository add command -label [mc "Compress Database"] \
 		-command do_gc
 
-	.mbar.repository add command -label {Verify Database} \
+	.mbar.repository add command -label [mc "Verify Database"] \
 		-command do_fsck_objects
 
 	.mbar.repository add separator
 
 	if {[is_Cygwin]} {
 		.mbar.repository add command \
-			-label {Create Desktop Icon} \
+			-label [mc "Create Desktop Icon"] \
 			-command do_cygwin_shortcut
 	} elseif {[is_Windows]} {
 		.mbar.repository add command \
-			-label {Create Desktop Icon} \
+			-label [mc "Create Desktop Icon"] \
 			-command do_windows_shortcut
 	} elseif {[is_MacOSX]} {
 		.mbar.repository add command \
-			-label {Create Desktop Icon} \
+			-label [mc "Create Desktop Icon"] \
 			-command do_macosx_app
 	}
 }
 
-.mbar.repository add command -label Quit \
+.mbar.repository add command -label [mc Quit] \
 	-command do_quit \
 	-accelerator $M1T-Q
 
 # -- Edit Menu
 #
 menu .mbar.edit
-.mbar.edit add command -label Undo \
+.mbar.edit add command -label [mc Undo] \
 	-command {catch {[focus] edit undo}} \
 	-accelerator $M1T-Z
-.mbar.edit add command -label Redo \
+.mbar.edit add command -label [mc Redo] \
 	-command {catch {[focus] edit redo}} \
 	-accelerator $M1T-Y
 .mbar.edit add separator
-.mbar.edit add command -label Cut \
+.mbar.edit add command -label [mc Cut] \
 	-command {catch {tk_textCut [focus]}} \
 	-accelerator $M1T-X
-.mbar.edit add command -label Copy \
+.mbar.edit add command -label [mc Copy] \
 	-command {catch {tk_textCopy [focus]}} \
 	-accelerator $M1T-C
-.mbar.edit add command -label Paste \
+.mbar.edit add command -label [mc Paste] \
 	-command {catch {tk_textPaste [focus]; [focus] see insert}} \
 	-accelerator $M1T-V
-.mbar.edit add command -label Delete \
+.mbar.edit add command -label [mc Delete] \
 	-command {catch {[focus] delete sel.first sel.last}} \
 	-accelerator Del
 .mbar.edit add separator
-.mbar.edit add command -label {Select All} \
+.mbar.edit add command -label [mc "Select All"] \
 	-command {catch {[focus] tag add sel 0.0 end}} \
 	-accelerator $M1T-A
 
@@ -1791,29 +1792,29 @@ menu .mbar.edit
 if {[is_enabled branch]} {
 	menu .mbar.branch
 
-	.mbar.branch add command -label {Create...} \
+	.mbar.branch add command -label [mc "Create..."] \
 		-command branch_create::dialog \
 		-accelerator $M1T-N
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Checkout...} \
+	.mbar.branch add command -label [mc "Checkout..."] \
 		-command branch_checkout::dialog \
 		-accelerator $M1T-O
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Rename...} \
+	.mbar.branch add command -label [mc "Rename..."] \
 		-command branch_rename::dialog
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Delete...} \
+	.mbar.branch add command -label [mc "Delete..."] \
 		-command branch_delete::dialog
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
 
-	.mbar.branch add command -label {Reset...} \
+	.mbar.branch add command -label [mc "Reset..."] \
 		-command merge::reset_hard
 	lappend disable_on_lock [list .mbar.branch entryconf \
 		[.mbar.branch index last] -state]
@@ -1825,7 +1826,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 	menu .mbar.commit
 
 	.mbar.commit add radiobutton \
-		-label {New Commit} \
+		-label [mc "New Commit"] \
 		-command do_select_commit_type \
 		-variable selected_commit_type \
 		-value new
@@ -1833,7 +1834,7 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
 	.mbar.commit add radiobutton \
-		-label {Amend Last Commit} \
+		-label [mc "Amend Last Commit"] \
 		-command do_select_commit_type \
 		-variable selected_commit_type \
 		-value amend
@@ -1842,40 +1843,40 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 
 	.mbar.commit add separator
 
-	.mbar.commit add command -label Rescan \
+	.mbar.commit add command -label [mc Rescan] \
 		-command do_rescan \
 		-accelerator F5
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Stage To Commit} \
+	.mbar.commit add command -label [mc "Stage To Commit"] \
 		-command do_add_selection
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Stage Changed Files To Commit} \
+	.mbar.commit add command -label [mc "Stage Changed Files To Commit"] \
 		-command do_add_all \
 		-accelerator $M1T-I
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Unstage From Commit} \
+	.mbar.commit add command -label [mc "Unstage From Commit"] \
 		-command do_unstage_selection
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
-	.mbar.commit add command -label {Revert Changes} \
+	.mbar.commit add command -label [mc "Revert Changes"] \
 		-command do_revert_selection
 	lappend disable_on_lock \
 		[list .mbar.commit entryconf [.mbar.commit index last] -state]
 
 	.mbar.commit add separator
 
-	.mbar.commit add command -label {Sign Off} \
+	.mbar.commit add command -label [mc "Sign Off"] \
 		-command do_signoff \
 		-accelerator $M1T-S
 
-	.mbar.commit add command -label Commit \
+	.mbar.commit add command -label [mc Commit] \
 		-command do_commit \
 		-accelerator $M1T-Return
 	lappend disable_on_lock \
@@ -1886,12 +1887,12 @@ if {[is_enabled multicommit] || [is_enabled singlecommit]} {
 #
 if {[is_enabled branch]} {
 	menu .mbar.merge
-	.mbar.merge add command -label {Local Merge...} \
+	.mbar.merge add command -label [mc "Local Merge..."] \
 		-command merge::dialog \
 		-accelerator $M1T-M
 	lappend disable_on_lock \
 		[list .mbar.merge entryconf [.mbar.merge index last] -state]
-	.mbar.merge add command -label {Abort Merge...} \
+	.mbar.merge add command -label [mc "Abort Merge..."] \
 		-command merge::reset_hard
 	lappend disable_on_lock \
 		[list .mbar.merge entryconf [.mbar.merge index last] -state]
@@ -1903,38 +1904,38 @@ if {[is_enabled transport]} {
 	menu .mbar.fetch
 
 	menu .mbar.push
-	.mbar.push add command -label {Push...} \
+	.mbar.push add command -label [mc "Push..."] \
 		-command do_push_anywhere \
 		-accelerator $M1T-P
-	.mbar.push add command -label {Delete...} \
+	.mbar.push add command -label [mc "Delete..."] \
 		-command remote_branch_delete::dialog
 }
 
 if {[is_MacOSX]} {
 	# -- Apple Menu (Mac OS X only)
 	#
-	.mbar add cascade -label Apple -menu .mbar.apple
+	.mbar add cascade -label [mc Apple] -menu .mbar.apple
 	menu .mbar.apple
 
-	.mbar.apple add command -label "About [appname]" \
+	.mbar.apple add command -label [mc "About %s" [appname]] \
 		-command do_about
-	.mbar.apple add command -label "Options..." \
+	.mbar.apple add command -label [mc "Options..."] \
 		-command do_options
 } else {
 	# -- Edit Menu
 	#
 	.mbar.edit add separator
-	.mbar.edit add command -label {Options...} \
+	.mbar.edit add command -label [mc "Options..."] \
 		-command do_options
 }
 
 # -- Help Menu
 #
-.mbar add cascade -label Help -menu .mbar.help
+.mbar add cascade -label [mc Help] -menu .mbar.help
 menu .mbar.help
 
 if {![is_MacOSX]} {
-	.mbar.help add command -label "About [appname]" \
+	.mbar.help add command -label [mc "About %s" [appname]] \
 		-command do_about
 }
 
@@ -1971,7 +1972,7 @@ if {[file isfile $doc_path]} {
 }
 
 if {$browser ne {}} {
-	.mbar.help add command -label {Online Documentation} \
+	.mbar.help add command -label [mc "Online Documentation"] \
 		-command [list exec $browser $doc_url &]
 }
 unset browser doc_path doc_url
@@ -2093,7 +2094,7 @@ frame .branch \
 	-borderwidth 1 \
 	-relief sunken
 label .branch.l1 \
-	-text {Current Branch:} \
+	-text [mc "Current Branch:"] \
 	-anchor w \
 	-justify left
 label .branch.cb \
@@ -2114,7 +2115,7 @@ pack .vpane -anchor n -side top -fill both -expand 1
 # -- Index File List
 #
 frame .vpane.files.index -height 100 -width 200
-label .vpane.files.index.title -text {Staged Changes (Will Be Committed)} \
+label .vpane.files.index.title -text [mc "Staged Changes (Will Be Committed)"] \
 	-background lightgreen
 text $ui_index -background white -borderwidth 0 \
 	-width 20 -height 10 \
@@ -2134,7 +2135,7 @@ pack $ui_index -side left -fill both -expand 1
 # -- Working Directory File List
 #
 frame .vpane.files.workdir -height 100 -width 200
-label .vpane.files.workdir.title -text {Unstaged Changes (Will Not Be Committed)} \
+label .vpane.files.workdir.title -text [mc "Unstaged Changes (Will Not Be Committed)"] \
 	-background lightsalmon
 text $ui_workdir -background white -borderwidth 0 \
 	-width 20 -height 10 \
@@ -2175,29 +2176,29 @@ label .vpane.lower.commarea.buttons.l -text {} \
 pack .vpane.lower.commarea.buttons.l -side top -fill x
 pack .vpane.lower.commarea.buttons -side left -fill y
 
-button .vpane.lower.commarea.buttons.rescan -text {Rescan} \
+button .vpane.lower.commarea.buttons.rescan -text [mc Rescan] \
 	-command do_rescan
 pack .vpane.lower.commarea.buttons.rescan -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.rescan conf -state}
 
-button .vpane.lower.commarea.buttons.incall -text {Stage Changed} \
+button .vpane.lower.commarea.buttons.incall -text [mc "Stage Changed"] \
 	-command do_add_all
 pack .vpane.lower.commarea.buttons.incall -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.incall conf -state}
 
-button .vpane.lower.commarea.buttons.signoff -text {Sign Off} \
+button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
 	-command do_signoff
 pack .vpane.lower.commarea.buttons.signoff -side top -fill x
 
-button .vpane.lower.commarea.buttons.commit -text {Commit} \
+button .vpane.lower.commarea.buttons.commit -text [mc Commit] \
 	-command do_commit
 pack .vpane.lower.commarea.buttons.commit -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.commit conf -state}
 
-button .vpane.lower.commarea.buttons.push -text {Push} \
+button .vpane.lower.commarea.buttons.push -text [mc Push] \
 	-command do_push_anywhere
 pack .vpane.lower.commarea.buttons.push -side top -fill x
 
@@ -2208,14 +2209,14 @@ frame .vpane.lower.commarea.buffer.header
 set ui_comm .vpane.lower.commarea.buffer.t
 set ui_coml .vpane.lower.commarea.buffer.header.l
 radiobutton .vpane.lower.commarea.buffer.header.new \
-	-text {New Commit} \
+	-text [mc "New Commit"] \
 	-command do_select_commit_type \
 	-variable selected_commit_type \
 	-value new
 lappend disable_on_lock \
 	[list .vpane.lower.commarea.buffer.header.new conf -state]
 radiobutton .vpane.lower.commarea.buffer.header.amend \
-	-text {Amend Last Commit} \
+	-text [mc "Amend Last Commit"] \
 	-command do_select_commit_type \
 	-variable selected_commit_type \
 	-value amend
@@ -2227,12 +2228,12 @@ label $ui_coml \
 proc trace_commit_type {varname args} {
 	global ui_coml commit_type
 	switch -glob -- $commit_type {
-	initial       {set txt {Initial Commit Message:}}
-	amend         {set txt {Amended Commit Message:}}
-	amend-initial {set txt {Amended Initial Commit Message:}}
-	amend-merge   {set txt {Amended Merge Commit Message:}}
-	merge         {set txt {Merge Commit Message:}}
-	*             {set txt {Commit Message:}}
+	initial       {set txt [mc "Initial Commit Message:"]}
+	amend         {set txt [mc "Amended Commit Message:"]}
+	amend-initial {set txt [mc "Amended Initial Commit Message:"]}
+	amend-merge   {set txt [mc "Amended Merge Commit Message:"]}
+	merge         {set txt [mc "Merge Commit Message:"]}
+	*             {set txt [mc "Commit Message:"]}
 	}
 	$ui_coml conf -text $txt
 }
@@ -2261,23 +2262,23 @@ pack .vpane.lower.commarea.buffer -side left -fill y
 set ctxm .vpane.lower.commarea.buffer.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-	-label {Cut} \
+	-label [mc Cut] \
 	-command {tk_textCut $ui_comm}
 $ctxm add command \
-	-label {Copy} \
+	-label [mc Copy] \
 	-command {tk_textCopy $ui_comm}
 $ctxm add command \
-	-label {Paste} \
+	-label [mc Paste] \
 	-command {tk_textPaste $ui_comm}
 $ctxm add command \
-	-label {Delete} \
+	-label [mc Delete] \
 	-command {$ui_comm delete sel.first sel.last}
 $ctxm add separator
 $ctxm add command \
-	-label {Select All} \
+	-label [mc "Select All"] \
 	-command {focus $ui_comm;$ui_comm tag add sel 0.0 end}
 $ctxm add command \
-	-label {Copy All} \
+	-label [mc "Copy All"] \
 	-command {
 		$ui_comm tag add sel 0.0 end
 		tk_textCopy $ui_comm
@@ -2285,7 +2286,7 @@ $ctxm add command \
 	}
 $ctxm add separator
 $ctxm add command \
-	-label {Sign Off} \
+	-label [mc "Sign Off"] \
 	-command do_signoff
 bind_button3 $ui_comm "tk_popup $ctxm %X %Y"
 
@@ -2301,7 +2302,7 @@ proc trace_current_diff_path {varname args} {
 	} else {
 		set p $current_diff_path
 		set s [mapdesc [lindex $file_states($p) 0] $p]
-		set f {File:}
+		set f [mc "File:"]
 		set p [escape_path $p]
 		set o normal
 	}
@@ -2335,7 +2336,7 @@ pack .vpane.lower.diff.header.path -fill x
 set ctxm .vpane.lower.diff.header.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-	-label {Copy} \
+	-label [mc Copy] \
 	-command {
 		clipboard clear
 		clipboard append \
@@ -2403,19 +2404,19 @@ $ui_diff tag raise sel
 set ctxm .vpane.lower.diff.body.ctxm
 menu $ctxm -tearoff 0
 $ctxm add command \
-	-label {Refresh} \
+	-label [mc Refresh] \
 	-command reshow_diff
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Copy} \
+	-label [mc Copy] \
 	-command {tk_textCopy $ui_diff}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Select All} \
+	-label [mc "Select All"] \
 	-command {focus $ui_diff;$ui_diff tag add sel 0.0 end}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Copy All} \
+	-label [mc "Copy All"] \
 	-command {
 		$ui_diff tag add sel 0.0 end
 		tk_textCopy $ui_diff
@@ -2424,36 +2425,36 @@ $ctxm add command \
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-	-label {Apply/Reverse Hunk} \
+	-label [mc "Apply/Reverse Hunk"] \
 	-command {apply_hunk $cursorX $cursorY}
 set ui_diff_applyhunk [$ctxm index last]
 lappend diff_actions [list $ctxm entryconf $ui_diff_applyhunk -state]
 $ctxm add separator
 $ctxm add command \
-	-label {Decrease Font Size} \
+	-label [mc "Decrease Font Size"] \
 	-command {incr_font_size font_diff -1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Increase Font Size} \
+	-label [mc "Increase Font Size"] \
 	-command {incr_font_size font_diff 1}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
 $ctxm add command \
-	-label {Show Less Context} \
+	-label [mc "Show Less Context"] \
 	-command {if {$repo_config(gui.diffcontext) >= 1} {
 		incr repo_config(gui.diffcontext) -1
 		reshow_diff
 	}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add command \
-	-label {Show More Context} \
+	-label [mc "Show More Context"] \
 	-command {if {$repo_config(gui.diffcontext) < 99} {
 		incr repo_config(gui.diffcontext)
 		reshow_diff
 	}}
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
 $ctxm add separator
-$ctxm add command -label {Options...} \
+$ctxm add command -label [mc "Options..."] \
 	-command do_options
 proc popup_diff_menu {ctxm x y X Y} {
 	global current_diff_path file_states
@@ -2461,7 +2462,7 @@ proc popup_diff_menu {ctxm x y X Y} {
 	set ::cursorY $y
 	if {$::ui_index eq $::current_diff_side} {
 		set s normal
-		set l "Unstage Hunk From Commit"
+		set l [mc "Unstage Hunk From Commit"]
 	} else {
 		if {$current_diff_path eq {}
 			|| ![info exists file_states($current_diff_path)]
@@ -2470,7 +2471,7 @@ proc popup_diff_menu {ctxm x y X Y} {
 		} else {
 			set s normal
 		}
-		set l "Stage Hunk For Commit"
+		set l [mc "Stage Hunk For Commit"]
 	}
 	if {$::is_3way_diff} {
 		set s disabled
@@ -2484,7 +2485,7 @@ bind_button3 $ui_diff [list popup_diff_menu $ctxm %x %y %X %Y]
 #
 set main_status [::status_bar::new .status]
 pack .status -anchor w -side bottom -fill x
-$main_status show {Initializing...}
+$main_status show [mc "Initializing..."]
 
 # -- Load geometry
 #
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 9607284..b5fdad5 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -74,11 +74,11 @@ constructor new {i_commit i_path} {
 	set path   $i_path
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): File Viewer"
+	wm title $top [append "[appname] ([reponame]): " [mc "File Viewer"]]
 
 	frame $w.header -background gold
 	label $w.header.commit_l \
-		-text {Commit:} \
+		-text [mc "Commit:"] \
 		-background gold \
 		-anchor w \
 		-justify left
@@ -101,7 +101,7 @@ constructor new {i_commit i_path} {
 		-anchor w \
 		-justify left
 	label $w.header.path_l \
-		-text {File:} \
+		-text [mc "File:"] \
 		-background gold \
 		-anchor w \
 		-justify left
@@ -246,7 +246,7 @@ constructor new {i_commit i_path} {
 
 	menu $w.ctxm -tearoff 0
 	$w.ctxm add command \
-		-label "Copy Commit" \
+		-label [mc "Copy Commit"] \
 		-command [cb _copycommit]
 
 	foreach i $w_columns {
@@ -366,7 +366,7 @@ method _load {jump} {
 	set amov_data [list [list]]
 	set asim_data [list [list]]
 
-	$status show "Reading $commit:[escape_path $path]..."
+	$status show [mc "Reading %s..." "$commit:[escape_path $path]"]
 	$w_path conf -text [escape_path $path]
 	if {$commit eq {}} {
 		set fd [open $path r]
diff --git a/lib/branch_checkout.tcl b/lib/branch_checkout.tcl
index 72c45b4..6603703 100644
--- a/lib/branch_checkout.tcl
+++ b/lib/branch_checkout.tcl
@@ -11,37 +11,37 @@ field opt_detach    0; # force a detached head case?
 
 constructor dialog {} {
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Checkout Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Checkout Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Checkout Branch} -font font_uibold
+	label $w.header -text [mc "Checkout Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.create -text Checkout \
+	button $w.buttons.create -text [mc Checkout] \
 		-default active \
 		-command [cb _checkout]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	set w_rev [::choose_rev::new $w.rev {Revision}]
+	set w_rev [::choose_rev::new $w.rev [mc Revision]]
 	$w_rev bind_listbox <Double-Button-1> [cb _checkout]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.options -text {Options}
+	labelframe $w.options -text [mc Options]
 
 	checkbutton $w.options.fetch \
-		-text {Fetch Tracking Branch} \
+		-text [mc "Fetch Tracking Branch"] \
 		-variable @opt_fetch
 	pack $w.options.fetch -anchor nw
 
 	checkbutton $w.options.detach \
-		-text {Detach From Local Branch} \
+		-text [mc "Detach From Local Branch"] \
 		-variable @opt_detach
 	pack $w.options.detach -anchor nw
 
diff --git a/lib/branch_create.tcl b/lib/branch_create.tcl
index def615d..53dfb4c 100644
--- a/lib/branch_create.tcl
+++ b/lib/branch_create.tcl
@@ -19,28 +19,28 @@ constructor dialog {} {
 	global repo_config
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Create Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Create Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Create New Branch} -font font_uibold
+	label $w.header -text [mc "Create New Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.create -text Create \
+	button $w.buttons.create -text [mc Create] \
 		-default active \
 		-command [cb _create]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.desc -text {Branch Name}
+	labelframe $w.desc -text [mc "Branch Name"]
 	radiobutton $w.desc.name_r \
 		-anchor w \
-		-text {Name:} \
+		-text [mc "Name:"] \
 		-value user \
 		-variable @name_type
 	set w_name $w.desc.name_t
@@ -55,7 +55,7 @@ constructor dialog {} {
 
 	radiobutton $w.desc.match_r \
 		-anchor w \
-		-text {Match Tracking Branch Name} \
+		-text [mc "Match Tracking Branch Name"] \
 		-value match \
 		-variable @name_type
 	grid $w.desc.match_r -sticky we -padx {0 5} -columnspan 2
@@ -63,38 +63,38 @@ constructor dialog {} {
 	grid columnconfigure $w.desc 1 -weight 1
 	pack $w.desc -anchor nw -fill x -pady 5 -padx 5
 
-	set w_rev [::choose_rev::new $w.rev {Starting Revision}]
+	set w_rev [::choose_rev::new $w.rev [mc "Starting Revision"]]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.options -text {Options}
+	labelframe $w.options -text [mc Options]
 
 	frame $w.options.merge
-	label $w.options.merge.l -text {Update Existing Branch:}
+	label $w.options.merge.l -text [mc "Update Existing Branch:"]
 	pack $w.options.merge.l -side left
 	radiobutton $w.options.merge.no \
-		-text No \
+		-text [mc No] \
 		-value none \
 		-variable @opt_merge
 	pack $w.options.merge.no -side left
 	radiobutton $w.options.merge.ff \
-		-text {Fast Forward Only} \
+		-text [mc "Fast Forward Only"] \
 		-value ff \
 		-variable @opt_merge
 	pack $w.options.merge.ff -side left
 	radiobutton $w.options.merge.reset \
-		-text {Reset} \
+		-text [mc Reset] \
 		-value reset \
 		-variable @opt_merge
 	pack $w.options.merge.reset -side left
 	pack $w.options.merge -anchor nw
 
 	checkbutton $w.options.fetch \
-		-text {Fetch Tracking Branch} \
+		-text [mc "Fetch Tracking Branch"] \
 		-variable @opt_fetch
 	pack $w.options.fetch -anchor nw
 
 	checkbutton $w.options.checkout \
-		-text {Checkout After Creation} \
+		-text [mc "Checkout After Creation"] \
 		-variable @opt_checkout
 	pack $w.options.checkout -anchor nw
 	pack $w.options -anchor nw -fill x -pady 5 -padx 5
@@ -128,7 +128,7 @@ method _create {} {
 				-type ok \
 				-title [wm title $w] \
 				-parent $w \
-				-message "Please select a tracking branch."
+				-message [mc "Please select a tracking branch."]
 			return
 		}
 		if {![regsub ^refs/heads/ [lindex $spec 2] {} newbranch]} {
@@ -137,7 +137,7 @@ method _create {} {
 				-type ok \
 				-title [wm title $w] \
 				-parent $w \
-				-message "Tracking branch [$w get] is not a branch in the remote repository."
+				-message [mc "Tracking branch %s is not a branch in the remote repository." [$w get]]
 			return
 		}
 	}
@@ -150,7 +150,7 @@ method _create {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please supply a branch name."
+			-message [mc "Please supply a branch name."]
 		focus $w_name
 		return
 	}
@@ -161,7 +161,7 @@ method _create {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "'$newbranch' is not an acceptable branch name."
+			-message [mc "'%s' is not an acceptable branch name." $newbranch]
 		focus $w_name
 		return
 	}
diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index c7573c6..86c4f73 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -12,29 +12,29 @@ constructor dialog {} {
 	global current_branch
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Delete Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Delete Local Branch} -font font_uibold
+	label $w.header -text [mc "Delete Local Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
 	set w_delete $w.buttons.delete
 	button $w_delete \
-		-text Delete \
+		-text [mc Delete] \
 		-default active \
 		-state disabled \
 		-command [cb _delete]
 	pack $w_delete -side right
 	button $w.buttons.cancel \
-		-text {Cancel} \
+		-text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.list -text {Local Branches}
+	labelframe $w.list -text [mc "Local Branches"]
 	set w_heads $w.list.l
 	listbox $w_heads \
 		-height 10 \
@@ -49,9 +49,9 @@ constructor dialog {} {
 
 	set w_check [choose_rev::new \
 		$w.check \
-		{Delete Only If Merged Into} \
+		[mc "Delete Only If Merged Into"] \
 		]
-	$w_check none {Always (Do not perform merge test.)}
+	$w_check none [mc "Always (Do not perform merge test.)"]
 	pack $w.check -anchor nw -fill x -pady 5 -padx 5
 
 	foreach h [load_all_heads] {
@@ -100,7 +100,7 @@ method _delete {} {
 		lappend to_delete [list $b $o]
 	}
 	if {$not_merged ne {}} {
-		set msg "The following branches are not completely merged into [$w_check get]:
+		set msg "[mc "The following branches are not completely merged into %s:" [$w_check get]]
 
  - [join $not_merged "\n - "]"
 		tk_messageBox \
@@ -112,9 +112,7 @@ method _delete {} {
 	}
 	if {$to_delete eq {}} return
 	if {$check_cmt eq {}} {
-		set msg {Recovering deleted branches is difficult.
-
-Delete the selected branches?}
+		set msg [mc "Recovering deleted branches is difficult. \n\n Delete the selected branches?"]
 		if {[tk_messageBox \
 			-icon warning \
 			-type yesno \
@@ -140,7 +138,7 @@ Delete the selected branches?}
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Failed to delete branches:\n$failed"
+			-message [mc "Failed to delete branches:\n%s" $failed]
 	}
 
 	destroy $w
diff --git a/lib/branch_rename.tcl b/lib/branch_rename.tcl
index 1cadc31..d6f040e 100644
--- a/lib/branch_rename.tcl
+++ b/lib/branch_rename.tcl
@@ -11,7 +11,7 @@ constructor dialog {} {
 	global current_branch
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Rename Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Rename Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
@@ -19,24 +19,24 @@ constructor dialog {} {
 	set oldname $current_branch
 	set newname [get_config gui.newbranchtemplate]
 
-	label $w.header -text {Rename Branch} -font font_uibold
+	label $w.header -text [mc "Rename Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.rename -text Rename \
+	button $w.buttons.rename -text [mc Rename] \
 		-default active \
 		-command [cb _rename]
 	pack $w.buttons.rename -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
 	frame $w.rename
-	label $w.rename.oldname_l -text {Branch:}
+	label $w.rename.oldname_l -text [mc "Branch:"]
 	eval tk_optionMenu $w.rename.oldname_m @oldname [load_all_heads]
 
-	label $w.rename.newname_l -text {New Name:}
+	label $w.rename.newname_l -text [mc "New Name:"]
 	entry $w.rename.newname_t \
 		-borderwidth 1 \
 		-relief sunken \
@@ -72,7 +72,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please select a branch to rename."
+			-message [mc "Please select a branch to rename."]
 		focus $w.rename.oldname_m
 		return
 	}
@@ -83,7 +83,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please supply a branch name."
+			-message [mc "Please supply a branch name."]
 		focus $w.rename.newname_t
 		return
 	}
@@ -93,7 +93,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Branch '$newname' already exists."
+			-message [mc "Branch '%s' already exists." $newname]
 		focus $w.rename.newname_t
 		return
 	}
@@ -103,7 +103,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "We do not like '$newname' as a branch name."
+			-message [mc "'%s' is not an acceptable branch name." $newname]
 		focus $w.rename.newname_t
 		return
 	}
@@ -114,7 +114,7 @@ method _rename {} {
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Failed to rename '$oldname'.\n\n$err"
+			-message [append [mc "Failed to rename '%s'." $oldname] "\n\n$err"]
 		return
 	}
 
diff --git a/lib/browser.tcl b/lib/browser.tcl
index 888db3c..9876229 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -14,7 +14,7 @@ field w
 field browser_commit
 field browser_path
 field browser_files  {}
-field browser_status {Starting...}
+field browser_status [mc "Starting..."]
 field browser_stack  {}
 field browser_busy   1
 
@@ -23,7 +23,7 @@ field ls_buf     {}; # Buffered record output from ls-tree
 constructor new {commit {path {}}} {
 	global cursor_ptr M1B
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): File Browser"
+	wm title $top [append "[appname] ([reponame]): " [mc "File Browser"]]
 
 	set browser_commit $commit
 	set browser_path $browser_commit:$path
@@ -124,7 +124,7 @@ method _parent {} {
 		} else {
 			regsub {/[^/]+$} $browser_path {} browser_path
 		}
-		set browser_status "Loading $browser_path..."
+		set browser_status [mc "Loading %s..." $browser_path]
 		_ls $this [lindex $parent 0] [lindex $parent 1]
 	}
 }
@@ -141,7 +141,7 @@ method _enter {} {
 		tree {
 			set name [lindex $info 2]
 			set escn [escape_path $name]
-			set browser_status "Loading $escn..."
+			set browser_status [mc "Loading %s..." $escn]
 			append browser_path $escn
 			_ls $this [lindex $info 1] $name
 		}
@@ -185,7 +185,7 @@ method _ls {tree_id {name {}}} {
 			-align center -padx 5 -pady 1 \
 			-name icon0 \
 			-image ::browser::img_parent
-		$w insert end {[Up To Parent]}
+		$w insert end [mc "\[Up To Parent\]"]
 		lappend browser_files parent
 	}
 	lappend browser_stack [list $tree_id $name]
@@ -244,7 +244,7 @@ method _read {fd} {
 
 	if {[eof $fd]} {
 		close $fd
-		set browser_status Ready.
+		set browser_status [mc "Ready."]
 		set browser_busy 0
 		set ls_buf {}
 		if {$n > 0} {
@@ -265,27 +265,27 @@ field w_rev          ; # mega-widget to pick the initial revision
 
 constructor dialog {} {
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Browse Branch Files"
+	wm title $top [append "[appname] ([reponame]): " [mc "Browse Branch Files"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
 	label $w.header \
-		-text {Browse Branch Files} \
+		-text [mc "Browse Branch Files"] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.browse -text Browse \
+	button $w.buttons.browse -text [mc Browse] \
 		-default active \
 		-command [cb _open]
 	pack $w.buttons.browse -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	set w_rev [::choose_rev::new $w.rev {Revision}]
+	set w_rev [::choose_rev::new $w.rev [mc Revision]]
 	$w_rev bind_listbox <Double-Button-1> [cb _open]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
diff --git a/lib/checkout_op.tcl b/lib/checkout_op.tcl
index 170f737..b98c9cb 100644
--- a/lib/checkout_op.tcl
+++ b/lib/checkout_op.tcl
@@ -76,7 +76,7 @@ method run {} {
 		_toplevel $this {Refreshing Tracking Branch}
 		set w_cons [::console::embed \
 			$w.console \
-			"Fetching $r_name from $remote"]
+			[mc "Fetching %s from %s" $r_name $remote]]
 		pack $w.console -fill both -expand 1
 		$w_cons exec $cmd [cb _finish_fetch]
 
@@ -137,7 +137,7 @@ method _finish_fetch {ok} {
 		destroy $w
 		set w {}
 	} else {
-		button $w.close -text Close -command [list destroy $w]
+		button $w.close -text [mc Close] -command [list destroy $w]
 		pack $w.close -side bottom -anchor e -padx 10 -pady 10
 	}
 
@@ -166,7 +166,7 @@ method _update_ref {} {
 		# Assume it does not exist, and that is what the error was.
 		#
 		if {!$create} {
-			_error $this "Branch '$newbranch' does not exist."
+			_error $this [mc "Branch '%s' does not exist." $newbranch]
 			return 0
 		}
 
@@ -176,7 +176,7 @@ method _update_ref {} {
 		# We were told to create it, but not do a merge.
 		# Bad.  Name shouldn't have existed.
 		#
-		_error $this "Branch '$newbranch' already exists."
+		_error $this [mc "Branch '%s' already exists." $newbranch]
 		return 0
 	} elseif {!$create && $merge_type eq {none}} {
 		# We aren't creating, it exists and we don't merge.
@@ -203,7 +203,7 @@ method _update_ref {} {
 					set new $cur
 					set new_hash $cur
 				} else {
-					_error $this "Branch '$newbranch' already exists.\n\nIt cannot fast-forward to $new_expr.\nA merge is required."
+					_error $this [mc "Branch '%s' already exists.\n\nIt cannot fast-forward to %s.\nA merge is required." $newbranch $new_expr]
 					return 0
 				}
 			}
@@ -217,7 +217,7 @@ method _update_ref {} {
 				}
 			}
 			default {
-				_error $this "Merge strategy '$merge_type' not supported."
+				_error $this [mc "Merge strategy '%s' not supported." $merge_type]
 				return 0
 			}
 			}
@@ -236,7 +236,7 @@ method _update_ref {} {
 		if {[catch {
 				git update-ref -m $reflog_msg $ref $new $cur
 			} err]} {
-			_error $this "Failed to update '$newbranch'.\n\n$err"
+			_error $this [append [mc "Failed to update '%s'." $newbranch] "\n\n$err"]
 			return 0
 		}
 	}
@@ -248,7 +248,7 @@ method _checkout {} {
 	if {[lock_index checkout_op]} {
 		after idle [cb _start_checkout]
 	} else {
-		_error $this "Staging area (index) is already locked."
+		_error $this [mc "Staging area (index) is already locked."]
 		delete_this
 	}
 }
@@ -263,12 +263,12 @@ method _start_checkout {} {
 		&& $curType eq {normal}
 		&& $curHEAD eq $HEAD} {
 	} elseif {$commit_type ne $curType || $HEAD ne $curHEAD} {
-		info_popup {Last scanned state does not match repository state.
+		info_popup [mc "Last scanned state does not match repository state.
 
 Another Git program has modified this repository since the last scan.  A rescan must be performed before the current branch can be changed.
 
 The rescan will be automatically started now.
-}
+"]
 		unlock_index
 		rescan ui_ready
 		delete_this
@@ -350,12 +350,12 @@ method _readtree_wait {fd} {
 	if {[catch {close $fd}]} {
 		set err $readtree_d
 		regsub {^fatal: } $err {} err
-		$::main_status stop "Aborted checkout of '[_name $this]' (file level merging is required)."
-		warn_popup "File level merge required.
+		$::main_status stop [mc "Aborted checkout of '%s' (file level merging is required)." [_name $this]]
+		warn_popup [append [mc "File level merge required."] "
 
 $err
 
-Staying on branch '$current_branch'."
+" [mc "Staying on branch '%s'." $current_branch]]
 		unlock_index
 		delete_this
 		return
@@ -426,9 +426,9 @@ method _after_readtree {} {
 	}
 
 	if {$is_detached} {
-		info_popup "You are no longer on a local branch.
+		info_popup [mc "You are no longer on a local branch.
 
-If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."
+If you wanted to be on a branch, create one now starting from 'This Detached Checkout'."]
 	}
 
 	# -- Update our repository state.  If we were previously in
@@ -475,7 +475,7 @@ method _confirm_reset {cur} {
 	pack [label $w.msg1 \
 		-anchor w \
 		-justify left \
-		-text "Resetting '$name' to $new_expr will lose the following commits:" \
+		-text [mc "Resetting '%s' to '%s' will lose the following commits:" $name $new_expr]\
 		] -anchor w
 
 	set list $w.list.l
@@ -497,21 +497,21 @@ method _confirm_reset {cur} {
 	pack [label $w.msg2 \
 		-anchor w \
 		-justify left \
-		-text {Recovering lost commits may not be easy.} \
+		-text [mc "Recovering lost commits may not be easy."] \
 		]
 	pack [label $w.msg3 \
 		-anchor w \
 		-justify left \
-		-text "Reset '$name'?" \
+		-text [mc "Reset '%s'?" $name] \
 		]
 
 	frame $w.buttons
 	button $w.buttons.visualize \
-		-text Visualize \
+		-text [mc Visualize] \
 		-command $gitk
 	pack $w.buttons.visualize -side left
 	button $w.buttons.reset \
-		-text Reset \
+		-text [mc Reset] \
 		-command "
 			set @reset_ok 1
 			destroy $w
@@ -519,7 +519,7 @@ method _confirm_reset {cur} {
 	pack $w.buttons.reset -side right
 	button $w.buttons.cancel \
 		-default active \
-		-text Cancel \
+		-text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -575,13 +575,13 @@ method _toplevel {title} {
 }
 
 method _fatal {err} {
-	error_popup "Failed to set current branch.
+	error_popup [append [mc "Failed to set current branch.
 
 This working directory is only partially switched.  We successfully updated your files, but failed to update an internal Git file.
 
-This should not have occurred.  [appname] will now close and give up.
+This should not have occurred.  %s will now close and give up." [appname]] "
 
-$err"
+$err"]
 	exit 1
 }
 
diff --git a/lib/choose_rev.tcl b/lib/choose_rev.tcl
index ec064b3..a58b752 100644
--- a/lib/choose_rev.tcl
+++ b/lib/choose_rev.tcl
@@ -50,14 +50,14 @@ constructor _new {path unmerged_only title} {
 	if {$is_detached} {
 		radiobutton $w.detachedhead_r \
 			-anchor w \
-			-text {This Detached Checkout} \
+			-text [mc "This Detached Checkout"] \
 			-value HEAD \
 			-variable @revtype
 		grid $w.detachedhead_r -sticky we -padx {0 5} -columnspan 2
 	}
 
 	radiobutton $w.expr_r \
-		-text {Revision Expression:} \
+		-text [mc "Revision Expression:"] \
 		-value expr \
 		-variable @revtype
 	entry $w.expr_t \
@@ -71,17 +71,17 @@ constructor _new {path unmerged_only title} {
 
 	frame $w.types
 	radiobutton $w.types.head_r \
-		-text {Local Branch} \
+		-text [mc "Local Branch"] \
 		-value head \
 		-variable @revtype
 	pack $w.types.head_r -side left
 	radiobutton $w.types.trck_r \
-		-text {Tracking Branch} \
+		-text [mc "Tracking Branch"] \
 		-value trck \
 		-variable @revtype
 	pack $w.types.trck_r -side left
 	radiobutton $w.types.tag_r \
-		-text {Tag} \
+		-text [mc "Tag"] \
 		-value tag \
 		-variable @revtype
 	pack $w.types.tag_r -side left
@@ -314,7 +314,7 @@ method commit_or_die {} {
 		}
 
 		set top [winfo toplevel $w]
-		set msg "Invalid revision: [get $this]\n\n$err"
+		set msg [append [mc "Invalid revision: %s" [get $this]] "\n\n$err"]
 		tk_messageBox \
 			-icon error \
 			-type ok \
@@ -335,7 +335,7 @@ method _expr {} {
 		if {$i ne {}} {
 			return [lindex $cur_specs $i 1]
 		} else {
-			error "No revision selected."
+			error [mc "No revision selected."]
 		}
 	}
 
@@ -343,7 +343,7 @@ method _expr {} {
 		if {$c_expr ne {}} {
 			return $c_expr
 		} else {
-			error "Revision expression is empty."
+			error [mc "Revision expression is empty."]
 		}
 	}
 	HEAD { return HEAD                     }
diff --git a/lib/commit.tcl b/lib/commit.tcl
index f857a2f..15489c6 100644
--- a/lib/commit.tcl
+++ b/lib/commit.tcl
@@ -6,19 +6,19 @@ proc load_last_commit {} {
 	global repo_config
 
 	if {[llength $PARENT] == 0} {
-		error_popup {There is nothing to amend.
+		error_popup [mc "There is nothing to amend.
 
 You are about to create the initial commit.  There is no commit before this to amend.
-}
+"]
 		return
 	}
 
 	repository_state curType curHEAD curMERGE_HEAD
 	if {$curType eq {merge}} {
-		error_popup {Cannot amend while merging.
+		error_popup [mc "Cannot amend while merging.
 
 You are currently in the middle of a merge that has not been fully completed.  You cannot amend the prior commit unless you first abort the current merge activity.
-}
+"]
 		return
 	}
 
@@ -46,7 +46,7 @@ You are currently in the middle of a merge that has not been fully completed.  Y
 			}
 			set msg [string trim $msg]
 		} err]} {
-		error_popup "Error loading commit data for amend:\n\n$err"
+ 	    error_popup [append [mc "Error loading commit data for amend:"] "\n\n$err"]
 		return
 	}
 
@@ -73,12 +73,12 @@ proc committer_ident {} {
 
 	if {$GIT_COMMITTER_IDENT eq {}} {
 		if {[catch {set me [git var GIT_COMMITTER_IDENT]} err]} {
-			error_popup "Unable to obtain your identity:\n\n$err"
+			error_popup [append [mc "Unable to obtain your identity:"] "\n\n$err"]
 			return {}
 		}
 		if {![regexp {^(.*) [0-9]+ [-+0-9]+$} \
 			$me me GIT_COMMITTER_IDENT]} {
-			error_popup "Invalid GIT_COMMITTER_IDENT:\n\n$me"
+			error_popup [append [mc "Invalid GIT_COMMITTER_IDENT:"] "\n\n$me"]
 			return {}
 		}
 	}
@@ -130,12 +130,12 @@ proc commit_tree {} {
 		&& $curType eq {normal}
 		&& $curHEAD eq $HEAD} {
 	} elseif {$commit_type ne $curType || $HEAD ne $curHEAD} {
-		info_popup {Last scanned state does not match repository state.
+		info_popup [mc "Last scanned state does not match repository state.
 
 Another Git program has modified this repository since the last scan.  A rescan must be performed before another commit can be created.
 
 The rescan will be automatically started now.
-}
+"]
 		unlock_index
 		rescan ui_ready
 		return
@@ -151,26 +151,26 @@ The rescan will be automatically started now.
 		D? -
 		M? {set files_ready 1}
 		U? {
-			error_popup "Unmerged files cannot be committed.
+			error_popup [mc "Unmerged files cannot be committed.
 
-File [short_path $path] has merge conflicts.  You must resolve them and stage the file before committing.
-"
+File %s has merge conflicts.  You must resolve them and stage the file before committing.
+" [short_path $path]]
 			unlock_index
 			return
 		}
 		default {
-			error_popup "Unknown file state [lindex $s 0] detected.
+			error_popup [mc "Unknown file state %s detected.
 
-File [short_path $path] cannot be committed by this program.
-"
+File %s cannot be committed by this program.
+" [lindex $s 0] [short_path $path]]
 		}
 		}
 	}
 	if {!$files_ready && ![string match *merge $curType]} {
-		info_popup {No changes to commit.
+		info_popup [mc "No changes to commit.
 
 You must stage at least 1 file before you can commit.
-}
+"]
 		unlock_index
 		return
 	}
@@ -180,14 +180,14 @@ You must stage at least 1 file before you can commit.
 	set msg [string trim [$ui_comm get 1.0 end]]
 	regsub -all -line {[ \t\r]+$} $msg {} msg
 	if {$msg eq {}} {
-		error_popup {Please supply a commit message.
+		error_popup [mc "Please supply a commit message.
 
 A good commit message has the following format:
 
 - First line: Describe in one sentance what you did.
 - Second line: Blank
 - Remaining lines: Describe why this change is good.
-}
+"]
 		unlock_index
 		return
 	}
@@ -254,7 +254,7 @@ proc commit_committree {fd_wt curHEAD msg} {
 
 	gets $fd_wt tree_id
 	if {$tree_id eq {} || [catch {close $fd_wt} err]} {
-		error_popup "write-tree failed:\n\n$err"
+		error_popup [append [mc "write-tree failed:"] "\n\n$err"]
 		ui_status {Commit failed.}
 		unlock_index
 		return
@@ -276,14 +276,14 @@ proc commit_committree {fd_wt curHEAD msg} {
 		}
 
 		if {$tree_id eq $old_tree} {
-			info_popup {No changes to commit.
+			info_popup [mc "No changes to commit.
 
 No files were modified by this commit and it was not a merge commit.
 
 A rescan will be automatically started now.
-}
+"]
 			unlock_index
-			rescan {ui_status {No changes to commit.}}
+			rescan {ui_status [mc "No changes to commit."]}
 			return
 		}
 	}
@@ -314,7 +314,7 @@ A rescan will be automatically started now.
 	}
 	lappend cmd <$msg_p
 	if {[catch {set cmt_id [eval git $cmd]} err]} {
-		error_popup "commit-tree failed:\n\n$err"
+		error_popup [append [mc "commit-tree failed:"] "\n\n$err"]
 		ui_status {Commit failed.}
 		unlock_index
 		return
@@ -336,7 +336,7 @@ A rescan will be automatically started now.
 	if {[catch {
 			git update-ref -m $reflogm HEAD $cmt_id $curHEAD
 		} err]} {
-		error_popup "update-ref failed:\n\n$err"
+		error_popup [append [mc "update-ref failed:"] "\n\n$err"]
 		ui_status {Commit failed.}
 		unlock_index
 		return
@@ -427,5 +427,5 @@ A rescan will be automatically started now.
 	display_all_files
 	unlock_index
 	reshow_diff
-	ui_status "Created commit [string range $cmt_id 0 7]: $subject"
+	ui_status [mc "Created commit %s: %s" [string range $cmt_id 0 7] $subject]
 }
diff --git a/lib/console.tcl b/lib/console.tcl
index 6f718fb..e5f9ba4 100644
--- a/lib/console.tcl
+++ b/lib/console.tcl
@@ -52,7 +52,7 @@ method _init {} {
 		-state disabled \
 		-xscrollcommand [list $w.m.sbx set] \
 		-yscrollcommand [list $w.m.sby set]
-	label $w.m.s -text {Working... please wait...} \
+	label $w.m.s -text [mc "Working... please wait..."] \
 		-anchor w \
 		-justify left \
 		-font font_uibold
@@ -66,11 +66,11 @@ method _init {} {
 	pack $w.m -side top -fill both -expand 1 -padx 5 -pady 10
 
 	menu $w.ctxm -tearoff 0
-	$w.ctxm add command -label "Copy" \
+	$w.ctxm add command -label [mc "Copy"] \
 		-command "tk_textCopy $w.m.t"
-	$w.ctxm add command -label "Select All" \
+	$w.ctxm add command -label [mc "Select All"] \
 		-command "focus $w.m.t;$w.m.t tag add sel 0.0 end"
-	$w.ctxm add command -label "Copy All" \
+	$w.ctxm add command -label [mc "Copy All"] \
 		-command "
 			$w.m.t tag add sel 0.0 end
 			tk_textCopy $w.m.t
@@ -78,7 +78,7 @@ method _init {} {
 		"
 
 	if {$is_toplevel} {
-		button $w.ok -text {Close} \
+		button $w.ok -text [mc "Close"] \
 			-state disabled \
 			-command [list destroy $w]
 		pack $w.ok -side bottom -anchor e -pady 10 -padx 10
@@ -181,7 +181,7 @@ method insert {txt} {
 method done {ok} {
 	if {$ok} {
 		if {[winfo exists $w.m.s]} {
-			$w.m.s conf -background green -text {Success}
+			$w.m.s conf -background green -text [mc "Success"]
 			if {$is_toplevel} {
 				$w.ok conf -state normal
 				focus $w.ok
@@ -191,7 +191,7 @@ method done {ok} {
 		if {![winfo exists $w.m.s]} {
 			_init $this
 		}
-		$w.m.s conf -background red -text {Error: Command Failed}
+		$w.m.s conf -background red -text [mc "Error: Command Failed"]
 		if {$is_toplevel} {
 			$w.ok conf -state normal
 			focus $w.ok
diff --git a/lib/database.tcl b/lib/database.tcl
index 0657cc2..118b1b2 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -24,14 +24,14 @@ proc do_stats {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text {Database Statistics}
+	label $w.header -text [mc "Database Statistics"]
 	pack $w.header -side top -fill x
 
 	frame $w.buttons -border 1
-	button $w.buttons.close -text Close \
+	button $w.buttons.close -text [mc Close] \
 		-default active \
 		-command [list destroy $w]
-	button $w.buttons.gc -text {Compress Database} \
+	button $w.buttons.gc -text [mc "Compress Database"] \
 		-default normal \
 		-command "destroy $w;do_gc"
 	pack $w.buttons.close -side right
@@ -40,16 +40,16 @@ proc do_stats {} {
 
 	frame $w.stat -borderwidth 1 -relief solid
 	foreach s {
-		{count           {Number of loose objects}}
-		{size            {Disk space used by loose objects} { KiB}}
-		{in-pack         {Number of packed objects}}
-		{packs           {Number of packs}}
-		{size-pack       {Disk space used by packed objects} { KiB}}
-		{prune-packable  {Packed objects waiting for pruning}}
-		{garbage         {Garbage files}}
+		{count           {mc "Number of loose objects"}}
+		{size            {mc "Disk space used by loose objects"} { KiB}}
+		{in-pack         {mc "Number of packed objects"}}
+		{packs           {mc "Number of packs"}}
+		{size-pack       {mc "Disk space used by packed objects"} { KiB}}
+		{prune-packable  {mc "Packed objects waiting for pruning"}}
+		{garbage         {mc "Garbage files"}}
 		} {
 		set name [lindex $s 0]
-		set label [lindex $s 1]
+		set label [eval [lindex $s 1]]
 		if {[catch {set value $stats($name)}]} continue
 		if {[llength $s] > 2} {
 			set value "$value[lindex $s 2]"
@@ -64,12 +64,12 @@ proc do_stats {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.close"
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [list destroy $w]
-	wm title $w "[appname] ([reponame]): Database Statistics"
+	wm title $w [append "[appname] ([reponame]): " [mc "Database Statistics"]]
 	tkwait window $w
 }
 
 proc do_gc {} {
-	set w [console::new {gc} {Compressing the object database}]
+	set w [console::new {gc} [mc "Compressing the object database"]]
 	console::chain $w {
 		{exec git pack-refs --prune}
 		{exec git reflog expire --all}
@@ -80,7 +80,7 @@ proc do_gc {} {
 
 proc do_fsck_objects {} {
 	set w [console::new {fsck-objects} \
-		{Verifying the object database with fsck-objects}]
+		[mc "Verifying the object database with fsck-objects"]]
 	set cmd [list git fsck-objects]
 	lappend cmd --full
 	lappend cmd --cache
diff --git a/lib/diff.tcl b/lib/diff.tcl
index e09e125..b1129d5 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -39,13 +39,13 @@ proc handle_empty_diff {} {
 	set s $file_states($path)
 	if {[lindex $s 0] ne {_M}} return
 
-	info_popup "No differences detected.
+	info_popup [mc "No differences detected.
 
-[short_path $path] has no changes.
+%s has no changes.
 
 The modification date of this file was updated by another application, but the content within the file was not changed.
 
-A rescan will be automatically started to find other files which may have the same state."
+A rescan will be automatically started to find other files which may have the same state." [short_path $path]]
 
 	clear_diff
 	display_file $path __
@@ -94,7 +94,7 @@ proc show_diff {path w {lno {}}} {
 			set diff_active 0
 			unlock_index
 			ui_status "Unable to display [escape_path $path]"
-			error_popup "Error loading file:\n\n$err"
+ 		    error_popup [append [mc "Error loading file:"] "\n\n$err"]
 			return
 		}
 		$ui_diff conf -state normal
@@ -159,7 +159,7 @@ proc show_diff {path w {lno {}}} {
 		set diff_active 0
 		unlock_index
 		ui_status "Unable to display [escape_path $path]"
-		error_popup "Error loading diff:\n\n$err"
+		error_popup [append [mc "Error loading diff:"] "\n\n$err"]
 		return
 	}
 
@@ -275,14 +275,14 @@ proc apply_hunk {x y} {
 	set apply_cmd {apply --cached --whitespace=nowarn}
 	set mi [lindex $file_states($current_diff_path) 0]
 	if {$current_diff_side eq $ui_index} {
-		set mode unstage
+		set failed_msg [mc "Failed to unstage selected hunk."]
 		lappend apply_cmd --reverse
 		if {[string index $mi 0] ne {M}} {
 			unlock_index
 			return
 		}
 	} else {
-		set mode stage
+		set failed_msg [mc "Failed to stage selected hunk."]
 		if {[string index $mi 1] ne {M}} {
 			unlock_index
 			return
@@ -307,7 +307,7 @@ proc apply_hunk {x y} {
 		puts -nonewline $p $current_diff_header
 		puts -nonewline $p [$ui_diff get $s_lno $e_lno]
 		close $p} err]} {
-		error_popup "Failed to $mode selected hunk.\n\n$err"
+		error_popup [append $failed_msg "\n\n$err"]
 		unlock_index
 		return
 	}
diff --git a/lib/error.tcl b/lib/error.tcl
index 16a2218..13565b7 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -9,7 +9,7 @@ proc error_popup {msg} {
 	set cmd [list tk_messageBox \
 		-icon error \
 		-type ok \
-		-title "$title: error" \
+		-title [append "$title: " [mc "error"]] \
 		-message $msg]
 	if {[winfo ismapped .]} {
 		lappend cmd -parent .
@@ -25,7 +25,7 @@ proc warn_popup {msg} {
 	set cmd [list tk_messageBox \
 		-icon warning \
 		-type ok \
-		-title "$title: warning" \
+		-title [append "$title: " [mc "warning"]] \
 		-message $msg]
 	if {[winfo ismapped .]} {
 		lappend cmd -parent .
@@ -78,7 +78,7 @@ proc hook_failed_popup {hook msg} {
 		-font font_diff \
 		-yscrollcommand [list $w.m.sby set]
 	label $w.m.l2 \
-		-text {You must correct the above errors before committing.} \
+		-text [mc "You must correct the above errors before committing."] \
 		-anchor w \
 		-justify left \
 		-font font_uibold
@@ -99,6 +99,6 @@ proc hook_failed_popup {hook msg} {
 
 	bind $w <Visibility> "grab $w; focus $w"
 	bind $w <Key-Return> "destroy $w"
-	wm title $w "[appname] ([reponame]): error"
+	wm title $w [append "[appname] ([reponame]): " [mc "error"]]
 	tkwait window $w
 }
diff --git a/lib/index.tcl b/lib/index.tcl
index f47f929..b3f5e17 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -345,26 +345,35 @@ proc revert_helper {txt paths} {
 		}
 	}
 
+
+	# Split question between singular and plural cases, because
+	# such distinction is needed in some languages. Previously, the
+	# code used "Revert changes in" for both, but that can't work
+	# in languages where 'in' must be combined with word from
+	# rest of string (in diffrent way for both cases of course).
+	#
+	# FIXME: Unfortunately, even that isn't enough in some languages
+	# as they have quite complex plural-form rules. Unfortunately,
+	# msgcat doesn't seem to support that kind of string translation.
+	#
 	set n [llength $pathList]
 	if {$n == 0} {
 		unlock_index
 		return
 	} elseif {$n == 1} {
-		set s "[short_path [lindex $pathList]]"
+		set query [mc "Revert changes in file %s?" [short_path [lindex $pathList]]]
 	} else {
-		set s "these $n files"
+		set query [mc "Revert changes in these %i files?" $n]
 	}
 
 	set reply [tk_dialog \
 		.confirm_revert \
 		"[appname] ([reponame])" \
-		"Revert changes in $s?
-
-Any unstaged changes will be permanently lost by the revert." \
+		[mc "Any unstaged changes will be permanently lost by the revert."] \
 		question \
 		1 \
-		{Do Nothing} \
-		{Revert Changes} \
+		[mc "Do Nothing"] \
+		[mc "Revert Changes"] \
 		]
 	if {$reply == 1} {
 		checkout_index \
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 0e50919..63e1427 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -10,10 +10,10 @@ method _can_merge {} {
 	global HEAD commit_type file_states
 
 	if {[string match amend* $commit_type]} {
-		info_popup {Cannot merge while amending.
+		info_popup [mc "Cannot merge while amending.
 
 You must finish amending this commit before starting any type of merge.
-}
+"]
 		return 0
 	}
 
@@ -24,12 +24,12 @@ You must finish amending this commit before starting any type of merge.
 	#
 	repository_state curType curHEAD curMERGE_HEAD
 	if {$commit_type ne $curType || $HEAD ne $curHEAD} {
-		info_popup {Last scanned state does not match repository state.
+		info_popup [mc "Last scanned state does not match repository state.
 
 Another Git program has modified this repository since the last scan.  A rescan must be performed before a merge can be performed.
 
 The rescan will be automatically started now.
-}
+"]
 		unlock_index
 		rescan ui_ready
 		return 0
@@ -41,22 +41,22 @@ The rescan will be automatically started now.
 			continue; # and pray it works!
 		}
 		U? {
-			error_popup "You are in the middle of a conflicted merge.
+			error_popup [mc "You are in the middle of a conflicted merge.
 
-File [short_path $path] has merge conflicts.
+File %s has merge conflicts.
 
 You must resolve them, stage the file, and commit to complete the current merge.  Only then can you begin another merge.
-"
+" [short_path $path]]
 			unlock_index
 			return 0
 		}
 		?? {
-			error_popup "You are in the middle of a change.
+			error_popup [mc "You are in the middle of a change.
 
-File [short_path $path] is modified.
+File %s is modified.
 
 You should complete the current commit before starting a merge.  Doing so will help you abort a failed merge, should the need arise.
-"
+" [short_path $path]]
 			unlock_index
 			return 0
 		}
@@ -103,7 +103,7 @@ method _start {} {
 			regsub {^[^:@]*@} $remote {} remote
 		}
 		set branch [lindex $spec 2]
-		set stitle "$branch of $remote"
+		set stitle [mc "%s of %s" $branch $remote]
 	}
 	regsub ^refs/heads/ $branch {} branch
 	puts $fh "$cmit\t\tbranch '$branch' of $remote"
@@ -116,9 +116,9 @@ method _start {} {
 	lappend cmd HEAD
 	lappend cmd $name
 
-	set msg "Merging $current_branch and $stitle"
+	set msg [mc "Merging %s and %s" $current_branch $stitle]
 	ui_status "$msg..."
-	set cons [console::new "Merge" "merge $stitle"]
+	set cons [console::new [mc "Merge"] "merge $stitle"]
 	console::exec $cons $cmd [cb _finish $cons]
 
 	wm protocol $w WM_DELETE_WINDOW {}
@@ -128,9 +128,9 @@ method _start {} {
 method _finish {cons ok} {
 	console::done $cons $ok
 	if {$ok} {
-		set msg {Merge completed successfully.}
+		set msg [mc "Merge completed successfully."]
 	} else {
-		set msg {Merge failed.  Conflict resolution is required.}
+		set msg [mc "Merge failed.  Conflict resolution is required."]
 	}
 	unlock_index
 	rescan [list ui_status $msg]
@@ -147,7 +147,7 @@ constructor dialog {} {
 	}
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Merge"
+	wm title $top [append "[appname] ([reponame]): " [mc "Merge"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
@@ -155,26 +155,26 @@ constructor dialog {} {
 	set _start [cb _start]
 
 	label $w.header \
-		-text "Merge Into $current_branch" \
+		-text [mc "Merge Into %s" $current_branch] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
 	button $w.buttons.visualize \
-		-text Visualize \
+		-text [mc Visualize] \
 		-command [cb _visualize]
 	pack $w.buttons.visualize -side left
 	button $w.buttons.merge \
-		-text Merge \
+		-text [mc Merge] \
 		-command $_start
 	pack $w.buttons.merge -side right
 	button $w.buttons.cancel \
-		-text {Cancel} \
+		-text [mc "Cancel"] \
 		-command [cb _cancel]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	set w_rev [::choose_rev::new_unmerged $w.rev {Revision To Merge}]
+	set w_rev [::choose_rev::new_unmerged $w.rev [mc "Revision To Merge"]]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
 	bind $w <$M1B-Key-Return> $_start
@@ -209,34 +209,34 @@ proc reset_hard {} {
 	global HEAD commit_type file_states
 
 	if {[string match amend* $commit_type]} {
-		info_popup {Cannot abort while amending.
+		info_popup [mc "Cannot abort while amending.
 
 You must finish amending this commit.
-}
+"]
 		return
 	}
 
 	if {![lock_index abort]} return
 
 	if {[string match *merge* $commit_type]} {
-		set op_question "Abort merge?
+		set op_question [mc "Abort merge?
 
 Aborting the current merge will cause *ALL* uncommitted changes to be lost.
 
-Continue with aborting the current merge?"
+Continue with aborting the current merge?"]
 	} else {
-		set op_question "Reset changes?
+		set op_question [mc "Reset changes?
 
 Resetting the changes will cause *ALL* uncommitted changes to be lost.
 
-Continue with resetting the current changes?"
+Continue with resetting the current changes?"]
 	}
 
 	if {[ask_popup $op_question] eq {yes}} {
 		set fd [git_read --stderr read-tree --reset -u -v HEAD]
 		fconfigure $fd -blocking 0 -translation binary
 		fileevent $fd readable [namespace code [list _reset_wait $fd]]
-		$::main_status start {Aborting} {files reset}
+		$::main_status start [mc "Aborting"] {files reset}
 	} else {
 		unlock_index
 	}
@@ -263,9 +263,9 @@ proc _reset_wait {fd} {
 		catch {file delete [gitdir GITGUI_MSG]}
 
 		if {$fail} {
-			warn_popup "Abort failed.\n\n$err"
+			warn_popup "[mc "Abort failed."]\n\n$err"
 		}
-		rescan {ui_status {Abort completed.  Ready.}}
+		rescan {ui_status [mc "Abort completed.  Ready."]}
 	} else {
 		fconfigure $fd -blocking 0
 	}
diff --git a/lib/option.tcl b/lib/option.tcl
index aa9f783..31c7d47 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -62,7 +62,7 @@ proc do_about {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text "About [appname]" \
+	label $w.header -text [mc "About %s" [appname]] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
@@ -74,8 +74,7 @@ proc do_about {} {
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
 	label $w.desc \
-		-text "git-gui - a graphical user interface for Git.
-$copyright" \
+		-text "[mc "git-gui - a graphical user interface for Git."]\n$copyright" \
 		-padx 5 -pady 5 \
 		-justify left \
 		-anchor w \
@@ -157,48 +156,48 @@ proc do_options {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text "Options" \
+	label $w.header -text [mc "Options"] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.restore -text {Restore Defaults} \
+	button $w.buttons.restore -text [mc "Restore Defaults"] \
 		-default normal \
 		-command do_restore_defaults
 	pack $w.buttons.restore -side left
-	button $w.buttons.save -text Save \
+	button $w.buttons.save -text [mc Save] \
 		-default active \
 		-command [list do_save_config $w]
 	pack $w.buttons.save -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc "Cancel"] \
 		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.repo -text "[reponame] Repository"
-	labelframe $w.global -text {Global (All Repositories)}
+	labelframe $w.repo -text [mc "%s Repository" [reponame]]
+	labelframe $w.global -text [mc "Global (All Repositories)"]
 	pack $w.repo -side left -fill both -expand 1 -pady 5 -padx 5
 	pack $w.global -side right -fill both -expand 1 -pady 5 -padx 5
 
 	set optid 0
 	foreach option {
-		{t user.name {User Name}}
-		{t user.email {Email Address}}
-
-		{b merge.summary {Summarize Merge Commits}}
-		{i-1..5 merge.verbosity {Merge Verbosity}}
-		{b merge.diffstat {Show Diffstat After Merge}}
-
-		{b gui.trustmtime  {Trust File Modification Timestamps}}
-		{b gui.pruneduringfetch {Prune Tracking Branches During Fetch}}
-		{b gui.matchtrackingbranch {Match Tracking Branches}}
-		{i-0..99 gui.diffcontext {Number of Diff Context Lines}}
-		{t gui.newbranchtemplate {New Branch Name Template}}
+		{t user.name {mc "User Name"}}
+		{t user.email {mc "Email Address"}}
+
+		{b merge.summary {mc "Summarize Merge Commits"}}
+		{i-1..5 merge.verbosity {mc "Merge Verbosity"}}
+		{b merge.diffstat {mc "Show Diffstat After Merge"}}
+
+		{b gui.trustmtime  {mc "Trust File Modification Timestamps"}}
+		{b gui.pruneduringfetch {mc "Prune Tracking Branches During Fetch"}}
+		{b gui.matchtrackingbranch {mc "Match Tracking Branches"}}
+		{i-0..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
+		{t gui.newbranchtemplate {mc "New Branch Name Template"}}
 		} {
 		set type [lindex $option 0]
 		set name [lindex $option 1]
-		set text [lindex $option 2]
+		set text [eval [lindex $option 2]]
 		incr optid
 		foreach f {repo global} {
 			switch -glob -- $type {
@@ -246,7 +245,7 @@ proc do_options {} {
 	foreach option $font_descs {
 		set name [lindex $option 0]
 		set font [lindex $option 1]
-		set text [lindex $option 2]
+		set text [eval [lindex $option 2]]
 
 		set global_config_new(gui.$font^^family) \
 			[font configure $font -family]
@@ -272,7 +271,7 @@ proc do_options {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.save"
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list do_save_config $w]
-	wm title $w "[appname] ([reponame]): Options"
+	wm title $w [append "[appname] ([reponame]): " [mc "Options"]]
 	tkwait window $w
 }
 
@@ -303,7 +302,7 @@ proc do_restore_defaults {} {
 
 proc do_save_config {w} {
 	if {[catch {save_config} err]} {
-		error_popup "Failed to completely save options:\n\n$err"
+		error_popup [append [mc "Failed to completely save options:"] "\n\n$err"]
 	}
 	reshow_diff
 	destroy $w
diff --git a/lib/remote.tcl b/lib/remote.tcl
index cf9b9d5..62bfe8f 100644
--- a/lib/remote.tcl
+++ b/lib/remote.tcl
@@ -159,7 +159,7 @@ proc populate_fetch_menu {} {
 		if {$enable} {
 			lappend prune_list $r
 			$m add command \
-				-label "Fetch from $r..." \
+				-label [mc "Fetch from %s..." $r] \
 				-command [list fetch_from $r]
 		}
 	}
@@ -169,7 +169,7 @@ proc populate_fetch_menu {} {
 	}
 	foreach r $prune_list {
 		$m add command \
-			-label "Prune from $r..." \
+			-label [mc "Prune from %s..." $r] \
 			-command [list prune_from $r]
 	}
 }
@@ -203,7 +203,7 @@ proc populate_push_menu {} {
 				$m add separator
 			}
 			$m add command \
-				-label "Push to $r..." \
+				-label [mc "Push to %s..." $r] \
 				-command [list push_to $r]
 			incr fast_count
 		}
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index c88a360..06b5eab 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -26,28 +26,28 @@ constructor dialog {} {
 	global all_remotes M1B
 
 	make_toplevel top w
-	wm title $top "[appname] ([reponame]): Delete Remote Branch"
+	wm title $top [append "[appname] ([reponame]): " [mc "Delete Remote Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text {Delete Remote Branch} -font font_uibold
+	label $w.header -text [mc "Delete Remote Branch"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.delete -text Delete \
+	button $w.buttons.delete -text [mc Delete] \
 		-default active \
 		-command [cb _delete]
 	pack $w.buttons.delete -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc "Cancel"] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.dest -text {From Repository}
+	labelframe $w.dest -text [mc "From Repository"]
 	if {$all_remotes ne {}} {
 		radiobutton $w.dest.remote_r \
-			-text {Remote:} \
+			-text [mc "Remote:"] \
 			-value remote \
 			-variable @urltype
 		eval tk_optionMenu $w.dest.remote_m @remote $all_remotes
@@ -63,7 +63,7 @@ constructor dialog {} {
 		set urltype url
 	}
 	radiobutton $w.dest.url_r \
-		-text {Arbitrary URL:} \
+		-text [mc "Arbitrary URL:"] \
 		-value url \
 		-variable @urltype
 	entry $w.dest.url_t \
@@ -81,7 +81,7 @@ constructor dialog {} {
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
 
-	labelframe $w.heads -text {Branches}
+	labelframe $w.heads -text [mc "Branches"]
 	listbox $w.heads.l \
 		-height 10 \
 		-width 70 \
@@ -96,7 +96,7 @@ constructor dialog {} {
 		-anchor w \
 		-justify left
 	button $w.heads.footer.rescan \
-		-text {Rescan} \
+		-text [mc "Rescan"] \
 		-command [cb _rescan]
 	pack $w.heads.footer.status -side left -fill x
 	pack $w.heads.footer.rescan -side right
@@ -106,9 +106,9 @@ constructor dialog {} {
 	pack $w.heads.l -side left -fill both -expand 1
 	pack $w.heads -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.validate -text {Delete Only If}
+	labelframe $w.validate -text [mc "Delete Only If"]
 	radiobutton $w.validate.head_r \
-		-text {Merged Into:} \
+		-text [mc "Merged Into:"] \
 		-value head \
 		-variable @checktype
 	set head_m [tk_optionMenu $w.validate.head_m @check_head {}]
@@ -116,7 +116,7 @@ constructor dialog {} {
 	trace add variable @check_head write [cb _write_check_head]
 	grid $w.validate.head_r $w.validate.head_m -sticky w
 	radiobutton $w.validate.always_r \
-		-text {Always (Do not perform merge checks)} \
+		-text [mc "Always (Do not perform merge checks)"] \
 		-value always \
 		-variable @checktype
 	grid $w.validate.always_r -columnspan 2 -sticky w
@@ -149,7 +149,7 @@ method _delete {} {
 				-type ok \
 				-title [wm title $w] \
 				-parent $w \
-				-message "A branch is required for 'Merged Into'."
+				-message [mc "A branch is required for 'Merged Into'."]
 			return
 		}
 		set crev $full_cache("$cache\nrefs/heads/$check_head")
@@ -186,9 +186,7 @@ method _delete {} {
  - [join $not_merged "\n - "]"
 
 		if {$need_fetch} {
-			append msg "
-
-One or more of the merge tests failed because you have not fetched the necessary commits.  Try fetching from $uri first."
+			append msg "\n\n" [mc "One or more of the merge tests failed because you have not fetched the necessary commits.  Try fetching from %s first." $uri]
 		}
 
 		tk_messageBox \
@@ -206,7 +204,7 @@ One or more of the merge tests failed because you have not fetched the necessary
 			-type ok \
 			-title [wm title $w] \
 			-parent $w \
-			-message "Please select one or more branches to delete."
+			-message [mc "Please select one or more branches to delete."]
 		return
 	}
 
@@ -215,9 +213,9 @@ One or more of the merge tests failed because you have not fetched the necessary
 		-type yesno \
 		-title [wm title $w] \
 		-parent $w \
-		-message {Recovering deleted branches is difficult.
+		-message [mc "Recovering deleted branches is difficult.
 
-Delete the selected branches?}] ne yes} {
+Delete the selected branches?"]] ne yes} {
 		return
 	}
 
@@ -225,7 +223,7 @@ Delete the selected branches?}] ne yes} {
 
 	set cons [console::new \
 		"push $uri" \
-		"Deleting branches from $uri"]
+		[mc "Deleting branches from %s" $uri]]
 	console::exec $cons $push_cmd
 }
 
@@ -285,12 +283,12 @@ method _load {cache uri} {
 		$w.heads.l conf -state disabled
 		set head_list [list]
 		set full_list [list]
-		set status {No repository selected.}
+		set status [mc "No repository selected."]
 		return
 	}
 
 	if {[catch {set x $cached($cache)}]} {
-		set status "Scanning $uri..."
+		set status [mc "Scanning %s..." $uri]
 		$w.heads.l conf -state disabled
 		set head_list [list]
 		set full_list [list]
diff --git a/lib/shortcut.tcl b/lib/shortcut.tcl
index c36be2f..d0e63a3 100644
--- a/lib/shortcut.tcl
+++ b/lib/shortcut.tcl
@@ -6,7 +6,7 @@ proc do_windows_shortcut {} {
 
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title "[appname] ([reponame]): Create Desktop Icon" \
+		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
 		-initialfile "Git [reponame].bat"]
 	if {$fn != {}} {
 		if {[file extension $fn] ne {.bat}} {
@@ -23,7 +23,7 @@ proc do_windows_shortcut {} {
 				puts $fd " \"[file normalize $argv0]\""
 				close $fd
 			} err]} {
-			error_popup "Cannot write script:\n\n$err"
+			error_popup [append [mc "Cannot write script:"] "\n\n$err"]
 		}
 	}
 }
@@ -42,7 +42,7 @@ proc do_cygwin_shortcut {} {
 	}
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title "[appname] ([reponame]): Create Desktop Icon" \
+		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
 		-initialdir $desktop \
 		-initialfile "Git [reponame].bat"]
 	if {$fn != {}} {
@@ -71,7 +71,7 @@ proc do_cygwin_shortcut {} {
 				puts $fd " &\""
 				close $fd
 			} err]} {
-			error_popup "Cannot write script:\n\n$err"
+			error_popup [append [mc "Cannot write script:"] "\n\n$err"]
 		}
 	}
 }
@@ -81,7 +81,7 @@ proc do_macosx_app {} {
 
 	set fn [tk_getSaveFile \
 		-parent . \
-		-title "[appname] ([reponame]): Create Desktop Icon" \
+		-title [append "[appname] ([reponame]): " [mc "Create Desktop Icon"]] \
 		-initialdir [file join $env(HOME) Desktop] \
 		-initialfile "Git [reponame].app"]
 	if {$fn != {}} {
@@ -146,7 +146,7 @@ proc do_macosx_app {} {
 
 				file attributes $exe -permissions u+x,g+x,o+x
 			} err]} {
-			error_popup "Cannot write icon:\n\n$err"
+			error_popup [append [mc "Cannot write icon:"] "\n\n$err"]
 		}
 	}
 }
diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
index 72a8fe1..769ef81 100644
--- a/lib/status_bar.tcl
+++ b/lib/status_bar.tcl
@@ -55,7 +55,7 @@ method update {have total} {
 		set pdone [expr {100 * $have / $total}]
 	}
 
-	set status [format "%s ... %i of %i %s (%2i%%)" \
+	set status [mc "%s ... %i of %i %s (%2i%%)" \
 		$prefix $have $total $units $pdone]
 	$w_c coords bar 0 0 $pdone 20
 }
diff --git a/lib/transport.tcl b/lib/transport.tcl
index 3a22bd4..1c7baef 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -4,7 +4,7 @@
 proc fetch_from {remote} {
 	set w [console::new \
 		"fetch $remote" \
-		"Fetching new changes from $remote"]
+		[mc "Fetching new changes from %s" $remote]]
 	set cmds [list]
 	lappend cmds [list exec git fetch $remote]
 	if {[is_config_true gui.pruneduringfetch]} {
@@ -16,14 +16,14 @@ proc fetch_from {remote} {
 proc prune_from {remote} {
 	set w [console::new \
 		"remote prune $remote" \
-		"Pruning tracking branches deleted from $remote"]
+		[mc "Pruning tracking branches deleted from %s" $remote]]
 	console::exec $w [list git remote prune $remote]
 }
 
 proc push_to {remote} {
 	set w [console::new \
 		"push $remote" \
-		"Pushing changes to $remote"]
+		[mc "Pushing changes to %s" $remote]]
 	set cmd [list git push]
 	lappend cmd -v
 	lappend cmd $remote
@@ -65,7 +65,7 @@ proc start_push_anywhere_action {w} {
 
 	set cons [console::new \
 		"push $r_url" \
-		"Pushing $cnt $unit to $r_url"]
+		[mc "Pushing %s %s to %s" $cnt $unit $r_url]]
 	console::exec $cons $cmd
 	destroy $w
 }
@@ -81,21 +81,21 @@ proc do_push_anywhere {} {
 	toplevel $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text {Push Branches} -font font_uibold
+	label $w.header -text [mc "Push Branches"] -font font_uibold
 	pack $w.header -side top -fill x
 
 	frame $w.buttons
-	button $w.buttons.create -text Push \
+	button $w.buttons.create -text [mc Push] \
 		-default active \
 		-command [list start_push_anywhere_action $w]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text {Cancel} \
+	button $w.buttons.cancel -text [mc "Cancel"] \
 		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.source -text {Source Branches}
+	labelframe $w.source -text [mc "Source Branches"]
 	listbox $w.source.l \
 		-height 10 \
 		-width 70 \
@@ -112,10 +112,10 @@ proc do_push_anywhere {} {
 	pack $w.source.l -side left -fill both -expand 1
 	pack $w.source -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.dest -text {Destination Repository}
+	labelframe $w.dest -text [mc "Destination Repository"]
 	if {$all_remotes ne {}} {
 		radiobutton $w.dest.remote_r \
-			-text {Remote:} \
+			-text [mc "Remote:"] \
 			-value remote \
 			-variable push_urltype
 		eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
@@ -130,7 +130,7 @@ proc do_push_anywhere {} {
 		set push_urltype url
 	}
 	radiobutton $w.dest.url_r \
-		-text {Arbitrary URL:} \
+		-text [mc "Arbitrary URL:"] \
 		-value url \
 		-variable push_urltype
 	entry $w.dest.url_t \
@@ -150,13 +150,13 @@ proc do_push_anywhere {} {
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
 
-	labelframe $w.options -text {Transfer Options}
+	labelframe $w.options -text [mc "Transfer Options"]
 	checkbutton $w.options.thin \
-		-text {Use thin pack (for slow network connections)} \
+		-text [mc "Use thin pack (for slow network connections)"] \
 		-variable push_thin
 	grid $w.options.thin -columnspan 2 -sticky w
 	checkbutton $w.options.tags \
-		-text {Include tags} \
+		-text [mc "Include tags"] \
 		-variable push_tags
 	grid $w.options.tags -columnspan 2 -sticky w
 	grid columnconfigure $w.options 1 -weight 1
@@ -169,6 +169,6 @@ proc do_push_anywhere {} {
 	bind $w <Visibility> "grab $w; focus $w.buttons.create"
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list start_push_anywhere_action $w]
-	wm title $w "[appname] ([reponame]): Push"
+	wm title $w [append "[appname] ([reponame]): " [mc "Push"]]
 	tkwait window $w
 }
-- 
1.5.3.2.g46909
