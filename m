Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CDE95207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 12:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S938923AbcIZMJq (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 08:09:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:48057 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933347AbcIZMJq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 08:09:46 -0400
Received: (qmail 19246 invoked by uid 109); 26 Sep 2016 12:09:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 12:09:45 +0000
Received: (qmail 4540 invoked by uid 111); 26 Sep 2016 12:09:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 26 Sep 2016 08:09:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Sep 2016 08:09:43 -0400
Date:   Mon, 26 Sep 2016 08:09:43 -0400
From:   Jeff King <peff@peff.net>
To:     Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: Changing the default for "core.abbrev"?
Message-ID: <20160926120942.tjaxhcwwz3lyxy25@sigill.intra.peff.net>
References: <CA+55aFy0_pwtFOYS1Tmnxipw9ZkRNCQHmoYyegO00pjMiZQfbg@mail.gmail.com>
 <xmqq37knwcf4.fsf@gitster.mtv.corp.google.com>
 <vpq37kntbjj.fsf@anie.imag.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <vpq37kntbjj.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 26, 2016 at 08:33:52AM +0200, Matthieu Moy wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I am not opposed to bump the default to 12 or whatever, but I
> > suspect any lengthening today may need to be accompanied by a tool
> > support that finds the set of objects that are reachable from a
> > commit whose names begin with non-unique abbreviations that appear
> > in the commit log message.
> 
> Something much simpler would be to set core.abbrev at clone time,
> depending on the size of the project just cloned. So, when cloning a
> hello-world, we'd keep the 7 but when cloning a big project we'd get a
> larger value.
> 
> This doesn't cover the case of someone growing his own project without
> cloning, and isn't as clever as actually looking for colision, but it
> would probably provide a sane default in 99% cases, and wouldn't be
> worse than hardcoding 7 in the 1% remaining cases.

I think we could easily make this even more dynamic, and just base the
minimum for DEFAULT_ABBREV on the number of objects _currently_ in the
repository, plus some safety factor. We could do this cheaply by just
counting the number of objects in the packs (which we get for free when
we open their pack index). That misses loose objects, but if you have 4
million loose objects you have bigger problems than abbreviation
lengths, I think.

OTOH, any scheme that looks at the current repository size will
eventually grow outdated. The safety factor depends on how fast your
repository grows, and how big you expect it to eventually get. Such a
default might still have been using 7-character abbreviations on
linux.git in 2006, and we'd be stuck with them now.

The idea of a 12-character default is basically that we'd expect decades
or more for even the largest projects to get there, so you err on the
side of future-proofing.

-Peff
