Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B676CC35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BA0720675
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgBXErd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:47:33 -0500
Received: from cloud.peff.net ([104.130.231.41]:52372 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727186AbgBXErd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:47:33 -0500
Received: (qmail 5303 invoked by uid 109); 24 Feb 2020 04:47:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:47:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7075 invoked by uid 111); 24 Feb 2020 04:56:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:56:38 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:47:32 -0500
From:   Jeff King <peff@peff.net>
To:     Mike Hommey <mh@glandium.org>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] Remove non-SHA1dc sha1 implementations
Message-ID: <20200224044732.GK1018190@coredump.intra.peff.net>
References: <xmqqk14rtonu.fsf@gitster-ct.c.googlers.com>
 <20200223223758.120941-1-mh@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200223223758.120941-1-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 24, 2020 at 07:37:58AM +0900, Mike Hommey wrote:

> It is 2020, and with the weakening of SHA1 security-wise, there doesn't
> seem to be a reason to support anything else than SHA1dc, with collision
> detection.

One possible reason is that they're way faster than sha1dc (block-sha1
maybe only a little, but openssl's sha1 is over twice as fast).

To be clear, I think the slowdown is worth the extra safety, but:

 - do we still want to care about people who prefer to make the tradeoff
   differently?

 - when we first switched the default to sha1dc, the idea was raised of
   continuing to use a faster implementation for non-security checksums
   (e.g., the checksums at the end of packfiles, index files, etc). I
   don't think anybody ever implemented that, but it's not a terrible
   idea. OTOH, if nobody noticed the bottleneck enough to care, maybe
   it's not worth worrying about.

I'm not convinced the answer to those questions is "yes", but I think
it's worth at least raising them (and arguing against them in the commit
message).

One thing that compels me is the recent report that we still build with
common crypto by default on macOS, which was definitely _not_ intended.
That's a bug that can be fixed, but it wouldn't have happened in the
first place if we only supported sha1dc.

-Peff
