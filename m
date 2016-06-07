From: Jeff King <peff@peff.net>
Subject: [PATCH] tree-diff: avoid alloca for large allocations
Date: Tue, 7 Jun 2016 18:53:00 -0400
Message-ID: <20160607225300.GA2285@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Kirill Smelkov <kirr@mns.spb.ru>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 00:53:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAPrz-0001Hg-Ja
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 00:53:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161376AbcFGWxF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 18:53:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:50925 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932249AbcFGWxE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 18:53:04 -0400
Received: (qmail 12791 invoked by uid 102); 7 Jun 2016 22:53:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 18:53:02 -0400
Received: (qmail 2951 invoked by uid 107); 7 Jun 2016 22:53:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 18:53:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 18:53:00 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296747>

Commit 72441af (tree-diff: rework diff_tree() to generate
diffs for multiparent cases as well, 2014-04-07) introduced
the use of alloca so that the common cases of commits with 1
or 2 parents would not be adversely affected by going
through the multi-parent code.

However, our xalloca is not ideal when the number of parents
grows very large:

  1. If the requested size is too large for our stack,
     alloca() has no way to tell us, and we simply segfault
     while trying to access the memory.

  2. It does not use our usual memory_limit_check() logic.

I measured, and alloca is indeed buying us a very small
speedup over xmalloc()/free(). So we'd want to keep
something like it.

This patch simply puts a conditional in place at each
callsite: we use alloca for common known-small numbers of
parents, and otherwise use the heap. We are technically
still vulnerable to (1), but no more so than if we simply
put a few dozen bytes on the stack, which we must do all the
time anyway. And likewise, we technically miss a memory
limit check if it is tiny, but such a limit is pointless.

An alternative to this would be implement something like:

  struct tree *tp, tp_fallback[2];
  if (nparent <= ARRAY_SIZE(tp_fallback))
          tp = tp_fallback;
  else
	  ALLOC_ARRAY(tp, nparent);
  ...
  if (tp != tp_fallback)
	  free(tp);

That would let us drop our xalloca() portability code
entirely. But in my measurements, this seemed to perform
slightly worse than the xalloca solution.

Note in the example above, and in the patch below, I've used
ALLOC_ARRAY() to replace the manual xmalloc(nr * sizeof(*x)).
Besides being shorter, this has the bonus that one cannot
accidentally overflow a size_t during that computation.

Signed-off-by: Jeff King <peff@peff.net>
---
And yes, I actually saw this in real life. The commit in question had a
million parents, which is obviously silly. I never let it run to
completion, as presumably there's some quadratic stuff in there. So we
could also have a general max-parent limit. I'm just not sure what it
would be; any limit we set would be arbitrary. Most of the rest of git
is happy to chug along using whatever RAM and CPU you are comfortable to
give it, and if you want to wait 5 minutes for your answer, go right
ahead.

 tree-diff.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index ff4e0d3..ebf40f4 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -14,6 +14,16 @@
  */
 #define S_IFXMIN_NEQ	S_DIFFTREE_IFXMIN_NEQ
 
+#define FAST_ARRAY_ALLOC(x, nr) do { \
+	if ((nr) <= 2) \
+		(x) = xalloca((nr) * sizeof(*(x))); \
+	else \
+		ALLOC_ARRAY((x), nr); \
+} while(0)
+#define FAST_ARRAY_FREE(x, nr) do { \
+	if ((nr) > 2) \
+		free((x)); \
+} while(0)
 
 static struct combine_diff_path *ll_diff_tree_paths(
 	struct combine_diff_path *p, const unsigned char *sha1,
@@ -265,7 +275,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	if (recurse) {
 		const unsigned char **parents_sha1;
 
-		parents_sha1 = xalloca(nparent * sizeof(parents_sha1[0]));
+		FAST_ARRAY_ALLOC(parents_sha1, nparent);
 		for (i = 0; i < nparent; ++i) {
 			/* same rule as in emitthis */
 			int tpi_valid = tp && !(tp[i].entry.mode & S_IFXMIN_NEQ);
@@ -277,7 +287,7 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		strbuf_add(base, path, pathlen);
 		strbuf_addch(base, '/');
 		p = ll_diff_tree_paths(p, sha1, parents_sha1, nparent, base, opt);
-		xalloca_free(parents_sha1);
+		FAST_ARRAY_FREE(parents_sha1, nparent);
 	}
 
 	strbuf_setlen(base, old_baselen);
@@ -402,8 +412,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	void *ttree, **tptree;
 	int i;
 
-	tp     = xalloca(nparent * sizeof(tp[0]));
-	tptree = xalloca(nparent * sizeof(tptree[0]));
+	FAST_ARRAY_ALLOC(tp, nparent);
+	FAST_ARRAY_ALLOC(tptree, nparent);
 
 	/*
 	 * load parents first, as they are probably already cached.
@@ -531,8 +541,8 @@ static struct combine_diff_path *ll_diff_tree_paths(
 	free(ttree);
 	for (i = nparent-1; i >= 0; i--)
 		free(tptree[i]);
-	xalloca_free(tptree);
-	xalloca_free(tp);
+	FAST_ARRAY_FREE(tptree, nparent);
+	FAST_ARRAY_FREE(tp, nparent);
 
 	return p;
 }
-- 
2.9.0.rc1.159.g81173282e
