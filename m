Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54EFC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F75364DEC
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhBWAb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 19:31:58 -0500
Received: from cloud.peff.net ([104.130.231.41]:40906 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhBWAb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 19:31:56 -0500
Received: (qmail 22412 invoked by uid 109); 23 Feb 2021 00:31:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Feb 2021 00:31:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19946 invoked by uid 111); 23 Feb 2021 00:31:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Feb 2021 19:31:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Feb 2021 19:31:12 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com
Subject: Re: [PATCH v3 0/8] repack: support repacking into a geometric
 sequence
Message-ID: <YDRM0E+GjLlXoSwC@coredump.intra.peff.net>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1613618042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1613618042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 17, 2021 at 10:14:11PM -0500, Taylor Blau wrote:

> Here is another updated version of mine and Peff's series to add a new 'git
> repack --geometric' mode which supports repacking a repository into a geometric
> progression of packs by object count.

Thanks. This version looks pretty good to me. I have a few inline
comments below. Mostly just observations, but there a couple tiny nits
that I think may justify one more re-roll.

> 14:  ddc2896caa !  2:  82f6b45463 revision: learn '--no-kept-objects'
>     @@ Commit message
>          certain packs alone (for e.g., when doing a geometric repack that has
>          some "large" packs which are kept in-core that it wants to leave alone).
> 
>     +    Note that this option is not guaranteed to produce exactly the set of
>     +    objects that aren't in kept packs, since it's possible the traversal
>     +    order may end up in a situation where a non-kept ancestor was "cut off"
>     +    by a kept object (at which point we would stop traversing). But, we
>     +    don't care about absolute correctness here, since this will eventually
>     +    be used as a purely additive guide in an upcoming new repack mode.
>     +
>     +    Explicitly avoid documenting this new flag, since it is only used
>     +    internally. In theory we could avoid even adding it rev-list, but being
>     +    able to spell this option out on the command-line makes some special
>     +    cases easier to test without promising to keep it behaving consistently
>     +    forever. Those tricky cases are exercised in t6114.

We don't have a real procedure for marking something as "off limits" for
users. IMHO omitting it from the documentation and putting an explicit
note in the commit message is probably enough. It would be perhaps
stronger to mark it explicitly as "do not touch" in the documentation,
but then we are polluting the documentation. :)

>     @@ builtin/pack-objects.c: static int git_pack_config(const char *k, const char *v,
>      +			die(_("could not find pack '%s'"), item->string);
>      +		p->pack_keep_in_core = 1;
>      +	}
>     ++
>     ++	/*
>     ++	 * Order packs by ascending mtime; use QSORT directly to access the
>     ++	 * string_list_item's ->util pointer, which string_list_sort() does not
>     ++	 * provide.
>     ++	 */
>     ++	QSORT(include_packs.items, include_packs.nr, pack_mtime_cmp);
>     ++

I wondered briefly if we should accept the order from the caller, and
make it responsible for any sorting. But in other instances, we are
happy to reorder objects internally for the sake of optimization, so it
probably makes sense here.

I also wondered if we could piggy-back on the sorting of packed_git,
which is already in reverse chronological order. But here our primary
structure is the string-list, so we lose that order.

I'm not sure if your sort function is going the right way, though. It
does:

>     ++static int pack_mtime_cmp(const void *_a, const void *_b)
>     ++{
>     ++        struct packed_git *a = ((const struct string_list_item*)_a)->util;
>     ++        struct packed_git *b = ((const struct string_list_item*)_b)->util;
>     ++
>     ++        if (a->mtime < b->mtime)
>     ++                return -1;
>     ++        else if (b->mtime < a->mtime)
>     ++                return 1;
>     ++        else
>     ++                return 0;
>     ++}
>     ++

Does that give us the packs in increasing chronological order, but then
decreasing chronological order within the packs themselves?

> 17:  b5081c01b5 !  5:  181c104a03 p5303: measure time to repack with keep
>     @@ Metadata
>       ## Commit message ##
>          p5303: measure time to repack with keep
> 
>     -    This is the same as the regular repack test, except that we mark the
>     -    single base pack as "kept" and use --assume-kept-packs-closed. The
>     -    theory is that this should be faster than the normal repack, because
>     -    we'll have fewer objects to traverse and process.
>     +    Add two new tests to measure repack performance. Both test split the

s/test split/tests split/, I think.

>     +    in the 50-pack case, things start to slow down:
>     +
>     +      5303.11: repack (50)                        71.54(88.57+4.84)
>     +      5303.12: repack with kept (50)              85.12(102.05+4.94)
>     +
>     +    and by the time we hit 1,000 packs, things are substantially worse, even
>     +    though the resulting pack produced is the same:
>     +
>     +      5303.17: repack (1000)                      216.87(490.79+14.57)
>     +      5303.18: repack with kept (1000)            665.63(938.87+15.76)

OK, that's the kind of horrendous slowdown I knew we could demonstrate. :)
I'm excited to see the numbers improve in the next patch.

>     +    Likewise, the scaling is pretty extreme on --stdin-packs:
>     +
>     +      5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)
>     +      5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)
>     +      5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)
> 
>          That's because the code paths around handling .keep files are known to
>          scale badly; they look in every single pack file to find each object.

Your "that's because" is a little confusing to me. It certainly applies
to the repack vs repack-with-kept comparisons for a given number of
packs. But the scaling on the three --stdin-packs tests is high because
each subsequent test is being asked to do a lot more work. But they're
still cheaper than the matching "repack" case with a given number of
packs. Just not _as_ cheap as they would be if the kept code weren't so
slow.

Would it make sense to reorder those two paragraphs?

>     ++	test_perf "repack with kept ($nr_packs)" '
>     ++		git pack-objects --keep-true-parents \
>     ++		  --keep-pack=pack-$empty_pack.pack \
>     ++		  --honor-pack-keep --non-empty --all \
>     ++		  --reflog --indexed-objects --delta-base-offset \
>     ++		  --stdout </dev/null >/dev/null
>     ++	'

The new test itself looks sensible. I like using --keep-pack here to
avoid needing to do any other setup/cleanup. (It does assume that
on-disk and in-core keeps behave the same, but I'm fine with that
white-box assumption, especially for a perf test).

>     +      5303.5: repack (1)                          57.26(54.59+10.84)      57.34(54.66+10.88) +0.1%
>     +      5303.6: repack with kept (1)                57.33(54.80+10.51)      57.38(54.83+10.49) +0.1%
>     +      5303.11: repack (50)                        71.54(88.57+4.84)       71.70(88.99+4.74) +0.2%
>     +      5303.12: repack with kept (50)              85.12(102.05+4.94)      72.58(89.61+4.78) -14.7%
>     +      5303.17: repack (1000)                      216.87(490.79+14.57)    217.19(491.72+14.25) +0.1%
>     +      5303.18: repack with kept (1000)            665.63(938.87+15.76)    246.12(520.07+14.93) -63.0%

Nice. In each amount we are recovering almost all of the kept slowdown
seen between the repack and repack-with-kept cases. The remaining
slowdown is just from iterating that N-pack linked list, even though we
don't look in any of its .idx files.

>     +    and the --stdin-packs timings:
>     +
>     +      5303.7: repack with --stdin-packs (1)       0.01(0.01+0.00)         0.00(0.00+0.00) -100.0%
>     +      5303.13: repack with --stdin-packs (50)     3.53(12.07+0.24)        3.43(11.75+0.24) -2.8%
>     +      5303.19: repack with --stdin-packs (1000)   195.83(371.82+8.10)     130.50(307.15+7.66) -33.4%

And of course we see an improvement here, too (as expected, but not as
dramatic because we are doing less work overall).

> 19:  f1c07324f6 !  7:  e9e04b95e7 packfile: add kept-pack cache for find_kept_pack_entry()
> [...]
>     +      5303.5: repack (1)                          57.34(54.66+10.88)      56.98(54.36+10.98) -0.6%
>     +      5303.6: repack with kept (1)                57.38(54.83+10.49)      57.17(54.97+10.26) -0.4%
>     +      5303.11: repack (50)                        71.70(88.99+4.74)       71.62(88.48+5.08) -0.1%
>     +      5303.12: repack with kept (50)              72.58(89.61+4.78)       71.56(88.80+4.59) -1.4%
>     +      5303.17: repack (1000)                      217.19(491.72+14.25)    217.31(490.82+14.53) +0.1%
>     +      5303.18: repack with kept (1000)            246.12(520.07+14.93)    217.08(490.37+15.10) -11.8%

And now we can see this patch carrying its weight much more than in the
previous iteration of the series. Good. Our N-pack linked list is now a
single element (just the kept pack), so we expect our repack-with-kept
times to match their non-kept partners. And they do.

>     +    and the --stdin-packs case, which scales a little bit better (although
>     +    not by that much even at 1,000 packs):
>     +
>     +      5303.7: repack with --stdin-packs (1)       0.00(0.00+0.00)         0.00(0.00+0.00) =
>     +      5303.13: repack with --stdin-packs (50)     3.43(11.75+0.24)        3.43(11.69+0.30) +0.0%
>     +      5303.19: repack with --stdin-packs (1000)   130.50(307.15+7.66)     125.13(301.36+8.04) -4.1%

And likewise this is less dramatic, but still nice to see.

> 20:  d5561585c2 !  8:  bd492ec142 builtin/repack.c: add '--geometric' option
>     @@ Documentation/git-repack.txt: depth is 4095.
> [...]
>     ++Unlike other repack modes, the set of objects to pack is determined
>     ++uniquely by the set of packs being "rolled-up"; in other words, the
>     ++packs determined to need to be combined in order to restore a geometric
>     ++progression.

And this is the "clarify roll-up" bit I asked for. Looks good.

>     ++Loose objects are implicitly included in this "roll-up", without respect
>     ++to their reachability. This is subject to change in the future. This
>     ++option (implying a drastically different repack mode) is not guarenteed
>     ++to work with all other combinations of option to `git repack`).

Likewise, this is a big improvement. But should it make it clear that
touching loose objects requires --unpacked? I.e., something like:

  When `--unpacked` is specified, loose objects are included in this
  "roll-up" without respect to their reachability...

Also, s/guarenteed/guaranteed/.

-Peff
