Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D2241F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbeJDCak (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 22:30:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:40380 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726969AbeJDCak (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 22:30:40 -0400
Received: (qmail 6394 invoked by uid 109); 3 Oct 2018 19:40:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 03 Oct 2018 19:40:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16915 invoked by uid 111); 3 Oct 2018 19:40:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 03 Oct 2018 15:40:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Oct 2018 15:40:51 -0400
Date:   Wed, 3 Oct 2018 15:40:51 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] oidset: use khash
Message-ID: <20181003194051.GB20709@sigill.intra.peff.net>
References: <64911aec-71cd-d990-5dfd-bf2c3163690c@web.de>
 <5efe6695-2e82-786c-1170-7874978cb534@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5efe6695-2e82-786c-1170-7874978cb534@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 03, 2018 at 03:16:39PM +0200, René Scharfe wrote:

> Performance of a command that mainly checks for duplicate objects using
> an oidset, with master and Clang 6.0.1:
> 
>   $ cmd="./git-cat-file --batch-all-objects --unordered --buffer --batch-check='%(objectname)'"
> 
>   $ /usr/bin/time $cmd >/dev/null
>   0.22user 0.03system 0:00.25elapsed 99%CPU (0avgtext+0avgdata 48484maxresident)k
>   0inputs+0outputs (0major+11204minor)pagefaults 0swaps
> 
>   $ hyperfine "$cmd"
>   Benchmark #1: ./git-cat-file --batch-all-objects --unordered --buffer --batch-check='%(objectname)'
> 
>     Time (mean ± σ):     250.0 ms ±   6.0 ms    [User: 225.9 ms, System: 23.6 ms]
> 
>     Range (min … max):   242.0 ms … 261.1 ms
> 
> And with this patch:
> 
>   $ /usr/bin/time $cmd >/dev/null
>   0.14user 0.00system 0:00.15elapsed 100%CPU (0avgtext+0avgdata 41396maxresident)k
>   0inputs+0outputs (0major+8318minor)pagefaults 0swaps
> 
>   $ hyperfine "$cmd"
>   Benchmark #1: ./git-cat-file --batch-all-objects --unordered --buffer --batch-check='%(objectname)'
> 
>     Time (mean ± σ):     151.9 ms ±   4.9 ms    [User: 130.5 ms, System: 21.2 ms]
> 
>     Range (min … max):   148.2 ms … 170.4 ms

Thanks. Just to reinforce these timings, a similar command on linux.git
drops from 4.0s to 2.3s.

The patch itself mostly looks good. A few small comments:

> diff --git a/fetch-pack.c b/fetch-pack.c
> index 75047a4b2a..a839315726 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -536,7 +536,7 @@ static int tip_oids_contain(struct oidset *tip_oids,
>  	 * add to "newlist" between calls, the additions will always be for
>  	 * oids that are already in the set.
>  	 */
> -	if (!tip_oids->map.map.tablesize) {
> +	if (!tip_oids->set.n_buckets) {
>  		add_refs_to_oidset(tip_oids, unmatched);
>  		add_refs_to_oidset(tip_oids, newlist);
>  	}

This is a little intimate with the implementation of khash, but I think
it's probably OK (and really no worse than what was there before).

As the comment above notes, I think we're really looking at the case
where this gets populated on the first call, but not subsequent ones. It
might be less hacky to use a "static int initialized" here. Or if we
want to avoid hidden globals, put the logic into filter_refs() to decide
when to populate.

I don't think any of that needs to hold up this series, though.

>  int oidset_insert(struct oidset *set, const struct object_id *oid)
>  {
> -	struct oidmap_entry *entry;
> -
> -	if (!set->map.map.tablesize)
> -		oidmap_init(&set->map, 0);
> -	else if (oidset_contains(set, oid))
> -		return 1;
> -
> -	entry = xmalloc(sizeof(*entry));
> -	oidcpy(&entry->oid, oid);
> -
> -	oidmap_put(&set->map, entry);
> -	return 0;
> +	int added;
> +	kh_put_oid(&set->set, *oid, &added);
> +	return !added;
>  }

This actually does the check-and-insert in a single lookup, which is
nice. ;)

> diff --git a/oidset.h b/oidset.h
> index 40ec5f87fe..4b90540cd4 100644
> --- a/oidset.h
> +++ b/oidset.h
> [...]
> +KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)

This will declare these "static inline". Our other major "macros become
inline functions" code is commit-slab.h, and there we found it necessary
to add MAYBE_UNUSED. I wonder if we ought to be doing the same here (I
don't get any warnings, but I suspect sparse might complain).

It might be nice if these functions could hide inside oidset.c (and just
declare the struct here). It looks like we might be able to do that with
__KHASH_TYPE(), but the double-underscore implies that we're not
supposed to. ;)

I guess we also use a few of them in our inlines here. I'm not 100% sure
that oidset_* needs to be inlined either, but this is at least a pretty
faithful conversion of the original.

-Peff
