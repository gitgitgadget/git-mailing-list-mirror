From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] for_each_reflog_ent: be forgiving about missing message
Date: Fri, 9 Feb 2007 00:59:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702090057210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160702071721s401ea38fxa8eb71bb694a6915@mail.gmail.com>
 <Pine.LNX.4.63.0702082021210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <eqfu36$lb3$1@sea.gmane.org> <Pine.LNX.4.63.0702082040390.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vveicw850.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:59:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJBA-0008Up-4W
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:59:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965744AbXBHX7t (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965741AbXBHX7t
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:59:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:48709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1422729AbXBHX7s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:59:48 -0500
Received: (qmail invoked by alias); 08 Feb 2007 23:59:47 -0000
X-Provags-ID: V01U2FsdGVkX19lARtDLrplqU3ZMb/jQi/HJuB1kPHLodm3V1Q+XM
	PPtg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vveicw850.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39133>


Some reflogs are/were generated without a message; do not plainly
ignore those entries.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	On Thu, 8 Feb 2007, Junio C Hamano wrote:

	> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
	> 
	> > On Thu, 8 Feb 2007, Jakub Narebski wrote:
	> >
	> >> StGIT used to produce no reflog messages; I don't know if 
	> >> this has improved. But you can have old reflog entries with 
	> >> empty messages; git log -g should deal with them IMHO.
	> >
	> > I just tried. An empty string is not enough. The tab before 
	> > the message has to be lacking, too.
	> >
	> > Here's a small patch, if you have to have it.
	> 
	> I think this is necessary for v1.5.0.  I'd appreciate a properly
	> signed-off log message.

	Voila!

 refs.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/refs.c b/refs.c
index 7e07fc4..ba5bd2d 100644
--- a/refs.c
+++ b/refs.c
@@ -1189,12 +1189,14 @@ int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data)
 		    !message || message[0] != ' ' ||
 		    (message[1] != '+' && message[1] != '-') ||
 		    !isdigit(message[2]) || !isdigit(message[3]) ||
-		    !isdigit(message[4]) || !isdigit(message[5]) ||
-		    message[6] != '\t')
+		    !isdigit(message[4]) || !isdigit(message[5]))
 			continue; /* corrupt? */
 		email_end[1] = '\0';
 		tz = strtol(message + 1, NULL, 10);
-		message += 7;
+		if (message[6] != '\t')
+			message += 6;
+		else
+			message += 7;
 		ret = fn(osha1, nsha1, buf+82, timestamp, tz, message, cb_data);
 		if (ret)
 			break;
