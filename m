From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add to gitk an --argscmd flag to get the list of refs to draw
	at refresh time.
Date: Fri, 13 Jul 2007 00:04:40 +0200
Message-ID: <20070712220411.31743.83101.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Fri Jul 13 00:06:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I96mm-0001vO-Kh
	for gcvg-git@gmane.org; Fri, 13 Jul 2007 00:05:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759635AbXGLWFR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 18:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759342AbXGLWFR
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 18:05:17 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59213 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752476AbXGLWFQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 18:05:16 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6A2165A229;
	Fri, 13 Jul 2007 00:05:14 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 15BBB1F162;
	Fri, 13 Jul 2007 00:04:41 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52339>

This allows to display a set of refs, when the refs in the set may
themselves change between two refresh operations (eg. the set of
patches in a patch stack), and is expected to be called from other
porcelain suites.

The command is expected to generate a list of commits, which will be
appended to the commits litterally passed on the command-line.  That
command is handled similarly to the litteral refs, and has its own
field in the saved view, and an edit field in the view editor.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

This new version causes the command to add its revs to the litteral
ones from command-line instead of overriding them, and allows to
edit the command in the view editor.

Disclaimer: I'm no tcl/tk expert, feel free to flame my style :)

 Documentation/gitk.txt |    7 ++++++
 gitk                   |   54 +++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 8 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index e9f82b9..71ed8ba 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -41,6 +41,13 @@ frequently used options.
 
 	Show all branches.
 
+--argscmd=<command>::
+	Command to be run each time gitk has to determine the list of
+	<revs> to show.  The command is expected to print on its
+	standard output a list of additional revs to be shown.  Use
+	this instead of explicitely specifying <revs> if the set of
+	commits to show may vary between refreshs.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
diff --git a/gitk b/gitk
index 2d6a6ef..4b6d31b 100755
--- a/gitk
+++ b/gitk
@@ -82,12 +82,22 @@ proc dorunq {} {
 proc start_rev_list {view} {
     global startmsecs
     global commfd leftover tclencoding datemode
-    global viewargs viewfiles commitidx
+    global viewargs viewargscmd viewfiles commitidx
     global lookingforhead showlocalchanges
 
     set startmsecs [clock clicks -milliseconds]
     set commitidx($view) 0
     set args $viewargs($view)
+    if {$viewargscmd($view) ne "None"} {
+	if {[catch {
+	    set fd [open [concat | $viewargscmd($view)] r]
+	} err]} {
+	    puts stderr "Error executing --argscmd command: $err"
+	    exit 1
+	}
+	set args [concat $args [read $fd 500000]]
+	close $fd
+    }
     if {$viewfiles($view) ne {}} {
 	set args [concat $args "--" $viewfiles($view)]
     }
@@ -943,7 +953,7 @@ proc savestuff {w} {
     global canv canv2 canv3 ctext cflist mainfont textfont uifont tabstop
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags showlocalchanges
-    global viewname viewfiles viewargs viewperm nextviewnum
+    global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment
     global colors bgcolor fgcolor diffcolors selectbgcolor
 
@@ -979,7 +989,7 @@ proc savestuff {w} {
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v)]}"
+		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
 	    }
 	}
 	puts $f "}"
@@ -1566,7 +1576,7 @@ proc shellsplit {str} {
 
 proc newview {ishighlight} {
     global nextviewnum newviewname newviewperm uifont newishighlight
-    global newviewargs revtreeargs
+    global newviewargs revtreeargs viewargscmd newviewargscmd curview
 
     set newishighlight $ishighlight
     set top .gitkview
@@ -1577,13 +1587,14 @@ proc newview {ishighlight} {
     set newviewname($nextviewnum) "View $nextviewnum"
     set newviewperm($nextviewnum) 0
     set newviewargs($nextviewnum) [shellarglist $revtreeargs]
+    set newviewargscmd($nextviewnum) [shellarglist $viewargscmd($curview)]
     vieweditor $top $nextviewnum "Gitk view definition"
 }
 
 proc editview {} {
     global curview
     global viewname viewperm newviewname newviewperm
-    global viewargs newviewargs
+    global viewargs newviewargs viewargscmd newviewargscmd
 
     set top .gitkvedit-$curview
     if {[winfo exists $top]} {
@@ -1593,6 +1604,7 @@ proc editview {} {
     set newviewname($curview) $viewname($curview)
     set newviewperm($curview) $viewperm($curview)
     set newviewargs($curview) [shellarglist $viewargs($curview)]
+    set newviewargscmd($curview) [shellarglist $viewargscmd($curview)]
     vieweditor $top $curview "Gitk: edit view $viewname($curview)"
 }
 
@@ -1613,7 +1625,15 @@ proc vieweditor {top n title} {
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
 	-background white -font $uifont
+
     grid $top.args - -sticky ew -padx 5
+    message $top.ac -aspect 1000 -font $uifont \
+	-text "Command to generate more commits to include:"
+    grid $top.ac - -sticky w -pady 5
+    entry $top.argscmd -width 50 -textvariable newviewargscmd($n) \
+	-background white -font $uifont
+
+    grid $top.argscmd - -sticky ew -padx 5
     message $top.l -aspect 1000 -font $uifont \
 	-text "Enter files and directories to include, one per line:"
     grid $top.l - -sticky w
@@ -1659,7 +1679,7 @@ proc allviewmenus {n op args} {
 proc newviewok {top n} {
     global nextviewnum newviewperm newviewname newishighlight
     global viewname viewfiles viewperm selectedview curview
-    global viewargs newviewargs viewhlmenu
+    global viewargs newviewargs viewargscmd newviewargscmd viewhlmenu
 
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
@@ -1669,6 +1689,14 @@ proc newviewok {top n} {
 	focus $top
 	return
     }
+    if {[catch {
+	set newargscmd [shellsplit $newviewargscmd($n)]
+    } err]} {
+	error_popup "Error in commit selection command: $err"
+	wm raise $top
+	focus $top
+	return
+    }
     set files {}
     foreach f [split [$top.t get 0.0 end] "\n"] {
 	set ft [string trim $f]
@@ -1683,6 +1711,7 @@ proc newviewok {top n} {
 	set viewperm($n) $newviewperm($n)
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
+	set viewargscmd($n) $newargscmd
 	addviewmenu $n
 	if {!$newishighlight} {
 	    run showview $n
@@ -1699,9 +1728,11 @@ proc newviewok {top n} {
 	    doviewmenu $viewhlmenu 1 [list addvhighlight $n] \
 		entryconf [list -label $viewname($n) -value $viewname($n)]
 	}
-	if {$files ne $viewfiles($n) || $newargs ne $viewargs($n)} {
+	if {$files ne $viewfiles($n) || $newargs ne $viewargs($n) || \
+		$newargscmd ne $viewargscmd($n)} {
 	    set viewfiles($n) $files
 	    set viewargs($n) $newargs
+	    set viewargscmd($n) $newargscmd
 	    if {$curview == $n} {
 		run updatecommits
 	    }
@@ -7419,10 +7450,14 @@ catch {source ~/.gitk}
 font create optionfont -family sans-serif -size -12
 
 set revtreeargs {}
+set revtreeargscmd None
 foreach arg $argv {
     switch -regexp -- $arg {
 	"^$" { }
 	"^-d" { set datemode 1 }
+	"^--argscmd=" {
+	    regexp {^--argscmd=(.*)} $arg match revtreeargscmd
+	}
 	default {
 	    lappend revtreeargs $arg
 	}
@@ -7481,6 +7516,7 @@ set selectedhlview None
 set viewfiles(0) {}
 set viewperm(0) 0
 set viewargs(0) {}
+set viewargscmd(0) None
 
 set cmdlineok 0
 set stopped 0
@@ -7494,7 +7530,7 @@ makewindow
 wm title . "[file tail $argv0]: [file tail [pwd]]"
 readrefs
 
-if {$cmdline_files ne {} || $revtreeargs ne {}} {
+if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     # create a view for the files/dirs specified on the command line
     set curview 1
     set selectedview 1
@@ -7502,6 +7538,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewname(1) "Command line"
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
+    set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
     addviewmenu 1
     .bar.view entryconf Edit* -state normal
@@ -7515,6 +7552,7 @@ if {[info exists permviews]} {
 	set viewname($n) [lindex $v 0]
 	set viewfiles($n) [lindex $v 1]
 	set viewargs($n) [lindex $v 2]
+	set viewargscmd($n) [lindex $v 3]
 	set viewperm($n) 1
 	addviewmenu $n
     }
