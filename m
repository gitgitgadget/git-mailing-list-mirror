From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: [RFC] undo and redo
Date: Thu, 25 Aug 2005 10:32:01 -0600
Organization: Hewlett Packard
Message-ID: <20050825163201.GA3944@hpsvcnb.fc.hp.com>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com> <20050824181004.GA18790@hpsvcnb.fc.hp.com> <Pine.LNX.4.58.0508241148480.3317@g5.osdl.org> <20050824195615.GA693@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241634350.23242@iabervon.org> <20050824204736.GA13194@hpsvcnb.fc.hp.com> <Pine.LNX.4.63.0508241651420.23242@iabervon.org> <7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net> <20050825024134.GA31886@hpsvcnb.fc.hp.com> <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 18:36:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8KeD-0005qf-3D
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 18:32:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932283AbVHYQcJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 12:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbVHYQcJ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 12:32:09 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:19418 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S932283AbVHYQcI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 12:32:08 -0400
Received: from smtp1.fc.hp.com (smtp1b.fc.hp.com [15.15.136.127])
	by atlrel6.hp.com (Postfix) with ESMTP id 89EAA8876;
	Thu, 25 Aug 2005 12:32:07 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp1.fc.hp.com (Postfix) with ESMTP
	id 27FD8384DD; Thu, 25 Aug 2005 16:32:02 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id E95EE2B093; Thu, 25 Aug 2005 10:32:01 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7752>

On Wed, Aug 24, 2005 at 10:06:45PM -0700, Junio C Hamano wrote:
> > So, I've tried cloning, pulling to|from, pushing to|from and resolving
> > merges in a repository with undo information stored under
> > .git/refs/undo.  None of these operations seem to notice the existence
> > of this directory.  I think this is good.
> 
> What I meant was that, when "undo/bar" is a tree object, things
> may work in a funny way:
> 
>     $ git pull ../repo-with-undo/.git refs/undo/bar
> 
>     $ git push ../other-repo/.git undo/bar:refs/heads/foo
>     $ cd ../other-repo && git resolve master foo 'Attempt to merge undo'

I was thinking that undo trees should not be pushed and pulled between
repositories.  For this I would use a new branch with proper commits as
Linus suggested.

> I think this undo/redo first needs to be thought about how best
> it is used.  My guess is that the workflow you have in mind is
> something like this:
> 
>     $ git checkout master
>     $ hack hack hack
>     # Hmph, it almost works, and but my boss says work on
>     # some other feature that is more urgent
>     $ git undo
>     Saved current state as 2005-08-24T20:32:22
>     $ work work work
>     $ git commit -m 'Boring but urgent fix'
>     # Ok, now let's back to the thing I wanted to do.
>     $ git redo
>     # I happen to know it is the last undo, so I did not name
>     # it, but I could have said 2005-08-24T20:32:22
>     $ hack more
>     $ git commit -m 'Finally fix frotz.'

For this, I may also use branching, as suggested.  I meant for undo/redo
to be a lighter weight alternative to allow for a faster context switch.
I am reluctant to commit what I have in my working directory unless I
have taken the time to review the changes using diff tools and cleaned
up considerably.  This is my way of being a careful developer.  Not all
developers share my style but I know many that do.  This makes
committing a heavy weight operation for me.

So, referring to your example.  If my 'boss' says that I need to switch
to working on 'Boring but urgent fix' for the next *week* or more I will
likely take the time to make the full context switch to a new branch and
work on the fix.  I may also choose to just clone my repository and use
a new working directory.  If the fix takes just a day or two I may do
the same.

Now, let's say that the 'fix' is something that I can do in an hour or
two and quickly get back to where I was.  In this context, making the
full context switch can feel very cumbersome compared to the amount of
work required to make the fix.  Now, a simple 'git undo' will ease this
switch.

Another example is if I'm working on a commit and suddenly get a
brilliant idea for some easy modification that I want to make and commit
by itself before making this commit.  I can do this easily with

        % git undo
        % carefully make easy change
        % git commit
        % git redo

Having a light-weight alternative like this could make the difference
between realizing the easy, brilliant idea and forgetting about it on
the back burner because it was just too cumbersome to make the context
switch.

The bottom line is that I don't argue against using the existing
work-flows.  I hope to add the flexibility to use various work-flows to
fit the job at hand.

[ stuff deleted ]

>     $ git checkout master
>     $ hack hack hack
>     # Hmph, it almost works, and but my boss says work on
>     # some other feature that is more urgent
>     $ git commit -m 'WIP - fix frotz'
>     $ git branch anchor-frotz
>     $ git reset --hard master^
>     $ work work work
>     $ git commit -m 'Boring but urgent fix'
>     # Ok, now let's go back to the thing I wanted to do.
>     $ git pull . anchor-frotz
>     $ rm .git/heads/anchor-frotz
>     $ git reset --soft master^
>     $ hack more
>     $ git commit -m 'Finally fix frotz.'

Again, these are effective.  I simply want to provide an alternative
light weight way of accomplishing this.

> The above flow would be something somebody not so organized
> (like myself) would do.  A perfect person would have done this:
> 
>     $ git checkout -b frotz master
>     $ hack hack hack
>     # Hmph, it almost works, and but my boss says work on
>     # some other feature that is more urgent
>     $ git commit -m 'WIP - fix frotz'
>     $ git checkout master
>     $ work work work
>     $ git commit -m 'Boring but urgent fix'
>     # Ok, now let's go back to the thing I wanted to do.
>     $ git checkout frotz
>     $ git reset --soft HEAD^
>     $ hack more
>     $ git commit -m 'Finally fix frotz.'
>     $ git checkout master
>     $ git pull . frotz
>     $ rm .git/refs/heads/frotz
> 
> The "perfect person" approach has an added benefit that you
> could have made intermediate commits while doing "hacking",
> because your hackery is always done in the "frotz" branch.
> 
> Of course, the scenarios your undo/redo is useful for may not be
> limited to this "handling interrupt" use case.  If that is the
> only thing it solves, then I do not see much point having them
> as new commands.  I think the undo/redo has potential beyond
> that.

What other potential do you see?  I sounds like you had a stream of
thought here that didn't make it in the email.  I think there are
probably many ways that it can be useful.  I'll ask some of my
colleagues here who have liked undo/redo type functionality what they
think.

I think it would be impossible to think of all of the possibilities
ahead of time.  But, if you've thought of some, please share :-)

> So let's first clarify what kind of workflow these new commands
> would help, how well that workflow is applicable in general, and
> then how well these new commands would help that workflow.
> 
> > I would be glad to write up documentation and provide a patch.
> 
> Sure.  I think a set of patches for new commands, and new
> options to existing commands should ideally include the
> following:
> 
>  - Justification, such as:
> 
>    - The problems new commands/options address.
>    - The expected workflow the new commands/options fit in.
>    - How useful that workflow is.
>    - How impossible or cumbersome to achieve that workflow using
>      existing tools.
> 
>    Some of these should go to the commit log message, and the
>    documentation to describe the "best practice" workflow using
>    the new feature should go to Documentation/howto/ directory.
> 
>  - Documentation.  Files Documentation/git-*.txt to describe
>    new commands or updates to existing pages, new entry in
>    Documentation/Makefile as necessary, and a new link from
>    Documentation/git.txt to reach that page.
> 
>  - Implementation.
> 
>  - Test scripts in t/ directory, either a new test script or
>    updates to existing ones, if the patch is to fix existing
>    implementation.

This all sounds reasonable.  I'm willing to do this work.

Cheers,
Carl

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
