Return-Path: <SRS0=kKTt=BD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AAAC433E1
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FFE92070B
	for <git@archiver.kernel.org>; Fri, 24 Jul 2020 19:51:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgGXTv1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jul 2020 15:51:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:37496 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgGXTv1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jul 2020 15:51:27 -0400
Received: (qmail 24794 invoked by uid 109); 24 Jul 2020 19:51:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Jul 2020 19:51:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26133 invoked by uid 111); 24 Jul 2020 19:51:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Jul 2020 15:51:26 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 24 Jul 2020 15:51:26 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200724195126.GB4013174@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
 <20200724165133.GA15287@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200724165133.GA15287@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 12:51:33PM -0400, Taylor Blau wrote:

> Let me double check my understanding... I think that you are suggesting
> the following three things:
> 
>   - Write the same message as an err packet over the wire as we do when
>     'die()'ing from inside of upload-pack.c
> 
>   - Don't mark said message(s) for translation, matching what we do in
>     the rest of upload-pack.c.
> 
>   - Re-introduce the 'test_must_fail ok=sigpipe' and stop grepping
>     stderr for the right message.
> 
> Do I have that right?

I'm not Gábor, but that is the sequence I think is best.

Between the die() and the ERR, the ERR packets are way more useful in
practice, since they actually go back to the client. I'd even suggest we
do away with the die() messages entirely (since they're either redundant
or go nowhere, depending on the protocol), but I think it would make
sense to wait until the raciness issues are fixed (until then, they
_might_ help in the redundant cases, which is what the test here is
relying on).

-Peff
