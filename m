From: Mark Ventimiglia <Mark.Ventimiglia@hotmail.com>
Subject: [PATCH] gitk: Improve readability of highlighted text
Date: Thu, 26 Mar 2015 00:48:45 -0500
Message-ID: <BLU436-SMTP165FCB03C8F3B79226DB3F093080@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, Mark Ventimiglia <Mark.Ventimiglia@hotmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 26 06:56:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yb0mo-0002Wc-1E
	for gcvg-git-2@plane.gmane.org; Thu, 26 Mar 2015 06:56:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752126AbbCZF4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2015 01:56:49 -0400
Received: from blu004-omc2s23.hotmail.com ([65.55.111.98]:55671 "EHLO
	BLU004-OMC2S23.hotmail.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752071AbbCZF4q (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2015 01:56:46 -0400
X-Greylist: delayed 480 seconds by postgrey-1.27 at vger.kernel.org; Thu, 26 Mar 2015 01:56:46 EDT
Received: from BLU436-SMTP165 ([65.55.111.73]) by BLU004-OMC2S23.hotmail.com over TLS secured channel with Microsoft SMTPSVC(7.5.7601.22751);
	 Wed, 25 Mar 2015 22:48:46 -0700
X-TMN: [8UmGjbwfw+CS9N7vjvjF23P2j+cR8oCV]
X-Originating-Email: [mark.ventimiglia@hotmail.com]
X-Mailer: git-send-email 1.9.0.msysgit.0
X-OriginalArrivalTime: 26 Mar 2015 05:48:45.0708 (UTC) FILETIME=[861E24C0:01D06788]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266314>

Selected text is indicated by displaying a rectangle under the selected
text. When the default background color of dark blue is used for the
selection rectangle, it does not have sufficient contrast with the default
text color of black, and the highlighted text cannot be read easily.

To fix this, determine the HSV value of the selection background color.
Then, set the color of the selected text based on that value -- white if
the value is less than 0.6, black otherwise. This ensures that there is
sufficent contrast to make the text readable over the background color.
Also tag all selected text with secseltext, so that it can be reverted to
the default color on a change of selection.
---
 gitk | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index 9a2daf3..0a5423a 100755
--- a/gitk
+++ b/gitk
@@ -2464,7 +2464,8 @@ proc makewindow {} {
     pack .bright.sb -side right -fill y
     pack $cflist -side left -fill both -expand 1
     $cflist tag configure highlight \
-	-background [$cflist cget -selectbackground]
+	-background [$cflist cget -selectbackground] \
+	-foreground [getseltextcolor [$cflist cget -selectbackground]]
     $cflist tag configure bold -font mainfontbold
 
     .pwbottom add .bright
@@ -7188,21 +7189,44 @@ proc dispnexttag {} {
 }
 
 proc make_secsel {id} {
-    global linehtag linentag linedtag canv canv2 canv3
+    global linehtag linentag linedtag canv canv2 canv3 fgcolor
 
     if {![info exists linehtag($id)]} return
-    $canv delete secsel
+
+    allcanvs delete secsel
+
+    set textfill [getseltextcolor [$canv cget -selectbackground]]
+    foreach t [$canv find withtag secseltext] {
+	$canv itemconf $t -fill $fgcolor
+	$canv dtag $t secseltext
+    }
     set t [eval $canv create rect [$canv bbox $linehtag($id)] -outline {{}} \
 	       -tags secsel -fill [$canv cget -selectbackground]]
     $canv lower $t
+    $canv itemconf $linehtag($id) -fill $textfill
+    $canv addtag secseltext withtag $linehtag($id)
+
+    foreach t [$canv2 find withtag secseltext] {
+	$canv2 itemconf $t -fill $fgcolor
+	$canv2 dtag $t secseltext
+    }
     $canv2 delete secsel
     set t [eval $canv2 create rect [$canv2 bbox $linentag($id)] -outline {{}} \
 	       -tags secsel -fill [$canv2 cget -selectbackground]]
     $canv2 lower $t
+    $canv2 itemconf $linentag($id) -fill $textfill
+    $canv2 addtag secseltext withtag $linentag($id)
+
+    foreach t [$canv3 find withtag secseltext] {
+	$canv3 itemconf $t -fill $fgcolor
+	$canv3 dtag $t secseltext
+    }
     $canv3 delete secsel
     set t [eval $canv3 create rect [$canv3 bbox $linedtag($id)] -outline {{}} \
 	       -tags secsel -fill [$canv3 cget -selectbackground]]
     $canv3 lower $t
+    $canv3 itemconf $linedtag($id) -fill $textfill
+    $canv3 addtag secseltext withtag $linedtag($id)
 }
 
 proc make_idmark {id} {
@@ -11529,14 +11553,26 @@ proc choosecolor {v vi w x cmd} {
     eval $cmd $c
 }
 
+proc getseltextcolor {c} {
+    # Get the largest RGB value -- this is the V in HSV
+    set value [lindex [lsort -integer [winfo rgb . $c]] end]
+
+    # If the normalized value is darker than 0.6 use white text,
+    # otherwise use black text
+    return [expr ($value < (65535 * .6))?"white":"black"]
+}
+
 proc setselbg {c} {
     global bglist cflist
     foreach w $bglist {
 	$w configure -selectbackground $c
     }
+    set textfill [getseltextcolor $c]
     $cflist tag configure highlight \
-	-background [$cflist cget -selectbackground]
+	-background [$cflist cget -selectbackground] \
+	-foreground $textfill
     allcanvs itemconf secsel -fill $c
+    allcanvs itemconf secseltext -fill $textfill
 }
 
 # This sets the background color and the color scheme for the whole UI.
-- 
1.9.0.msysgit.0
