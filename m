Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 474F11F5CB
	for <e@80x24.org>; Mon, 22 Apr 2019 18:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727419AbfDVSnc (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Apr 2019 14:43:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:37126 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727014AbfDVSnb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Apr 2019 14:43:31 -0400
Received: (qmail 2511 invoked by uid 109); 22 Apr 2019 18:43:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 22 Apr 2019 18:43:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1442 invoked by uid 111); 22 Apr 2019 18:44:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Apr 2019 14:44:03 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Apr 2019 14:43:29 -0400
Date:   Mon, 22 Apr 2019 14:43:29 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin Fick <mfick@codeaurora.org>,
        Git Mailing List <git@vger.kernel.org>,
        "Jansen, Geert" <gerardu@amazon.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Resolving deltas dominates clone time
Message-ID: <20190422184329.GA20304@sigill.intra.peff.net>
References: <259296914.jpyqiltySj@mfick-lnx>
 <20190420035825.GB3559@sigill.intra.peff.net>
 <874l6tayzz.fsf@evledraar.gmail.com>
 <20190422155716.GA9680@sigill.intra.peff.net>
 <874l6pudg4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874l6pudg4.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 22, 2019 at 08:01:15PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Your patch is optionally removing the "woah, we got an object with a
> > duplicate sha1, let's check that the bytes are the same in both copies"
> > check. But Martin's problem is a clone, so we wouldn't have any existing
> > objects to duplicate in the first place.
> 
> Right, but we do anyway, as reported by Geert at @amazon.com preceding
> that patch of mine. But it is 99.99% irrelevant to *performance* in this
> case after the loose object cache you added (but before that could make
> all the difference depending on the FS).

I scratched my head at this a bit. If we don't have any other objects,
then what are we comparing against? But I think you mean that we have
the overhead of doing the object lookups to find that out. Yes, that can
add up if your filesystem has high latency, but I think in this case it
is a drop in the bucket compared to dealing with the actual object data.

> I just mentioned it to plant a flag on another bit of the code where
> index-pack in general has certain paranoias/validation the user might be
> willing to optionally drop just at "clone" time.

Yeah, I agree it may be worth pursuing independently. I just don't think
it will help Martin's case in any noticeable way.

> > Right, that would work. I will note one thing, though: the total time to
> > do a 1-depth clone followed by an unshallow is probably much higher than
> > doing the whole clone as one unit, for two reasons:
> 
> Indeed. The hypothesis is that the user doesn't really care about the
> clone-time, but the clone-to-repo-mostly-usable time.

There was a little bit of self-interest in there for me, too, as a
server operator. While it does add to the end-to-end time, most of the
resource use for the shallow fetch gets put on the server. IOW, I don't
think we'd be happy to see clients doing this depth-1-and-then-unshallow
strategy for every clone.

> > So in general, I think you'd need some cooperation from the server side
> > to ask it to generate and send the .idx that matches the .pack it is
> > sending you. Or even if not the .idx format itself, some stable list of
> > sha1s that you could use to reproduce it without hashing each
> > uncompressed byte yourself.
> 
> Yeah, depending on how jt/fetch-cdn-offload is designed (see my
> https://public-inbox.org/git/87k1hv6eel.fsf@evledraar.gmail.com/) it
> could be (ab)used to do this. I.e. you'd keep a "base" *.{pack,idx}
> around for such a purpose.
> 
> So in such a case you'd serve up that recent-enough *.{pack,idx} for the
> client to "wget", and the client would then trust it (or not) and do the
> equivalent of a "fetch" from that point to be 100% up-to-date.

I think it's sort of orthogonal. Either way you have to teach the client
how to get a .pack/.idx combo. Whether it learns to receive it inline
from the first fetch, or whether it is taught to expect it from the
out-of-band fetch, most of the challenge is the same.

> > This could even be stuffed into the pack format and stripped out by
> > the receiving index-pack (i.e., each entry is prefixed with "and by
> > the way, here is my sha1...").
> 
> That would be really interesting. I.e. just having room for that (or
> anything else) in the pack format.
> 
> I wonder if it could be added to the delta-chain in the current format
> as a nasty hack :)

There's definitely not "room" in any sense of the word in the pack
format. :) However, as long as all parties agreed, we can stick whatever
we want into the on-the-wire format. So I was imagining something more
like:

  1. pack-objects learns a --report-object-id option that sticks some
     additional bytes before each object (in its simplest form,
     $obj_hash bytes of id)

  2. likewise, index-pack learns a --parse-object-id option to receive
     it and skip hashing the object bytes

  3. we get a new protocol capability, "send-object-ids". If the server
     advertises and the client requests it, then both sides turn on the
     appropriate option

You could even imagine generalizing it to "--report-object-metadata",
and including 0 or more metadata packets before each object. With object
id being one, but possibly other computable bits like "generation
number" after that. I'm not convinced other metadata is worth the
space/time tradeoff, though. After all, this is stuff that the client
_could_ generate and cache themselves, so you're trading off bandwidth
to save the client from doing the computation.

Anyway, food for thought. :)

-Peff
