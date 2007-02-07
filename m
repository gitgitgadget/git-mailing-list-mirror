From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Make gitk save and restore the user set window position.
Date: Tue, 06 Feb 2007 19:21:05 -0800
Message-ID: <7v3b5ifyam.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 07 04:21:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HEdN4-0000Zo-Jz
	for gcvg-git@gmane.org; Wed, 07 Feb 2007 04:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965329AbXBGDVP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Feb 2007 22:21:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965634AbXBGDVP
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Feb 2007 22:21:15 -0500
Received: from fed1rmmtai19.cox.net ([68.230.241.40]:40307 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965329AbXBGDVG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Feb 2007 22:21:06 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070207032105.XDJE1349.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Feb 2007 22:21:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id LTM51W00E1kojtg0000000; Tue, 06 Feb 2007 22:21:05 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38886>

From: Mark Levedahl <mdl123@verizon.net>
Date: Mon, 05 Feb 2007 22:59:50 -0500

gitk was saving widget sizes and positions when the main window was
destroyed, which is after all child widgets are destroyed. Tk resizes
container widgets as children are destroyed, so the saved main window
information was not as the user left the window. This patch causes the
info to be saved before the first child widget is destroyed. Also,
use wm geometry rather than winfo geometry (both work on Windows, on
Linux they give different answers and the former is correct).

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 * Somehow this did not appeared on the list, so I am forwarding.

   After seeing what this patch has to do, I feel dirty, but
   that is not Mark's fault -- rather it is Tk's.

   I am tempted to suggest adding an explicit "Save window
   configuration" action on the menubar and forget about
   resurrecting the window configuration immediately before the
   end of the last session.

 gitk |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 8132812..beec6a9 100755
--- a/gitk
+++ b/gitk
@@ -725,7 +725,7 @@ proc makewindow {} {
     bind . <Control-KP_Add> {incrfont 1}
     bind . <Control-minus> {incrfont -1}
     bind . <Control-KP_Subtract> {incrfont -1}
-    bind . <Destroy> {savestuff %W}
+    bindalldestroy .
     bind . <Button-1> "click %W"
     bind $fstring <Key-Return> dofind
     bind $sha1entry <Key-Return> gotocommit
@@ -759,6 +759,22 @@ proc makewindow {} {
 	-command rmbranch
 }
 
+# The main window resizes itself while the windows are being destroyed,
+# we want to save the size before it is resized so we write out when the
+# first widget with no children is destroyed.  We don't know which this
+# will be, so we bind all child widgets (savestuff will save only once,
+# the remaining calls are ignored).
+proc bindalldestroy {w} {
+    set children [winfo children $w]
+    if {"$children" == ""} {
+        bind $w <Destroy> {savestuff %W}
+    } else {
+        foreach child $children {
+            bindalldestroy $child
+        }
+    }
+}
+
 # mouse-2 makes all windows scan vertically, but only the one
 # the cursor is in scans horizontally
 proc canvscan {op w x y} {
@@ -829,7 +845,7 @@ proc savestuff {w} {
 	puts $f [list set colors $colors]
 	puts $f [list set diffcolors $diffcolors]
 
-        puts $f "set geometry(main) [winfo geometry .]"
+	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
 	puts $f "set geometry(canv) [expr {[winfo width $canv]-0}]"
-- 
1.5.0.rc3.24.g0c5e
