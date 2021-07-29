Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBADC4338F
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC76360F01
	for <git@archiver.kernel.org>; Thu, 29 Jul 2021 21:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhG2VO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Jul 2021 17:14:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:33198 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229738AbhG2VO6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jul 2021 17:14:58 -0400
Received: (qmail 11081 invoked by uid 109); 29 Jul 2021 21:14:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Jul 2021 21:14:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27470 invoked by uid 111); 29 Jul 2021 21:14:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Jul 2021 17:14:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 29 Jul 2021 17:14:53 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/7] Final optimization batch (#15): use memory pools
Message-ID: <YQMaTTjgTB3wD8wY@coredump.intra.peff.net>
References: <pull.990.git.1627044897.gitgitgadget@gmail.com>
 <pull.990.v2.git.1627531121.gitgitgadget@gmail.com>
 <YQLVPN9n5E1Yvi/q@coredump.intra.peff.net>
 <CABPp-BH2PQ_rHDPNBghdkhO=kaNfQBnU28UFh9c-sPBNUOM4gA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BH2PQ_rHDPNBghdkhO=kaNfQBnU28UFh9c-sPBNUOM4gA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 29, 2021 at 02:46:03PM -0600, Elijah Newren wrote:

> You make fair points about the absolute timings for rebase, but the
> "grand scheme of things" involves usecases outside of traditional
> rebases.  Some of those involve far more merges, making the relative
> timings more important.  They also involve much less overhead -- not
> only do they get to ignore the "git checkout" present in most rebases,
> but they also get to exclude the index or worktree updating that are
> present above.  Without that extra overhead, the relative improvement
> from this patch is even greater. One particular example usecase that
> is coming soon is the introduction of `git log --remerge-diff`; it
> makes the timing of individual merges critical since it does so many
> of them.  And it becomes even more important for users who change the
> default from --diff-merges=off to --diff-merges=remerge-diff, because
> then any `git log -p` will potentially remerge hundreds or thousands
> of merge commits.  (I've got lots of users who have -p imply
> --remerge-diff since last November.)

Ooh, I hadn't considered doing a bunch of fast in-memory merges for
--remerge-diff. That is a very compelling use case, I agree.

> >   Benchmark #1: ./test-tool.nopool fast-rebase --onto HEAD base hwmon-updates
> >     Time (mean ± σ):     921.1 ms ± 146.0 ms    [User: 843.0 ms, System: 77.5 ms]
> >     Range (min … max):   660.9 ms … 1112.2 ms    10 runs
> >
> >   Benchmark #2: ./test-tool.pool fast-rebase --onto HEAD base hwmon-updates
> >     Time (mean ± σ):     635.4 ms ± 125.5 ms    [User: 563.7 ms, System: 71.3 ms]
> >     Range (min … max):   496.8 ms … 856.7 ms    10 runs
> >
> >   Benchmark #3: ./test-tool.tcmalloc fast-rebase --onto HEAD base hwmon-updates
> >     Time (mean ± σ):     727.3 ms ± 139.9 ms    [User: 654.1 ms, System: 72.9 ms]
> >     Range (min … max):   476.3 ms … 900.5 ms    10 runs
> 
> That's some _really_ wide variance on your runs, making me wonder if
> you are running other things on your (I presume) laptop that are
> potentially muddying the numbers.  Would the tcmalloc case actually
> have the fastest run in general, or was it just lucky to hit a "quiet"
> moment on the laptop?

Yeah, I noticed that, too. The system was otherwise unloaded, but there
I think a big part of it was that my prepare commands flipped back and forth
between the pre-/post-rename states twice. Even though that isn't
included in the timings, I think it was just creating a lot of delayed
work for the OS to do when it decided to write back all those inodes.

Switching it to:

  hyperfine \
    -p 'git checkout 5.4-renames^0 &&
        git branch -f hwmon-updates fd8bdb23b91876ac1e624337bb88dc1dcc21d67e' \
    -L version nopool,pool,tcmalloc \
    './test-tool.{version} fast-rebase --onto HEAD base hwmon-updates'

produces much smoother results:

  Benchmark #1: ./test-tool.nopool fast-rebase --onto HEAD base hwmon-updates
    Time (mean ± σ):     649.7 ms ±   5.0 ms    [User: 595.1 ms, System: 54.3 ms]
    Range (min … max):   643.7 ms … 661.9 ms    10 runs
   
  Benchmark #2: ./test-tool.pool fast-rebase --onto HEAD base hwmon-updates
    Time (mean ± σ):     405.0 ms ±   3.0 ms    [User: 354.9 ms, System: 50.0 ms]
    Range (min … max):   401.0 ms … 411.9 ms    10 runs
   
  Benchmark #3: ./test-tool.tcmalloc fast-rebase --onto HEAD base hwmon-updates
    Time (mean ± σ):     476.7 ms ±   3.9 ms    [User: 430.1 ms, System: 46.4 ms]
    Range (min … max):   472.3 ms … 484.1 ms    10 runs
   
  Summary
    './test-tool.pool fast-rebase --onto HEAD base hwmon-updates' ran
      1.18 ± 0.01 times faster than './test-tool.tcmalloc fast-rebase --onto HEAD base hwmon-updates'
      1.60 ± 0.02 times faster than './test-tool.nopool fast-rebase --onto HEAD base hwmon-updates'

So the pool is definitively faster, though we can go a fair ways by
using a better allocator. :)

> I did similar testing a year ago, before I even looked at memory
> pools.  I was surprised by how big a speedup I saw, and considered
> asking on the list if we could push to use a different allocator by
> default.  Ultimately, I figured that probably wouldn't fly and
> distributors might override our choices anyway.  It was at that point
> that I decided to start tweaking mem-pool.[ch] (which ended up getting
> merged at edab8a8d07 ("Merge branch 'en/mem-pool'", 2020-08-27)), and
> then integrating that into strmap/strset/strintmap -- all in an effort
> to guarantee that we realized the speedups that I knew were possible
> due to my testing with the special allocators.

Yeah, I think choice of allocator should be outside the scope of Git. It
would be a packaging issue if people want to squeeze out every bit. I do
agree there's something to be said for Git just handling this itself,
regardless of the platform or build. I'm just always on the lookout for
places where we can get free speedups without having to pay any
maintenance cost for them. :)

> I think you make a good suggestion to drop the USE_MEMORY_POOL switch.
> I think I'll do it as an additional patch at the end of the series,
> just so it's easy for me to restore if by change it's ever needed.

Yeah, between that cleanup reducing the maintenance cost and your
compelling use cases above, I think I'm convinced that this is a good
direction.

-Peff
