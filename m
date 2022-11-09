Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 741EAC4332F
	for <git@archiver.kernel.org>; Wed,  9 Nov 2022 14:00:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiKIOAt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Nov 2022 09:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiKIOAi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Nov 2022 09:00:38 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92BA25D
        for <git@vger.kernel.org>; Wed,  9 Nov 2022 06:00:35 -0800 (PST)
Received: (qmail 12547 invoked by uid 109); 9 Nov 2022 14:00:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 09 Nov 2022 14:00:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14939 invoked by uid 111); 9 Nov 2022 14:00:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 09 Nov 2022 09:00:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 9 Nov 2022 09:00:33 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: avoid unnecessary builds
Message-ID: <Y2uygXD7R+fsC0as@coredump.intra.peff.net>
References: <pull.1404.git.1667482458622.gitgitgadget@gmail.com>
 <221104.86bkpnzdqi.gmgdl@evledraar.gmail.com>
 <Y2R3vJf1A2KOZwA7@nand.local>
 <Y2SFGmQnx7CXtTEI@coredump.intra.peff.net>
 <oo9ssp5n-6ors-n309-2r2n-3q43rq7pn89q@tzk.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <oo9ssp5n-6ors-n309-2r2n-3q43rq7pn89q@tzk.qr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 10:16:15AM +0100, Johannes Schindelin wrote:

> > As an aside, I wish there was a way to interpret per-repo environment
> > variables in the actual action config.
> 
> There kind of is. "Kind of" because it is not _really_ a per-repo variable
> (those do not exist on GitHub), but there are topics you can set. These
> are relatively free-form labels you can attach to _your_ fork, and these
> labels show up below the "About" section and the link to the home page (if
> any) on the right side of your respository. AFAICT these topics are not
> inherited automatically when forking a repository, which is precisely what
> we want. See
> https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/classifying-your-repository-with-topics
> for more details on that.

Ah, that's very clever, thank you!

For the original problem that motivated me adding ci-config in the first
place, branch selection, I think we could do this:

  if: |
    !contains(join(github.event.repository.topics), 'ci-only-') ||
    contains(github.event.repository.topics, format('ci-only-{0}', github.ref_name))

and then by default we'd continue to build for all pushes, but if you
add ci-only-foo as a repo topic, then we'd build only refs/heads/foo.

I may see if I can work this into our workflow file. Even if we can't
get rid of ci-config for the skip-successful-build feature, this would
still save CPU by dropping even ci-config when the branch should be
skipped entirely.

> > The current ci-config stuff works, but it's pretty horrible because (if
> > I understand correctly) it spins up a VM just to evaluate a glob and say
> > "nope, no CI needed on this branch". So:
> >
> >   1. It's wasteful of resources, compared to a system where the Actions
> >      parser can evaluate a variable.
> 
> Indeed. It might look like the job only takes a few seconds (at least that
> was the argument that got the `ci-config` patch accepted), but that misses
> the queue time, which turns this more into several dozens of seconds, and
> the recorded total duration is much longer than that. In
> https://github.com/gitgitgadget/git/actions/runs/3412982102 for example,
> the `ci-config` job only took 6 seconds, according to the page, but the
> total duration of the build was 6 minutes and 56 seconds.

Yes, but I don't think that's wasting 6 minutes of resources if we're
just sitting in a queue. It may increase the end-to-end latency of
getting the CI result, of course.

>     4. The way `ci-config` is configured is sufficiently "magic" that it
>        only benefits very, very few users, at the price of adding to
>        everybody's build time. To see what I mean, look at
>        https://github.com/gitgitgadget/git/actions/runs/3416084640/jobs/5685867765#step:1:1
>        and at
>        https://github.com/gitgitgadget/git/actions/runs/3416084640/jobs/5685879914#step:1:1
>        turning on the timestamps (i.e. click on the sprocket wheel on the
>        upper right side of the log and select "Show timestamps"). You will
>        see that the `ci-config` job started at 3:22:05 UTC and the next
>        job, `win-build`, started only at 4:16:03 UTC.

Ouch. Though I wonder in practice how fast that would have gone without
ci-config. It is just asking for a generic ubuntu vm, which many of
other jobs would. Was there a shortage of those vms at 3:22, and by the
time it finally ran that shortage was over? Or is there constant
contention, and it is increasing the end-to-end latency by asking for a
queue slot, running, and then asking for more queue slots?

>     5. There is official support for the desired behavior that comes
>        without any magic branch with special content that users somehow
>        need to learn about: If you push a branch with commit messages that
>        contain `[skip ci]`, the build will be skipped, and no time is
>        wasted on running any job. For full details, see
>        https://github.blog/changelog/2021-02-08-github-actions-skip-pull-request-and-push-workflows-with-skip-ci/

This existed back when I added ci-config originally, and I tried it, but
the results are quite painful to use. Because "skip ci" is really a
property of a branch that a commit is pushed to, and not a branch. So
you have to sprinkle these "skip ci" markers all over the branch tips,
but then remember to remove them when you actually want to do useful
things with the branches, like merge them or send them out.

-Peff
