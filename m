Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088291F4F8
	for <e@80x24.org>; Fri, 30 Sep 2016 08:07:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752316AbcI3IHE (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 04:07:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:50387 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751020AbcI3IHC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 04:07:02 -0400
Received: (qmail 24225 invoked by uid 109); 30 Sep 2016 08:07:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 08:07:00 +0000
Received: (qmail 8830 invoked by uid 111); 30 Sep 2016 08:07:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 30 Sep 2016 04:07:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Sep 2016 04:06:58 -0400
Date:   Fri, 30 Sep 2016 04:06:58 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] core.abbrev: raise the default abbreviation to 12
 hexdigits
Message-ID: <20160930080658.lyi7aovvazjmy346@sigill.intra.peff.net>
References: <CA+55aFwbCNiF0nDppZ5SuRcZwc9kNvKYzgyd_bR8Ut8XRW_p4Q@mail.gmail.com>
 <20160929191609.maxggcli76472t4g@sigill.intra.peff.net>
 <CA+55aFxNVbvyERNc_xEhrtfTVMGz3hkeAx1nv9vW+dhJwCpp6g@mail.gmail.com>
 <xmqqwphuebhd.fsf@gitster.mtv.corp.google.com>
 <CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com>
 <xmqqbmz6cna5.fsf@gitster.mtv.corp.google.com>
 <CA+55aFysvNc4p_nFcV=edctCizJBJtDjFOHJa-YYgVZQgBZfiA@mail.gmail.com>
 <CA+55aFyXxQSygO-gqevLZDjuggOaHs7HsRO=P6GhpC3GStqwvQ@mail.gmail.com>
 <CA+55aFxsfxvDQqi2M3TUVvAHUx3Qm1hHQ4DMyzXzN6V2v7o-3A@mail.gmail.com>
 <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFyHn0Q-qPq4dPEJ7X_4jf5UbsVw2vE-4LoWYbPn6gS10g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 06:18:03PM -0700, Linus Torvalds wrote:

> On Thu, Sep 29, 2016 at 5:57 PM, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > Actually, all the other cases seem to be "parse a SHA1 with a known
> > length", so they really don't have a negative length.  So this seems
> > ok, and is easier to verify than the "what all contexts might use
> > DEFAULT_ABBREV" thing. There's only a few callers, and it's a static
> > function so it's easy to check it locally in sha1_name.c.
> 
> Here's my original patch with just a tiny change that instead of
> starting the automatic guessing at 7 each time, it starts at
> "default_automatic_abbrev", which is initialized to 7.
> 
> The difference is that if we decide that "oh, that was too small, need
> to repeat", we also update that "default_automatic_abbrev" value, so
> that we won't start at the number that we now know was too small.
> 
> So it still loops over the abbrev values, but now it only loops a
> couple of times.
> 
> I actually verified the performance impact by doing
> 
>       time git rev-list --abbrev-commit HEAD > /dev/null
> 
> on the kernel git tree, and it does actually matter. With my original
> patch, we wasted a noticeable amount of time on just the extra
> looping, with this it's down to the same performance as just doing it
> once at init time (it's about 12s vs 9s on my laptop).

I agree that this deals with the performance concerns by caching the
default_abbrev_len and starting there. I still think it's unnecessarily
invasive to touch get_short_sha1() at all, which is otherwise only a
reading function.

So IMHO, the best combination is the init_default_abbrev() you posted in
[1], but initialized at the top of find_unique_abbrev(). And cached
there, obviously, in a similar way.

-Peff

[1] http://public-inbox.org/git/CA+55aFyVEQ+8TBBUm5KG9APtd9wy8cp_mRO=3nj12DXZNLAC9A@mail.gmail.com/
