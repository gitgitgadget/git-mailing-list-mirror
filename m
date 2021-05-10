Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F2EC433B4
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:24:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA92E613DF
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:24:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231153AbhEJWZ0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 18:25:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:49808 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229996AbhEJWZX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 18:25:23 -0400
Received: (qmail 20123 invoked by uid 109); 10 May 2021 22:24:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 10 May 2021 22:24:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16257 invoked by uid 111); 10 May 2021 22:24:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 10 May 2021 18:24:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 10 May 2021 18:24:16 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
Message-ID: <YJmykGWaWi03+WoW@coredump.intra.peff.net>
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net>
 <YJW81zNr5bgW+yVs@coredump.intra.peff.net>
 <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpN_ieGc2HJCvSsmUuEqS-GGPDcZHz=v2Z3hJY=Or_HMw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 09, 2021 at 10:20:37AM +0200, Martin Ågren wrote:

> > But I wouldn't be at all sad to just standardize on asciidoctor. I think
> > we're at parity in terms of the output (thanks to lots of work from you
> > and Martin over the past couple of years), and I've generally found it
> > nicer to work with.
> 
> I tend to think asciidoctor even renders our manpages *better* than
> asciidoc does. Not by a huge margin, but a few things here and there.

Yeah, I'd agree with that.

> Some time around the Python 2 EOL, I was about to propose flipping the
> default, but then I went to look up the asciidoc EOL schedule, and like
> you, I noticed that it was a lot more alive and kicking than I thought
> it was. So it's not so much "we should flip to avoid a bitrotting
> dependency" as it is "asciidoctor is arguably nicer" or "it's the way
> forward".

I'm OK with those arguments, too. :)

> > The only downside is that it may be available in fewer places (though
> > I'd think that python vs ruby is not so different). IMHO it's OK to be
> > aggressive about the doc toolchain requirements, because the fallback is
> > always grabbing the preformatted roff or HTML pages that were generated
> > on a different system.
> 
> In general, I agree. I do think it's important that "most people
> contributing to Git", whatever that means, can build the documentation
> to check the part they're adding/modifying and not find it broken left
> and right. They would then (quite rightly) not even bother building it.

Agreed. But I think that is mostly the case (asciidoctor seems no harder
to acquire on most modern systems than asciidoc; there are system
packages in most cases, and decent binary-package systems for both ruby
and python if you really need it).

It does create a situation where people like Randall on NonStop might
need to do part of their dev work on another, more mainstream platform.
But I suspect that is already the case.

> When we looked at xmlto-less rendering around two years ago [1], we
> found various asciidoctor bugs up to and around version 2.0. We would
> likely need to require some >=2.0.x. The exact requirements will
> probably only become clear when someone really does the work.

That does make things a little less convenient; Debian stable, for
instance, still has 1.5.8. It's not too hard to install an updated gem,
but not quite as nice as using the system package (it also makes things
weird for building the stable Debian package itself, which would want to
rely only on other packages; but of course any proposed change to the
doc toolchain would be for new versions, and would not get backported
there anyway).

> I think what I'm arguing for is
> 
>   1) switch the default to asciidoctor,
>   2) enable optionally using it without xmlto,
>   3) figure out what broke and fix it, and document which is the minimum
>      asciidoctor version we're going to bother with for (2),
>   4) lather, rinse, repeat (3),
>   5) switch the default to not using xmlto,
>   6) drop the xmlto way of generating the manpages(?).

I'm unclear when support for python asciidoc goes away here. Is it part
of step 6 (because it does not have another way of generating them)? Or
does it live on forever as a non-default legacy system? I'd prefer not,
but as long as we are clear about the primary target and leave it up to
people interested in the legacy to do the compat fixes, that might be
OK.

-Peff
