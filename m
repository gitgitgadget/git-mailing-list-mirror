Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97167C761A6
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 18:55:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjC1SzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 14:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjC1SzX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 14:55:23 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4342139
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 11:55:22 -0700 (PDT)
Received: (qmail 1465 invoked by uid 109); 28 Mar 2023 18:55:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Mar 2023 18:55:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 726 invoked by uid 111); 28 Mar 2023 18:55:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Mar 2023 14:55:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Mar 2023 14:55:20 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Matthew John Cheetham via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Glen Choo <chooglen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v7 00/12] Enhance credential helper protocol to include
 auth headers
Message-ID: <20230328185520.GE18558@coredump.intra.peff.net>
References: <pull.1352.v6.git.1674012618.gitgitgadget@gmail.com>
 <pull.1352.v7.git.1674252530.gitgitgadget@gmail.com>
 <e57c1ca3-c21c-db41-a386-e5887f46055c@github.com>
 <xmqqwn5bg695.fsf@gitster.g>
 <Y9JkMLueCwjkLHOr@coredump.intra.peff.net>
 <xmqqfsbxcmdd.fsf@gitster.g>
 <6f83ed25-a7e1-06dd-f180-d70c7e1b1973@gmx.de>
 <Y91FjhNgZGz6foFl@coredump.intra.peff.net>
 <0f94b998-e223-85cc-7730-f75675d5e649@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0f94b998-e223-85cc-7730-f75675d5e649@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 27, 2023 at 11:10:40AM +0200, Johannes Schindelin wrote:

> > I'm skeptical that it is a good idea for Git to implement a custom http
> > server from scratch.
> 
> To be clear: I never suggested to implement a generic HTTP server.
> 
> All I wanted was to have a replacement for `git daemon` that speaks
> https:// instead of git://. It does not have to speak to every browser out
> there, it only needs to respond well when speaking to Git clients. That is
> a much, much smaller surface than "production-ready server, HTTP/2 and so
> on".

I guess I don't see the point of having this in our test suite, though.
We do want to test things like HTTP/2, SSL, and so on in our test suite.
So either we have a split in our tests (some use apache, some don't,
which presumably means many tests are still not run on Windows), or this
custom HTTP server eventually grows to do all of those other things.

I can see the utility outside the tests of a quick "let me stand up an
HTTP server to access Git" tool. But even there, I'd be considered with
feature creep as regular users ignore any warnings about its lack of
encryption/robustness, and so on. And it feels like something that could
utilize work already done by others in making a web server. Yes, that's
a new dependency for the tool, but there are a lot of options out there.
Surely one of them is worth building on?

> And while the proposed test helper was not quite complete in that way, and
> while it may have had much of the `git daemon` code that you would love to
> lose, it would have offered an incremental way forward.
> 
> I am afraid that this way forward is now blocked, and we're further away
> from dropping that `git daemon` code you wanted to drop than ever.

I don't see how pushing the same code into an http server helps. If we
could have incrementally improved it there, we could incrementally
improve it in git-daemon, too.

-Peff
