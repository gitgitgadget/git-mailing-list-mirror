Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E928C38159
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 02:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbjASCGo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 21:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjASCGn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 21:06:43 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2638A59D4
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 18:06:42 -0800 (PST)
Received: (qmail 5635 invoked by uid 109); 19 Jan 2023 02:06:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 19 Jan 2023 02:06:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28027 invoked by uid 111); 19 Jan 2023 02:06:44 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Jan 2023 21:06:44 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 18 Jan 2023 21:06:40 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 4/6] t: use hash-object --literally when created
 malformed objects
Message-ID: <Y8ilsLkR7R2uu542@coredump.intra.peff.net>
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8hZlN9rRg1msc0L@coredump.intra.peff.net>
 <Y8hiWGOArYqzen58@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y8hiWGOArYqzen58@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 18, 2023 at 04:19:20PM -0500, Taylor Blau wrote:

> > This patch is worth looking at because it shows the kinds of things the
> > new hash-object from patch 6 will reject.
> 
> Obviously we could avoid this patch entirely by making the new behavior
> of fscking the incoming objects hidden behind a `--fsck` flag or
> something. But I think the decision not to is a good one.
> 
> We already have `--literally`, and it makes sense that passing that
> should let us write anything, and that not passing it should perform
> some validity checks. But I think exactly *what* those checks are is
> ambiguous enough that the absence of `--literally` implying fsck checks
> isn't out of the question.
> 
> You address this in the last patch more thoroughly, but I figure that it
> is worth stating some of this here during review to indicate that I
> think the direction you pursued here is a good one.

Thanks for raising this, I think it's a good thing to consider. I didn't
even really think about making it a new option, since we already do
quality checks (and loosen them via --literally). This just seemed like
more of the same.

So yeah, if there were people who really wanted to distinguish between
the severity of the old checks and the new ones, we can add --fsck (or
even default to having it on, and disable it with --no-fsck to get the
old checks). But I just see little point in that.

One thing we _could_ support that my patch doesn't (I think; I didn't
test very deeply here) is respecting individual fsck.msgType config
variables. Again, I don't really see much point there. If you know you
are producing garbage, then just say --literally. The type-specific ones
are useful when you have to hold your nose and accept somebody else's
historical garbage, and you want to limit the damage as much as
possible.

-Peff
