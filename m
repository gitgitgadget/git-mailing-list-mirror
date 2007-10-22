From: Andreas Ericsson <ae@op5.se>
Subject: Re: best git practices, was Re: Git User's Survey 2007 unfinished
 summary continued
Date: Mon, 22 Oct 2007 14:44:03 +0200
Message-ID: <471C9B13.9080603@op5.se>
References: <8fe92b430710081355i7d3dbaa2q9a8939b55d7ca7dc@mail.gmail.com>  <Pine.LNX.4.64.0710130130380.25221@racer.site>  <1192827476.4522.93.camel@cacharro.xalalinux.org>  <4719B655.90204@op5.se> <DE4FB702-24E8-421F-8447-04A5C7F7B5D2@zib.de> <8fe92b430710201606i47e85b24k17abd819bf0d353b@mail.gmail.com> <Pine.LNX.4.64.0710210031130.25221@racer.site> <471AFD07.4040606@op5.se> <Pine.LNX.4.64.0710212308540.25221@racer.site> <471C586A.9030900@op5.se> <Pine.LNX.4.64.0710221156540.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Steffen Prohaska <prohaska@zib.de>,
	Federico Mena Quintero <federico@novell.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 14:44:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjweK-0000EQ-Gi
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 14:44:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753172AbXJVMoL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 08:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753228AbXJVMoL
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 08:44:11 -0400
Received: from mail.op5.se ([193.201.96.20]:58047 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172AbXJVMoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 08:44:09 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 874ED173064F;
	Mon, 22 Oct 2007 14:44:07 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.468
X-Spam-Level: 
X-Spam-Status: No, score=-2.468 tagged_above=-10 required=6.6
	tests=[AWL=0.031, BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f-8AO3DlCIP0; Mon, 22 Oct 2007 14:44:06 +0200 (CEST)
Received: from nox.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 605001730695;
	Mon, 22 Oct 2007 14:44:05 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <Pine.LNX.4.64.0710221156540.25221@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61998>

Johannes Schindelin wrote:
> So once again, what operations involving git do people use regularly?
> 

diff
qgit
commit
fetch
rebase
merge
status
push
cherry-pick
grep
bisect
add
show-ref

If I were to suggest any improvements, it'd be to change the semantics 
of git-pull to always update the local branches set up to be merged with 
the remote tracking branches when they, prior to fetching, pointed to 
the same commit, such that when

$ git show-ref master
d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/heads/master
d4027a816dd0b416dc8c7b37e2c260e6905f11b6 refs/remotes/origin/master

refs/heads/master gets set to refs/remotes/origin/master post-fetch.

This would save me from this command sequence, which I currently have to 
do for git.

git fetch
git checkout next
git merge spearce/next
git checkout master
git merge spearce/master
git checkout maint
git merge spearce/maint
git checkout pu
git reset --hard spearce/pu

<rinse and repeat for every tracked branch>

git could definitely help here. I want the local branches to be 
up-to-date with the remote ones, because I frequently run diffs against 
the various branches to see if anything that I should be aware of has 
changed, and just as frequently I forget to add that 'origin/' prefix, 
which means I *might* be looking at old code.

I usually do that on internal projects, where we have "master", "next", 
"testing", and "stable" branches for pretty much every repo. We have 54 
git repos. The typing adds up. This is also one of the most frequent 
causes of confusion for my (even) less git-savvy co-workers. The 
argument usually goes like this:
"Umm... Peter, why did you commit your fix on top of 7 weeks old code?"
"Oh? I did git-pull first, just as you said, so it should have been the 
latest, shouldn't it?"
"Well, what branch were you on when you pulled?"
"Err.. does that matter? I didn't have any local modifications on the 
branch when I pulled, so it should have just updated it."

What's happened prior to such an argument is usually this:
next or master is inevitably checked out. The user does git-pull to get 
up to date. They then change branch and get down to business with 
rebasing, merging and editing. When it's time to push, git tells them 
"not a strict subset. use git-pull!", and they do, and sometimes it 
fails, and I have a hard time explaining why since I really don't see a 
reason for *not* updating all "to-merge" branches when they point to the 
same commit as their tracking-branch before the pull.

Patch to follow (at some point), although it's likely to make git-pull a 
built-in since I have no idea how to maintain coupled lists in shell.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
