Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8BEDF1F4DD
	for <e@80x24.org>; Thu, 24 Aug 2017 05:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdHXFfU (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 01:35:20 -0400
Received: from ikke.info ([178.21.113.177]:42174 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751019AbdHXFfS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 01:35:18 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 26B6C440215; Thu, 24 Aug 2017 07:32:13 +0200 (CEST)
Date:   Thu, 24 Aug 2017 07:32:13 +0200
From:   Kevin Daudt <me@ikke.info>
To:     Nish Aravamudan <nish.aravamudan@canonical.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Undocumented change in `git branch -M` behavior
Message-ID: <20170824053213.GF3839@alpha.vpn.ikke.info>
References: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170823201334.bz42s6t5ti4jdaqm@pitfall>
User-Agent: Mutt/1.8.3 (2017-05-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 23, 2017 at 01:13:34PM -0700, Nish Aravamudan wrote:
> Hello,
> 
> Hopefully, I've got this right -- I noticed a change in behavior in git
> with Ubuntu 17.10, which recently got 2.14.1. Specifically, that when in
> an orphaned branch, -M ends up moving HEAD to the new branch name,
> clobbering the working tree. As far as I know, from the manpages,
> orphaned branches are still supported and should work?
> 
> I think an example will demonstrate more than words (the following are
> done in LXD containers, hence the root user):
> 
> # git --version
> git version 2.14.1
> # mkdir test && cd test && git init .
> Initialized empty Git repository in /root/test/.git/
> # git checkout -b a
> Switched to a new branch 'a'
> # touch testfile && git add testfile && git commit -m 'initial commit'
> [a (root-commit) 6061193] initial commit
>  Committer: root <root@precious-magpie.lxd>
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 testfile
> # git checkout --orphan master
> Switched to a new branch 'master'
> # git status
> On branch master
> 
> No commits yet
> 
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
> 
>         new file:   testfile
> 
> # git reset --hard && git status
> On branch master
> 
> No commits yet
> 
> nothing to commit (create/copy files and use "git add" to track)
> # git branch -M a b
> # git status
> On branch b
> Changes to be committed:
>   (use "git reset HEAD <file>..." to unstage)
> 
>         deleted:    testfile
> 
> This is very unexpected. I force-renamed a branch I wasn't currently
> checked out to and now I'm checked out to it *and* I have staged file
> removals (I think what is effectively happening is my current working
> directory (empty) is being staged into the new branch, but I'm not
> 100%).
> 
> For comparision, on 17.04:
> 
> # git --version
> git version 2.11.0
> # mkdir test && cd test && git init .
> Initialized empty Git repository in /root/test/.git/
> # git checkout -b a
> Switched to a new branch 'a'
> # touch testfile && git add testfile && git commit -m 'initial commit'
> [a (root-commit) f8d0d53] initial commit
>  Committer: root <root@honest-sturgeon.lxd>
>  1 file changed, 0 insertions(+), 0 deletions(-)
>  create mode 100644 testfile
> # git checkout --orphan master
> Switched to a new branch 'master'
> # git status
> On branch master
> 
> No commits yet
> 
> Changes to be committed:
>   (use "git rm --cached <file>..." to unstage)
> 
>         new file:   testfile
> 
> # git reset --hard && git status
> On branch master
> 
> No commits yet
> 
> nothing to commit (create/copy files and use "git add" to track)
> # git branch -M a b
> # git status
> On branch master
> 
> Initial commit
> 
> nothing to commit (create/copy files and use "git add" to track)
> 
> This is what I expect to see, the branch rename has no effect on HEAD.
> 
> I haven't yet bisected this (but I can if necessary). My initial
> suspicion is
> https://github.com/git/git/commit/70999e9ceca47e03b8900bfb310b2f804125811e#diff-d18f86ea14e2f1e5bff391b2e54438cb
> where a comparison between the oldname of the branch and HEAD was
> performed before attempting to move HEAD (so that HEAD followed to the
> new branch name, I believe). That change was dropped, though and perhaps
> the new check in replace_each_worktree_head_symref of
> 
>         strcmp(oldref, worktrees[i]->head_ref)
> 
> does not work for orphaned branches? I am unfamiliar with all the
> details of the git internals, so please correct me if I'm wrong!
> 
> Thanks,
> Nish
> 
> -- 
> Nishanth Aravamudan
> Ubuntu Server
> Canonical Ltd

Thanks for this report. I've bisected it down to 
fa099d232 (worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe(), 2017-04-24) 

I've CC'ed Duy, who made that commit.

Kevin
