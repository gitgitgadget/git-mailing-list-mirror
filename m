From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [RFC/PATCH] interpolate '\n' as newline
Date: Fri, 6 Jul 2007 21:02:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707062100360.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jul 06 22:09:14 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I6u77-0005l8-Sv
	for gcvg-git@gmane.org; Fri, 06 Jul 2007 22:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762104AbXGFUJL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jul 2007 16:09:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762435AbXGFUJL
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jul 2007 16:09:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:60048 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762170AbXGFUJK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jul 2007 16:09:10 -0400
Received: (qmail invoked by alias); 06 Jul 2007 20:09:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 06 Jul 2007 22:09:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1816vpzk7M1FsSJR24xpzMQNNDodhwrNAU4Z4S7Qh
	+qjphrWm4TLgDu
X-X-Sender: gene099@racer.site
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51785>


All places which call interpolate() get this interpolation for free.

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>

---

	In the back of my head, I remembered that a few people
	were interested in this.

	Judging by the diffstat, it really escapes me why these people
	did not implement it.

	However, there is a chance that this change is not liked by
	all places that call interpolate(). merge-recursive can live
	with it, I guess. But daemon interpolates the path... However,
	it seems only the command line of daemon can change the string,
	so this change should be safe. There is only one other place in 
	git.git, the --pretty=format: stuff, and that is where the idea
	was born first.

 interpolate.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/interpolate.c b/interpolate.c
index 0082677..b322503 100644
--- a/interpolate.c
+++ b/interpolate.c
@@ -87,6 +87,12 @@ unsigned long interpolate(char *result, unsigned long reslen,
 				src += namelen;
 				continue;
 			}
+		} else if (c == '\\' && src[1] == 'n') {
+			if (newlen + 1 < reslen)
+				*dest++ = '\n';
+			src += 2;
+			newlen++;
+			continue;
 		}
 		/* Straight copy one non-interpolation character. */
 		if (newlen + 1 < reslen)
