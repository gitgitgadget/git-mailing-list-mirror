Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62721C61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 06:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjCIGlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 01:41:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjCIGlr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 01:41:47 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3728D59431
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 22:41:26 -0800 (PST)
Received: (qmail 6474 invoked by uid 109); 9 Mar 2023 06:41:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Mar 2023 06:41:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28499 invoked by uid 111); 9 Mar 2023 06:41:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Mar 2023 01:41:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 9 Mar 2023 01:41:25 -0500
From:   Jeff King <peff@peff.net>
To:     Paul Smith <paul@mad-scientist.net>
Cc:     git@vger.kernel.org
Subject: Re: Fetching everything in another bare repo
Message-ID: <ZAl/lQMhaQ54BDXN@coredump.intra.peff.net>
References: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6215dde710670fdf0da3ba0549429eaa32db257b.camel@mad-scientist.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 08, 2023 at 05:39:07PM -0500, Paul Smith wrote:

> I have a tool that wants to preserve every commit and never garbage
> collect (there are references that need to be maintained to older
> commits/branches that have been deleted).  This tool keeps its own bare
> clone, and disables all GC and maintenance on it.

OK. It's not clear to me if this archive repo retains the old
references, or if it simply has a bunch of unreachable objects.
That distinction will matter below.

> Unfortunately a month or so ago, by accident someone re-cloned the
> primary copy of the repo that everyone else uses as this bare clone,
> which lost the old history.

Oops. I take it from this that the repository _doesn't_ have all of the
references.  It just has unreachable objects.

Which makes sense. Git cannot store "foo/bar" if "foo" still exists, so
you'd eventually hit such a problem if you tried to keep all of the old
references.

> So now what I want to do is fetch the old data into the current bare
> clone (since the old clone doesn't have the newest stuff).  And, I need
> to be sure that all commits are pulled, and kept, and nothing is
> cleaned up.  I would also like any deleted branches to re-appear, but I
> don't want to change the location of any existing branches in the new
> repo.
> 
> Is it sufficient to run something like this:
> 
>   git fetch --no-auto-maintenance --no-auto-gc <path-to-old-clone>

That wouldn't grab the unreachable objects from the old clone, though
(again, assuming it has some that you care about).

I think you probably want to treat the objects and references
separately. It's safe to just copy all of the objects and packfiles from
the old clone into the new one. You'll have duplicates, but you should
be able to de-dup and get a single packfile with:

  git repack -ad --keep-unreachable

And then you can do any ref updates in the new repository (since it now
has all objects from both). You might want something like:

  # get the list of refs in both repositories
  git -C old-repo for-each-ref --format='%(refname)' >old
  git -C new-repo for-each-ref --format='%(refname)' >new

  # now find the refs that are only in the old one; for-each-ref
  # output is sorted, so we can just use comm
  comm -23 old new >missing-refs

  # now generate and apply commands to update those refs. You could
  # probably also use fetch here, but this is faster and we know we have
  # all of the objects.
  xargs git -C old-repo \
	for-each-repo --format='create %(refname) %(objectname)' \
	<missing-refs |
  git update-ref --stdin

(caveat executor; I just typed this into my email and didn't test it, so
there may be typos or small issues).

-Peff
