Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08ACEC11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D98D76147D
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 17:45:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbhF3Rrm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:47:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:37604 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230191AbhF3Rrl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 13:47:41 -0400
Received: (qmail 24647 invoked by uid 109); 30 Jun 2021 17:45:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Jun 2021 17:45:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9253 invoked by uid 111); 30 Jun 2021 17:45:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Jun 2021 13:45:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 30 Jun 2021 13:45:11 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Andrei Rybak <rybak.a.v@gmail.com>
Subject: Re: [PATCH v3 0/3]
Message-ID: <YNytp0JAIaQih0Y4@coredump.intra.peff.net>
References: <cover-0.3-00000000000-20210621T151357Z-avarab@gmail.com>
 <cover-0.3-00000000000-20210630T140339Z-avarab@gmail.com>
 <YNyrDxUO1PlGJvCn@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YNyrDxUO1PlGJvCn@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 30, 2021 at 01:34:07PM -0400, Jeff King wrote:

> As an aside, having to have a separate bundle_header_init() and
> BUNDLE_HEADER_INIT is annoying (because they both must be kept up to
> date with each other), but quite common in our code base. I wonder if
> writing:
> 
>   void bundle_header_init(struct bundle_header *header)
>   {
> 	struct bundle_header blank = BUNDLE_HEADER_INIT;
> 	memcpy(header, &blank, sizeof(*header));
>   }
> 
> would let a smart enough compiler just init "header" in place without
> the extra copy (the performance of a single bundle_header almost
> certainly doesn't matter, but it might for other types).
> 
> Just musing. ;)

For my own curiosity, the answer is yes: https://godbolt.org/z/s54dc6ss9

With "gcc -O2" the memcpy goes away and we init "header" directly.

If we want to start using this technique widely, I don't think it should
be part of your series, though. This probably applies to quite a few
data structures, so it would make more sense to have a series which
converts several.

-Peff
