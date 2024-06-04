Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA01B13D289
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495697; cv=none; b=GScGvt+isyQG5FGRaZswXOB/JuM7byFs1szVov5L/ZuwYXEG2AyoY/kjpr+aO5AkWHC6nPiskbeOOSh6vRqk3n/OTKlmmAYswiAayfX6BKBGO39gx63QjfjySzNxFb0HWleFa3BrvG0hpZ3Tp7jDSTNqYWRWqgvDoK8I4L4EPlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495697; c=relaxed/simple;
	bh=YEc4DpOyZ9B+RKKRJzjgcuthlJwtllri4j2krQPHuVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m1P4I/lIfEpRDU4rix+3u1UJecI42tf1XOwgK428s0HVEmEPbxtt3Bb8EHnFUv/lQEO9/CscwymA5BNsaL2gwwFUxHjf7L0PGcVKVKybOxkD+hXxh0viRgKEN0vEWLTpOzw1skuc37s+pGz/89KxNIQkBizUml9wkonf5VtcBG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21336 invoked by uid 109); 4 Jun 2024 10:08:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:08:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18300 invoked by uid 111); 4 Jun 2024 10:08:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:08:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:08:14 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 0/13] leak fixes for sparse-checkout code
Message-ID: <20240604100814.GA1304520@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

On Fri, May 31, 2024 at 07:24:34AM -0400, Jeff King wrote:

> So Patrick nerd-sniped me by asking if my earlier leakfix for git-mv was
> triggered by the test suite. It was, in t7002, but that wasn't enough to
> make the script leak-free. So I figured, how hard could it be to go all
> the way?
> 
> Well. It only took a few patches (1-5), but in the process I stumbled on
> a rather tricky interface oddity of add_pattern(), which caused some
> other leaks. The interface is fixed in patch 6, and the matching leak
> goes away in patch 7. Of course, I wanted to make sure it was tested, so
> after poking around I found that t1091 triggered it.
> 
> But as you might guess, that didn't make t1091 leak-free. And I couldn't
> bear leaving it on a cliffhanger like that, so patches 8-13 fix the rest
> of the issues triggered by that script.
> 
> And along the way we managed to make t1090 and t3602 leak-free, too
> (actually in patch 2, but I didn't notice until the whole thing was
> done).
> 
> These should apply on top of jk/leakfixes, since the leak-freeness of
> t7002 depends on the fix there.

Here's a v2 with a few minor updates, based on review from Patrick. The
restoration of "old_pl" in patch 9 is now done unconditionally (it
doesn't matter in practice due to a bunch of subtle things, but it's the
less surprising and more defensive choice). And a small style update in
patch 13.

Range-diff:

 1:  1be529905f =  1:  1be529905f sparse-checkout: free string list in write_cone_to_file()
 2:  8e36bf2213 =  2:  8e36bf2213 sparse-checkout: pass string literals directly to add_pattern()
 3:  1a3c5819f9 =  3:  1a3c5819f9 dir.c: free strings in sparse cone pattern hashmaps
 4:  a492842dd3 =  4:  a492842dd3 sparse-checkout: clear patterns when init() sees existing sparse file
 5:  2d8d402809 =  5:  2d8d402809 dir.c: free removed sparse-pattern hashmap entries
 6:  addb69e229 =  6:  addb69e229 dir.c: always copy input to add_pattern()
 7:  f2ee2192f7 =  7:  f2ee2192f7 sparse-checkout: reuse --stdin buffer when reading patterns
 8:  d3f7ea12ab =  8:  d3f7ea12ab sparse-checkout: always free "line" strbuf after reading input
 9:  b5c07325d2 !  9:  b78d3b51b9 sparse-checkout: refactor temporary sparse_checkout_patterns
    @@ builtin/sparse-checkout.c: static int update_working_directory(struct pattern_li
     +	if (r->index->sparse_checkout_patterns != pl) {
     +		clear_pattern_list(r->index->sparse_checkout_patterns);
     +		FREE_AND_NULL(r->index->sparse_checkout_patterns);
    -+	} else {
    -+		r->index->sparse_checkout_patterns = old_pl;
     +	}
    ++	r->index->sparse_checkout_patterns = old_pl;
    ++
      	return result;
      }
      
10:  26b1e08e6f = 10:  ef05901aef sparse-checkout: free sparse_filename after use
11:  d14f0f0546 = 11:  7b423b1691 sparse-checkout: free pattern list in sparse_checkout_list()
12:  84b1a5eb0d = 12:  034668997b sparse-checkout: free string list after displaying
13:  460a7f9324 ! 13:  82f14304ae sparse-checkout: free duplicate hashmap entries
    @@ builtin/sparse-checkout.c: static void insert_recursive_pattern(struct pattern_l
      
     -		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
     +		dup = hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL);
    -+		if (!dup)
    ++		if (!dup) {
      			hashmap_add(&pl->parent_hashmap, &e->ent);
    -+		else {
    ++		} else {
     +			free(e->pattern);
     +			free(e);
     +			e = dup;

  [01/13]: sparse-checkout: free string list in write_cone_to_file()
  [02/13]: sparse-checkout: pass string literals directly to add_pattern()
  [03/13]: dir.c: free strings in sparse cone pattern hashmaps
  [04/13]: sparse-checkout: clear patterns when init() sees existing sparse file
  [05/13]: dir.c: free removed sparse-pattern hashmap entries
  [06/13]: dir.c: always copy input to add_pattern()
  [07/13]: sparse-checkout: reuse --stdin buffer when reading patterns
  [08/13]: sparse-checkout: always free "line" strbuf after reading input
  [09/13]: sparse-checkout: refactor temporary sparse_checkout_patterns
  [10/13]: sparse-checkout: free sparse_filename after use
  [11/13]: sparse-checkout: free pattern list in sparse_checkout_list()
  [12/13]: sparse-checkout: free string list after displaying
  [13/13]: sparse-checkout: free duplicate hashmap entries

 builtin/sparse-checkout.c          | 49 +++++++++++++++++++-----------
 dir.c                              | 42 ++++++++++++++++---------
 dir.h                              |  3 +-
 t/t1090-sparse-checkout-scope.sh   |  1 +
 t/t1091-sparse-checkout-builtin.sh |  1 +
 t/t3602-rm-sparse-checkout.sh      |  1 +
 t/t7002-mv-sparse-checkout.sh      |  1 +
 7 files changed, 65 insertions(+), 33 deletions(-)

-Peff
