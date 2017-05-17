Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD7A3201A7
	for <e@80x24.org>; Wed, 17 May 2017 14:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753433AbdEQOWJ (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 10:22:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:53732 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751360AbdEQOWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 10:22:09 -0400
Received: (qmail 9007 invoked by uid 109); 17 May 2017 14:22:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 14:22:08 +0000
Received: (qmail 10102 invoked by uid 111); 17 May 2017 14:22:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 17 May 2017 10:22:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 17 May 2017 10:22:06 -0400
Date:   Wed, 17 May 2017 10:22:06 -0400
From:   Jeff King <peff@peff.net>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 04/23] prefix_ref_iterator: don't trim too much
Message-ID: <20170517142205.zbhhekogaw5gwqhr@sigill.intra.peff.net>
References: <cover.1495014840.git.mhagger@alum.mit.edu>
 <eecc015af8d7ed71223b591b13847fdb56ee69f0.1495014840.git.mhagger@alum.mit.edu>
 <20170517125510.qmy2qvyxuup25zw6@sigill.intra.peff.net>
 <7cec0285-fe6b-0e7e-83b4-b93c9770b55b@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7cec0285-fe6b-0e7e-83b4-b93c9770b55b@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2017 at 04:11:15PM +0200, Michael Haggerty wrote:

> > I suspect it's undefined behavior according to the standard, though I'd
> > guess in practice it would be fine. But if I'm understanding it
> > correctly, this is the same check as:
> > 
> >   if (strlen(iter->iter0->refname) <= iter->trim)
> > 
> > which seems a lot more obvious to me and doesn't fall afoul of weird
> > standard issues. The only downside I see is that it would read to the
> > end of string when yours could stop at iter->trim bytes. I have no idea
> > if that would be measurable (it might even be faster because strlen()
> > only has one condition to loop on).
> 
> You are correct that I chose `memchr()` over `strlen()` to avoid
> scanning a POTENTIALLY EXTREMELY LARGE NUMBER OF CHARACTERS past the
> trim length, but of course in real life refnames aren't that long and
> `strlen()` might actually be faster.

Heh. Yeah, I actually did dig up a glibc thread that says that strlen()
is even faster than rawmemchr(). But they were discussing buffer sizes
of at least 1K. For refnames I doubt it matters much at all.

> I *think* `memchr()` is technically OK:
> 
> > Implementations shall behave as if they read the memory byte by byte
> from the beginning of the bytes pointed to by s and stop at the first
> occurrence of c (if it is found in the initial n bytes).

Interesting. I don't really see how else you'd implement it, so that
makes sense (your quote is from POSIX; I first looked in C99, but
couldn't find any similar language there).

-Peff
