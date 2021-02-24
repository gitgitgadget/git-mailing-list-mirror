Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC122C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 21:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 843F364E20
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 21:05:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233178AbhBXVFv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 16:05:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:43888 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhBXVFv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 16:05:51 -0500
Received: (qmail 2047 invoked by uid 109); 24 Feb 2021 21:05:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Feb 2021 21:05:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19218 invoked by uid 111); 24 Feb 2021 21:05:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Feb 2021 16:05:09 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Feb 2021 16:05:09 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] dir: fix malloc of root untracked_cache_dir
Message-ID: <YDa/hT8g8FvmpXYT@coredump.intra.peff.net>
References: <pull.884.git.1614177117508.gitgitgadget@gmail.com>
 <xmqqk0qxz0s5.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqk0qxz0s5.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 24, 2021 at 12:08:42PM -0800, Junio C Hamano wrote:

> > Use FLEX_ALLOC_STR() to allocate the `struct untracked_cache_dir`
> > for the root directory.  Get rid of unsafe code that might fail to
> > initialize the `name` field (if FLEX_ARRAY is not 1).  This will
> > make it clear that we intend to have a structure with an empty
> > string following it.
> [...]
> The problematic code was introduced in 2015, a year before these
> FLEX_ALLOC_*() helpers were introduced.  The result is of course
> correct and much easier to read, as the necessary "ask for a region
> of calloc'ed memory with an additional byte for terminating NUL
> beyond strlen()" is hidden in the helper.

When I added the FLEX_ALLOC_* helpers, I audited for existing callers to
convert. But I did so by looking for places where we were doing manual
size computations. The bug here was that it was not doing any
computation at all (when it need to be doing "+1"). So that's my guess
why it got overlooked (which is not super important, but may give a hint
about how to look for similar bugs).

-Peff
