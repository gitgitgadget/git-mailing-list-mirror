Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9AD21F404
	for <e@80x24.org>; Wed, 29 Aug 2018 22:18:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbeH3CRh (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 Aug 2018 22:17:37 -0400
Received: from cloud.peff.net ([104.130.231.41]:33070 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727104AbeH3CRh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Aug 2018 22:17:37 -0400
Received: (qmail 23069 invoked by uid 109); 29 Aug 2018 22:18:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 29 Aug 2018 22:18:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19697 invoked by uid 111); 29 Aug 2018 22:18:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 29 Aug 2018 18:18:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 29 Aug 2018 18:18:38 -0400
Date:   Wed, 29 Aug 2018 18:18:38 -0400
From:   Jeff King <peff@peff.net>
To:     Jann Horn <jannh@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 1/3] patch-delta: fix oob read
Message-ID: <20180829221838.GA10400@sigill.intra.peff.net>
References: <20180829205857.77340-1-jannh@google.com>
 <20180829212025.GB29880@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180829212025.GB29880@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 29, 2018 at 05:20:25PM -0400, Jeff King wrote:

> Nice catch. The patch looks good to me, but just to lay out my thought
> process looking for other related problems:
> 
> We have two types of instructions:
> 
>   1. Take N bytes from position P within the source.
> 
>   2. Take the next N bytes from the delta stream.
> 
> In both cases we need to check that:
> 
>   a. We have enough space in the destination buffer.
> 
>   b. We have enough source bytes.

Actually, there's one other case to consider: reading the actual offset
for a copy operation. E.g., if we see '0x80' at the end of the delta,
I think we'd read garbage into cp_offset? That would typically generate
nonsense that would be caught by the other checks, but I think it's
possible that the memory could happen to produce a valid copy
instruction from the base, leading to a confusing result (though it
would still need to match the expected result size).

Thinking on it more, one other interesting tidbit here: in actual git
code (i.e., not test-delta), we'd always be reading from an mmap'd
packfile. And we're guaranteed to have at least 20 trailing bytes in the
mmap due to the pack format (which is enforced when we parse the pack).

So I don't think this can ever read truly out-of-bounds memory, though
obviously it's something we should fix regardless.

-Peff
