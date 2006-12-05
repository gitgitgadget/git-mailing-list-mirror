X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] xdl_merge(): fix and simplify conflict handling
Date: Tue, 5 Dec 2006 22:15:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612052209030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <456FD461.4080002@saville.com> <Pine.LNX.4.64.0611302330000.3695@woody.osdl.org>
 <456FDF24.1070001@saville.com> <Pine.LNX.4.64.0612012018490.3476@woody.osdl.org>
 <7vejri20mf.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612021131140.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <4575B32F.5060108@ramsay1.demon.co.uk> <Pine.LNX.4.64.0612051023460.3542@woody.osdl.org>
 <Pine.LNX.4.63.0612051949290.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vac22glzz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 5 Dec 2006 21:15:47 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vac22glzz.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33373>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Grhde-0004WD-GY for gcvg-git@gmane.org; Tue, 05 Dec
 2006 22:15:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031451AbWLEVPj (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 5 Dec 2006
 16:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031494AbWLEVPj
 (ORCPT <rfc822;git-outgoing>); Tue, 5 Dec 2006 16:15:39 -0500
Received: from mail.gmx.net ([213.165.64.20]:52443 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1031451AbWLEVPi
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 5 Dec 2006 16:15:38 -0500
Received: (qmail invoked by alias); 05 Dec 2006 21:15:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp042) with SMTP; 05 Dec 2006 22:15:35 +0100
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org


Suppose you have changes in new1 to the original lines 10-20,
and changes in new2 to the original lines 15-25, then the
changes to 10-25 conflict. But it is possible that the next
changes in new1 still overlap with this change to new2.

So, in the next iteration we have to look at the same change
to new2 again.

The old code tried to be a bit too clever. The new code is
shorter and more to the point: do not fiddle with the ranges
at all.

Also, xdl_append_merge() tries harder to combine conflicts.
This is necessary, because with the above simplification,
some conflicts would not be recognized as conflicts otherwise:

In the above scenario, it is possible that there is no other
change to new1. Absent the combine logic, the change in new2
would be recorded _again_, but as a non-conflict.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Tue, 5 Dec 2006, Junio C Hamano wrote:

	> However, the conflict 'next' leaves seems a bit suspicious.
	> Trying to reproduce
	> 
	> 	56f9686c4d1e1d586b731b815bd98d70f84ecda4
	> 
	> gives an interesting illustration.

	This is fixed now.

 xdiff/xmerge.c |   21 +++++----------------
 1 files changed, 5 insertions(+), 16 deletions(-)

diff --git a/xdiff/xmerge.c b/xdiff/xmerge.c
index 1fe7a1b..352207e 100644
--- a/xdiff/xmerge.c
+++ b/xdiff/xmerge.c
@@ -38,8 +38,9 @@ static int xdl_append_merge(xdmerge_t **merge, int mode,
 		long i1, long chg1, long i2, long chg2)
 {
 	xdmerge_t *m = *merge;
-	if (m && mode == m->mode &&
-			(i1 == m->i1 + m->chg1 || i2 == m->i2 + m->chg2)) {
+	if (m && (i1 <= m->i1 + m->chg1 || i2 <= m->i2 + m->chg2)) {
+		if (mode != m->mode)
+			m->mode = 0;
 		m->chg1 = i1 + chg1 - m->i1;
 		m->chg2 = i2 + chg2 - m->i2;
 	} else {
@@ -313,22 +314,10 @@ static int xdl_do_merge(xdfenv_t *xe1, xdchange_t *xscr1, const char *name1,
 		i1 = xscr1->i1 + xscr1->chg1;
 		i2 = xscr2->i1 + xscr2->chg1;
 
-		if (i1 > i2) {
-			xscr1->chg1 -= i1 - i2;
-			xscr1->i1 = i2;
-			xscr1->i2 += xscr1->chg2;
-			xscr1->chg2 = 0;
+		if (i1 >= i2)
 			xscr2 = xscr2->next;
-		} else if (i2 > i1) {
-			xscr2->chg1 -= i2 - i1;
-			xscr2->i1 = i1;
-			xscr2->i2 += xscr2->chg2;
-			xscr2->chg2 = 0;
-			xscr1 = xscr1->next;
-		} else {
+		if (i2 >= i1)
 			xscr1 = xscr1->next;
-			xscr2 = xscr2->next;
-		}
 	}
 	while (xscr1) {
 		if (!changes)
-- 
1.4.4.1.g394ac-dirty
