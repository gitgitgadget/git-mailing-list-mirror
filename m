From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: use a tabbed dialog to edit preferences
Date: Tue, 13 Dec 2011 14:56:49 +0000
Message-ID: <87ty547arf.fsf@fox.patthoyts.tk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
To: Git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 13 16:27:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RaUGY-0007Jt-6Q
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 16:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754892Ab1LMP11 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 10:27:27 -0500
Received: from mtaout02-winn.ispmail.ntl.com ([81.103.221.48]:5584 "EHLO
	mtaout02-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754065Ab1LMP1L (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Dec 2011 10:27:11 -0500
Received: from know-smtpout-4.server.virginmedia.net ([62.254.123.2])
          by mtaout02-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20111213152702.TIIT11752.mtaout02-winn.ispmail.ntl.com@know-smtpout-4.server.virginmedia.net>;
          Tue, 13 Dec 2011 15:27:02 +0000
Received: from [94.171.229.22] (helo=fox.patthoyts.tk)
	by know-smtpout-4.server.virginmedia.net with esmtpa (Exim 4.63)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1RaUFy-0005JM-97; Tue, 13 Dec 2011 15:27:02 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2999620806; Tue, 13 Dec 2011 15:27:01 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
X-Url: http://www.patthoyts.tk/
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=O9HYxzjLEG8A:10 a=f-Z5v1zQKK4A:10 a=kj9zAlcOel0A:10 a=FP58Ms26AAAA:8 a=VwQbUJbxAAAA:8 a=c_LxSaOlehPrnXBCQMIA:9 a=uIHLD9JcGflrfPFCq50A:7 a=CjuIK1q_8ugA:10 a=U62fhAwekXMA:10 a=f5tjhc1ilKWCaA4u:21 a=lUKKX727IePbMiq0:21 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This commit converts the user preferences dialog into a tabbed property
sheet grouping general properties, colours and font selections onto
separate pages. The previous implementation was exceeding the screen
height on some systems and this avoids such problems and permits extension
using new pages in the future.

If themed Tk is unavailable or undesired a reasonable facsimile of the
tabbed notebook widget is used instead.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

I have done this patch against the git-core version of gitk as gitk's
own repository on kernel.org has not re-appeared. Is this likely to get
resurrected or should I perhaps make a github fork for any future work
on gitk?

Cheers,
Pat.

 gitk-git/gitk |  264 +++++++++++++++++++++++++++++++++++----------------------
 1 files changed, 164 insertions(+), 100 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 2a92e20..8d95bfc 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -10770,6 +10770,139 @@ proc chg_fontparam {v sub op} {
     font config sample -$sub $fontparam($sub)
 }
 
+# Create a property sheet tab page
+proc create_prefs_page {w} {
+    global NS
+    set parent [join [lrange [split $w .] 0 end-1] .]
+    if {[winfo class $parent] eq "TNotebook"} {
+	${NS}::frame $w
+    } else {
+	${NS}::labelframe $w
+    }
+}
+
+proc prefspage_general {notebook} {
+    global NS maxwidth maxgraphpct showneartags showlocalchanges
+    global tabstop limitdiffs autoselect autosellen extdifftool perfile_attrs
+    global hideremotes want_ttk have_ttk
+
+    set page [create_prefs_page $notebook.general]
+
+    ${NS}::label $page.ldisp -text [mc "Commit list display options"]
+    grid $page.ldisp - -sticky w -pady 10
+    ${NS}::label $page.spacer -text " "
+    ${NS}::label $page.maxwidthl -text [mc "Maximum graph width (lines)"]
+    spinbox $page.maxwidth -from 0 -to 100 -width 4 -textvariable maxwidth
+    grid $page.spacer $page.maxwidthl $page.maxwidth -sticky w
+    ${NS}::label $page.maxpctl -text [mc "Maximum graph width (% of pane)"]
+    spinbox $page.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
+    grid x $page.maxpctl $page.maxpct -sticky w
+    ${NS}::checkbutton $page.showlocal -text [mc "Show local changes"] \
+	-variable showlocalchanges
+    grid x $page.showlocal -sticky w
+    ${NS}::checkbutton $page.autoselect -text [mc "Auto-select SHA1 (length)"] \
+	-variable autoselect
+    spinbox $page.autosellen -from 1 -to 40 -width 4 -textvariable autosellen
+    grid x $page.autoselect $page.autosellen -sticky w
+    ${NS}::checkbutton $page.hideremotes -text [mc "Hide remote refs"] \
+	-variable hideremotes
+    grid x $page.hideremotes -sticky w
+
+    ${NS}::label $page.ddisp -text [mc "Diff display options"]
+    grid $page.ddisp - -sticky w -pady 10
+    ${NS}::label $page.tabstopl -text [mc "Tab spacing"]
+    spinbox $page.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
+    grid x $page.tabstopl $page.tabstop -sticky w
+    ${NS}::checkbutton $page.ntag -text [mc "Display nearby tags"] \
+	-variable showneartags
+    grid x $page.ntag -sticky w
+    ${NS}::checkbutton $page.ldiff -text [mc "Limit diffs to listed paths"] \
+	-variable limitdiffs
+    grid x $page.ldiff -sticky w
+    ${NS}::checkbutton $page.lattr -text [mc "Support per-file encodings"] \
+	-variable perfile_attrs
+    grid x $page.lattr -sticky w
+
+    ${NS}::entry $page.extdifft -textvariable extdifftool
+    ${NS}::frame $page.extdifff
+    ${NS}::label $page.extdifff.l -text [mc "External diff tool" ]
+    ${NS}::button $page.extdifff.b -text [mc "Choose..."] -command choose_extdiff
+    pack $page.extdifff.l $page.extdifff.b -side left
+    pack configure $page.extdifff.l -padx 10
+    grid x $page.extdifff $page.extdifft -sticky ew
+
+    ${NS}::label $page.lgen -text [mc "General options"]
+    grid $page.lgen - -sticky w -pady 10
+    ${NS}::checkbutton $page.want_ttk -variable want_ttk \
+	-text [mc "Use themed widgets"]
+    if {$have_ttk} {
+	${NS}::label $page.ttk_note -text [mc "(change requires restart)"]
+    } else {
+	${NS}::label $page.ttk_note -text [mc "(currently unavailable)"]
+    }
+    grid x $page.want_ttk $page.ttk_note -sticky w
+    return $page
+}
+
+proc prefspage_colors {notebook} {
+    global NS uicolor bgcolor fgcolor ctext diffcolors selectbgcolor markbgcolor
+
+    set page [create_prefs_page $notebook.colors]
+
+    ${NS}::label $page.cdisp -text [mc "Colors: press to choose"]
+    grid $page.cdisp - -sticky w -pady 10
+    label $page.ui -padx 40 -relief sunk -background $uicolor
+    ${NS}::button $page.uibut -text [mc "Interface"] \
+       -command [list choosecolor uicolor {} $page.ui [mc "interface"] setui]
+    grid x $page.uibut $page.ui -sticky w
+    label $page.bg -padx 40 -relief sunk -background $bgcolor
+    ${NS}::button $page.bgbut -text [mc "Background"] \
+	-command [list choosecolor bgcolor {} $page.bg [mc "background"] setbg]
+    grid x $page.bgbut $page.bg -sticky w
+    label $page.fg -padx 40 -relief sunk -background $fgcolor
+    ${NS}::button $page.fgbut -text [mc "Foreground"] \
+	-command [list choosecolor fgcolor {} $page.fg [mc "foreground"] setfg]
+    grid x $page.fgbut $page.fg -sticky w
+    label $page.diffold -padx 40 -relief sunk -background [lindex $diffcolors 0]
+    ${NS}::button $page.diffoldbut -text [mc "Diff: old lines"] \
+	-command [list choosecolor diffcolors 0 $page.diffold [mc "diff old lines"] \
+		      [list $ctext tag conf d0 -foreground]]
+    grid x $page.diffoldbut $page.diffold -sticky w
+    label $page.diffnew -padx 40 -relief sunk -background [lindex $diffcolors 1]
+    ${NS}::button $page.diffnewbut -text [mc "Diff: new lines"] \
+	-command [list choosecolor diffcolors 1 $page.diffnew [mc "diff new lines"] \
+		      [list $ctext tag conf dresult -foreground]]
+    grid x $page.diffnewbut $page.diffnew -sticky w
+    label $page.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
+    ${NS}::button $page.hunksepbut -text [mc "Diff: hunk header"] \
+	-command [list choosecolor diffcolors 2 $page.hunksep \
+		      [mc "diff hunk header"] \
+		      [list $ctext tag conf hunksep -foreground]]
+    grid x $page.hunksepbut $page.hunksep -sticky w
+    label $page.markbgsep -padx 40 -relief sunk -background $markbgcolor
+    ${NS}::button $page.markbgbut -text [mc "Marked line bg"] \
+	-command [list choosecolor markbgcolor {} $page.markbgsep \
+		      [mc "marked line background"] \
+		      [list $ctext tag conf omark -background]]
+    grid x $page.markbgbut $page.markbgsep -sticky w
+    label $page.selbgsep -padx 40 -relief sunk -background $selectbgcolor
+    ${NS}::button $page.selbgbut -text [mc "Select bg"] \
+	-command [list choosecolor selectbgcolor {} $page.selbgsep [mc "background"] setselbg]
+    grid x $page.selbgbut $page.selbgsep -sticky w
+    return $page
+}
+
+proc prefspage_fonts {notebook} {
+    global NS
+    set page [create_prefs_page $notebook.fonts]
+    ${NS}::label $page.cfont -text [mc "Fonts: press to choose"]
+    grid $page.cfont - -sticky w -pady 10
+    mkfontdisp mainfont $page [mc "Main font"]
+    mkfontdisp textfont $page [mc "Diff display font"]
+    mkfontdisp uifont $page [mc "User interface font"]
+    return $page
+}
+
 proc doprefs {} {
     global maxwidth maxgraphpct use_ttk NS
     global oldprefs prefstop showneartags showlocalchanges
@@ -10790,106 +10923,37 @@ proc doprefs {} {
     ttk_toplevel $top
     wm title $top [mc "Gitk preferences"]
     make_transient $top .
-    ${NS}::label $top.ldisp -text [mc "Commit list display options"]
-    grid $top.ldisp - -sticky w -pady 10
-    ${NS}::label $top.spacer -text " "
-    ${NS}::label $top.maxwidthl -text [mc "Maximum graph width (lines)"]
-    spinbox $top.maxwidth -from 0 -to 100 -width 4 -textvariable maxwidth
-    grid $top.spacer $top.maxwidthl $top.maxwidth -sticky w
-    ${NS}::label $top.maxpctl -text [mc "Maximum graph width (% of pane)"]
-    spinbox $top.maxpct -from 1 -to 100 -width 4 -textvariable maxgraphpct
-    grid x $top.maxpctl $top.maxpct -sticky w
-    ${NS}::checkbutton $top.showlocal -text [mc "Show local changes"] \
-	-variable showlocalchanges
-    grid x $top.showlocal -sticky w
-    ${NS}::checkbutton $top.autoselect -text [mc "Auto-select SHA1 (length)"] \
-	-variable autoselect
-    spinbox $top.autosellen -from 1 -to 40 -width 4 -textvariable autosellen
-    grid x $top.autoselect $top.autosellen -sticky w
-    ${NS}::checkbutton $top.hideremotes -text [mc "Hide remote refs"] \
-	-variable hideremotes
-    grid x $top.hideremotes -sticky w
-
-    ${NS}::label $top.ddisp -text [mc "Diff display options"]
-    grid $top.ddisp - -sticky w -pady 10
-    ${NS}::label $top.tabstopl -text [mc "Tab spacing"]
-    spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
-    grid x $top.tabstopl $top.tabstop -sticky w
-    ${NS}::checkbutton $top.ntag -text [mc "Display nearby tags"] \
-	-variable showneartags
-    grid x $top.ntag -sticky w
-    ${NS}::checkbutton $top.ldiff -text [mc "Limit diffs to listed paths"] \
-	-variable limitdiffs
-    grid x $top.ldiff -sticky w
-    ${NS}::checkbutton $top.lattr -text [mc "Support per-file encodings"] \
-	-variable perfile_attrs
-    grid x $top.lattr -sticky w
-
-    ${NS}::entry $top.extdifft -textvariable extdifftool
-    ${NS}::frame $top.extdifff
-    ${NS}::label $top.extdifff.l -text [mc "External diff tool" ]
-    ${NS}::button $top.extdifff.b -text [mc "Choose..."] -command choose_extdiff
-    pack $top.extdifff.l $top.extdifff.b -side left
-    pack configure $top.extdifff.l -padx 10
-    grid x $top.extdifff $top.extdifft -sticky ew
-
-    ${NS}::label $top.lgen -text [mc "General options"]
-    grid $top.lgen - -sticky w -pady 10
-    ${NS}::checkbutton $top.want_ttk -variable want_ttk \
-	-text [mc "Use themed widgets"]
-    if {$have_ttk} {
-	${NS}::label $top.ttk_note -text [mc "(change requires restart)"]
+
+    if {[set use_notebook [expr {$use_ttk && [info command ::ttk::notebook] ne ""}]]} {
+	set notebook [ttk::notebook $top.notebook]
     } else {
-	${NS}::label $top.ttk_note -text [mc "(currently unavailable)"]
-    }
-    grid x $top.want_ttk $top.ttk_note -sticky w
-
-    ${NS}::label $top.cdisp -text [mc "Colors: press to choose"]
-    grid $top.cdisp - -sticky w -pady 10
-    label $top.ui -padx 40 -relief sunk -background $uicolor
-    ${NS}::button $top.uibut -text [mc "Interface"] \
-       -command [list choosecolor uicolor {} $top.ui [mc "interface"] setui]
-    grid x $top.uibut $top.ui -sticky w
-    label $top.bg -padx 40 -relief sunk -background $bgcolor
-    ${NS}::button $top.bgbut -text [mc "Background"] \
-	-command [list choosecolor bgcolor {} $top.bg [mc "background"] setbg]
-    grid x $top.bgbut $top.bg -sticky w
-    label $top.fg -padx 40 -relief sunk -background $fgcolor
-    ${NS}::button $top.fgbut -text [mc "Foreground"] \
-	-command [list choosecolor fgcolor {} $top.fg [mc "foreground"] setfg]
-    grid x $top.fgbut $top.fg -sticky w
-    label $top.diffold -padx 40 -relief sunk -background [lindex $diffcolors 0]
-    ${NS}::button $top.diffoldbut -text [mc "Diff: old lines"] \
-	-command [list choosecolor diffcolors 0 $top.diffold [mc "diff old lines"] \
-		      [list $ctext tag conf d0 -foreground]]
-    grid x $top.diffoldbut $top.diffold -sticky w
-    label $top.diffnew -padx 40 -relief sunk -background [lindex $diffcolors 1]
-    ${NS}::button $top.diffnewbut -text [mc "Diff: new lines"] \
-	-command [list choosecolor diffcolors 1 $top.diffnew [mc "diff new lines"] \
-		      [list $ctext tag conf dresult -foreground]]
-    grid x $top.diffnewbut $top.diffnew -sticky w
-    label $top.hunksep -padx 40 -relief sunk -background [lindex $diffcolors 2]
-    ${NS}::button $top.hunksepbut -text [mc "Diff: hunk header"] \
-	-command [list choosecolor diffcolors 2 $top.hunksep \
-		      [mc "diff hunk header"] \
-		      [list $ctext tag conf hunksep -foreground]]
-    grid x $top.hunksepbut $top.hunksep -sticky w
-    label $top.markbgsep -padx 40 -relief sunk -background $markbgcolor
-    ${NS}::button $top.markbgbut -text [mc "Marked line bg"] \
-	-command [list choosecolor markbgcolor {} $top.markbgsep \
-		      [mc "marked line background"] \
-		      [list $ctext tag conf omark -background]]
-    grid x $top.markbgbut $top.markbgsep -sticky w
-    label $top.selbgsep -padx 40 -relief sunk -background $selectbgcolor
-    ${NS}::button $top.selbgbut -text [mc "Select bg"] \
-	-command [list choosecolor selectbgcolor {} $top.selbgsep [mc "background"] setselbg]
-    grid x $top.selbgbut $top.selbgsep -sticky w
-
-    ${NS}::label $top.cfont -text [mc "Fonts: press to choose"]
-    grid $top.cfont - -sticky w -pady 10
-    mkfontdisp mainfont $top [mc "Main font"]
-    mkfontdisp textfont $top [mc "Diff display font"]
-    mkfontdisp uifont $top [mc "User interface font"]
+	set notebook [${NS}::frame $top.notebook -borderwidth 0 -relief flat]
+    }
+
+    lappend pages [prefspage_general $notebook] [mc "General"]
+    lappend pages [prefspage_colors $notebook] [mc "Colors"]
+    lappend pages [prefspage_fonts $notebook] [mc "Fonts"]
+    foreach {page title} $pages {
+	if {$use_notebook} {
+	    $notebook add $page -text $title
+	} else {
+	    set btn [${NS}::button $notebook.b_[string map {. X} $page] \
+			 -text $title -command [list raise $page]]
+	    $page configure -text $title
+	    grid $btn -row 0 -column [incr col] -sticky w
+	    grid $page -row 1 -column 0 -sticky news -columnspan 100
+	}
+    }
+
+    if {!$use_notebook} {
+	grid columnconfigure $notebook 0 -weight 1
+	grid rowconfigure $notebook 1 -weight 1
+	raise [lindex $pages 0]
+    }
+
+    grid $notebook -sticky news -padx 2 -pady 2
+    grid rowconfigure $top 0 -weight 1
+    grid columnconfigure $top 0 -weight 1
 
     ${NS}::frame $top.buts
     ${NS}::button $top.buts.ok -text [mc "OK"] -command prefsok -default active
@@ -10901,7 +10965,7 @@ proc doprefs {} {
     grid columnconfigure $top.buts 1 -weight 1 -uniform a
     grid $top.buts - - -pady 10 -sticky ew
     grid columnconfigure $top 2 -weight 1
-    bind $top <Visibility> "focus $top.buts.ok"
+    bind $top <Visibility> [list focus $top.buts.ok]
 }
 
 proc choose_extdiff {} {
-- 
1.7.8.msysgit.0
