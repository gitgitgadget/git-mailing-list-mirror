From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v3] Add to gitk an --argscmd flag to get the list of refs to
	draw at refresh time.
Date: Sun, 29 Jul 2007 14:17:47 +0200
Message-ID: <20070729121123.3262.38879.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sun Jul 29 14:18:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF7jY-0004SH-4A
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 14:18:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760024AbXG2MSs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 08:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759463AbXG2MSs
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 08:18:48 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:44948 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758952AbXG2MSq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 08:18:46 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A0BC159FE1;
	Sun, 29 Jul 2007 14:18:45 +0200 (CEST)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 719FD83A6;
	Sun, 29 Jul 2007 14:18:45 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 180921F162;
	Sun, 29 Jul 2007 14:17:48 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54110>

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

This is a rebase to current git master.  It happens that I had to
revert 2 code simplifications you did under "Improve handling of --
and ambiguous arguments", which my patch happens to rely on in its
current form.

 Documentation/gitk.txt |    7 +++++
 gitk                   |   65 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 59 insertions(+), 13 deletions(-)

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
index f74ce51..264500f 100755
--- a/gitk
+++ b/gitk
@@ -82,18 +82,29 @@ proc dorunq {} {
 proc start_rev_list {view} {
     global startmsecs
     global commfd leftover tclencoding datemode
-    global viewargs viewfiles commitidx
+    global viewargs viewargscmd viewfiles commitidx
     global lookingforhead showlocalchanges
 
     set startmsecs [clock clicks -milliseconds]
     set commitidx($view) 0
+    set args $viewargs($view)
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
     set order "--topo-order"
     if {$datemode} {
 	set order "--date-order"
     }
     if {[catch {
 	set fd [open [concat | git log -z --pretty=raw $order --parents \
-			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
+			 --boundary $args "--" $viewfiles($view)] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
 	exit 1
@@ -966,7 +977,7 @@ proc savestuff {w} {
     global canv canv2 canv3 ctext cflist mainfont textfont uifont tabstop
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags showlocalchanges
-    global viewname viewfiles viewargs viewperm nextviewnum
+    global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment
     global colors bgcolor fgcolor diffcolors selectbgcolor
 
@@ -1002,7 +1013,7 @@ proc savestuff {w} {
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v)]}"
+		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
 	    }
 	}
 	puts $f "}"
@@ -1597,7 +1608,7 @@ proc shellsplit {str} {
 
 proc newview {ishighlight} {
     global nextviewnum newviewname newviewperm uifont newishighlight
-    global newviewargs revtreeargs
+    global newviewargs revtreeargs viewargscmd newviewargscmd curview
 
     set newishighlight $ishighlight
     set top .gitkview
@@ -1608,13 +1619,14 @@ proc newview {ishighlight} {
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
@@ -1624,6 +1636,7 @@ proc editview {} {
     set newviewname($curview) $viewname($curview)
     set newviewperm($curview) $viewperm($curview)
     set newviewargs($curview) [shellarglist $viewargs($curview)]
+    set newviewargscmd($curview) [shellarglist $viewargscmd($curview)]
     vieweditor $top $curview "Gitk: edit view $viewname($curview)"
 }
 
@@ -1644,7 +1657,15 @@ proc vieweditor {top n title} {
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
@@ -1690,7 +1711,7 @@ proc allviewmenus {n op args} {
 proc newviewok {top n} {
     global nextviewnum newviewperm newviewname newishighlight
     global viewname viewfiles viewperm selectedview curview
-    global viewargs newviewargs viewhlmenu
+    global viewargs newviewargs viewargscmd newviewargscmd viewhlmenu
 
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
@@ -1700,6 +1721,14 @@ proc newviewok {top n} {
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
@@ -1714,6 +1743,7 @@ proc newviewok {top n} {
 	set viewperm($n) $newviewperm($n)
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
+	set viewargscmd($n) $newargscmd
 	addviewmenu $n
 	if {!$newishighlight} {
 	    run showview $n
@@ -1730,9 +1760,11 @@ proc newviewok {top n} {
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
@@ -7584,14 +7616,18 @@ if {![file isdirectory $gitdir]} {
 set revtreeargs {}
 set cmdline_files {}
 set i 0
+set revtreeargscmd None
 foreach arg $argv {
-    switch -- $arg {
-	"" { }
-	"-d" { set datemode 1 }
-	"--" {
+    switch -regexp -- $arg {
+	"^$" { }
+	"^-d" { set datemode 1 }
+	"^--$" {
 	    set cmdline_files [lrange $argv [expr {$i + 1}] end]
 	    break
 	}
+	"^--argscmd=" {
+	    regexp {^--argscmd=(.*)} $arg match revtreeargscmd
+	}
 	default {
 	    lappend revtreeargs $arg
 	}
@@ -7653,6 +7689,7 @@ set selectedhlview None
 set viewfiles(0) {}
 set viewperm(0) 0
 set viewargs(0) {}
+set viewargscmd(0) None
 
 set cmdlineok 0
 set stopped 0
@@ -7669,7 +7706,7 @@ tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
 readrefs
 
-if {$cmdline_files ne {} || $revtreeargs ne {}} {
+if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     # create a view for the files/dirs specified on the command line
     set curview 1
     set selectedview 1
@@ -7677,6 +7714,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewname(1) "Command line"
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
+    set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
     addviewmenu 1
     .bar.view entryconf Edit* -state normal
@@ -7690,6 +7728,7 @@ if {[info exists permviews]} {
 	set viewname($n) [lindex $v 0]
 	set viewfiles($n) [lindex $v 1]
 	set viewargs($n) [lindex $v 2]
+	set viewargscmd($n) [lindex $v 3]
 	set viewperm($n) 1
 	addviewmenu $n
     }
