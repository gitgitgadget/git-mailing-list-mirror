From: Michele Ballabio <barra_cuda@katamail.com>
Subject: [PATCH] gitk: fix in procedure drawcommits
Date: Mon, 3 Sep 2007 15:59:49 +0200
Message-ID: <200709031559.49143.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Mon Sep 03 15:57:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISCR7-0007ch-Vr
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 15:57:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbXICN5u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 09:57:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbXICN5u
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 09:57:50 -0400
Received: from slim-3a.inet.it ([213.92.5.124]:54294 "EHLO slim-3a.inet.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751091AbXICN5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 09:57:49 -0400
Received: from host78-57-static.104-80-b.business.telecomitalia.it ([::ffff:80.104.57.78]) by slim-3a.inet.it via I-SMTP-5.4.4-547
	id ::ffff:80.104.57.78+8IuFmoCkSA6D; Mon, 03 Sep 2007 15:57:46 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57488>

This patch indroduces a check before unsetting an array element.

Without this, gitk may complain with

	can't unset "prevlines(...)": no such element in array

when scrolling the history view, bugging the user.

Signed-off-by: Michele Ballabio <barra_cuda@katamail.com>
---

I don't really know if this is the right fix, but it seems to work.

An example of this error:

can't unset "prevlines(a3b4383d69e0754346578c85ba8ff7c05bd88705)": no such element in array
can't unset "prevlines(a3b4383d69e0754346578c85ba8ff7c05bd88705)": no such element in array
    while executing
"unset prevlines($lid)"
    (procedure "drawcommits" line 39)
    invoked from within
"drawcommits $row $endrow"
    (procedure "drawfrac" line 10)
    invoked from within
"drawfrac $f0 $f1"
    (procedure "scrollcanv" line 3)
    invoked from within
"scrollcanv .tf.histframe.csb 0.00672513 0.0087015"


The first "bad" commit is 9f1afe05c3ab7228e21ba3666c6e35d693149b37
(merged in 1.3.0-rc1):

	gitk: New improved gitk

 gitk |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitk b/gitk
index 300fdce..527b716 100755
--- a/gitk
+++ b/gitk
@@ -3697,7 +3697,9 @@ proc drawcommits {row {endrow {}}} {
 
 	if {[info exists lineends($r)]} {
 	    foreach lid $lineends($r) {
-		unset prevlines($lid)
+		if {[info exists prevlines($lid)]} {
+		    unset prevlines($lid)
+	        }
 	    }
 	}
 	set rowids [lindex $rowidlist $r]
-- 
1.5.3
