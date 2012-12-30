From: Jason Holden <jason.k.holden.swdev@gmail.com>
Subject: [RFC/PATCH] gitk: Visualize a merge commit with a right-click in gitk
Date: Sat, 29 Dec 2012 19:16:16 -0500
Message-ID: <1356826576-24334-1-git-send-email-jason.k.holden.swdev@gmail.com>
Cc: paulus@samba.org, Jason Holden <jason.k.holden.swdev@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 01:17:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tp6ak-00041W-5A
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 01:17:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753499Ab2L3ARH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2012 19:17:07 -0500
Received: from mail-vb0-f49.google.com ([209.85.212.49]:61917 "EHLO
	mail-vb0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753440Ab2L3ARG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2012 19:17:06 -0500
Received: by mail-vb0-f49.google.com with SMTP id r6so11713588vbi.22
        for <git@vger.kernel.org>; Sat, 29 Dec 2012 16:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=u2sdmCHekopzFGHnfWEfJfJmhkl0ZoHaLCOJAJHXSUU=;
        b=dFuO0346O26Am8sjo8YxoAkjJhn71AnC6JTSHqca9VJqXOSQBolNnk664RMbE1fBwD
         nM6pcyQfb6Ywsewrs4ciTo5RYuIusD4shlI2l5Jf6NL0EDlJ4tne6Z4WsO3nKQCM8CTL
         PWVnKPasSqa/oulYxyhTr2lwRKYWG4YTkjOKVr7+GDZ8uPFd8q6y9qUAE9ox8ehBx6C2
         gvt/A+BBO1ZJtD3qU3E9KzwwGN49xIJhcLSh9n4gcg1yad6wHERGWISDulPPrEUxswcB
         qHVI24Igye34JiB3Pn0wIJzW96mT051UFKkdRv7e7sYF185hBHIdyNj6hLaM/jPBm4y3
         wz1g==
X-Received: by 10.52.93.146 with SMTP id cu18mr50577406vdb.37.1356826625111;
        Sat, 29 Dec 2012 16:17:05 -0800 (PST)
Received: from rowblue.hsd1.nh.comcast.net (c-75-69-185-21.hsd1.nh.comcast.net. [75.69.185.21])
        by mx.google.com with ESMTPS id y7sm33951647vdt.14.2012.12.29.16.17.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 29 Dec 2012 16:17:04 -0800 (PST)
X-Mailer: git-send-email 1.8.1.rc3.28.g0ab5d1f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212321>

When first doing a merge in git-gui, the "Visualize Merge" button is
quite helpful to visualize the changes due to a merge.
But once the merge is complete, there's not a similarly convenient
way to recreate that merge view in gitk.

This commit adds to gitk the ability to right-click on a merge commit and
bring up a new gitk window displaying only those commits involved in
the merge.

When right-clicking on a non-merge commit, this option is grayed out.  This
patch also supports correct visualization of octopus merges

Signed-off-by: Jason Holden <jason.k.holden.swdev@gmail.com>
---
 gitk | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/gitk b/gitk
index 379582a..17e1fcb 100755
--- a/gitk
+++ b/gitk
@@ -2551,6 +2551,7 @@ proc makewindow {} {
 	{mc "Compare with marked commit" command compare_commits}
 	{mc "Diff this -> marked commit" command {diffvsmark 0}}
 	{mc "Diff marked commit -> this" command {diffvsmark 1}}
+	{mc "Visualize this merge" command visualize_merge}
     }
     $rowctxmenu configure -tearoff 0
 
@@ -2590,6 +2591,31 @@ proc makewindow {} {
     $diff_menu configure -tearoff 0
 }
 
+# Return the number of parents for a given sha1 id
+proc get_numparents_from_id {id} {
+    global parentlist
+    set row [rowofcommit $id]
+    return [llength [lindex $parentlist $row]]
+}
+
+proc visualize_merge {} {
+    global parents currentid parentlist
+    global rowmenuid
+
+    set num_parents [get_numparents_from_id $rowmenuid]
+    set row [rowofcommit $rowmenuid]
+
+    if {$num_parents >= 2} {
+	set revlist $rowmenuid
+	for { set i 1 } {$i < $num_parents} {incr i} {
+
+	    set revlist "$revlist [lindex $parentlist $row 0]..[lindex $parentlist $row $i] $rowmenuid"
+	}
+	
+	eval exec gitk $revlist
+    }
+}
+
 # Windows sends all mouse wheel events to the current focused window, not
 # the one where the mouse hovers, so bind those events here and redirect
 # to the correct window
@@ -8577,6 +8603,13 @@ proc rowmenu {x y id} {
 	$menu entryconfigure 9 -state $mstate
 	$menu entryconfigure 10 -state $mstate
 	$menu entryconfigure 11 -state $mstate
+
+	# Disable visualize-merge on only one parent
+	if {[get_numparents_from_id $id] == 1} {
+	    $menu entryconfigure 15 -state disabled
+	} else {
+	    $menu entryconfigure 15 -state normal
+	}
     } else {
 	set menu $fakerowmenu
     }
-- 
1.8.1.rc3.28.g0ab5d1f
