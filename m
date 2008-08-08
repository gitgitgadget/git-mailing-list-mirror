From: Christian Jaeger <christian@jaeger.mine.nu>
Subject: [BUG/PATCH] Revert "gitk: Arrange to kill diff-files & diff-index on quit"
Date: Fri, 8 Aug 2008 16:41:07 +0200
Message-ID: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 17:03:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRTV0-0006jB-7i
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 17:03:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007AbYHHPCX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 11:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753895AbYHHPCW
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 11:02:22 -0400
Received: from ethlife-a.ethz.ch ([129.132.49.178]:46364 "HELO ethlife.ethz.ch"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1753086AbYHHPCV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 11:02:21 -0400
Received: (qmail 2394 invoked by uid 1000); 8 Aug 2008 15:02:20 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91677>

This reverts commit e439e092b8ee5248e92ed4cb4400f9dbed70f689.

gitk would not show diffs (or trees when choosing tree view) about
half of the times it is started, it would only show the commit
messages. Sometimes it took dozens of times to get it to show a diff
again with 3 starts, then the next 2 starts not, then the next 2
starts would show it again, and so on.

Conflicts:

	gitk-git/gitk

Signed-off-by: Christian Jaeger <christian@jaeger.mine.nu>
---

This is fixing the problem for 1.6.0-rc2.

I've found the culprit with bisect, running gitk directly from the
source tree witout installation (meaning that it probably used the
1.6.0-rc2 git tools throughout the whole bisect run).

My system environment:
  Debian Lenny (testing)
  tk8.4 8.4.19-2

Thanks,
Christian.


 gitk-git/gitk |   41 +++++++++++++++++------------------------
 1 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index d093a39..5b6ab7e 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -90,15 +90,6 @@ proc dorunq {} {
     }
 }
 
-proc reg_instance {fd} {
-    global commfd leftover loginstance
-
-    set i [incr loginstance]
-    set commfd($i) $fd
-    set leftover($i) {}
-    return $i
-}
-
 proc unmerged_files {files} {
     global nr_unmerged
 
@@ -303,11 +294,11 @@ proc parseviewrevs {view revs} {
 # Start off a git log process and arrange to read its output
 proc start_rev_list {view} {
     global startmsecs commitidx viewcomplete curview
-    global tclencoding
+    global commfd leftover tclencoding
     global viewargs viewargscmd viewfiles vfilelimit
     global showlocalchanges commitinterest
-    global viewactive viewinstances vmergeonly
-    global mainheadid
+    global viewactive loginstance viewinstances vmergeonly
+    global pending_select mainheadid
     global vcanopt vflags vrevs vorigargs
 
     set startmsecs [clock clicks -milliseconds]
@@ -363,8 +354,10 @@ proc start_rev_list {view} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return 0
     }
-    set i [reg_instance $fd]
+    set i [incr loginstance]
     set viewinstances($view) [list $i]
+    set commfd($i) $fd
+    set leftover($i) {}
     if {$showlocalchanges && $mainheadid ne {}} {
 	lappend commitinterest($mainheadid) {dodiffindex}
     }
@@ -440,8 +433,8 @@ proc getcommits {selid} {
 
 proc updatecommits {} {
     global curview vcanopt vorigargs vfilelimit viewinstances
-    global viewactive viewcomplete tclencoding
-    global startmsecs showneartags showlocalchanges
+    global viewactive viewcomplete loginstance tclencoding
+    global startmsecs commfd showneartags showlocalchanges leftover
     global mainheadid pending_select
     global isworktree
     global varcid vposids vnegids vflags vrevs
@@ -502,8 +495,10 @@ proc updatecommits {} {
     if {$viewactive($view) == 0} {
 	set startmsecs [clock clicks -milliseconds]
     }
-    set i [reg_instance $fd]
+    set i [incr loginstance]
     lappend viewinstances($view) $i
+    set commfd($i) $fd
+    set leftover($i) {}
     fconfigure $fd -blocking 0 -translation lf -eofchar {}
     if {$tclencoding != {}} {
 	fconfigure $fd -encoding $tclencoding
@@ -4091,11 +4086,10 @@ proc dodiffindex {} {
     incr lserial
     set fd [open "|git diff-index --cached HEAD" r]
     fconfigure $fd -blocking 0
-    set i [reg_instance $fd]
-    filerun $fd [list readdiffindex $fd $lserial $i]
+    filerun $fd [list readdiffindex $fd $lserial]
 }
 
-proc readdiffindex {fd serial inst} {
+proc readdiffindex {fd serial} {
     global mainheadid nullid nullid2 curview commitinfo commitdata lserial
 
     set isdiff 1
@@ -4106,7 +4100,7 @@ proc readdiffindex {fd serial inst} {
 	set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
-    stop_instance $inst
+    close $fd
 
     if {$serial != $lserial} {
 	return 0
@@ -4115,8 +4109,7 @@ proc readdiffindex {fd serial inst} {
     # now see if there are any local changes not checked in to the index
     set fd [open "|git diff-files" r]
     fconfigure $fd -blocking 0
-    set i [reg_instance $fd]
-    filerun $fd [list readdifffiles $fd $serial $i]
+    filerun $fd [list readdifffiles $fd $serial]
 
     if {$isdiff && ![commitinview $nullid2 $curview]} {
 	# add the line for the changes in the index to the graph
@@ -4133,7 +4126,7 @@ proc readdiffindex {fd serial inst} {
     return 0
 }
 
-proc readdifffiles {fd serial inst} {
+proc readdifffiles {fd serial} {
     global mainheadid nullid nullid2 curview
     global commitinfo commitdata lserial
 
@@ -4145,7 +4138,7 @@ proc readdifffiles {fd serial inst} {
 	set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
-    stop_instance $inst
+    close $fd
 
     if {$serial != $lserial} {
 	return 0
-- 
1.6.0.rc2.1.g42d19
