Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9028EC433EF
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 21:47:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhKZVu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 16:50:59 -0500
Received: from cloud.peff.net ([104.130.231.41]:38550 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242791AbhKZVs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 16:48:58 -0500
Received: (qmail 13030 invoked by uid 109); 26 Nov 2021 21:45:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Nov 2021 21:45:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7305 invoked by uid 111); 26 Nov 2021 21:45:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Nov 2021 16:45:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Nov 2021 16:45:44 -0500
From:   Jeff King <peff@peff.net>
To:     Dmitry Marakasov <amdmi3@amdmi3.ru>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: pull.rebase config option broken in 2.33.1
Message-ID: <YaFViM1tTTAc48ZG@coredump.intra.peff.net>
References: <YYFEE/2g3SiM04zx@hades.panopticon>
 <YYFJEASSimMhEsYz@coredump.intra.peff.net>
 <YaEh+k2q+9LoLXNh@hades.panopticon>
 <YaFVVMa9cg4gpI6b@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YaFVVMa9cg4gpI6b@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 26, 2021 at 04:44:52PM -0500, Jeff King wrote:

> +cc Alex and Elijah from the original 3d5fc24dae (pull: abort if
> --ff-only is given and fast-forwarding is impossible, 2021-07-21) in
> case they have further thoughts, but I _think_ this is working as
> designed.

Whoops, forgot the cc. Original message in full below.

-Peff

> On Fri, Nov 26, 2021 at 09:05:46PM +0300, Dmitry Marakasov wrote:
> 
> > * Jeff King (peff@peff.net) wrote:
> > 
> > > > After update from 2.33.0 to 2.33.1 the pull.rebase = true option
> > > > no longer works: `git pull` no longer tries to rebase (however manual
> > > > `git pull --rebase` works fine):
> > > > 
> > > > % git config pull.rebase
> > > > true
> > > > % git pull
> > > > fatal: Not possible to fast-forward, aborting.
> > > > % git pull --rebase
> > > > Successfully rebased and updated refs/heads/local-fixes.
> > > > % git pull
> > > > fatal: Not possible to fast-forward, aborting.
> > > > % grep -C1 rebase .git/config
> > > > [pull]
> > > > 	rebase = true
> > > > [rebase]
> > > > 	autostash = true
> > > > 
> > > > After downgrade to 2.33.0:
> > > > 
> > > > % git pull
> > > > Current branch local-fixes is up to date.
> > > 
> > > This looks like the same bug discussed in:
> > > 
> > >   https://lore.kernel.org/git/CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com/
> > > 
> > > There's a fix in that thread. It's currently in "next", but didn't quite
> > > make the cutoff for the upcoming v2.34.0.
> > 
> > For the record, the problem is still present in 2.34.1
> 
> In the bug I linked (and what got fixed in 2.34.1), the issue is that
> when the local branch is ahead of the remote, we don't say "up to date",
> but complain about fast-forwards.
> 
> It's hard to tell from the output above, but it looks like you have a
> case where there are new commits both locally and on the remote? In
> which case a rebase would work just fine.
> 
> But why are we complaining about "not possible to fast-forward"? Testing
> locally with something like:
> 
> -- >8 --
> git init repo
> cd repo
> 
> commit() {
> 	echo $1 >$1
> 	git add $1
> 	git commit -m $1
> }
> 
> git checkout -b local
> commit base
> commit local
> 
> git checkout -b remote HEAD^
> commit remote
> 
> git checkout local
> git config pull.rebase true
> git pull . remote
> -- >8 --
> 
> shows that we do rebase. If I set:
> 
>   git config pull.ff only
> 
> then we start complaining. And that behavior did change in 2.33.1, but
> I'm not sure it's wrong. We have two conflicting config options, and the
> precedence for which one we pick switched.
> 
> Do you have that option set in your config? Try:
> 
>   git config --show-origin --show-scope --get-regexp 'pull\..*'
> 
> 
> -Peff
