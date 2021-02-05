Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0408C433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 13:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED9064FBF
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 13:48:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhBENrv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 08:47:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:51558 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231404AbhBENpF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 08:45:05 -0500
Received: (qmail 18106 invoked by uid 109); 5 Feb 2021 13:44:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Feb 2021 13:44:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13745 invoked by uid 111); 5 Feb 2021 13:44:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Feb 2021 08:44:17 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Feb 2021 08:44:17 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH] usage: trace2 BUG() invocations
Message-ID: <YB1LsacCd4au0P5z@coredump.intra.peff.net>
References: <20210205054914.104640-1-jonathantanmy@google.com>
 <xmqq1rdv2g3q.fsf@gitster.c.googlers.com>
 <YB0JYPLMC+hbcxCa@coredump.intra.peff.net>
 <1051d473-5d1b-1155-8d9e-93eb2cc349f0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1051d473-5d1b-1155-8d9e-93eb2cc349f0@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 05, 2021 at 07:51:09AM -0500, Derrick Stolee wrote:

> > We've had a similar problem on the die() side in the past, and solved it
> > with a recursion flag. But note it gets a bit non-trivial in the face of
> > threads. There's some discussion in 1ece66bc9e (run-command: use
> > thread-aware die_is_recursing routine, 2013-04-16).
> > 
> > That commit talks about a case where "die()" in a thread takes down the
> > thread but not the whole process. That wouldn't be true here (we'd
> > expect BUG() to take everything down). So a single counter might be OK
> > in practice, though I suspect we could trigger the problem racily
> > Likewise this is probably a lurking problem when other threaded code
> > calls die(), but we just don't do that often enough for anybody to have
> > noticed.
> 
> Would a simple "BUG() has been called" static suffice?

Yeah, perhaps. That's what we started with for die(), and what we
replaced in the commit I mentioned when it became a problem with
threads. But we might be able to get away with it here.

> so the trace2 call would want to be as close to the abort as
> possible to avoid a silent failure. So, in the patch...
> [...]
> We would want this vreportf() to be before the call to
> trace2_cmd_error_va(), right?

Yeah, that is definitely preferable. The die-is-recursing logic is bad
for that, and it's annoying. I think it dies with "woah, I'm recursing"
without printing anything, because the recursion happens in the handler
that does the printing. And I suspect nobody bothered to improve it
because the whole point is that this recursing case shouldn't come up.
But if it's easy to make it do the right thing for the BUG() case (and I
think it is), we might as well.

-Peff
