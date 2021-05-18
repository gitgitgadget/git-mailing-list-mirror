Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21A59C433B4
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED31E60FD8
	for <git@archiver.kernel.org>; Tue, 18 May 2021 12:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244621AbhERMNH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 08:13:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:57760 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233638AbhERMNH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 08:13:07 -0400
Received: (qmail 14629 invoked by uid 109); 18 May 2021 12:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 May 2021 12:11:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7445 invoked by uid 111); 18 May 2021 12:11:48 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 May 2021 08:11:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 May 2021 08:11:48 -0400
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     "Randall S. Becker" <rsbecker@nexbridge.com>, git@vger.kernel.org,
        'SZEDER =?utf-8?Q?G=C3=A1bor'?= <szeder.dev@gmail.com>,
        'Johannes Schindelin via GitGitGadget' 
        <gitgitgadget@gmail.com>, jeffhost@microsoft.com
Subject: Re: [BUG] Unix Builds Requires Pthread Support (was [PATCH v4 00/12]
 Simple IPC Mechanism)
Message-ID: <YKOvBGjAC2kVPVa7@coredump.intra.peff.net>
References: <009d01d74b44$9efe8a60$dcfb9f20$@nexbridge.com>
 <YKN5lXs4AoK/JFTO@coredump.intra.peff.net>
 <8540e41e-3ba6-8d40-9424-8f62ea785f42@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8540e41e-3ba6-8d40-9424-8f62ea785f42@jeffhostetler.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 18, 2021 at 07:21:33AM -0400, Jeff Hostetler wrote:

> > In the simple-ipc API, there's an explicit "async" interface. But it's
> > not clear to me how rich it expects the communication with the caller to
> > be (i.e., whether we could get away with the fork() trick here). Or if
> > it would be OK for the threading to remain an implementation detail,
> > with one "worker" upon whom we wait for completion.
> > 
> 
> TBH I forgot that we still support NO_PTHREAD systems.
> I seem to remember that we got rid of some of the non-pthread
> stub functions at one point, but I'm fuzzy on the details.

You're probably thinking of when we got rid of a bunch of #ifdef code
paths in index-pack, and replaced it with stubs that turn the pthread
calls into "do nothing" (so all the ugly stuff is in thread-utils.h
now). But we still very much support systems that don't handle pthreads
at all.

> WRT to "simple ipc" (and future "builtin fsmonitor"), it's heavily
> threaded.  There's no point in trying to fake it with forks.
> 
> The server side of simple ipc implements a thread pool.  And
> the builtin fsmonitor will use a thread to monitor FS events
> and that thread pool to respond to clients.  All driven from a
> shared queue of events.
> 
> It would be a major overhaul to do all that without threads
> -- and even that assumes that nonstop has a sufficient file
> system notification mechanism.

OK, that matches my guess from a brief look at the code. Thanks for
confirming.

> So, yes, we should ifdef it out as Peff suggests.

The patch I sent wasn't really tested beyond confirming that "make
NO_PTHREADS=1" finished compiling (and that test-tool simple-ipc
barfed appropriately at runtime).

Do you want to pick it up from there and produce a polished patch? I
think we should deal with this prior to the v2.32.0 release (and thanks
Randall for testing and finding it during the -rc0 period).

-Peff
