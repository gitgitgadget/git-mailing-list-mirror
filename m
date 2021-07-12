Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A1D6C07E99
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67BA661221
	for <git@archiver.kernel.org>; Mon, 12 Jul 2021 17:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhGLRTD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Jul 2021 13:19:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:46544 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230142AbhGLRTC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jul 2021 13:19:02 -0400
Received: (qmail 18769 invoked by uid 109); 12 Jul 2021 17:16:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 12 Jul 2021 17:16:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7733 invoked by uid 111); 12 Jul 2021 17:16:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 12 Jul 2021 13:16:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 12 Jul 2021 13:16:13 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [RFC] Bump {diff,merge}.renameLimit ?
Message-ID: <YOx43fqGyQMy7+tR@coredump.intra.peff.net>
References: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFzp3TCWiF1QAVSfywDLYrz=GOQszVM-sw5p0rSB8RWvw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tl;dr Bumping the limit seems like a good idea to me.

On Sat, Jul 10, 2021 at 05:28:43PM -0700, Elijah Newren wrote:

> * My colleagues happily raised merge.renameLimit beyond 32767 when the
>   artificial cap was removed.  10 minute waits were annoying, but much
>   less so than having to manually cherry-pick commits (especially given
>   the risk of getting it wrong).[13]

One tricky thing here is that waiting 10 minutes may be worth it _if the
rename detection finds something_. If it doesn't, then it's just
annoying.

I do think progress meters help a bit there, because then at least the
user understands what's going on. I'll go into more detail in the
sub-thread there. :)

> ==> Arguments for bumping MODERATELY higher:
> 
> * We have bumped the limits twice before (in 2008 and 2011), both times
>   stating performance as the limiting factor.  Processors are faster
>   today than then.[14,15]

Yeah, it is definitely time to revisit the default numbers. I think at
one point we talked about letting it run for N wallclock seconds before
giving up, but we've been hesitant to introduce that kind of time-based
limit, because it ends up with non-deterministic results (plus you don't
realize you're not going to finish until you've already wasted a bunch
of time, whereas the static limits can avoid even beginning the work).

> * Peff's computations for performance in the last two bumps used "the
>   average size of a file in the linux-2.6 repository"[16], for which I
>   assume average==mean, but the file selected was actually ~2x larger
>   than the mean file size according to my calculations[17].
> [...]
> [17] Calculated and compared as follows (num files, mean size, size Peff used):
>   $ git ls-tree -rl v2.6.25 | wc -l
>   23810
>   $ git ls-tree -rl v2.6.25 | awk '{sum += $4} END{print sum/23810}'
>   11150.3
>   $ git show v2.6.25:arch/m68k/Kconfig | wc -c
>   20977

I don't remember my methodology at this point, but perhaps it was based
on blobs in the graph, not just one tree, like:

  $ git rev-list --objects v2.6.25 |
    git cat-file --batch-check='%(objecttype) %(objectsize) %(rest)' |
    awk '
      /^blob/ { sum += $2; total += 1 }
      END { print sum / total }
    '
  27535.8

I suspect the difference versus a single tree is that there is a
quadratic-ish property going on with file size: the bigger the file, the
more likely it is to be touched (so total storage is closer to bytes^2).

Looking at single-tree blob sizes is probably better though, as rename
detection will happen between two single trees.

> * I think the median file size is a better predictor of rename
>   performance than mean file size, and median file size is ~2.5x smaller
>   than the mean[18].

There you might get hit with the quadratic-update thing again, though.
The big files are more likely to be touched, so could be weighted more
(though are they more likely to have been added/delete/renamed? Who
knows).

I don't think file size matters all _that_ much, though, as it has a
linear relationship to time spent. Whereas the number of entries is
quadratic. And of course the whole experiment is ball-parking in the
first place. We're looking for order-of-magnitude approximations, I'd
think.

> * The feedback about the limit is better today than when we last changed
>   the limits, and folks can configure a higher limit relatively easily.
>   Many already have.

I can't remember the last time I saw the limit kick in in practice, but
then I don't generally work with super-large repos (and my workflows
typically do not encourage merging across big segments of history).
Nor do I remember the topic coming up on the list after the last bump.
So maybe that means that people are happily bumping the limits
themselves via config.

But I don't think that's really an argument against at least a moderate
bump. If it helps even a few people avoid having to learn about the
config, that's time saved. And it's a trivial code change on our end.

-Peff
