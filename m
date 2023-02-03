Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8794C05027
	for <git@archiver.kernel.org>; Fri,  3 Feb 2023 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232149AbjBCRBn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Feb 2023 12:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjBCRBj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Feb 2023 12:01:39 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57012708
        for <git@vger.kernel.org>; Fri,  3 Feb 2023 09:01:38 -0800 (PST)
Received: (qmail 26400 invoked by uid 109); 3 Feb 2023 17:01:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 Feb 2023 17:01:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10186 invoked by uid 111); 3 Feb 2023 17:01:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 Feb 2023 12:01:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 3 Feb 2023 12:01:37 -0500
From:   Jeff King <peff@peff.net>
To:     demerphq <demerphq@gmail.com>
Cc:     "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
Subject: Re: grep: fix multibyte regex handling under macOS
 (1819ad327b7a1f19540a819813b70a0e8a7f798f)
Message-ID: <Y9098dyaTtiNk506@coredump.intra.peff.net>
References: <CALnO6CAZtwfGY4SYeOuKqdP9+e_0EYNf4F703DRQB7UUfd_bUg@mail.gmail.com>
 <CANgJU+X_e0owKC3uWPaA_gVP54syF1+MJ-cTn+fjPrNS5LDsMA@mail.gmail.com>
 <Y9rv29c0dYUAYx8B@coredump.intra.peff.net>
 <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANgJU+XNLqf0E2+YC8yxtRPVh=mevc3P0eeye2_nx=ULB2iVWw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 02, 2023 at 05:22:37PM +0100, demerphq wrote:

> I've been lurking watching some of the regex discussion on the list
> and personally I think it is asking for trouble to use "whatever regex
> engine is traditional in a given environment" instead of just choosing
> a good open source engine and using it consistently everywhere.  I
> don't really buy the arguments I have seen to justify a policy of "use
> the standard library version"; regex engines vary widely in
> performance and implementation and feature set, and even the really
> good ones do not entirely agree on every semantic[1], so if you don't
> standardize you will be forever dealing with bugs related to those
> differences.

I think this is a perennial question for portable software: is it better
to be consistent across platforms (by shipping our own regex engine), or
consistent with other programs on the same platform (by using the system
regex).

I don't have a strong opinion either way. The main concern I'd have is
handling dependencies. I like pcre a lot, but I'm not sure that I would
want building Git to require pcre on every platform. If there's an
engine we can ship as a vendored dependency that builds everywhere, that
helps. We have the engine imported from gawk in compat/regex. That
_probably_ builds everywhere (though we don't really know, because any
platform that doesn't set NO_REGEX has been happily using the system
routines). But it also may not be the best choice; avoiding its
multi-byte handling was the reason behind 1819ad327 in the first place.

> I think the git project should choose the feature set[2] it thinks are
> important, and then choose a regex engine that provides those features
> and is well supported, and then use it consistently everywhere that
> git needs to do regex based matching. Anything else is asking for
> trouble at some level or another.

IMHO the biggest issue here is that the built-in userdiff regexes are
doing something a bit questionable, which is embedding high-bit
characters directly into the regex. If we can avoid that, then having
consistency in multi-byte handling across platforms becomes a lot less
important.

-Peff
