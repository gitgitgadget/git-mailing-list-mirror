Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B803FC433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 05:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D90461A4A
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 05:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhCZFOL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 01:14:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:49504 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229458AbhCZFNv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 01:13:51 -0400
Received: (qmail 28561 invoked by uid 109); 26 Mar 2021 05:13:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 05:13:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7865 invoked by uid 111); 26 Mar 2021 05:13:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 01:13:52 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 01:13:49 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos@gmail.com>, git <git@vger.kernel.org>,
        =?utf-8?B?zqPPhM6xz43Pgc6/z4Igzp3PhM6tzr3PhM6/z4I=?= 
        <stdedos+git@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 1/1] pathspec: warn for a no-glob entry that contains
 `**`
Message-ID: <YF1tjaATILcSNuMa@coredump.intra.peff.net>
References: <xmqqft1iquka.fsf@gitster.g>
 <20210325233648.31162-2-stdedos+git@gmail.com>
 <xmqq35wiu4om.fsf@gitster.g>
 <CAPig+cT3xprHLxDkvfgHpHY7t5_5_A2xyGKB5S2KiqW=3Lk-TQ@mail.gmail.com>
 <xmqqtuoysjlk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuoysjlk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 25, 2021 at 08:02:31PM -0700, Junio C Hamano wrote:

> Eric Sunshine <sunshine@sunshineco.com> writes:
> 
> > I haven't been following the discussion, but is there a reason we need
> > to penalize the user with a warning rather than helping, for instance
> > by inferring ":(glob)" in the presence of `/**/` if not otherwise
> > countermanded by ":(literal)" or whatnot?
> 
> Two reasons I can think of offhand are
> 
>  - How /**/ is interpreted is not the only thing that is different
>    between the normal mode and the glob magic mode.  IIRC, an
>    asterisk * or a question mark ? matches slash in normal mode (it
>    started out as fnmatch() without FNM_PATHNAME).  Should we warn
>    about ":(glob)" if somebody asks for "foo*", "*foo", or
>    "foo*bar".  If not, why shouldn't?
> 
>  - Thers is no explicit magic that says "there is no magic" to
>    countermand such a DWIM.

I do wonder if this distinction creates more harm than good.

As somebody who has never used ":(glob)" myself, I was confused about
what it even does (and it was not easy to find the documentation; I
ended up finding the original commit in the history first!).

We have three modes:

  - no globbing

  - globbing with fnmatch(), with FNM_PATHNAME according to the docs

  - globbing with wildmatch

You may notice that I would call both of those latter two "globbing",
but only one of them is triggered by the ":(glob)" magic. :)

This just seems really confusing, and I wonder if anybody would be that
sad if we just used wildmatch everywhere. The original bd30c2e484
(pathspec: support :(glob) syntax, 2013-07-14) even says:

  The old fnmatch behavior is considered deprecated and discouraged to
  use.

but I guess it would be backwards-incompatible.

Maybe it would be less confusing if we named the three states
explicitly:

  :(literal)
  :(fnmatch)
  :(wildmatch)

(and keeping :(glob) as a synonym for compatibility).

-Peff
