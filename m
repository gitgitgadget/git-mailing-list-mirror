Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081E8C83F12
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 00:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236296AbjH3ATU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 20:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233522AbjH3ASs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 20:18:48 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9BFCC2
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 17:18:46 -0700 (PDT)
Received: (qmail 15111 invoked by uid 109); 30 Aug 2023 00:18:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Aug 2023 00:18:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20448 invoked by uid 111); 30 Aug 2023 00:18:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 29 Aug 2023 20:18:46 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 29 Aug 2023 20:18:44 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .github/workflows: add coverity action
Message-ID: <20230830001844.GA227310@coredump.intra.peff.net>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
 <6534ba5d-f4a6-71e6-5b0f-9cba2be8426e@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6534ba5d-f4a6-71e6-5b0f-9cba2be8426e@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 29, 2023 at 10:18:24AM +0200, Johannes Schindelin wrote:

> - Limit it by repository "topics" (think: "repository tags"):
> 
> 	if: contains(github.event.repository.topics, 'has-coverity-secrets')

FWIW, I like this approach the most. As you note, it's not exactly
obvious to discover, but I think it is the most flexible. And setting up
Coverity runs already requires a lot of non-obvious steps (like creating
an account with them and getting a token to paste into the GitHub
secrets area).

My gut feeling is that we should be able to do something with env
variables to avoid the (ab)use of repository tags, but when I looked
into this in the past, it wasn't possible.  However, poking at it again
now, it seems that the "vars" context (but not "secrets") is available
to "jobs.*.if". I'm not sure if I missed before, or if that's a new
feature since the last time I checked.

At any rate, it seems to work to do:

  if: vars.ENABLE_COVERITY != ''

or even make COVERITY_SCAN_EMAIL a "var" instead of a "secret", and use
that. Likewise, I think we could do:

  if: contains(vars.COVERITY_BRANCHES, github.ref_name)

to allow individual repositories to do their own branch selection (that
is matching by substring, which is probably good enough, but if you want
to get fancy, I think we can use fromJSON to interpret the contents of
the variable).

(I had mostly looked into this in the context of branch selection for
our ci-config job, and I think we could do something similar there).

-Peff
