From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v5] Add to gitk an --argscmd flag to get the list of refs to
	draw at refresh time.
Date: Thu, 21 Feb 2008 21:23:31 +0100
Message-ID: <20080221202121.22796.57651.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Feb 21 21:23:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSHx1-0004qT-2Q
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 21:23:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755642AbYBUUWu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 15:22:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755608AbYBUUWu
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 15:22:50 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:33797 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558AbYBUUWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 15:22:49 -0500
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 26CF917B5D8;
	Thu, 21 Feb 2008 21:22:47 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id DA24F17B56B;
	Thu, 21 Feb 2008 21:22:46 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 638681F025;
	Thu, 21 Feb 2008 21:23:32 +0100 (CET)
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74650>

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

I assume you did not have time to review v4 of this patch at that time
- here is an update, simply ported to master.  It works for me, let me
know if you have any remainging issues with it.


 Documentation/gitk.txt |    7 +++++++
 gitk-git/gitk          |   50 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 47 insertions(+), 10 deletions(-)
 mode change 100644 => 100755 gitk-git/gitk


diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 29edafc..2ac51bd 100644
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
diff --git a/gitk-git/gitk b/gitk-git/gitk
old mode 100644
new mode 100755
index f1f21e9..8ea89d2
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
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
 	error_popup "[mc "Error executing git rev-list:"] $err"
 	exit 1
@@ -1160,7 +1170,7 @@ proc savestuff {w} {
     global canv canv2 canv3 mainfont textfont uifont tabstop
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags showlocalchanges
-    global viewname viewfiles viewargs viewperm nextviewnum
+    global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
 
@@ -1199,7 +1209,7 @@ proc savestuff {w} {
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v)]}"
+		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
 	    }
 	}
 	puts $f "}"
@@ -1850,7 +1860,7 @@ proc shellsplit {str} {
 
 proc newview {ishighlight} {
     global nextviewnum newviewname newviewperm newishighlight
-    global newviewargs revtreeargs
+    global newviewargs revtreeargs viewargscmd newviewargscmd curview
 
     set newishighlight $ishighlight
     set top .gitkview
@@ -1861,13 +1871,14 @@ proc newview {ishighlight} {
     set newviewname($nextviewnum) "View $nextviewnum"
     set newviewperm($nextviewnum) 0
     set newviewargs($nextviewnum) [shellarglist $revtreeargs]
+    set newviewargscmd($nextviewnum) $viewargscmd($curview)
     vieweditor $top $nextviewnum [mc "Gitk view definition"]
 }
 
 proc editview {} {
     global curview
     global viewname viewperm newviewname newviewperm
-    global viewargs newviewargs
+    global viewargs newviewargs viewargscmd newviewargscmd
 
     set top .gitkvedit-$curview
     if {[winfo exists $top]} {
@@ -1877,6 +1888,7 @@ proc editview {} {
     set newviewname($curview) $viewname($curview)
     set newviewperm($curview) $viewperm($curview)
     set newviewargs($curview) [shellarglist $viewargs($curview)]
+    set newviewargscmd($curview) $viewargscmd($curview)
     vieweditor $top $curview "Gitk: edit view $viewname($curview)"
 }
 
@@ -1896,7 +1908,15 @@ proc vieweditor {top n title} {
     grid $top.al - -sticky w -pady 5
     entry $top.args -width 50 -textvariable newviewargs($n) \
 	-background $bgcolor
+
     grid $top.args - -sticky ew -padx 5
+    message $top.ac -aspect 1000 \
+	-text [mc "Command to generate more commits to include:"]
+    grid $top.ac - -sticky w -pady 5
+    entry $top.argscmd -width 50 -textvariable newviewargscmd($n) \
+	-background white
+
+    grid $top.argscmd - -sticky ew -padx 5
     message $top.l -aspect 1000 \
 	-text [mc "Enter files and directories to include, one per line:"]
     grid $top.l - -sticky w
@@ -1940,7 +1960,7 @@ proc allviewmenus {n op args} {
 proc newviewok {top n} {
     global nextviewnum newviewperm newviewname newishighlight
     global viewname viewfiles viewperm selectedview curview
-    global viewargs newviewargs viewhlmenu
+    global viewargs newviewargs viewargscmd newviewargscmd viewhlmenu
 
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
@@ -1964,6 +1984,7 @@ proc newviewok {top n} {
 	set viewperm($n) $newviewperm($n)
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
+	set viewargscmd($n) $newviewargscmd($n)
 	addviewmenu $n
 	if {!$newishighlight} {
 	    run showview $n
@@ -1980,9 +2001,11 @@ proc newviewok {top n} {
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
@@ -8522,8 +8545,9 @@ set mergeonly 0
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
@@ -8534,6 +8558,9 @@ foreach arg $argv {
 	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
 	    break
 	}
+	"--argscmd=*" {
+	    set revtreeargscmd [string range $arg 10 end]
+	}
 	default {
 	    lappend revtreeargs $arg
 	}
@@ -8635,6 +8662,7 @@ set highlight_files {}
 set viewfiles(0) {}
 set viewperm(0) 0
 set viewargs(0) {}
+set viewargscmd(0) {}
 
 set cmdlineok 0
 set stopped 0
@@ -8650,7 +8678,7 @@ tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
 readrefs
 
-if {$cmdline_files ne {} || $revtreeargs ne {}} {
+if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     # create a view for the files/dirs specified on the command line
     set curview 1
     set selectedview 1
@@ -8658,6 +8686,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewname(1) [mc "Command line"]
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
+    set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
     addviewmenu 1
     .bar.view entryconf [mc "Edit view..."] -state normal
@@ -8671,6 +8700,7 @@ if {[info exists permviews]} {
 	set viewname($n) [lindex $v 0]
 	set viewfiles($n) [lindex $v 1]
 	set viewargs($n) [lindex $v 2]
+	set viewargscmd($n) [lindex $v 3]
 	set viewperm($n) 1
 	addviewmenu $n
     }
