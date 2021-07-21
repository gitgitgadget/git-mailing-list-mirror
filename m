Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EC8FC6377C
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2257C611CE
	for <git@archiver.kernel.org>; Wed, 21 Jul 2021 10:04:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbhGUJXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jul 2021 05:23:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:52930 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238351AbhGUJNF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jul 2021 05:13:05 -0400
Received: (qmail 1770 invoked by uid 109); 21 Jul 2021 09:53:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jul 2021 09:53:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2724 invoked by uid 111); 21 Jul 2021 09:53:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jul 2021 05:53:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 21 Jul 2021 05:53:39 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v2 02/24] pack-bitmap-write.c: gracefully fail to write
 non-closed bitmaps
Message-ID: <YPfuo1GY2WSqHn8j@coredump.intra.peff.net>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <3e637d9ec83435540ad32b8325b0dce87f61bae0.1624314293.git.me@ttaylorr.com>
 <87eecqzvld.fsf@evledraar.gmail.com>
 <YO8fpVZhoCiEiurR@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO8fpVZhoCiEiurR@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 01:32:21PM -0400, Taylor Blau wrote:

> > So if we're already paying for that extra space (which, on some
> > platforms would already be a 64 bit int, and on some so would the
> > uint32_t, it's just "at least 32 bits").
> >
> > Wouldn't it be more idiomatic to just have find_object_pos() return
> > int64_t now, if it's -1 it's an error, otherwise the "pos" is cast to
> > uint32_t:
> 
> I'm not sure. It does save the extra argument, which is arguably more
> convenient for callers, but the cost for doing so is a cast from a
> signed integer type to an unsigned one (and a narrower destination type,
> at that).
> 
> That seems easier to get wrong to me than passing a pointer to a pure
> "int" and keeping the return type a uint32_t. So, I'm probably more
> content to leave it as-is rather than change it.

I agree that the separate "found" value makes things more obvious.
Casting to a smaller size means explaining why that is OK, whereas it is
quite clear that things are correct with two separate variables. And
having an int64_t makes one wonder whether a value like 2^35 is possible
(it isn't; this is a uint32_t because that is the limit of objects in
the pack format).

-Peff
