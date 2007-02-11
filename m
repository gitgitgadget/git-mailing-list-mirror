From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Make gitk save and restore the user set window position.
Date: Sun, 11 Feb 2007 09:27:19 -0500
Message-ID: <11712040403973-git-send-email-mdl123@verizon.net>
References: <11712040401127-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 11 15:27:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGFg1-0000It-Ri
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 15:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXBKO1d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 09:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751419AbXBKO12
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 09:27:28 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:63219 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbXBKO11 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 09:27:27 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDA00JIZYTHTDH6@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Sun, 11 Feb 2007 08:27:18 -0600 (CST)
In-reply-to: <11712040401127-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39282>

gitk was saving widget sizes and positions when the main window was
destroyed, which is after all child widgets are destroyed. The cure
is to trap the WM_DELETE_WINDOW event before the gui is torn down. Also,
the saved geometry was captured using "winfo geometry .", rather than
"wm geometry ." Under Linux, these two return different answers and the
latter one is correct.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 1c36235..23bf567 100755
--- a/gitk
+++ b/gitk
@@ -725,7 +725,7 @@ proc makewindow {} {
     bind . <Control-KP_Add> {incrfont 1}
     bind . <Control-minus> {incrfont -1}
     bind . <Control-KP_Subtract> {incrfont -1}
-    bind . <Destroy> {savestuff %W}
+    wm protocol . WM_DELETE_WINDOW doquit
     bind . <Button-1> "click %W"
     bind $fstring <Key-Return> dofind
     bind $sha1entry <Key-Return> gotocommit
@@ -829,7 +829,7 @@ proc savestuff {w} {
 	puts $f [list set colors $colors]
 	puts $f [list set diffcolors $diffcolors]
 
-        puts $f "set geometry(main) [winfo geometry .]"
+	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
 	puts $f "set geometry(canv) [expr {[winfo width $canv]-0}]"
@@ -5800,6 +5800,7 @@ proc showtag {tag isnew} {
 proc doquit {} {
     global stopped
     set stopped 100
+    savestuff .
     destroy .
 }
 
-- 
1.5.0.rc3.24.g0c5e
