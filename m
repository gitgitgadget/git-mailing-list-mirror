From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH] cache-tree: avoid infinite loop on zero-entry tree
Date: Wed, 29 Oct 2014 13:11:58 -0400
Message-ID: <20141029171158.GA32188@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 29 18:12:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjWn1-0006vu-Ir
	for gcvg-git-2@plane.gmane.org; Wed, 29 Oct 2014 18:12:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934210AbaJ2RMD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Oct 2014 13:12:03 -0400
Received: from cloud.peff.net ([50.56.180.127]:34901 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S934080AbaJ2RMB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Oct 2014 13:12:01 -0400
Received: (qmail 25987 invoked by uid 102); 29 Oct 2014 17:12:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 12:12:01 -0500
Received: (qmail 1466 invoked by uid 107); 29 Oct 2014 17:12:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 29 Oct 2014 13:12:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Oct 2014 13:11:58 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The loop in cache-tree's update_one iterates over all the
entries in the index. For each one, we find the cache-tree
subtree which represents our path (creating it if
necessary), and then recurse into update_one again. The
return value we get is the number of index entries that
belonged in that subtree. So for example, with entries:

    a/one
    a/two
    b/one

We start by processing the first entry, "a/one".  We would
find the subtree for "a" and recurse into update_one. That
would then handle "a/one" and "a/two", and return the value
2. The parent function then skips past the 2 handled
entries, and we continue by processing "b/one".

If the recursed-into update_one ever returns 0, then we make
no forward progress in our loop. We would process "a/one"
over and over, infinitely.

This should not happen normally. Any subtree we create must
have at least one path in it (the one that we are
processing!). However, we may also reuse a cache-tree entry
we found in the on-disk index. For the same reason, this
should also never have zero entries. However, certain buggy
versions of libgit2 could produce such bogus cache-tree
records. The libgit2 bug has since been fixed, but it does
not hurt to protect ourselves against bogus input coming
from the on-disk data structures.

Note that this is not a die("BUG") or assert, because it is
not an internal bug, but rather a corrupted on-disk
structure. It's possible that we could even recover from it
(by throwing out the bogus cache-tree entry), but it is not
worth the effort; the important thing is that we report an
error instead of looping infinitely.

Signed-off-by: Jeff King <peff@peff.net>
---
I'm a little iffy on this just because it is fixing one particular bug,
and I am sure there are probably a bunch of other ways to have a bogus
index. Fundamentally, I think we pretty much trust that the index was
not maliciously generated (unlike packfiles, for instance, which can
come from elsewhere).  Still, this is one step closer to safe, and the
bug was seen in the wild, so maybe it is worth doing.

We could alternatively (or in addition) reject 0-entry cache trees when
reading them from disk. The trick, though, is that it is not just
records with 0 entries, but ones where the sum of the entries and
subtree entries is 0. Given that it is not something we expect to
happen, it is easier to catch it here. And we know there can be no
regressions for missed corner cases, because the case we are catching
here would _always_ have gone into an infinite loop before this patch.

 cache-tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/cache-tree.c b/cache-tree.c
index 215202c..32772b9 100644
--- a/cache-tree.c
+++ b/cache-tree.c
@@ -303,6 +303,8 @@ static int update_one(struct cache_tree *it,
 				    flags);
 		if (subcnt < 0)
 			return subcnt;
+		if (!subcnt)
+			die("index cache-tree records empty sub-tree");
 		i += subcnt;
 		sub->count = subcnt; /* to be used in the next loop */
 		*skip_count += subskip;
-- 
2.1.2.596.g7379948
