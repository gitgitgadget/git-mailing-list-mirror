Return-Path: <SRS0=ksp+=3Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88801C32771
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 05:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5432920716
	for <git@archiver.kernel.org>; Mon, 27 Jan 2020 05:55:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgA0FzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jan 2020 00:55:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:45220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725763AbgA0FzL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jan 2020 00:55:11 -0500
Received: (qmail 31230 invoked by uid 109); 27 Jan 2020 05:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 27 Jan 2020 05:55:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28390 invoked by uid 111); 27 Jan 2020 06:02:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jan 2020 01:02:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jan 2020 00:55:09 -0500
From:   Jeff King <peff@peff.net>
To:     Chris Jerdonek <chris.jerdonek@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: git-clone --single-branch clones objects outside of branch
Message-ID: <20200127055509.GA12108@coredump.intra.peff.net>
References: <CAOTb1wfoMf338VPRYcjAv+EaMYQxKJ=kP6-qMykG-LfxPrWuag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOTb1wfoMf338VPRYcjAv+EaMYQxKJ=kP6-qMykG-LfxPrWuag@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 26, 2020 at 04:39:52AM -0800, Chris Jerdonek wrote:

> However, when I attempted this with a local repo, I found that objects
> located only in branches other than the branch I specified are also
> cloned. Also, this is true even if the remote repo has only loose
> objects (i.e. no pack files). So it doesn't appear to be doing this
> only to avoid creating new files.
> 
> In contrast, git-fetch behaves as expected (including locally).
> git-fetch appears to fetch only objects in the given branch, when a
> branch is specified.

This is the expected outcome, because in your example you're cloning on
the local filesystem. By default that enables some optimizations, one of
which is to hard-link the object files into the destination repository.
That avoids the cost of copying and re-hashing them (which a normal
cross-system clone would do). And it even avoids traversing the objects
to find which are necessary, instead just hard-linking everything.

So with:

> git clone --branch master --single-branch repo1 repo3

You should be able to see with "git for-each-ref" in repo3 that you only
got the "master" branch, but not "dev". But those extra objects are
available to you, because of the hard-links.

If you do:

  git clone --branch master --single-branch --no-local repo1 repo4

then repo4 will not have the objects (we really will send a packfile
across a pipe, just as we would across the network for a cross-system
clone).

> cd repo2
> git init
> git remote add other file:///<path-to-repo1>
> git fetch other master

This one behaves as you expected because git-fetch does not perform the
same optimizations (it wouldn't make as much sense there, as generally
in a fetch we already have most of the objects from the other side
anyway, so hard-linking would just give us duplicates).

-Peff
