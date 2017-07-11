Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F8F0202AC
	for <e@80x24.org>; Tue, 11 Jul 2017 14:08:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932601AbdGKOIE (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 10:08:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:37068 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755627AbdGKOID (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 10:08:03 -0400
Received: (qmail 11041 invoked by uid 109); 11 Jul 2017 14:08:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 14:08:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16957 invoked by uid 111); 11 Jul 2017 14:08:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 10:08:15 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 10:08:01 -0400
Date:   Tue, 11 Jul 2017 10:08:01 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH 0/7] tag: more fine-grained pager-configuration
Message-ID: <20170711140801.ocbr44wktjjj44dq@sigill.intra.peff.net>
References: <cover.1499723297.git.martin.agren@gmail.com>
 <20170711101942.h2uwxtgzvgguzivu@sigill.intra.peff.net>
 <CAN0heSqN6SJ_dppbYEDYVs+pSzVdLvLUDL4_VSNn79ro6c_8=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSqN6SJ_dppbYEDYVs+pSzVdLvLUDL4_VSNn79ro6c_8=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 03:50:39PM +0200, Martin Ågren wrote:

> > Would it makes sense to just have git-tag respect pager.tag in listing
> > mode, and otherwise ignore it completely?
> 
> Yes. I doubt anyone would notice, and no-one should mind with the
> change (famous last words).
> 
> It does mean there's a precedence for individual commands to get to
> choose when to honor pager.foo. If more such exceptions are added, at
> some point, some command will learn to ignore pager.foo in some
> particular situation and someone will consider it a regression.

Yes, perhaps. One could even argue that "git tag foo" is OK to page and
somebody would consider it a regression not to respect pager.tag. It
seems useless to me, but at least it's not totally broken like "git tag
-a foo" is.

But I find it pretty unlikely, as it doesn't produce copious output. I'd
worry more about eventually finding a command with two copious-output
modes, and somebody wants to distinguish between them. If we can't come
up with a plausible example now, I'm inclined to deal with it if and
when it ever comes up. Right now I just don't want to paint ourselves
into a corner, and I think we can always add more config later (e.g.,
tag.pageFooCommand=true or something; that's not great, but I'm mostly
betting that it will never come up).

> Well, I respect your hunch about .enable and .command and I certainly
> don't want to take things in a direction that makes that approach less
> clean. You have convinced me that I will instead try to teach git tag
> to be more clever about when to use the pager, at least to see what
> that looks like.

Thanks. I was the original proponent of "pager.tag.list", and only after
reading your series today did I think "gee, this seems unnecessarily
complex". So it's entirely possible I'm missing a corner case that you
may uncover through discussion or experimenting.

> Let's call such a "git tag" the "future git tag". Just to convince
> myself I've thought through the implications -- how would
> pager.tag.enable=true affect that future git tag? Would it be fair to
> say that enable=false means "definitely don't start the pager (unless
> --paginate)" and that enable=true means "feel free to use it (unless
> --no-paginate)"? The future git tag would default to using
> enable=true. Would --paginate also be "feel free to use it", or rather
> "the pager must be used"?

I think the rules would be:

  1. If --paginate is given, do that. Likewise for --no-pager.

  2. Otherwise, respect tag.pager.enable if it is set.

  3. Otherwise, use the built-in default.

  4. Any time the pager is run, respect tag.pager.command if it is set.

And then there are two optional bits:

  2a. If tag.pager is set to a boolean, behave as if tag.pager.enable is
      set to the same boolean. If it's set to a string, behave as if
      tag.pager.enable is set to "true", and tag.pager.command is set to
      the string. That should give us backwards compatibility.

  2b. If tag.pager.command is set but tag.pager.enable isn't, possibly we
      should assume that tag.pager.enable is set to "true". That makes
      the common case of "page and use this command" a single config
      block instead of two. It matters less for "tag" where paging would
      be the default.

So I think that what you asked above, but to be clear on the final
question: --paginate should always be "must be used". And that meshes
nicely with implementing it via the git.c wrapper, where it takes
precedence way before we ever hit the setup_auto_pager() call.

-Peff
