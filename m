Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 177DDC433EF
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 02:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7DEA60F4F
	for <git@archiver.kernel.org>; Mon, 27 Sep 2021 02:17:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232435AbhI0CSq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Sep 2021 22:18:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:31780 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229811AbhI0CSo (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Sep 2021 22:18:44 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10119"; a="221188351"
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="221188351"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 19:17:06 -0700
X-IronPort-AV: E=Sophos;i="5.85,325,1624345200"; 
   d="scan'208";a="615600912"
Received: from mdroper-desk1.fm.intel.com (HELO mdroper-desk1.amr.corp.intel.com) ([10.1.27.134])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2021 19:17:06 -0700
Date:   Sun, 26 Sep 2021 19:17:05 -0700
From:   Matt Roper <matthew.d.roper@intel.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [BUG REPORT] split-index behavior during interactive rebase
Message-ID: <20210927021705.GW3389343@mdroper-desk1.amr.corp.intel.com>
References: <20210916055057.GT3389343@mdroper-desk1.amr.corp.intel.com>
 <20210926215703.GB3311029@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210926215703.GB3311029@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 26, 2021 at 11:57:03PM +0200, SZEDER Gábor wrote:
> On Wed, Sep 15, 2021 at 10:50:57PM -0700, Matt Roper wrote:
> > What did you do before the bug happened? (Steps to reproduce your issue)
> > 
> >   I activated split index mode on a repo ("git config core.splitIndex
> >   true"), performed an interactive rebase, modified a commit earlier in
> >   the history.
> > 
> >   The steps can be reproduced via a sequence of:
> >       $ mkdir tmp && cd tmp && git init
> >       $ git config core.splitIndex true
> >       $ for x in `seq 20`; do echo $x >> count; git add count; git commit -m "Commit $x"; done
> 
> It's important to note that this test repository has only a single
> tracked file in it.
> 
> >       $ git rebase -i HEAD~10
> >       
> >       ## Add "x git commit --amend --no-edit" as the first command of
> >       ## the todo list.
> > 
> > What did you expect to happen? (Expected behavior)
> > 
> >   My expectation was that there would still only be a single shared index
> >   file in the .git directory upon completion of the rebase.
> > 
> > What happened instead? (Actual behavior)
> > 
> >   A large number of distinct sharedindex.* files were generated in the .git
> >   directory during the rebase.
> 
> I think this works as intended.
> 
> A new shared index is written when the number of index entries that
> would be writen to '.git/index' is higher than a given percentage of
> the total number of index entries.  This percentage can be specified
> with the 'splitIndex.maxPercentChange' configuration variable and it
> defaults to 20%.  In your test repository above there is only a single
> file and it is modified in every commit, so when switching from one
> commit to the other 100% of the index entries would be written to
> '.git/index', resulting in a new shared index file written for each
> rebase step.

Good point; my attempt to create a simple reproducer may not be
sufficiently complex in this case.  But I don't think this is the source
of the problem for my real Linux kernel repo; see below.

> 
> > What's different between what you expected and what actually happened?
> > 
> >   Rather than a single shared index file, I wound up with a huge number of
> >   large shared index files.  The real repository I was working with (a Linux
> >   kernel source tree) had a shared index file size of about 7MB, and I was
> >   modifying a commit several hundred back in history (in case it
> >   matters, these were all linear commits, no merges), so the resulting
> >   collection of shared index files consumed a surprising amount of disk
> >   space.
> 
> The last commit in my somewhat outdated linux repo contains ~71k
> files, the 20% of that is ~14k.  Does that linear string of "several
> hundred" commits modify that many files?

No.  In the real Linux repo I'm working with, nearly all of the commits
are in the drm/i915 driver tree.  The overall diff of the patches being
rebased is

         614 files changed, 107114 insertions(+), 8751 deletions(-)

> 
> > Anything else you want to add:
> > 
> >   As an experiment, I tried setting splitIndex.sharedIndexExpire=now
> 
> I would advise against that, it's potentially dangerous, because it
> can remove shared index files that are still in use by other git
> processes.

Yeah, I also found sharedIndexExpire=now to be incompatible with a few
other commands such as "git stash" too.


> 
> >   to see
> >   if it would avoid the explosion of shared index files, but it appears the
> >   stale index files are still not being removed during the rebase, and I
> >   still wind up with a huge number at the end of the rebase.  If I manually
> >   run "git update-index --split-index" after the rebase completes it will
> >   properly delete all of the stale ones at that point.
> > 
> >   Rebases that do not actually modify the history do _not_ trigger the
> >   explosion of shared index files (e.g., "git rebase -i HEAD~10 --exec 'echo
> >   foo'").
> > 
> >   If I do not set the core.splitIndex setting on the repository, but only
> >   activate split index manually via "git update-index --split-index" there
> >   is only one shared index file at the end of the rebase, but based on the
> >   file size it appears the repository is no longer operating in split index
> >   mode.
> > 
> >   Before:
> >   $ ll .git | grep index
> >   -rw-rw-r--   1 mdroper mdroper   149165 Sep 15 22:21 index
> >   -rw-rw-r--   1 mdroper mdroper  7296080 Sep 15 22:21 sharedindex.f916dd59ccc22ca34298f557a4659aca2767dae4
> > 
> >   After (just amending HEAD~1 in this case):
> >   $ ls -l .git | grep index
> >   -rw-rw-r--   1 mdroper mdroper  7445145 Sep 15 22:22 index
> >   -rw-rw-r--   1 mdroper mdroper  7296080 Sep 15 22:22 sharedindex.f916dd59ccc22ca34298f557a4659aca2767dae4
> 
> > git version 2.33.0
> 
> I could reproduce all this with v2.33.0 (except that I saw the split
> index being turned off even with core.splitIndex enabled), but was
> unable to do so with current master.
> 
> I think that this is a bug in the interaction between the split index
> feature and 'git rebase' when using the recursive merge strategy and
> when a couple of other, more subtle conditions are met.  It seems that
> with the right conditions rebase only writes regular index files, and
> by not entering the split index code paths it doesn't look for old
> shared index files to expire.
> 
> After v2.33.0 we switched the default merge strategy from recursive to
> 'ort', and with that these cases appear to work as intended, i.e. old
> shared index files are expired and the split index feature doesn't get
> turned off.  Since the 'ort' strategy is in many ways better (faster,
> more correct, etc.) than the recursive, I don't think it's worth the
> effort to try to fix this issue with split index, rebase and the
> recursive strategy.

Yeah, if this is specific to the recursive strategy then it's probably
not worth sinking too much time into tracking down.  I just tried
setting pull.twohead=ort in my config to make v2.33.0 also use the ort
strategy by default, and from some preliminary testing that does indeed
appear to solve the problem.

Thanks for looking into this!


Matt

-- 
Matt Roper
Graphics Software Engineer
VTT-OSGC Platform Enablement
Intel Corporation
(916) 356-2795
