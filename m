From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] revision: avoid work after --max-count is reached
Date: Fri, 13 Jul 2012 03:53:26 -0400
Message-ID: <20120713075326.GA32206@sigill.intra.peff.net>
References: <20120713075023.GA31618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 09:53:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spagw-0006Ca-BD
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 09:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827Ab2GMHx3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 03:53:29 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:58661
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab2GMHx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 03:53:28 -0400
Received: (qmail 32565 invoked by uid 107); 13 Jul 2012 07:53:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jul 2012 03:53:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2012 03:53:26 -0400
Content-Disposition: inline
In-Reply-To: <20120713075023.GA31618@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201393>

On Fri, Jul 13, 2012 at 03:50:23AM -0400, Jeff King wrote:

>  revision.c | 39 +++++++++++++++++++--------------------
>  1 file changed, 19 insertions(+), 20 deletions(-)

BTW, the patch is slightly hard to read because of the re-indentation.
Here it is with "-w -U5":

diff --git a/revision.c b/revision.c
index 5b81a92..7e39655 100644
--- a/revision.c
+++ b/revision.c
@@ -2359,32 +2359,31 @@ static struct commit *get_revision_internal(struct rev_info *revs)
 			c->object.flags |= SHOWN;
 		return c;
 	}
 
 	/*
-	 * Now pick up what they want to give us
+	 * If our max_count counter has reached zero, then we are done. We
+	 * don't simply return NULL because we still might need to show
+	 * boundary commits. But we want to avoid calling get_revision_1, which
+	 * might do a considerable amount of work finding the next commit only
+	 * for us to throw it away.
+	 *
+	 * If it is non-zero, then either we don't have a max_count at all
+	 * (-1), or it is still counting, in which case we decrement.
 	 */
+	if (revs->max_count) {
 		c = get_revision_1(revs);
 		if (c) {
 			while (0 < revs->skip_count) {
 				revs->skip_count--;
 				c = get_revision_1(revs);
 				if (!c)
 					break;
 			}
 		}
 
-	/*
-	 * Check the max_count.
-	 */
-	switch (revs->max_count) {
-	case -1:
-		break;
-	case 0:
-		c = NULL;
-		break;
-	default:
+		if (revs->max_count > 0)
 			revs->max_count--;
 	}
 
 	if (c)
 		c->object.flags |= SHOWN;
-- 
1.7.11.35.gbaf554e.dirty
