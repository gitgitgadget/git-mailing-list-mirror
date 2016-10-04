Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09C9A20986
	for <e@80x24.org>; Tue,  4 Oct 2016 20:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754190AbcJDUti (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 16:49:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:52358 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754155AbcJDUth (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 16:49:37 -0400
Received: (qmail 18559 invoked by uid 109); 4 Oct 2016 20:49:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 20:49:36 +0000
Received: (qmail 9926 invoked by uid 111); 4 Oct 2016 20:49:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 04 Oct 2016 16:49:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2016 16:49:34 -0400
Date:   Tue, 4 Oct 2016 16:49:34 -0400
From:   Jeff King <peff@peff.net>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 06/18] t5613: clarify "too deep" recursion tests
Message-ID: <20161004204933.ygfhoy24g6psyf6h@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
 <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
 <CA+P7+xok5PoNKO+8R6zF9SXYfDq6BboDTDz9WZYEczs0pFK+pw@mail.gmail.com>
 <20161004134853.x3zq33ywyyzgbwsy@sigill.intra.peff.net>
 <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+P7+xok-8vhikxkp+t8pu53YJAyUjZ0NiAwejEW2j3+eP_2Xw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 04, 2016 at 01:44:23PM -0700, Jacob Keller wrote:

> On Tue, Oct 4, 2016 at 6:48 AM, Jeff King <peff@peff.net> wrote:
> > On Mon, Oct 03, 2016 at 10:57:48PM -0700, Jacob Keller wrote:
> >
> >> > diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
> >> > index 7bc1c3c..b393613 100755
> >> > --- a/t/t5613-info-alternate.sh
> >> > +++ b/t/t5613-info-alternate.sh
> >> > @@ -39,6 +39,18 @@ test_expect_success 'preparing third repository' '
> >> >         )
> >> >  '
> >> >
> >> > +# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
> >> > +# the depth at 0 and count links, not repositories, so in a chain like:
> >> > +#
> >> > +#   A -> B -> C -> D -> E -> F -> G -> H
> >> > +#      0    1    2    3    4    5    6
> >> > +#
> >>
> >> Ok so we count links, but wouldn't we have 5 links when we hit F, and
> >> not G? Or am I missing something here?
> >
> > This is what I was trying to get at with the "start the depth at 0". We
> > disallow a depth greater than 5, but because we start at 0-counting,
> > it's really six links. I guess saying "5 as too deep" is really the
> > misleading part. It should be "5 as the maximum depth".
> >
> > -Peff
> 
> Right, but if A is 0, then:
> 
> B = 1
> C = 2
> D = 3
> E = 4
> F = 5
> G = 6  (UhOh??)
> H = 7
> 
> So do you mean that *B* = 0, and C = 1??? That is not clear from this commment.

No, we count links, not repositories. So the "A->B" link is "0", "B->C"
is "1", and so on.

> So either way it still feels like "6" links is what is allowed? Or the
> first link has to not count? That's really confusing.

Right, 6 links _are_ allowed. Because we count links, and because we
start the link-counting at "0" and allow through "5". The link labeled
"6" (which is really the seventh link!) is the one that is forbidden.

> Basically I G is the 7th letter, not the 6th, so even if we're
> subtractnig 1 it's still 6 which is 1 too deep? That means we not only
> discard 0 (the first repository) but we discount the 2nd one as well?

It's basically two off-by-ones from what you might think is correct.  I
agree it's unintuitive, but I'm just documenting what's there. We could
change it; it's not like anybody cares about the exact value except
"deep enough", but _since_ nobody cares, I preferred not to modify the
code.

-Peff
