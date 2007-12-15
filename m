From: Steffen Prohaska <prohaska@zib.de>
Subject: [RFC 2/4] gitk: Add diff-diff support
Date: Sat, 15 Dec 2007 17:51:43 +0100
Message-ID: <1197737505599-git-send-email-prohaska@zib.de>
References: <1197737505128-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 17:52:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3aFI-0000ng-HW
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 17:52:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755658AbXLOQvt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 11:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755505AbXLOQvt
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 11:51:49 -0500
Received: from mailer.zib.de ([130.73.108.11]:44311 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752641AbXLOQvr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 11:51:47 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBFGpjYs006054
	for <git@vger.kernel.org>; Sat, 15 Dec 2007 17:51:46 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBFGpj9D029051;
	Sat, 15 Dec 2007 17:51:45 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1197737505128-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68394>


---
 gitk-git/gitk |   46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1da0b0a..ca121e4 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -1019,6 +1019,8 @@ proc makewindow {} {
 	-command {diffvssel 0}
     $rowctxmenu add command -label "Diff selected -> this" \
 	-command {diffvssel 1}
+    $rowctxmenu add command -label "Diff Diff selected -> this" \
+	-command {diffdiffvssel 1}
     $rowctxmenu add command -label "Make patch" -command mkpatch
     $rowctxmenu add command -label "Create tag" -command mktag
     $rowctxmenu add command -label "Write commit to file" -command writecommit
@@ -6010,6 +6012,50 @@ proc doseldiff {oldid newid} {
     startdiff [list $oldid $newid]
 }
 
+proc diffdiffvssel {dirn} {
+    global rowmenuid selectedline displayorder
+
+    if {![info exists selectedline]} return
+    if {$dirn} {
+	set oldid [lindex $displayorder $selectedline]
+	set newid $rowmenuid
+    } else {
+	set oldid $rowmenuid
+	set newid [lindex $displayorder $selectedline]
+    }
+    addtohistory [list doseldiffdiff $oldid $newid]
+    doseldiffdiff $oldid $newid
+}
+
+proc doseldiffdiff {oldid newid} {
+    global ctext
+    global commitinfo
+
+    $ctext conf -state normal
+    clear_ctext
+    init_flist "Top"
+    $ctext insert end "From Commit "
+    $ctext insert end $oldid link0
+    setlink $oldid link0
+    $ctext insert end "\n     "
+    $ctext insert end [lindex $commitinfo($oldid) 0]
+    $ctext insert end "\n\nTo Commit   "
+    $ctext insert end $newid link1
+    setlink $newid link1
+    $ctext insert end "\n     "
+    $ctext insert end [lindex $commitinfo($newid) 0]
+    $ctext insert end "\n"
+    $ctext insert end "\n"
+    $ctext conf -state disabled
+    $ctext tag remove found 1.0 end
+
+    set diff [exec git diff-diff $oldid $newid]
+    $ctext conf -state normal
+    $ctext insert end "\n"
+    $ctext insert end $diff
+    $ctext conf -state disabled
+}
+
 proc mkpatch {} {
     global rowmenuid currentid commitinfo patchtop patchnum
 
-- 
1.5.4.rc0.37.geff3a-dirty
