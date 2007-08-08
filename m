From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - Handle MouseWheel events on Windows
Date: Tue, 07 Aug 2007 21:40:35 -0400
Message-ID: <11865372381125-git-send-email-mdl123@verizon.net>
References: <1186440352826-git-send-email-mdl123@verizon.net>
 <11865372352543-git-send-email-mdl123@verizon.net>
Cc: Git Mailing List <git@vger.kernel.org>,
	Mark Levedahl <mdl123@verizon.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Aug 08 03:41:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIaXk-0001a2-AI
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 03:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760314AbXHHBk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 21:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756947AbXHHBk4
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 21:40:56 -0400
Received: from vms040pub.verizon.net ([206.46.252.40]:55285 "EHLO
	vms040pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757652AbXHHBkz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 21:40:55 -0400
Received: from fal-l07294-lp.us.ray.com ([72.66.124.87])
 by vms040.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JMF00DXKLZQ5MJ0@vms040.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 07 Aug 2007 20:40:39 -0500 (CDT)
In-reply-to: <11865372352543-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.3.rc4.25.gade7b9
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55291>

Windows, unlike X-Windows, sends mousewheel events by default to the
window that has keyboard focus and uses the MouseWheel event to do so.
The window to be scrolled must be able to take focus, but gitk's panels
are disabled so cannot take focus. For all these reasons, a different
design is needed to use the mousewheel on Windows. The approach here is
to bind the mousewheel events to the top level window and redirect them
based upon the current mouse position.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---

This version is a slight clean-up of the original, collapsing two
if/else blocks into a single conditional assignment.

 gitk |   27 +++++++++++++++++++++++++--
 1 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 84f5ee4..eb2b194 100755
--- a/gitk
+++ b/gitk
@@ -823,8 +823,13 @@ proc makewindow {} {
     pack .ctop -fill both -expand 1
     bindall <1> {selcanvline %W %x %y}
     #bindall <B1-Motion> {selcanvline %W %x %y}
-    bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
-    bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+    if {[tk windowingsystem] == "win32"} {
+	bind . <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D }
+	bind $ctext <MouseWheel> { windows_mousewheel_redirector %W %X %Y %D ; break }
+    } else {
+	bindall <ButtonRelease-4> "allcanvs yview scroll -5 units"
+	bindall <ButtonRelease-5> "allcanvs yview scroll 5 units"
+    }
     bindall <2> "canvscan mark %W %x %y"
     bindall <B2-Motion> "canvscan dragto %W %x %y"
     bindkey <Home> selfirstline
@@ -918,6 +923,24 @@ proc makewindow {} {
 	-command rmbranch
 }

+# Windows sends all mouse wheel events to the current focused window, not
+# the one where the mouse hovers, so bind those events here and redirect
+# to the correct window
+proc windows_mousewheel_redirector {W X Y D} {
+    global canv canv2 canv3
+    set w [winfo containing -displayof $W $X $Y]
+    if {$w ne ""} {
+	set u [expr {$D < 0 ? 5 : -5}]
+	if {$w == $canv || $w == $canv2 || $w == $canv3} {
+	    allcanvs yview scroll $u units
+	} else {
+	    catch {
+		$w yview scroll $u units
+	    }
+	}
+    }
+}
+
 # mouse-2 makes all windows scan vertically, but only the one
 # the cursor is in scans horizontally
 proc canvscan {op w x y} {
--
1.5.3.rc4.25.gade7b9
