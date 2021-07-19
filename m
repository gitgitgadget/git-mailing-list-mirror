Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E34AC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43DF161029
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 10:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbhGSKLy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 06:11:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:53476 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235621AbhGSKLx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 06:11:53 -0400
Received: (qmail 30947 invoked by uid 109); 19 Jul 2021 10:52:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jul 2021 10:52:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12159 invoked by uid 111); 19 Jul 2021 10:52:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jul 2021 06:52:34 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 19 Jul 2021 06:52:32 -0400
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #03; Tue, 13)
Message-ID: <YPVZcA2z9cmTe5D5@coredump.intra.peff.net>
References: <xmqqmtqpzosf.fsf@gitster.g>
 <YPUrSB8+zEur+ZBt@ncase>
 <YPU48uSCxXbsjvGW@coredump.intra.peff.net>
 <YPVW50Q6oyTxQ4D4@ncase>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YPVW50Q6oyTxQ4D4@ncase>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 19, 2021 at 12:41:43PM +0200, Patrick Steinhardt wrote:

> > TBH, I had never really considered using TEST_OUTPUT_DIRECTORY for this
> > (--root predates it, and was written explicitly for the tmpfs case). But
> > I also think --root is more convenient:
> > 
> >   - "make test" will run in the tmpfs for speed, but "./t1234-foo.sh -i"
> >     will run locally, which makes it easy to "cd" in to inspect the
> >     result
> > 
> >   - likewise, I find accessing the results in t/test-results/*.out a
> >     little more convenient
> > 
> > But all of that is preference. I don't think you're wrong to use
> > TEST_OUTPUT_DIRECTORY this way, but the above points might be
> > interesting to you.
> 
> It is, thanks a lot for the hint. But given your first point about
> direct execution, this in fact makes me want TEST_OUTPUT_DIRECTORY in
> contrast to `--root=/path/to/tmpfs`: especially in the context of perf
> tests, I never run all of them together given that it takes such a long
> time. So I instead either run them directly or via the `./run` script,
> and in both cases I definitely want to have them in tmpfs given that
> there's a lot of disk churn if you're using biggish repos.

I generally use "./run", too. It will use GIT_TEST_OPTS under the hood
(which I actually find a little odd, just because it kicks in my usual
"-x --verbose-log", which I don't actually care about for the perf
tests).

You'd have to specify it manually for single-script runs, though. I
usually avoid single-script runs (and instead use "./run") because I try
to make sure each run is associated with a commit. Otherwise, it's easy
to confuse yourself about what the state of "this tree" was when it ran
(it does not even build fresh with GIT_PERF_MAKE_OPTS! So many times
I've accidentally tested a -O0 build from the current tree and wondered
why it was so slow).

-Peff
