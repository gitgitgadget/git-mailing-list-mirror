Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF766201B0
	for <e@80x24.org>; Sun, 26 Feb 2017 06:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbdBZGIJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 01:08:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:34304 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750970AbdBZGH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 01:07:29 -0500
Received: (qmail 12105 invoked by uid 109); 26 Feb 2017 06:07:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 06:07:29 +0000
Received: (qmail 15885 invoked by uid 111); 26 Feb 2017 06:07:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 01:07:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Feb 2017 01:07:26 -0500
Date:   Sun, 26 Feb 2017 01:07:26 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v5 1/1] config: add conditional include
Message-ID: <20170226060726.mvdip4vnbdngypzx@sigill.intra.peff.net>
References: <20170223122346.12222-1-pclouds@gmail.com>
 <20170223122346.12222-2-pclouds@gmail.com>
 <xmqqwpcg7k6r.fsf@gitster.mtv.corp.google.com>
 <CACsJy8CerU-=PF6wqzUAM02jkrVVGJ5MA0NgL6z9bHn5KM6jiw@mail.gmail.com>
 <xmqq1sun5vo6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1sun5vo6.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 09:46:17AM -0800, Junio C Hamano wrote:

> Duy Nguyen <pclouds@gmail.com> writes:
> 
> >>> +     if (skip_prefix_mem(cond, cond_len, "gitdir:", &cond, &cond_len))
> >>> +             return include_by_gitdir(cond, cond_len, 0);
> >>> +     else if (skip_prefix_mem(cond, cond_len, "gitdir/i:", &cond, &cond_len))
> >>> +             return include_by_gitdir(cond, cond_len, 1);
> >>
> >> This may be OK for now, but it should be trivial to start from a
> >> table with two entries, i.e.
> >>
> >>         struct include_cond {
> >>                 const char *keyword;
> >>                 int (*fn)(const char *, size_t);
> >>         };
> >>
> >> and will show a better way to do things to those who follow your
> >> footsteps.
> >
> > Yeah I don't see a third include coming soon and did not go with that.
> > Let's way for it and refactor then.
> 
> I would have said exactly that in my message if you already had
> include_by_gitdir() and include_by_gitdir_i() as separate functions.
> 
> But I didn't, because the above code gives an excuse to the person
> who adds the third one to be lazy and add another "else if" for
> expediency, because making it table-driven would require an extra
> work to add two wrapper functions that do not have anything to do
> with the third one being added.

I don't think driving that with a two-entry table is the right thing
here. We are as likely to add another "foobar:" entry as we are to add
another modifier "/i" modifier to "gitdir:", and it is unclear whether
that modifier would be mutually exclusive with "/i".

E.g., imagine we add "/re" for a regex, but allow a case-insensitive
regex with an "i", giving something like "gitdir/i/re:".  Now you would
want to drive it by matching "gitdir" first, and then collecting the
"/i/re" independently, to avoid an explosion of matches.

Driving that with a table is much more complex. I'd just as soon keep
things as simple as possible for now and worry about flagging it in
review when something new gets added.

-Peff
