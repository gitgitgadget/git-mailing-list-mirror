Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4BB1F404
	for <e@80x24.org>; Wed,  5 Sep 2018 15:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbeIEUTP (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 16:19:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:40008 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726335AbeIEUTP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 16:19:15 -0400
Received: (qmail 14563 invoked by uid 109); 5 Sep 2018 15:48:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 05 Sep 2018 15:48:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19744 invoked by uid 111); 5 Sep 2018 15:48:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 05 Sep 2018 11:48:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Sep 2018 11:48:27 -0400
Date:   Wed, 5 Sep 2018 11:48:27 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Van Oostenryck Luc <luc.vanoostenryck@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>
Subject: Re: [PATCH] reopen_tempfile(): truncate opened file
Message-ID: <20180905154827.GC24660@sigill.intra.peff.net>
References: <20180902050803.GA21324@sigill.intra.peff.net>
 <20180902071204.GA2868@duynguyen.home>
 <20180902072408.GA18787@sigill.intra.peff.net>
 <xmqq36upcl1s.fsf@gitster-ct.c.googlers.com>
 <CACsJy8AuWKxAdETaqYmcSY2VeLeWFyjnSYrK4GJeyG5ecv3OcA@mail.gmail.com>
 <20180904163807.GA23572@sigill.intra.peff.net>
 <20180904233643.GA9156@sigill.intra.peff.net>
 <CACsJy8Ax4S9Sms6TY1dMV8M9-=hakEW8TCqn8yxb73Vbrpy_MQ@mail.gmail.com>
 <20180905153551.GB24660@sigill.intra.peff.net>
 <CACsJy8BGxqzjXUprnhSU7jQDjzgDnY4x+SMsnOVb4Uho4dJt0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BGxqzjXUprnhSU7jQDjzgDnY4x+SMsnOVb4Uho4dJt0g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 05, 2018 at 05:39:19PM +0200, Duy Nguyen wrote:

> On Wed, Sep 5, 2018 at 5:35 PM Jeff King <peff@peff.net> wrote:
> > > > +       after=$(wc -c <.git/index) &&
> > > > +
> > > > +       # double check that the index shrank
> > > > +       test $before -gt $after &&
> > > > +
> > > > +       # and that our index was not corrupted
> > > > +       git fsck
> > >
> > > If the index is not shrunk, we parse remaining rubbish as extensions.
> > > If by chance the rubbish extension name is in uppercase, then we
> > > ignore (and not flag it as error). But then the chances of the next 4
> > > bytes being the "right" extension size is so small that we would end
> > > up flagging it as bad extension anyway. So it's good. But if you want
> > > to be even stricter (not necessary in my opinion), make sure that
> > > stderr is empty.
> >
> > In this case, the size difference is only a few bytes, so the rubbish
> > actually ends up in the trailing sha1. The reason I use git-fsck here is
> > that it actually verifies the whole sha1 (since normal index reads no
> > longer do). In fact, a normal index read won't show any problem for this
> > case (since it is _only_ the trailing sha1 which is junk, and we no
> > longer verify it on every read).
> >
> > In the original sparse-dev case, the size of the rubbish is much larger
> > (because we deleted a lot more entries), and we do interpret it as a
> > bogus extension. But it also triggers here, because the trailing sha1 is
> > _also_ wrong.
> >
> > So AFAIK this fsck catches everything and yields a non-zero exit in the
> > error case. And it should work for even a single byte of rubbish.
> 
> Yes you're right. I forgot about the trailing hash.

Thanks, I was worried that I was missing something. ;)

Maybe it is worth making that final comment:

  # and that the trailing hash in the index was not corrupted,
  # which should catch even a single byte of cruft
  git fsck

-Peff
