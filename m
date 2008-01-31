From: Thomas Arcila <tarcila@mc.com>
Subject: [PATCH] gitk : External diff viewer.
Date: Thu, 31 Jan 2008 17:00:02 +0100
Organization: Mercury Computer Systems
Message-ID: <1201795202.11689.9.camel@bod-tarcila2.ad.mc.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: msysGit <msysgit@googlegroups.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 31 17:01:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKbr3-0000jl-Gp
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 17:01:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761504AbYAaQA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 11:00:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761149AbYAaQA6
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 11:00:58 -0500
Received: from iris-63.mc.com ([63.96.239.141]:53964 "EHLO mc.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756136AbYAaQA4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 11:00:56 -0500
Received: from CHM-EMAIL1.ad.mc.com by mc.com (8.8.8+Sun/SMI-SVR4)
	id LAA26957; Thu, 31 Jan 2008 11:00:54 -0500 (EST)
Received: from fue-email2.ad.mc.com ([192.168.152.32]) by CHM-EMAIL1.ad.mc.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Thu, 31 Jan 2008 11:00:08 -0500
Received: from 192.168.193.115 ([192.168.193.115]) by fue-email2.ad.mc.com ([192.168.152.32]) with Microsoft Exchange Server HTTP-DAV ;
 Thu, 31 Jan 2008 16:00:02 +0000
Received: from bod-tarcila2 by FUE-EMAIL2; 31 Jan 2008 17:00:02 +0100
X-Mailer: Evolution 2.12.1 
X-OriginalArrivalTime: 31 Jan 2008 16:00:08.0728 (UTC) FILETIME=[5A558980:01C86422]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72131>

Right click on patched file list view gives "External diff" popup menu entry,
launching selected external diff tool.
The diff tool is configurable through Edit/Preference/External diff tool.

Signed-off-by: Thomas Arcila <tarcila@mc.com>
---

Hi,

Here is a patch to gitk that allows to run an external diff viewer.
It can be configured in Edit/Preferences/External diff tool.

To see the diff between two files:
- select revisions to diff
- right click on a file in the patched files list view
- choose "External diff"

Any feedback is welcome.
Thomas

 gitk |  132 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 128 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 5560e4d..6d727f4 100755
--- a/gitk
+++ b/gitk
@@ -1054,6 +1054,16 @@ proc makewindow {} {
 	-command {flist_hl 0}
     $flist_menu add command -label [mc "Highlight this only"] \
 	-command {flist_hl 1}
+    $flist_menu add command -label [mc "External diff"] \
+        -command {external_diff}
+
+    global flist_menu_tree
+    set flist_menu_tree .flistctxmenutree
+    menu $flist_menu_tree -tearoff 0
+    $flist_menu_tree add command -label [mc "Highlight this too"] \
+	-command {flist_hl 0}
+    $flist_menu_tree add command -label [mc "Highlight this only"] \
+	-command {flist_hl 1}
 }
 
 # Windows sends all mouse wheel events to the current focused window, not
@@ -1157,7 +1167,7 @@ proc savestuff {w} {
     global maxwidth showneartags showlocalchanges
     global viewname viewfiles viewargs viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
-    global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
+    global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor extdifftool
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
@@ -1182,6 +1192,7 @@ proc savestuff {w} {
 	puts $f [list set diffcolors $diffcolors]
 	puts $f [list set diffcontext $diffcontext]
 	puts $f [list set selectbgcolor $selectbgcolor]
+	puts $f [list set extdifftool $extdifftool]
 
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
@@ -1719,7 +1730,7 @@ proc sel_flist {w x y} {
 }
 
 proc pop_flist_menu {w X Y x y} {
-    global ctext cflist cmitmode flist_menu flist_menu_file
+    global ctext cflist cmitmode flist_menu flist_menu_tree flist_menu_file
     global treediffs diffids
 
     stopfinding
@@ -1732,7 +1743,11 @@ proc pop_flist_menu {w X Y x y} {
 	set e [lindex $treediffs($diffids) [expr {$l-2}]]
     }
     set flist_menu_file $e
-    tk_popup $flist_menu $X $Y
+    if {$cmitmode eq "tree"} {
+      tk_popup $flist_menu_tree $X $Y
+    } else {
+      tk_popup $flist_menu $X $Y
+    }
 }
 
 proc flist_hl {only} {
@@ -1747,6 +1762,99 @@ proc flist_hl {only} {
     set gdttype [mc "touching paths:"]
 }
 
+proc external_diff {} {
+  global gitktmpdir nullid nullid2
+  global flist_menu_file
+  global diffids
+  global diffnum
+  global gitdir extdifftool
+
+  set diffidto [lindex $diffids 0]
+
+  if {[llength $diffids] == 1} {
+    # no reference commit given
+    set diffidto [lindex $diffids 0]
+    if {$diffidto eq $nullid} {
+      # diffing working copy with index
+      set diffidfrom $nullid2
+    } elseif {$diffidto eq $nullid2} {
+      # diffing index with HEAD
+      set diffidfrom "HEAD"
+    } else {
+      # use parent commit
+      global allparents
+      set diffidfrom $allparents($diffidto)
+    }
+  } else {
+    set diffidfrom [lindex $diffids 0]
+    set diffidto [lindex $diffids 1]
+  }
+
+  if {! [info exists diffnum]} {
+    set diffnum 0
+  } else {
+    set diffnum [expr $diffnum + 1]
+  }
+
+
+  set diffdir [file join $gitktmpdir "$diffnum"]
+  set diffok "true"
+
+  file mkdir $diffdir
+  if {$diffidto eq $nullid} {
+    set difftofile [file join $gitdir ".." $flist_menu_file]
+  } elseif {$diffidto eq $nullid2} {
+    set difftofile [file join $diffdir "\[index\] [file tail $flist_menu_file]"]
+    if {[catch {exec git show :$flist_menu_file > $difftofile} err]} {
+      error_popup "\"$flist_menu_file\" [mc "cannot be found in index. \
+                  File has probably been created, deleted or renamed, \
+                  in a different commit."]"
+      set diffok "false"
+    }
+  } else {
+    set difftofile [file join $diffdir "\[$diffidto\] [file tail $flist_menu_file]"]
+    if {[catch {exec git show $diffidto:$flist_menu_file > $difftofile} err]} {
+      error_popup "\"$flist_menu_file\" [mc "cannot be found in revision"] \
+                  $diffidto. [mc "File has probably been created, \
+                  deleted or renamed, in a different commit."]"
+      set diffok "false"
+    }
+  }
+
+  if {$diffidfrom == $nullid} {
+    set difffromfile [file join $gitdir ".." $flist_menu_file]
+  } elseif {$diffidfrom == $nullid2} {
+    set difffromfile [file join $diffdir "\[index\] [file tail $flist_menu_file]"]
+    if {[catch {exec git show :$flist_menu_file > $difffromfile} err]} {
+      error_popup "\"$flist_menu_file\" [mc "cannot be found in index. \
+                  File has probably been created, deleted or renamed, \
+                  in a different commit."]"
+      set diffok "false"
+    }
+   } else {
+    set difffromfile [file join $diffdir "\[$diffidfrom\] [file tail $flist_menu_file]"]
+    if {[catch {exec git show $diffidfrom:$flist_menu_file > $difffromfile} err]} {
+      error_popup "\"$flist_menu_file\" [mc "cannot be found in revision"] \
+                  $diffidfrom. [mc "File has probably been created, \
+                  deleted or renamed, in a different commit."]"
+      set diffok "false"
+    }
+  }
+
+  if {$diffok} {
+    # here we don't use shellquote because \ and everything must be escaped and not enclosed between ''
+    set quotedextdifftool \"[string map {\" \\\" \\ \\\\ \  \\\ } $extdifftool]\"
+    set cmd [concat | $quotedextdifftool [shellarglist [list $difffromfile $difftofile]]]
+    if {[catch {set fl [open $cmd]} err]} {
+      file delete -force [ file join $gitktmpdir $diffnum ]
+      error_popup [mc "$extdifftool command failed: $err"]
+    } else {
+      fconfigure $fl -blocking 0
+      filerun $fl [list file delete -force [file join $gitktmpdir $diffnum]]
+    }
+  }
+}
+
 # Functions for adding and removing shell-type quoting
 
 proc shellquote {str} {
@@ -7802,9 +7910,13 @@ proc showtag {tag isnew} {
 
 proc doquit {} {
     global stopped
+    global gitktmpdir
+
     set stopped 100
     savestuff .
     destroy .
+
+    catch {file delete -force $gitktmpdir}
 }
 
 proc mkfontdisp {font top which} {
@@ -7933,7 +8045,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct
     global oldprefs prefstop showneartags showlocalchanges
     global bgcolor fgcolor ctext diffcolors selectbgcolor
-    global tabstop limitdiffs
+    global tabstop limitdiffs extdifftool
 
     set top .gitkprefs
     set prefstop $top
@@ -7980,6 +8092,13 @@ proc doprefs {} {
     pack $top.ldiff.b $top.ldiff.l -side left
     grid x $top.ldiff -sticky w
 
+    entry $top.extdifft -textvariable extdifftool
+    button $top.extdiffb -text [mc "External diff tool" ] -font optionfont \
+  -command {set extdifftool [tk_getOpenFile -title "External diff tool" \
+  -multiple "false"]}
+    grid x $top.extdiffb $top.extdifft -sticky w
+
+
     label $top.cdisp -text [mc "Colors: press to choose"]
     grid $top.cdisp - -sticky w -pady 10
     label $top.bg -padx 40 -relief sunk -background $bgcolor
@@ -8454,6 +8573,8 @@ set showlocalchanges 1
 set limitdiffs 1
 set datetimeformat "%Y-%m-%d %H:%M:%S"
 
+set extdifftool "meld"
+
 set colors {green red blue magenta darkgrey brown orange}
 set bgcolor white
 set fgcolor black
@@ -8507,6 +8628,9 @@ if {![file isdirectory $gitdir]} {
     exit 1
 }
 
+set gitktmpdir [file normalize [file join $gitdir ".." [format ".gitk-tmp.%s" [pid]]]]
+file mkdir $gitktmpdir
+
 set mergeonly 0
 set revtreeargs {}
 set cmdline_files {}
-- 
1.5.3.8
