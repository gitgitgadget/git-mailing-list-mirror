Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914CF1F404
	for <e@80x24.org>; Tue, 14 Aug 2018 21:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728348AbeHOAge (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 20:36:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:55416 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728080AbeHOAge (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 20:36:34 -0400
Received: (qmail 7190 invoked by uid 109); 14 Aug 2018 21:47:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Aug 2018 21:47:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26469 invoked by uid 111); 14 Aug 2018 21:47:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 14 Aug 2018 17:47:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Aug 2018 17:47:24 -0400
Date:   Tue, 14 Aug 2018 17:47:24 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Syncing HEAD
Message-ID: <20180814214723.GA667@sigill.intra.peff.net>
References: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
 <20180814210616.GA32367@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180814210616.GA32367@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 05:06:16PM -0400, Jeff King wrote:

> On Tue, Aug 14, 2018 at 10:09:37PM +0200, Christian Couder wrote:
> 
> > When cloning with --mirror, the clone gets its HEAD initialized with
> > the value HEAD has in its origin remote. After that if HEAD changes in
> > origin there is no simple way to sync HEAD at the same time as the
> > refs are synced.
> > 
> > It looks like the simplest way to sync HEAD is:
> > 
> > 1) git remote show origin
> > 2) parse "HEAD branch: XXX" from the output of the above command
> > 3) git symbolic-ref HEAD refs/heads/XXX
> 
> How about:
> 
>   git remote set-head origin -a
> 
> ?

Reading your message again, I see you actually care less about the
refs/remote placeholder and more about the actual HEAD in a bare repo.

In which case "git remote" isn't going to help, though its underlying
code has the algorithm you would want.

> One tricky thing is that the name "refs/remotes/<remote>/HEAD" is only
> special by convention, and that convention is known on the writing side
> only by git-clone and git-remote. So obviously:

And so here the convention is simpler, because we're talking about the
main HEAD. But we still have know if you want to do that, and not update
some refs/remotes/ symref in a bare repo.

So all of this really implies to me that you want to be able to say
"take this symref on the other side and update this one on the local
side". I.e., some way to tell a refspec "don't update the value, update
the symref destination". So imagine we made "~" the magic character for
"just the symrefs" (I picked that because it's not allowed in a
refname).

Then you could do what you want with:

  git config --add remote.origin.fetch ~HEAD:HEAD

and these two would be the same:

  git remote set-head origin -a
  git fetch origin ~HEAD:refs/remotes/origin/HEAD

And it would allow more exotic things, too, like:

  # always update the remote notion of HEAD on every fetch
  git config --add remote.origin.fetch ~HEAD:refs/remotes/origin/HEAD

  # update a non-HEAD symref we track for our own purposes
  git fetch origin ~refs/tags/LATEST:refs/tags/LATEST

  # or the same thing but using the usual refspec "dst defaults to src"
  # rule and dwim lookup magic
  git fetch origin ~LATEST

In protocol v0 we don't get symref reports from the other side over the
git protocol (except for HEAD), but we could use the same logic we use
for determining HEAD for older versions of Git: find a ref that points
to the same tip. Though I would say that unlike the existing code in
guess_remote_head(), we'd probably want to treat an ambiguity as an
error, and not just default to refs/heads/master.

-Peff
