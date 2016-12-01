Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EB541FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:51:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757655AbcLASvE (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:51:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:49979 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753680AbcLASvA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:51:00 -0500
Received: (qmail 8743 invoked by uid 109); 1 Dec 2016 18:50:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 18:50:59 +0000
Received: (qmail 1998 invoked by uid 111); 1 Dec 2016 18:51:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 13:51:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 13:50:57 -0500
Date:   Thu, 1 Dec 2016 13:50:57 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] difftool.c: mark a file-local symbol with static
Message-ID: <20161201185056.eso5rhec7izlbywa@sigill.intra.peff.net>
References: <alpine.DEB.2.20.1611301204020.117539@virtualbox>
 <29abc89b-9ca5-930f-8e90-ca446ac2b96a@ramsayjones.plus.com>
 <xmqqtwaod7ly.fsf@gitster.mtv.corp.google.com>
 <20161130212510.ihcmvig7jq44p3nx@sigill.intra.peff.net>
 <3e6a6685-19ec-4536-4a5f-3a56e30fb530@ramsayjones.plus.com>
 <20161130231848.v5ge6otytim2t6d2@sigill.intra.peff.net>
 <xmqqinr4bkf4.fsf@gitster.mtv.corp.google.com>
 <59da5383-16a0-b327-75a8-b4c4ad7bd479@ramsayjones.plus.com>
 <20161201040234.3rnuttitneweedn5@sigill.intra.peff.net>
 <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60n3bjel.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 10:20:50AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I don't have a preference on which direction we go, but yes, right now
> > we are in an awkward middle ground. We should do one of:
> >
> >   1. Drop -Wno-format-zero-length from DEVELOPER_CFLAGS and make sure
> >      future patches to do not violate it.
> >
> >   2. Declare warning("") as OK.
> >
> > I still think the warning is silly, but (1) has value in that it
> > produces the least surprise and annoyance to various people building
> > Git.
> 
> What is most awkward is that "make", with no customization out of
> box, suggests to use -Wall in CFLAGS and triggers the misguided
> warning, and DEVELOPER_CFLAGS, partly because it adds -Werror to
> turn warnings (including this misguided one) into errors, disables
> it with -Wno-format-zero-length.  As a result:
> 
>  - Casual builders that follow our suggestion get warnings.
> 
>  - Developers do not notice their new code may make the "casual
>    builder" experience worse.
> 
> That is totally backwards.  That is probably what you meant by "the
> least surprise and annoyance"?

Yes, exactly. :)

The surprise and annoyance for (1) is that people who get caught up by
the warning while writing new patches say "this warning is stupid, why
don't we disable it". But that is a much smaller number of people to be
annoyed.

> I also still think that any_printf_like_function("%s", "") looks
> silly.  I know that we've already started moving in that direction
> and we stopped at a place we do not want to be in, but perhaps it
> was a mistake to move in that direction in the first place.  I am
> tempted to say we should do something like the attached, but that
> may not fly well, as I suspect that -Wno-format-zero-length may be a
> lot more exotic than the -Wall compiler option.

Yeah, I think portability concerns are what caused us not to go down
that road in the first place. But I think it's also a mistake to put too
much into CFLAGS, because somebody who wants to override one flag has to
repeat the rest. So, e.g., right now I might do:

  make CFLAGS="-O3 -Wall"

to bump the optimization level. But if our codebase relies on
-Wno-format-zero-length being there, then I have to know to put it in
there, too.

You can work around that with an extra make variable, but that also
makes it harder to disable if your compiler doesn't like it.

> An obvious second
> best option would be to drop -Wall from the "everybody" CFLAGS and
> move it to DEVELOPER_CFLAGS instead.

Yeah, though that doesn't help the example above.

As ugly as warning("%s", "") is, I think it may be the thing that annoys
the smallest number of people.

-Peff
