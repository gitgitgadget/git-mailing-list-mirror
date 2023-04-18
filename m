Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62344C77B78
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 10:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjDRKLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 06:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231147AbjDRKLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 06:11:18 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A388772B5
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 03:10:59 -0700 (PDT)
Received: (qmail 4832 invoked by uid 109); 18 Apr 2023 10:10:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Apr 2023 10:10:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 691 invoked by uid 111); 18 Apr 2023 10:10:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Apr 2023 06:10:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Apr 2023 06:10:58 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] string-list: introduce
 `string_list_split_in_place_multi()`
Message-ID: <20230418101058.GA508219@coredump.intra.peff.net>
References: <cover.1681428696.git.me@ttaylorr.com>
 <dda218c8c1fdc0ca2e4352b820f3432565a74a23.1681428696.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dda218c8c1fdc0ca2e4352b820f3432565a74a23.1681428696.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 13, 2023 at 07:31:43PM -0400, Taylor Blau wrote:

> Instead of using `strchr(2)` to locate the first occurrence of the given
> delimiter character, `string_list_split_in_place_multi()` uses
> `strpbrk(2)` to find the first occurrence of *any* character in the given
> delimiter string.
> 
> Since the `_multi` variant is a generalization of the original
> implementation, reimplement `string_list_split_in_place()` in terms of
> the more general function by providing a single-character string for the
> list of accepted delimiters.

I'd imagine that strpbrk() is potentially a lot slower than strchr().
But I kind of doubt that splitting is such a hot path that it will
matter. If we want to care, I think we could do something like:

  end = delim[1] ? strpbrk(p, delim) : strchr(p, delim[0]);

It's entirely possible that a half-decent strpbrk() implementation does
this already.

So I mention it mostly in case we need to revisit this later. I think
it's OK to ignore for now.

-Peff
