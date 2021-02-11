Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DCCC433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 11:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A63B64DCF
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 11:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbhBKLNm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 06:13:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:57598 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhBKLLG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 06:11:06 -0500
Received: (qmail 5297 invoked by uid 109); 11 Feb 2021 11:10:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 11 Feb 2021 11:10:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31999 invoked by uid 111); 11 Feb 2021 11:10:11 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 11 Feb 2021 06:10:11 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 11 Feb 2021 06:10:10 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] reflog expire --stale-fix: be generous about missing
 objects
Message-ID: <YCUQkqXNXFzBs7aA@coredump.intra.peff.net>
References: <pull.873.git.1612973499110.gitgitgadget@gmail.com>
 <xmqqy2fv1x98.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2fv1x98.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 12:30:27PM -0800, Junio C Hamano wrote:

> I appreciate an effort of making it looser and less likely to get in
> trouble when running in a corrupt repository, but --stale-fix is a
> bit special and should probably be removed.
> 
> The only reason the option was added was because we needed to have
> an easy way to recover from a specific kind of reflog corruption
> that would have resulted by a (then known) bug in "git reflog" in
> the released version of Git that came immediately before the version
> of Git that added the "fix" option, while the root cause of the
> corruption got fixed.
> 
> Back when 1389d9dd (reflog expire --fix-stale, 2007-01-06) was
> written, it was very useful to have a way to recover from the
> corruption likely to have happened with the version of Git that came
> before it.  But it no longer is relevant after this many years.
> There may be other ways to break the reflog entries, but --stale-fix
> was never designed to deal with anything but a specific way the
> reflog gets corrupted (namely, by the old version of Git that
> corrupted reflog in a specific way), so keeping it would not be very
> useful.

FWIW, I have used --stale-fix for cases where a repo's reflog was
"corrupted" by its alternate pruning objects.

E.g., if you do something like this:

  git clone -s orig.git new.git

you're now at risk of "git gc" in orig.git corrupting new.git, because
its reachability check doesn't know anything about those refs. You can
mitigate that by keeping a copy of new.git's refs in orig.git. Something
like:

  git -C orig.git fetch ../new.git refs/*:refs/preserve/*
  git -C orig.git gc

But that doesn't know about reflogs at all! It will still corrupt them
(but only sometimes; depending how often you do that fetch, you might
catch the same values in orig.git's reflog).

Possibly the correct answer here is "turn off reflogs in new.git", but
they are sometimes useful, and things _mostly_ work (for history that
doesn't rewind, or where the rewound bits are specific to new.git). So
it's useful to be able to run something like "reflog expire --stale-fix"
to clear out the occasional problem.

(A careful reader will note that objects mentioned only in the index
have a similar problem; but again, those tend to be local to new.git,
and don't exist at all in a server context).

-Peff
