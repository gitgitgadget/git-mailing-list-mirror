Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0007FC433B4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5889613D4
	for <git@archiver.kernel.org>; Tue,  4 May 2021 21:38:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbhEDVjL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 May 2021 17:39:11 -0400
Received: from cloud.peff.net ([104.130.231.41]:44702 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232803AbhEDVjL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 May 2021 17:39:11 -0400
Received: (qmail 13704 invoked by uid 109); 4 May 2021 21:38:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 May 2021 21:38:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2420 invoked by uid 111); 4 May 2021 21:38:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 May 2021 17:38:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 4 May 2021 17:38:14 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org,
        Yiyuan guo <yguoaz@gmail.com>
Subject: Re: [PATCH 3/5] pack-objects: clamp negative window size to 0
Message-ID: <YJG+xp2b1rUzBaws@coredump.intra.peff.net>
References: <YI1fbERSuS7Y3LKh@coredump.intra.peff.net>
 <YI1fubjvQQlrPz9D@coredump.intra.peff.net>
 <3d77d70b-2cc5-4ca9-8753-fa9af5111842@gmail.com>
 <YJAOzTIXkO2lhxSs@coredump.intra.peff.net>
 <02a66bfb-aac0-c05e-dab3-366bc312d900@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <02a66bfb-aac0-c05e-dab3-366bc312d900@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 04, 2021 at 08:47:56PM +0200, René Scharfe wrote:

> >> This seems like a reasonable approach. It takes existing "undefined"
> >> behavior and turns it into well-understood, "defined" behavior.
> >
> > I was on the fence on doing that, or just:
> >
> >   if (window < 0)
> > 	die("sorry dude, negative windows are nonsense");
> >
> > So if anybody has a strong preference, I could be easily persuaded. Part
> > of what led me to being forgiving was that we similarly clamp too-large
> > depth values (with a warning; I didn't think it was really necessary
> > here, though).
> 
> There's another option: Mapping -1 or all negative values to the
> maximum:
> 
> 	if (window < 0)
> 		window = INT_MAX;
> 	if (depth < 0)
> 		depth = (1 << OE_DEPTH_BITS) - 1;
> 
> That's allows saying "gimme all you got" without knowing or being
> willing to type out the exact maximum value, which may change between
> versions.  Not all that useful for --window, I guess.  That convention
> has been used elsewhere I'm sure, but can't point out a concrete
> example.  $arr[-1] get the last item of the array $arr in PowerShell,
> though, which is kind of similar.
> 
> Sure, you get the same effect in both cases by typing 2147483647, but
> -1 is more convenient.
> 
> Not a strong preference, but I thought it was at least worth
> mentioning that particular bike shed color. :)

Thanks for thinking about this. In general, yeah, allowing "-1" as
"unlimited" is a sensible thing for many options. But for these two
variables, I don't think "unlimited" is ever a good idea:

  - for --window, it makes the amount of work quadratic in the number of
    objects in the repository (and likewise, memory usage equivalent to
    the uncompressed contents of the repo). Going beyond about 250 or so
    gives diminishing returns.

  - for --depth, going beyond about 50 provides diminishing space
    returns, and makes the run-time performance of accessing the deltas
    horrible.

So certainly INT_MAX or the max allowable by OE_DEPTH_BITS is a very bad
idea in both cases, and the use would probably be happier if we just hit
a die() instead. :) We _could_ make "-1" mean "the maximum sensible
valuable", but I think there's a lot of wiggle room for "sensible"
there. I much prefer using and advertising the actual values there (as
we do for "gc --aggressive").

-Peff
