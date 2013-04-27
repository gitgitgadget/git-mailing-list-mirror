From: Knut Franke <Knut.Franke@gmx.de>
Subject: [PATCH] gitk: Add menu item for reverting commits
Date: Sat, 27 Apr 2013 16:36:13 +0200
Message-ID: <1367073373.12513.3.camel@Vger>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 27 16:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UW6Ef-0008IN-On
	for gcvg-git-2@plane.gmane.org; Sat, 27 Apr 2013 16:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755767Ab3D0OgR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Apr 2013 10:36:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:61351 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755595Ab3D0OgQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Apr 2013 10:36:16 -0400
Received: from mailout-de.gmx.net ([10.1.76.4]) by mrigmx.server.lan
 (mrigmx002) with ESMTP (Nemesis) id 0MLDZP-1UVpFe1VhZ-000IWg for
 <git@vger.kernel.org>; Sat, 27 Apr 2013 16:36:15 +0200
Received: (qmail invoked by alias); 27 Apr 2013 14:36:15 -0000
Received: from f051078105.adsl.alicedsl.de (EHLO [192.168.1.4]) [78.51.78.105]
  by mail.gmx.net (mp004) with SMTP; 27 Apr 2013 16:36:15 +0200
X-Authenticated: #377055
X-Provags-ID: V01U2FsdGVkX1873i9TCvk7RoVrzs8Ad7zXV/rdlH5BXG61CGXgVz
	EPKDS//bWi+k+0
X-Mailer: Evolution 3.2.3-0ubuntu6 
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222654>

Sometimes it's helpful (at least psychologically) to have this feature
easily accessible. Code borrows heavily from cherrypick.

Signed-off-by: Knut Franke <Knut.Franke@gmx.de>
---
 gitk |   62
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/gitk b/gitk
index 572f73f..fb1a6ce 100755
--- a/gitk
+++ b/gitk
@@ -2562,6 +2562,7 @@ proc makewindow {} {
 	{mc "Compare with marked commit" command compare_commits}
 	{mc "Diff this -> marked commit" command {diffvsmark 0}}
 	{mc "Diff marked commit -> this" command {diffvsmark 1}}
+	{mc "Revert this commit" command revert}
     }
     $rowctxmenu configure -tearoff 0
 
@@ -9347,6 +9348,67 @@ proc cherrypick {} {
     notbusy cherrypick
 }
 
+proc revert {} {
+    global rowmenuid curview
+    global mainhead mainheadid
+    global gitdir
+
+    set oldhead [exec git rev-parse HEAD]
+    set dheads [descheads $rowmenuid]
+    if { $dheads eq {} || [lsearch -exact $dheads $oldhead] == -1 } {
+       set ok [confirm_popup [mc "Commit %s is not\
+           included in branch %s -- really revert it?" \
+                      [string range $rowmenuid 0 7] $mainhead]]
+       if {!$ok} return
+    }
+    nowbusy revert [mc "Reverting"]
+    update
+
+    if [catch {exec git revert --no-edit $rowmenuid} err] {
+        notbusy revert
+        if [regexp {files would be overwritten by merge:(\n(( |\t)+[^
\n]+\n)+)}\
+                $err match files] {
+            regsub {\n( |\t)+} $files "\n" files
+            error_popup [mc "Revert failed because of local changes to
\
+                the following files:%s Please commit, reset or stash \
+                your changes and try again." $files]
+        } elseif [regexp {error: could not revert} $err] {
+            if [confirm_popup [mc "Revert failed because of merge
conflict.\n\
+                Do you wish to run git citool to resolve it?"]] {
+                # Force citool to read MERGE_MSG
+                file delete [file join $gitdir "GITGUI_MSG"]
+                exec_citool {} $rowmenuid
+            }
+        } else { error_popup $err }
+        run updatecommits
+        return
+    }
+
+    set newhead [exec git rev-parse HEAD]
+    if { $newhead eq $oldhead } {
+        notbusy revert
+        error_popup [mc "No changes committed"]
+        return
+    }
+
+    addnewchild $newhead $oldhead
+
+    if [commitinview $oldhead $curview] {
+        # XXX this isn't right if we have a path limit...
+        insertrow $newhead $oldhead $curview
+        if {$mainhead ne {}} {
+            movehead $newhead $mainhead
+            movedhead $newhead $mainhead
+        }
+        set mainheadid $newhead
+        redrawtags $oldhead
+        redrawtags $newhead
+        selbyid $newhead
+    }
+
+    notbusy revert
+}
+
 proc resethead {} {
     global mainhead rowmenuid confirm_ok resettype NS
 
-- 
1.7.9.5
