Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C3C9C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 026AF60F39
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbhHPVzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 17:55:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:49158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232269AbhHPVzf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 17:55:35 -0400
Received: (qmail 25540 invoked by uid 109); 16 Aug 2021 21:55:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 21:55:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19442 invoked by uid 111); 16 Aug 2021 21:55:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 17:55:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 17:55:01 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     Max Kirillov <max@max630.net>,
        'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRretXfEfiVujSeO@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
 <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
 <01b401d792c9$c083e4b0$418bae10$@nexbridge.com>
 <YRqv30kTZqW9nMN0@coredump.intra.peff.net>
 <01b901d792d0$1e993950$5bcbabf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <01b901d792d0$1e993950$5bcbabf0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 02:54:14PM -0400, Randall S. Becker wrote:

> >That 60 seconds is the timeout from t5562/invoke-with-content-length.
> >
> >So one, are you sure it's hanging forever, and not just for 60 seconds?
> 
> Absolutely sure. 48 hours because I forgot to check.
> 
> >And two, it is quite obvious there's some racing here. I'm not sure if this is indicative of a problem in the test suite, or in http-backend
> >itself (in which case it could be affecting real users).
> 
> How can I help track this down?

Here's what I found out so far. For my 60-second lag case, the test
_does_ complete as expected; it just takes a long time. So I think what
happens is this:

  - the invoke-with-content-length script sets up a SIGCLD handler

  - then it kicks off http-backend and writes to it

  - then it sleeps for 60 seconds, assuming that SIGCLD will interrupt
    the sleep

  - after the sleep finishes (whether by 60 seconds or because it was
    interrupted by the signal), we check a flag to see if our SIGCLD
    handler was called. If not, then we complain.

This usually completes instantaneously-ish, because the signal
interrupts our sleep. But very occasionally the child process dies
_before_ we hit the sleep, so we don't realize it.

So ideally we'd have some way of atomically checking our flag and then
sleeping only if it's not set. But I don't think that exists. The
closest we can come is using a series of smaller sleeps and checks. And
indeed, digging in the archive shows that Max already proposed such a
patch:

  https://lore.kernel.org/git/20190218205028.32486-1-max@max630.net/

It looks like it feel through the cracks, though. Maybe now is a good
time to resurrect it.

However, you are in that thread, too, and it didn't help your situation.
So I think your race is somehow different. It looks like there was some
weirdness around close() for you, though generally we _shouldn't_ be
hitting that close() at all, because we'd have gotten SIGCLD and set the
$exited flag in the interim.

-Peff
