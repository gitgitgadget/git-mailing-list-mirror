Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A918EC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8799860C40
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhFKRN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 13:13:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:52674 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230212AbhFKRNV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 13:13:21 -0400
Received: (qmail 14211 invoked by uid 109); 11 Jun 2021 17:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Jun 2021 17:11:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10041 invoked by uid 111); 11 Jun 2021 17:11:20 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Jun 2021 13:11:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 11 Jun 2021 13:11:19 -0400
From:   Jeff King <peff@peff.net>
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Andrzej Hunt <andrzej@ahunt.org>
Subject: Re: [PATCH 0/3] Fix uninitialised reads found with MSAN
Message-ID: <YMOZNyzWZbDvtFkD@coredump.intra.peff.net>
References: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1033.git.git.1623343712.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 10, 2021 at 04:48:29PM +0000, Andrzej Hunt via GitGitGadget wrote:

> As to the tricky part: MSAN tries to detect reads from uninitialised memory
> at runtime. However you need to ensure that all code performing
> initialisation is built with the right instrumentation (i.e.
> -fsanitize=memory). So you'll immediately run into issues if you link
> against libraries provided by your system (with the exception of libc, as
> MSAN provides some default interceptors for most of libc). In theory you
> should rebuild all dependencies with -fsanitize=memory, although I
> discovered that it's sufficient to recompile only zlib + link git against
> that copy of zlib (which not a very tricky thing to do). Doing this will
> uncover one intentional read from uninitialised memory inside zlib itself.
> This can be worked around with an annotation in zlib (which I'm trying to
> submit upstream at [1]) - but it's also possible to define an override list
> at compile time - I've detailed this in my recipe below).

I played with MSAN a while ago, and yeah, the trickiest part is dealing
with libraries. I came up with this patch for handling zlib from within
Git itself:

  https://lore.kernel.org/git/20171004101932.pai6wzcv2eohsicr@sigill.intra.peff.net/

It's entirely possible that it papers over actual bugs (perhaps even the
one your first patch is addressing). But I wonder if it's easier to
convince people to try the tool if there's an easy way to do it without
recompiling dependencies (I also hit issues with pcre and the libc
regex; that was a few years ago, though, so I would not be at all
surprised if they know intercept the system regex routines, at least).

-Peff
