From: Steven Grimm <koreth@midwinter.com>
Subject: Re: GIT vs Other: Need argument
Date: Thu, 19 Apr 2007 11:18:58 -0700
Message-ID: <4627B292.6080202@midwinter.com>
References: <aa69c80b0704170202r3f35acc7ydb81708e747c69ff@mail.gmail.com>	<200704171818.28256.andyparkins@gmail.com>	<8b65902a0704180540l721b9b1dj6f6e068f0d7e5119@mail.gmail.com>	<200704181426.29969.andyparkins@gmail.com>	<462650A7.5030404@midwinter.com> <f06d4m$3rs$1@sea.gmane.org>	<4626C4B9.1040707@midwinter.com>	<7vy7kpaz9s.fsf@assigned-by-dhcp.cox.net> <7vejmg9a1z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Apr 19 20:19:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HebDm-0001r5-Jc
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 20:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1766926AbXDSSTB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 14:19:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766927AbXDSSTB
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 14:19:01 -0400
Received: from tater.midwinter.com ([216.32.86.90]:58784 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1766926AbXDSSTA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 14:19:00 -0400
Received: (qmail 25068 invoked from network); 19 Apr 2007 18:19:00 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=dMNIau0tsR8YIBHmOgL0HzXCOFQav3VGNSghOmgCWs9SibvfH2F6geyx6z3I/eTR  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 19 Apr 2007 18:19:00 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <7vejmg9a1z.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45033>

Thanks for that detailed writeup. It squares pretty well with my 
understanding.


Junio C Hamano wrote:
>           (2).............M?
>          /               . 
> 	1-----3a-3b-3c-3d
>
> [...]
>                           (2')
>                          .
> 	1-----3a-3b-3c-3d
>
>
> The patch series I "vaguely recalled" in my previous message
> handled this special case where the branch being merged
> (i.e. 3d) was a fast-forward of the current commit (i.e. 1).
>   

I think this is actually the case I'd be most concerned about getting 
right for those people who are coming from svn and want to change their 
workflow as little as possible at first. The class of people who would 
exclusively use an "svnish-commit" alias that did "git commit;git push" 
-- that is, who never do local commits -- would always find themselves 
with this setup.

>  3. Always serialize by rebasing.  The structure you would want
>     to end up with is like this:
>
>                          2a'-2b'.(2c')
>                         /
> 	1-----3a-3b-3c-3d
>   

You are correct in pointing out later on that my fetch+rebase workflow 
fits this structure. And for my particular environment it's actually the 
only one I can use a lot of the time, because I'm usually pushing to a 
shared git-svn repository (or working in a git-svn repo of my own), from 
which the changes will get committed back to svn. Eric Wong has warned 
that git-svn doesn't deal well with merges; it expects linear history. 
So for now this is the structure I need to end up with, at least until 
git-svn learns how to deal with nonlinear ancestry, if that's even 
possible at all given svn's inherent limitations.

I look forward to the day when git has built up enough critical mass 
here that we can just switch over to it completely and ditch that kind 
of restriction. With that happy day in mind, I'd still love to see the 
other workflows made as painless as possible, so more comments below.

> For the second workflow, you would:
>
>     2-a. first make a tentative commit 2c
>     2-b. merge what was ready on your end and the other side:
>     2-c. roll forward the local change you have in 2c:
>
>     We probably could help automating this, but your "git pull"
>     session transcript need to look like this:
>
> 	$ git pull origin
>         First stashing away of your local changes...
> 	Resolving conflicts between 2b and 3d.
> 	Conflicted merge.  Please resolve and commit.
> 	$ edit ; test
>         $ git commit ;# to record M
> 	Committed the merge result.
>         You have stashed local changes further to roll forward.
>         $ git unstash local-changes
>         Resolving conflicts between M and 2c.
> 	Local changes conflicted during roll-forward.
>         Leaving resulting mess in the working tree for you to sort out.
>   

I wonder if it makes sense to automate that even more and make git pull 
behave a bit statefully like rebase does:

    $ git pull origin
    Stashing local changes.
    Resolving conflicts, pass 1.
    Conflicts! Please resolve.
    $ edit ; test
    $ git pull --continue
    Committing revision M.
    Unstashing your local changes.
    Resolving conflicts, pass 2.
    Local changes conflicted during roll-forward. Sort it out.
    $

When git pull --continue does the commit, it *might* be nice for it to 
do a variant of commit -a: if the user has modified all the conflicting 
files, *and* not done an update-index on any of them manually, then do 
the update-index implicitly. (That "and" part would be to prevent it 
from tripping up experienced git users who want to manually mark the 
conflicting files as resolved by running update-index.) I'm not sure 
that's actually a good idea, though it'd save some commands most of the 
time; the danger, of course, is that you could end up committing a 
half-resolved file by accident. But then I guess there's nothing 
preventing you from doing that with update-index today.

But that's attractive because it's exactly two git commands in the most 
complex case (conflicts in the merge of committed revisions) and only 
one git command in the simplest cases (no conflicts or conflicts only in 
the working copy edits.) In the case of no working copy edits, 
--continue would just do the commit for you.

To make pull and rebase even more consistent, one could also allow git 
pull --abort to roll back the pull during a conflict resolution, whether 
or not it's a working-copy-edits one. People might find that a handy 
shortcut in other workflows too; it would probably just do a hard reset 
back to the pre-merge revision in the no-working-copy-edits case. 
Obviously that wouldn't be new functionality, just an arguably slightly 
more intuitive way to do it than what exists now.

>     If you want to automate this, you can use this four-liner
>     shell script:
>
> 	#!/bin/sh
>         git commit || exit
> 	git fetch origin || exit
>         git rebase origin || exit
> 	git reset HEAD^
>   

Actually I think I like the idea of making that a little more robust and 
having it take a --continue option like I described above. No reason it 
can't keep track of its current state. I will spend some time this 
weekend doing that.

-Steve
