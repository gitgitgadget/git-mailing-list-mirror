Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D377CC6FD1C
	for <git@archiver.kernel.org>; Sat, 11 Mar 2023 14:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCKOzS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Mar 2023 09:55:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjCKOzQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2023 09:55:16 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080C13C29
        for <git@vger.kernel.org>; Sat, 11 Mar 2023 06:55:14 -0800 (PST)
Received: (qmail 2219 invoked by uid 109); 11 Mar 2023 14:55:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 11 Mar 2023 14:55:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22287 invoked by uid 111); 11 Mar 2023 14:55:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 11 Mar 2023 09:55:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 11 Mar 2023 09:55:13 -0500
From:   Jeff King <peff@peff.net>
To:     Sebastian Tennant <sdt@sebyte.me>
Cc:     git@vger.kernel.org
Subject: Re: How to mirror and augment a git repository
Message-ID: <ZAyWUS27M+degQxj@coredump.intra.peff.net>
References: <87ilfgemkb.fsf@sebyte.me>
 <ZAWfkkmrPUqNmrtu@coredump.intra.peff.net>
 <87fsaf9oa8.fsf@sebyte.me>
 <ZAlOnTovp0ncZopf@coredump.intra.peff.net>
 <87o7oz7eer.fsf@sebyte.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o7oz7eer.fsf@sebyte.me>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 11, 2023 at 10:47:40AM +0000, Sebastian Tennant wrote:

> Here are the actions I'm taking to configure the mirror:
> 
>  $ git clone --bare https://url.of/project.git
>  $ cd project.git
>  $ git remote rename origin upstream
>  $ git config remote.upstream.fetch\
>        '+refs/heads/*:refs/remotes/upstream/*'
>  $ git fetch upstream --prune
> 
> At this point there are no refs under refs/heads (and very many under
> refs/remotes/upstream).

You'd have refs under refs/heads at this point. They were created when
you did the original bare clone (since bare clones fetch all heads to
start with, though they don't set up a refspec).

And they won't be deleted by the pruning fetch, of course, because you
configured the refspec to limit itself to refs/remotes/upstream on the
local side.

If you don't want them (and I think you don't), you can just initialize
the repository directly, and then fetch, like:

  git init --bare project.git
  cd project.git
  git config remote.upstream.url https://url.of/project.git
  [and then configure refspec and fetch --prune as before]

> Here are the actions I'm then taking on a client:
> 
>  $ git clone --bare mirror:path/to/project.git
>  $ cd project.git
>  $ git remote rename origin mirror
>  $ git config remote.mirror.fetch\
>        '+refs/heads/*:refs/remotes/mirror/*'

This bare clone will do the same thing. So you'll end up with a copy of
all of the heads created in the earlier step. Worse, they won't be the
current state of those branches, but stale ones left from when you
created the mirror repo.

I think you want _two_ refspecs in the clients:

  - one to fetch the client-local branches stored on the mirror. That
    is:

      +refs/heads/*:refs/remotes/origin/*

    and those branches just appear as normal.

  - one to fetch the mirrored upstream branches from the special
    namespace on the mirror. That one is:

      +refs/remotes/upstream/*:refs/remotes/upstream/*

> At this point, both mirror and client have a normal fetch refspec,
> i.e. no additional refspec has been added to the client, yet when I
> run:
> 
>  $ git fetch mirror --prune
> 
> on the client, all the refs on mirror under refs/remotes/upstream are
> fetched and placed under refs/remotes/mirror on the client.

The refspec you showed above for the client is fetching from
refs/heads/* on the remote side. So it will never look at
refs/remotes/upstream from the mirror.

> My understanding of refspec:
> 
>  +refs/heads/*:refs/remotes/mirror/*
> 
> is "fetch only those refs under refs/heads and place them under
> refs/remotes/mirror", which in this case should mean that no refs are
> fetched (since there are none on mirror under refs/heads).

Your understanding is right, but the gotcha of how "clone --bare" works
is making things more confusing.

> What's going on here that I'm just not getting?
> 
> If I add the additional refspec to the client:
> 
>  $ git config --add remote.mirror.fetch\
>    '+refs/remotes/upstream/*:refs/remotes/upstream/*'
> 
> and fetch once more, I end up with all the refs already under
> refs/remotes/mirror duplicated under refs/remotes/upstream.

Right. Those are the copies you actually _want_ to have. The ones pulled
from refs/heads/* aren't. You'd expect that to be empty to start, and
then eventually it would be populated by pushes from local clients.

-Peff
