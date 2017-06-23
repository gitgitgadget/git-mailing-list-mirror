Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE35320282
	for <e@80x24.org>; Fri, 23 Jun 2017 20:10:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755085AbdFWUKX (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Jun 2017 16:10:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:51210 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754969AbdFWUKX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2017 16:10:23 -0400
Received: (qmail 15476 invoked by uid 109); 23 Jun 2017 20:10:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Jun 2017 20:10:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18778 invoked by uid 111); 23 Jun 2017 20:10:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 23 Jun 2017 16:10:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Jun 2017 16:10:20 -0400
Date:   Fri, 23 Jun 2017 16:10:20 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: --color-moved feedback, was Re: [PATCH v2 19/29] packed-backend: new
 module for handling packed references
Message-ID: <20170623201020.24zus6tsnf2i62d3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[I culled the cc list, as it was big and they don't all necessarily care
about this feature]

On Fri, Jun 23, 2017 at 12:46:47PM -0700, Stefan Beller wrote:

> > Looks good. Stefan will be happy to know that I used --color-moved to
> > look at it. ;)
> 
> Hah!
> 
> As a follow up on that, let's perform a user survey :-P
> * How was your review experience?
> * Were you annoyed by the default colors or mode?
>   (That is best expressed as a patch, as it seems like
>    bikeshedding to me, but I am far from being a UX expert ;)

I'm not sure what the default mode is. When I first used it it seemed to
italicize a bunch of text. Which I didn't even notice at first, so I
thought it was broken.

In the end, I just did --color-moved=plain, which seemed to color with
magenta/cyan. I found that a bit loud and switched to "red 80" and
"green 80" (i.e., a dark grey background, as I usually have a black
one). I probably would have picked a darker grey, but I use urxvt and it
doesn't seem to do 24-bit color codes.

I didn't try the "dim" feature; I don't think urxvt supports that
attribute (though maybe it was what was doing the italics?).

Anyway, it worked fine after that. My main use for it was just seeing
"yep, this is all a giant moved chunk, so I don't have to look carefully
at it".

One minor quibble is that I used with "git log", so I was looking at all
the commits with that coloring. But the ones that didn't have movement
had a lot of noisy "moved" sections. E.g., one line moving here or
there, or even blank lines. It might be worth having some heuristics to
identify a chunk (I think I saw some discussion on that earlier, and
maybe it's even there and I didn't see it).

> Just today I thought about that further:
> While reviewing is one thing (which I do a lot), how can we make this
> work with merging changes?
> 
> I think the file rename detection is acknowledged by the merge code,
> such that a plain file rename and a patch to said file is easy on the
> maintainer, but we would want that for smaller code movements, too.
> 
> Let's take this patch as an example, if someone were to find a bug
> in one of the moved functions, they would send a fix based on the
> function in refs/files-backend.c, such that it can easily be merged down
> to maint, but when merging it forward with this, it may clash.

That feels more dangerous to me, just because the heuristics seem to
find a lot of "moves" of repeated code. Imagine a simple patch like
"switch return 0 to return -1". If the code you're touching went away,
there's a very good chance that another "return 0" popped up somewhere
else in the code base. A conflict is what you want there; silently
changing some other site would be not only wrong, but quite subtle and
hard to find.

-Peff
