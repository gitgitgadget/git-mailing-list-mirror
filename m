From: Mark Levedahl <mdl123@verizon.net>
Subject: [PATCH] gitk - Allow specifying tabstop as other than default 8
 characters.
Date: Mon, 25 Jun 2007 22:43:21 -0400
Message-ID: <1182825801391-git-send-email-mdl123@verizon.net>
References: <46807CEF.2010109@verizon.net>
 <1182825801300-git-send-email-mdl123@verizon.net>
 <11828258013248-git-send-email-mdl123@verizon.net>
Cc: git@vger.kernel.org, Mark Levedahl <mdl123@verizon.net>
To: gitster@pobox.com, paulus@samba.org
X-From: git-owner@vger.kernel.org Tue Jun 26 04:43:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I311u-0004Qr-Pl
	for gcvg-git@gmane.org; Tue, 26 Jun 2007 04:43:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752384AbXFZCna (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 22:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822AbXFZCna
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 22:43:30 -0400
Received: from vms042pub.verizon.net ([206.46.252.42]:50332 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752338AbXFZCn3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 22:43:29 -0400
Received: from fal-l07294-lp.us.ray.com ([71.126.129.74])
 by vms042.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0JK80019K28BA5N1@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Mon, 25 Jun 2007 21:43:24 -0500 (CDT)
In-reply-to: <11828258013248-git-send-email-mdl123@verizon.net>
X-Mailer: git-send-email 1.5.2.2.282.g9826
X-Peer: 127.0.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50944>

Not all projects use the convention that one tabstop = 8 characters, and
a common convention is to use one tabstop = on level of indent. For such
projects, using 8 characters per tabstop often shows too much whitespace
per indent. This allows the user to configure the number of characters
to use per tabstop.

Signed-off-by: Mark Levedahl <mdl123@verizon.net>
---
 gitk |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 62eefd9..06df3bb 100755
--- a/gitk
+++ b/gitk
@@ -395,7 +395,7 @@ proc confirm_popup msg {
 
 proc makewindow {} {
     global canv canv2 canv3 linespc charspc ctext cflist
-    global textfont mainfont uifont
+    global textfont mainfont uifont tabstop
     global findtype findtypemenu findloc findstring fstring geometry
     global entries sha1entry sha1string sha1but
     global maincursor textcursor curtextcursor
@@ -615,6 +615,7 @@ proc makewindow {} {
     pack .bleft.mid.diff .bleft.mid.old .bleft.mid.new -side left
     set ctext .bleft.ctext
     text $ctext -background $bgcolor -foreground $fgcolor \
+	-tabs "[expr {$tabstop * $charspc}]" \
 	-state disabled -font $textfont \
 	-yscrollcommand scrolltext -wrap none
     scrollbar .bleft.sb -command "$ctext yview"
@@ -824,7 +825,7 @@ proc click {w} {
 }
 
 proc savestuff {w} {
-    global canv canv2 canv3 ctext cflist mainfont textfont uifont
+    global canv canv2 canv3 ctext cflist mainfont textfont uifont tabstop
     global stuffsaved findmergefiles maxgraphpct
     global maxwidth showneartags
     global viewname viewfiles viewargs viewperm nextviewnum
@@ -838,6 +839,7 @@ proc savestuff {w} {
 	puts $f [list set mainfont $mainfont]
 	puts $f [list set textfont $textfont]
 	puts $f [list set uifont $uifont]
+	puts $f [list set tabstop $tabstop]
 	puts $f [list set findmergefiles $findmergefiles]
 	puts $f [list set maxgraphpct $maxgraphpct]
 	puts $f [list set maxwidth $maxwidth]
@@ -4696,12 +4698,13 @@ proc redisplay {} {
 
 proc incrfont {inc} {
     global mainfont textfont ctext canv phase cflist
+    global charspc tabstop
     global stopped entries
     unmarkmatches
     set mainfont [lreplace $mainfont 1 1 [expr {[lindex $mainfont 1] + $inc}]]
     set textfont [lreplace $textfont 1 1 [expr {[lindex $textfont 1] + $inc}]]
     setcoords
-    $ctext conf -font $textfont
+    $ctext conf -font $textfont -tabs "[expr {$tabstop * $charspc}]"
     $cflist conf -font $textfont
     $ctext tag conf filesep -font [concat $textfont bold]
     foreach e $entries {
@@ -5852,7 +5855,7 @@ proc doprefs {} {
     global maxwidth maxgraphpct diffopts
     global oldprefs prefstop showneartags
     global bgcolor fgcolor ctext diffcolors selectbgcolor
-    global uifont
+    global uifont tabstop
 
     set top .gitkprefs
     set prefstop $top
@@ -5890,6 +5893,9 @@ proc doprefs {} {
     checkbutton $top.ntag.b -variable showneartags
     pack $top.ntag.b $top.ntag.l -side left
     grid x $top.ntag -sticky w
+    label $top.tabstopl -text "tabstop" -font optionfont
+    spinbox $top.tabstop -from 1 -to 20 -width 4 -textvariable tabstop
+    grid x $top.tabstopl $top.tabstop -sticky w
 
     label $top.cdisp -text "Colors: press to choose"
     $top.cdisp configure -font $uifont
@@ -5988,9 +5994,11 @@ proc prefscan {} {
 proc prefsok {} {
     global maxwidth maxgraphpct
     global oldprefs prefstop showneartags
+    global charspc ctext tabstop
 
     catch {destroy $prefstop}
     unset prefstop
+    $ctext configure -tabs "[expr {$tabstop * $charspc}]"
     if {$maxwidth != $oldprefs(maxwidth)
 	|| $maxgraphpct != $oldprefs(maxgraphpct)} {
 	redisplay
@@ -6296,6 +6304,7 @@ if {$tclencoding == {}} {
 set mainfont {Helvetica 9}
 set textfont {Courier 9}
 set uifont {Helvetica 9 bold}
+set tabstop 8
 set findmergefiles 0
 set maxgraphpct 50
 set maxwidth 16
-- 
1.5.2.2.282.g9826
