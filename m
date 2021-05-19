Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D1C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 872E661244
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242122AbhESOWr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 10:22:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:59082 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234654AbhESOWq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 10:22:46 -0400
Received: (qmail 23335 invoked by uid 109); 19 May 2021 14:21:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 19 May 2021 14:21:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20391 invoked by uid 111); 19 May 2021 14:21:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 19 May 2021 10:21:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 19 May 2021 10:21:25 -0400
From:   Jeff King <peff@peff.net>
To:     Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] rev-parse: fix segfault with missing
 --path-format argument
Message-ID: <YKUe5WD3ci3J4roO@coredump.intra.peff.net>
References: <20210516120449.661636-1-wolf@oriole.systems>
 <20210517080243.10191-1-wolf@oriole.systems>
 <20210517080243.10191-2-wolf@oriole.systems>
 <YKImcgntKHryLLfv@coredump.intra.peff.net>
 <20210519095235.cydjlj2qoko6xm4v@nabokov.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210519095235.cydjlj2qoko6xm4v@nabokov.fritz.box>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 11:52:35AM +0200, Wolfgang Müller wrote:

> On 2021-05-17 04:16, Jeff King wrote:
> 
> > I don't have a strong preference for one or the other. It is maybe
> > helpful to diagnose "--path-format" without an equals as an error, as
> > your patch would, rather than quietly passing it along as an unknown
> > (as the hunk above would). I dunno. That perhaps applies to the rest
> > of the options, too. :)
> 
> I have a very slight preference for throwing an error: that is what I
> expected to happen as a user. At the same time, passing it along as an
> unknown seems more consistent with the other options that take equals.
> I'm split on this, and would defer to what people here prefer.

Yeah, I don't feel strongly at all. I like consistency, but noticing
bogus input is good, too. ;)

> Short of fully migrating to the parse-options API, I do not see a
> perfect solution for this, especially since there are options that take
> optional arguments which are not delimited by equals. These seem to be
> sprinkled throughout and all error out if no argument is given.

Ultimately I think using the parse-options API would be nice. In the
meantime, I suspect (but didn't think too hard on it) that you could get
by with two helpers:

  - rename the current opt_with_value() to opt_with_optional_value()
    to make its assumptions clear.

  - add a new helper opt_with_required_value() that accepts either:

      --default <arg>
      --default=<arg>
      --disambiguate <arg>
      --disambiguate=<arg>
      etc...

     and complains when the "=" is missing, or there is no extra "<arg>"
     available.

The second helper is a little tricky to write, because it sometimes
needs to advance argv (and decrement argc) to account for the extra
consumed arg.

That's definitely something we can leave off for now, though.

> So it turns out that my hunch was not really correct. Maybe there's also
> a pattern that I am not seeing.

I don't find it hard to believe that there's no obvious pattern. :) I
would say that rev-parse is one of the messiest and most "organically
grown" parts of Git.

Thanks for digging, though. It is always nice to see contributors going
the extra mile to figure out how their solutions fit into the bigger
picture of the project.

-Peff
