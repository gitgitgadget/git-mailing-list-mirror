From: Jeff King <peff@peff.net>
Subject: [PATCH] lookup_object: prioritize recently found objects
Date: Wed, 1 May 2013 16:34:50 -0400
Message-ID: <20130501203449.GA12535@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 01 22:34:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UXdjt-00070t-6d
	for gcvg-git-2@plane.gmane.org; Wed, 01 May 2013 22:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757112Ab3EAUey (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 May 2013 16:34:54 -0400
Received: from cloud.peff.net ([50.56.180.127]:50688 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756938Ab3EAUew (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 May 2013 16:34:52 -0400
Received: (qmail 5567 invoked by uid 102); 1 May 2013 20:35:08 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 May 2013 15:35:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 May 2013 16:34:50 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223139>

The lookup_object function is backed by a hash table of all
objects we have seen in the program. We manage collisions
with a linear walk over the colliding entries, checking each
with hashcmp(). The main cost of lookup is in these
hashcmp() calls; finding our item in the first slot is
cheaper than finding it in the second slot, which is cheaper
than the third, and so on.

If we assume that there is some locality to the object
lookups (e.g., if X and Y collide, and we have just looked
up X, the next lookup is more likely to be for X than for
Y), then we can improve our average lookup speed by checking
X before Y.

This patch does so by swapping a found item to the front of
the collision chain. The p0001 perf test reveals that this
does indeed exploit locality in the case of "rev-list --all
--objects":

Test                               origin          this tree
-------------------------------------------------------------------------
0001.1: rev-list --all             0.40(0.38+0.02) 0.40(0.36+0.03) +0.0%
0001.2: rev-list --all --objects   2.24(2.17+0.05) 1.86(1.79+0.05) -17.0%

This is not surprising, as the full object traversal will
hit the same tree entries over and over (e.g., for every
commit that doesn't change "Documentation/", we will have to
look up the same sha1 just to find out that we already
processed it).

The reason why this technique works (and does not violate
any properties of the hash table) is subtle and bears some
explanation. Let's imagine we get a lookup for sha1 `X`, and
it hashes to bucket `i` in our table. That stretch of the
table may look like:

index       | i-1 |  i  | i+1 | i+2 |
       -----------------------------------
entry   ... |  A  |  B  |  C  |  X  | ...
       -----------------------------------

We start our probe at i, see that B does not match, nor does
C, and finally find X. There may be multiple C's in the
middle, but we know that there are no empty slots (or else
we would not find X at all).

We do not know the original index of B; it may be `i`, or it
may be less than i (e.g., if it were `i-1`, it would collide
with A and spill over into the `i` bucket). So it is
acceptable for us to move it to the right of a contiguous
stretch of entries (because we will find it from a linear
walk starting anywhere at `i` or before), but never to the
left (if we moved it to `i-1`, we would miss it when
starting our walk at `i`).

We do know the original index of X; it is `i`, so it is safe
to place it anywhere in the contiguous stretch between `i`
and where we found it (`i+2` in the this case).

This patch does a pure swap; after finding X in the
situation above, we would end with:

index       | i-1 |  i  | i+1 | i+2 |
       -----------------------------------
entry   ... |  A  |  X  |  C  |  B  | ...
       -----------------------------------

We could instead bump X into the `i` slot, and then shift
the whole contiguous chain down by one, resulting in:

index       | i-1 |  i  | i+1 | i+2 |
       -----------------------------------
entry   ... |  A  |  X  |  B  |  C  | ...
       -----------------------------------

That puts our chain in true most-recently-used order.
However, experiments show that it is not any faster (and in
fact, is slightly slower due to the extra manipulation).

Signed-off-by: Jeff King <peff@peff.net>
---
The speedup on linux.git is less spectacular; I got about 9% improvement
versus stock git. However, when I combine this with the commit cache we
were looking at a few months ago, at which point the lookup_object time
starts to dominate, then doing this nets more like 20% on linux.git.

It may speed up other tree-oriented loads, too, but I didn't measure. At
the very least, it should generally not be making other loads worse.

 object.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index 20703f5..1ba2083 100644
--- a/object.c
+++ b/object.c
@@ -71,13 +71,13 @@ struct object *lookup_object(const unsigned char *sha1)
 
 struct object *lookup_object(const unsigned char *sha1)
 {
-	unsigned int i;
+	unsigned int i, first;
 	struct object *obj;
 
 	if (!obj_hash)
 		return NULL;
 
-	i = hashtable_index(sha1);
+	first = i = hashtable_index(sha1);
 	while ((obj = obj_hash[i]) != NULL) {
 		if (!hashcmp(sha1, obj->sha1))
 			break;
@@ -85,6 +85,11 @@ struct object *lookup_object(const unsigned char *sha1)
 		if (i == obj_hash_size)
 			i = 0;
 	}
+	if (obj && i != first) {
+		struct object *tmp = obj_hash[i];
+		obj_hash[i] = obj_hash[first];
+		obj_hash[first] = tmp;
+	}
 	return obj;
 }
 
-- 
1.8.2.2.10.geb24d2a
