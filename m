Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE0EC2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1320E20771
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 15:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1414828AbgDOPl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:41:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:54572 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1414823AbgDOPl6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 11:41:58 -0400
Received: (qmail 12663 invoked by uid 109); 15 Apr 2020 15:41:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Apr 2020 15:41:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4361 invoked by uid 111); 15 Apr 2020 15:52:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Apr 2020 11:52:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Apr 2020 11:41:57 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] date.c: allow compact version of ISO-8601 datetime
Message-ID: <20200415154157.GC2464307@coredump.intra.peff.net>
References: <20200414000324.GA2751707@camp.crustytoothpaste.net>
 <cover.1586856398.git.congdanhqx@gmail.com>
 <06e62c58d5accad7bbebbc51f9fb38fda83a73f6.1586856398.git.congdanhqx@gmail.com>
 <20200414202401.GC1879688@coredump.intra.peff.net>
 <xmqq5ze094gg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5ze094gg.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 15, 2020 at 08:03:11AM -0700, Junio C Hamano wrote:

> > I worry a little this may conflict with other approxidate heuristics.
> >
> > The only one I can think of is an actual unix timestamp, though, and we
> > already require that to have at least 9 digits (plus anybody wanting to
> > use one robustly really should be using @12345678).
> 
> I am OK with 1/2, but I'd worry a LOT about this one, if we didn't
> require 9 digits.  60/100 * 60/100 * 24/100 ~= 8.6% so limiting the
> hour/min/sec to sensible values is not a useful protection against
> ambiguity.  We'd essentially be declaring that a raw UNIX timestamp
> without @ prefix is now hit-and-miss if we take this change, were
> there not the "must be at least 9 digits" requirement.

Yeah, that was exactly why I poked at it.

Curiously, a1a5a6347b (Accept dates before 2000/01/01 when specified as
seconds since the epoch, 2007-06-06), the commit which introduced the
9-digit rule, specifically says:

  There is now still a limit, 100000000, which is 1973/03/03 09:46:40
  UTC, in order to allow that dates are represented as 8 digits.

but running "test-date 20100403" even back at that commit does not seem
to work (nor does it work now).

Doubly curious, some nearby code blames to 9f2b6d2936 (date/time: do not
get confused by fractional seconds, 2008-08-16). So why don't fractional
seconds work right now?

They sure don't seem to:

  [the 17 becomes a day-of-month]
  $ t/helper/test-tool date approxidate 12:43:50.17
  12:43:50.17 -> 2020-04-17 16:43:50 +0000

But I wonder if the new patch breaks the example from that commit
message, which does work now:

  [current version; the 17 attaches to "days ago"]
  $ t/helper/test-tool date approxidate 12:43:50.17.days.ago
  12:43:50.17.days.ago -> 2020-03-29 16:43:50 +0000

It looks like the answer is yes:

  [with patch 1/2 applied; now it's a fractional second]
  $ t/helper/test-tool date approxidate 12:43:50.17.days.ago
  12:43:50.17.days.ago -> 2020-04-15 16:43:50 +0000

TBH I'm not sure how big a deal it is. The input is rather ambiguous for
a strict left-to-right parser, and I'm not sure this case is worth doing
more look-ahead parsing. But it's worth making a conscious decision
about it.

One alternative would be to restrict the fractional second handling only
to the parse_date_basic(), which is quite a bit stricter. It shares
match_digit() with approxidate(), so we'd probably have to pass in an
extra flag to match_digit() to change the rules. It also means that:

  2020-04-14T12:43:50.17

would parse a fractional second, but:

  yesterday at 12:43:50.17

wouldn't.

> > We could probably tighten the heuristics a bit by insisting that the
> > month and day be sensible. Or even year (see the 1900 to 2100 magic for
> > the 4-digit year guess).
> 
> I do agree that we'd want 0 <= hr <= 24, 0 <= min <= 59, and 0 <=
> sec <= 60 (or should this be 61?), but it is for correctness of the
> new code.  It wouldn't have any value in disambiguation from other
> formats, I would think.  So, from that point of view, I would buy
> something like 1969 as a lower bound, but I am not sure if we
> necessarily want an upper bound for the year.  What mistake are we
> protecting us against?

No particular mistake. I was just suggesting to keep the heuristics in
the new code as tight as possible to leave room for later changes (since
approxidate by its nature is heuristics and hacks piled atop each
other).

I do agree that year bounds are a questionable restriction. Right now
Git's date code can only handle dates between 1970 and 2099, but it
would be nice to change that.

-Peff
