Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51807C4332F
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 01:16:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbiKXBQJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 20:16:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKXBQI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 20:16:08 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4F35FF419
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 17:16:07 -0800 (PST)
Received: (qmail 24377 invoked by uid 109); 24 Nov 2022 01:16:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 24 Nov 2022 01:16:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21558 invoked by uid 111); 24 Nov 2022 01:16:07 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 23 Nov 2022 20:16:07 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 23 Nov 2022 20:16:06 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Git List <git@vger.kernel.org>,
        Kyle Zhao <kylezhao@tencent.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH] t5516: fail to run in verbose mode
Message-ID: <Y37F1nxifC8o8qEQ@coredump.intra.peff.net>
References: <20221121134040.12260-1-worldhello.net@gmail.com>
 <xmqqo7szsjs4.fsf@gitster.g>
 <Y30eK/mNYeLNtOi2@coredump.intra.peff.net>
 <xmqqwn7mo4eu.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqwn7mo4eu.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 23, 2022 at 10:17:29AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I agree this is a good fix for now, but I wonder philosophically what it
> > means. That is, I could see two arguments:
> >
> >   1. Our tests sometimes run with stderr connected to a tty and
> >      sometimes not. This means the test environment isn't consistent,
> >      and perhaps we should be piping all "-v" tests through "cat" or
> >      something so that the environment is stable.
> 
> Yes, this is tempting (and I almost brought it up in my response),
> and a pipe to "|cat" may be hopefully closer than tester's tty to
> the redirection to "/dev/null".  I didn't know how much closer,
> though, and the differences may still matter (we could teach "git
> grep" or "git diff --exit-code" to notice that the output is sent to
> /dev/null and stop at the first hit, for example), but still "|cat"
> is closer than ">/dev/tty".

One thing I'd worry about is buffering. One of the nice things about
"-v" is that there is nothing between you and the running programs, so
you are much less likely to be fooled about the order of events in the
output. Or wondering why nothing is happening because real-time output
seems to have stalled. But piping through "cat" may end up with weird
pauses while it fills up a 4k buffer. Using stdbuf could help, but
that's far from portable.

-Peff
