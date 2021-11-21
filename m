Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA51C433EF
	for <git@archiver.kernel.org>; Sun, 21 Nov 2021 22:05:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231548AbhKUWIU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Nov 2021 17:08:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:35926 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230028AbhKUWIT (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Nov 2021 17:08:19 -0500
Received: (qmail 17924 invoked by uid 109); 21 Nov 2021 22:05:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Nov 2021 22:05:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6925 invoked by uid 111); 21 Nov 2021 22:05:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Nov 2021 17:05:14 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 21 Nov 2021 17:05:12 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Is t7006-pager.sh racy?
Message-ID: <YZrCmPb5AIW8YYQ0@coredump.intra.peff.net>
References: <xmqq1r4b8ezp.fsf@gitster.g>
 <20211024170349.GA2101@szeder.dev>
 <YZqSgu4XjPWnURju@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YZqSgu4XjPWnURju@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Nov 21, 2021 at 01:40:02PM -0500, Jeff King wrote:

> It seems like this thread stalled. Ævar, were you planning to fix these
> tests?
> 
> It's not too hard to swap out a "yes" as I showed above, but it further
> confuses the trace2 output, because now we have the child yes (or its
> shell equivalent) exiting as well.
> [...]

I think it also probably doesn't test what the patch adding these tests
was interested in. Specifically, it's trying to check the case of
reporting the pager exit code while we're in a signal handler. So we
have to get the SIGPIPE in the main git process to trigger that. Which
means it has to be a builtin.

So you really do need a builtin that produces infinite output. Or at the
very least, enough that we expect it to fill any possible OS pipe
buffer. I guess the latter is actually not that hard. A 1MB
commit-message would be plenty (or if you prefer, a big file with "log
-p").

-Peff
