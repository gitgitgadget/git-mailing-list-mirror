Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D76932022D
	for <e@80x24.org>; Thu, 23 Feb 2017 18:46:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbdBWSql (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 13:46:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:60926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750828AbdBWSqk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 13:46:40 -0500
Received: (qmail 8355 invoked by uid 109); 23 Feb 2017 18:46:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 18:46:39 +0000
Received: (qmail 12721 invoked by uid 111); 23 Feb 2017 18:46:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 13:46:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 13:46:37 -0500
Date:   Thu, 23 Feb 2017 13:46:37 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <CAPc5daVZ79WWKSw76kxHgDra9a7fSR1AibZa_pvK9aUuuVawLQ@mail.gmail.com>
 <20170223173547.qljypk7sdqi37oha@kitenet.net>
 <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 10:40:48AM -0800, Linus Torvalds wrote:

> > Generate a regular commit object; use the entire commit object + NUL as the
> > chosen prefix, and use the identical-prefix collision attack to generate
> > the colliding good/bad objects.
> 
> So I agree with you that we need to make git check for the opaque
> data. I think I was the one who brought that whole argument up.

We do already.

> But even then, what you describe doesn't work. What you describe just
> replaces the opaque data - that git doesn't actually *use*, and that
> nobody sees - with another piece of opaque data.
> 
> You also need to make the non-opaque data of the bad object be
> something that actually encodes valid git data with interesting hashes
> in it (for the parent/tree/whatever pointers).
> 
> So you don't have just that "chosen prefix". You actually need to also
> fill in some very specific piece of data *in* the attack parts itself.
> And you need to do this in the exact same size (because that's part of
> the prefix), etc etc.

It's not an identical prefix, but I think collision attacks generally
are along the lines of selecting two prefixes followed by garbage, and
then mutating the garbage on both sides. That would "work" in this case
(modulo the fact that git would complain about the NUL).

I haven't read the paper yet to see if that is the case here, though.

A related case is if you could stick a "cruft ...." header at the end of
the commit headers, and mutate its value (avoiding newlines). fsck
doesn't complain about that.

-Peff
