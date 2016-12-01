Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8CF4A1FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 19:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752913AbcLATDf (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 14:03:35 -0500
Received: from cloud.peff.net ([104.130.231.41]:50005 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751937AbcLATDe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 14:03:34 -0500
Received: (qmail 9503 invoked by uid 109); 1 Dec 2016 19:03:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 19:03:34 +0000
Received: (qmail 2140 invoked by uid 111); 1 Dec 2016 19:04:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 14:04:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 14:03:32 -0500
Date:   Thu, 1 Dec 2016 14:03:32 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, jonathantanmy@google.com,
        gitster@pobox.com
Subject: Re: [PATCH v6 0/6] recursively grep across submodules
Message-ID: <20161201190332.lh627xknixb7ccrt@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <20161201042228.ynug33mcsqkdbuoe@sigill.intra.peff.net>
 <20161201174547.GA51406@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201174547.GA51406@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 09:45:47AM -0800, Brandon Williams wrote:

> Yeah I was trying to think through these scenarios myself last night.
> And like you found it seemed alright to let the child process deal with
> the .git file/dir as long as once actually exists at that path.  If one
> didn't then there would be the possibility that we ended up back at the
> superproject, which would result in an infinite loop.  And yeah if the
> .git file doesn't resolve to anything sensible then the user probably
> mangled their repository somehow anyways.

I hadn't considered the infinite loop. I thought the worst case is that
we might just generate bogus results by going back to the superproject.
But of course there is nothing to stop it from just recursing again.

However, it looks like there is a circuit-breaker; we end up back in the
superproject, but inside a subdirectory, which causes --super-prefix to
complain.

You can test it with just:

  rm submodule/.git
  mkdir submodule/.git

which says:

  fatal: can't use --super-prefix from a subdirectory
  fatal: process for submodule 'foo' failed with exit code: 128

It might be worth including a test to make sure that behavior remains.
I think it's more of an emergent behavior than something planned. :)

-Peff
