From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: use themed tk widgets with Tk 8.5
Date: Sun, 20 Dec 2009 00:46:56 +0000
Message-ID: <87my1ev4gi.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 20 02:07:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NMAGR-00078h-Nq
	for gcvg-git-2@lo.gmane.org; Sun, 20 Dec 2009 02:07:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbZLTBHH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 20:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754784AbZLTBHH
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 20:07:07 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:44454 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754487AbZLTBHB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Dec 2009 20:07:01 -0500
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1NMAGA-0003sW-FO; Sun, 20 Dec 2009 01:06:58 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1NMAG7-0001dX-8t; Sun, 20 Dec 2009 01:06:56 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 9F25F13D389; Sun, 20 Dec 2009 01:06:54 +0000 (GMT)
Cc: msysgit@googlegroups.com
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.90 (usg-unix-v)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135515>

 This patch enables the use of themed Tk widgets with Tk 8.5 and above.
 These make a significant difference on Windows in making the application
 appear native. The gui.usettk git config variable may be set to disable
 this if the user prefers the classic Tk look.
 On Windows and MacOSX ttk defaults to the native look as much as possible.
 On X11 the user may select a theme using the TkTheme XRDB resource class.
 Some support is included for Tk 8.6 features (themed spinbox and native
 font chooser for MacOSX and Windows).

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

There is a screenshot of this running on Windows 7 at
http://www.patthoyts.tk/screenshots/git-gui-win32.png
It has been tested on Linux but not on MacOSX yet.

---
 git-gui.sh                   |  158 +++++++++++++++++++++++++++---------------
 lib/about.tcl                |   53 +++++++-------
 lib/blame.tcl                |   22 +++---
 lib/branch_checkout.tcl      |   20 +++--
 lib/branch_create.tcl        |   45 ++++++------
 lib/branch_delete.tcl        |   24 +++---
 lib/branch_rename.tcl        |   32 +++++----
 lib/browser.tcl              |   41 ++++++-----
 lib/choose_font.tcl          |   31 +++++----
 lib/choose_repository.tcl    |   94 ++++++++++++-------------
 lib/choose_rev.tcl           |   51 ++++++++------
 lib/class.tcl                |    7 ++
 lib/console.tcl              |   17 +++--
 lib/database.tcl             |   20 +++---
 lib/error.tcl                |   15 +++--
 lib/index.tcl                |   13 ++--
 lib/merge.tcl                |   14 ++--
 lib/option.tcl               |   67 ++++++++++--------
 lib/remote_add.tcl           |   37 +++++-----
 lib/remote_branch_delete.tcl |   51 +++++++-------
 lib/search.tcl               |   11 ++--
 lib/sshkey.tcl               |   20 +++---
 lib/status_bar.tcl           |   14 ++--
 lib/themed.tcl               |  156 +++++++++++++++++++++++++++++++++++++++++
 lib/tools_dlg.tcl            |   87 +++++++++++-------------
 lib/transport.tcl            |   48 +++++++------
 26 files changed, 695 insertions(+), 453 deletions(-)
 create mode 100644 lib/themed.tcl

diff --git a/git-gui.sh b/git-gui.sh
index 718277a..0e21a0a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -649,12 +649,17 @@ if {[is_Windows]} {
 ## config defaults
 
 set cursor_ptr arrow
-font create font_diff -family Courier -size 10
 font create font_ui
-catch {
-	label .dummy
-	eval font configure font_ui [font actual [.dummy cget -font]]
-	destroy .dummy
+if {[lsearch -exact [font names] TkDefaultFont] != -1} {
+	eval [linsert [font actual TkDefaultFont] 0 font configure font_ui]
+	eval [linsert [font actual TkFixedFont] 0 font create font_diff]
+} else {
+	font create font_diff -family Courier -size 10
+	catch {
+		label .dummy
+		eval font configure font_ui [font actual [.dummy cget -font]]
+		destroy .dummy
+	}
 }
 
 font create font_uiitalic
@@ -669,6 +674,9 @@ foreach class {Button Checkbutton Entry Label
 }
 if {![is_MacOSX]} {
 	option add *Menu.font font_ui
+	option add *Entry.borderWidth 1 startupFile
+	option add *Entry.relief sunken startupFile
+	option add *RadioButton.anchor w startupFile
 }
 unset class
 
@@ -721,6 +729,18 @@ proc apply_config {} {
 		font configure ${font}bold -weight bold
 		font configure ${font}italic -slant italic
 	}
+
+	global use_ttk NS
+	set use_ttk 0
+	set NS {}
+	if {$repo_config(gui.usettk)} {
+		set use_ttk [package vsatisfies [package provide Tk] 8.5]
+		if {$use_ttk} {
+			set NS ttk
+			bind [winfo class .] <<ThemeChanged>> [list InitTheme]
+			pave_toplevel .
+		}
+	}
 }
 
 set default_config(branch.autosetupmerge) true
@@ -747,6 +767,7 @@ set default_config(gui.fontui) [font configure font_ui]
 set default_config(gui.fontdiff) [font configure font_diff]
 # TODO: this option should be added to the git-config documentation
 set default_config(gui.maxfilesdisplayed) 5000
+set default_config(gui.usettk) 1
 set font_descs {
 	{fontui   font_ui   {mc "Main Font"}}
 	{fontdiff font_diff {mc "Diff/Console Font"}}
@@ -1983,7 +2004,7 @@ proc do_quit {{rc {1}}} {
 	global ui_comm is_quitting repo_config commit_type
 	global GITGUI_BCK_exists GITGUI_BCK_i
 	global ui_comm_spell
-	global ret_code
+	global ret_code use_ttk
 
 	if {$is_quitting} return
 	set is_quitting 1
@@ -2041,8 +2062,13 @@ proc do_quit {{rc {1}}} {
 		}
 		set cfg_geometry [list]
 		lappend cfg_geometry [wm geometry .]
-		lappend cfg_geometry [lindex [.vpane sash coord 0] 0]
-		lappend cfg_geometry [lindex [.vpane.files sash coord 0] 1]
+		if {$use_ttk} {
+			lappend cfg_geometry [.vpane sashpos 0]
+			lappend cfg_geometry [.vpane.files sashpos 0]
+		} else {
+			lappend cfg_geometry [lindex [.vpane sash coord 0] 0]
+			lappend cfg_geometry [lindex [.vpane.files sash coord 0] 1]
+		}
 		if {[catch {set rc_geometry $repo_config(gui.geometry)}]} {
 			set rc_geometry {}
 		}
@@ -2807,14 +2833,13 @@ default {
 
 # -- Branch Control
 #
-frame .branch \
-	-borderwidth 1 \
-	-relief sunken
-label .branch.l1 \
+${NS}::frame .branch
+if {!$use_ttk} {.branch configure -borderwidth 1 -relief sunken}
+${NS}::label .branch.l1 \
 	-text [mc "Current Branch:"] \
 	-anchor w \
 	-justify left
-label .branch.cb \
+${NS}::label .branch.cb \
 	-textvariable current_branch \
 	-anchor w \
 	-justify left
@@ -2824,15 +2849,20 @@ pack .branch -side top -fill x
 
 # -- Main Window Layout
 #
-panedwindow .vpane -orient horizontal
-panedwindow .vpane.files -orient vertical
-.vpane add .vpane.files -sticky nsew -height 100 -width 200
+${NS}::panedwindow .vpane -orient horizontal
+${NS}::panedwindow .vpane.files -orient vertical
+if {$use_ttk} {
+	.vpane add .vpane.files
+} else {
+	.vpane add .vpane.files -sticky nsew -height 100 -width 200
+}
 pack .vpane -anchor n -side top -fill both -expand 1
 
 # -- Index File List
 #
-frame .vpane.files.index -height 100 -width 200
-label .vpane.files.index.title -text [mc "Staged Changes (Will Commit)"] \
+${NS}::frame .vpane.files.index -height 100 -width 200
+tlabel .vpane.files.index.title \
+	-text [mc "Staged Changes (Will Commit)"] \
 	-background lightgreen -foreground black
 text $ui_index -background white -foreground black \
 	-borderwidth 0 \
@@ -2842,8 +2872,8 @@ text $ui_index -background white -foreground black \
 	-xscrollcommand {.vpane.files.index.sx set} \
 	-yscrollcommand {.vpane.files.index.sy set} \
 	-state disabled
-scrollbar .vpane.files.index.sx -orient h -command [list $ui_index xview]
-scrollbar .vpane.files.index.sy -orient v -command [list $ui_index yview]
+${NS}::scrollbar .vpane.files.index.sx -orient h -command [list $ui_index xview]
+${NS}::scrollbar .vpane.files.index.sy -orient v -command [list $ui_index yview]
 pack .vpane.files.index.title -side top -fill x
 pack .vpane.files.index.sx -side bottom -fill x
 pack .vpane.files.index.sy -side right -fill y
@@ -2851,8 +2881,8 @@ pack $ui_index -side left -fill both -expand 1
 
 # -- Working Directory File List
 #
-frame .vpane.files.workdir -height 100 -width 200
-label .vpane.files.workdir.title -text [mc "Unstaged Changes"] \
+${NS}::frame .vpane.files.workdir -height 100 -width 200
+tlabel .vpane.files.workdir.title -text [mc "Unstaged Changes"] \
 	-background lightsalmon -foreground black
 text $ui_workdir -background white -foreground black \
 	-borderwidth 0 \
@@ -2862,15 +2892,19 @@ text $ui_workdir -background white -foreground black \
 	-xscrollcommand {.vpane.files.workdir.sx set} \
 	-yscrollcommand {.vpane.files.workdir.sy set} \
 	-state disabled
-scrollbar .vpane.files.workdir.sx -orient h -command [list $ui_workdir xview]
-scrollbar .vpane.files.workdir.sy -orient v -command [list $ui_workdir yview]
+${NS}::scrollbar .vpane.files.workdir.sx -orient h -command [list $ui_workdir xview]
+${NS}::scrollbar .vpane.files.workdir.sy -orient v -command [list $ui_workdir yview]
 pack .vpane.files.workdir.title -side top -fill x
 pack .vpane.files.workdir.sx -side bottom -fill x
 pack .vpane.files.workdir.sy -side right -fill y
 pack $ui_workdir -side left -fill both -expand 1
 
-.vpane.files add .vpane.files.workdir -sticky nsew
-.vpane.files add .vpane.files.index -sticky nsew
+.vpane.files add .vpane.files.workdir
+.vpane.files add .vpane.files.index
+if {!$use_ttk} {
+	.vpane.files paneconfigure .vpane.files.workdir -sticky news
+	.vpane.files paneconfigure .vpane.files.index -sticky news
+}
 
 foreach i [list $ui_index $ui_workdir] {
 	rmsel_tag $i
@@ -2880,68 +2914,69 @@ unset i
 
 # -- Diff and Commit Area
 #
-frame .vpane.lower -height 300 -width 400
-frame .vpane.lower.commarea
-frame .vpane.lower.diff -relief sunken -borderwidth 1
+${NS}::frame .vpane.lower -height 300 -width 400
+${NS}::frame .vpane.lower.commarea
+${NS}::frame .vpane.lower.diff -relief sunken -borderwidth 1
 pack .vpane.lower.diff -fill both -expand 1
 pack .vpane.lower.commarea -side bottom -fill x
-.vpane add .vpane.lower -sticky nsew
+.vpane add .vpane.lower
+if {!$use_ttk} {.vpane paneconfigure .vpane.lower -sticky nsew}
 
 # -- Commit Area Buttons
 #
-frame .vpane.lower.commarea.buttons
-label .vpane.lower.commarea.buttons.l -text {} \
+${NS}::frame .vpane.lower.commarea.buttons
+${NS}::label .vpane.lower.commarea.buttons.l -text {} \
 	-anchor w \
 	-justify left
 pack .vpane.lower.commarea.buttons.l -side top -fill x
 pack .vpane.lower.commarea.buttons -side left -fill y
 
-button .vpane.lower.commarea.buttons.rescan -text [mc Rescan] \
+${NS}::button .vpane.lower.commarea.buttons.rescan -text [mc Rescan] \
 	-command ui_do_rescan
 pack .vpane.lower.commarea.buttons.rescan -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.rescan conf -state}
 
-button .vpane.lower.commarea.buttons.incall -text [mc "Stage Changed"] \
+${NS}::button .vpane.lower.commarea.buttons.incall -text [mc "Stage Changed"] \
 	-command do_add_all
 pack .vpane.lower.commarea.buttons.incall -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.incall conf -state}
 
 if {![is_enabled nocommitmsg]} {
-	button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
+	${NS}::button .vpane.lower.commarea.buttons.signoff -text [mc "Sign Off"] \
 		-command do_signoff
 	pack .vpane.lower.commarea.buttons.signoff -side top -fill x
 }
 
-button .vpane.lower.commarea.buttons.commit -text [commit_btn_caption] \
+${NS}::button .vpane.lower.commarea.buttons.commit -text [commit_btn_caption] \
 	-command do_commit
 pack .vpane.lower.commarea.buttons.commit -side top -fill x
 lappend disable_on_lock \
 	{.vpane.lower.commarea.buttons.commit conf -state}
 
 if {![is_enabled nocommit]} {
-	button .vpane.lower.commarea.buttons.push -text [mc Push] \
+	${NS}::button .vpane.lower.commarea.buttons.push -text [mc Push] \
 		-command do_push_anywhere
 	pack .vpane.lower.commarea.buttons.push -side top -fill x
 }
 
 # -- Commit Message Buffer
 #
-frame .vpane.lower.commarea.buffer
-frame .vpane.lower.commarea.buffer.header
+${NS}::frame .vpane.lower.commarea.buffer
+${NS}::frame .vpane.lower.commarea.buffer.header
 set ui_comm .vpane.lower.commarea.buffer.t
 set ui_coml .vpane.lower.commarea.buffer.header.l
 
 if {![is_enabled nocommit]} {
-	radiobutton .vpane.lower.commarea.buffer.header.new \
+	${NS}::radiobutton .vpane.lower.commarea.buffer.header.new \
 		-text [mc "New Commit"] \
 		-command do_select_commit_type \
 		-variable selected_commit_type \
 		-value new
 	lappend disable_on_lock \
 		[list .vpane.lower.commarea.buffer.header.new conf -state]
-	radiobutton .vpane.lower.commarea.buffer.header.amend \
+	${NS}::radiobutton .vpane.lower.commarea.buffer.header.amend \
 		-text [mc "Amend Last Commit"] \
 		-command do_select_commit_type \
 		-variable selected_commit_type \
@@ -2950,7 +2985,7 @@ if {![is_enabled nocommit]} {
 		[list .vpane.lower.commarea.buffer.header.amend conf -state]
 }
 
-label $ui_coml \
+${NS}::label $ui_coml \
 	-anchor w \
 	-justify left
 proc trace_commit_type {varname args} {
@@ -2982,7 +3017,7 @@ text $ui_comm -background white -foreground black \
 	-width $repo_config(gui.commitmsgwidth) -height 9 -wrap none \
 	-font font_diff \
 	-yscrollcommand {.vpane.lower.commarea.buffer.sby set}
-scrollbar .vpane.lower.commarea.buffer.sby \
+${NS}::scrollbar .vpane.lower.commarea.buffer.sby \
 	-command [list $ui_comm yview]
 pack .vpane.lower.commarea.buffer.header -side top -fill x
 pack .vpane.lower.commarea.buffer.sby -side right -fill y
@@ -3048,19 +3083,19 @@ proc trace_current_diff_path {varname args} {
 }
 trace add variable current_diff_path write trace_current_diff_path
 
-frame .vpane.lower.diff.header -background gold
-label .vpane.lower.diff.header.status \
+gold_frame .vpane.lower.diff.header
+tlabel .vpane.lower.diff.header.status \
 	-background gold \
 	-foreground black \
 	-width $max_status_desc \
 	-anchor w \
 	-justify left
-label .vpane.lower.diff.header.file \
+tlabel .vpane.lower.diff.header.file \
 	-background gold \
 	-foreground black \
 	-anchor w \
 	-justify left
-label .vpane.lower.diff.header.path \
+tlabel .vpane.lower.diff.header.path \
 	-background gold \
 	-foreground black \
 	-anchor w \
@@ -3084,7 +3119,7 @@ bind_button3 .vpane.lower.diff.header.path "tk_popup $ctxm %X %Y"
 
 # -- Diff Body
 #
-frame .vpane.lower.diff.body
+${NS}::frame .vpane.lower.diff.body
 set ui_diff .vpane.lower.diff.body.t
 text $ui_diff -background white -foreground black \
 	-borderwidth 0 \
@@ -3093,9 +3128,9 @@ text $ui_diff -background white -foreground black \
 	-xscrollcommand {.vpane.lower.diff.body.sbx set} \
 	-yscrollcommand {.vpane.lower.diff.body.sby set} \
 	-state disabled
-scrollbar .vpane.lower.diff.body.sbx -orient horizontal \
+${NS}::scrollbar .vpane.lower.diff.body.sbx -orient horizontal \
 	-command [list $ui_diff xview]
-scrollbar .vpane.lower.diff.body.sby -orient vertical \
+${NS}::scrollbar .vpane.lower.diff.body.sby -orient vertical \
 	-command [list $ui_diff yview]
 pack .vpane.lower.diff.body.sbx -side bottom -fill x
 pack .vpane.lower.diff.body.sby -side right -fill y
@@ -3274,12 +3309,17 @@ $main_status show [mc "Initializing..."]
 catch {
 set gm $repo_config(gui.geometry)
 wm geometry . [lindex $gm 0]
-.vpane sash place 0 \
-	[lindex $gm 1] \
-	[lindex [.vpane sash coord 0] 1]
-.vpane.files sash place 0 \
-	[lindex [.vpane.files sash coord 0] 0] \
-	[lindex $gm 2]
+if {$use_ttk} {
+	.vpane sashpos 0 [lindex $gm 1]
+	.vpane.files sashpos 0 [lindex $gm 2]
+} else {
+	.vpane sash place 0 \
+		[lindex $gm 1] \
+		[lindex [.vpane sash coord 0] 1]
+	.vpane.files sash place 0 \
+		[lindex [.vpane.files sash coord 0] 0] \
+		[lindex $gm 2]
+}
 unset gm
 }
 
@@ -3543,3 +3583,9 @@ if {[is_enabled retcode]} {
 if {$picked && [is_config_true gui.autoexplore]} {
 	do_explore
 }
+
+# Local variables:
+# mode: tcl
+# indent-tabs-mode: t
+# tab-width: 4
+# End:
diff --git a/lib/about.tcl b/lib/about.tcl
index 241ab89..1731ddf 100644
--- a/lib/about.tcl
+++ b/lib/about.tcl
@@ -1,34 +1,45 @@
 # git-gui about git-gui dialog
 # Copyright (C) 2006, 2007 Shawn Pearce
+proc pad_label {w args} {
+	global use_ttk
+	if {$use_ttk} {
+		ttk::style configure Padded.TLabel \
+			-padding {5 5} -borderwidth 1 -relief solid
+		set cmd [linsert $args 0 ttk::label $w -style Padded.TLabel]
+	} else {
+		set cmd [linsert $args 0 label $w \
+					 -padx 5 -pady 5 \
+					 -justify left \
+					 -anchor w \
+					 -borderwidth 1 \
+					 -relief solid]
+	}
+	eval $cmd
+}
 
 proc do_about {} {
 	global appvers copyright oguilib
 	global tcl_patchLevel tk_patchLevel
-	global ui_comm_spell
+	global ui_comm_spell NS use_ttk
 
 	set w .about_dialog
-	toplevel $w
+	Dialog $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
 	pack [git_logo $w.git_logo] -side left -fill y -padx 10 -pady 10
-	label $w.header -text [mc "About %s" [appname]] \
-		-font font_uibold
+	${NS}::label $w.header -text [mc "About %s" [appname]] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.close -text {Close} \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.close -text {Close} \
 		-default active \
 		-command [list destroy $w]
 	pack $w.buttons.close -side right
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	label $w.desc \
-		-text "[mc "git-gui - a graphical user interface for Git."]\n$copyright" \
-		-padx 5 -pady 5 \
-		-justify left \
-		-anchor w \
-		-borderwidth 1 \
-		-relief solid
+	pad_label $w.desc \
+		-text "[mc "git-gui - a graphical user interface for Git."]\n$copyright"
 	pack $w.desc -side top -fill x -padx 5 -pady 5
 
 	set v {}
@@ -52,22 +63,10 @@ proc do_about {} {
 	append d "git exec dir: [gitexec]\n"
 	append d "git-gui lib: $oguilib"
 
-	label $w.vers \
-		-text $v \
-		-padx 5 -pady 5 \
-		-justify left \
-		-anchor w \
-		-borderwidth 1 \
-		-relief solid
+	pad_label $w.vers -text $v
 	pack $w.vers -side top -fill x -padx 5 -pady 5
 
-	label $w.dirs \
-		-text $d \
-		-padx 5 -pady 5 \
-		-justify left \
-		-anchor w \
-		-borderwidth 1 \
-		-relief solid
+	pad_label $w.dirs -text $d
 	pack $w.dirs -side top -fill x -padx 5 -pady 5
 
 	menu $w.ctxm -tearoff 0
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 8525b79..786b50b 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -61,7 +61,7 @@ field tooltip_timer     {} ; # Current timer event for our tooltip
 field tooltip_commit    {} ; # Commit(s) in tooltip
 
 constructor new {i_commit i_path i_jump} {
-	global cursor_ptr M1B M1T have_tk85
+	global cursor_ptr M1B M1T have_tk85 use_ttk NS
 	variable active_color
 	variable group_colors
 
@@ -73,15 +73,15 @@ constructor new {i_commit i_path i_jump} {
 
 	set font_w [font measure font_diff "0"]
 
-	frame $w.header -background gold
-	label $w.header.commit_l \
+	gold_frame $w.header
+	tlabel $w.header.commit_l \
 		-text [mc "Commit:"] \
 		-background gold \
 		-foreground black \
 		-anchor w \
 		-justify left
 	set w_back $w.header.commit_b
-	label $w_back \
+	tlabel $w_back \
 		-image ::blame::img_back_arrow \
 		-borderwidth 0 \
 		-relief flat \
@@ -94,20 +94,20 @@ constructor new {i_commit i_path i_jump} {
 			[cb _history_menu]
 		}
 		"
-	label $w.header.commit \
+	tlabel $w.header.commit \
 		-textvariable @commit \
 		-background gold \
 		-foreground black \
 		-anchor w \
 		-justify left
-	label $w.header.path_l \
+	tlabel $w.header.path_l \
 		-text [mc "File:"] \
 		-background gold \
 		-foreground black \
 		-anchor w \
 		-justify left
 	set w_path $w.header.path
-	label $w_path \
+	tlabel $w_path \
 		-background gold \
 		-foreground black \
 		-anchor w \
@@ -209,10 +209,10 @@ constructor new {i_commit i_path i_jump} {
 
 	set w_columns [list $w_amov $w_asim $w_line $w_file]
 
-	scrollbar $w.file_pane.out.sbx \
+	${NS}::scrollbar $w.file_pane.out.sbx \
 		-orient h \
 		-command [list $w_file xview]
-	scrollbar $w.file_pane.out.sby \
+	${NS}::scrollbar $w.file_pane.out.sby \
 		-orient v \
 		-command [list scrollbar2many $w_columns yview]
 	eval grid $w_columns $w.file_pane.out.sby -sticky nsew
@@ -254,10 +254,10 @@ constructor new {i_commit i_path i_jump} {
 		-background $active_color \
 		-font font_ui
 	$w_cviewer tag raise sel
-	scrollbar $w.file_pane.cm.sbx \
+	${NS}::scrollbar $w.file_pane.cm.sbx \
 		-orient h \
 		-command [list $w_cviewer xview]
-	scrollbar $w.file_pane.cm.sby \
+	${NS}::scrollbar $w.file_pane.cm.sby \
 		-orient v \
 		-command [list $w_cviewer yview]
 	pack $w.file_pane.cm.sby -side right -fill y
diff --git a/lib/branch_checkout.tcl b/lib/branch_checkout.tcl
index 6603703..2e459a8 100644
--- a/lib/branch_checkout.tcl
+++ b/lib/branch_checkout.tcl
@@ -10,21 +10,24 @@ field opt_fetch     1; # refetch tracking branch if used?
 field opt_detach    0; # force a detached head case?
 
 constructor dialog {} {
-	make_toplevel top w
+	global use_ttk NS
+	make_dialog top w
+	wm withdraw $w
 	wm title $top [append "[appname] ([reponame]): " [mc "Checkout Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text [mc "Checkout Branch"] -font font_uibold
+	${NS}::label $w.header -text [mc "Checkout Branch"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.create -text [mc Checkout] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.create -text [mc Checkout] \
 		-default active \
 		-command [cb _checkout]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text [mc Cancel] \
+	${NS}::button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -33,14 +36,14 @@ constructor dialog {} {
 	$w_rev bind_listbox <Double-Button-1> [cb _checkout]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.options -text [mc Options]
+	${NS}::labelframe $w.options -text [mc Options]
 
-	checkbutton $w.options.fetch \
+	${NS}::checkbutton $w.options.fetch \
 		-text [mc "Fetch Tracking Branch"] \
 		-variable @opt_fetch
 	pack $w.options.fetch -anchor nw
 
-	checkbutton $w.options.detach \
+	${NS}::checkbutton $w.options.detach \
 		-text [mc "Detach From Local Branch"] \
 		-variable @opt_detach
 	pack $w.options.detach -anchor nw
@@ -50,6 +53,7 @@ constructor dialog {} {
 	bind $w <Visibility> [cb _visible]
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [cb _checkout]\;break
+	wm deiconify $w
 	tkwait window $w
 }
 
diff --git a/lib/branch_create.tcl b/lib/branch_create.tcl
index 3817771..a8d8d38 100644
--- a/lib/branch_create.tcl
+++ b/lib/branch_create.tcl
@@ -16,48 +16,48 @@ field opt_fetch     1; # refetch tracking branch if used?
 field reset_ok      0; # did the user agree to reset?
 
 constructor dialog {} {
-	global repo_config
+	global repo_config use_ttk NS
 
-	make_toplevel top w
+	make_dialog top w
+	wm withdraw $w
 	wm title $top [append "[appname] ([reponame]): " [mc "Create Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text [mc "Create New Branch"] -font font_uibold
+	${NS}::label $w.header -text [mc "Create New Branch"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.create -text [mc Create] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.create -text [mc Create] \
 		-default active \
 		-command [cb _create]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text [mc Cancel] \
+	${NS}::button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.desc -text [mc "Branch Name"]
-	radiobutton $w.desc.name_r \
-		-anchor w \
+	${NS}::labelframe $w.desc -text [mc "Branch Name"]
+	${NS}::radiobutton $w.desc.name_r \
 		-text [mc "Name:"] \
 		-value user \
 		-variable @name_type
+	if {!$use_ttk} {$w.desc.name_r configure -anchor w}
 	set w_name $w.desc.name_t
-	entry $w_name \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w_name \
 		-width 40 \
 		-textvariable @name \
 		-validate key \
 		-validatecommand [cb _validate %d %S]
 	grid $w.desc.name_r $w_name -sticky we -padx {0 5}
 
-	radiobutton $w.desc.match_r \
-		-anchor w \
+	${NS}::radiobutton $w.desc.match_r \
 		-text [mc "Match Tracking Branch Name"] \
 		-value match \
 		-variable @name_type
+	if {!$use_ttk} {$w.desc.name_r configure -anchor w}
 	grid $w.desc.match_r -sticky we -padx {0 5} -columnspan 2
 
 	grid columnconfigure $w.desc 1 -weight 1
@@ -66,34 +66,34 @@ constructor dialog {} {
 	set w_rev [::choose_rev::new $w.rev [mc "Starting Revision"]]
 	pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.options -text [mc Options]
+	${NS}::labelframe $w.options -text [mc Options]
 
-	frame $w.options.merge
-	label $w.options.merge.l -text [mc "Update Existing Branch:"]
+	${NS}::frame $w.options.merge
+	${NS}::label $w.options.merge.l -text [mc "Update Existing Branch:"]
 	pack $w.options.merge.l -side left
-	radiobutton $w.options.merge.no \
+	${NS}::radiobutton $w.options.merge.no \
 		-text [mc No] \
 		-value none \
 		-variable @opt_merge
 	pack $w.options.merge.no -side left
-	radiobutton $w.options.merge.ff \
+	${NS}::radiobutton $w.options.merge.ff \
 		-text [mc "Fast Forward Only"] \
 		-value ff \
 		-variable @opt_merge
 	pack $w.options.merge.ff -side left
-	radiobutton $w.options.merge.reset \
+	${NS}::radiobutton $w.options.merge.reset \
 		-text [mc Reset] \
 		-value reset \
 		-variable @opt_merge
 	pack $w.options.merge.reset -side left
 	pack $w.options.merge -anchor nw
 
-	checkbutton $w.options.fetch \
+	${NS}::checkbutton $w.options.fetch \
 		-text [mc "Fetch Tracking Branch"] \
 		-variable @opt_fetch
 	pack $w.options.fetch -anchor nw
 
-	checkbutton $w.options.checkout \
+	${NS}::checkbutton $w.options.checkout \
 		-text [mc "Checkout After Creation"] \
 		-variable @opt_checkout
 	pack $w.options.checkout -anchor nw
@@ -109,6 +109,7 @@ constructor dialog {} {
 	bind $w <Visibility> [cb _visible]
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [cb _create]\;break
+	wm deiconify $w
 	tkwait window $w
 }
 
diff --git a/lib/branch_delete.tcl b/lib/branch_delete.tcl
index 20d5e42..867938e 100644
--- a/lib/branch_delete.tcl
+++ b/lib/branch_delete.tcl
@@ -9,41 +9,40 @@ field w_check         ; # revision picker for merge test
 field w_delete        ; # delete button
 
 constructor dialog {} {
-	global current_branch
+	global current_branch use_ttk NS
 
-	make_toplevel top w
+	make_dialog top w
+	wm withdraw $w
 	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text [mc "Delete Local Branch"] -font font_uibold
+	${NS}::label $w.header -text [mc "Delete Local Branch"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
+	${NS}::frame $w.buttons
 	set w_delete $w.buttons.delete
-	button $w_delete \
+	${NS}::button $w_delete \
 		-text [mc Delete] \
 		-default active \
 		-state disabled \
 		-command [cb _delete]
 	pack $w_delete -side right
-	button $w.buttons.cancel \
+	${NS}::button $w.buttons.cancel \
 		-text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.list -text [mc "Local Branches"]
+	${NS}::labelframe $w.list -text [mc "Local Branches"]
 	set w_heads $w.list.l
-	listbox $w_heads \
+	slistbox $w_heads \
 		-height 10 \
 		-width 70 \
 		-selectmode extended \
-		-exportselection false \
-		-yscrollcommand [list $w.list.sby set]
-	scrollbar $w.list.sby -command [list $w.list.l yview]
-	pack $w.list.sby -side right -fill y
+		-exportselection false
 	pack $w.list.l -side left -fill both -expand 1
 	pack $w.list -fill both -expand 1 -pady 5 -padx 5
 
@@ -67,6 +66,7 @@ constructor dialog {} {
 	"
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [cb _delete]\;break
+	wm deiconify $w
 	tkwait window $w
 }
 
diff --git a/lib/branch_rename.tcl b/lib/branch_rename.tcl
index 1665388..6398877 100644
--- a/lib/branch_rename.tcl
+++ b/lib/branch_rename.tcl
@@ -8,9 +8,10 @@ field oldname
 field newname
 
 constructor dialog {} {
-	global current_branch
+	global current_branch use_ttk NS
 
-	make_toplevel top w
+	make_dialog top w
+	wm withdraw $w
 	wm title $top [append "[appname] ([reponame]): " [mc "Rename Branch"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
@@ -19,27 +20,31 @@ constructor dialog {} {
 	set oldname $current_branch
 	set newname [get_config gui.newbranchtemplate]
 
-	label $w.header -text [mc "Rename Branch"] -font font_uibold
+	${NS}::label $w.header -text [mc "Rename Branch"]\
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.rename -text [mc Rename] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.rename -text [mc Rename] \
 		-default active \
 		-command [cb _rename]
 	pack $w.buttons.rename -side right
-	button $w.buttons.cancel -text [mc Cancel] \
+	${NS}::button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	frame $w.rename
-	label $w.rename.oldname_l -text [mc "Branch:"]
-	eval tk_optionMenu $w.rename.oldname_m @oldname [load_all_heads]
+	${NS}::frame $w.rename
+	${NS}::label $w.rename.oldname_l -text [mc "Branch:"]
+	if {$use_ttk} {
+		ttk::combobox $w.rename.oldname_m -textvariable @oldname \
+			-values [load_all_heads] -state readonly
+	} else {
+		eval tk_optionMenu $w.rename.oldname_m @oldname [load_all_heads]
+	}
 
-	label $w.rename.newname_l -text [mc "New Name:"]
-	entry $w.rename.newname_t \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::label $w.rename.newname_l -text [mc "New Name:"]
+	${NS}::entry $w.rename.newname_t \
 		-width 40 \
 		-textvariable @newname \
 		-validate key \
@@ -60,6 +65,7 @@ constructor dialog {} {
 		$w.rename.newname_t icursor end
 		focus $w.rename.newname_t
 	"
+	wm deiconify $w
 	tkwait window $w
 }
 
diff --git a/lib/browser.tcl b/lib/browser.tcl
index 0410cc6..c241572 100644
--- a/lib/browser.tcl
+++ b/lib/browser.tcl
@@ -21,23 +21,23 @@ field browser_busy   1
 field ls_buf     {}; # Buffered record output from ls-tree
 
 constructor new {commit {path {}}} {
-	global cursor_ptr M1B
-	make_toplevel top w
+	global cursor_ptr M1B use_ttk NS
+	make_dialog top w
+	wm withdraw $top
 	wm title $top [append "[appname] ([reponame]): " [mc "File Browser"]]
 
 	set browser_commit $commit
 	set browser_path $browser_commit:$path
 
-	label $w.path \
+	${NS}::label $w.path \
 		-textvariable @browser_path \
 		-anchor w \
 		-justify left \
-		-borderwidth 1 \
-		-relief sunken \
 		-font font_uibold
+	if {!$use_ttk} { $w.path configure -borderwidth 1 -relief sunken}
 	pack $w.path -anchor w -side top -fill x
 
-	frame $w.list
+	${NS}::frame $w.list
 	set w_list $w.list.l
 	text $w_list -background white -foreground black \
 		-borderwidth 0 \
@@ -49,19 +49,18 @@ constructor new {commit {path {}}} {
 		-xscrollcommand [list $w.list.sbx set] \
 		-yscrollcommand [list $w.list.sby set]
 	rmsel_tag $w_list
-	scrollbar $w.list.sbx -orient h -command [list $w_list xview]
-	scrollbar $w.list.sby -orient v -command [list $w_list yview]
+	${NS}::scrollbar $w.list.sbx -orient h -command [list $w_list xview]
+	${NS}::scrollbar $w.list.sby -orient v -command [list $w_list yview]
 	pack $w.list.sbx -side bottom -fill x
 	pack $w.list.sby -side right -fill y
 	pack $w_list -side left -fill both -expand 1
 	pack $w.list -side top -fill both -expand 1
 
-	label $w.status \
+	${NS}::label $w.status \
 		-textvariable @browser_status \
 		-anchor w \
-		-justify left \
-		-borderwidth 1 \
-		-relief sunken
+		-justify left
+	if {!$use_ttk} { $w.status configure -borderwidth 1 -relief sunken}
 	pack $w.status -anchor w -side bottom -fill x
 
 	bind $w_list <Button-1>        "[cb _click 0 @%x,%y];break"
@@ -78,6 +77,7 @@ constructor new {commit {path {}}} {
 	bind $w_list <Right>           break
 
 	bind $w_list <Visibility> [list focus $w_list]
+	wm deiconify $top
 	set w $w_list
 	if {$path ne {}} {
 		_ls $this $browser_commit:$path $path
@@ -263,23 +263,27 @@ field w              ; # widget path
 field w_rev          ; # mega-widget to pick the initial revision
 
 constructor dialog {} {
-	make_toplevel top w
+	global use_ttk NS
+	make_dialog top w
+	wm withdraw $top
 	wm title $top [append "[appname] ([reponame]): " [mc "Browse Branch Files"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
+		wm transient $top .
 	}
 
-	label $w.header \
+	${NS}::label $w.header \
 		-text [mc "Browse Branch Files"] \
-		-font font_uibold
+		-font font_uibold \
+		-anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.browse -text [mc Browse] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.browse -text [mc Browse] \
 		-default active \
 		-command [cb _open]
 	pack $w.buttons.browse -side right
-	button $w.buttons.cancel -text [mc Cancel] \
+	${NS}::button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
@@ -291,6 +295,7 @@ constructor dialog {} {
 	bind $w <Visibility> [cb _visible]
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [cb _open]\;break
+	wm deiconify $top
 	tkwait window $w
 }
 
diff --git a/lib/choose_font.tcl b/lib/choose_font.tcl
index 56443b0..ebe50bd 100644
--- a/lib/choose_font.tcl
+++ b/lib/choose_font.tcl
@@ -17,6 +17,7 @@ variable all_families [list]  ; # All fonts known to Tk
 
 constructor pick {path title a_family a_size} {
 	variable all_families
+	global use_ttk NS
 
 	set v_family $a_family
 	set v_size $a_size
@@ -27,29 +28,30 @@ constructor pick {path title a_family a_size} {
 	set f_family $pv_family
 	set f_size $pv_size
 
-	make_toplevel top w
+	make_dialog top w
+	wm withdraw $top
 	wm title $top "[appname] ([reponame]): $title"
 	wm geometry $top "+[winfo rootx $path]+[winfo rooty $path]"
 
-	label $w.header -text $title -font font_uibold
+	${NS}::label $w.header -text $title -font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.select \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.select \
 		-text [mc Select] \
 		-default active \
 		-command [cb _select]
-	button $w.buttons.cancel \
+	${NS}::button $w.buttons.cancel \
 		-text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.select -side right
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	frame $w.inner
+	${NS}::frame $w.inner
 
-	frame $w.inner.family
-	label $w.inner.family.l \
+	${NS}::frame $w.inner.family
+	${NS}::label $w.inner.family.l \
 		-text [mc "Font Family"] \
 		-anchor w
 	set w_family $w.inner.family.v
@@ -64,16 +66,16 @@ constructor pick {path title a_family a_size} {
 		-height 10 \
 		-yscrollcommand [list $w.inner.family.sby set]
 	rmsel_tag $w_family
-	scrollbar $w.inner.family.sby -command [list $w_family yview]
+	${NS}::scrollbar $w.inner.family.sby -command [list $w_family yview]
 	pack $w.inner.family.l -side top -fill x
 	pack $w.inner.family.sby -side right -fill y
 	pack $w_family -fill both -expand 1
 
-	frame $w.inner.size
-	label $w.inner.size.l \
+	${NS}::frame $w.inner.size
+	${NS}::label $w.inner.size.l \
 		-text [mc "Font Size"] \
 		-anchor w
-	spinbox $w.inner.size.v \
+	tspinbox $w.inner.size.v \
 		-textvariable @f_size \
 		-from 2 -to 80 -increment 1 \
 		-width 3
@@ -86,8 +88,8 @@ constructor pick {path title a_family a_size} {
 	grid columnconfigure $w.inner 0 -weight 1
 	pack $w.inner -fill both -expand 1 -padx 5 -pady 5
 
-	frame $w.example
-	label $w.example.l \
+	${NS}::frame $w.example
+	${NS}::label $w.example.l \
 		-text [mc "Font Example"] \
 		-anchor w
 	set w_example $w.example.t
@@ -129,6 +131,7 @@ constructor pick {path title a_family a_size} {
 		grab $w
 		focus $w
 	"
+	wm deiconify $w
 	tkwait window $w
 }
 
diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 633cc57..4081876 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -22,9 +22,9 @@ field readtree_err        ; # Error output from read-tree (if any)
 field sorted_recent       ; # recent repositories (sorted)
 
 constructor pick {} {
-	global M1T M1B
+	global M1T M1B use_ttk NS
 
-	make_toplevel top w
+	make_dialog top w
 	wm title $top [mc "Git Gui"]
 
 	if {$top eq {.}} {
@@ -71,11 +71,11 @@ constructor pick {} {
 
 	set w_body $w.body
 	set opts $w_body.options
-	frame $w_body
+	${NS}::frame $w_body
 	text $opts \
 		-cursor $::cursor_ptr \
 		-relief flat \
-		-background [$w_body cget -background] \
+		-background [get_bg_color $w_body] \
 		-wrap none \
 		-spacing1 5 \
 		-width 50 \
@@ -132,15 +132,15 @@ constructor pick {} {
 				-label [mc "Recent Repositories"]
 		}
 
-		label $w_body.space
-		label $w_body.recentlabel \
+		${NS}::label $w_body.space
+		${NS}::label $w_body.recentlabel \
 			-anchor w \
 			-text [mc "Open Recent Repository:"]
 		set w_recentlist $w_body.recentlist
 		text $w_recentlist \
 			-cursor $::cursor_ptr \
 			-relief flat \
-			-background [$w_body.recentlabel cget -background] \
+			-background [get_bg_color $w_body.recentlabel] \
 			-wrap none \
 			-width 50 \
 			-height 10
@@ -176,10 +176,10 @@ constructor pick {} {
 	}
 	pack $w_body -fill x -padx 10 -pady 10
 
-	frame $w.buttons
+	${NS}::frame $w.buttons
 	set w_next $w.buttons.next
 	set w_quit $w.buttons.quit
-	button $w_quit \
+	${NS}::button $w_quit \
 		-text [mc "Quit"] \
 		-command exit
 	pack $w_quit -side right -padx 5
@@ -203,6 +203,7 @@ constructor pick {} {
 	wm deiconify $top
 	tkwait variable @done
 
+	grab release $top
 	if {$top eq {.}} {
 		eval destroy [winfo children $top]
 	}
@@ -280,9 +281,10 @@ method _open_recent_path {p} {
 }
 
 method _next {action} {
+	global NS
 	destroy $w_body
 	if {![winfo exists $w_next]} {
-		button $w_next -default active
+		${NS}::button $w_next -default active
 		pack $w_next -side right -padx 5 -before $w_quit
 	}
 	_do_$action $this
@@ -371,26 +373,25 @@ proc _objdir {path} {
 ## Create New Repository
 
 method _do_new {} {
+	global use_ttk NS
 	$w_next conf \
 		-state disabled \
 		-command [cb _do_new2] \
 		-text [mc "Create"]
 
-	frame $w_body
-	label $w_body.h \
-		-font font_uibold \
+	${NS}::frame $w_body
+	${NS}::label $w_body.h \
+		-font font_uibold -anchor center \
 		-text [mc "Create New Repository"]
 	pack $w_body.h -side top -fill x -pady 10
 	pack $w_body -fill x -padx 10
 
-	frame $w_body.where
-	label $w_body.where.l -text [mc "Directory:"]
-	entry $w_body.where.t \
+	${NS}::frame $w_body.where
+	${NS}::label $w_body.where.l -text [mc "Directory:"]
+	${NS}::entry $w_body.where.t \
 		-textvariable @local_path \
-		-borderwidth 1 \
-		-relief sunken \
 		-width 50
-	button $w_body.where.b \
+	${NS}::button $w_body.where.b \
 		-text [mc "Browse"] \
 		-command [cb _new_local_path]
 	set w_localpath $w_body.where.t
@@ -456,63 +457,57 @@ proc _new_ok {p} {
 ## Clone Existing Repository
 
 method _do_clone {} {
+	global use_ttk NS
 	$w_next conf \
 		-state disabled \
 		-command [cb _do_clone2] \
 		-text [mc "Clone"]
 
-	frame $w_body
-	label $w_body.h \
-		-font font_uibold \
+	${NS}::frame $w_body
+	${NS}::label $w_body.h \
+		-font font_uibold -anchor center \
 		-text [mc "Clone Existing Repository"]
 	pack $w_body.h -side top -fill x -pady 10
 	pack $w_body -fill x -padx 10
 
 	set args $w_body.args
-	frame $w_body.args
+	${NS}::frame $w_body.args
 	pack $args -fill both
 
-	label $args.origin_l -text [mc "Source Location:"]
-	entry $args.origin_t \
+	${NS}::label $args.origin_l -text [mc "Source Location:"]
+	${NS}::entry $args.origin_t \
 		-textvariable @origin_url \
-		-borderwidth 1 \
-		-relief sunken \
 		-width 50
-	button $args.origin_b \
+	${NS}::button $args.origin_b \
 		-text [mc "Browse"] \
 		-command [cb _open_origin]
 	grid $args.origin_l $args.origin_t $args.origin_b -sticky ew
 
-	label $args.where_l -text [mc "Target Directory:"]
-	entry $args.where_t \
+	${NS}::label $args.where_l -text [mc "Target Directory:"]
+	${NS}::entry $args.where_t \
 		-textvariable @local_path \
-		-borderwidth 1 \
-		-relief sunken \
 		-width 50
-	button $args.where_b \
+	${NS}::button $args.where_b \
 		-text [mc "Browse"] \
 		-command [cb _new_local_path]
 	grid $args.where_l $args.where_t $args.where_b -sticky ew
 	set w_localpath $args.where_t
 
-	label $args.type_l -text [mc "Clone Type:"]
-	frame $args.type_f
+	${NS}::label $args.type_l -text [mc "Clone Type:"]
+	${NS}::frame $args.type_f
 	set w_types [list]
-	lappend w_types [radiobutton $args.type_f.hardlink \
+	lappend w_types [${NS}::radiobutton $args.type_f.hardlink \
 		-state disabled \
-		-anchor w \
 		-text [mc "Standard (Fast, Semi-Redundant, Hardlinks)"] \
 		-variable @clone_type \
 		-value hardlink]
-	lappend w_types [radiobutton $args.type_f.full \
+	lappend w_types [${NS}::radiobutton $args.type_f.full \
 		-state disabled \
-		-anchor w \
 		-text [mc "Full Copy (Slower, Redundant Backup)"] \
 		-variable @clone_type \
 		-value full]
-	lappend w_types [radiobutton $args.type_f.shared \
+	lappend w_types [${NS}::radiobutton $args.type_f.shared \
 		-state disabled \
-		-anchor w \
 		-text [mc "Shared (Fastest, Not Recommended, No Backup)"] \
 		-variable @clone_type \
 		-value shared]
@@ -1001,26 +996,25 @@ method _postcheckout_wait {fd_ph} {
 ## Open Existing Repository
 
 method _do_open {} {
+	global NS
 	$w_next conf \
 		-state disabled \
 		-command [cb _do_open2] \
 		-text [mc "Open"]
 
-	frame $w_body
-	label $w_body.h \
-		-font font_uibold \
+	${NS}::frame $w_body
+	${NS}::label $w_body.h \
+		-font font_uibold -anchor center \
 		-text [mc "Open Existing Repository"]
 	pack $w_body.h -side top -fill x -pady 10
 	pack $w_body -fill x -padx 10
 
-	frame $w_body.where
-	label $w_body.where.l -text [mc "Repository:"]
-	entry $w_body.where.t \
+	${NS}::frame $w_body.where
+	${NS}::label $w_body.where.l -text [mc "Repository:"]
+	${NS}::entry $w_body.where.t \
 		-textvariable @local_path \
-		-borderwidth 1 \
-		-relief sunken \
 		-width 50
-	button $w_body.where.b \
+	${NS}::button $w_body.where.b \
 		-text [mc "Browse"] \
 		-command [cb _open_local_path]
 
diff --git a/lib/choose_rev.tcl b/lib/choose_rev.tcl
index c8821c1..b78d216 100644
--- a/lib/choose_rev.tcl
+++ b/lib/choose_rev.tcl
@@ -10,7 +10,7 @@ field w_list          ; # list of currently filtered specs
 field w_filter        ; # filter entry for $w_list
 
 field c_expr        {}; # current revision expression
-field filter          ; # current filter string
+field filter        ""; # current filter string
 field revtype     head; # type of revision chosen
 field cur_specs [list]; # list of specs for $revtype
 field spec_head       ; # list of all head specs
@@ -32,7 +32,7 @@ proc new_unmerged {path {title {}}} {
 }
 
 constructor _new {path unmerged_only title} {
-	global current_branch is_detached
+	global current_branch is_detached use_ttk NS
 
 	if {![info exists ::all_remotes]} {
 		load_all_remotes
@@ -41,65 +41,65 @@ constructor _new {path unmerged_only title} {
 	set w $path
 
 	if {$title ne {}} {
-		labelframe $w -text $title
+		${NS}::labelframe $w -text $title
 	} else {
-		frame $w
+		${NS}::frame $w
 	}
 	bind $w <Destroy> [cb _delete %W]
 
 	if {$is_detached} {
-		radiobutton $w.detachedhead_r \
-			-anchor w \
+		${NS}::radiobutton $w.detachedhead_r \
 			-text [mc "This Detached Checkout"] \
 			-value HEAD \
 			-variable @revtype
+		if {!$use_ttk} {$w.detachedhead configure -anchor w}
 		grid $w.detachedhead_r -sticky we -padx {0 5} -columnspan 2
 	}
 
-	radiobutton $w.expr_r \
+	${NS}::radiobutton $w.expr_r \
 		-text [mc "Revision Expression:"] \
 		-value expr \
 		-variable @revtype
-	entry $w.expr_t \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w.expr_t \
 		-width 50 \
 		-textvariable @c_expr \
 		-validate key \
 		-validatecommand [cb _validate %d %S]
 	grid $w.expr_r $w.expr_t -sticky we -padx {0 5}
 
-	frame $w.types
-	radiobutton $w.types.head_r \
+	${NS}::frame $w.types
+	${NS}::radiobutton $w.types.head_r \
 		-text [mc "Local Branch"] \
 		-value head \
 		-variable @revtype
 	pack $w.types.head_r -side left
-	radiobutton $w.types.trck_r \
+	${NS}::radiobutton $w.types.trck_r \
 		-text [mc "Tracking Branch"] \
 		-value trck \
 		-variable @revtype
 	pack $w.types.trck_r -side left
-	radiobutton $w.types.tag_r \
+	${NS}::radiobutton $w.types.tag_r \
 		-text [mc "Tag"] \
 		-value tag \
 		-variable @revtype
 	pack $w.types.tag_r -side left
 	set w_filter $w.types.filter
-	entry $w_filter \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w_filter \
 		-width 12 \
 		-textvariable @filter \
 		-validate key \
 		-validatecommand [cb _filter %P]
 	pack $w_filter -side right
-	pack [label $w.types.filter_icon \
+	pack [${NS}::label $w.types.filter_icon \
 		-image ::choose_rev::img_find \
 		] -side right
 	grid $w.types -sticky we -padx {0 5} -columnspan 2
 
-	frame $w.list
+	if {$use_ttk} {
+		ttk::frame $w.list -style SListbox.TFrame -padding 2
+	} else {
+		frame $w.list
+	}
 	set w_list $w.list.l
 	listbox $w_list \
 		-font font_diff \
@@ -109,6 +109,9 @@ constructor _new {path unmerged_only title} {
 		-exportselection false \
 		-xscrollcommand [cb _sb_set $w.list.sbx h] \
 		-yscrollcommand [cb _sb_set $w.list.sby v]
+	if {$use_ttk} {
+		$w_list configure -relief flat -highlightthickness 0 -borderwidth 0
+	}
 	pack $w_list -fill both -expand 1
 	grid $w.list -sticky nswe -padx {20 5} -columnspan 2
 	bind $w_list <Any-Motion>  [cb _show_tooltip @%x,%y]
@@ -235,11 +238,12 @@ constructor _new {path unmerged_only title} {
 }
 
 method none {text} {
+	global NS use_ttk
 	if {![winfo exists $w.none_r]} {
-		radiobutton $w.none_r \
-			-anchor w \
+		${NS}::radiobutton $w.none_r \
 			-value none \
 			-variable @revtype
+		if {!$use_ttk} {$w.none_r configure -anchor w}
 		grid $w.none_r -sticky we -padx {0 5} -columnspan 2
 	}
 	$w.none_r configure -text $text
@@ -425,6 +429,7 @@ method _delete {current} {
 }
 
 method _sb_set {sb orient first last} {
+	global NS
 	set old_focus [focus -lastfor $w]
 
 	if {$first == 0 && $last == 1} {
@@ -440,10 +445,10 @@ method _sb_set {sb orient first last} {
 
 	if {![winfo exists $sb]} {
 		if {$orient eq {h}} {
-			scrollbar $sb -orient h -command [list $w_list xview]
+			${NS}::scrollbar $sb -orient h -command [list $w_list xview]
 			pack $sb -fill x -side bottom -before $w_list
 		} else {
-			scrollbar $sb -orient v -command [list $w_list yview]
+			${NS}::scrollbar $sb -orient v -command [list $w_list yview]
 			pack $sb -fill y -side right -before $w_list
 		}
 		if {$old_focus ne {}} {
diff --git a/lib/class.tcl b/lib/class.tcl
index dc21411..c27b714 100644
--- a/lib/class.tcl
+++ b/lib/class.tcl
@@ -134,6 +134,13 @@ proc delete_this {{t {}}} {
 	if {[namespace exists $t]} {namespace delete $t}
 }
 
+proc make_dialog {t w args} {
+	upvar $t top $w pfx this this
+	global use_ttk
+	uplevel [linsert $args 0 make_toplevel $t $w]
+	pave_toplevel $pfx
+}
+
 proc make_toplevel {t w args} {
 	upvar $t top $w pfx this this
 
diff --git a/lib/console.tcl b/lib/console.tcl
index c112464..1f3248f 100644
--- a/lib/console.tcl
+++ b/lib/console.tcl
@@ -27,20 +27,20 @@ constructor embed {path title} {
 }
 
 method _init {} {
-	global M1B
+	global M1B use_ttk NS
 
 	if {$is_toplevel} {
-		make_toplevel top w -autodelete 0
+		make_dialog top w -autodelete 0
 		wm title $top "[appname] ([reponame]): $t_short"
 	} else {
-		frame $w
+		${NS}::frame $w
 	}
 
 	set console_cr 1.0
 	set w_t $w.m.t
 
-	frame $w.m
-	label $w.m.l1 \
+	${NS}::frame $w.m
+	${NS}::label $w.m.l1 \
 		-textvariable @t_long  \
 		-anchor w \
 		-justify left \
@@ -78,7 +78,7 @@ method _init {} {
 		"
 
 	if {$is_toplevel} {
-		button $w.ok -text [mc "Close"] \
+		${NS}::button $w.ok -text [mc "Close"] \
 			-state disabled \
 			-command [list destroy $w]
 		pack $w.ok -side bottom -anchor e -pady 10 -padx 10
@@ -206,13 +206,14 @@ method done {ok} {
 }
 
 method _sb_set {sb orient first last} {
+	global NS
 	if {![winfo exists $sb]} {
 		if {$first == $last || ($first == 0 && $last == 1)} return
 		if {$orient eq {h}} {
-			scrollbar $sb -orient h -command [list $w_t xview]
+			${NS}::scrollbar $sb -orient h -command [list $w_t xview]
 			pack $sb -fill x -side bottom -before $w_t
 		} else {
-			scrollbar $sb -orient v -command [list $w_t yview]
+			${NS}::scrollbar $sb -orient v -command [list $w_t yview]
 			pack $sb -fill y -side right -before $w_t
 		}
 	}
diff --git a/lib/database.tcl b/lib/database.tcl
index d4e0bed..1f187ed 100644
--- a/lib/database.tcl
+++ b/lib/database.tcl
@@ -2,6 +2,7 @@
 # Copyright (C) 2006, 2007 Shawn Pearce
 
 proc do_stats {} {
+	global use_ttk NS
 	set fd [git_read count-objects -v]
 	while {[gets $fd line] > 0} {
 		if {[regexp {^([^:]+): (\d+)$} $line _ name value]} {
@@ -21,24 +22,22 @@ proc do_stats {} {
 	}
 
 	set w .stats_view
-	toplevel $w
+	Dialog $w
+	wm withdraw $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	label $w.header -text [mc "Database Statistics"]
-	pack $w.header -side top -fill x
-
-	frame $w.buttons -border 1
-	button $w.buttons.close -text [mc Close] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.close -text [mc Close] \
 		-default active \
 		-command [list destroy $w]
-	button $w.buttons.gc -text [mc "Compress Database"] \
+	${NS}::button $w.buttons.gc -text [mc "Compress Database"] \
 		-default normal \
 		-command "destroy $w;do_gc"
 	pack $w.buttons.close -side right
 	pack $w.buttons.gc -side left
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	frame $w.stat -borderwidth 1 -relief solid
+	${NS}::labelframe $w.stat -text [mc "Database Statistics"]
 	foreach s {
 		{count           {mc "Number of loose objects"}}
 		{size            {mc "Disk space used by loose objects"} { KiB}}
@@ -55,8 +54,8 @@ proc do_stats {} {
 			set value "$value[lindex $s 2]"
 		}
 
-		label $w.stat.l_$name -text "$label:" -anchor w
-		label $w.stat.v_$name -text $value -anchor w
+		${NS}::label $w.stat.l_$name -text "$label:" -anchor w
+		${NS}::label $w.stat.v_$name -text $value -anchor w
 		grid $w.stat.l_$name $w.stat.v_$name -sticky we -padx {0 5}
 	}
 	pack $w.stat -pady 10 -padx 10
@@ -65,6 +64,7 @@ proc do_stats {} {
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [list destroy $w]
 	wm title $w [append "[appname] ([reponame]): " [mc "Database Statistics"]]
+	wm deiconify $w
 	tkwait window $w
 }
 
diff --git a/lib/error.tcl b/lib/error.tcl
index 7565015..c0fa69a 100644
--- a/lib/error.tcl
+++ b/lib/error.tcl
@@ -71,11 +71,13 @@ proc ask_popup {msg} {
 }
 
 proc hook_failed_popup {hook msg {is_fatal 1}} {
+	global use_ttk NS
 	set w .hookfail
-	toplevel $w
+	Dialog $w
+	wm withdraw $w
 
-	frame $w.m
-	label $w.m.l1 -text "$hook hook failed:" \
+	${NS}::frame $w.m
+	${NS}::label $w.m.l1 -text "$hook hook failed:" \
 		-anchor w \
 		-justify left \
 		-font font_uibold
@@ -87,10 +89,10 @@ proc hook_failed_popup {hook msg {is_fatal 1}} {
 		-width 80 -height 10 \
 		-font font_diff \
 		-yscrollcommand [list $w.m.sby set]
-	scrollbar $w.m.sby -command [list $w.m.t yview]
+	${NS}::scrollbar $w.m.sby -command [list $w.m.t yview]
 	pack $w.m.l1 -side top -fill x
 	if {$is_fatal} {
-		label $w.m.l2 \
+		${NS}::label $w.m.l2 \
 			-text [mc "You must correct the above errors before committing."] \
 			-anchor w \
 			-justify left \
@@ -104,7 +106,7 @@ proc hook_failed_popup {hook msg {is_fatal 1}} {
 	$w.m.t insert 1.0 $msg
 	$w.m.t conf -state disabled
 
-	button $w.ok -text OK \
+	${NS}::button $w.ok -text OK \
 		-width 15 \
 		-command "destroy $w"
 	pack $w.ok -side bottom -anchor e -pady 10 -padx 10
@@ -112,5 +114,6 @@ proc hook_failed_popup {hook msg {is_fatal 1}} {
 	bind $w <Visibility> "grab $w; focus $w"
 	bind $w <Key-Return> "destroy $w"
 	wm title $w [strcat "[appname] ([reponame]): " [mc "error"]]
+	wm deiconify $w
 	tkwait window $w
 }
diff --git a/lib/index.tcl b/lib/index.tcl
index d33896a..3b96777 100644
--- a/lib/index.tcl
+++ b/lib/index.tcl
@@ -8,13 +8,15 @@ proc _delete_indexlock {} {
 }
 
 proc _close_updateindex {fd after} {
+	global use_ttk NS
 	fconfigure $fd -blocking 1
 	if {[catch {close $fd} err]} {
 		set w .indexfried
-		toplevel $w
+		Dialog $w
+		wm withdraw $w
 		wm title $w [strcat "[appname] ([reponame]): " [mc "Index Error"]]
 		wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
-		pack [label $w.msg \
+		pack [${NS}::label $w.msg \
 			-justify left \
 			-anchor w \
 			-text [strcat \
@@ -22,12 +24,12 @@ proc _close_updateindex {fd after} {
 				"\n\n$err"] \
 			] -anchor w
 
-		frame $w.buttons
-		button $w.buttons.continue \
+		${NS}::frame $w.buttons
+		${NS}::button $w.buttons.continue \
 			-text [mc "Continue"] \
 			-command [list destroy $w]
 		pack $w.buttons.continue -side right -padx 5
-		button $w.buttons.unlock \
+		${NS}::button $w.buttons.unlock \
 			-text [mc "Unlock Index"] \
 			-command "destroy $w; _delete_indexlock"
 		pack $w.buttons.unlock -side right
@@ -38,6 +40,7 @@ proc _close_updateindex {fd after} {
 			grab $w
 			focus $w.buttons.continue
 		"
+		wm deiconify $w
 		tkwait window $w
 
 		$::main_status stop
diff --git a/lib/merge.tcl b/lib/merge.tcl
index 283e491..5cded23 100644
--- a/lib/merge.tcl
+++ b/lib/merge.tcl
@@ -139,14 +139,14 @@ method _finish {cons ok} {
 
 constructor dialog {} {
 	global current_branch
-	global M1B
+	global M1B use_ttk NS
 
 	if {![_can_merge $this]} {
 		delete_this
 		return
 	}
 
-	make_toplevel top w
+	make_dialog top w
 	wm title $top [append "[appname] ([reponame]): " [mc "Merge"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
@@ -154,21 +154,21 @@ constructor dialog {} {
 
 	set _start [cb _start]
 
-	label $w.header \
+	${NS}::label $w.header \
 		-text [mc "Merge Into %s" $current_branch] \
 		-font font_uibold
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.visualize \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.visualize \
 		-text [mc Visualize] \
 		-command [cb _visualize]
 	pack $w.buttons.visualize -side left
-	button $w.buttons.merge \
+	${NS}::button $w.buttons.merge \
 		-text [mc Merge] \
 		-command $_start
 	pack $w.buttons.merge -side right
-	button $w.buttons.cancel \
+	${NS}::button $w.buttons.cancel \
 		-text [mc "Cancel"] \
 		-command [cb _cancel]
 	pack $w.buttons.cancel -side right -padx 5
diff --git a/lib/option.tcl b/lib/option.tcl
index 1d55b49..d4c5e45 100644
--- a/lib/option.tcl
+++ b/lib/option.tcl
@@ -91,7 +91,7 @@ proc save_config {} {
 proc do_options {} {
 	global repo_config global_config font_descs
 	global repo_config_new global_config_new
-	global ui_comm_spell
+	global ui_comm_spell use_ttk NS
 
 	array unset repo_config_new
 	array unset global_config_new
@@ -110,26 +110,28 @@ proc do_options {} {
 	}
 
 	set w .options_editor
-	toplevel $w
+	Dialog $w
+	wm withdraw $w
+	wm transient $w [winfo parent $w]
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
 
-	frame $w.buttons
-	button $w.buttons.restore -text [mc "Restore Defaults"] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.restore -text [mc "Restore Defaults"] \
 		-default normal \
 		-command do_restore_defaults
 	pack $w.buttons.restore -side left
-	button $w.buttons.save -text [mc Save] \
+	${NS}::button $w.buttons.save -text [mc Save] \
 		-default active \
 		-command [list do_save_config $w]
 	pack $w.buttons.save -side right
-	button $w.buttons.cancel -text [mc "Cancel"] \
+	${NS}::button $w.buttons.cancel -text [mc "Cancel"] \
 		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.repo -text [mc "%s Repository" [reponame]]
-	labelframe $w.global -text [mc "Global (All Repositories)"]
+	${NS}::labelframe $w.repo -text [mc "%s Repository" [reponame]]
+	${NS}::labelframe $w.global -text [mc "Global (All Repositories)"]
 	pack $w.repo -side left -fill both -expand 1 -pady 5 -padx 5
 	pack $w.global -side right -fill both -expand 1 -pady 5 -padx 5
 
@@ -161,7 +163,7 @@ proc do_options {} {
 		foreach f {repo global} {
 			switch -glob -- $type {
 			b {
-				checkbutton $w.$f.$optid -text $text \
+				${NS}::checkbutton $w.$f.$optid -text $text \
 					-variable ${f}_config_new($name) \
 					-onvalue true \
 					-offvalue false
@@ -169,10 +171,10 @@ proc do_options {} {
 			}
 			i-* {
 				regexp -- {-(\d+)\.\.(\d+)$} $type _junk min max
-				frame $w.$f.$optid
-				label $w.$f.$optid.l -text "$text:"
+				${NS}::frame $w.$f.$optid
+				${NS}::label $w.$f.$optid.l -text "$text:"
 				pack $w.$f.$optid.l -side left -anchor w -fill x
-				spinbox $w.$f.$optid.v \
+				tspinbox $w.$f.$optid.v \
 					-textvariable ${f}_config_new($name) \
 					-from $min \
 					-to $max \
@@ -184,11 +186,9 @@ proc do_options {} {
 			}
 			c -
 			t {
-				frame $w.$f.$optid
-				label $w.$f.$optid.l -text "$text:"
-				entry $w.$f.$optid.v \
-					-borderwidth 1 \
-					-relief sunken \
+				${NS}::frame $w.$f.$optid
+				${NS}::label $w.$f.$optid.l -text "$text:"
+				${NS}::entry $w.$f.$optid.v \
 					-width 20 \
 					-textvariable ${f}_config_new($name)
 				pack $w.$f.$optid.l -side left -anchor w
@@ -199,7 +199,7 @@ proc do_options {} {
 					menu $w.$f.$optid.m
 					build_encoding_menu $w.$f.$optid.m \
 						[list set ${f}_config_new($name)] 1
-					button $w.$f.$optid.b \
+					${NS}::button $w.$f.$optid.b \
 						-text [mc "Change"] \
 						-command [list popup_btn_menu \
 							$w.$f.$optid.m $w.$f.$optid.b]
@@ -226,11 +226,17 @@ proc do_options {} {
 			set ${f}_config_new(gui.spellingdictionary) $value
 		}
 
-		frame $w.$f.$optid
-		label $w.$f.$optid.l -text [mc "Spelling Dictionary:"]
-		eval tk_optionMenu $w.$f.$optid.v \
-			${f}_config_new(gui.spellingdictionary) \
-			$all_dicts
+		${NS}::frame $w.$f.$optid
+		${NS}::label $w.$f.$optid.l -text [mc "Spelling Dictionary:"]
+		if {$use_ttk} {
+			ttk::combobox $w.$f.$optid.v \
+				-textvariable ${f}_config_new(gui.spellingdictionary) \
+				-values $all_dicts -state readonly
+		} else {
+			eval tk_optionMenu $w.$f.$optid.v \
+				${f}_config_new(gui.spellingdictionary) \
+				$all_dicts
+		}
 		pack $w.$f.$optid.l -side left -anchor w -fill x
 		pack $w.$f.$optid.v -side right -anchor e -padx 5
 		pack $w.$f.$optid -side top -anchor w -fill x
@@ -248,20 +254,20 @@ proc do_options {} {
 		set global_config_new(gui.$font^^size) \
 			[font configure $font -size]
 
-		frame $w.global.$name
-		label $w.global.$name.l -text "$text:"
-		button $w.global.$name.b \
+		${NS}::frame $w.global.$name
+		${NS}::label $w.global.$name.l -text "$text:"
+		${NS}::button $w.global.$name.b \
 			-text [mc "Change Font"] \
 			-command [list \
-				choose_font::pick \
+				tchoosefont \
 				$w \
 				[mc "Choose %s" $text] \
 				global_config_new(gui.$font^^family) \
 				global_config_new(gui.$font^^size) \
 				]
-		label $w.global.$name.f -textvariable global_config_new(gui.$font^^family)
-		label $w.global.$name.s -textvariable global_config_new(gui.$font^^size)
-		label $w.global.$name.pt -text [mc "pt."]
+		${NS}::label $w.global.$name.f -textvariable global_config_new(gui.$font^^family)
+		${NS}::label $w.global.$name.s -textvariable global_config_new(gui.$font^^size)
+		${NS}::label $w.global.$name.pt -text [mc "pt."]
 		pack $w.global.$name.l -side left -anchor w
 		pack $w.global.$name.b -side right -anchor e
 		pack $w.global.$name.pt -side right -anchor w
@@ -280,6 +286,7 @@ proc do_options {} {
 		set t [mc "Options"]
 	}
 	wm title $w "[appname] ([reponame]): $t"
+	wm deiconify $w
 	tkwait window $w
 }
 
diff --git a/lib/remote_add.tcl b/lib/remote_add.tcl
index fb29422..50029d0 100644
--- a/lib/remote_add.tcl
+++ b/lib/remote_add.tcl
@@ -13,45 +13,43 @@ field location     {}; # location of the remote the user has chosen
 field opt_action fetch; # action to do after registering the remote locally
 
 constructor dialog {} {
-	global repo_config
+	global repo_config use_ttk NS
 
-	make_toplevel top w
+	make_dialog top w
+	wm withdraw $top
 	wm title $top [append "[appname] ([reponame]): " [mc "Add Remote"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text [mc "Add New Remote"] -font font_uibold
+	${NS}::label $w.header -text [mc "Add New Remote"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.create -text [mc Add] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.create -text [mc Add] \
 		-default active \
 		-command [cb _add]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text [mc Cancel] \
+	${NS}::button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.desc -text [mc "Remote Details"]
+	${NS}::labelframe $w.desc -text [mc "Remote Details"]
 
-	label $w.desc.name_l -text [mc "Name:"]
+	${NS}::label $w.desc.name_l -text [mc "Name:"]
 	set w_name $w.desc.name_t
-	entry $w_name \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w_name \
 		-width 40 \
 		-textvariable @name \
 		-validate key \
 		-validatecommand [cb _validate_name %d %S]
 	grid $w.desc.name_l $w_name -sticky we -padx {0 5}
 
-	label $w.desc.loc_l -text [mc "Location:"]
+	${NS}::label $w.desc.loc_l -text [mc "Location:"]
 	set w_loc $w.desc.loc_t
-	entry $w_loc \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w_loc \
 		-width 40 \
 		-textvariable @location
 	grid $w.desc.loc_l $w_loc -sticky we -padx {0 5}
@@ -59,21 +57,21 @@ constructor dialog {} {
 	grid columnconfigure $w.desc 1 -weight 1
 	pack $w.desc -anchor nw -fill x -pady 5 -padx 5
 
-	labelframe $w.action -text [mc "Further Action"]
+	${NS}::labelframe $w.action -text [mc "Further Action"]
 
-	radiobutton $w.action.fetch \
+	${NS}::radiobutton $w.action.fetch \
 		-text [mc "Fetch Immediately"] \
 		-value fetch \
 		-variable @opt_action
 	pack $w.action.fetch -anchor nw
 
-	radiobutton $w.action.push \
+	${NS}::radiobutton $w.action.push \
 		-text [mc "Initialize Remote Repository and Push"] \
 		-value push \
 		-variable @opt_action
 	pack $w.action.push -anchor nw
 
-	radiobutton $w.action.none \
+	${NS}::radiobutton $w.action.none \
 		-text [mc "Do Nothing Else Now"] \
 		-value none \
 		-variable @opt_action
@@ -85,6 +83,7 @@ constructor dialog {} {
 	bind $w <Visibility> [cb _visible]
 	bind $w <Key-Escape> [list destroy $w]
 	bind $w <Key-Return> [cb _add]\;break
+	wm deiconify $top
 	tkwait window $w
 }
 
diff --git a/lib/remote_branch_delete.tcl b/lib/remote_branch_delete.tcl
index 2416420..f872a3d 100644
--- a/lib/remote_branch_delete.tcl
+++ b/lib/remote_branch_delete.tcl
@@ -23,34 +23,40 @@ field full_cache
 field cached
 
 constructor dialog {} {
-	global all_remotes M1B
+	global all_remotes M1B use_ttk NS
 
-	make_toplevel top w
+	make_dialog top w
 	wm title $top [append "[appname] ([reponame]): " [mc "Delete Branch Remotely"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 	}
 
-	label $w.header -text [mc "Delete Branch Remotely"] -font font_uibold
+	${NS}::label $w.header -text [mc "Delete Branch Remotely"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.delete -text [mc Delete] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.delete -text [mc Delete] \
 		-default active \
 		-command [cb _delete]
 	pack $w.buttons.delete -side right
-	button $w.buttons.cancel -text [mc "Cancel"] \
+	${NS}::button $w.buttons.cancel -text [mc "Cancel"] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.dest -text [mc "From Repository"]
+	${NS}::labelframe $w.dest -text [mc "From Repository"]
 	if {$all_remotes ne {}} {
-		radiobutton $w.dest.remote_r \
+		${NS}::radiobutton $w.dest.remote_r \
 			-text [mc "Remote:"] \
 			-value remote \
 			-variable @urltype
-		eval tk_optionMenu $w.dest.remote_m @remote $all_remotes
+		if {$use_ttk} {
+			ttk::combobox $w.dest.remote_m -textvariable @remote \
+				-values $all_remotes -state readonly
+		} else {
+			eval tk_optionMenu $w.dest.remote_m @remote $all_remotes
+		}
 		grid $w.dest.remote_r $w.dest.remote_m -sticky w
 		if {[lsearch -sorted -exact $all_remotes origin] != -1} {
 			set remote origin
@@ -62,13 +68,11 @@ constructor dialog {} {
 	} else {
 		set urltype url
 	}
-	radiobutton $w.dest.url_r \
+	${NS}::radiobutton $w.dest.url_r \
 		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable @urltype
-	entry $w.dest.url_t \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w.dest.url_t \
 		-width 50 \
 		-textvariable @url \
 		-validate key \
@@ -81,33 +85,30 @@ constructor dialog {} {
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
 
-	labelframe $w.heads -text [mc "Branches"]
-	listbox $w.heads.l \
+	${NS}::labelframe $w.heads -text [mc "Branches"]
+	slistbox $w.heads.l \
 		-height 10 \
 		-width 70 \
 		-listvariable @head_list \
-		-selectmode extended \
-		-yscrollcommand [list $w.heads.sby set]
-	scrollbar $w.heads.sby -command [list $w.heads.l yview]
+		-selectmode extended
 
-	frame $w.heads.footer
-	label $w.heads.footer.status \
+	${NS}::frame $w.heads.footer
+	${NS}::label $w.heads.footer.status \
 		-textvariable @status \
 		-anchor w \
 		-justify left
-	button $w.heads.footer.rescan \
+	${NS}::button $w.heads.footer.rescan \
 		-text [mc "Rescan"] \
 		-command [cb _rescan]
 	pack $w.heads.footer.status -side left -fill x
 	pack $w.heads.footer.rescan -side right
 
 	pack $w.heads.footer -side bottom -fill x
-	pack $w.heads.sby -side right -fill y
 	pack $w.heads.l -side left -fill both -expand 1
 	pack $w.heads -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.validate -text [mc "Delete Only If"]
-	radiobutton $w.validate.head_r \
+	${NS}::labelframe $w.validate -text [mc "Delete Only If"]
+	${NS}::radiobutton $w.validate.head_r \
 		-text [mc "Merged Into:"] \
 		-value head \
 		-variable @checktype
@@ -115,7 +116,7 @@ constructor dialog {} {
 	trace add variable @head_list write [cb _write_head_list]
 	trace add variable @check_head write [cb _write_check_head]
 	grid $w.validate.head_r $w.validate.head_m -sticky w
-	radiobutton $w.validate.always_r \
+	${NS}::radiobutton $w.validate.always_r \
 		-text [mc "Always (Do not perform merge checks)"] \
 		-value always \
 		-variable @checktype
diff --git a/lib/search.tcl b/lib/search.tcl
index b371e9a..7fdbf87 100644
--- a/lib/search.tcl
+++ b/lib/search.tcl
@@ -14,15 +14,16 @@ field smarktop
 field smarkbot
 
 constructor new {i_w i_text args} {
+	global use_ttk NS
 	set w      $i_w
 	set ctext  $i_text
 
-	frame  $w
-	label  $w.l       -text [mc Find:]
+	${NS}::frame  $w
+	${NS}::label  $w.l       -text [mc Find:]
 	entry  $w.ent -textvariable ${__this}::searchstring -background lightgreen
-	button $w.bn      -text [mc Next] -command [cb find_next]
-	button $w.bp      -text [mc Prev] -command [cb find_prev]
-	checkbutton $w.cs -text [mc Case-Sensitive] \
+	${NS}::button $w.bn      -text [mc Next] -command [cb find_next]
+	${NS}::button $w.bp      -text [mc Prev] -command [cb find_prev]
+	${NS}::checkbutton $w.cs -text [mc Case-Sensitive] \
 		-variable ${__this}::casesensitive -command [cb _incrsearch]
 	pack   $w.l   -side left
 	pack   $w.cs  -side right
diff --git a/lib/sshkey.tcl b/lib/sshkey.tcl
index 82a1a80..5f75bc9 100644
--- a/lib/sshkey.tcl
+++ b/lib/sshkey.tcl
@@ -15,7 +15,7 @@ proc find_ssh_key {} {
 }
 
 proc do_ssh_key {} {
-	global sshkey_title have_tk85 sshkey_fd
+	global sshkey_title have_tk85 sshkey_fd use_ttk NS
 
 	set w .sshkey_dialog
 	if {[winfo exists $w]} {
@@ -23,7 +23,7 @@ proc do_ssh_key {} {
 		return
 	}
 
-	toplevel $w
+	Dialog $w
 	wm transient $w .
 
 	set finfo [find_ssh_key]
@@ -35,9 +35,9 @@ proc do_ssh_key {} {
 		set gen_state   disabled
 	}
 
-	frame $w.header -relief flat
-	label $w.header.lbl -textvariable sshkey_title -anchor w
-	button $w.header.gen -text [mc "Generate Key"] \
+	${NS}::frame $w.header
+	${NS}::label $w.header.lbl -textvariable sshkey_title -anchor w
+	${NS}::button $w.header.gen -text [mc "Generate Key"] \
 		-command [list make_ssh_key $w] -state $gen_state
 	pack $w.header.lbl -side left -expand 1 -fill x
 	pack $w.header.gen -side right
@@ -46,14 +46,16 @@ proc do_ssh_key {} {
 	text $w.contents -width 60 -height 10 -wrap char -relief sunken
 	pack $w.contents -fill both -expand 1
 	if {$have_tk85} {
-		$w.contents configure -inactiveselectbackground darkblue
+		set clr darkblue
+		if {$use_ttk} { set clr [ttk::style lookup . -selectbackground] }
+		$w.contents configure -inactiveselectbackground $clr
 	}
 
-	frame $w.buttons
-	button $w.buttons.close -text [mc Close] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.close -text [mc Close] \
 		-default active -command [list destroy $w]
 	pack $w.buttons.close -side right
-	button $w.buttons.copy -text [mc "Copy To Clipboard"] \
+	${NS}::button $w.buttons.copy -text [mc "Copy To Clipboard"] \
 		-command [list tk_textCopy $w.contents]
 	pack $w.buttons.copy -side left
 	pack $w.buttons -side bottom -fill x -pady 5 -padx 5
diff --git a/lib/status_bar.tcl b/lib/status_bar.tcl
index 51d4177..5fe3aad 100644
--- a/lib/status_bar.tcl
+++ b/lib/status_bar.tcl
@@ -13,14 +13,16 @@ field units   {}; # unit of progress
 field meter   {}; # current core git progress meter (if active)
 
 constructor new {path} {
+	global use_ttk NS
 	set w $path
 	set w_l $w.l
 	set w_c $w.c
 
-	frame $w \
-		-borderwidth 1 \
-		-relief sunken
-	label $w_l \
+	${NS}::frame $w
+	if {!$use_ttk} {
+		$w configure -borderwidth 1 -relief sunken
+	}
+	${NS}::label $w_l \
 		-textvariable @status \
 		-anchor w \
 		-justify left
@@ -41,8 +43,8 @@ constructor two_line {path} {
 	set w_l $w.l
 	set w_c $w.c
 
-	frame $w
-	label $w_l \
+	${NS}::frame $w
+	${NS}::label $w_l \
 		-textvariable @status \
 		-anchor w \
 		-justify left
diff --git a/lib/themed.tcl b/lib/themed.tcl
new file mode 100644
index 0000000..518a5d5
--- /dev/null
+++ b/lib/themed.tcl
@@ -0,0 +1,156 @@
+# Functions for supporting the use of themed Tk widgets in git-gui.
+# Copyright (C) 2009 Pat Thoyts <patthoyts@users.sourceforge.net>
+
+proc InitTheme {} {
+	# Create a color label style (bg can be overridden by widget option)
+	ttk::style layout Color.TLabel {
+		Color.Label.border -sticky news -children {
+			Color.label.fill -sticky news -children {
+				Color.Label.padding -sticky news -children {
+					Color.Label.label -sticky news}}}}
+	eval [linsert [ttk::style configure TLabel] 0 \
+			  ttk::style configure Color.TLabel]
+	ttk::style configure Color.TLabel \
+		-borderwidth 0 -relief flat -padding 2
+	ttk::style map Color.TLabel -background {{} gold}
+	# We need a gold frame.
+	ttk::style layout Gold.TFrame {
+		Gold.Frame.border -sticky nswe -children {
+			Gold.Frame.fill -sticky nswe}}
+	ttk::style configure Gold.TFrame -background gold -relief flat
+	# listboxes should have a theme border so embed in ttk::frame
+	ttk::style layout SListbox.TFrame {
+        SListbox.Frame.Entry.field -sticky news -border true -children {
+            SListbox.Frame.padding -sticky news
+        }
+    }
+}
+
+proc gold_frame {w args} {
+	global use_ttk
+	if {$use_ttk} {
+		eval [linsert $args 0 ttk::frame $w -style Gold.TFrame]
+	} else {
+		eval [linsert $args 0 frame $w -background gold]
+	}
+}
+
+proc tlabel {w args} {
+	global use_ttk
+	if {$use_ttk} {
+		set cmd [list ttk::label $w -style Color.TLabel]
+		foreach {k v} $args {
+			switch -glob -- $k {
+				-activebackground {}
+				default { lappend cmd $k $v }
+			}
+		}
+		eval $cmd
+	} else {
+		eval [linsert $args 0 label $w]
+	}
+}
+
+# Create a toplevel for use as a dialog.
+# If available, sets the EWMH dialog hint and if ttk is enabled
+# place a themed frame over the surface.
+proc Dialog {w args} {
+	eval [linsert $args 0 toplevel $w -class Dialog]
+	pave_toplevel $w
+	return $w
+}
+
+# Tk toplevels are not themed - so pave it over with a themed frame to get
+# the base color correct per theme.
+proc pave_toplevel {w} {
+	global use_ttk
+	if {$use_ttk && ![winfo exists $w.!paving]} {
+		set paving [ttk::frame $w.!paving]
+		place $paving -x 0 -y 0 -relwidth 1 -relheight 1
+		lower $paving
+	}
+}
+
+# Create a scrolled listbox with appropriate border for the current theme.
+# On many themes the border for a scrolled listbox needs to go around the
+# listbox and the scrollbar.
+proc slistbox {w args} {
+	global use_ttk NS
+	if {$use_ttk} {
+		set f [ttk::frame $w -style SListbox.TFrame -padding 2]
+	} else {
+		set f [frame $w -relief flat]
+	}
+    if {[catch {
+		if {$use_ttk} {
+			eval [linsert $args 0 listbox $f.list -relief flat \
+					  -highlightthickness 0 -borderwidth 0]
+		} else {
+			eval [linsert $args 0 listbox $f.list]
+		}
+        ${NS}::scrollbar $f.vs -command [list $f.list yview]
+        $f.list configure -yscrollcommand [list $f.vs set]
+        grid $f.list $f.vs -sticky news
+        grid rowconfigure $f 0 -weight 1
+        grid columnconfigure $f 0 -weight 1
+		bind $f.list <<ListboxSelect>> \
+			[list event generate $w <<ListboxSelect>>]
+        interp hide {} $w
+        interp alias {} $w {} $f.list
+    } err]} {
+        destroy $f
+        return -code error $err
+    }
+    return $w
+}
+
+# fetch the background color from a widget.
+proc get_bg_color {w} {
+	global use_ttk
+	if {$use_ttk} {
+		set bg [ttk::style lookup [winfo class $w] -background]
+	} else {
+		set bg [$w cget -background]
+	}
+	return $bg
+}
+
+# ttk::spinbox didn't get added until 8.6
+proc tspinbox {w args} {
+	global use_ttk
+	if {$use_ttk && [llength [info commands ttk::spinbox]] > 0} {
+		eval [linsert $args 0 ttk::spinbox $w]
+	} else {
+		eval [linsert $args 0 spinbox $w]
+	}
+}
+
+# Tk 8.6 provides a standard font selection dialog. This uses the native
+# dialogs on Windows and MacOSX or a standard Tk dialog on X11.
+proc tchoosefont {w title familyvar sizevar} {
+	if {[package vsatisfies [package provide Tk] 8.6]} {
+		upvar #0 $familyvar family
+		upvar #0 $sizevar size
+		tk fontchooser configure -parent $w -title $title \
+			-font [list $family $size] \
+			-command [list on_choosefont $familyvar $sizevar]
+		tk fontchooser show
+	} else {
+		choose_font::pick $w $title $familyvar $sizevar
+	}
+}
+
+# Called when the Tk 8.6 fontchooser selects a font.
+proc on_choosefont {familyvar sizevar font} {
+	upvar #0 $familyvar family
+	upvar #0 $sizevar size
+	set font [font actual $font]
+	set family [dict get $font -family]
+	set size [dict get $font -size]
+}
+
+# Local variables:
+# mode: tcl
+# indent-tabs-mode: t
+# tab-width: 4
+# End:
diff --git a/lib/tools_dlg.tcl b/lib/tools_dlg.tcl
index 5f7f08e..7eeda9d 100644
--- a/lib/tools_dlg.tcl
+++ b/lib/tools_dlg.tcl
@@ -16,53 +16,50 @@ field ask_branch    0; # ask for a revision
 field ask_args      0; # ask for additional args
 
 constructor dialog {} {
-	global repo_config
+	global repo_config use_ttk NS
 
-	make_toplevel top w
+	make_dialog top w
 	wm title $top [append "[appname] ([reponame]): " [mc "Add Tool"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 		wm transient $top .
 	}
 
-	label $w.header -text [mc "Add New Tool Command"] -font font_uibold
+	${NS}::label $w.header -text [mc "Add New Tool Command"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	checkbutton $w.buttons.global \
+	${NS}::frame $w.buttons
+	${NS}::checkbutton $w.buttons.global \
 		-text [mc "Add globally"] \
 		-variable @add_global
 	pack $w.buttons.global -side left -padx 5
-	button $w.buttons.create -text [mc Add] \
+	${NS}::button $w.buttons.create -text [mc Add] \
 		-default active \
 		-command [cb _add]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text [mc Cancel] \
+	${NS}::button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.desc -text [mc "Tool Details"]
+	${NS}::labelframe $w.desc -text [mc "Tool Details"]
 
-	label $w.desc.name_cmnt -anchor w\
+	${NS}::label $w.desc.name_cmnt -anchor w\
 		-text [mc "Use '/' separators to create a submenu tree:"]
 	grid x $w.desc.name_cmnt -sticky we -padx {0 5} -pady {0 2}
-	label $w.desc.name_l -text [mc "Name:"]
+	${NS}::label $w.desc.name_l -text [mc "Name:"]
 	set w_name $w.desc.name_t
-	entry $w_name \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w_name \
 		-width 40 \
 		-textvariable @name \
 		-validate key \
 		-validatecommand [cb _validate_name %d %S]
 	grid $w.desc.name_l $w_name -sticky we -padx {0 5}
 
-	label $w.desc.cmd_l -text [mc "Command:"]
+	${NS}::label $w.desc.cmd_l -text [mc "Command:"]
 	set w_cmd $w.desc.cmd_t
-	entry $w_cmd \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w_cmd \
 		-width 40 \
 		-textvariable @command
 	grid $w.desc.cmd_l $w_cmd -sticky we -padx {0 5} -pady {0 3}
@@ -70,30 +67,30 @@ constructor dialog {} {
 	grid columnconfigure $w.desc 1 -weight 1
 	pack $w.desc -anchor nw -fill x -pady 5 -padx 5
 
-	checkbutton $w.confirm \
+	${NS}::checkbutton $w.confirm \
 		-text [mc "Show a dialog before running"] \
 		-variable @confirm -command [cb _check_enable_dlg]
 
-	labelframe $w.dlg -labelwidget $w.confirm
+	${NS}::labelframe $w.dlg -labelwidget $w.confirm
 
-	checkbutton $w.dlg.askbranch \
+	${NS}::checkbutton $w.dlg.askbranch \
 		-text [mc "Ask the user to select a revision (sets \$REVISION)"] \
 		-variable @ask_branch -state disabled
 	pack $w.dlg.askbranch -anchor w -padx 15
 
-	checkbutton $w.dlg.askargs \
+	${NS}::checkbutton $w.dlg.askargs \
 		-text [mc "Ask the user for additional arguments (sets \$ARGS)"] \
 		-variable @ask_args -state disabled
 	pack $w.dlg.askargs -anchor w -padx 15
 
 	pack $w.dlg -anchor nw -fill x -pady {0 8} -padx 5
 
-	checkbutton $w.noconsole \
+	${NS}::checkbutton $w.noconsole \
 		-text [mc "Don't show the command output window"] \
 		-variable @no_console
 	pack $w.noconsole -anchor w -padx 5
 
-	checkbutton $w.needsfile \
+	${NS}::checkbutton $w.needsfile \
 		-text [mc "Run only if a diff is selected (\$FILENAME not empty)"] \
 		-variable @needs_file
 	pack $w.needsfile -anchor w -padx 5
@@ -182,40 +179,38 @@ field w              ; # widget path
 field w_names        ; # name list
 
 constructor dialog {} {
-	global repo_config global_config system_config
+	global repo_config global_config system_config use_ttk NS
 
 	load_config 1
 
-	make_toplevel top w
+	make_dialog top w
 	wm title $top [append "[appname] ([reponame]): " [mc "Remove Tool"]]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
 		wm transient $top .
 	}
 
-	label $w.header -text [mc "Remove Tool Commands"] -font font_uibold
+	${NS}::label $w.header -text [mc "Remove Tool Commands"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.create -text [mc Remove] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.create -text [mc Remove] \
 		-default active \
 		-command [cb _remove]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text [mc Cancel] \
+	${NS}::button $w.buttons.cancel -text [mc Cancel] \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	frame $w.list
+	${NS}::frame $w.list
 	set w_names $w.list.l
-	listbox $w_names \
+	slistbox $w_names \
 		-height 10 \
 		-width 30 \
 		-selectmode extended \
-		-exportselection false \
-		-yscrollcommand [list $w.list.sby set]
-	scrollbar $w.list.sby -command [list $w.list.l yview]
-	pack $w.list.sby -side right -fill y
+		-exportselection false
 	pack $w.list.l -side left -fill both -expand 1
 	pack $w.list -fill both -expand 1 -pady 5 -padx 5
 
@@ -232,7 +227,7 @@ constructor dialog {} {
 	}
 
 	if {$local_cnt > 0} {
-		label $w.colorlbl -foreground blue \
+		${NS}::label $w.colorlbl -foreground blue \
 			-text [mc "(Blue denotes repository-local tools)"]
 		pack $w.colorlbl -fill x -pady 5 -padx 5
 	}
@@ -277,14 +272,14 @@ field is_ok         0; # ok to start
 field argstr       {}; # arguments
 
 constructor dialog {fullname} {
-	global M1B
+	global M1B use_ttk NS
 
 	set title [get_config "guitool.$fullname.title"]
 	if {$title eq {}} {
 		regsub {/} $fullname { / } title
 	}
 
-	make_toplevel top w -autodelete 0
+	make_dialog top w -autodelete 0
 	wm title $top [append "[appname] ([reponame]): " $title]
 	if {$top ne {.}} {
 		wm geometry $top "+[winfo rootx .]+[winfo rooty .]"
@@ -297,7 +292,7 @@ constructor dialog {fullname} {
 		set prompt [mc "Run Command: %s" $command]
 	}
 
-	label $w.header -text $prompt -font font_uibold
+	${NS}::label $w.header -text $prompt -font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
 	set argprompt [get_config "guitool.$fullname.argprompt"]
@@ -311,12 +306,10 @@ constructor dialog {fullname} {
 			set argprompt [mc "Arguments"]
 		}
 
-		labelframe $w.arg -text $argprompt
+		${NS}::labelframe $w.arg -text $argprompt
 
 		set w_args $w.arg.txt
-		entry $w_args \
-			-borderwidth 1 \
-			-relief sunken \
+		${NS}::entry $w_args \
 			-width 40 \
 			-textvariable @argstr
 		pack $w_args -padx 5 -pady 5 -fill both
@@ -337,18 +330,18 @@ constructor dialog {fullname} {
 		pack $w.rev -anchor nw -fill both -expand 1 -pady 5 -padx 5
 	}
 
-	frame $w.buttons
+	${NS}::frame $w.buttons
 	if {$is_ask_revs} {
-		button $w.buttons.visualize \
+		${NS}::button $w.buttons.visualize \
 			-text [mc Visualize] \
 			-command [cb _visualize]
 		pack $w.buttons.visualize -side left
 	}
-	button $w.buttons.ok \
+	${NS}::button $w.buttons.ok \
 		-text [mc OK] \
 		-command [cb _start]
 	pack $w.buttons.ok -side right
-	button $w.buttons.cancel \
+	${NS}::button $w.buttons.cancel \
 		-text [mc "Cancel"] \
 		-command [cb _cancel]
 	pack $w.buttons.cancel -side right -padx 5
diff --git a/lib/transport.tcl b/lib/transport.tcl
index b18d9c7..60e3a64 100644
--- a/lib/transport.tcl
+++ b/lib/transport.tcl
@@ -91,50 +91,55 @@ trace add variable push_remote write \
 proc do_push_anywhere {} {
 	global all_remotes current_branch
 	global push_urltype push_remote push_url push_thin push_tags
-	global push_force
+	global push_force use_ttk NS
 
 	set w .push_setup
 	toplevel $w
+	wm withdraw $w
 	wm geometry $w "+[winfo rootx .]+[winfo rooty .]"
+	pave_toplevel $w
 
-	label $w.header -text [mc "Push Branches"] -font font_uibold
+	${NS}::label $w.header -text [mc "Push Branches"] \
+		-font font_uibold -anchor center
 	pack $w.header -side top -fill x
 
-	frame $w.buttons
-	button $w.buttons.create -text [mc Push] \
+	${NS}::frame $w.buttons
+	${NS}::button $w.buttons.create -text [mc Push] \
 		-default active \
 		-command [list start_push_anywhere_action $w]
 	pack $w.buttons.create -side right
-	button $w.buttons.cancel -text [mc "Cancel"] \
+	${NS}::button $w.buttons.cancel -text [mc "Cancel"] \
 		-default normal \
 		-command [list destroy $w]
 	pack $w.buttons.cancel -side right -padx 5
 	pack $w.buttons -side bottom -fill x -pady 10 -padx 10
 
-	labelframe $w.source -text [mc "Source Branches"]
-	listbox $w.source.l \
+	${NS}::labelframe $w.source -text [mc "Source Branches"]
+	slistbox $w.source.l \
 		-height 10 \
 		-width 70 \
-		-selectmode extended \
-		-yscrollcommand [list $w.source.sby set]
+		-selectmode extended
 	foreach h [load_all_heads] {
 		$w.source.l insert end $h
 		if {$h eq $current_branch} {
 			$w.source.l select set end
 		}
 	}
-	scrollbar $w.source.sby -command [list $w.source.l yview]
-	pack $w.source.sby -side right -fill y
 	pack $w.source.l -side left -fill both -expand 1
 	pack $w.source -fill both -expand 1 -pady 5 -padx 5
 
-	labelframe $w.dest -text [mc "Destination Repository"]
+	${NS}::labelframe $w.dest -text [mc "Destination Repository"]
 	if {$all_remotes ne {}} {
-		radiobutton $w.dest.remote_r \
+		${NS}::radiobutton $w.dest.remote_r \
 			-text [mc "Remote:"] \
 			-value remote \
 			-variable push_urltype
-		eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
+		if {$use_ttk} {
+			ttk::combobox $w.dest.remote_m -textvariable push_remote \
+				-values $all_remotes
+		} else {
+			eval tk_optionMenu $w.dest.remote_m push_remote $all_remotes
+		}
 		grid $w.dest.remote_r $w.dest.remote_m -sticky w
 		if {[lsearch -sorted -exact $all_remotes origin] != -1} {
 			set push_remote origin
@@ -145,13 +150,11 @@ proc do_push_anywhere {} {
 	} else {
 		set push_urltype url
 	}
-	radiobutton $w.dest.url_r \
+	${NS}::radiobutton $w.dest.url_r \
 		-text [mc "Arbitrary Location:"] \
 		-value url \
 		-variable push_urltype
-	entry $w.dest.url_t \
-		-borderwidth 1 \
-		-relief sunken \
+	${NS}::entry $w.dest.url_t \
 		-width 50 \
 		-textvariable push_url \
 		-validate key \
@@ -166,16 +169,16 @@ proc do_push_anywhere {} {
 	grid columnconfigure $w.dest 1 -weight 1
 	pack $w.dest -anchor nw -fill x -pady 5 -padx 5
 
-	labelframe $w.options -text [mc "Transfer Options"]
-	checkbutton $w.options.force \
+	${NS}::labelframe $w.options -text [mc "Transfer Options"]
+	${NS}::checkbutton $w.options.force \
 		-text [mc "Force overwrite existing branch (may discard changes)"] \
 		-variable push_force
 	grid $w.options.force -columnspan 2 -sticky w
-	checkbutton $w.options.thin \
+	${NS}::checkbutton $w.options.thin \
 		-text [mc "Use thin pack (for slow network connections)"] \
 		-variable push_thin
 	grid $w.options.thin -columnspan 2 -sticky w
-	checkbutton $w.options.tags \
+	${NS}::checkbutton $w.options.tags \
 		-text [mc "Include tags"] \
 		-variable push_tags
 	grid $w.options.tags -columnspan 2 -sticky w
@@ -191,5 +194,6 @@ proc do_push_anywhere {} {
 	bind $w <Key-Escape> "destroy $w"
 	bind $w <Key-Return> [list start_push_anywhere_action $w]
 	wm title $w [append "[appname] ([reponame]): " [mc "Push"]]
+	wm deiconify $w
 	tkwait window $w
 }
-- 
1.6.5.1.1367.gcd48
