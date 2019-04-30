Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F2B51F453
	for <e@80x24.org>; Tue, 30 Apr 2019 21:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbfD3VOR (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Apr 2019 17:14:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:45054 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726015AbfD3VOR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Apr 2019 17:14:17 -0400
Received: (qmail 27317 invoked by uid 109); 30 Apr 2019 21:14:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Apr 2019 21:14:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12623 invoked by uid 111); 30 Apr 2019 21:14:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Apr 2019 17:14:51 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Apr 2019 17:14:15 -0400
Date:   Tue, 30 Apr 2019 17:14:15 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Barret Rhoden <brho@google.com>, Olaf Hering <olaf@aepfle.de>
Subject: Re: How to undo previously set configuration? (again)
Message-ID: <20190430211415.GB16290@sigill.intra.peff.net>
References: <20190424004948.728326-1-sandals@crustytoothpaste.net>
 <20190424023438.GE98980@google.com>
 <20190424230744.GL6316@genre.crustytoothpaste.net>
 <87k1fis8gq.fsf@evledraar.gmail.com>
 <20190425143614.GA91608@google.com>
 <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8B5j2K=RU7N+h-i9HszuYuYd+fNmAftVDW-4nJ_o5z8Sw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 26, 2019 at 04:36:40PM +0700, Duy Nguyen wrote:

> > I'm confused.  Isn't that bog-standard Git usage, not a custom hack?
> > That is, I thought the intended behavior is always
> >
> >  1. For single-valued options, last value wins.
> >  2. For multi-valued options, empty clears the list.
> 
> I didn't know this! Should it be documented? At least a quick skimming
> through config.txt does not mention anything about empty value
> clearing multi-valued options.
> 
> I also wanted to see if it's true. However, the first var I checked,
> branch.*.merge does not follow this rule. I got disappointed and
> stopped.

It's definitely not implemented universally; each consumer of the config
option must decide on it (and it will probably always be that way to
some degree, since we don't know the semantics of each options; recall
that we may be holding config keys for other non-core programs, too).
And we just haven't retro-fitted a lot of those older options because
nobody has been bothered by it.

That said, I am a proponent of having some kind of clearing mechanism
(and I was the one who added credential.helper's mechanism, which has
been mentioned in this thread).  I think it makes things a lot less
difficult if we don't have to change the syntax of the config files to
do it. With that constraint, that pretty much leaves:

  1. Some sentinel value like the empty string. That one _probably_
     works in most cases, but there may be lists which want to represent
     the empty value. There could be other sentinel values (e.g.,
     "CLEAR") which are simply unlikely to be used as real values.

  2. The boolean syntax (i.e., "[foo]bar" with no equals) is almost
     always bogus for a list. So that can work as a sentinel that is
     OK syntactically.

> > Which of course leaves room for improvement in documentation and how
> > we organize the implementation (as Peff discussed in [1]), but isn't
> > it nice to already have something in place that doesn't require
> > inventing a new syntax?
> 
> This cannot undefine a variable though, especially those single-valued
> ones. But I think for most cases, the user just needs to find out what
> is the default value and set to that one.

Having "default" is a little more convenient, but it would need to be
implemented on a per-value basis anyway. In many cases the caller of the
config code has implemented last-one-wins by overwriting an old value,
and only it knows how to restore "default".

I guess if we moved completely to a configset world, then asking for
git_config_get_string() could resolve "default" completely. But we are a
ways from that.

-Peff
