Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35833C433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3C7060F9C
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 12:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhIDMvF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Sep 2021 08:51:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:39328 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229957AbhIDMvE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Sep 2021 08:51:04 -0400
Received: (qmail 32498 invoked by uid 109); 4 Sep 2021 12:50:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 04 Sep 2021 12:50:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11448 invoked by uid 111); 4 Sep 2021 12:50:02 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 04 Sep 2021 08:50:02 -0400
Authentication-Results: peff.net; auth=none
Date:   Sat, 4 Sep 2021 08:50:02 -0400
From:   Jeff King <peff@peff.net>
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <ttaylorr@github.com>, git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom verma <hariom18599@gmail.com>
Subject: Re: Git in Outreachy?
Message-ID: <YTNrehKnfPo3E5RI@coredump.intra.peff.net>
References: <YTGLLQCvlnT17jo8@nand.local>
 <CAP8UFD2SNyCj6Weo4EeHt0Z-CW9CEJbQbzmU7jhwfJdNW9CrYQ@mail.gmail.com>
 <CAOLTT8QufEU5Q64JfQyEOs4FYCsrNX2jgj8PdmYziVtKnRyu4w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOLTT8QufEU5Q64JfQyEOs4FYCsrNX2jgj8PdmYziVtKnRyu4w@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 04, 2021 at 03:40:41PM +0800, ZheNing Hu wrote:

> This may be a place to promote my patches: See [1][2][3].
> It can provide some extra atoms for git cat-file --batch | --batch-check,
> like %(tree), %(author), %(tagger) etc. Although some performance
> optimizations have been made, It still has small performance gap.
> 
> If the community still expects git cat-file --batch to reuse the logic
> of ref-filter,
> I expect it to get the attention of reviewers.
> 
> The solutions I can think of to further optimize performance are:
> 1. Delay the evaluation of some ref-filter intermediate data.
> 2. Let ref-filter code reentrant and can be called in multi-threaded  to take
> advantage of multi-core.

I don't think trying to thread it will help much. For expensive formats,
where we have to actually open and parse objects, in theory we could do
that in parallel. But most of our time there is spent in zlib getting
the object data, and that all needs to be done under a big lock.

For little formats (e.g., just printing "%(refname)"), we need to
serialize the output anyway. So our unit of work is so tiny, I suspect
that the threading overhead would be a net negative.

I was coincidentally looking at ref-filter last week, and it seemed to
me that a lot of the slowness is because of the over-use of malloc
(e.g., we allocate a substring for every atom_value, and then form them
into a separate buffer). If we could parse the original format into a
form that could be traversed without having to do further allocations,
just writing directly to a strbuf (or even a file handle), I think that
would be a big improvement.

I just posted the results of some of my experiments to the list:

  https://lore.kernel.org/git/YTNpQ7Od1U%2F5i0R7@coredump.intra.peff.net/

I don't think that gives any kind of useful base to build on, but it
shows what's possible by skipping past various segments of the
ref-filter code.

-Peff
