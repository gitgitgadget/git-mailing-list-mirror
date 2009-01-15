From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: rebase -p confusion in 1.6.1
Date: Thu, 15 Jan 2009 14:39:37 +0100
Message-ID: <496F3C99.1040800@drmicha.warpmail.net>
References: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Stephen Haberman <stephen@exigencecorp.com>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 14:41:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNST5-0003MC-5j
	for gcvg-git-2@gmane.org; Thu, 15 Jan 2009 14:41:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756295AbZAONjm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 08:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755969AbZAONjl
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 08:39:41 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:40487 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755046AbZAONjl (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 Jan 2009 08:39:41 -0500
Received: from compute1.internal (compute1.internal [10.202.2.41])
	by out1.messagingengine.com (Postfix) with ESMTP id DD9D821252A;
	Thu, 15 Jan 2009 08:39:38 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute1.internal (MEProxy); Thu, 15 Jan 2009 08:39:38 -0500
X-Sasl-enc: hvikEhzF4wKKsmZXWR46Jri/Z35vFxV+YL7TOaYHJIId 1232026778
Received: from [139.174.44.34] (pascal.math.tu-clausthal.de [139.174.44.34])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2B7DD3723D;
	Thu, 15 Jan 2009 08:39:38 -0500 (EST)
User-Agent: Thunderbird 2.0.0.19 (X11/20081209)
In-Reply-To: <slrngmu4j5.e1u.sitaramc@sitaramc.homelinux.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105801>

Sitaram Chamarty venit, vidit, dixit 15.01.2009 11:39:
> Hello all,
> 
> While trying to understand "rebase -p", I came across some
> very unexpected behaviour that made me throw in the towel
> and ask for help!
> 
> The outputs I got really confused me.  Before the "rebase
> -p", the tree looked like
>     
>     * 78ffda9... (refs/heads/work) b4
>     * be1e3a4... b3
>     *   cd8d893... Merge branch 'master' into work
>     |\
>     | * 0153c27... (refs/heads/master) a4
>     | * 74f4387... a3
>     * | f1b0c1c... b2
>     * | 2e202d0... b1
>     |/
>     * b37ae36... a2
>     * ed1e1bc... a1
> 
> But afterward, this is what it looks like -- all the "b"
> commits are gone!
> 
>     * 0153c27... (refs/heads/work, refs/heads/master) a4
>     * 74f4387... a3
>     * b37ae36... a2
>     * ed1e1bc... a1
> 
> What did I do wrong/misunderstand?
> 
> Here's how to recreate.  Note that "testci" is a shell
> function and "lg" is a git alias.  They are, respectively,
> (1) testci() { for i; do echo $i > $i; git add $i; git commit -m $i; done; }
> (2) git config alias.lg log --graph --pretty=oneline --abbrev-commit --decorate
> 
>     git init
>     testci a1 a2
>     git checkout -b work
>     testci b1 b2
>     git checkout master
>     testci a3 a4
>     git checkout work
>     git merge master
>     testci b3 b4
>     git --no-pager lg   # graph before rebase -p
>     git rebase -p master
>     git --no-pager lg   # graph after rebase -p
> 

First of all: git 1.6.0.6 gives you the unchanged graph after using
rebase -i -p (git 1.6.1 adds -i behind you back and sets up a dummy
editor). In any case, git rebase should not simply eat those commits -
either leave them alone or rewrite them. git bisect says

d80d6bc146232d81f1bb4bc58e5d89263fd228d4 is first bad commit
commit d80d6bc146232d81f1bb4bc58e5d89263fd228d4
Author: Stephen Haberman <stephen@exigencecorp.com>
Date:   Wed Oct 15 02:44:39 2008 -0500

    rebase-i-p: do not include non-first-parent commits touching UPSTREAM

so I'll cc the bad guy ;)

Second, what result do you expect? If the merge is to be preserved then
b1, b2 can't be simply ripped out - or else you get the linear structure
which rebase without '-p' delivers. The merge base (as returned by git
merge-base) between work and master is a4, i.e. master, so that the
expected result with '-p' is the one from 1.6.0.6 (unchanged graph).

Cheers,
Michael
