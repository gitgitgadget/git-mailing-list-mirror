Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0271F404
	for <e@80x24.org>; Wed,  7 Feb 2018 18:17:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754108AbeBGSRI (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 13:17:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:43974 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753794AbeBGSRI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 13:17:08 -0500
Received: (qmail 22376 invoked by uid 109); 7 Feb 2018 18:17:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 07 Feb 2018 18:17:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 650 invoked by uid 111); 7 Feb 2018 18:17:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 07 Feb 2018 13:17:50 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 07 Feb 2018 13:17:06 -0500
Date:   Wed, 7 Feb 2018 13:17:06 -0500
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>
Subject: Re: BUG: fetch in certain repo always gives "did not send all
 necessary objects"
Message-ID: <20180207181706.GA4227@sigill.intra.peff.net>
References: <CABPp-BHVD19ZoAmWhQd9aN-v+qB7Ryq9Z-wobLYtJf_b6RWgzQ@mail.gmail.com>
 <CAGZ79kYstN9ATPGKZjnk-hJ6jRsx9Oz0b2hQ5cTiqVqMNDCsyA@mail.gmail.com>
 <CABPp-BHkLLrJDTQwHTYpqC0Cg7Wv_wDr14Fq_LXneg+OzzRngg@mail.gmail.com>
 <20180207132157.GB16018@sigill.intra.peff.net>
 <CABPp-BH0rSELVJV11MJM=KFU2jAEuhVTzUUBskghgku+y_ozDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BH0rSELVJV11MJM=KFU2jAEuhVTzUUBskghgku+y_ozDQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 07, 2018 at 09:25:42AM -0800, Elijah Newren wrote:

> > So other_head_refs knows that it's looking at the worktrees. And it
> > passes the alternate ref-store to refs_head_ref(), with "add_one_ref" as
> > the callback. But the knowledge that we're not talking about the real
> > "HEAD" is lost as we cross that callback boundary. We'd need to either
> > add another parameter to the callback, or have some way of talking about
> > "HEAD in this worktree" as a refname (which AFAIK we don't have).
> 
> Can we use "worktrees/${WORKTREE}/HEAD"?  It already satisfies all the
> necessary rev-parse rules...

True, but it's mostly an accident that it works. And once we have ref
backends besides the filesystem, it will probably stop working.

I think there was discussion at some point of embedding worktree refs
into the normal ref namespace, but I don't know what came of it (it's
not a feature I've followed very closely).

> (And on a slight tangent...do we want to start disallowing the
> creation of branches/tags whose name starts with "worktrees/",
> "refs/", "hooks/", or other paths that exists under gitdir?  Making a
> branch named "refs/heads/foo" so that it fully-qualifies as
> "refs/heads/refs/heads/foo" is always fun)

We recently taught the porcelain to disallow a branch named "HEAD".
Though I think there are actually two related problems with different
solutions. One is saying something like:

  git checkout -b HEAD

or:

  git checkout -b refs/heads/foo

both of which will not do what you want, and leave you with a
funnily-named branch in the ref namespace.

But that's separate from the fact that:

  git rev-parse info/refs

will look at a file that is not a ref at all. Long-term I think the
solution is storage formats that don't mingle with other files. But we
could probably teach even the files-backend that any ref at the
top-level is supposed to be either in refs/, or to consist only of
"[A-Z_]".

-Peff
