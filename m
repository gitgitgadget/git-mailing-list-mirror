Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7062F2D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412413; cv=none; b=Btmerf6y0SfXOcg7Vcksq2UcwmRsyV+HC8D3i9Taio5s/XcdtDQacupry8mcuvt8HIivrhKfbIppl+z2j5R/Yhu/MlYEkUiw6yI/n6IDNJEqMtmw1ptAW534dLXgSme4QscGhMVAYJTMUlU2HVh1tuN75bSkZ1fmv2nh3iPvpNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412413; c=relaxed/simple;
	bh=A0tgNetaVLpeUdEDWB4z3h7ZaFLGeW55new43be59us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hju1sG166xDrFORJElwL4tRsXWij5yEPFx4z1J5YyDJabNRMX7jh94k6rVBdyYcVXT8cXIGa91ZoH0Mo1f3+anNUk+QUkLzrJC//vyhAHpuaGO8klzDS5wzaO4pKcmOC49E9zFCkxnr3QrqScOMssRmHm941dt8Tm1u5MPBie9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Nlw+0bwI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Nlw+0bwI"
Received: (qmail 25695 invoked by uid 109); 9 Jan 2025 08:46:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=A0tgNetaVLpeUdEDWB4z3h7ZaFLGeW55new43be59us=; b=Nlw+0bwIXvPxb7uoOuv0Xf2KOqdEUIOR6wMxOA2RMBO9XQxZCuHtgpPtF0h39uyELpe0y2Dz7nOMc7lonbSnTF7MAJXwqhT3OkEmxuN3LUzzeFkEtay6KGm662Vr7POAvXlxqdsNRiShbj90yvVYPcXFksTENmWJqwG4CcSjJ22TKmuajOAubUxxEyP6jwBl2H7Lzg7RyImRg3OyhXRGV00YsjOEFHg2k/7oHOyBxMaVXKceK2K9Kqt/CA6e4MXHO7UKmkcnGiAnFraabo9WMybhqVUTA3CXUpCvvW+qlhLjhG2hrkx24dICqR66FHVVT/APDxKSh698MlqZFuDj/g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:46:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20340 invoked by uid 111); 9 Jan 2025 08:46:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:46:50 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:46:49 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 07/14] tree-diff: drop path_appendnew() alloc optimization
Message-ID: <20250109084649.GG2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

When we're diffing trees, we create a list of combine_diff_path structs
that represent changed paths. We allocate each struct and add it to the
list with path_appendnew(), which we then feed to opt->pathchange().
That function tells us whether the path is of interest or not; if not,
then we can throw away the struct we allocated.

So there's an optimization to avoid extra allocations: instead of
throwing away the new entry, we try to reuse it. If it was large enough
to store the next path we care about, we can do so. And if not, we fall
back to freeing and re-allocating a new struct.

This comes from 72441af7c4 (tree-diff: rework diff_tree() to generate
diffs for multiparent cases as well, 2014-04-07), where the goal was to
have even the 2-parent diff code use the combine-diff infrastructure,
but without taking a performance hit.

The implementation causes some complexities in the interface (as we
store the allocation length inside the "next" pointer), and prevents us
from using the regular combine_diff_path_new() constructor. The
complexity is mostly contained inside two functions, but it's worth
re-evaluating how much it's helping.

That commit claims it helps ~1% on generating two-parent diffs in
linux.git. Here are the timings I get on the same command today ("old"
is the current tip of master, and "new" has this patch applied):

  Benchmark 1: ./git.old log --raw --no-abbrev --no-renames v3.10..v3.11
    Time (mean ± σ):     532.9 ms ±   5.8 ms    [User: 472.7 ms, System: 59.6 ms]
    Range (min … max):   525.9 ms … 543.3 ms    10 runs

  Benchmark 2: ./git.new log --raw --no-abbrev --no-renames v3.10..v3.11
    Time (mean ± σ):     538.3 ms ±   5.7 ms    [User: 478.0 ms, System: 59.7 ms]
    Range (min … max):   528.5 ms … 545.3 ms    10 runs

  Summary
    ./git.old log --raw --no-abbrev --no-renames v3.10..v3.11 ran
    1.01 ± 0.02 times faster than ./git.new log --raw --no-abbrev --no-renames v3.10..v3.11

So we do end up on average 1% faster, but with 2% of noise. I tried to
focus more on diff performance by running the commit traversal
separately, like:

  git rev-list v3.10..v3.11 >in

and then timing just the diffs:

  Benchmark 1: ./git.old diff-tree --stdin -r <in
    Time (mean ± σ):     415.7 ms ±   5.8 ms    [User: 357.7 ms, System: 58.0 ms]
    Range (min … max):   410.9 ms … 430.3 ms    10 runs

  Benchmark 2: ./git.new diff-tree --stdin -r <in
    Time (mean ± σ):     418.5 ms ±   2.1 ms    [User: 361.7 ms, System: 56.6 ms]
    Range (min … max):   414.9 ms … 421.3 ms    10 runs

  Summary
    ./git.old diff-tree --stdin -r <in ran
      1.01 ± 0.02 times faster than ./git.new diff-tree --stdin -r <in

That gets roughly the same result.

Adding in "-c" to do multi-parent diffs doesn't change much:

  Benchmark 1: ./git.old diff-tree --stdin -r -c <in
    Time (mean ± σ):     525.3 ms ±   6.6 ms    [User: 470.0 ms, System: 55.1 ms]
    Range (min … max):   508.4 ms … 531.0 ms    10 runs

  Benchmark 2: ./git.new diff-tree --stdin -r -c <in
    Time (mean ± σ):     532.3 ms ±   6.2 ms    [User: 469.0 ms, System: 63.1 ms]
    Range (min … max):   520.3 ms … 539.4 ms    10 runs

  Summary
    ./git.old diff-tree --stdin -r -c <in ran
      1.01 ± 0.02 times faster than ./git.new diff-tree --stdin -r -c <in

And of course if you add in a lot more work by doing actual
content-level diffs, any difference is lost entirely (here the newer
version is actually faster, but that's really just noise):

  Benchmark 1: ./git.old diff-tree --stdin -r --cc <in
    Time (mean ± σ):     11.571 s ±  0.064 s    [User: 11.287 s, System: 0.283 s]
    Range (min … max):   11.497 s … 11.615 s    3 runs

  Benchmark 2: ./git.new diff-tree --stdin -r --cc <in
    Time (mean ± σ):     11.466 s ±  0.109 s    [User: 11.108 s, System: 0.357 s]
    Range (min … max):   11.346 s … 11.560 s    3 runs

  Summary
    ./git.new diff-tree --stdin -r --cc <in ran
      1.01 ± 0.01 times faster than ./git.old diff-tree --stdin -r --cc <in

So my conclusion is that it probably does help a little, but it's mostly
lost in the noise. I could see an argument for keeping it, as the
complexity is hidden away in functions that do not often need to be
touched. But it does make them more confusing than necessary (despite
some detailed explanations from the author of that commit; it just took
me a while to wrap my head around what was going on) and prevents
further refactoring of the combine_diff_path struct. So let's drop it.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-diff.c | 67 +++++------------------------------------------------
 1 file changed, 6 insertions(+), 61 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 24f7b5912c..22fc2d8f8c 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -127,30 +127,6 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
 /*
  * Make a new combine_diff_path from path/mode/sha1
  * and append it to paths list tail.
- *
- * Memory for created elements could be reused:
- *
- *	- if last->next == NULL, the memory is allocated;
- *
- *	- if last->next != NULL, it is assumed that p=last->next was returned
- *	  earlier by this function, and p->next was *not* modified.
- *	  The memory is then reused from p.
- *
- * so for clients,
- *
- * - if you do need to keep the element
- *
- *	p = path_appendnew(p, ...);
- *	process(p);
- *	p->next = NULL;
- *
- * - if you don't need to keep the element after processing
- *
- *	pprev = p;
- *	p = path_appendnew(p, ...);
- *	process(p);
- *	p = pprev;
- *	; don't forget to free tail->next in the end
  */
 static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	int nparent, const struct strbuf *base, const char *path, int pathlen,
@@ -160,22 +136,8 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	size_t len = st_add(base->len, pathlen);
 	size_t alloclen = combine_diff_path_size(nparent, len);
 
-	/* if last->next is !NULL - it is a pre-allocated memory, we can reuse */
-	p = last->next;
-	if (p && (alloclen > (intptr_t)p->next)) {
-		FREE_AND_NULL(p);
-	}
-
-	if (!p) {
-		p = xmalloc(alloclen);
-
-		/*
-		 * until we go to it next round, .next holds how many bytes we
-		 * allocated (for faster realloc - we don't need copying old data).
-		 */
-		p->next = (struct combine_diff_path *)(intptr_t)alloclen;
-	}
-
+	p = xmalloc(alloclen);
+	p->next = NULL;
 	last->next = p;
 
 	p->path = (char *)&(p->parent[nparent]);
@@ -279,21 +241,11 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		if (opt->pathchange)
 			keep = opt->pathchange(opt, p);
 
-		/*
-		 * If a path was filtered or consumed - we don't need to add it
-		 * to the list and can reuse its memory, leaving it as
-		 * pre-allocated element on the tail.
-		 *
-		 * On the other hand, if path needs to be kept, we need to
-		 * correct its .next to NULL, as it was pre-initialized to how
-		 * much memory was allocated.
-		 *
-		 * see path_appendnew() for details.
-		 */
-		if (!keep)
+		if (!keep) {
+			free(p);
+			pprev->next = NULL;
 			p = pprev;
-		else
-			p->next = NULL;
+		}
 	}
 
 	if (recurse) {
@@ -585,13 +537,6 @@ struct combine_diff_path *diff_tree_paths(
 	struct strbuf *base, struct diff_options *opt)
 {
 	p = ll_diff_tree_paths(p, oid, parents_oid, nparent, base, opt, 0);
-
-	/*
-	 * free pre-allocated last element, if any
-	 * (see path_appendnew() for details about why)
-	 */
-	FREE_AND_NULL(p->next);
-
 	return p;
 }
 
-- 
2.48.0.rc2.413.gc1c80375a3

