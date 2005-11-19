From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH, take 2] Re: Make "gitk" work better with dense revlists
Date: Sat, 19 Nov 2005 23:48:20 +0100
Message-ID: <20051119224819.GG3393@nowhere.earth>
References: <20051115225740.GB28173@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Nov 19 23:47:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdbTy-0007TR-Iy
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 23:46:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751032AbVKSWqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 17:46:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751039AbVKSWqv
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 17:46:51 -0500
Received: from smtp6-g19.free.fr ([212.27.42.36]:54932 "EHLO smtp6-g19.free.fr")
	by vger.kernel.org with ESMTP id S1751032AbVKSWqv (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 17:46:51 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 01DF9960C
	for <git@vger.kernel.org>; Sat, 19 Nov 2005 23:46:49 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EdbVM-0007Su-ED
	for git@vger.kernel.org; Sat, 19 Nov 2005 23:48:20 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20051115225740.GB28173@nowhere.earth>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12355>

On Tue, Nov 15, 2005 at 11:57:40PM +0100, Yann Dirson wrote:
> Linus wrote:
> >To generate the diff for a commit, gitk used to do
> >
> >	git-diff-tree -p -C $p $id
> 
> Although the "$p" reference is harmful to --dense mode, and redundant
> when we just want to look at a single commit, removing it breaks the
> "Diff this -> selected" and "Diff selected -> this" features.

As noted by Junio off-list, this original fix was not good.  Here is
another try, which should be more robust, and, unlike the 1st try,
handle all cases.  Also pullable from
http://ydirson.free.fr/soft/git/git.git/


commit 6483475ddd1af24fc138d36cfec986335685663e
tree 421f408703235272f7b4d86f77a451f4e6606ec3
parent 6ed64058e1241f9939c4abf5d6a9eaed6a2cc795
author Yann Dirson <ydirson@altern.org> Sat, 19 Nov 2005 23:36:16 +0100
committer Yann Dirson <dwitch@gandelf.nowhere.earth> Sat, 19 Nov 2005 23:36:16 +0100

    Fix gitk this->selected diffs
    
    The change made to accomodate dense revlists in single-commit diffs
    had broken computing of diffs between arbitrary trees, which does need
    to pass two commit ids, whether sparse or dense.
    
    This patch changes the two git-diff-tree calls to get the necessary
    two ids in this case.  It does so by propagating a "singlecommit" flag
    through all functions involved via an additionnal argument.
    
    Signed-off-by: Yann Dirson <ydirson@altern.org>

6483475ddd1af24fc138d36cfec986335685663e
diff --git a/gitk b/gitk
index 95b05c0..e3389e2 100755
--- a/gitk
+++ b/gitk
@@ -2197,9 +2197,9 @@ proc selectline {l isnew} {
     $cflist delete 0 end
     $cflist insert end "Comments"
     if {$nparents($id) == 1} {
-       startdiff [concat $id $parents($id)]
+       startdiff [concat $id $parents($id)] 1
     } elseif {$nparents($id) > 1} {
-       mergediff $id
+       mergediff $id 1
     }
 }
 
@@ -2268,7 +2268,7 @@ proc goforw {} {
     }
 }
 
-proc mergediff {id} {
+proc mergediff {id singlecommit} {
     global parents diffmergeid diffmergegca mergefilelist diffpindex
 
     set diffmergeid $id
@@ -2279,7 +2279,7 @@ proc mergediff {id} {
            showmergediff
        }
     } else {
-       contmergediff {}
+       contmergediff {} $singlecommit
     }
 }
 
@@ -2299,7 +2299,7 @@ proc findgca {ids} {
     return $gca
 }
 
-proc contmergediff {ids} {
+proc contmergediff {ids singlecommit} {
     global diffmergeid diffpindex parents nparents diffmergegca
     global treediffs mergefilelist diffids treepending
 
@@ -2316,7 +2316,7 @@ proc contmergediff {ids} {
        if {![info exists treediffs($ids)]} {
            set diffids $ids
            if {![info exists treepending]} {
-               gettreediffs $ids
+               gettreediffs $ids $singlecommit
            }
            return
        }
@@ -2794,40 +2794,45 @@ proc similarity {pnum l nlc f events} {
     return [expr {200 * $same / (2 * $same + $diff)}]
 }
 
-proc startdiff {ids} {
+proc startdiff {ids singlecommit} {
     global treediffs diffids treepending diffmergeid
 
     set diffids $ids
     catch {unset diffmergeid}
     if {![info exists treediffs($ids)]} {
        if {![info exists treepending]} {
-           gettreediffs $ids
+           gettreediffs $ids $singlecommit
        }
     } else {
-       addtocflist $ids
+       addtocflist $ids $singlecommit
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
     set p [lindex $ids 1]
-    if [catch {set gdtf [open "|git-diff-tree -r $id" r]}] return
+    if {$singlecommit == 1} {
+       set range "$id"
+    } else {
+       set range "$p $id"
+    }
+    if [catch {set gdtf [open "|git-diff-tree -r $range" r]}] return
     fconfigure $gdtf -blocking 0
-    fileevent $gdtf readable [list gettreediffline $gdtf $ids]
+    fileevent $gdtf readable [list gettreediffline $gdtf $ids $singlecommit]
 }
 
-proc gettreediffline {gdtf ids} {
+proc gettreediffline {gdtf ids singlecommit} {
     global treediff treediffs treepending diffids diffmergeid
 
     set n [gets $gdtf line]
@@ -2837,12 +2842,12 @@ proc gettreediffline {gdtf ids} {
        set treediffs($ids) $treediff
        unset treepending
        if {$ids != $diffids} {
-           gettreediffs $diffids
+           gettreediffs $diffids $singlecommit
        } else {
            if {[info exists diffmergeid]} {
-               contmergediff $ids
+               contmergediff $ids $singlecommit
            } else {
-               addtocflist $ids
+               addtocflist $ids $singlecommit
            }
        }
        return
@@ -2851,14 +2856,18 @@ proc gettreediffline {gdtf ids} {
     lappend treediff $file
 }
 
-proc getblobdiffs {ids} {
+proc getblobdiffs {ids singlecommit} {
     global diffopts blobdifffd diffids env curdifftag curtagstart
     global difffilestart nextupdate diffinhdr treediffs
 
     set id [lindex $ids 0]
     set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [list | git-diff-tree -r -p -C $id]
+    if {$singlecommit == 1} {
+       set cmd [list | git-diff-tree -r -p -C $id]
+    } else {
+       set cmd [list | git-diff-tree -r -p -C $p $id]
+    }
     if {[catch {set bdf [open $cmd r]} err]} {
        puts "error getting diffs: $err"
        return
@@ -3373,7 +3382,7 @@ proc doseldiff {oldid newid} {
     $ctext conf -state disabled
     $ctext tag delete Comments
     $ctext tag remove found 1.0 end
-    startdiff [list $newid $oldid]
+    startdiff [list $newid $oldid] 0
 }
 
 proc mkpatch {} {

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
