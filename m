Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B46C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 15:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236963AbiHEPZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiHEPZp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 11:25:45 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6BC65DF
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 08:25:41 -0700 (PDT)
Received: (qmail 15135 invoked by uid 109); 5 Aug 2022 15:25:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Aug 2022 15:25:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32252 invoked by uid 111); 5 Aug 2022 15:25:40 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Aug 2022 11:25:40 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Aug 2022 11:25:40 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Noneman <emily.noneman@gmail.com>,
        Paul Horn <git@knutwalker.engineer>
Subject: Re: [PATCH] revision.c: set-up "index_state.repo", don't segfault in
 pack-objects
Message-ID: <Yu02dOo4G8sy8tI6@coredump.intra.peff.net>
References: <CAKvVO18RVye=PkBRv=trj2GHh8ccGKL5j0mMq2eHQ1SX=wsr8A@mail.gmail.com>
 <patch-1.1-3ff17707481-20220805T141816Z-avarab@gmail.com>
 <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6299f8a-f75a-0e96-a6a6-55a7280584bf@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 05, 2022 at 10:48:43AM -0400, Derrick Stolee wrote:

> On 8/5/2022 10:24 AM, Ævar Arnfjörð Bjarmason wrote:
> > Narrowly fix a segfault that's been reported against pack-objects at
> > [1] and [2].
> > 
> > This fixes a segfault in "git pack-objects", see a reports at [1] and
> > [2]. In that case we'd go through the add_index_objects_to_pending()
> > codepath being modified here, and eventually call into
> > new_untracked_cache().
> > 
> > We'd then segfault in new_untracked_cache_flags() as we tried to use a
> > NULL "repo" extracted from the "struct index_state".
> 
> >  		struct worktree *wt = *p;
> > -		struct index_state istate = { NULL };
> > +		struct index_state istate = { .repo = revs->repo };
>   
> Thanks for the fix. It is definitely narrow to this particular
> stack trace.
> 
> It is rare that we create an index that is not 'the_index' in
> this way. However, there are similar { NULL } initializers that
> could be cleaned up in these files:
> 
>  * apply.c
>  * merge-recursive.c
>  * builtin/stash.c
>  * builtin/worktree.c
> 
> Of course, delay these for a follow-up since these uses are
> not causing segfaults in the wild.

We did have another similar segfault recently:

  https://lore.kernel.org/git/YtrdPguYs3a3xekv@kitenet.net/

It's not quite the same case, but I think there's some overlap, and the
reason Ævar couldn't reproduce is that Martin's patch in that thread has
already fixed this case, too.

Using git v2.37.1, I can get a segfault with a backtrace similar to
Emily's by running:

  git init repo
  cd repo
  git commit --allow-empty -m base

  git config core.untrackedCache true
  git worktree add at
  rm .git/worktrees/wt/index

  git gc

And applying the patch from this thread does make it go away. But
likewise for cherry-picking 4447d4129d (read-cache: make `do_read_index()`
always set up `istate->repo`, 2022-07-22), which is already in "master".

Of the two patches, I think 4447d4129d is the better approach. The
assumption in the code seems to be that do_read_index() (and thus
read_index_from(), etc) will set up istate->repo. That patch fixes a
corner case where we failed to do so. And with that fix, there's no need
for the callers to set things up ahead of time. So it covers all of
those initializers you mentioned.

Emily, Paul: I'm 99% sure this will be the case given my reproduction
above, but if you could try reproducing the problem with the current tip
of "master" from git.git, that would confirm the findings.

-Peff
