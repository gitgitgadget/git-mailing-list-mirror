Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D74C202A4
	for <e@80x24.org>; Fri,  8 Sep 2017 06:52:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754326AbdIHGw1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Sep 2017 02:52:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:60506 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753222AbdIHGw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2017 02:52:26 -0400
Received: (qmail 20867 invoked by uid 109); 8 Sep 2017 06:52:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 06:52:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6258 invoked by uid 111); 8 Sep 2017 06:52:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 08 Sep 2017 02:52:59 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Sep 2017 02:52:24 -0400
Date:   Fri, 8 Sep 2017 02:52:24 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 01/10] packed-backend: don't adjust the reference count
 on lock/unlock
Message-ID: <20170908065223.f7f52hjcx5qsjbch@sigill.intra.peff.net>
References: <cover.1503993268.git.mhagger@alum.mit.edu>
 <c5d66cadb70efdb5b5ce91fbcc5673621f5d4792.1503993268.git.mhagger@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c5d66cadb70efdb5b5ce91fbcc5673621f5d4792.1503993268.git.mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2017 at 10:20:25AM +0200, Michael Haggerty wrote:

> The old code incremented the packed ref cache reference count when
> acquiring the packed-refs lock, and decremented the count when
> releasing the lock. This is unnecessary because a locked packed-refs
> file cannot be changed, so there is no reason for the cache to become
> stale.

Hmm, I thought that after your last series, we might hold the lock but
update the packed-refs from a separate tempfile. I.e., 42dfa7ecef
(commit_packed_refs(): use a staging file separate from the lockfile,
2017-06-23).

> Moreover, the extra reference count causes a problem if we
> intentionally clear the packed refs cache, as we sometimes need to do
> if we change the cache in anticipation of writing a change to disk,
> but then the write to disk fails. In that case, `packed_refs_unlock()`
> would have no easy way to find the cache whose reference count it
> needs to decrement.
> 
> This whole issue will soon become moot due to upcoming changes that
> avoid changing the in-memory cache as part of updating the packed-refs
> on disk, but this change makes that transition easier.

All of this makes sense, and I'm happy this complexity is going away in
the long run. But I guess what I'm wondering is in the meantime if we
can have a sequence like:

  1. We hold packed-refs.lock

  2. We update the file without releasing the lock, via 42dfa7ecef.

  3. Still holding the lock, we try to look at packed-refs. The
     stat_validity code says no, we're not up to date.

  4. We discard the old packed_ref_cache and reload it. Because its
     reference count was not incremented during step 1, we actually
     free() it.

  5. We try to look at at the old freed pointer.

There are several steps in there that might be implausible. So I'm
mostly playing devil's advocate here.

I'm wondering if the "don't validate while we hold the lock" logic in
get_packed_refs_cache() means that step 3 is impossible.

> @@ -560,9 +559,7 @@ int packed_refs_lock(struct ref_store *ref_store, int flags, struct strbuf *err)
>  	 */
>  	validate_packed_ref_cache(refs);
>  
> -	packed_ref_cache = get_packed_ref_cache(refs);
> -	/* Increment the reference count to prevent it from being freed: */
> -	acquire_packed_ref_cache(packed_ref_cache);
> +	get_packed_ref_cache(refs);

It seems a bit funny to call a "get" function and throw away the return
value. Presumably we care about its side effect of updating refs->cache.
That might be worth a comment (though if this is all going away soon, I
care a lot less about niceties like that).

-Peff
