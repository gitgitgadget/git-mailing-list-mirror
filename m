From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Re: Re: Add "clone" support to lntree
Date: Sat, 16 Apr 2005 20:07:36 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504161951160.30848-100000@iabervon.org>
References: <20050416233305.GO19099@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 02:04:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMxGo-0006pQ-9C
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 02:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVDQAHw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 20:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVDQAHw
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 20:07:52 -0400
Received: from iabervon.org ([66.92.72.58]:61191 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261214AbVDQAHU (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 20:07:20 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DMxK4-0007KQ-00; Sat, 16 Apr 2005 20:07:36 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050416233305.GO19099@pasky.ji.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 17 Apr 2005, Petr Baudis wrote:

> Dear diary, on Sat, Apr 16, 2005 at 05:17:00AM CEST, I got a letter
> where Daniel Barkalow <barkalow@iabervon.org> told me that...
> > On Sat, 16 Apr 2005, Petr Baudis wrote:
> > 
> > > Dear diary, on Sat, Apr 16, 2005 at 04:47:55AM CEST, I got a letter
> > > where Petr Baudis <pasky@ucw.cz> told me that...
> > > > 	git branch --- creates a branch from a given commit
> > > > 			(when passed empty commit, creates a branch
> > > > 			from the current commit and sets the working
> > > > 			tree to that branch)
> > > > Note that there is a bug in current git update - it will allow you to
> > > > bring several of your trees to follow the same branch, or even a remote
> > > > branch. This is not even supposed to work, and will be fixed when I get
> > > > some sleep. You will be able to do git pull even on local branches, and
> > > > the proper solution for this will be just tracking the branch you want
> > > > to follow.
> > > 
> > > I must admit that I'm not entirely decided yet, so I'd love to hear your
> > > opinion.
> > > 
> > > I'm wondering, whether each tree should be fixed to a certain branch.
> > > That is, you decide a name when you do git fork, and then the tree
> > > always follows that branch. (It always has to follow [be bound to]
> > > *some* branch, and each branch can be followed by only a single tree at
> > > a time.)
> > 
> > I don't think I'm following the use of branches. Currently, what I do is
> > have a git-pasky and a git-linus, and fork off a working directory from
> > one of these for each thing I want to work on. I do some work, commit as I
> > make progress, and then do a diff against the remote head to get a patch
> > to send off. If I want to do a series of patches which depend on each
> > other, I fork my next directory off of my previous one rather than off of
> > a remote base. I haven't done much rebasing, so I haven't worked out how I
> > would do that most effectively.
> 
> Yes. And that's exactly what the branches allow you to do. You just do
> 
> 	git fork myhttpclient ~/myhttpclientdir
> 
> then you do some hacking, and when you have something usable, you can
> go back to your main working directory and do
> 
> 	git merge -b when_you_started myhttpclient
> 
> Since you consider the code perfect, you can now just rm -rf
> ~/myhttpclient.
> 
> Suddenly, you get a mail from mj pointing out some bugs, and it looks
> like there are more to come. What to do?
> 
> 	git fork myhttpclient ~/myhttpclientdir
> 
> (Ok, this does not work, but that's a bug, will fix tomorrow.) This will
> let you take off when you left in your work on the branch.

Ah, I think that's what made me think I wasn't understanding branches; the
first thing I tried hit this big.

> git update for seeking between commits is probably extremely important
> for any kind of binary search when you are wondering when did this bug
> appeared first, or when you are exploring how certain branch evolved
> over time. Doing git fork for each successive iteration sounds horrible.

Even if there isn't a performance hit, it's semantically wrong, because
you're looking at different versions that were in the same place at
different times.

> Now, what about git branch and git update for switching between
> branches? I think this is the most controversial part; these are
> basically just shortcuts for not having to do git fork, and I wouldn't
> mind so much removing them, if you people really consider them too ugly
> a wart for the soft clean git skin. I admit that they both come from a
> hidden prejudice that git fork is going to be slow and eat a lot of
> disk.

I think that this just confuses matters.

> The idea for git update for switching between branches is that
> especially when you have two rather similar branches and mostly do stuff
> on one of them, but sometimes you want to do something on the other one,
> you can do just quick git update, do stuff, and git update back, without
> any forking.

I still think that fork should be quick enough, or you could leave the
extra tree around. I'm not against having such a command, but I think it
should be a separate command rather than a different use of update, since
it would be used by poeople working in different ways.

> > I think I can make this space efficient by hardlinking unmodified blobs to
> > a directory of cached expanded blobs.
> 
> I don't know but I really feel *very* unsafe when doing that. What if
> something screws up and corrupts my base... way too easy. And it gets
> pretty inconvenient and even more dangerous when you get the idea to do
> some modifications on your tree by something else than your favorite
> editor (which you've already checked does the right thing).

It should only be an option, not required and maybe not even
default. I think it should be possible to prevent stuff from screwing up,
since we really don't want anything to ever modify those inodes (as
opposed to some cases, where you want to modify inodes only in certain
ways). For that matter, relatively few programs actually support
modifying inodes rather than unlinking.

	-Daniel
*This .sig left intentionally blank*

