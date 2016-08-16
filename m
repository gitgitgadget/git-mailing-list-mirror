Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5295D1F859
	for <e@80x24.org>; Tue, 16 Aug 2016 16:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751404AbcHPQWB (ORCPT <rfc822;e@80x24.org>);
	Tue, 16 Aug 2016 12:22:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:56318 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751222AbcHPQVo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Aug 2016 12:21:44 -0400
Received: (qmail 17284 invoked by uid 109); 16 Aug 2016 16:21:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 16:21:44 +0000
Received: (qmail 27665 invoked by uid 111); 16 Aug 2016 16:21:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 16 Aug 2016 12:21:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Aug 2016 12:21:41 -0400
Date:	Tue, 16 Aug 2016 12:21:41 -0400
From:	Jeff King <peff@peff.net>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] receive-pack: allow a maximum input size to be
 specified
Message-ID: <20160816162141.b3jtmun3kynjnwxs@sigill.intra.peff.net>
References: <20160816081701.29949-1-chriscool@tuxfamily.org>
 <20160816081701.29949-4-chriscool@tuxfamily.org>
 <20160816131640.h2zzn3sy5qqdeewc@sigill.intra.peff.net>
 <CAP8UFD2r-Zi757zizRQq-TPp+dO=+=ho=7oOipjPxY4ksmzC=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2r-Zi757zizRQq-TPp+dO=+=ho=7oOipjPxY4ksmzC=g@mail.gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Aug 16, 2016 at 04:27:10PM +0200, Christian Couder wrote:

> >> +while read unpacklimit filesize filename
> >> +do
> >> [...]
> >> +done <<\EOF
> >> +1 1024 one-k-file
> >> +10 2048 two-k-file
> >> +EOF
> >
> > Is there any reason to use different filenames and sizes for the two
> > runs? They should behave identically, so it would make more sense to me
> > to subject them to identical inputs.
> 
> About the sizes, I thought that some people might want to try sizes
> closer to the limit and also that it is good anyway in general to add
> a bit of "randomness", or at least variability, in the tests.

In general, I'd prefer a systematic approach to introducing variables
into tests. If it's important that we test different sizes, then we
should do so, and not only test some combinations (and if it is not
important to test different sizes, then we should not waste CPU time and
the mental energy of people reading the tests).

IOW, when I see this, I wonder why the index-pack code path is not
tested against a 2k file. But there really isn't a good reason. So
either it does matter, and our tests do not have good coverage, or it
does not, and it is just making me wonder if the tests are buggy.

Worse, both files are created with the same seed via test-genrandom. So
I suspect the 2k file is a superset of the 1k file, and we may send it
is a thin delta (so it really is only testing a 1k input anyway!).

> I thought that it would be a bit less wasteful to use the same "dest"
> and also it would make the test more realistic as people often push in
> non empty repos.

I doubt it is expensive enough to matter in practice. Though note that
if you push the same commit to two new repositories, then you can
amortize the test-genrandom/add/commit step (i.e., push the exact same
packfile in both cases).

-Peff
