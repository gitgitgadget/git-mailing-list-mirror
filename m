From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Help rescuing a repository
Date: Tue, 10 Jun 2008 19:08:31 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806101848320.3101@woody.linux-foundation.org>
References: <C061111B-1696-4545-A3F0-D0B8B961A352@vicaya.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Luke Lu <git@vicaya.com>
X-From: git-owner@vger.kernel.org Wed Jun 11 04:09:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6FmC-0000Vu-ET
	for gcvg-git-2@gmane.org; Wed, 11 Jun 2008 04:09:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755132AbYFKCIf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2008 22:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754256AbYFKCIf
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Jun 2008 22:08:35 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54413 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754144AbYFKCIe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jun 2008 22:08:34 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B28VAC029066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 10 Jun 2008 19:08:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5B28VPp008111;
	Tue, 10 Jun 2008 19:08:31 -0700
In-Reply-To: <C061111B-1696-4545-A3F0-D0B8B961A352@vicaya.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.378 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84580>



On Tue, 10 Jun 2008, Luke Lu wrote:
>
> I was doing some git rebase -i in a topic branch (topic/ser) to squash and
> reorder some commits. There were some conflicts. I fixed the conflicts and
> typed git rebase --continue. The cycle continued a few times and then this
> happened:
> 
> 13 files changed, 68 insertions(+), 41 deletions(-)
> error: Ref refs/heads/topic/ser is at 5cfb6b694f2d5a1ff429fe86f6c5ecafed159e47
> but expected a10a7127be3441c732cab5baa2dd8684591f91f7
> fatal: Cannot lock the ref 'refs/heads/topic/ser'.

Ok, you seem to have committed something in another session (other window 
or something) at the same time as doing that git rebase series. As a 
result, the rebasing commit was unhappy, because you basically ripped the 
rug out from under it by changing the branch it was working on.

> $ git status
> # Not currently on any branch.
> nothing to commit (working directory clean)

Don't worry. Nothing has gone away, although you may now need to *find* 
the particular branch tip(s) that you are interested in.

> I've used git rebase -i before without any problem. The only difference this
> time is that there are more commits (50+) and more files (hundreds) and
> changes (thousands) involved due to some global find & replace.

That shouldn't matter, except that it was obviously very likely one of the 
reasons for the conflicts too.

What mattered is:

> I *might* have committed something in the same branch, while the git 
> rebase -i editor window is open (there are a lot of commits to reorder 
> and squash, so I used another window to look at the commits I'm not sure 
> about. I might have done a quick fix (likely whitespace errors :) and 
> committed)

Yup, that would explain it.

> I have the gut feeling that it might be fixable by some magical incantation to
> connect the refs to my branch. But I don't know git internal very well. I need
> your help. My work obviously depend upon it.

Most likely, the only thing you actually need to do is simply

	git rebase --abort

and it will just take you back to the state you were in before the rebase, 
and now you'll have to redo it all.

BUT. You can also decide that instead of doing that, you want to keep the 
work you did do, and just try to continue. You'll just need to figure out 
where you are, and where the rest of the commits you want to do are.

And those things should not be so hard to figure out, at least if you 
still have a reasonably good idea about what the commits were that you 
cared about. You just need to find all the relevant development tips, and 
it turns out that that is actually mostly pretty easy.

You have one right there: the current disconnected HEAD you are on is one 
tip. You can save that one away by making that a real branch, so you don't 
lose it, with something like

	git branch middle-of-rebase

which will just take your current state, and make it the new branch 
'middle-of-rebase'.

You can also try to get a better view of where you are by doing

	gitk --all

to show all the branches graphically, which is usually a great way to get 
your bearings. Keep the gitk window open in the background as a reference.

After that, do

	git log -g

wher the "-g" (or "--walk-reflogs" for the long version) just means that 
instead of looking through history as a chain of commits and their 
parents, you look through not the chain of commits, but as the chain of 
reflog entries (which are basically about how the HEAD has changed due to 
the commands you have done).

In all of that info, look for the place you want to go back to, and just 
start all over from there. You can either re-use one of your old branches 
and just start over from some state that you want:

	git checkout <branch>
	git reset --hard <startingpoint>

or you can decide that you want to start a new branch to fix up the mess 

	git checkout -b <newbranch> <startingpoint>

and only when it's all fixed up and you're happy will you change any of 
your old branches.

But it may well be that "git rebase --abort" and re-doing everything is
the least confusing option.

			Linus
