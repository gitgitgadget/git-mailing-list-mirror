Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5655DC433E0
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:03:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A0E72067D
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 19:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgF3TD1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 15:03:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:46420 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgF3TD0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 15:03:26 -0400
Received: (qmail 13925 invoked by uid 109); 30 Jun 2020 19:03:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2020 19:03:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25768 invoked by uid 111); 30 Jun 2020 19:03:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2020 15:03:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 30 Jun 2020 15:03:25 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/3] t4216: fix broken '&&'-chain
Message-ID: <20200630190325.GB1888406@coredump.intra.peff.net>
References: <cover.1593536481.git.me@ttaylorr.com>
 <5a20a97658fa8e6c874c9c9cafb2cf49e39f94d6.1593536481.git.me@ttaylorr.com>
 <CAPig+cQv3cHe5ci3mDvNKYXbVQt6Rp5icG-woaDCqfAtzZ6SZw@mail.gmail.com>
 <20200630183928.GB26550@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200630183928.GB26550@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 30, 2020 at 02:39:28PM -0400, Taylor Blau wrote:

> > > This ends up working fine when the file already exists, in which case
> > > 'rm' exits cleanly and the rest of the function executes normally. When
> > > the file does _not_ exist, however, 'rm' returns an unclean exit code,
> > > causing the function to terminate.
> >
> > This explanation makes no sense. Since this command was not part of
> > the &&-chain, its failure would not cause the function to terminate
> > prematurely nor would it affect the return value of the function. This
> > explanation would make sense, however, if you're talking about the
> > behavior _after_ fixing the broken &&-chain.
> 
> Fair enough. For what it's worth, this explanation *does* make sense if
> you 'set -e' beforehand, which I am accustomed to (and had incorrectly
> assumed that tests in 't' also have 'set -e', when they do not).

If we _really_ want to nitpick, it probably wouldn't terminate under
"set -e" because the call to "setup" is itself part of an &&-chain,
which suppresses "-e" handling (which is one of the many confusing "set
-e" behaviors that led us to avoid it in the first place).

But definitely your revised commit message below is more accurate.

However...

> --- >8 ---
> 
> Subject: [PATCH] t4216: fix broken '&&'-chain
> 
> The 'rm' added in a759bfa9ee (t4216: add end to end tests for git log
> with Bloom filters, 2020-04-06) should be placed within the function's
> '&&'-chain.
> 
> The file being removed may not exist (for eg., in the case of '--run',
> in which case it may not be generated beforehand by a skipped test), and
> so add '-f' to account for the file's optional existence.

Is the &&-chain really broken, or is the first command simply not part
of that chain? Perhaps a question for philosophers, but the more applied
question here is: what are we improving, and why?

The original code handled the fact that the file might not exist by not
including its exit code in the &&-chain which leads to the function's
return value. Your new code does so by putting it in the &&-chain but
asking "rm" to ignore errors. Is one better than the other?

I think so, but my argument would be more along the lines of:

  - without "-f", "rm" will complain about a missing file, which is
    distracting noise in the test log

  - once "-f" is added in to suppress that, we might as well add the
    command to the &&-chain. That's our normal style, so readers don't
    have to wonder if it's important or not. Plus it would help avoid a
    broken chain if more commands are added at the beginning of the
    function.

-Peff
