Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F43C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C97412071C
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 19:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgDVTdZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:33:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:36326 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725935AbgDVTdZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 15:33:25 -0400
Received: (qmail 10060 invoked by uid 109); 22 Apr 2020 19:33:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 19:33:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1144 invoked by uid 111); 22 Apr 2020 19:44:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 15:44:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 15:33:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lubomir Rintel <lkundrak@v3.sk>,
        Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200422193324.GB558336@coredump.intra.peff.net>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
 <20200422103011.GA545254@coredump.intra.peff.net>
 <20200422104000.GA551233@coredump.intra.peff.net>
 <xmqqwo67k00z.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwo67k00z.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 08:33:48AM -0700, Junio C Hamano wrote:

> > I don't quite think that's the solution, though. Both old and new are
> > supposed to be respecting MAX_IN_VAIN. So it's not at all clear to me
> > why it restricts the number of haves we'll send in v2, but not in v0.
> 
> Thanks for digging.  I tend to agree with your assessment that the
> setting should not make a difference, if v0 find the common out of
> the exchange within the same number of "have"s.

I think v0 sends many more haves. Again, it's hard to compare the
protocol traces because of the framing, but if I simplify each one like:

  perl -lne '/fetch-pack([<>] .*)/ and print "fetch$1"' <packet-v0.trace  >small-v0.trace
  perl -lne '/fetch([<>] .*)/ and print "fetch$1"' <packet-v2.trace  >small-v2.trace

I think we can get an apples-to-apples-ish comparison. And the results
are quite different:

  $ grep -c have small-v0.trace
  11342
  $ grep -c have small-v2.trace
  496

So I think the two protocols are treating MAX_IN_VAIN quite differently.

It looks like v0 only respects it after seeing a "continue" (or maybe
any non-common ACK; they all seem to trigger got_continue), but v2 will
use it to limit the haves we send when the other side is just NAKing.

> I am guilty of introducing the hardcoded "give up after this many
> naks", which I admit I was never fond of, back in the days there was
> only one original protocol.  In retrospect, I probably should have
> done "after this many naks, stop sending each and every commit but
> start skipping exponentially (or fibonacci)" instead.  After all,
> this was meant to prevent walking all the way down to a different
> root commit when you have more of them than the repository you are
> fetching from---but (1) skipping exponentially down to root is way
> less expensive, even if it is a bit more expensive than not walking
> at all, and (2) if we find a common tree, even if it is distant, it
> is way better than not having any common tree at all.

I think fetch.negotiationAlgorithm=skipping is that thing. And it _does_
paper over the problem (the most horrific case goes away, but you end up
with twice as many objects as v2 finds).

Limiting the amount of work we're willing to spend digging in history
does make sense, but it seems like we'd always want to at least dig a
little on each ref. For example, imagine a pathological case like this:

  - the client has 10,001 refs; the first 10,000 (sorted alphabetically)
    point to commit graph X. The last one points to some disjoint commit
    graph Y.

  - the server only cares about Y, and it has some Y' that adds one
    commit on top

We _should_ be able to serve that fetch with a single commit (Y->Y').
And we could find it trivially by feeding all of the ref tips as "have"
lines. But I suspect we wouldn't with v2, as we'd feed the first couple
hundred haves and then give up.

-Peff
