From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: split up displacement penalty for hash
 collisions
Date: Fri, 16 Aug 2013 09:49:52 -0400
Message-ID: <20130816134952.GG20138@sigill.intra.peff.net>
References: <1376595306-6335-1-git-send-email-stefanbeller@googlemail.com>
 <87haeqdop3.fsf@linux-k42r.v.cablecom.net>
 <8761v6dm0r.fsf@linux-k42r.v.cablecom.net>
 <20130816095722.GA11201@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <stefanbeller@googlemail.com>, git@vger.kernel.org
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 16 15:50:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAKPg-00081N-Uu
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 15:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754609Ab3HPNtz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 09:49:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:56707 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754600Ab3HPNtz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 09:49:55 -0400
Received: (qmail 29154 invoked by uid 102); 16 Aug 2013 13:49:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 08:49:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 09:49:52 -0400
Content-Disposition: inline
In-Reply-To: <20130816095722.GA11201@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232429>

On Fri, Aug 16, 2013 at 05:57:22AM -0400, Jeff King wrote:

> In that case, it seems like we would want to move B to the second
> position. This lets the 2-hot case just keep swapping the hot items back
> and forth as quickly as possible. To the detriment of C, D, etc, which
> never get promoted. But the likelihood of having _3_ hot items in a
> collision chain is even less than 2.

That was one of the cases Stefan considered in the original patch, but
didn't show code. Here's my make-shift code to try it; one could also
parameterize it to shift down at most N items, and then just bump the
N+1th item to the end (so the existing behavior is N=0, my patch is N+1,
etc).

However, I measured no speedup at all. Oh well. It was worth a shot.

---
 object.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index d8a4b1f..f7ca969 100644
--- a/object.c
+++ b/object.c
@@ -71,7 +71,7 @@ struct object *lookup_object(const unsigned char *sha1)
 
 struct object *lookup_object(const unsigned char *sha1)
 {
-	unsigned int i, first;
+	unsigned int i, first, middle;
 	struct object *obj;
 
 	if (!obj_hash)
@@ -90,9 +90,22 @@ struct object *lookup_object(const unsigned char *sha1)
 		 * Move object to where we started to look for it so
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
+		 *
+		 * However, we don't want to penalize the object being
+		 * moved from the first position, so shift it down only one
+		 * slot, and bump the next object to the end. This is faster
+		 * than shifting the whole chain down, and covers the common
+		 * case of a few "hot" items near the front of the chain.
 		 */
+		int second = (first + 1) % obj_hash_size;
 		struct object *tmp = obj_hash[i];
-		obj_hash[i] = obj_hash[first];
+
+		if (i != second) {
+			obj_hash[i] = obj_hash[second];
+			obj_hash[second] = obj_hash[first];
+		} else
+			obj_hash[i] = obj_hash[first];
+
 		obj_hash[first] = tmp;
 	}
 	return obj;
-- 
1.8.4.rc2.28.g6bb5f3f
