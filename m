Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585001F404
	for <e@80x24.org>; Sat, 10 Feb 2018 12:34:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750942AbeBJMe1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Feb 2018 07:34:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:48104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750832AbeBJMe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Feb 2018 07:34:26 -0500
Received: (qmail 25872 invoked by uid 109); 10 Feb 2018 12:34:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 10 Feb 2018 12:34:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30785 invoked by uid 111); 10 Feb 2018 12:35:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 10 Feb 2018 07:35:10 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Feb 2018 07:34:24 -0500
Date:   Sat, 10 Feb 2018 07:34:24 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] fsck: Check HEAD of other worktrees as well
Message-ID: <20180210123424.GC21843@sigill.intra.peff.net>
References: <20180209231330.4457-1-newren@gmail.com>
 <20180209231330.4457-4-newren@gmail.com>
 <20180210095952.GA9035@ash>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180210095952.GA9035@ash>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Feb 10, 2018 at 04:59:52PM +0700, Duy Nguyen wrote:

> On Fri, Feb 09, 2018 at 03:13:30PM -0800, Elijah Newren wrote:
> > This takes advantage of the fact that "worktrees/$WORKTREE/HEAD" will
> > currently resolve as a ref, which may not be true in the future with
> > different ref backends.  I don't think it locks us in to supporting
> > resolving other worktree HEADs with this syntax, as I view the
> > user-visible error message as more of a pointer to a pathname that the
> > user will need to fix.  If the underlying ref storage changes, naturally
> > both this code and the hint may need to change to match.
> 
> I'm leaning more about something like this patch below (which does not
> even build, just to demonstrate). A couple points:
> 
> - Instead of doing the hacky refs worktrees/foo/HEAD, we get the
>   correct ref store for each worktree
> - We have an API for getting all (non-broken) worktrees. I realize for
>   fsck, we may even want to examine semi-broken worktrees as well, but
>   get_worktrees() can take a flag to accomplish that if needed.
> - As you can see, I print %p from the ref store instead of something
>   human friendly. This is something I was stuck at last time. I need
>   better ref store description (or even the worktree name)

Yeah, I think this is the right approach. We know about worktrees
internally, and we should be able to iterate over their ref stores, even
if we have no way to succinctly name the resulting ref.

> - This ref_name() function makes me think if we should have an
>   extended sha1 syntax for accessing per-worktree refs from a
>   different worktree, something like HEAD@{worktree:foo} to resolve to
>   worktrees/foo/HEAD. Then we have a better description here that can
>   actually be used from command line, as a regular ref, if needed.

Yeah, I agree this would be very useful. I peeked at how bad it would be
to hanlde this. The parsing is pretty easy in get_oid_basic(), but you'd
have to plumb through the ref_store in quite a few places:

 - interpret_nth_prior_checkout() would probably want to use the
   worktree's HEAD (for "@{worktree:foo}@{-1}")

 - dwim_ref() would need to know about the ref store

 - that implies that substitute_branch_name() knows about it, too

So it may turn into a big job. But I think it's moving in the right
direction. And it may not be the end of the world if all features do not
work from day one (e.g., if HEAD@{worktree:foo} works, but
HEAD@{worktree:foo}@{upstream} does not yet, with plans to eventually
make that work).

-Peff
