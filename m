Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7CCE1F404
	for <e@80x24.org>; Sat,  8 Sep 2018 21:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeIICBp (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Sep 2018 22:01:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:43894 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726638AbeIICBp (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Sep 2018 22:01:45 -0400
Received: (qmail 29455 invoked by uid 109); 8 Sep 2018 21:14:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 08 Sep 2018 21:14:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31212 invoked by uid 111); 8 Sep 2018 21:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 08 Sep 2018 17:14:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Sep 2018 17:14:37 -0400
Date:   Sat, 8 Sep 2018 17:14:37 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        stas@stason.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: git silently ignores include directive with single quotes
Message-ID: <20180908211436.GA31560@sigill.intra.peff.net>
References: <ca2b192e-1722-092e-2c54-d79d21a66ba2@stason.org>
 <CAN0heSroxfcwiJaVgGFTweq=XKAgGsR-E6SeOgsG4m0rzK4dHQ@mail.gmail.com>
 <87bm97rcih.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87bm97rcih.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 08, 2018 at 09:54:14PM +0200, Ævar Arnfjörð Bjarmason wrote:

> The reason missing includes are ignored is that the way this is expected
> to be used is e.g.:
> 
>     [include]
>         path ~/.gitconfig.work
> 
> Where .gitconfig.work is some configuration you're going to drop into
> place on your $dayjob servers, but not on your personal machine, even
> though you sync the same ~/.gitconfig everywhere.
> 
> A lot of people who use includes rely on this, but I see from this
> thread this should be better documented.

Right, this was an intentional choice at the time the feature was added,
to support this kind of feature. I'd note also that it mirrors other
misspelled keys. E.g.:

  [include]
  psth = whatever

will also not generate an error. This is also intentional, for two
reasons:

  1. Git's config format has always been designed to carry extra keys
     used by third-party scripts and porcelain. So we don't actually
     know the complete set of valid keys. (Though you could make an
     argument that git-core could stake out include.* as its own).

  2. It makes using multiple git versions easier in some ways (though
     also harder in others). A config key that isn't known to the
     current version will be quietly ignored.

Of course those things mean that true spelling mistakes are harder to
catch as such, because Git doesn't know that's what they are. And here
I'm talking config _keys_, not values. So I'm just explaining the
philosophical thinking that led to the "missing file is a silent noop".
It doesn't _have_ to behave the same.

That said, it _does_ behave the same and people are likely depending on
it at this point. So if we introduce a warning, for example, there needs
to be some way to suppress it.

Probably:

  [include]
  warnOnMissing = false
  path = ...

would be enough (with the default being "true").

You could even do:

  [include]
  warnOnMissing = false
  path = one
  warnOnMissing = true
  path = two

to treat two includes differently (though I'm not sure why you would
want to).

> If we were to make nonexisting files an error, we'd need something like
> an extension of the includeIf syntax added in 3efd0bedc6 ("config: add
> conditional include", 2017-03-01) 3efd0bedc6 ("config: add conditional
> include", 2017-03-01). I.e.:
> 
>     [includeIfcond "test -e ~/.gitconfig.work"]
>         path = ~/.gitconfig.work
> 
> Or something like that, this is getting increasingly harder to shove
> into the *.ini config syntax.

I think it would be simpler to just introduce a new key that's a variant
of "path". Like:

  [include]
  maybePath = ~/.gitconfig.work

Though if it really is just a warning, the "warnOnMissing" above would
make that unnecessary (and it also scales better if we have to end up
adding more behavior tweaks in the future).

-Peff
