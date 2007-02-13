From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] Make gitk save and restore window pane position on Linux and
 Cygwin.
Date: Mon, 12 Feb 2007 19:19:34 -0500
Message-ID: <11713259742627-git-send-email-mdl123@verizon.net>
Cc: Mark Levedahl <mdl123@verizon.net>
To: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 13 01:19:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGlOd-0008WG-RU
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 01:19:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030579AbXBMATk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 19:19:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbXBMATk
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 19:19:40 -0500
Received: from vms044pub.verizon.net ([206.46.252.44]:41889 "EHLO
	vms044pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030579AbXBMATj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:19:39 -0500
Received: from fal-l07294-lp.us.ray.com ([71.246.235.75])
 by vms044.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JDD00HIEKWKLOK1@vms044.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 12 Feb 2007 18:19:33 -0600 (CST)
X-Mailer: git-send-email 1.5.0.rc3.24.g0c5e
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39464>

Subtle bugs remained on both Cygwin and Linux that caused the various
window panes to be restored in positions different than where the user
last placed them. Sergey Vlasov posed a pair of suggested fixes to this,
what is done here is slightly different. The basic fix here involves
a) explicitly remembering and restoring the sash positions for the upper
window, and b) using paneconfigure to redundantly set height and width of
other elements. This redundancy is needed as Cygwin Tcl has a nasty habit
of setting pane sizes to zero if their slaves are not configured with a
specific size, but Linux Tcl does not honor the specific size given.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |   23 +++++++++++++----------
 1 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/gitk b/gitk
index df1ce8c..9ddff3e 100755
--- a/gitk
+++ b/gitk
@@ -439,14 +439,13 @@ proc makewindow {} {
     panedwindow .ctop -orient vertical
 
     # possibly use assumed geometry
-    if {![info exists geometry(topheight)]} {
+    if {![info exists geometry(pwsash0)]} {
         set geometry(topheight) [expr {15 * $linespc}]
         set geometry(topwidth) [expr {80 * $charspc}]
         set geometry(botheight) [expr {15 * $linespc}]
         set geometry(botwidth) [expr {50 * $charspc}]
-        set geometry(canv) [expr {40 * $charspc}]
-        set geometry(canv2) [expr {20 * $charspc}]
-        set geometry(canv3) [expr {20 * $charspc}]
+        set geometry(pwsash0) "[expr {40 * $charspc}] 2"
+        set geometry(pwsash1) "[expr {60 * $charspc}] 2"
     }
 
     # the upper half will have a paned window, a scroll bar to the right, and some stuff below
@@ -457,18 +456,20 @@ proc makewindow {} {
     # create three canvases
     set cscroll .tf.histframe.csb
     set canv .tf.histframe.pwclist.canv
-    canvas $canv -width $geometry(canv) \
+    canvas $canv \
 	-background $bgcolor -bd 0 \
 	-yscrollincr $linespc -yscrollcommand "scrollcanv $cscroll"
     .tf.histframe.pwclist add $canv
     set canv2 .tf.histframe.pwclist.canv2
-    canvas $canv2 -width $geometry(canv2) \
+    canvas $canv2 \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv2
     set canv3 .tf.histframe.pwclist.canv3
-    canvas $canv3 -width $geometry(canv3) \
+    canvas $canv3 \
 	-background $bgcolor -bd 0 -yscrollincr $linespc
     .tf.histframe.pwclist add $canv3
+    eval .tf.histframe.pwclist sash place 0 $geometry(pwsash0)
+    eval .tf.histframe.pwclist sash place 1 $geometry(pwsash1)
 
     # a scroll bar to rule them
     scrollbar $cscroll -command {allcanvs yview} -highlightthickness 0
@@ -577,6 +578,8 @@ proc makewindow {} {
     pack .tf.bar -in .tf -side bottom -fill x
     pack .tf.histframe -fill both -side top -expand 1
     .ctop add .tf
+    .ctop paneconfigure .tf -height $geometry(topheight)
+    .ctop paneconfigure .tf -width $geometry(topwidth)
 
     # now build up the bottom
     panedwindow .pwbottom -orient horizontal
@@ -638,6 +641,7 @@ proc makewindow {} {
     $ctext tag conf found -back yellow
 
     .pwbottom add .bleft
+    .pwbottom paneconfigure .bleft -width $geometry(botwidth)
 
     # lower right
     frame .bright
@@ -832,9 +836,8 @@ proc savestuff {w} {
 	puts $f "set geometry(main) [wm geometry .]"
 	puts $f "set geometry(topwidth) [winfo width .tf]"
 	puts $f "set geometry(topheight) [winfo height .tf]"
-	puts $f "set geometry(canv) [winfo width $canv]"
-	puts $f "set geometry(canv2) [winfo width $canv2]"
-	puts $f "set geometry(canv3) [winfo width $canv3]"
+        puts $f "set geometry(pwsash0) \"[.tf.histframe.pwclist sash coord 0]\""
+        puts $f "set geometry(pwsash1) \"[.tf.histframe.pwclist sash coord 1]\""
 	puts $f "set geometry(botwidth) [winfo width .bleft]"
 	puts $f "set geometry(botheight) [winfo height .bleft]"
 
-- 
1.5.0.rc3.24.g0c5e
