Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1610BC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F17BD206D7
	for <git@archiver.kernel.org>; Mon,  4 May 2020 15:43:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgEDPnp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 11:43:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:35878 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726509AbgEDPno (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 May 2020 11:43:44 -0400
Received: (qmail 31511 invoked by uid 109); 4 May 2020 15:43:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 04 May 2020 15:43:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17870 invoked by uid 111); 4 May 2020 15:43:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 May 2020 11:43:44 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 May 2020 11:43:43 -0400
From:   Jeff King <peff@peff.net>
To:     clime <clime7@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: :format:%s for date fields seems to be shifted by timezone
Message-ID: <20200504154343.GA12842@coredump.intra.peff.net>
References: <CAGqZTUu2U6FFXGTXihC64O0gB5Bz_Z3MbD750kMoJWMciAGH6w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGqZTUu2U6FFXGTXihC64O0gB5Bz_Z3MbD750kMoJWMciAGH6w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 03, 2020 at 12:15:14PM +0200, clime wrote:

> my current timezone is UTC+0200.
> 
> I create a test repo, add one commit and create a tag:
> 
> Now:
> 
> $  git for-each-ref --format="%(taggerdate:format:%s)" refs/tags
> 1588504146
> 
> $ date +"%s"
> 1588500585
> 
> $  git for-each-ref --format="%(taggerdate:raw)" refs/tags
> 1588500546 +0200
> 
> Somehow %(taggerdate:format:%s) gives a Unix timestamp which is one
> hour in future and it is different than what ` date +"%s"` gives
> around approximately the same time the tag was created.

It's caused by strftime() being clever with DST. Try this:

  git commit --date=@1559361600 --allow-empty -m summer
  git commit --date=@1577854800 --allow-empty -m winter
  git log --format=%ad --date=unix >unix
  git log --format=%ad --date=format:%s >strftime
  diff -u unix strftime

We get the winter time right, but the summer time wrong.

The issue is that strftime() takes a broken-down "struct tm", not a unix
time_t. We have all of the right values for hour/minute/etc there, so
using "format:%H:%M:%S" prints what you'd expect. But we never set the
"isdst" field, so when it tries to convert back to unix time, it applies
a one-hour offset (if it's "summer" in your local timezone).

Unfortunately I don't think we can solve this easily. If we were
operating completely in your local timezone, then we would have gotten
that "struct tm" from localtime(), and its isdst field would be set
properly. And indeed, if you use "--date=format-local:%s", the problem
goes away.

But when we're formatting in the original author's timezone, which is
the default, we have no idea if they were in dst then or not. We only
know their offset-to-gmt, so we munge the time_t ourselves and use
gmtime().

So there are a few reasons I think this is the best we can do:

 - the full timezone information literally isn't there in Git; we might
   know the author was in +0200, but we don't know if they were
   observing DST, or if they were simply in a timezone further east.

 - even if we had a zone, there's no system function to convert a time_t
   to a tm in an arbitrary timezone (hence the gmtime() hack above;
   we've tried playing games with $TZ and tzset(), but it's awkward and
   unportable)

 - likewise, strftime() is doing the reverse conversion using the local
   timezone anyway, which would be wrong.

So my advice is not to use "%s" (which isn't portable anyway). Use
"--date=unix" or "%(taggerdate:unix)".

-Peff
