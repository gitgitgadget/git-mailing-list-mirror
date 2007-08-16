From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] gitk: Handle 'copy from' and 'copy to' in diff headers.
Date: Thu, 16 Aug 2007 14:32:29 +0200
Message-ID: <11872675493132-git-send-email-johannes.sixt@telecom.at>
Cc: git@vger.kernel.org, Johannes Sixt <johannes.sixt@telecom.at>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 14:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILeWm-00060n-63
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 14:32:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754259AbXHPMcg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 08:32:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbXHPMcg
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 08:32:36 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28360 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754239AbXHPMcf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 08:32:35 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@eudaptics.com>)
	id 1ILeWe-0000Vw-AC; Thu, 16 Aug 2007 14:32:33 +0200
Received: from srv.linz.eudaptics (srv.linz.eudaptics [192.168.1.4])
	by linz.eudaptics.com (Postfix) with ESMTP
	id B27AAB662; Thu, 16 Aug 2007 14:32:31 +0200 (CEST)
Received: by srv.linz.eudaptics (Postfix, from userid 503)
	id E783F101; Thu, 16 Aug 2007 14:32:30 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.rc5.15.g8ddb
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56012>

If a commit contained a copy operation, the file name was not correctly
determined, and the corresponding part of the patch could not be
navigated to from the list of files.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
 gitk |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index 57617d5..07b4a26 100755
--- a/gitk
+++ b/gitk
@@ -5116,8 +5116,8 @@ proc getblobdiffline {bdf ids} {
 	    # the middle char will be a space, and the two bits either
 	    # side will be a/name and b/name, or "a/name" and "b/name".
 	    # If the name has changed we'll get "rename from" and
-	    # "rename to" lines following this, and we'll use them
-	    # to get the filenames.
+	    # "rename to" or "copy from" and "copy to" lines following this,
+	    # and we'll use them to get the filenames.
 	    # This complexity is necessary because spaces in the filename(s)
 	    # don't get escaped.
 	    set l [string length $line]
@@ -5141,8 +5141,9 @@ proc getblobdiffline {bdf ids} {
 	    set diffinhdr 0
 
 	} elseif {$diffinhdr} {
-	    if {![string compare -length 12 "rename from " $line]} {
-		set fname [string range $line 12 end]
+	    if {![string compare -length 12 "rename from " $line] ||
+		![string compare -length 10 "copy from " $line]} {
+		set fname [string range $line [expr 6 + [string first " from " $line] ] end]
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
@@ -5150,8 +5151,9 @@ proc getblobdiffline {bdf ids} {
 		if {$i >= 0} {
 		    setinlist difffilestart $i $curdiffstart
 		}
-	    } elseif {![string compare -length 10 $line "rename to "]} {
-		set fname [string range $line 10 end]
+	    } elseif {![string compare -length 10 $line "rename to "] ||
+		      ![string compare -length 8 $line "copy to "]} {
+		set fname [string range $line [expr 4 + [string first " to " $line] ] end]
 		if {[string index $fname 0] eq "\""} {
 		    set fname [lindex $fname 0]
 		}
-- 
1.5.3.rc5.15.g8ddb
