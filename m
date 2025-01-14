Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66070229637
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 10:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736850652; cv=none; b=Jd+jwzOphM4Hvm88ewuM6PQWyg7qEuLmPr/IIK4hyHpYJMdWNwnK6C10imiYPO40nL9BnAQTMdnD4XRuTllw2M1Mxdky8DKgBgJa9KTvFil7iwLuvbqa+KYjgjad4OtbNcYGnHNR3E6DSjtB78xmMoVQnQfn1mXYYxFiMEdTxWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736850652; c=relaxed/simple;
	bh=wtxga6sb6x5bIJNbJSW/XEpE8FmU+kWDtxlJ1tLnNTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W4RkYDt0XAUvC11Lk8nIexW4vQqdaO32SiU3WEL8c+rnXb5mD9RXfaKzIT8oKz5p0SR3j3b77kzYM+Zi8vyKJr+jKra7uQStDBFiM53IlutQebW1BXhiMUfc+NrnbIjiMLzS2gxzkKsOCpltmZLYfW+ZYLrY9DyUddLdYWwr4q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NIwoIFR8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NIwoIFR8"
Received: (qmail 27692 invoked by uid 109); 14 Jan 2025 10:30:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=wtxga6sb6x5bIJNbJSW/XEpE8FmU+kWDtxlJ1tLnNTc=; b=NIwoIFR8pAOOff0rHG0YifHyihgTiBogL+1bjyIuO4Lz4aE1z5yPr4OZfhBRvWjLPKPmgHgcVITrYsYKr1q2u7Jt8LGuo5mb7s6oRoM0cFKTrJCh5JwG8yqFbpCq0xTIbC0mQnebBtNS2cwuvv1/aS50Itr/3ndOKz7FkHEwMvXKPgCZCvAG/zfin+wUy+aRoqN1kVDYcBE9NAozlqgEbb3WlGNAfyKZL+eZtlnSVGOio8KxnPWRFySo9cZaRmq6zmfDPLZ01M4iQH3OFDXnUOYnX1c9U+g9zQJDsdHD4Jnue9NzOj0DSV7LUQhgqYx9gvnex6d+GrkR36+ktgQ3Og==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jan 2025 10:30:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5322 invoked by uid 111); 14 Jan 2025 10:30:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2025 05:30:52 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jan 2025 05:30:47 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Wink Saville <wink@saville.com>
Subject: Re: [PATCH 07/14] tree-diff: drop path_appendnew() alloc optimization
Message-ID: <20250114103047.GC882468@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109084649.GG2748836@coredump.intra.peff.net>
 <Z4Uz7B4J89NphNF6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4Uz7B4J89NphNF6@pks.im>

On Mon, Jan 13, 2025 at 04:40:28PM +0100, Patrick Steinhardt wrote:

> On Thu, Jan 09, 2025 at 03:46:49AM -0500, Jeff King wrote:
> > So my conclusion is that it probably does help a little, but it's mostly
> > lost in the noise. I could see an argument for keeping it, as the
> > complexity is hidden away in functions that do not often need to be
> > touched. But it does make them more confusing than necessary (despite
> > some detailed explanations from the author of that commit; it just took
> > me a while to wrap my head around what was going on) and prevents
> > further refactoring of the combine_diff_path struct. So let's drop it.
> 
> A 1% performance speedup does not feel like a good argument to me, so
> I'm perfectly fine with dropping the code, even if most of it is
> actually in the form of comments. But that already shows that it needs
> quite a bit of explanation.
> 
> I wonder though: did you also use e.g. Valgrind to compare the number of
> allocations? glibc tends to be heavily optimized with regards to small
> allocations, so you typically don't notice the performance impact caused
> by them even when the number of saved allocations is significant. So the
> effect might be more pronounced with other libcs that aren't optimized
> for such usecases, like e.g. musl libc.

I didn't use valgrind, but I did confirm via some hacky printf() calls
that the optimization does kick in. Here's a version with counting:

diff --git a/tree-diff.c b/tree-diff.c
index d9237ffd9b..60db2b2f51 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -154,6 +154,11 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
  *
  * p->parent[] remains uninitialized.
  */
+static int hit, total;
+void show_counter(void)
+{
+	warning("%d / %d\n", hit, total);
+}
 static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 	int nparent, const struct strbuf *base, const char *path, int pathlen,
 	unsigned mode, const struct object_id *oid)
@@ -168,6 +173,11 @@ static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
 		FREE_AND_NULL(p);
 	}
 
+	if (!total++)
+		atexit(show_counter);
+	if (p)
+		hit++;
+
 	if (!p) {
 		p = xmalloc(alloclen);
 
It seems to kick in about half of the time when running "git log --raw"
on git.git and linux.git. The absolute best case for the optimization is
comparing two trees with all entries of the same size, and all changed,
like:

  git init
  blob1=$(echo one | git hash-object -w --stdin)
  blob2=$(echo two | git hash-object -w --stdin)

  mktree() {
    perl -e '
      printf "100644 blob %s\tpath%08d\n", $ARGV[0], $_ for (1..1000000)
    ' $1
  }
  git tag tree1 $(mktree $blob1 | git mktree)
  git tag tree2 $(mktree $blob2 | git mktree)

  git diff-tree tree1 tree2

In that optimal case I see ~3% speedup on glibc. If somebody on a
platform with a different allocator can show a bigger change, that would
definitely be interesting.

I suspect it won't make that big a difference even with a slower
allocator, though, because each changed path involves other allocations
(like creating a diff_pair).

Running under valgrind with that optimal case, the old code does ~3M
allocations (so 3 per entry). Now we do 4 per entry.

So if we really care about micro-optimizing, I suspect a more productive
path would be getting a better allocator. ;) Here are hyperfine results
for the existing code ("old") versus my series ("new") with the glibc
allocator versus jemalloc:

  Benchmark 1: LD_PRELOAD= ./git.old -C repo diff-tree tree1 tree2
    Time (mean ± σ):     625.3 ms ±  13.3 ms    [User: 547.9 ms, System: 77.3 ms]
    Range (min … max):   599.8 ms … 649.9 ms    10 runs
  
  Benchmark 2: LD_PRELOAD= ./git.new -C repo diff-tree tree1 tree2
    Time (mean ± σ):     650.8 ms ±  14.5 ms    [User: 568.2 ms, System: 82.5 ms]
    Range (min … max):   632.2 ms … 673.6 ms    10 runs
  
  Benchmark 3: LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 ./git.old -C repo diff-tree tree1 tree2
    Time (mean ± σ):     563.9 ms ±   9.2 ms    [User: 538.4 ms, System: 25.3 ms]
    Range (min … max):   545.4 ms … 571.0 ms    10 runs
  
  Benchmark 4: LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 ./git.new -C repo diff-tree tree1 tree2
    Time (mean ± σ):     582.9 ms ±  10.8 ms    [User: 545.1 ms, System: 37.7 ms]
    Range (min … max):   568.6 ms … 595.5 ms    10 runs
  
  Summary
    LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 ./git.old -C repo diff-tree tree1 tree2 ran
      1.03 ± 0.03 times faster than LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 ./git.new -C repo diff-tree tree1 tree2
      1.11 ± 0.03 times faster than LD_PRELOAD= ./git.old -C repo diff-tree tree1 tree2
      1.15 ± 0.03 times faster than LD_PRELOAD= ./git.new -C repo diff-tree tree1 tree2

So rather than saving 2-3%, a better allocator gives you 10-15% (again,
these are pretty synthetic numbers because this is a pathological test
case). It is still faster to do fewer allocations with jemalloc, but
both the relative and absolute improvement is smaller.

-Peff
