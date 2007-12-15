From: Steffen Prohaska <prohaska@zib.de>
Subject: [RFC 3/4] gitk: Refactor getblobdiffline to split off adddiffline
Date: Sat, 15 Dec 2007 17:51:44 +0100
Message-ID: <11977375051617-git-send-email-prohaska@zib.de>
References: <1197737505128-git-send-email-prohaska@zib.de>
 <1197737505599-git-send-email-prohaska@zib.de>
Cc: Steffen Prohaska <prohaska@zib.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 15 17:52:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J3aFJ-0000ng-Av
	for gcvg-git-2@gmane.org; Sat, 15 Dec 2007 17:52:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754731AbXLOQvv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Dec 2007 11:51:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755891AbXLOQvu
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Dec 2007 11:51:50 -0500
Received: from mailer.zib.de ([130.73.108.11]:44313 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753653AbXLOQvs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Dec 2007 11:51:48 -0500
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id lBFGpkGI006056
	for <git@vger.kernel.org>; Sat, 15 Dec 2007 17:51:46 +0100 (CET)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id lBFGpj9E029051;
	Sat, 15 Dec 2007 17:51:45 +0100 (MET)
X-Mailer: git-send-email 1.5.2.4
In-Reply-To: <1197737505599-git-send-email-prohaska@zib.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68395>

getblobdiffline used to read from a file descriptor, parsed
the line read, and displayed the line nicely formatted.

Parsing and displaying the line is split off to a separate
function adddiffline.

---
 gitk-git/gitk |   30 +++++++++++++++++++-----------
 1 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index ca121e4..3c4ec03 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -5324,18 +5324,11 @@ proc makediffhdr {fname ids} {
     $ctext insert $curdiffstart "$pad $fname $pad" filesep
 }
 
-proc getblobdiffline {bdf ids} {
+proc adddiffline {line ids} {
     global diffids blobdifffd ctext curdiffstart
     global diffnexthead diffnextnote difffilestart
     global diffinhdr treediffs
 
-    set nr 0
-    $ctext conf -state normal
-    while {[incr nr] <= 1000 && [gets $bdf line] >= 0} {
-	if {$ids != $diffids || $bdf != $blobdifffd($ids)} {
-	    close $bdf
-	    return 0
-	}
 	if {![string compare -length 11 "diff --git " $line]} {
 	    # trim off "diff --git "
 	    set line [string range $line 11 end]
@@ -5357,7 +5350,7 @@ proc getblobdiffline {bdf ids} {
 	    if {!(($l & 1) && [string index $line $i] eq " " &&
 		  [string range $line 2 [expr {$i - 1}]] eq \
 		      [string range $line [expr {$i + 3}] end])} {
-		continue
+		return
 	    }
 	    # unescape if quoted and chop off the a/ from the front
 	    if {[string index $line 0] eq "\""} {
@@ -5391,10 +5384,10 @@ proc getblobdiffline {bdf ids} {
 		makediffhdr $fname $ids
 	    } elseif {[string compare -length 3 $line "---"] == 0} {
 		# do nothing
-		continue
+		return
 	    } elseif {[string compare -length 3 $line "+++"] == 0} {
 		set diffinhdr 0
-		continue
+		return
 	    }
 	    $ctext insert end "$line\n" filesep
 
@@ -5411,6 +5404,21 @@ proc getblobdiffline {bdf ids} {
 		$ctext insert end "$line\n" hunksep
 	    }
 	}
+}
+
+proc getblobdiffline {bdf ids} {
+    global diffids blobdifffd ctext curdiffstart
+    global diffnexthead diffnextnote difffilestart
+    global diffinhdr treediffs
+
+    set nr 0
+    $ctext conf -state normal
+    while {[incr nr] <= 1000 && [gets $bdf line] >= 0} {
+	if {$ids != $diffids || $bdf != $blobdifffd($ids)} {
+	    close $bdf
+	    return 0
+	}
+	adddiffline $line $ids
     }
     $ctext conf -state disabled
     if {[eof $bdf]} {
-- 
1.5.4.rc0.37.geff3a-dirty
