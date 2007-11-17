From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v4] Add to gitk an --argscmd flag to get the list of refs to
	draw at refresh time.
Date: Sat, 17 Nov 2007 20:58:35 +0100
Message-ID: <20071117195809.8490.14788.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Nov 17 20:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItTpL-0003aK-3w
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 20:59:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761980AbXKQT7X (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 14:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762049AbXKQT7W
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 14:59:22 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:37211 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761794AbXKQT7V (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 14:59:21 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 7D22017B593;
	Sat, 17 Nov 2007 20:59:20 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 4D0C217B590;
	Sat, 17 Nov 2007 20:59:20 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id C70351F03E;
	Sat, 17 Nov 2007 20:58:35 +0100 (CET)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65301>

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

 Documentation/gitk.txt |    7 +++++++
 gitk                   |   50 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 10 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 8dbfb0d..f1f3410 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -41,6 +41,13 @@ frequently used options.
 
 	Show all branches.
 
+--argscmd=<command>::
+	Command to be run each time gitk has to determine the list of
+	<revs> to show.  The command is expected to print on its standard
+	output a list of additional revs to be shown, one per line.
+	Use this instead of explicitly specifying <revs> if the set of
+	commits to show may vary between refreshes.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
diff --git a/gitk b/gitk
index 1da0b0a..aba9100 100755
--- a/gitk
+++ b/gitk
@@ -82,7 +82,7 @@ proc dorunq {} {
 proc start_rev_list {view} {
     global startmsecs
     global commfd leftover tclencoding datemode
-    global viewargs viewfiles commitidx viewcomplete vnextroot
+    global viewargs viewargscmd viewfiles commitidx viewcomplete vnextroot
     global showlocalchanges commitinterest mainheadid
     global progressdirn progresscoords proglastnc curview
 
@@ -90,13 +90,23 @@ proc start_rev_list {view} {
     set commitidx($view) 0
     set viewcomplete($view) 0
     set vnextroot($view) 0
+    set args $viewargs($view)
+    if {$viewargscmd($view) ne {}} {
+	if {[catch {
+	    set str [exec sh -c $viewargscmd($view)]
+	} err]} {
+	    error_popup "Error executing --argscmd command: $err"
+	    exit 1
+	}
+	set args [concat $args [split $str "\n"]]
+    }
     set order "--topo-order"
     if {$datemode} {
 	set order "--date-order"
     }
     if {[catch {
 	set fd [open [concat | git log --no-color -z --pretty=raw $order --parents \
-			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
+			 --boundary $args "--" $viewfiles($view)] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
 	exit 1
@@ -1154,7 +1164,7 @@ proc savestuff {w} {
     global canv canv2 canv3 mainfont textfont uifont tabstop
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags showlocalchanges
-    global viewname viewfiles viewargs viewperm nextviewnum
+    global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
 
@@ -1193,7 +1203,7 @@ proc savestuff {w} {
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v)]}"
+		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
 	    }
 	}
 	puts $f "}"
@@ -1849,7 +1859,7 @@ proc shellsplit {str} {
 
 proc newview {ishighlight} {
     global nextviewnum newviewname newviewperm uifont newishighlight
-    global newviewargs revtreeargs
+    global newviewargs revtreeargs viewargscmd newviewargscmd curview
 
     set newishighlight $ishighlight
     set top .gitkview
@@ -1860,13 +1870,14 @@ proc newview {ishighlight} {
     set newviewname($nextviewnum) "View $nextviewnum"
     set newviewperm($nextviewnum) 0
     set newviewargs($nextviewnum) [shellarglist $revtreeargs]
+    set newviewargscmd($nextviewnum) $viewargscmd($curview)
     vieweditor $top $nextviewnum "Gitk view definition"
 }
 
 proc editview {} {
     global curview
     global viewname viewperm newviewname newviewperm
-    global viewargs newviewargs
+    global viewargs newviewargs viewargscmd newviewargscmd
 
     set top .gitkvedit-$curview
     if {[winfo exists $top]} {
@@ -1876,6 +1887,7 @@ proc editview {} {
     set newviewname($curview) $viewname($curview)
     set newviewperm($curview) $viewperm($curview)
     set newviewargs($curview) [shellarglist $viewargs($curview)]
+    set newviewargscmd($curview) $viewargscmd($curview)
     vieweditor $top $curview "Gitk: edit view $viewname($curview)"
 }
 
@@ -1896,7 +1908,15 @@ proc vieweditor {top n title} {
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
 	-background white -font uifont
+
     grid $top.args - -sticky ew -padx 5
+    message $top.ac -aspect 1000 -font uifont \
+	-text "Command to generate more commits to include:"
+    grid $top.ac - -sticky w -pady 5
+    entry $top.argscmd -width 50 -textvariable newviewargscmd($n) \
+	-background white -font uifont
+
+    grid $top.argscmd - -sticky ew -padx 5
     message $top.l -aspect 1000 -font uifont \
 	-text "Enter files and directories to include, one per line:"
     grid $top.l - -sticky w
@@ -1942,7 +1962,7 @@ proc allviewmenus {n op args} {
 proc newviewok {top n} {
     global nextviewnum newviewperm newviewname newishighlight
     global viewname viewfiles viewperm selectedview curview
-    global viewargs newviewargs viewhlmenu
+    global viewargs newviewargs viewargscmd newviewargscmd viewhlmenu
 
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
@@ -1966,6 +1986,7 @@ proc newviewok {top n} {
 	set viewperm($n) $newviewperm($n)
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
+	set viewargscmd($n) $newviewargscmd($n)
 	addviewmenu $n
 	if {!$newishighlight} {
 	    run showview $n
@@ -1982,9 +2003,11 @@ proc newviewok {top n} {
 	    # doviewmenu $viewhlmenu 1 [list addvhighlight $n] \
 		# entryconf [list -label $viewname($n) -value $viewname($n)]
 	}
-	if {$files ne $viewfiles($n) || $newargs ne $viewargs($n)} {
+	if {$files ne $viewfiles($n) || $newargs ne $viewargs($n) || \
+		$newviewargscmd($n) ne $viewargscmd($n)} {
 	    set viewfiles($n) $files
 	    set viewargs($n) $newargs
+	    set viewargscmd($n) $newviewargscmd($n)
 	    if {$curview == $n} {
 		run updatecommits
 	    }
@@ -8505,8 +8528,9 @@ set mergeonly 0
 set revtreeargs {}
 set cmdline_files {}
 set i 0
+set revtreeargscmd {}
 foreach arg $argv {
-    switch -- $arg {
+    switch -glob -- $arg {
 	"" { }
 	"-d" { set datemode 1 }
 	"--merge" {
@@ -8517,6 +8541,9 @@ foreach arg $argv {
 	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
 	    break
 	}
+	"--argscmd=*" {
+	    set revtreeargscmd [string range $arg 10 end]
+	}
 	default {
 	    lappend revtreeargs $arg
 	}
@@ -8618,6 +8645,7 @@ set highlight_files {}
 set viewfiles(0) {}
 set viewperm(0) 0
 set viewargs(0) {}
+set viewargscmd(0) {}
 
 set cmdlineok 0
 set stopped 0
@@ -8633,7 +8661,7 @@ tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
 readrefs
 
-if {$cmdline_files ne {} || $revtreeargs ne {}} {
+if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     # create a view for the files/dirs specified on the command line
     set curview 1
     set selectedview 1
@@ -8641,6 +8669,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewname(1) "Command line"
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
+    set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
     addviewmenu 1
     .bar.view entryconf Edit* -state normal
@@ -8654,6 +8683,7 @@ if {[info exists permviews]} {
 	set viewname($n) [lindex $v 0]
 	set viewfiles($n) [lindex $v 1]
 	set viewargs($n) [lindex $v 2]
+	set viewargscmd($n) [lindex $v 3]
 	set viewperm($n) 1
 	addviewmenu $n
     }
