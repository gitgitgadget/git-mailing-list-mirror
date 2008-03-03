From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: fix a corner case when switching views
Date: Mon, 3 Mar 2008 20:59:52 +0100
Message-ID: <200803032059.52960.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:11:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWH0B-0002CI-5i
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 21:11:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754984AbYCCUKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 15:10:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754954AbYCCUKL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 15:10:11 -0500
Received: from smtp.katamail.com ([62.149.157.154]:51473 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754847AbYCCUKJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 15:10:09 -0500
Received: (qmail 21354 invoked by uid 89); 3 Mar 2008 20:09:47 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp2-pc
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=5.0 tests=RDNS_NONE autolearn=disabled
	version=3.2.3
Received: from unknown (HELO host122-56-static.104-80-b.business.telecomitalia.it) (barra?cuda@katamail.com@80.104.56.122)
  by smtp2-pc with SMTP; 3 Mar 2008 20:09:46 -0000
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75982>

Switching from a view that shows no commit ("No commits selected")
to another view, back and forth, can trigger an error like:

	can't read "yscreen": no such variable
	can't read "yscreen": no such variable
	    while executing
	"expr {[yc $row] - $yscreen}"
	    (procedure "showview" line 91)
	    invoked from within
	"showview 2"
	    invoked from within
	".#bar.#bar#view invoke active"
	    ("uplevel" body line 1)
	    invoked from within
	"uplevel #0 [list $w invoke active]"
	    (procedure "tk::MenuInvoke" line 50)
	    invoked from within
	"tk::MenuInvoke .#bar.#bar#view 1"
	    (command bound to event)

This patch avoids this with a check on yscreen and ytop in procedure
showview.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---
 gitk |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index f1f21e9..371654f 100755
--- a/gitk
+++ b/gitk
@@ -2124,11 +2124,15 @@ proc showview {n} {
 	set row $commitrow($n,$selid)
 	# try to get the selected row in the same position on the screen
 	set ymax [lindex [$canv cget -scrollregion] 3]
-	set ytop [expr {[yc $row] - $yscreen}]
-	if {$ytop < 0} {
-	    set ytop 0
+	if {[info exists yscreen]} {
+	    set ytop [expr {[yc $row] - $yscreen}]
+	}
+	if {[info exists ytop]} {
+	    if {$ytop < 0} {
+		set ytop 0
+	    }
+	    set yf [expr {$ytop * 1.0 / $ymax}]
 	}
-	set yf [expr {$ytop * 1.0 / $ymax}]
     }
     allcanvs yview moveto $yf
     drawvisible
-- 
1.5.4.3

