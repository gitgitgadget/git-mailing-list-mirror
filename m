Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D55C2D0E4
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 04:17:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A97E2222A
	for <git@archiver.kernel.org>; Fri, 27 Nov 2020 04:17:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388784AbgK0ERp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 23:17:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:44250 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731568AbgK0ERp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 23:17:45 -0500
Received: (qmail 18788 invoked by uid 109); 27 Nov 2020 04:17:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Nov 2020 04:17:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22679 invoked by uid 111); 27 Nov 2020 04:17:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Nov 2020 23:17:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Nov 2020 23:17:43 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>,
        git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on [
Message-ID: <X8B9589XMlCQEltA@coredump.intra.peff.net>
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
 <20201121002921.GC353076@coredump.intra.peff.net>
 <xmqqd006s7ee.fsf@gitster.c.googlers.com>
 <X7zOKbzR9gwJHMbJ@coredump.intra.peff.net>
 <xmqqy2ipcdvj.fsf@gitster.c.googlers.com>
 <X778eIAr3uzdh0H0@coredump.intra.peff.net>
 <xmqqo8jllyhc.fsf@gitster.c.googlers.com>
 <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd2c4577-4c8c-851c-6045-ba4b306ca612@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 09:04:35PM +0100, René Scharfe wrote:

> Before I could submit that one (or something similar) formally, I'd need
> to understand what's happening here a lot better and witness the effect
> of the patch.
> 
> I understand that the main benefit of stopping the child upon
> termination of the parent is to avoid using CPU cycles on a heavy task
> whose results will just go to waste.  But wouldn't the orphaned child
> then become a zombie?  Init would reap it eventually, but are there
> perhaps init-less deployments (containerized daemon?) where such
> zombies could pile up?

I think an init-less deployment like that is already broken. If we
encounter any error at all in upload-pack we may quit without reaping
all of our children. And this could never be protected against entirely;
we could be killed by SIGSEGV, SIGKILL, etc.

My understanding is container deployments often have a tiny pid-1 init
that takes care of zombie processes like this (but it's not something
I've dealt with much myself).

> For a test, winning the race condition should be easy if we cheat by
> letting the child loop forever.  But I struggle even with the most
> basic task: Making upload-pack invoked by clone call pack-objects.
> (Feeling a bit silly.)

Here's an easy reproduction. On a clone of something large-ish (by
number of objects) like linux.git:

  - make sure you don't have bitmaps on (since they make the enumerating
    phase go quickly). For linux.git it takes ~30s or so to walk the
    whole graph on my machine.

  - run "git clone --no-local -q . dst"; the "-q" is important because
    if pack-objects is writing progress to upload-pack (to get
    multiplexed over the sideband to the client), then it will notice
    pretty quickly the failure to write to stderr

  - kill just upload-pack with "pkill git-upload-pack" or whatever you
    like

  - run "ps au | grep pack-objects" (or just "top") to see pack-objects
    chugging on 100% CPU (and consuming 1GB+ of RAM)

With the patch adding clean_on_exit, that last step turns up nothing.

Now the situation above is probably pretty rare. Nobody is usually going
to kill upload-pack specifically. The more common case is when
upload-pack realizes that the client (or the network) has gone away,
because it tries to write and finds the connection gone. But what is it
writing? Most of the time it's stuff from pack-objects! So in the normal
case, pack-objects is continually writing either data or progress
reports, so it would notice for its next write.

But again, a client asking for no progress is a problem. upload-pack
will be sending keepalives every 5s or so, so it will notice client
death then. But pack-objects will keep running, not generating any
output until it starts spewing the pack.

So you could probably make the scenario above a bit more realistic by
killing the parent git-clone process. But don't use ^C; that will send
SIGINT to all of the processes. Simulate a network failure by killing
the "git clone" process specifically. This shows the same problem, and
the same improvement after the patch (though remember it may take up to
5 seconds for upload-pack to send a keepalive and notice the problem).

-Peff
