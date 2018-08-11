Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6A7E1F404
	for <e@80x24.org>; Sat, 11 Aug 2018 20:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbeHKW4G (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 18:56:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:51304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727379AbeHKW4G (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 18:56:06 -0400
Received: (qmail 2760 invoked by uid 109); 11 Aug 2018 17:34:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 Aug 2018 17:34:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28730 invoked by uid 111); 11 Aug 2018 17:34:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 Aug 2018 13:34:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 Aug 2018 13:34:06 -0400
Date:   Sat, 11 Aug 2018 13:34:06 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>, danshu@microsoft.com,
        marc@marc-stevens.nl
Subject: Re: [PATCH 0/9] Add missing includes and forward declares
Message-ID: <20180811173406.GA9119@sigill.intra.peff.net>
References: <20180811043218.31456-1-newren@gmail.com>
 <87mutts3sz.fsf@evledraar.gmail.com>
 <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEADR15gOrH+GBQxKLZR2fCQwhaPWgf3VS--Z0bTNP0rA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 11, 2018 at 01:59:50AM -0700, Elijah Newren wrote:

> The part of my story you snipped in the ellipsis is kind of important,
> though: "...and decided to determine which header files were missing
> their own necessary #include's and forward declarations."  The way I
> did so was making a simple one-line .c file that included exactly one
> header, and checked to see if I could compile it (without any special
> defines), fixed it up as necessary, then repeated that process for
> every toplevel header.

The rule in Git has always been that your very first include must
always be "git-compat-util.h" or an equivalent header that includes it
first (like "cache.h"). This is mentioned in CodingGuidelines.

So I think the better test is a two-line .c file with:

  #include "git-compat-util.h"
  #include $header_to_check

And I'd be fine with fixing any compilation failures there, either with
forward declarations or recursive includes. I think the in the early
days there was some resistance to having a lot of recursive includes,
because it _can_ lead to confusion, but IMHO it mostly helps people. And
I don't recall much discussion on it in recent years.

Including "git-compat-util.h" in many more headers probably doesn't hurt
(after all, it's a noop for every .c file which is following the
existing rule). But I'd just as soon not sprinkle it everywhere, nor
imply that that people don't need to be including it. It's really
important that it comes first because it wants a clean slate and have
subtle effects on other header files due to macros. Worse still, some of
the effects are platform dependent, so we might not realize an ordering
problem until somebody on AIX complains.

I wonder if there's an easy way to check. I guess adding '-Dint=foo' to
the command line, and then putting '#undef int' at the top of
git-compat-util would catch just about any code the compiler sees that
doesn't have git-compat-util included. :)

-Peff
