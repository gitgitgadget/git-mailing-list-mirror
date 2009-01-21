From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [VALGRIND PATCH for nth_last patch series] Fix invalid memory
 access
Date: Wed, 21 Jan 2009 01:16:37 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901210113500.19014@racer>
References: <7v8wpcs38c.fsf@gitster.siamese.dyndns.org> <1232163011-20088-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0901170646560.3586@pacific.mpi-cbg.de> <200901171438.22504.trast@student.ethz.ch> <alpine.DEB.1.00.0901171602340.3586@pacific.mpi-cbg.de>
 <7vljt97nld.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901172028470.3586@pacific.mpi-cbg.de> <7vmydp5tqj.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901180201070.3586@pacific.mpi-cbg.de> <7vprilyt1w.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0901182152010.3586@pacific.mpi-cbg.de> <7vprijra52.fsf@gitster.siamese.dyndns.org> <7vljt7r9mq.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	Johannes Sixt <johannes.sixt@telecom.at>,
	Johan Herland <johan@herland.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 21 01:18:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LPQn3-0006xo-D5
	for gcvg-git-2@gmane.org; Wed, 21 Jan 2009 01:17:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758107AbZAUAQ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Jan 2009 19:16:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757923AbZAUAQ1
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jan 2009 19:16:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:33430 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757470AbZAUAQ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jan 2009 19:16:26 -0500
Received: (qmail invoked by alias); 21 Jan 2009 00:16:24 -0000
Received: from pD9EB302D.dip0.t-ipconnect.de (EHLO noname) [217.235.48.45]
  by mail.gmx.net (mp029) with SMTP; 21 Jan 2009 01:16:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18R8TlZF0MR/VCIRHSlNTNmRz0HijcE1EppuO/+4l
	2shH1Y6bqculhA
X-X-Sender: gene099@racer
In-Reply-To: <alpine.DEB.1.00.0901191331590.3586@pacific.mpi-cbg.de>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106548>


Please squash in.
---

	On Mon, 19 Jan 2009, Johannes Schindelin wrote:

	> @@ -720,7 +718,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
	>  	if (target[len] == '\n' && !strncmp(match, target, len))
	>  		return 0;

	This code is still not valid, as target[len] can be well after the 
	NUL marker.

	Found by valgrind.

 sha1_name.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sha1_name.c b/sha1_name.c
index 4d10705..803f9d2 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -735,7 +735,7 @@ static int grab_nth_branch_switch(unsigned char *osha1, unsigned char *nsha1,
 	if ((target = strstr(match, " to ")) != NULL) {
 		len = target - match;
 		target += 4;
-		if (target[len] == '\n' && !strncmp(match, target, len))
+		if (len == strlen(target) && !strncmp(match, target, len))
 			return 0;
 	}
 	else
-- 
1.6.1.243.g6c8bb35
