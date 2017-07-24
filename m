Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A8ED203F3
	for <e@80x24.org>; Mon, 24 Jul 2017 19:36:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751692AbdGXTgy (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jul 2017 15:36:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:47452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750898AbdGXTgx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2017 15:36:53 -0400
Received: (qmail 12320 invoked by uid 109); 24 Jul 2017 19:36:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 19:36:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12188 invoked by uid 111); 24 Jul 2017 19:37:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Jul 2017 15:37:09 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Jul 2017 15:36:51 -0400
Date:   Mon, 24 Jul 2017 15:36:51 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Blake <eblake@redhat.com>, git@vger.kernel.org
Subject: Re: [PATCH] git-contacts: Add recognition of Reported-by
Message-ID: <20170724193651.ocup4b6cs5hqmstx@sigill.intra.peff.net>
References: <20170721141530.25907-1-eblake@redhat.com>
 <xmqqbmodj1pa.fsf@gitster.mtv.corp.google.com>
 <a8b47a45-0100-dbef-0bff-fdfdb9cbccb4@redhat.com>
 <xmqqwp71hj5n.fsf@gitster.mtv.corp.google.com>
 <20170724183103.b4vbr5xkijj7s7z3@sigill.intra.peff.net>
 <xmqqzibtd473.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzibtd473.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 24, 2017 at 12:29:04PM -0700, Junio C Hamano wrote:

> > There's already some prior art around trailers in the trailer.* config.
> > I wonder if it would make sense to claim a new key there, like:
> >
> >   git config trailer.Reported-by.autocc true
> >
> > If "Reported-by" is a trailer that your project uses, then there may be
> > some benefit to setting up other config related to it, and this would
> > mesh nicely. And then potentially other programs besides git-contacts
> > would want to respect that flag (perhaps send-email would even want to
> > do it itself; I think it already respects cc and s-o-b headers).
> 
> Sounds like a good suggestion.  But...
> 
> If I understand your proposal, the trailer stuff would still not
> care what value .autocc is set to while doing its own thing, but the
> programs that read the text file that the trailer can work on would
> pay attention to it, and they individually have to do so?  Perhaps
> there is a need for another mode "interpret-trailers" is told to run
> in, where it is given a text file with trailers in it and is told to
> show only the value that has .autocc bit on?  Alternatively, yield
> <key, value> pairs so that the user of the tool can further process
> the value differently depending on the key, or something?

Yeah, I don't think interpret-trailers is currently a useful tool for
looking at an extra config key like that. I'd expect it would need to be
extended, or a new tool added, or perhaps existing tools would need to
learn more about how trailers work (e.g., it would be nice if git-log
could do matching or even print them via %(trailer:reported-by)
placeholders or something). I think there's a lot of potential work in
that area.

Of course git-contacts (or send-email) _can_ just look look at all of
the trailer.*.autocc config and try to match those manually. But the
point of having trailer config, I think, is that we should stop doing
ad-hoc parsing and have a tool for manipulating and querying trailers.
If interpret-trailers isn't up to the task yet, I'd rather see work go
there.

But that (manual parsing) is basically how the current cc and s-o-b
trailers implemented inside of git-send-email, so I don't think it would
be the end of the world as a quick hack that could later be expanded to
use the trailer infrastructure.

-Peff
