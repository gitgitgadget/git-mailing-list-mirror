From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: [PATCH/resend] gitk: Handle 'copy from' and 'copy to' in diff headers.
Date: Mon, 20 Aug 2007 15:27:54 +0200
Organization: eudaptics software gmbh
Message-ID: <46C996DA.E712D739@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Aug 20 15:27:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN7Hl-0000rx-9e
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 15:27:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751658AbXHTN1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 09:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbXHTN1I
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 09:27:08 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:54140 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751255AbXHTN1H (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 09:27:07 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IN7Hc-000271-1f; Mon, 20 Aug 2007 15:27:04 +0200
Received: from eudaptics.com (unknown [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 24FBB54D; Mon, 20 Aug 2007 15:27:03 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 1.3 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, AWL=-0.380, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56216>

From: Johannes Sixt <johannes.sixt@telecom.at>

If a commit contained a copy operation, the file name was not correctly
determined, and the corresponding part of the patch could not be
navigated to from the list of files.

Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---
	This patch was probably lost in the noise.
	-- Hannes

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
