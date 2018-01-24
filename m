Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6F8521F404
	for <e@80x24.org>; Wed, 24 Jan 2018 23:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933198AbeAXXWS (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Jan 2018 18:22:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:56420 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932889AbeAXXWQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jan 2018 18:22:16 -0500
Received: (qmail 12366 invoked by uid 109); 24 Jan 2018 23:22:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 24 Jan 2018 23:22:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30805 invoked by uid 111); 24 Jan 2018 23:22:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 24 Jan 2018 18:22:54 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jan 2018 18:22:14 -0500
Date:   Wed, 24 Jan 2018 18:22:14 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: Git packs friendly to block-level deduplication
Message-ID: <20180124232214.GA11348@sigill.intra.peff.net>
References: <87bmhiykvw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bmhiykvw.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 24, 2018 at 11:03:47PM +0100, Ævar Arnfjörð Bjarmason wrote:

> This produces a total of 0 blocks that are the same. If after the repack
> we throw this in there after the repack:
> 
>     echo 5be1f00a9a | git pack-objects --no-reuse-delta --no-reuse-object --revs .git/objects/pack/manual
> 
> Just over 8% of the blocks are the same, and of course this pack
> entirely duplicates the existing packs, and I don't know how to coerce
> repack/pack-objects into keeping this manual-* pack and re-packing the
> rest, removing any objects that exist in the manual-* pack.

I think touching manual-*.keep would do what you want (followed by
"repack -ad" to drop the duplicate objects).

You may also want to use "--threads=1" to avoid non-determinism in the
generated packs. In theory, both repos would then produce identical base
packs, though it does not seem to do so in practice (I didn't dig in to
what the different may be).

> I couldn't find any references to someone trying to get this particular
> use-case working on-list. I.e. to pack different repositories with a
> shared history in such a way as to optimize for getting the most amount
> of identical blocks within packs.

I don't recall any discussion on this topic before.

I think you're fighting against two things here:

  - the order in which we find deltas; obviously a delta of A against B
    is quite different than B against A

  - the order of objects written to disk

Those mostly work backwards through the history graph, so adding new
history on top of old will cause changes at the beginning of the file,
and "shift" the rest so that the blocks don't match.

If you reverse the order of those, then the shared history is more
likely to provide a common start to the pack. See compute_write_order()
and the final line of type_size_sort().

> It should be possible to produce such a pack, e.g. by having a repack
> mode that would say:
> 
>  1. Find what the main branch is
>  2. Get its commits in reverse order, produce packs of some chunk-size
>     of commit batches.
>  3. Pack all the remaining content
> 
> This would delta much less efficiently, but as noted above the
> block-level deduplication might make up for it, and in any case some
> might want to use less disk space.

We do something a bit like this at GitHub. There we have a single pack
holding all of the objects for many forks. So the deduplication is done
already, but we want to avoid deltas that cross fork boundaries (since
they mean throwing away the delta and recomputing from scratch when
somebody fetches). And then we write the result in layers, although
right now there are only 2 layers (some "base" fork gets all of its
objects, and then everybody else's objects are dumped on top).

I suspect some of the same concepts could be applied. If you're
interested in playing with it, I happened to extract it into a single
patch recently (it's on my list of "stuff to send upstream" but I
haven't gotten around to polishing it fully). It's the
"jk/delta-islands" branch of https://github.com/peff/git (which I happen
to know you already have a clone of ;) ).

-Peff
