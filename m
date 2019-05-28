Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0786D1F462
	for <e@80x24.org>; Tue, 28 May 2019 05:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbfE1Foh (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 01:44:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:39360 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725904AbfE1Fog (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 01:44:36 -0400
Received: (qmail 27007 invoked by uid 109); 28 May 2019 05:44:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 28 May 2019 05:44:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10234 invoked by uid 111); 28 May 2019 05:45:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 28 May 2019 01:45:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 May 2019 01:44:35 -0400
Date:   Tue, 28 May 2019 01:44:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Keegan Carruthers-Smith <keegan.csmith@gmail.com>,
        git@vger.kernel.org
Subject: Re: git archive generates tar with malformed pax extended attribute
Message-ID: <20190528054434.GA7946@sigill.intra.peff.net>
References: <CAMVcy0Q0TL6uEGR2NeudJrOiXdQ87XcducL0EwMidWucjk5XYw@mail.gmail.com>
 <20190524070644.GF25694@sigill.intra.peff.net>
 <CAMVcy0ThtcDNjqat0+nQ4B91hC30NTUe=RW8v9WDxA2Q-4SyRA@mail.gmail.com>
 <20190524081337.GA9082@sigill.intra.peff.net>
 <b4aaff4b-eaf7-9eaf-063f-42c073078060@web.de>
 <877eaefdkt.fsf@evledraar.gmail.com>
 <2b52ca7b-bb72-193a-9d6b-83003ce49424@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2b52ca7b-bb72-193a-9d6b-83003ce49424@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 26, 2019 at 11:33:20PM +0200, René Scharfe wrote:

> Git archive writes link targets that are 100 characters long or less
> into the appropriate field in the plain tar header.  It copies
> everything, including NULs, but unlike a PAX extended header that field
> lacks a length indicator, so extractors basically have to treat it as
> NUL-terminated.
> 
> If we want to preserve NUL in short link targets as well, we'd have to
> put such names into an PAX extended header..

I can't say that I care much either way, since putting NULs in your
filenames is pretty crazy. But that would at least make things
consistent regardless of the length.

I also wondered if you could play any security tricks here (e.g., by
having one tool view a filename as "foo" and another as "foo\0bar"). I
doubt it, though.  Filenames themselves in Git are always
NUL-terminated, since that's dictated the tree format; so this is really
just about link destinations.

And even then, it's hard to imagine a case. I was wondering if you could
have an entry ".git\0foo" that ends up written to the filesystem as
".git". But these are tar archives we're talking about, so it's not like
you couldn't just put ".git" in a tar file in the first place.

But maybe somebody else can brainstorm something more evil. :)

-Peff
