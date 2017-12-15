Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F25261F407
	for <e@80x24.org>; Fri, 15 Dec 2017 12:50:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755773AbdLOMuO (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Dec 2017 07:50:14 -0500
Received: from quechua.inka.de ([193.197.184.2]:45755 "EHLO mail.inka.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755902AbdLOMuL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Dec 2017 07:50:11 -0500
Received: from raven.inka.de (uucp@[127.0.0.1])
        by mail.inka.de with uucp (rmailwrap 0.5) 
        id 1ePpRJ-0004Hg-4G; Fri, 15 Dec 2017 13:50:09 +0100
Received: by raven.inka.de (Postfix, from userid 1000)
        id 7EAEF120192; Fri, 15 Dec 2017 13:47:39 +0100 (CET)
Date:   Fri, 15 Dec 2017 13:47:39 +0100
From:   Josef Wolf <jw@raven.inka.de>
To:     git@vger.kernel.org
Subject: Re: Need help migrating workflow from svn to git.
Message-ID: <20171215124739.GC18542@raven.inka.de>
Mail-Followup-To: Josef Wolf <jw@raven.inka.de>, git@vger.kernel.org
References: <20171214130933.GA18542@raven.inka.de>
 <5eb3fe18-864d-0b04-223e-d9e5cbf2c81e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5eb3fe18-864d-0b04-223e-d9e5cbf2c81e@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your input, Igor!

On Thu, Dec 14, 2017 at 11:27:09PM +0100, Igor Djordjevic wrote:
> Aside "update and merge" working copy while you`re hacking on it, 
> what happens with "execute" part? It seems really strange that you 
> don`t mind cron job running the same scripts which you are actively 
> working on, thus being in an inconsistent state, if not broken, even.

In theory, you're right. In practice, problems are almost non-existent because
of:

1. Scripts are independant from each other. Would there be a problem with one
   script, the other several hundred scripts will still continue to work.
2. Most changes to existing scripts are just minor tweaks. Not much room to
   wind up.
3. When new scripts/features are introduced, it is usually to some aspect that
   were non-existing before. Breaking something that did not work before is
   not a big issue.
4. Even IF cron happens to execute something half-baked, most of the time it
   will give a syntax error. The effect is as if the cron job would have been
   stopped entirely
5. When there's a major refactoring to be done where some problems are to
   expected, then the cron entry is disabled.

So, in practice, it's pretty much a non-issue.

> > With git, by contrast, this won't work. Git will refuse to pull
> > anything as long as there are ANY local modifications.
> 
> Not sure what`s happening at your end, but "ANY" part shouldn`t be 
> true - you can have local modifications and still execute `git pull` 
> successfully.
> 
> Only if you have local modifications in files that _also_ changed on 
> the remote end, `git pull` aborts (fetch of the remote branch 
> succeeds, actually, just merge with local branch is aborted).

Oh, you're right! I don't know where I catched the idea that ANY modification
would stop "git pull" from working...

> Now, having in mind you said conflicts are extremely rare in your 
> flow anyway, would this be enough for you?

No. There's still the issue with "git pop", even if no modifications are
coming from upstream.

> > The cron job would need to
> > 
> >    git stash
> >    git pull
> >    git stash pop
> > 
> > But this will temporarily remove my local modifications. If I happen
> > to do a test run at this time, the test run would NOT contain the
> > local modifications which I was about to test. Even worse: if I
> > happen to save one of the modified files while the modifications are
> > in the stash, the "git stash pop" will definitely cause a conflict,
> > although nothing really changed.
> 
> Is `git stash pop` causing conflicts your only concern here? How 
> about a situation where you save one of the modified files _after_ 
> `git stash pop` was successful, effectively discarding any updates 
> introduced by `git pull` from remote end...?

It's both. With the conflict having the highest probability.

> As you basically have a flow where two users (you and cron job) can 
> edit same files at the same time, desired outcome might be a bit 
> ambiguous, especially when scheduled execution of those files is 
> added to the mix.

Yeah. That's the difference with svn: Svn won't touch the files unless there
are changes coming from upstream. In contrast, git-stash WILL touch ALL
locally modified files, even the files which were not touched at all upstream.

So with svn, only files are at risk which are locally modified AND which have
been changed upstream. With git-stash, EVERY locally modified file is at risk.

> I`m thinking of a workflow involving (scripted) creation of a 
> temporary branch at fetched remote branch position, and using 
> something like `git checkout --merge <temp_branch>` to merge your 
> local modifications to latest changes fetched from remote (ending up 
> with conflicts inside working tree, if any),

But this would require local modifications to be committed?

-- 
Josef Wolf
jw@raven.inka.de
