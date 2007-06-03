From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Add to gitk an --argscmd flag to get the list of refs to draw
	at refresh time.
Date: Mon, 04 Jun 2007 00:49:50 +0200
Message-ID: <20070603224449.29875.24010.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Mon Jun 04 00:50:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Huytg-0003Fp-Gt
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 00:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750915AbXFCWtv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 18:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751051AbXFCWtv
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 18:49:51 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:37943 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbXFCWtu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 18:49:50 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 93B555A13E;
	Mon,  4 Jun 2007 00:49:49 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 7E0741F019;
	Mon,  4 Jun 2007 00:49:50 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49045>

This flag is meant for porcelains which can modify the list of
meaningful refs to graph.  It allows gitk's refresh operation to be
always up-to-date wrt the list of refs to graph.

Primary target is stg-gitk (in StGIT contrib/ dir), which requests
gitk to graph all patches in a stack: patches can be created and
deleted, so we need a way to tell gitk that something has changed.


This patch does not allow setting this parameter in a saved profile,
although it reserves a slot in the savefile format, and will read it
when it finds one.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 Documentation/gitk.txt |    6 ++++++
 gitk                   |   28 +++++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 48c5894..21d002b 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -41,6 +41,12 @@ frequently used options.
 
 	Show all branches.
 
+--argscmd=<command>::
+	Command to be run each time gitk has to determine the list of
+	<revs> to show.  Use this instead of explicitely specifying
+	<revs> if the list of commits to show may vary between
+	refreshs.
+
 <revs>::
 
 	Limit the revisions to show. This can be either a single revision
diff --git a/gitk b/gitk
index a57e84c..6d4d10a 100755
--- a/gitk
+++ b/gitk
@@ -19,12 +19,23 @@ proc gitdir {} {
 proc start_rev_list {view} {
     global startmsecs nextupdate
     global commfd leftover tclencoding datemode
-    global viewargs viewfiles commitidx
+    global viewargs viewargscmd viewfiles commitidx
 
     set startmsecs [clock clicks -milliseconds]
     set nextupdate [expr {$startmsecs + 100}]
     set commitidx($view) 0
-    set args $viewargs($view)
+    if {$viewargscmd($view) ne "None"} {
+	if {[catch {
+	    set fd [open [concat | $viewargscmd($view)] r]
+	} err]} {
+	    puts stderr "Error executing --argscmd command: $err"
+	    exit 1
+	}
+	set args [read $fd 500000]
+	close $fd
+    } else {
+	set args $viewargs($view)
+    }
     if {$viewfiles($view) ne {}} {
 	set args [concat $args "--" $viewfiles($view)]
     }
@@ -823,7 +834,7 @@ proc savestuff {w} {
     global canv canv2 canv3 ctext cflist mainfont textfont uifont
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags
-    global viewname viewfiles viewargs viewperm nextviewnum
+    global viewname viewfiles viewargs viewargscmd viewperm nextviewnum
     global cmitmode wrapcomment
     global colors bgcolor fgcolor diffcolors
 
@@ -856,7 +867,7 @@ proc savestuff {w} {
 	puts -nonewline $f "set permviews {"
 	for {set v 0} {$v < $nextviewnum} {incr v} {
 	    if {$viewperm($v)} {
-		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v)]}"
+		puts $f "{[list $viewname($v) $viewfiles($v) $viewargs($v) $viewargscmd($v)]}"
 	    }
 	}
 	puts $f "}"
@@ -6298,10 +6309,14 @@ catch {source ~/.gitk}
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
@@ -6357,6 +6372,7 @@ set selectedhlview None
 set viewfiles(0) {}
 set viewperm(0) 0
 set viewargs(0) {}
+set viewargscmd(0) None
 
 set cmdlineok 0
 set stopped 0
@@ -6367,7 +6383,7 @@ makewindow
 wm title . "[file tail $argv0]: [file tail [pwd]]"
 readrefs
 
-if {$cmdline_files ne {} || $revtreeargs ne {}} {
+if {$cmdline_files ne {} || $revtreeargs ne {} || $revtreeargscmd ne {}} {
     # create a view for the files/dirs specified on the command line
     set curview 1
     set selectedview 1
@@ -6375,6 +6391,7 @@ if {$cmdline_files ne {} || $revtreeargs ne {}} {
     set viewname(1) "Command line"
     set viewfiles(1) $cmdline_files
     set viewargs(1) $revtreeargs
+    set viewargscmd(1) $revtreeargscmd
     set viewperm(1) 0
     addviewmenu 1
     .bar.view entryconf Edit* -state normal
@@ -6388,6 +6405,7 @@ if {[info exists permviews]} {
 	set viewname($n) [lindex $v 0]
 	set viewfiles($n) [lindex $v 1]
 	set viewargs($n) [lindex $v 2]
+	set viewargscmd($n) [lindex $v 3]
 	set viewperm($n) 1
 	addviewmenu $n
     }
