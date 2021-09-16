Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B084BC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:49:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9611C611F2
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241275AbhIPWvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:51:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:49578 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241276AbhIPWvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:51:13 -0400
Received: (qmail 8778 invoked by uid 109); 16 Sep 2021 22:49:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Sep 2021 22:49:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10105 invoked by uid 111); 16 Sep 2021 22:49:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Sep 2021 18:49:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 16 Sep 2021 18:49:50 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, avarab@gmail.com
Subject: Re: [PATCH v2 7/7] t5326: test propagating hashcache values
Message-ID: <YUPKDhi+rgwptZdY@coredump.intra.peff.net>
References: <cover.1631049462.git.me@ttaylorr.com>
 <cover.1631657157.git.me@ttaylorr.com>
 <fdf71432b32ef47b23b79ddfc3db8de8734ef7a5.1631657157.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdf71432b32ef47b23b79ddfc3db8de8734ef7a5.1631657157.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 06:06:16PM -0400, Taylor Blau wrote:

> Now that we both can propagate values from the hashcache, and respect
> the configuration to enable the hashcache at all, test that both of
> these function correctly by hardening their behavior with a test.
> 
> Like the hash-cache in classic single-pack bitmaps, this helps more
> proportionally the more up-to-date your bitmap coverage is. When our
> bitmap coverage is out-of-date with the ref tips, we spend more time
> proportionally traversing, and all of that traversal gets the name-hash
> filled in.
> 
> But for the up-to-date bitmaps, this helps quite a bit. These numbers
> are on git.git, with `pack.threads=1` to help see the difference
> reflected in the overall runtime.
> 
>     Test                            origin/tb/multi-pack-bitmaps   HEAD
>     -------------------------------------------------------------------------------------
>     5326.4: simulated clone         1.87(1.80+0.07)                1.46(1.42+0.03) -21.9%
>     5326.5: simulated fetch         2.66(2.61+0.04)                1.47(1.43+0.04) -44.7%
>     5326.6: pack to file (bitmap)   2.74(2.62+0.12)                1.89(1.82+0.07) -31.0%

The percentages here match timings I did. Doing it with linux.git gives
bigger absolute numbers, but I think this is sufficient (and a lot less
painful when people are trying to replicate).

> +test_expect_success 'hash-cache values are propagated from pack bitmaps' '
> +	rm -fr repo &&
> +	git init repo &&
> +	test_when_finished "rm -fr repo" &&
> +	(
> +		cd repo &&
> +
> +		git config pack.writeBitmapHashCache true &&

This is the default as of your earlier commits, so we could probably
drop this. I don't mind keeping it as explicit documentation of what we
expect, though.

-Peff
