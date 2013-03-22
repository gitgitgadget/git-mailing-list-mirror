From: Jeff King <peff@peff.net>
Subject: [PATCH 8/4] match-trees: drop "x = x" initializations
Date: Fri, 22 Mar 2013 12:21:55 -0400
Message-ID: <20130322162155.GB25857@sigill.intra.peff.net>
References: <20130322161837.GG3083@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 22 17:22:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJ4ji-000590-9J
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 17:22:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933914Ab3CVQWG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 12:22:06 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:35855 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933862Ab3CVQWF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 12:22:05 -0400
Received: (qmail 2132 invoked by uid 107); 22 Mar 2013 16:23:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Mar 2013 12:23:48 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Mar 2013 12:21:55 -0400
Content-Disposition: inline
In-Reply-To: <20130322161837.GG3083@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218819>

These nonsense assignments are meant to squelch gcc warnings
that the variables might be used uninitialized. However, gcc
gets it mostly right, realizing that we will either
extract tree entries from both sides, or we will hit a
"continue" statement and go to the top of the loop.

However, while getting this right for the "elem" and "path"
variables, it does not do so for the "mode" variables. Let's
drop the nonsense initialization where modern gcc does not
need them, and just set the modes to "0", along with a
comment. These values should never be used, but it makes
both gcc, as well as any compiler which does not like the "x
= x" initializations, happy.

While we're in the area, let's also update the loop
condition to use logical-OR rather than bitwise-OR. They should
be equivalent in this case, and the use of the latter was
probably a typo.

Signed-off-by: Jeff King <peff@peff.net>
---
Of the 8 patches, this is the one I find the least satisfying, if only
because I do not think gcc's failure is because of complicated control
flow, and rearranging the code would only hurt readability. And I'm
quite curious why it complains about "mode", but not about the other
variables, which are set in the exact same place (and why it would not
be able to handle such a simple control flow at all).

It makes me wonder if I am missing something, or there is some subtle
bug. But I can't see it. Other eyes appreciated.

 match-trees.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/match-trees.c b/match-trees.c
index 26f7ed1..4360f10 100644
--- a/match-trees.c
+++ b/match-trees.c
@@ -71,13 +71,13 @@ static int score_trees(const unsigned char *hash1, const unsigned char *hash2)
 	if (type != OBJ_TREE)
 		die("%s is not a tree", sha1_to_hex(hash2));
 	init_tree_desc(&two, two_buf, size);
-	while (one.size | two.size) {
-		const unsigned char *elem1 = elem1;
-		const unsigned char *elem2 = elem2;
-		const char *path1 = path1;
-		const char *path2 = path2;
-		unsigned mode1 = mode1;
-		unsigned mode2 = mode2;
+	while (one.size || two.size) {
+		const unsigned char *elem1;
+		const unsigned char *elem2;
+		const char *path1;
+		const char *path2;
+		unsigned mode1 = 0; /* make gcc happy */
+		unsigned mode2 = 0; /* make gcc happy */
 		int cmp;
 
 		if (one.size)
-- 
1.8.2.13.g0f18d3c
