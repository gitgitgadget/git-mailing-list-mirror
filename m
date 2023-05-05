Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A832C77B75
	for <git@archiver.kernel.org>; Fri,  5 May 2023 21:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233495AbjEEV0s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 17:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233469AbjEEV0q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 17:26:46 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32B1A8
        for <git@vger.kernel.org>; Fri,  5 May 2023 14:26:32 -0700 (PDT)
Received: (qmail 4710 invoked by uid 109); 5 May 2023 21:26:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 May 2023 21:26:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4361 invoked by uid 111); 5 May 2023 21:26:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 May 2023 17:26:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 May 2023 17:26:31 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <20230505212631.GB3321533@coredump.intra.peff.net>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLSDS89y8P2+g/2@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFLSDS89y8P2+g/2@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 03, 2023 at 05:28:45PM -0400, Taylor Blau wrote:

> > OK, I understand the use case you're trying to support, and your
> > approach mostly makes sense. But there are two things I was surprised by
> > in the implementation:
> >
> >   1. Does this need to be tied to cruft packs? The same logic would
> >      apply to "repack -A" which turns objects loose (of course you
> >      probably don't want to do that in the long term for performance
> >      reasons, but it's conceptually the same thing; see below).
> 
> I agree that you wouldn't want to do it for performance reasons, but I'm
> comfortable with the asymmetry here, since this is `pack.extraCruftTips`
> (emphasis on "cruft"), so it's not clear that it has to be related to
> "repack -A".
> 
> Happy to change things up if you feel strongly, though.

I don't feel strongly. I certainly have no intent to run "git repack -A"
with extra tips specified. Mostly I just thought that it would be
simpler to just apply it everywhere, both conceptually to the user and
within the implementation.

But since the cruft-pack implementation diverges quite a bit from the
regular "-A" handling, I guess it makes the code more complex rather
than less. The asymmetry feels like a wart to me, but I guess in the
long run we'd hope that the "turn unreachable loose" strategy is
deprecated anyway.

-Peff
