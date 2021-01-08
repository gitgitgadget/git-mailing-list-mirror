Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D39C433DB
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6012822248
	for <git@archiver.kernel.org>; Fri,  8 Jan 2021 09:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbhAHJLJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 04:11:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:49708 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727478AbhAHJLH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 04:11:07 -0500
Received: (qmail 29883 invoked by uid 109); 8 Jan 2021 09:10:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 08 Jan 2021 09:10:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12554 invoked by uid 111); 8 Jan 2021 09:10:29 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 08 Jan 2021 04:10:29 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 8 Jan 2021 04:10:26 -0500
From:   Jeff King <peff@peff.net>
To:     Jon Sagotsky <sagotsky@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Feature request - git add --patch should have an option to
 discard or drop a hunk Inbox
Message-ID: <X/ghgg+IdZYri1KV@coredump.intra.peff.net>
References: <CAJamm=+Z=88G6cH3DRkttGQkrf9tng310+p=4cKiy-GvdCG3zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJamm=+Z=88G6cH3DRkttGQkrf9tng310+p=4cKiy-GvdCG3zg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 07, 2021 at 11:43:45AM -0500, Jon Sagotsky wrote:

> I frequently make changes to a number of files.  I use `git add -p` to
> select a number of changes and wrap them up in a commit.  Then I run
> it again to build another commit.  Wash, rinse, repeat.
> 
> Sometimes I make a change I don't intend to keep.  Maybe it's a typo,
> or some debug code, or my linter does something naughty.  As
> described, I have to skip that hunk once per commit I'm building.
> Usually this is merely inconvenient, but each pass through `git add
> -p` runs the risk of me mistakenly adding unintended changes to my
> commit.

I do something similar and have run into the same problem. There's an
old discussion here going into some ideas:

  https://lore.kernel.org/git/EE89F0A1-1C07-4597-B654-035F657AD09F@me.com/

The interesting bits are I think:

  - some tools let you do this already (magit was mentioned there, and
    I'd expect vim plugins like fugitive can probably do the same; tig
    can also do so from its "stage" interface)

  - it probably wouldn't be _too_ hard to implement, because we already
    drive those actions from the same code that is invoked by "add -p"
    and "git checkout -p"; the difference is just which program we feed
    the hunks to.

  - in the most general form of the tool, it would let you take a pass
    through the hunks and annotating them. The simple common form is two
    annotations: stage these ones, discard those ones. There may be room
    for a more generalized tool, or it may just be over-complicating
    things.

    The generalized form probably shouldn't be "add -p". The simplified
    one (just adding "discard this hunk from the worktree") could
    perhaps be, though it does feel a little weird for "git add" to
    modify working tree files.

-Peff
