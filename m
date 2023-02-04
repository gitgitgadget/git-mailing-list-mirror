Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BBAC61DA4
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 11:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232230AbjBDLO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 06:14:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjBDLO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 06:14:57 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C94C2E0E7
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 03:14:56 -0800 (PST)
Received: (qmail 3473 invoked by uid 109); 4 Feb 2023 11:14:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Feb 2023 11:14:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18069 invoked by uid 111); 4 Feb 2023 11:14:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Feb 2023 06:14:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Feb 2023 06:14:55 -0500
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v3] delta-islands: free island_marks and bitmaps
Message-ID: <Y94+L/mhBnnbi+0k@coredump.intra.peff.net>
References: <20230202010353.23391-1-e@80x24.org>
 <230202.86mt5wq1i7.gmgdl@evledraar.gmail.com>
 <20230202094217.M955476@dcvr>
 <Y91OZHrMfca6tb/2@coredump.intra.peff.net>
 <20230203234430.M553381@dcvr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230203234430.M553381@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 03, 2023 at 11:44:30PM +0000, Eric Wong wrote:

> >  	/* If we aren't using islands, assume everything goes together. */
> > -	if (!island_marks)
> > +	if (!using_island_marks)
> >  		return 1;
> 
> I much prefer to rely on invalid pointers than extra flags since
> having multiple sources of truth confuses me[1].

That's kind of my point, though. It's not multiple sources of truth, but
rather there are two bits "did we ask to use islands" and "is
island_marks still valid". You are shoving both bits into the same
variable by using a special sentinel pointer.

> > And of course that would also be a tiny step in the right direction if
> > the delta islands API learned to use a struct (this would be the same
> > spot where we'd say "we're done with islands; free the struct").
> 
> I do wonder about performance on register-starved systems,
> though, especially if stuff like island_delta_cmp gets called
> frequently.  I already have enough performance problems atm :<

Calling in_same_island() is pretty heavy-weight (it's multiple hash
lookups, and then an arbitrary-length bit-string comparison). I'd be
shocked if replacing a global with a struct pointer is even measurable.

> [1] to go farther, I might even eliminate `int use_delta_islands' as
>     a global from builtin/pack-objects.c and just have that become a
>     `struct delta_islands_foo *' or something.  But I have more
>     pressing performance problems to figure out :<

Right, that's along the same lines I was thinking. But I don't blame
you for not tackling it. The upside is fairly minimal.

> +	/* detect use-after-free with a an address which is never valid: */
> +	island_marks = (void *)-1;

I still hate how magical this line is, but I don't that it's worth
arguing about more.

-Peff
