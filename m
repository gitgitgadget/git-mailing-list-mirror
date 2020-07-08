Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F20C433E0
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 04:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B11D2078C
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 04:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728927AbgGHEuK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 00:50:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:52004 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbgGHEuK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 00:50:10 -0400
Received: (qmail 26609 invoked by uid 109); 8 Jul 2020 04:50:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 08 Jul 2020 04:50:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1408 invoked by uid 111); 8 Jul 2020 04:50:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 08 Jul 2020 00:50:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 8 Jul 2020 00:50:08 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH/RFC] config: default to protocol v2
Message-ID: <20200708045008.GC2303891@coredump.intra.peff.net>
References: <20200707053805.GB784740@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200707053805.GB784740@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 06, 2020 at 10:38:05PM -0700, Jonathan Nieder wrote:

> Git 2.26 used protocol v2 as its default protocol, but soon after
> release, reports of edge-case regressions started rolling in.  So Git
> 2.27 returned to protocol v0 as a default (but with the various fixes
> in place to make protocol v2 safe) and Git 2.28 will use protocol v0
> as default but enable protocol v2 for those adventurous users that
> enable experimental features by setting feature.experimental=true.
> 
> Thus if all goes well, by the time Git 2.29 is being released, we can
> be confident in protocol v2 as a default again.  Make it the default.
> 
> This especially speeds up fetches from repositories with many refs,
> such as https://chromium.googlesource.com/chromium/src.
> 
> Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
> ---
> Mostly sending this to get the discussion started about what changes
> we want before flipping the default.

I can't actually think of any changes we'd want to make. AFAIK aside
from the negotiation problem, v2 is good to go. When we flipped it off
by default for 2.27 out of caution, I had hoped we would flip it back on
for the 2.28 cycle to get more exposure.

I guess it may be too late for that now if we wanted to get more testing
and exposure during the development cycle. But I'm not entirely
convinced that buys us anything anyway. v2 was available via a config
setting for at least a year, and major hosting sites supported it, and
still nobody noticed the negotiation problem until it was turned on by
default in 2.26.

And that has been the only bug people have reported for 2.26. That
implies to me that:

  - we won't get significantly more information by leaving v2-as-default
    in "next" or even "master" before it actually hits a release

  - there probably aren't other major problems lurking, given that
    people clearly upgraded to 2.26, found the negotiation problem, but
    never reported any other issues

-Peff
