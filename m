From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/4] Add git-rewrite-commits
Date: Sun, 8 Jul 2007 19:41:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707081920410.4248@racer.site>
References: <11839118073186-git-send-email-skimo@liacs.nl>
 <1183911808787-git-send-email-skimo@liacs.nl> <Pine.LNX.4.64.0707081729040.4248@racer.site>
 <46912726.5080807@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: skimo@liacs.nl, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Sun Jul 08 20:49:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7bp2-0002OY-0K
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 20:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755100AbXGHStZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 14:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754858AbXGHStZ
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 14:49:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:58670 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754726AbXGHStY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 14:49:24 -0400
Received: (qmail invoked by alias); 08 Jul 2007 18:49:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 08 Jul 2007 20:49:22 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18VyC8quQIVcPNeMP094EWn8PrYeqpGTw5NRTKiMU
	cMprZ+VVYACdH/
X-X-Sender: gene099@racer.site
In-Reply-To: <46912726.5080807@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51907>

Hi,

On Sun, 8 Jul 2007, Steven Grimm wrote:

> Johannes Schindelin wrote:
>
> > I am really unhappy that so much is talked about filtering out 
> > commits. That is amost certainly not what you want in most cases.  In 
> > particular, I suspect that most users would expect the _changes_ 
> > filtered out by such a command, which is just not true.
> >   
> 
> I agree that unless it's named and documented very carefully, users 
> might expect this to tweak history such that the commits in question 
> never happened (unlike revert, which of course adds a new commit and 
> leaves the old ones alone.) The documentation for this command could 
> stand to be more explicit about that.

In the documentation of filter-branch, you have at least a couple of more 
useful examples, and the misunderstanding is cleared up.  At least a 
little.

> > Further, I do not see much value in making this operation faster.  It 
> > is meant to be a one-time operation, for example when you open-source 
> > a product and have to cull a lot of history that you must not show for 
> > legal reasons.  It is a one-shot operation.
> 
> Your recent changes to git-rebase (which, BTW, are great) include a 
> feature that's very similar to this: the "squash these commits together 
> in my history" feature. That'd be my use case for this, when I want to 
> publish my changes to other developers who don't care about all my 
> intermediate checkpoints of work in progress, and when the commits I'm 
> removing haven't been published anywhere else yet.
> 
> With this command, I could do something like:
> 
> git rewrite-commits --grep="!@@@checkpoint"
> git push

git reset --head HEAD~<n> &&
git rev-list --pretty=oneline ..HEAD@{1} | while read sha1 message
do
	git cherry-pick -n $sha1 || exit
	case "$message" in
	*@@@checkpoint*) ;;
	*) git commit -C $sha1;;
	esac
done

Yes, it is longer than the command line you gave.  But it does not need 
any fancy new stuff, so it works even on 1.4.4.4.  And you can make that a 
script, or if you really need to, an alias.  Since you want to avoid the 
interactivity, rebase -i is kind of the wrong place to look.

> and it would strip out all my intermediate checkpoint commits (assuming 
> I've marked them as such in my commit comments, which I always do) 
> before pushing to my project's shared repo. Right now that's a much more 
> cumbersome, and very manual, operation. Even with the new git-rebase 
> changes, I still have to pick out those commits by hand, and it assumes 
> that I otherwise want to do a rebase in the first place.

If you _have_ to use some fancy stuff, you can fake an editor by 
resetting VISUAL, like illustrated in t3404.

> > So there are two things I see here that filter-branch cannot do yet.  
> > The first is to rewrite _all_ branches, which should be easy to do, it 
> > only has to be done.
> 
> I wonder if it makes sense to go that direction, though, or to make this 
> command do the things that filter-branch can do, for the simple reason 
> that filter-branch is a shell script and this is already a nice 
> non-shell-dependent C program.

Exactly it is a C program.  And if you are fleshing out issues, it is 
always easier to work on a shell script.  That is why git-remote is still 
a perl script; the semantics are not yet flashed out, and it is orders of 
magnitudes slower to change them in C.  And to test them in C.

Besides, it is way easier to fsck up some obscure detail in C, since you 
have low-level access to everything.  And those bugs are harder to spot.  
In shell, you have a limited interface, but for prototyping, that is 
actually an advantage.

> Obviously you end up in the same place either way eventually once 
> filter-branch percolates to the top of the "port these scripts to C" 
> list, but it seems odd to me to port features from a C program back to a 
> shell script only to have to convert the shell script to C later on.

Hey, if skimo would be willing to work until it is a complete replacement 
for filter-branch, and more, I will stop working on filter-branch at once.  
Somehow I did not get this impression, however.

> Ironically, this app doesn't really speed up the one thing I find too 
> slow in filter-branch: the "remove a file from the tree in all 
> revisions" case. To do that you still have to launch a filter app for 
> every commit, which is especially bad when the file in question only 
> appears in a few revisions deep in the history of a repo.

Semantics.  That is the stage we are at.  Trying to find the best 
semantics.

Filtering out single files might well suffice for you.  However, I think 
that this is only a very special corner case of something much bigger and 
more versatile.  ATM I am quite certain that the eval'ed filters are the 
way to go.

Since even in your corner case, you usually do it _once_.

> This command points us in the direction of a "remove/rename this file in 
> history" feature that doesn't require forking tens of thousands of child 
> processes on a repo with lots of history. For that alone I think it's 
> worthwhile, even though it's not there yet; that will never happen with 
> a shell script. And yeah, that's not a frequent operation, but it's sure 
> nice when even the infrequent operations are lightning fast.

It is sure nice when the frequent operations get lightning fast _first_.

Ciao,
Dscho
