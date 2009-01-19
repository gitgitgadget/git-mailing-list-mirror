From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] @{-<n>}: avoid crash with corrupt reflog
Date: Mon, 19 Jan 2009 13:41:05 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901191338470.3586@pacific.mpi-cbg.de>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de> <7vprijra52.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 19 13:43:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOtSY-0007K9-3d
	for gcvg-git-2@gmane.org; Mon, 19 Jan 2009 13:42:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758917AbZASMlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Jan 2009 07:41:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758860AbZASMlH
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Jan 2009 07:41:07 -0500
Received: from mail.gmx.net ([213.165.64.20]:57136 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758851AbZASMlE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Jan 2009 07:41:04 -0500
Received: (qmail invoked by alias); 19 Jan 2009 12:41:02 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp042) with SMTP; 19 Jan 2009 13:41:02 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TpF0+1dCTLONi0rhcWanxPjLANmJafSn12s/cza
	rCTqHIaACuCWuJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vljt7r9mq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106352>


The earlier code checked if a " to " was found after "checkout: Moving
from ".  However, it then went on to access the pointer to " to ",
regardless if it was still NULL (if no " to " was found) or not.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	You might want to squash this into "sha1_name: tweak @{-N} 
	lookup", just as a safety belt.

 sha1_name.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 9e5f444..853bac6 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -705,18 +705,18 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	size_t len;
 	int nth;
 
-	if (!prefixcmp(message, "checkout: moving from ")) {
-		match = message + strlen("checkout: moving from ");
-		if ((target = strstr(match, " to ")) != NULL)
-			target += 4;
-	}
-
-	if (!match)
+	if (prefixcmp(message, "checkout: moving from "))
 		return 0;
 
-	len = target - match - 4;
-	if (target[len] == '\n' && !strncmp(match, target, len))
-		return 0;
+	match = message + strlen("checkout: moving from ");
+	if ((target = strstr(match, " to ")) != NULL) {
+		len = target - match - 4;
+		target += 4;
+		if (target[len] == '\n' && !strncmp(match, target, len))
+			return 0;
+	}
+	else
+		len = strchrnul(match, ' ') - match;
 
 	nth = cb->cnt++ % cb->alloc;
 	strbuf_reset(&cb->buf[nth]);
-- 
1.6.1.347.g7b62749
