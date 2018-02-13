Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30C511F404
	for <e@80x24.org>; Tue, 13 Feb 2018 14:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935289AbeBMOXy (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Feb 2018 09:23:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:48815 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933555AbeBMOXv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Feb 2018 09:23:51 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9955BADD5;
        Tue, 13 Feb 2018 14:23:49 +0000 (UTC)
Subject: Re: "git submodule" vs "git subtree" vs "repo" vs "git subdir" ... ?
To:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Git Mailing list <git@vger.kernel.org>
References: <alpine.LFD.2.21.1802130746360.16738@localhost.localdomain>
From:   Nicolas Morey-Chaisemartin <NMoreyChaisemartin@suse.de>
Message-ID: <338901fc-6dc8-2684-c116-393e603f85e9@suse.de>
Date:   Tue, 13 Feb 2018 15:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:58.0) Gecko/20100101
 Thunderbird/58.0
MIME-Version: 1.0
In-Reply-To: <alpine.LFD.2.21.1802130746360.16738@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



Le 13/02/2018 à 14:06, Robert P. J. Day a écrit :
>   looking for general opinions ... i am (frighteningly :-) teaching a
> git course later this week, and one of the topics on the list is git
> submodules, which was specifically requested by the client as their
> idea of how to start incorporating child repos in new projects.
>
>   however, given the number of articles written about the drawbacks
> with submodules, i wanted to throw in a section about "git subtree" as
> well, even though (as discussed earlier) there is some minor dispute
> as to whether "git subtree" is part of "core" git, but i'm not going
> to let that stop me.

I've dealt with a large number of submodules and subtrees in the last years so here are my 2 cents.
The first question to ask is the most important one:
Do the repos really need to be split at all.

In a previous life, we started with one repo per "small projects", each containing a couple of binaries or libs.
Everything was put together through submodules.
After way too long to admit, we realized that it was just not worth it. We had to deal with so many corner cases in CI and other things for a no real gain.
The reality is git works perfectly with bigger projects and smart enough that people working on two different "subprojects" don't create any conflict.
So we started merging a lot of it back into the main repo and that was it.

I see some advantages submodules have other subtrees:
- It's slightly easier to in a subproject when using submodule than with subtree (at least for git newcomers).
Once you made sure your submodule is on a branch, you just go into it and work in a standard git.
When using subtree, you have to know you're in a subtree and to your subtree push/pull to resync with someone working directly in the subproject.
At the time conflict in subtrees were sometimes a bit weird and created history full of merge.

- submodules are great when working with huge subrepo.
We have a repository than had among its submodule: linux, gcc, gdb, glibc.
This means a real lot of code/files and commits.
Subtree would work but you'd endup with a humongous repo and as expected everything is slowed down.

- submodules work well when you are moving between versions and branches of a subproject.
Let me clarify with an example:
We had a repo that had ffmpeg as a submodule with a large patch series from us.
We would regularly create a new branch in the subrepo with all our patches on top of a new ffmpeg upstream release.
And simply point the top project to this SHA1. And it worked great.
I wouldn't risk doing that kind of things with subtree. I may be wrong here (I haven't tried it to be honest) the the push/pull approach doesn't seem to fit
 the idea of moving from a SHA1 to a seemingly unrelated one.

Now that I'm working with reasonable repo sizes again, and linear history, I mostly stick with subtrees.

Nicolas
