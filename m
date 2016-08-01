Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 622F91F855
	for <e@80x24.org>; Mon,  1 Aug 2016 19:02:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754786AbcHATCk (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:02:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:52735 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754730AbcHATCh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:02:37 -0400
Received: (qmail 9193 invoked by uid 102); 1 Aug 2016 18:00:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:00:50 -0400
Received: (qmail 15449 invoked by uid 107); 1 Aug 2016 18:01:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Aug 2016 14:01:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Aug 2016 14:00:47 -0400
Date:	Mon, 1 Aug 2016 14:00:47 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Paul Tan <pyokagan@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
Message-ID: <20160801180047.sgzqgh7pvp2qzwug@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
 <CACRoPnS2kDRLiY8KX3K4Havh7d1GWy3mUXSiYCzw45BznuwYeA@mail.gmail.com>
 <20160730024135.oaqtjpo5l2e3dam2@sigill.intra.peff.net>
 <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbn1cl6qv.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Aug 01, 2016 at 10:49:12AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> So maybe we would have to put reset_ident_date() at the end of the
> >> function instead, at least after git_committer_info() is called.
> >
> > Yes, although "reset and end" still feels a bit weird to me.
> >
> > I'd almost prefer to just have long-running programs insert resets at
> > strategic points.
> 
> Certainly "reset at the end" feels weird but it can be explained as
> "for a one-shot thing we use the first time of the default date and
> it gives a consistent timestamp; conceptually, things that make
> multiple commits are like doing that one-shot thing multiple times
> in a row."
> 
> When viewed that way, it is not _too_ bad, I would guess.

I think what bothers me is that you could use similar logic for "reset
at the beginning". The problem is that we don't know when "the
beginning" is. I thought it was inside commit_tree_extended(), but for
some operations, it's not, as Paul showed.

So when is "the end"? Is it at the end of commit_tree_extended()? I'm
not sure. Already we know it depends on whether you consider the ref
update part of the same operation. Whether that matters is debatable.
Are there other cases (an obvious one would be the human-readable bits
printed by git-commit, but it looks like those are done beforehand)?
Even if we do check every case, though, it seems like a fragile
assumption to be making.

So at this point I think I'd lean towards programs which have multiple
logical commit operations explicitly saying "I am starting a new
operation". It may be that we end up attaching more to that in the long
run than just timestamp resets, too (i.e., what other cached data might
there be that used to happen in separate sub-processes?).

-Peff
