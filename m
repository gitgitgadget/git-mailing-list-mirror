From: Jeff King <peff@peff.net>
Subject: [PATCH 2/5] fetch-pack: avoid quadratic behavior in remove_duplicates
Date: Mon, 21 May 2012 18:17:20 -0400
Message-ID: <20120521221720.GB22914@sigill.intra.peff.net>
References: <20120521221417.GA22664@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Martin Fick <mfick@codeaurora.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 22 00:17:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SWauu-00020h-03
	for gcvg-git-2@plane.gmane.org; Tue, 22 May 2012 00:17:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759434Ab2EUWRX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 May 2012 18:17:23 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:51134
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755465Ab2EUWRX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 May 2012 18:17:23 -0400
Received: (qmail 6971 invoked by uid 107); 21 May 2012 22:17:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 May 2012 18:17:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2012 18:17:20 -0400
Content-Disposition: inline
In-Reply-To: <20120521221417.GA22664@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198137>

We remove duplicate entries from the list of refs we are
fed in fetch-pack. The original algorithm is quadratic over
the number of refs, but since the list is now guaranteed to
be sorted, we can do it in linear time.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 380743e..3522d8e 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -834,21 +834,12 @@ static int remove_duplicates(int nr_heads, char **heads)
 {
 	int src, dst;
 
-	for (src = dst = 0; src < nr_heads; src++) {
-		/* If heads[src] is different from any of
-		 * heads[0..dst], push it in.
-		 */
-		int i;
-		for (i = 0; i < dst; i++) {
-			if (!strcmp(heads[i], heads[src]))
-				break;
-		}
-		if (i < dst)
-			continue;
-		if (src != dst)
-			heads[dst] = heads[src];
-		dst++;
-	}
+	if (!nr_heads)
+		return 0;
+
+	for (src = dst = 1; src < nr_heads; src++)
+		if (strcmp(heads[src], heads[dst-1]))
+			heads[dst++] = heads[src];
 	return dst;
 }
 
-- 
1.7.10.1.19.g711d603
