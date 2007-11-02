From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH v3] Add to gitk an --argscmd flag to get the list of refs to
	draw at refresh time.
Date: Fri, 02 Nov 2007 23:24:50 +0100
Message-ID: <20071102222436.23191.91785.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Nov 02 23:31:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Io539-0007sI-Bs
	for gcvg-git-2@gmane.org; Fri, 02 Nov 2007 23:31:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752882AbXKBWbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Nov 2007 18:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752947AbXKBWbB
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Nov 2007 18:31:01 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:37333 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752870AbXKBWbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Nov 2007 18:31:00 -0400
Received: from smtp3-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 3069D17B550;
	Fri,  2 Nov 2007 23:30:59 +0100 (CET)
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id ED16D17B54C;
	Fri,  2 Nov 2007 23:30:58 +0100 (CET)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 644AA1F093;
	Fri,  2 Nov 2007 23:24:50 +0100 (CET)
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63184>

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

This version is the same as v2, just rebased on current git master.  Just let me know
if there are any issues left - notably with the concept of allowing both plain args and
argcmds.

 Documentation/gitk.txt |    7 +++++
 gitk                   |   67 ++++++++++++++++++++++++++++++++++++++----------
 2 files changed, 60 insertions(+), 14 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 8dbfb0d..c3a98d4 100644
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
index 1da0b0a..5e6af40 100755
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
 
@@ -90,13 +90,24 @@ proc start_rev_list {view} {
     set commitidx($view) 0
     set viewcomplete($view) 0
     set vnextroot($view) 0
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
 	set fd [open [concat | git log --no-color -z --pretty=raw $order --parents \
-			 --boundary $viewargs($view) "--" $viewfiles($view)] r]
+			 --boundary $args "--" $viewfiles($view)] r]
     } err]} {
 	error_popup "Error executing git rev-list: $err"
 	exit 1
@@ -1154,7 +1165,7 @@ proc savestuff {w} {
     global canv canv2 canv3 mainfont textfont uifont tabstop
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags showlocalchanges
-    global viewname viewfiles viewargs viewperm nextviewnum
+    global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment datetimeformat limitdiffs
     global colors bgcolor fgcolor diffcolors diffcontext selectbgcolor
 
@@ -1193,7 +1204,7 @@ proc savestuff {w} {
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v)]}"
+		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
 	    }
 	}
 	puts $f "}"
@@ -1849,7 +1860,7 @@ proc shellsplit {str} {
 
 proc newview {ishighlight} {
     global nextviewnum newviewname newviewperm uifont newishighlight
-    global newviewargs revtreeargs
+    global newviewargs revtreeargs viewargscmd newviewargscmd curview
 
     set newishighlight $ishighlight
     set top .gitkview
@@ -1860,13 +1871,14 @@ proc newview {ishighlight} {
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
@@ -1876,6 +1888,7 @@ proc editview {} {
     set newviewname($curview) $viewname($curview)
     set newviewperm($curview) $viewperm($curview)
     set newviewargs($curview) [shellarglist $viewargs($curview)]
+    set newviewargscmd($curview) [shellarglist $viewargscmd($curview)]
     vieweditor $top $curview "Gitk: edit view $viewname($curview)"
 }
 
@@ -1896,7 +1909,15 @@ proc vieweditor {top n title} {
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
@@ -1942,7 +1963,7 @@ proc allviewmenus {n op args} {
 proc newviewok {top n} {
     global nextviewnum newviewperm newviewname newishighlight
     global viewname viewfiles viewperm selectedview curview
-    global viewargs newviewargs viewhlmenu
+    global viewargs newviewargs viewargscmd newviewargscmd viewhlmenu
 
     if {[catch {
 	set newargs [shellsplit $newviewargs($n)]
@@ -1952,6 +1973,14 @@ proc newviewok {top n} {
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
@@ -1966,6 +1995,7 @@ proc newviewok {top n} {
 	set viewperm($n) $newviewperm($n)
 	set viewfiles($n) $files
 	set viewargs($n) $newargs
+	set viewargscmd($n) $newargscmd
 	addviewmenu $n
 	if {!$newishighlight} {
 	    run showview $n
@@ -1982,9 +2012,11 @@ proc newviewok {top n} {
 	    # doviewmenu $viewhlmenu 1 [list addvhighlight $n] \
 		# entryconf [list -label $viewname($n) -value $viewname($n)]
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
@@ -8505,18 +8537,22 @@ set mergeonly 0
 set revtreeargs {}
 set cmdline_files {}
 set i 0
+set revtreeargscmd None
 foreach arg $argv {
-    switch -- $arg {
-	"" { }
-	"-d" { set datemode 1 }
-	"--merge" {
+    switch -regexp -- $arg {
+	"^$" { }
+	"^-d$" { set datemode 1 }
+	"^--merge$" {
 	    set mergeonly 1
 	    lappend revtreeargs $arg
 	}
-	"--" {
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
@@ -8618,6 +8654,7 @@ set highlight_files {}
 set viewfiles(0) {}
 set viewperm(0) 0
 set viewargs(0) {}
+set viewargscmd(0) None
 
 set cmdlineok 0
 set stopped 0
@@ -8633,7 +8670,7 @@ tkwait visibility .
 wm title . "[file tail $argv0]: [file tail [pwd]]"
 readrefs
 
-if {$cmdline_files ne {} || $revtreeargs ne {}} {
+if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     # create a view for the files/dirs specified on the command line
     set curview 1
     set selectedview 1
@@ -8641,6 +8678,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewname(1) "Command line"
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
+    set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
     addviewmenu 1
     .bar.view entryconf Edit* -state normal
@@ -8654,6 +8692,7 @@ if {[info exists permviews]} {
 	set viewname($n) [lindex $v 0]
 	set viewfiles($n) [lindex $v 1]
 	set viewargs($n) [lindex $v 2]
+	set viewargscmd($n) [lindex $v 3]
 	set viewperm($n) 1
 	addviewmenu $n
     }
