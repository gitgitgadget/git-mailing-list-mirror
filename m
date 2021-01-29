Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0857C433E0
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:54:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8216E64DE9
	for <git@archiver.kernel.org>; Fri, 29 Jan 2021 00:54:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbhA2AyS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 19:54:18 -0500
Received: from cloud.peff.net ([104.130.231.41]:42758 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229757AbhA2AyR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 19:54:17 -0500
Received: (qmail 20649 invoked by uid 109); 29 Jan 2021 00:53:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 Jan 2021 00:53:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4425 invoked by uid 111); 29 Jan 2021 00:53:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 19:53:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 19:53:34 -0500
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v3 09/10] pack-revindex: ensure that on-disk reverse
 indexes are given precedence
Message-ID: <YBNcjmn5Jm/EmHwS@coredump.intra.peff.net>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1611617819.git.me@ttaylorr.com>
 <a66d2f9f7c20eeb813656e66b3ad9d42f2eecf34.1611617820.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a66d2f9f7c20eeb813656e66b3ad9d42f2eecf34.1611617820.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 06:37:46PM -0500, Taylor Blau wrote:

> When an on-disk reverse index exists, there is no need to generate one
> in memory. In fact, doing so can be slow, and require large amounts of
> the heap.
> 
> Let's make sure that we treat the on-disk reverse index with precedence
> (i.e., that when it exists, we don't bother trying to generate an
> equivalent one in memory) by teaching Git how to conditionally die()
> when generating a reverse index in memory.
> 
> Then, add a test to ensure that when (a) an on-disk reverse index
> exists, and (b) when setting GIT_TEST_REV_INDEX_DIE_IN_MEMORY, that we
> do not die, implying that we read from the on-disk one.

I don't love this kind of hackery, as it will have to live forever if we
want to keep testing this feature. But I also don't know how else to
tell in the regular test suite that we are avoiding the slow path.

Would it be enough to instead add a t/perf test which checks the speed
of:

  echo HEAD | git cat-file --batch-check='%(objectsize:disk)'

? I hate relying on the perf suite, because it gets run way less often
(and requires a lot of squinting to interpret the results). But it
wouldn't require any extra code the binary, as it's observing the actual
user-visible thing we care about: speed.

(I guess we care as much or more about peak heap usage, but measuring
that is a whole other can of worms).

-Peff
