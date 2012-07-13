From: Jeff King <peff@peff.net>
Subject: [PATCH] revision: avoid work after --max-count is reached
Date: Fri, 13 Jul 2012 03:50:23 -0400
Message-ID: <20120713075023.GA31618@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git-dev@github.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 13 09:50:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spae0-00006Y-HX
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 09:50:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754641Ab2GMHu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 03:50:27 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:58651
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754547Ab2GMHu0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 03:50:26 -0400
Received: (qmail 32461 invoked by uid 107); 13 Jul 2012 07:50:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jul 2012 03:50:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2012 03:50:23 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201392>

During a revision traversal in which --max-count has been
specified, we decrement a counter for each revision returned
by get_revision. When it hits 0, we typically return NULL
(the exception being if we still have boundary commits to
show).

However, before we check the counter, we call get_revision_1
to get the next commit. This might involve looking at a
large number of commits if we have restricted the traversal
(e.g., we might traverse until we find the next commit whose
diff actually matches a pathspec).

There's no need to make this get_revision_1 call when our
counter runs out. If we are not in --boundary mode, we will
just throw away the result and immediately return NULL. If
we are in --boundary mode, then we will still throw away the
result, and then start showing the boundary commits.
However, as git_revision_1 does not impact the boundary
list, it should not have an impact.

In most cases, avoiding this work will not be especially
noticeable. However, in some cases, it can make a big
difference:

  [before]
  $ time git rev-list -1 origin Documentation/RelNotes/1.7.11.2.txt
  8d141a1d562abb31f27f599dbf6e10a6c06ed73e

  real    0m0.301s
  user    0m0.280s
  sys     0m0.016s

  [after]
  $ time git rev-list -1 origin Documentation/RelNotes/1.7.11.2.txt
  8d141a1d562abb31f27f599dbf6e10a6c06ed73e

  real    0m0.010s
  user    0m0.008s
  sys     0m0.000s

Note that the output is produced almost instantaneously in
the first case, and then git uselessly spends a long time
looking for the next commit to touch that file (but there
isn't one, and we traverse all the way down to the roots).

Signed-off-by: Jeff King <peff@peff.net>
---
I'd really like more sets of eyes to make sure this won't
cause a weird regression. Calling get_revision_1 does tweak
the flags on objects as it traverses, so I'm worried about
some other code relying on this side effect of get_revision
in some way. That does seem a bit crazy to me, though.

 revision.c | 39 +++++++++++++++++++--------------------
 1 file changed, 19 insertions(+), 20 deletions(-)

diff --git a/revision.c b/revision.c
index 5b81a92..7e39655 100644
--- a/revision.c
+++ b/revision.c
@@ -2361,29 +2361,28 @@ static struct commit *get_revision_internal(struct rev_info *revs)
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
-	c = get_revision_1(revs);
-	if (c) {
-		while (0 < revs->skip_count) {
-			revs->skip_count--;
-			c = get_revision_1(revs);
-			if (!c)
-				break;
+	if (revs->max_count) {
+		c = get_revision_1(revs);
+		if (c) {
+			while (0 < revs->skip_count) {
+				revs->skip_count--;
+				c = get_revision_1(revs);
+				if (!c)
+					break;
+			}
 		}
-	}
 
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
-		revs->max_count--;
+		if (revs->max_count > 0)
+			revs->max_count--;
 	}
 
 	if (c)
-- 
1.7.11.35.gbaf554e.dirty
