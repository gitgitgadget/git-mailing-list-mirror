Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43B1CC433DF
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 20:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23BC3206F6
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 20:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728889AbgGGUyU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 16:54:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:51672 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgGGUyU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 16:54:20 -0400
Received: (qmail 22946 invoked by uid 109); 7 Jul 2020 20:54:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jul 2020 20:54:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31601 invoked by uid 111); 7 Jul 2020 20:54:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 07 Jul 2020 16:54:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 7 Jul 2020 16:54:18 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH] Make some commit hashes in tests reproducible
Message-ID: <20200707205418.GB1396940@coredump.intra.peff.net>
References: <pull.816.git.git.1594149804313.gitgitgadget@gmail.com>
 <xmqqfta33y0m.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfta33y0m.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 07, 2020 at 12:50:33PM -0700, Junio C Hamano wrote:

> "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
> > From: Han-Wen Nienhuys <hanwen@google.com>
> >
> > Adds test_tick to t5801-remote-helpers.sh and t3203-branch-output.sh
> 
> That can be read from the patch.  Also the subject tells us a half
> of what you want to achieve with this change (by the way, your
> subject is malformatted and lacks the <area>: prefix; perhaps
> "[PATCH] tests: make commit object names reproducible" or something),
> but the readers are left hanging without knowing what motivated the
> change.  Do any test pieces in these scripts change their behaviour
> based on what exact object names are assigned to them, making them
> flaky and hard to test, and if so which one and in what way?

I agree that more discussion would be nice.

But I kind of wonder if we should be aiming for more determinism in
general, just to make debugging and reproduction simpler.

I.e., rather than pointing to _these_ tests, I think we could make an
argument for setting up a known timestamp in the test environment.
test_tick would continue to tick forward as usual, but for any tests
that don't use it, they'd by default get a deterministic outcome.

Something like this:

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 618a7c8d5b..d8adf5a199 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -441,15 +441,18 @@ TEST_AUTHOR_LOCALNAME=author
 TEST_AUTHOR_DOMAIN=example.com
 GIT_AUTHOR_EMAIL=${TEST_AUTHOR_LOCALNAME}@${TEST_AUTHOR_DOMAIN}
 GIT_AUTHOR_NAME='A U Thor'
+GIT_AUTHOR_DATE='1112911993 -0700'
 TEST_COMMITTER_LOCALNAME=committer
 TEST_COMMITTER_DOMAIN=example.com
 GIT_COMMITTER_EMAIL=${TEST_COMMITTER_LOCALNAME}@${TEST_COMMITTER_DOMAIN}
 GIT_COMMITTER_NAME='C O Mitter'
+GIT_COMMITTER_DATE='1112911993 -0700'
 GIT_MERGE_VERBOSITY=5
 GIT_MERGE_AUTOEDIT=no
 export GIT_MERGE_VERBOSITY GIT_MERGE_AUTOEDIT
 export GIT_AUTHOR_EMAIL GIT_AUTHOR_NAME
 export GIT_COMMITTER_EMAIL GIT_COMMITTER_NAME
+export GIT_COMMITTER_DATE GIT_AUTHOR_DATE
 export EDITOR
 
 # Tests using GIT_TRACE typically don't want <timestamp> <file>:<line> output

That's using the same start point as test_tick, though really it could
be anything. I've intentionally _not_ called test_tick at the beginning
of each script, because that would throw off all of the scripts that do
use it by one tick (whereas the first test_tick will overwrite these
values).

Trying to devil's advocate against this line of reasoning:

  - using the current timestamp introduces more randomness into the test
    suite, which could uncover problems. I'm somewhat skeptical, as the
    usual outcome I see here is that we realize a test's expected output
    is simply racy, and we remove the raciness by using test_tick

  - using the current timestamp could alert us to problems that occur
    only as the clock ticks forward (e.g., if we had a Y2021 bug, we'd
    notice when the clock rolled forward).

  - some tests may rely on having a "recent" timestamp in commits (e.g.,
    when looking at relative date handling). I think all of the
    relative-time tests already use a specific date, though, because
    otherwise we have too many problems with raciness.

Note that the patch above does seem to cause two tests to fail. One of
them I _suspect_ is a raciness problem (order of commits output changes,
which implies the original was expecting the time to increment between
two commits without running test_tick). And the other looks like some
weird interaction with the perl test harness. I'd be happy to dig into
both if this direction seems sane.

-Peff
