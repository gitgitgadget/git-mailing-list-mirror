From: Jeff King <peff@peff.net>
Subject: [RFC/PATCHv2 3/6] commit: add commit_generation function
Date: Wed, 13 Jul 2011 03:05:17 -0400
Message-ID: <20110713070517.GC18566@sigill.intra.peff.net>
References: <20110713064709.GA18499@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>, Ted Ts'o <tytso@mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 09:05:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QgtVe-0005uT-GO
	for gcvg-git-2@lo.gmane.org; Wed, 13 Jul 2011 09:05:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758673Ab1GMHFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Jul 2011 03:05:20 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43220
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856Ab1GMHFU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2011 03:05:20 -0400
Received: (qmail 21153 invoked by uid 107); 13 Jul 2011 07:05:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Jul 2011 03:05:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Jul 2011 03:05:17 -0400
Content-Disposition: inline
In-Reply-To: <20110713064709.GA18499@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177000>

A commit's generation is its height in the history graph, as
measured from the farthest root. It is defined as:

  - If the commit has no parents, then its generation is 0.

  - Otherwise, its generation is 1 more than the maximum of
    its parents generations.

The following diagram shows a sample history with
generations:

  A(0)--B(1)--C(2)------G(5)--H(6)
         \             /
          D(2)--E(3)--F(4)

Note that C and D have the same generation, as they are both
children of B. Note also that the merge commit G's
generation is 5, not 3, as we take the maximum of its
parents' generations.

Generation numbers can be useful for bounding traversals.
For example, if we have two commits with generations 500 and
600, we know that the second cannot be an ancestor of the
first. The first could be an ancestor of the second, but we
can't know unless we traverse the history graph. However,
when walking backwards from the "600" commit, once we reach
generation "499", we know that the "500" commit cannot be an
ancestor of the "499" commit, and we can stop the traversal
without even looking at the earlier parts of the history.

We already do something similar with commit timestamps in
many traversals. However, timestamps are somewhat
untrustworthy, as we have to deal with clock skew and with
imports from buggy systems.

Generation numbers are easy to calculate recursively, though
you have to go to the roots to do so. This patch calculates
and stores them in a persistent cache.  It uses a simple
recursive algorithm; you could probably drop the recursion
by topologically sorting a list of all commits and filling
in generation numbers left to right. But the recursive
definition coupled with the cache make it very cheap to
calculate generation numbers for new commits at the tip of
history (you only have to traverse back to the last cached
parents).

We could also store generation numbers in the commit header
directly. These would be faster to look at than an external
cache (they would be on par speed-wise with commit
timestamps). But there are a few reasons not to:

  1. The reason to avoid commit timestamps is that they are
     unreliable. Generation numbers would probably be more
     reliable, but they are still redundant with the actual
     graph structure represented by the parent pointers, and
     can therefore be out of sync with the parent
     information. By calculating them ourselves, we know
     they are correct.

  2. With grafts and replacement objects, the graph
     structure (and thus the generation numbers) can be
     changed. So the generation number, while immutable for
     a given commit object, can be changed when we "lie"
     about the graph structure via these mechanisms. Being
     able to simply clear the cache when these things are
     changed is helpful.

  3. There's a lot of existing git history without
     generation headers. So we'd still need to have the same
     cache to handle those cases.

  4. It generally pollutes the header with redundant
     information, which we try to avoid. Putting it in the
     commit header is purely a speedup, and it seems we can
     get similar performance with a generation cache.

Signed-off-by: Jeff King <peff@peff.net>
---
Same as before, but rebased onto the new metadata-cache interface.

 commit.c |   36 ++++++++++++++++++++++++++++++++++++
 commit.h |    2 ++
 2 files changed, 38 insertions(+), 0 deletions(-)

diff --git a/commit.c b/commit.c
index ac337c7..fb37aa0 100644
--- a/commit.c
+++ b/commit.c
@@ -6,6 +6,7 @@
 #include "diff.h"
 #include "revision.h"
 #include "notes.h"
+#include "metadata-cache.h"
 
 int save_commit_buffer = 1;
 
@@ -878,3 +879,38 @@ int commit_tree(const char *msg, unsigned char *tree,
 	strbuf_release(&buffer);
 	return result;
 }
+
+static struct metadata_cache generations =
+	METADATA_CACHE_INIT("generations", sizeof(uint32_t), NULL);
+
+static unsigned long commit_generation_recurse(struct commit *c)
+{
+	struct commit_list *p;
+	uint32_t r;
+
+	if (!metadata_cache_lookup_uint32(&generations, &c->object, &r))
+		return r;
+
+	if (parse_commit(c) < 0)
+		die("unable to parse commit: %s", sha1_to_hex(c->object.sha1));
+
+	if (!c->parents)
+		return 0;
+
+	r = 0;
+	for (p = c->parents; p; p = p->next) {
+		unsigned long pgen = commit_generation_recurse(p->item);
+		if (pgen > r)
+			r = pgen;
+	}
+	r++;
+
+	metadata_cache_add_uint32(&generations, &c->object, r);
+	return r;
+}
+
+unsigned long commit_generation(const struct commit *commit)
+{
+	/* drop const because we may call parse_commit */
+	return commit_generation_recurse((struct commit *)commit);
+}
diff --git a/commit.h b/commit.h
index a2d571b..bff6b36 100644
--- a/commit.h
+++ b/commit.h
@@ -176,4 +176,6 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
 
+unsigned long commit_generation(const struct commit *commit);
+
 #endif /* COMMIT_H */
-- 
1.7.6.37.g989c6
