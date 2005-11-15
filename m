From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Re: Make "gitk" work better with dense revlists
Date: Tue, 15 Nov 2005 23:57:40 +0100
Message-ID: <20051115225740.GB28173@nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Nov 15 23:59:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec9jK-0000j1-U9
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 23:56:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965067AbVKOW4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 17:56:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965069AbVKOW4a
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 17:56:30 -0500
Received: from smtp2-g19.free.fr ([212.27.42.28]:58572 "EHLO smtp2-g19.free.fr")
	by vger.kernel.org with ESMTP id S965067AbVKOW43 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 17:56:29 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A5D2D522EE
	for <git@vger.kernel.org>; Tue, 15 Nov 2005 23:56:27 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1Ec9kC-0006PG-US
	for git@vger.kernel.org; Tue, 15 Nov 2005 23:57:40 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11959>

Linus wrote:
>To generate the diff for a commit, gitk used to do
>
>	git-diff-tree -p -C $p $id

Although the "$p" reference is harmful to --dense mode, and redundant
when we just want to look at a single commit, removing it breaks the
"Diff this -> selected" and "Diff selected -> this" features.

A minimal fix would be at least make your change dependant on being in
dense mode, and disable those extra features then (better than keeping
them broken) if noone takes the lead to fix it.

Signed-off-by: Yann Dirson <ydirson@altern.org>

diff --git a/gitk b/gitk
index a9d37d9..f73ab41 100755
--- a/gitk
+++ b/gitk
@@ -2801,12 +2801,17 @@ proc addtocflist {ids} {
 }
 
 proc gettreediffs {ids} {
-    global treediff parents treepending
+    global treediff parents treepending isdense
     set treepending $ids
     set treediff {}
     set id [lindex $ids 0]
     set p [lindex $ids 1]
-    if [catch {set gdtf [open "|git-diff-tree -r $id" r]}] return
+    if {$isdense == 1} {
+       set range "$id"
+    } else {
+       set range "$p $id"
+    }
+    if [catch {set gdtf [open "|git-diff-tree -r $range" r]}] return
     fconfigure $gdtf -blocking 0
     fileevent $gdtf readable [list gettreediffline $gdtf $ids]
 }
@@ -2837,12 +2842,16 @@ proc gettreediffline {gdtf ids} {
 
 proc getblobdiffs {ids} {
     global diffopts blobdifffd diffids env curdifftag curtagstart
-    global difffilestart nextupdate diffinhdr treediffs
+    global difffilestart nextupdate diffinhdr treediffs isdense
 
     set id [lindex $ids 0]
     set p [lindex $ids 1]
     set env(GIT_DIFF_OPTS) $diffopts
-    set cmd [list | git-diff-tree -r -p -C $id]
+    if {$isdense == 1} {
+       set cmd [list | git-diff-tree -r -p -C $id]
+    } else {
+       set cmd [list | git-diff-tree -r -p -C $p $id]
+    }
     if {[catch {set bdf [open $cmd r]} err]} {
        puts "error getting diffs: $err"
        return
@@ -3299,16 +3308,21 @@ proc mstime {} {
 }
 
 proc rowmenu {x y id} {
-    global rowctxmenu idline selectedline rowmenuid
+    global rowctxmenu idline selectedline rowmenuid isdense
 
     if {![info exists selectedline] || $idline($id) eq $selectedline} {
-       set state disabled
+       set patchstate disabled
     } else {
-       set state normal
+       set patchstate normal
+    }
+    if {$isdense || $patchstate eq "disabled"} {
+       set diffstate disabled
+    } else {
+       set diffstate normal
     }
-    $rowctxmenu entryconfigure 0 -state $state
-    $rowctxmenu entryconfigure 1 -state $state
-    $rowctxmenu entryconfigure 2 -state $state
+    $rowctxmenu entryconfigure 0 -state $diffstate
+    $rowctxmenu entryconfigure 1 -state $diffstate
+    $rowctxmenu entryconfigure 2 -state $patchstate
     set rowmenuid $id
     tk_popup $rowctxmenu $x $y
 }
@@ -3653,6 +3667,7 @@ proc doquit {} {
 # defaults...
 set datemode 0
 set boldnames 0
+set isdense 0
 set diffopts "-U 5 -p"
 set wrcomcmd "git-diff-tree --stdin -p --pretty"
 
@@ -3678,6 +3693,10 @@ foreach arg $argv {
        "^$" { }
        "^-b" { set boldnames 1 }
        "^-d" { set datemode 1 }
+       "^--dense$" {
+           set isdense 1
+           lappend revtreeargs $arg
+       }
        default {
            lappend revtreeargs $arg
        }

-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
