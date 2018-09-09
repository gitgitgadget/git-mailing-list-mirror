Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE24B1F404
	for <e@80x24.org>; Sun,  9 Sep 2018 02:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbeIIHR2 (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 03:17:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:43966 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726152AbeIIHR2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 03:17:28 -0400
Received: (qmail 16005 invoked by uid 109); 9 Sep 2018 02:29:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 09 Sep 2018 02:29:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31863 invoked by uid 111); 9 Sep 2018 02:29:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 22:29:46 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 22:29:32 -0400
Date:   Sat, 8 Sep 2018 22:29:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        stas@stason.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180909022931.GA13485@sigill.intra.peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
 <20180908211436.GA31560@sigill.intra.peff.net>
 <87musr7h7q.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87musr7h7q.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 09, 2018 at 12:32:57AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > You could even do:
> >
> >   [include]
> >   warnOnMissing = false
> >   path = one
> >   warnOnMissing = true
> >   path = two
> >
> > to treat two includes differently (though I'm not sure why you would
> > want to).
> 
> I think this is introducing a brand new caveat into our *.ini syntax,
> i.e. that we're sensitive to the order in which we're parsing
> *different* keys.
> 
> I.e. we already had the concept that some keys override existing sets
> (e.g. user.name), but not that a x.y=foo controls the behavior of a
> subsequent a.b=bar, or the other way around.

This already exists. For example:

  echo '[foo]bar = inc' >config.inc
  echo '[foo]bar = main' >config.main
  echo '[include]path = config.inc' >>config.main
  git config -f config.main --includes foo.bar

Arriving at that answer requires expanding the include's contents at
the exact same spot in the file.

As far as I know this is the only case, though, so include.path really
is special. And this would be expanding that specialness to other things
in include.*. But I'm not sure that is really that big a deal. That
warnOnMissing isn't meant to be just a normal key. It's an
order-sensitive directive for further parsing, just like include.path
is. Either the parser understands includes (and has to handle these) or
it doesn't.

So I'm not worried about any burden on the parsing side, but...

> This also makes programmatic (via "git config") editing of the config
> hard, we'd need to introduce something like:
> 
>     git config -f ~/.gitconfig a.b bar
>     git config -f ~/.gitconfig --before a.b x.y foo
> 
> To set a.b=bar before x.y=foo, or --after or whatever.

Yes, I don't think "git config include.warnOnMissing true" would be very
useful, because it would generally be added after any includes you have,
and therefore not affect them.

I think this is generally an issue with include.path, too. My assumption
has been that anybody at the level of using includes is probably going
to be hand-editing anyway.

But if include.* is special on the parsing side, I don't know that it is
that bad to make it special on the writing side, too. I.e., to recognize
"git config include.warnOnMissing true" and always add it at the head of
any existing include block.

It certainly _feels_ hacky, but I think it would behave sensibly and
predictably. And it would just work, as opposed to requiring something
like "--before", which would be quite a subtle gotcha for somebody to
forget to use.

> Yeah, we could do that, and it wouldn't break the model described above,
> We can make that work, but this would be nasty. E.g. are we going to
> treat EACCES and ENOENT the same way in this construct?

I don't have a strong opinion (after all, I already wrote the behavior I
thought was reasonable long ago ;) ). So I think it would be up to
somebody to propose. We do already report and die on EACCES (and
basically any other error except ENOENT). So if we did treat them both
as a warning, that would be a weakening for EACCES.

-Peff
