From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Fix gitk this->selected diffs
Date: Sun, 27 Nov 2005 23:29:30 +0100
Message-ID: <20051127222929.GM3393@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 27 23:28:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgUzb-0000WQ-HT
	for gcvg-git@gmane.org; Sun, 27 Nov 2005 23:27:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVK0W12 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Nov 2005 17:27:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751164AbVK0W12
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Nov 2005 17:27:28 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:9454 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751163AbVK0W11 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Nov 2005 17:27:27 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 577DB5230B;
	Sun, 27 Nov 2005 23:27:26 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EgV1W-00018y-Em; Sun, 27 Nov 2005 23:29:30 +0100
To: GIT list <git@vger.kernel.org>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12832>

The change made in 8b7e5d76e836396a097bb6f61cf930ea872a7bd3 to
accomodate dense revlists in single-commit diffs has broken computing
of diffs between arbitrary trees, which does need to consider two
commit ids.

This patch changes the two git-diff-tree calls to get the necessary
two ids in this case.  It does so by propagating a "singlecommit" flag
through all functions involved via an additional argument.

Signed-off-by: Yann Dirson <ydirson@altern.org>

---

this->selected diffs have been broken for a month now - I'd like it to
get fixed before 1.0 :)

A previous version of this patch was sent under the 'Make "gitk" work
better with dense revlists' thread.  I have done some minor cleanups
to it.  I'm still not comfortable with the number of funcs I had to
touch to propagate the information - any better idea ?

 gitk |   53 ++++++++++++++++++++++++++++++++---------------------
 1 files changed, 32 insertions(+), 21 deletions(-)

applies-to: 1dc0816b6c98ef90985d2761f1ab80739e4fbc7d
4664daceca4faac92f0e15d3e80824f172192d84
diff --git a/gitk b/gitk
index 3dd97e2..4841a80 100755
--- a/gitk
+++ b/gitk
@@ -2164,9 +2164,9 @@ proc selectline {l isnew} {
     $cflist delete 0 end
     $cflist insert end "Comments"
     if {$nparents($id) == 1} {
-	startdiff [concat $id $parents($id)]
+	startdiff [concat $id $parents($id)] 1
     } elseif {$nparents($id) > 1} {
-	mergediff $id
+	mergediff $id 1
     }
 }
 
@@ -2235,7 +2235,7 @@ proc goforw {} {
     }
 }
 
-proc mergediff {id} {
+proc mergediff {id singlecommit} {
     global parents diffmergeid diffmergegca mergefilelist diffpindex
 
     set diffmergeid $id
@@ -2246,7 +2246,7 @@ proc mergediff {id} {
 	    showmergediff
 	}
     } else {
-	contmergediff {}
+	contmergediff {} $singlecommit
     }
 }
 
@@ -2266,7 +2266,7 @@ proc findgca {ids} {
     return $gca
 }
 
-proc contmergediff {ids} {
+proc contmergediff {ids singlecommit} {
     global diffmergeid diffpindex parents nparents diffmergegca
     global treediffs mergefilelist diffids treepending
 
@@ -2283,7 +2283,7 @@ proc contmergediff {ids} {
 	if {![info exists treediffs($ids)]} {
 	    set diffids $ids
 	    if {![info exists treepending]} {
-		gettreediffs $ids
+		gettreediffs $ids $singlecommit
 	    }
 	    return
 	}
@@ -2761,39 +2761,45 @@ proc similarity {pnum l nlc f events} {
     return [expr {200 * $same / (2 * $same + $diff)}]
 }
 
-proc startdiff {ids} {
+proc startdiff {ids singlecommit} {
     global treediffs diffids treepending diffmergeid
 
     set diffids $ids
     catch {unset diffmergeid}
     if {![info exists treediffs($ids)]} {
 	if {![info exists treepending]} {
-	    gettreediffs $ids
+	    gettreediffs $ids $singlecommit
 	}
     } else {
-	addtocflist $ids
+	addtocflist $ids $singlecommit
     }
 }
 
-proc addtocflist {ids} {
+proc addtocflist {ids singlecommit} {
     global treediffs cflist
     foreach f $treediffs($ids) {
 	$cflist insert end $f
     }
-    getblobdiffs $ids
+    getblobdiffs $ids $singlecommit
 }
 
-proc gettreediffs {ids} {
+proc gettreediffs {ids singlecommit} {
     global treediff parents treepending
     set treepending $ids
     set treediff {}
     set id [lindex $ids 0]
-    if [catch {set gdtf [open "|git-diff-tree --no-commit-id -r $id" r]}] return
+    if {$singlecommit == 1} {
+	set range "$id"
+    } else {
+	set p [lindex $ids 1]
+	set range "$p $id"
+    }
+    if [catch {set gdtf [open "|git-diff-tree --no-commit-id -r $range" r]}] return
     fconfigure $gdtf -blocking 0
-    fileevent $gdtf readable [list gettreediffline $gdtf $ids]
+    fileevent $gdtf readable [list gettreediffline $gdtf $ids $singlecommit]
 }
 
-proc gettreediffline {gdtf ids} {
+proc gettreediffline {gdtf ids singlecommit} {
     global treediff treediffs treepending diffids diffmergeid
 
     set n [gets $gdtf line]
@@ -2803,12 +2809,12 @@ proc gettreediffline {gdtf ids} {
 	set treediffs($ids) $treediff
 	unset treepending
 	if {$ids != $diffids} {
-	    gettreediffs $diffids
+	    gettreediffs $diffids $singlecommit
 	} else {
 	    if {[info exists diffmergeid]} {
-		contmergediff $ids
+		contmergediff $ids $singlecommit
 	    } else {
-		addtocflist $ids
+		addtocflist $ids $singlecommit
 	    }
 	}
 	return
@@ -2817,13 +2823,18 @@ proc gettreediffline {gdtf ids} {
     lappend treediff $file
 }
 
-proc getblobdiffs {ids} {
+proc getblobdiffs {ids singlecommit} {
     global diffopts blobdifffd diffids env curdifftag curtagstart
     global difffilestart nextupdate diffinhdr treediffs
 
     set id [lindex $ids 0]
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [list | git-diff-tree --no-commit-id -r -p -C $id]
+    if {$singlecommit == 1} {
+	set cmd [list | git-diff-tree --no-commit-id -r -p -C $id]
+    } else {
+	set p [lindex $ids 1]
+	set cmd [list | git-diff-tree --no-commit-id -r -p -C $p $id]
+    }
     if {[catch {set bdf [open $cmd r]} err]} {
 	puts "error getting diffs: $err"
 	return
@@ -3340,7 +3351,7 @@ proc doseldiff {oldid newid} {
     $ctext conf -state disabled
     $ctext tag delete Comments
     $ctext tag remove found 1.0 end
-    startdiff [list $newid $oldid]
+    startdiff [list $newid $oldid] 0
 }
 
 proc mkpatch {} {
---
0.99.9.GIT

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
