Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 286E7C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 07:43:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKAHnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 03:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiKAHnB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 03:43:01 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCC211837C
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 00:43:00 -0700 (PDT)
Received: (qmail 4810 invoked by uid 109); 1 Nov 2022 07:43:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Nov 2022 07:43:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20353 invoked by uid 111); 1 Nov 2022 07:43:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Nov 2022 03:43:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Nov 2022 03:42:59 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Message-ID: <Y2DOA7uYfkFveAU9@coredump.intra.peff.net>
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
 <xmqq5yfze0lc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5yfze0lc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 31, 2022 at 09:54:23PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It is unclear as to _why_, but under certain circumstances the warning
> > about credentials being passed as part of the URL seems to be swallowed
> > by the `git remote-https` helper in the Windows jobs of Git's CI builds.
> >
> > Since it is not actually important how many times Git prints the
> > warning/error message, as long as it prints it at least once, ...
> 
> Sorry, but I do not quite see the value of keeping the test to
> expect success in a weakend form.  If we think we are emitting three
> warnings, whether we do so by mistake or by design, and some of them
> are lost and not shown for an unknown reason, is there a guarantee
> that at least one would survive?  And when all three are lost, even
> the test in the weakened form would fail and stop the CI builds, no?

Without understanding the cause of the loss, I agree that things are a
little hand-wavy. But the assumption _does_ seem to hold that we
consistently produce at least one (presumably from the parent
clone/fetch/push process). And if we can rely on that, there's value in
the tests asserting that the message was shown to the user at least
once.

> If we do not know why we are losing some messages, and if we do not
> have resources to track down why, that is perfectly fine.  Fixes can
> be prioritised.  But wouldn't test_expect_failure be a better way to
> express "we think we ought to get 3 but for some reason we may not
> get all of them and we haven't figured it out"?

Marking it as expect_failure throws out the main point of the test,
though, which is that the user sees _some_ message (and that the "die"
form aborts the operation).

It might make sense to add a separate test in the meantime that
documents the "oops, we get the wrong number" sometimes state (and
eventually, if fixed, that could be folded back into the main test for
efficiency / simplicity).

-Peff
