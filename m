From: Nelson Elhage <nelhage@MIT.EDU>
Subject: [PATCH] gitk: Fix units in resize logic
Date: Wed, 15 Jul 2009 22:12:23 -0400
Message-ID: <1247710343-19096-1-git-send-email-nelhage@mit.edu>
Cc: Nelson Elhage <nelhage@mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 16 04:12:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRGSe-0006N6-64
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 04:12:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757043AbZGPCMd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jul 2009 22:12:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757041AbZGPCMd
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Jul 2009 22:12:33 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:35188 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757024AbZGPCMd (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Jul 2009 22:12:33 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id n6G2CUBe016437;
	Wed, 15 Jul 2009 22:12:30 -0400 (EDT)
Received: from PHANATIQUE.MIT.EDU (dhcp-18-111-28-78.dyn.mit.edu [18.111.28.78])
	(authenticated bits=0)
        (User authenticated as nelhage@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id n6G2CTWu023488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 15 Jul 2009 22:12:30 -0400 (EDT)
X-Mailer: git-send-email 1.6.3.3
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123353>

`resizeclistpanes' and `resizedetpanes' both contain logic that
clearly means to work in terms of columns of text, but are using APIs
that return pixels. Scale their inputs and outputs by $charspc
appropriately, resulting in much saner resize behavior.

In addition, keep the widths as floats through intermediate
calculations, which is necessary for smooth resizing behavior now that
we are working in columns.

Signed-off-by: Nelson Elhage <nelhage@mit.edu>
---
 gitk-git/gitk |   28 +++++++++++++++-------------
 1 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4604c83..29e9442 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -2575,17 +2575,18 @@ proc savestuff {w} {
 }
 
 proc resizeclistpanes {win w} {
-    global oldwidth
+    global oldwidth charspc
     if {[info exists oldwidth($win)]} {
 	set s0 [$win sash coord 0]
 	set s1 [$win sash coord 1]
+	set w [expr {1.0 * $w / $charspc}]
 	if {$w < 60} {
-	    set sash0 [expr {int($w/2 - 2)}]
-	    set sash1 [expr {int($w*5/6 - 2)}]
+	    set sash0 [expr {$w/2 - 2}]
+	    set sash1 [expr {$w*5/6 - 2}]
 	} else {
-	    set factor [expr {1.0 * $w / $oldwidth($win)}]
-	    set sash0 [expr {int($factor * [lindex $s0 0])}]
-	    set sash1 [expr {int($factor * [lindex $s1 0])}]
+	    set factor [expr {$w / $oldwidth($win)}]
+	    set sash0 [expr {$factor * [lindex $s0 0] / $charspc}]
+	    set sash1 [expr {$factor * [lindex $s1 0] / $charspc}]
 	    if {$sash0 < 30} {
 		set sash0 30
 	    }
@@ -2599,21 +2600,22 @@ proc resizeclistpanes {win w} {
 		}
 	    }
 	}
-	$win sash place 0 $sash0 [lindex $s0 1]
-	$win sash place 1 $sash1 [lindex $s1 1]
+	$win sash place 0 [expr {int($charspc * $sash0)}] [lindex $s0 1]
+	$win sash place 1 [expr {int($charspc * $sash1)}] [lindex $s1 1]
     }
     set oldwidth($win) $w
 }
 
 proc resizecdetpanes {win w} {
-    global oldwidth
+    global oldwidth charspc
     if {[info exists oldwidth($win)]} {
 	set s0 [$win sash coord 0]
+	set w [expr {1.0 * $w / $charspc}]
 	if {$w < 60} {
-	    set sash0 [expr {int($w*3/4 - 2)}]
+	    set sash0 [expr {$w*3/4 - 2}]
 	} else {
-	    set factor [expr {1.0 * $w / $oldwidth($win)}]
-	    set sash0 [expr {int($factor * [lindex $s0 0])}]
+	    set factor [expr {$w / $oldwidth($win)}]
+	    set sash0 [expr {$factor * [lindex $s0 0] / $charspc}]
 	    if {$sash0 < 45} {
 		set sash0 45
 	    }
@@ -2621,7 +2623,7 @@ proc resizecdetpanes {win w} {
 		set sash0 [expr {$w - 15}]
 	    }
 	}
-	$win sash place 0 $sash0 [lindex $s0 1]
+	$win sash place 0 [expr {int($charspc * $sash0)}] [lindex $s0 1]
     }
     set oldwidth($win) $w
 }
-- 
1.6.3.3
