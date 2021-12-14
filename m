Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6E0C433F5
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 16:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235814AbhLNQnk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 11:43:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:51750 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhLNQnj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 11:43:39 -0500
Received: (qmail 14389 invoked by uid 109); 14 Dec 2021 16:43:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 16:43:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26446 invoked by uid 111); 14 Dec 2021 16:43:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 11:43:39 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 11:43:38 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 2/2] test-lib.sh: remove the now-unused
 "test_untraceable" facility
Message-ID: <YbjJuh4dVijL7jw4@coredump.intra.peff.net>
References: <cover-v2-0.2-00000000000-20211201T200801Z-avarab@gmail.com>
 <cover-v3-0.2-00000000000-20211210T100512Z-avarab@gmail.com>
 <patch-v3-2.2-a7fc794e20d-20211210T100512Z-avarab@gmail.com>
 <20211212163207.GA3400@szeder.dev>
 <211212.865yrtbvl1.gmgdl@evledraar.gmail.com>
 <20211212201441.GB3400@szeder.dev>
 <xmqqo85kcp99.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo85kcp99.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 13, 2021 at 10:51:14AM -0800, Junio C Hamano wrote:

> > I don't see any argument pertinent to BASH_XTRACEFD in general in that
> > email, of in favor of its removal in particular, and there are no
> > valid arguments for its removal in earlier emails in this thread
> > either.
> 
> If I am reading Ævar right, the argument is "dash would not be fixed
> with BASH_XTRACEFD, so there needs another way that would work there,
> and if the approach happens to work also for bash, then there is no
> reason to use BASH_XTRACEFD", I think.
> 
> Now, if the way Ævar came up with to help shells with "-x" not to
> contaminate their standard error stream that our test scripts want
> to inspect is worse to write, understand, and maintain, compared to
> the way we have been writing our tests that inspect their standard
> errors, without having to worry about "-x" output thanks to the use
> of BASH_XTRACEFD, it may make a regression to developer
> productivity, but I am not sure if that is the case.

I think the method for handling this in the test scripts _is_ worse to
write, understand, and maintain. The problem to me is less that it's
ugly to workaround (which as you note in this case is not great, but not
_too_ bad), but that it's a subtle friction point that may jump up and
bite any test-writer who does something like:

  (foo && bar) 2>stderr

So my view had always been that BASH_XTRACEFD is the good solution, and
if people want to make "-x" work reliably under other shells, then I
won't stop them. But somewhere along the way Gábor did a bunch of fixes
to get things mostly running, and the use of dash with "-x" got added to
CI, so now it's a de facto requirement (if you care about CI
complaining, which we increasingly do).

Maybe that's OK. We've had fewer incidences of the problem popping up
than I would have expected.

My vision was that we'd leave BASH_XTRACEFD so people using it could
remain oblivious if they chose, but if the ship has sailed via CI, then
that might have less value.

> I think [1/2] of this same series can serve an example of how tests
> must be tweaked to live under the world order without BASH_XTRACEFD?
> Having to set and use a temporary file to capture the standard error
> output and append to it upfront looks uglier than each individual
> test locally capturing the standard error output from a single
> invocation of a helper function, but it does not look _too_ bad to
> me.  Can we find another example to argue for BASH_XTRACEFD, how
> much it makes it easier to write tests that work even under "-x"?

I think the fixes from 571e472dc4 (Merge branch 'sg/test-x', 2018-03-14)
show what had to be done to get where we are today.

-Peff
