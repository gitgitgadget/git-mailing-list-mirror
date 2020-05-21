Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0050C433E1
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:57:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3D8F207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 18:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729996AbgEUS5z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 14:57:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:53852 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729092AbgEUS5z (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 14:57:55 -0400
Received: (qmail 15097 invoked by uid 109); 21 May 2020 18:57:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 21 May 2020 18:57:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30169 invoked by uid 111); 21 May 2020 18:57:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 21 May 2020 14:57:55 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 21 May 2020 14:57:53 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Anyone know what is creating commits with bogus dates?
Message-ID: <20200521185753.GB1308489@coredump.intra.peff.net>
References: <CABPp-BFfa6q96qMUN07Dq3di6d3WuUzhyktBytbX=FGgarXgjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFfa6q96qMUN07Dq3di6d3WuUzhyktBytbX=FGgarXgjg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 21, 2020 at 10:49:17AM -0700, Elijah Newren wrote:

> I wanted to report that we seem to have a number of repos in the wild
> with bogus (as in "won't even parse") dates.
> 
> I first discovered such a repository in the wild a while ago with
> rails.git.  It has a commit with a recorded timezone of "+051800" for
> both author and committer.  Everything else about the commit looks
> fine.  See https://github.com/rails/rails/commit/4cf94979c9f4d6683c9338d694d5eb3106a4e734.
> 
> Some google searches at the time turned up a few other examples, all
> with the same "+051800" issue.  I put a special workaround for it into
> filter-repo because I figured it was slightly prominent but probably
> limited to that special timezone.  The fact that it was six digits but
> the last two were zeros made it seem not quite as bad as it could be.

I can't remember the source of the bug, but we've had a workaround in
GitHub's incoming fsck checks to allow 6-digit zones like this since
August 2011. I'm almost certain that it came up because of that
rails/rails commit, but I don't remember the culprit implementation. I'm
sure we would have dug it up and fixed it at the time.

Sadly our commit message for the fsck tweak gives no further details,
nor can I dig up anything out of issues/etc.

I _think_ it wasn't GitHub/grit which did this (the 0-prefixed tree
modes you might come across are, though). I couldn't find any mention of
the fix there, at least. I'd suspect perhaps libgit2, but I also
couldn't find any fix.

But I think it would be safe to assume the bug is long-since fixed, and
it's nice if you can be a bit more lenient on the parsing for historical
issues like this. Arguably fast-export ought to be normalizing it to
something syntactically correct (just like we probably do with other
unparsable dates), though I guess you could argue that a filter might
want to see the broken form in order to fix it in a custom way.

-Peff
