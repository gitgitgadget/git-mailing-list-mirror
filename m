Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C65C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:51:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3E1F206D9
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:51:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726337AbgD1UvU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:51:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:42960 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726208AbgD1UvU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Apr 2020 16:51:20 -0400
Received: (qmail 23660 invoked by uid 109); 28 Apr 2020 20:51:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 Apr 2020 20:51:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6986 invoked by uid 111); 28 Apr 2020 21:02:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Apr 2020 17:02:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Apr 2020 16:51:19 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2] fetch-pack: try harder to read an ERR packet
Message-ID: <20200428205119.GB4000@coredump.intra.peff.net>
References: <20200428074442.29830-1-chriscool@tuxfamily.org>
 <xmqqzhav1kix.fsf@gitster.c.googlers.com>
 <20200428195957.GA45908@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200428195957.GA45908@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 01:59:57PM -0600, Taylor Blau wrote:

> > > When the server has hung up after sending an ERR packet to the
> > > client, the client might still be writing, for example a "done"
> > > line. Therefore the client might get a write error before reading
> > > the ERR packet.
> > >
> > > When fetching, this could result in the client displaying a
> > > "Broken pipe" error, instead of the more useful error sent by
> > > the server in the ERR packet.
> >
> > Hmm, if the connection gets severed just before the ERR packet the
> > other side has written, we will see "Broken pipe" if we write
> > "done", and no amount of "try to read to collect as much what they
> > said as possible" would help.  If you are lucky and the connection
> > is broken after the ERR reaches on this side, such an "extra effort"
> > may help, but is it really worth the effort?  It is not clear to me
> > if the extra complexity, one more API function people need to learn,
> > and the need to think which one to use every time they want to say
> > write_in_full(), are justifiable.
> >
> > I dunno.
> 
> I think that you're right. The more that I thought about my suggestion,
> the more dumb I was convinced that it was.

Now I'm confused about which suggestion. The overall patch's purpose is
still good, I think (see my other response). But I agree that having an
alternate write_in_full() is spreading the hack too far outside of
fetch-pack (and as I wrote in [1], I really don't understand what it's
trying to do).

-Peff

[1] https://lore.kernel.org/git/20200428083336.GA2405176@coredump.intra.peff.net/
