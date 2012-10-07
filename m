From: Marcus Karlsson <mk@acc.umu.se>
Subject: [PATCH] gitk: Fix crash when not using themed widgets
Date: Sun,  7 Oct 2012 23:21:14 +0200
Message-ID: <1349644874-22988-1-git-send-email-mk@acc.umu.se>
Cc: git@vger.kernel.org, Marcus Karlsson <mk@acc.umu.se>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Oct 07 23:23:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TKyJV-0000PJ-Ni
	for gcvg-git-2@plane.gmane.org; Sun, 07 Oct 2012 23:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab2JGVVp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Oct 2012 17:21:45 -0400
Received: from mail.acc.umu.se ([130.239.18.156]:49375 "EHLO mail.acc.umu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750963Ab2JGVVn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Oct 2012 17:21:43 -0400
Received: from localhost (localhost [127.0.0.1])
	by amavisd-new (Postfix) with ESMTP id 7A507C3D;
	Sun,  7 Oct 2012 23:21:42 +0200 (MEST)
X-Virus-Scanned: amavisd-new at acc.umu.se
Received: by mail.acc.umu.se (Postfix, from userid 24678)
	id 53359C3B; Sun,  7 Oct 2012 23:21:41 +0200 (MEST)
X-Mailer: git-send-email 1.7.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207198>

When configured not to use themed widgets gitk may crash on launch with
a message that says that the image "bm-left disabled bm-left-gray"
doesn't exist. This happens when the left and right arrow buttons are
created.

The crash can be avoided by configuring the buttons differently
depending on whether or not themed widgets are used. If themed widgets
are not used then only set the images to bm-left and bm-right
respectively, and keep the old behavior when themed widgets are used.

The previous behaviour was added in f062e50f to work around a bug in Tk
on OS X where the disabled state did not display properly. The buttons
may still not display correctly, however the workaround added in
f062e50f will still apply if gitk is used with themed widgets.

Make gitk not crash on launch when not using themed widgets.

Signed-off-by: Marcus Karlsson <mk@acc.umu.se>
---
 gitk |   16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 379582a..02ffd9b 100755
--- a/gitk
+++ b/gitk
@@ -2182,11 +2182,19 @@ proc makewindow {} {
     image create bitmap bm-right -data $bm_right_data
     image create bitmap bm-right-gray -data $bm_right_data -foreground "#999"
 
-    ${NS}::button .tf.bar.leftbut -image [list bm-left disabled bm-left-gray] \
-	-command goback -state disabled -width 26
+    ${NS}::button .tf.bar.leftbut -command goback -state disabled -width 26
+    if {$use_ttk} {
+	.tf.bar.leftbut configure -image [list bm-left disabled bm-left-gray]
+    } else {
+	.tf.bar.leftbut configure -image bm-left
+    }
     pack .tf.bar.leftbut -side left -fill y
-    ${NS}::button .tf.bar.rightbut -image [list bm-right disabled bm-right-gray] \
-	-command goforw -state disabled -width 26
+    ${NS}::button .tf.bar.rightbut -command goforw -state disabled -width 26
+    if {$use_ttk} {
+	.tf.bar.rightbut configure -image [list bm-right disabled bm-right-gray]
+    } else {
+	.tf.bar.rightbut configure -image bm-right
+    }
     pack .tf.bar.rightbut -side left -fill y
 
     ${NS}::label .tf.bar.rowlabel -text [mc "Row"]
-- 
1.7.10.4
