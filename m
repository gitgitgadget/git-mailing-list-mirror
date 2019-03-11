Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DE1E220248
	for <e@80x24.org>; Mon, 11 Mar 2019 22:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbfCKWji (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 18:39:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:46556 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725819AbfCKWji (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 18:39:38 -0400
Received: (qmail 17685 invoked by uid 109); 11 Mar 2019 22:39:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 11 Mar 2019 22:39:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27865 invoked by uid 111); 11 Mar 2019 22:39:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 11 Mar 2019 18:39:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Mar 2019 18:39:36 -0400
Date:   Mon, 11 Mar 2019 18:39:36 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>,
        Yagamy Light <hi-angel@yandex.ru>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 1/1] worktree add: sanitize worktree names
Message-ID: <20190311223936.GA24989@sigill.intra.peff.net>
References: <20190305120834.7284-1-pclouds@gmail.com>
 <20190308092834.12549-1-pclouds@gmail.com>
 <20190308092834.12549-2-pclouds@gmail.com>
 <CAPig+cQYDuKrRwf9GrGZUTnH=BgSyp8Rmh7ON1p+0qOrHxpe3Q@mail.gmail.com>
 <xmqqbm2ikk4q.fsf@gitster-ct.c.googlers.com>
 <CACsJy8CqN=Uu-Fez7T9evazitVopXt2dkQ1rGzKwh94tdiUdvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8CqN=Uu-Fez7T9evazitVopXt2dkQ1rGzKwh94tdiUdvA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 11, 2019 at 04:24:13PM +0700, Duy Nguyen wrote:

> > > I think this needs to be:
> > >
> > >     strbuf_setlen(sanitized, sanitized->len - 1);
> > >
> > > to ensure that NUL-terminator ends up in the correct place if this "."
> > > is the very last character in 'refname'. (Otherwise, the NUL will
> > > remain after the second ".", thus ".." won't be collapsed to "." at
> > > all.)
> >
> > True.  Why doesn't it do the similar "replace with -" it does for
> > other unfortunate characters, though?
> 
> I think Jeff saw an opportunity to keep it cleaner ("." looks better
> than ".-") and took it.

Yeah, that was one thing I was going to comment on your patch. The
"rules" I made up were pretty ad-hoc as I was walking through the
function (note it also drops ".lock" instead of sanitizing it into
"-lock").

But it may make sense to make things more consistent (even if the result
isn't entirely reversible).

Another option _is_ to actually make it reversible. I.e., use "%2e"
instead of ".", which would also necessitate replacing "%". I don't know
if that has a huge value for this use-case, but it's a nice property
that two sanitized names can't collide (unless they originally
identical).

-Peff
