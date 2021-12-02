Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478EAC433EF
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 15:27:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346524AbhLBPav (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 10:30:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239981AbhLBPau (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 10:30:50 -0500
Received: from sprint-2.amdmi3.ru (sprint-2.amdmi3.ru [IPv6:2a0a:2b41:94:cb5e::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ED13AC06174A
        for <git@vger.kernel.org>; Thu,  2 Dec 2021 07:27:27 -0800 (PST)
Received: from amdmi3.ru (localhost [IPv6:::1])
        by sprint-2.amdmi3.ru (Postfix) with SMTP id CCA67188880;
        Thu,  2 Dec 2021 18:27:22 +0300 (MSK)
Received: by amdmi3.ru (nbSMTP-1.00) for uid 1000
        amdmi3@amdmi3.ru; Thu,  2 Dec 2021 18:27:22 +0300 (MSK)
Date:   Thu, 2 Dec 2021 18:26:05 +0300
From:   Dmitry Marakasov <amdmi3@amdmi3.ru>
To:     Jeff King <peff@peff.net>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: pull.rebase config option broken in 2.33.1
Message-ID: <Yajlf6e2aRIpTBqB@hades.panopticon>
Mail-Followup-To: Jeff King <peff@peff.net>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
References: <YYFEE/2g3SiM04zx@hades.panopticon>
 <YYFJEASSimMhEsYz@coredump.intra.peff.net>
 <YaEh+k2q+9LoLXNh@hades.panopticon>
 <YaFVVMa9cg4gpI6b@coredump.intra.peff.net>
 <YaFViM1tTTAc48ZG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YaFViM1tTTAc48ZG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Jeff King (peff@peff.net) wrote:

> > > > > After update from 2.33.0 to 2.33.1 the pull.rebase = true option
> > > > > no longer works: `git pull` no longer tries to rebase (however manual
> > > > > `git pull --rebase` works fine):
> > > > > 
> > > > > % git config pull.rebase
> > > > > true
> > > > > % git pull
> > > > > fatal: Not possible to fast-forward, aborting.
> > > > > % git pull --rebase
> > > > > Successfully rebased and updated refs/heads/local-fixes.
> > > > > % git pull
> > > > > fatal: Not possible to fast-forward, aborting.
> > > > > % grep -C1 rebase .git/config
> > > > > [pull]
> > > > > 	rebase = true
> > > > > [rebase]
> > > > > 	autostash = true
> > > > > 
> > > > > After downgrade to 2.33.0:
> > > > > 
> > > > > % git pull
> > > > > Current branch local-fixes is up to date.
> > > > 
> > > > This looks like the same bug discussed in:
> > > > 
> > > >   https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com/
> > > > 
> > > > There's a fix in that thread. It's currently in "next", but didn't quite
> > > > make the cutoff for the upcoming v2.34.0.
> > > 
> > > For the record, the problem is still present in 2.34.1
> > 
> > In the bug I linked (and what got fixed in 2.34.1), the issue is that
> > when the local branch is ahead of the remote, we don't say "up to date",
> > but complain about fast-forwards.
> > 
> > It's hard to tell from the output above, but it looks like you have a
> > case where there are new commits both locally and on the remote? In
> > which case a rebase would work just fine.
> > 
> > But why are we complaining about "not possible to fast-forward"? Testing
> > locally with something like:
> > 
> > -- >8 --
> > git init repo
> > cd repo
> > 
> > commit() {
> > 	echo $1 >$1
> > 	git add $1
> > 	git commit -m $1
> > }
> > 
> > git checkout -b local
> > commit base
> > commit local
> > 
> > git checkout -b remote HEAD^
> > commit remote
> > 
> > git checkout local
> > git config pull.rebase true
> > git pull . remote
> > -- >8 --
> > 
> > shows that we do rebase. If I set:
> > 
> >   git config pull.ff only
> > 
> > then we start complaining. And that behavior did change in 2.33.1, but
> > I'm not sure it's wrong. We have two conflicting config options, and the
> > precedence for which one we pick switched.
> > 
> > Do you have that option set in your config? Try:
> > 
> >   git config --show-origin --show-scope --get-regexp 'pull\..*'

Yes, I have both `pull.ff=only` and `pull.rebase` set, but these
come from different configs:

  % git config --show-origin --show-scope --get-regexp 'pull\..*'
  global  file:/home/marakasov/.gitconfig pull.ff only
  local   file:.git/config    pull.rebase true

IMO the setup is perfectly legal, as I want to disable merge on pull
in any case, and I also want rebase for a specific repo. So the
problem is then in how these options override (not) each other.

The following change in repo's config fixes this issue for me:

   [pull]
  +    ff = yes
       rebase = true

But IMO it still needs to be fixed in git, as the cause of this
problem is quite unobvious and it does not feel right that local
repo config should be aware of global config and include explicit
overrides not really realated to the local repo config, for the
latter to work as expected.

It looks like it could be fixed by either making `pull.rebase` on
repo level override `pull.ff` on global level, or reorganizing the
options so no override is required, for example by introducing e.g.
`pull.merge=off` instead of `pull.ff=only`. This way having both
`pull.merge=off` and `pull.rebase=true` will not contradict each
other and will not require any cross-variable override logic.

-- 
Dmitry Marakasov   .   55B5 0596 FF1E 8D84 5F56  9510 D35A 80DD F9D2 F77D
amdmi3@amdmi3.ru  ..:     https://github.com/AMDmi3  https://amdmi3.ru

