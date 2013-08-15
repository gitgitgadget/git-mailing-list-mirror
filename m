From: Stefan Beller <stefanbeller@googlemail.com>
Subject: [PATCH] lookup_object: split up displacement penalty for hash collisions
Date: Thu, 15 Aug 2013 21:35:06 +0200
Message-ID: <1376595306-6335-1-git-send-email-stefanbeller@googlemail.com>
Cc: Stefan Beller <stefanbeller@googlemail.com>
To: git@vger.kernel.org, peff@peff.net
X-From: git-owner@vger.kernel.org Thu Aug 15 21:35:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VA3KA-0002JJ-S8
	for gcvg-git-2@plane.gmane.org; Thu, 15 Aug 2013 21:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758242Ab3HOTfD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Aug 2013 15:35:03 -0400
Received: from mail-ea0-f179.google.com ([209.85.215.179]:57708 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757521Ab3HOTfB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Aug 2013 15:35:01 -0400
Received: by mail-ea0-f179.google.com with SMTP id b10so558064eae.24
        for <git@vger.kernel.org>; Thu, 15 Aug 2013 12:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=ccwouuRFVGRRnpujPPEZod5zgV5InmD/iQN5G0uX6iA=;
        b=mSFUrzQKGBgmYD0w1/OZvSfFbgX1WQV0BVvPZMXG4TclG8CcFOc5kVdB/llVyroGtZ
         i8tGSSOLD9t1c+qzYxTWDgTaQRLeioucnBW1rkVQFxWUWtknujbNMNG92Y13zDEqd/3U
         05NqmO6Z7dw+e3Gv1yPFTSVPE4f+qC0uqGBB8DQTepkuYFwC/zcliUUnOX3rx5bvFQMH
         zrDHXBadHZOQ44I0qzVOrYp04TpY1lSEpvw1E9n8dGksG3NH8B/UIelX6baBzBTv2mxA
         HsYhPp9CiV/BdlQQ6n8oPHBxPTgT/4H3QRsblwfdiBT9abr0lUVR2gUsVwhAONBW3asI
         jDsQ==
X-Received: by 10.15.23.1 with SMTP id g1mr90830eeu.110.1376595300259;
        Thu, 15 Aug 2013 12:35:00 -0700 (PDT)
Received: from localhost (ip-109-91-109-128.unitymediagroup.de. [109.91.109.128])
        by mx.google.com with ESMTPSA id n48sm1043573eeg.17.2013.08.15.12.34.58
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 15 Aug 2013 12:34:59 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc3.498.g5af1768
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232364>

A little background on hash tables first:
Consider you want to have the object X, which you'd expect at position
i, but because that place was already taken by B, it is not found at
position i, you start looking right of position i to find X until you
find it.

    index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
           --------------------------------------------
    entry   ... |  A  |  B  |  C  |  D  |  E  |  X  | ...
           --------------------------------------------

Once you have found X at i+4, the commit 9a414486d9f0 (2013-05-01,
lookup_object: prioritize recently found objects) did an optimization
and swapped the object B with X, so the placement looks like

    index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
           --------------------------------------------
    entry   ... |  A  |  X  |  C  |  D  |  E  |  B  | ...
           --------------------------------------------

This would improve the lookup times, because you'd likely be looking up X
again soon. However we are putting a heavy penalty on B for the collision.
Also suppose we'd look up B now, which is expected to be at i or even left
from there (i-n). So it is a long way to go until B is found.
So if B were expected at the same place as X, we'd end up as before the
swap, now penalizing the lookup of X again.

Jeff stated in the referenced commit, that another solution, an LRU
scheduling would be to shift all of the objects. So when looking for X
in the first diagram, once we found X, we'd shift all the objects and put
X to position i:

    index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
           --------------------------------------------
    entry   ... |  A  |  X  |  B  |  C  |  D  |  E  | ...
           --------------------------------------------

But that strategy would need to go through all the positions, hence taking
even longer.


This patch proposes another strategy: We split the penalty into parts and
add the penalty to different objects. To keep the overhead small, we're
splitting up the penalty to only 2 portions and assign it to the object B
and an arbitrary object in the range between B and X.

The reason why moving that arbitrary object in between is analogous to the
explanation of moving the first object. See 9a414486d9f0 (2013-05-01,
lookup_object: prioritize recently found objects) for a detailed explanation.

But which of the objects to choose from in between? At first I naively choose
the exact mid between those 2 objects, so here is the diagram from the beginning
again:

    index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
           --------------------------------------------
    entry   ... |  A  |  B  |  C  |  D  |  E  |  X  | ...
           --------------------------------------------

If we now want to find X and X is expected at i, we put X to
the position i and B to the middle position between B and X at D
and D will go to the old position of X:

    index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
           --------------------------------------------
    entry   ... |  A  |  X  |  C  |  B  |  E  |  D  | ...
           --------------------------------------------

So let's test how it works out:
	# running the current git.git master (c1ebd90c832e), repeat 25 times:
	perf stat -r 25 -- ./git-rev-list --all --objects >/dev/null
	...
	5.294512141 seconds time elapsed    ( +-  7.88% )
	# Now running with this patch applied:
	5.111576725 seconds time elapsed    ( +-  8.17% )

This is an average 5 percent performance gain, though the measure times
are varying itself by that amount (7.88 and 8.17 percent)

This approach is faster than before, because it still doesn't touch too
many object for resorting, but also doesn't put the penalty to one
outlier. The lookup penalty is split up between two objects, which
probably have nothing to do with each other.

But is the mid object really the right thing to do? We could
split the lookup penalty not into 2 halfs, but in a huge and a
small amount. So instead of the mid object, we are free to
choose any other arbitrary object in between B and X. Let's try
to use the nearest object (C) and farest object(E), because there
we may have better cache effects (near the objects we're accessing anyway)
and the calculation is easier:

If using C as the mid object, we'd end up with

    index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
           --------------------------------------------
    entry   ... |  A  |  X  |  B  |  D  |  E  |  C  | ...
           --------------------------------------------

or if taking the E object we'd end up with

    index       | i-1 |  i  | i+1 | i+2 | i+3 | i+4 |
           --------------------------------------------
    entry   ... |  A  |  X  |  C  |  D  |  B  |  E  | ...
           --------------------------------------------

	# Test with C as mid object (25 repetitions as well):
	# 5.35 seconds time elapsed  ( +-  7.09% )
	# Test with E as mid object (25 repetitions as well):
	# 5.42 seconds time elapsed  ( +-  6.50% )

So that was not successful, hence the initial idea to take the mid
object is in this patch. A second run of the original state and
this patch yieled a 5 percent performance gain again, so I am quite
confident now this patch is good.

However please do check if this patch brings the promised performance
on your own, as you're likely using different hardware and another
software setup. Feel free to share your performance differences.

Signed-off-by: Stefan Beller <stefanbeller@googlemail.com>
---
 object.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/object.c b/object.c
index d8a4b1f..014290d 100644
--- a/object.c
+++ b/object.c
@@ -71,7 +71,7 @@ static unsigned int hashtable_index(const unsigned char *sha1)
 
 struct object *lookup_object(const unsigned char *sha1)
 {
-	unsigned int i, first;
+	unsigned int i, first, middle;
 	struct object *obj;
 
 	if (!obj_hash)
@@ -90,9 +90,27 @@ struct object *lookup_object(const unsigned char *sha1)
 		 * Move object to where we started to look for it so
 		 * that we do not need to walk the hash table the next
 		 * time we look for it.
+		 * However, we don't want to penalize the the object being
+		 * moved from the first position, so divide the penalty to
+		 * two different objects.
 		 */
+
+		/*
+		 * First make sure i > first, so the middle is really
+		 * in between the i and first object
+		 */
+		if (i < first)
+			i += obj_hash_size;
+
+		middle = (i + first) / 2;
+		if (i >= obj_hash_size)
+			i -= obj_hash_size;
+		if (middle >= obj_hash_size)
+			middle -= obj_hash_size;
+
 		struct object *tmp = obj_hash[i];
-		obj_hash[i] = obj_hash[first];
+		obj_hash[i] = obj_hash[middle];
+		obj_hash[middle] = obj_hash[first];
 		obj_hash[first] = tmp;
 	}
 	return obj;
-- 
1.8.4.rc3.498.g5af1768
