Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CCEFC32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1767D2084D
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729080AbgAOTDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:03:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:37206 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728921AbgAOTDX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 14:03:23 -0500
Received: (qmail 18683 invoked by uid 109); 15 Jan 2020 19:03:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 15 Jan 2020 19:03:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32024 invoked by uid 111); 15 Jan 2020 19:09:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 15 Jan 2020 14:09:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 15 Jan 2020 14:03:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/10] built-in add -i/-p: treat SIGPIPE as EOF
Message-ID: <20200115190322.GA4087422@coredump.intra.peff.net>
References: <pull.175.v2.git.1577275020.gitgitgadget@gmail.com>
 <pull.175.v3.git.1578904171.gitgitgadget@gmail.com>
 <5e258a8d2bb271433902b2e44c3a30a988bbf512.1578904171.git.gitgitgadget@gmail.com>
 <20200113170417.GK32750@szeder.dev>
 <20200113183313.GA2087@coredump.intra.peff.net>
 <xmqqblr4k1t0.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblr4k1t0.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 10:32:59AM -0800, Junio C Hamano wrote:

> >>   test_config interactive.diffFilter "cat >/dev/null ; echo too-short" &&
> >> 
> >> made the test reliable, with over 2000 --stress repetitions, and that
> >> with only a single "y" on 'git add's stdin.
> >
> > Yeah, I agree the test should be changed. What you wrote above was my
> > first thought, too, but I think "sed 1d" is actually a more realistic
> > test (and is shorter and one fewer process).
> 
> I am not sure what we are aiming for.  Are we making sure the
> command behaves well in the hands of end users, who may write a
> script that consumes only early parts of the input that is needed
> for its use and stops reading, or are we just aiming to claim "all
> our tests pass"?  I was hoping that we would be doing the former,
> and I would understand if the suggestion were "sed 1q" for that
> exact reason.
> 
> IOW, shouldn't we be fixing the part that drives the external
> process, so that the test "passes" even with such a "broken" filter?

The original motivation for this test (and the code that fixes it) was
diff-so-fancy, which read all of the input but didn't have a 1:1 line
correspondence in the output (IIRC it condensed some particular lines,
like rename from/to into a single line).

And I think most sane filters would end up reading all of the content.
Or a misconfiguration would cause them to read nothing at all.

So something like "sed 1d" is more representative of a real filter. If
we want to test SIGPIPE, then the current one that reads _nothing_ is
the most torturous. But "sed 1q" is neither realistic (if that's what
we're going for) nor the hardest thing we can throw at the code (if
that's what we want).

> > I've been tempted to say that we should just ignore SIGPIPE everywhere,
> > and convert even copious-output programs like git-log to just check for
> > errors (they could probably even just check ferror(stdout) for each
> > commit we output, if we didn't want to touch every printf call).
> 
> Yeah, I share that temptation.

Hmm. My recollection was that you were more of a fan of SIGPIPE than I
am. But if you agree, then maybe the time has come for action. :)

-Peff
