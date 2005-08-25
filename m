From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] undo and redo
Date: Wed, 24 Aug 2005 22:06:45 -0700
Message-ID: <7v1x4izjtm.fsf@assigned-by-dhcp.cox.net>
References: <20050824172339.GA7083@hpsvcnb.fc.hp.com>
	<20050824181004.GA18790@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.58.0508241148480.3317@g5.osdl.org>
	<20050824195615.GA693@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241634350.23242@iabervon.org>
	<20050824204736.GA13194@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0508241651420.23242@iabervon.org>
	<7vd5o3ar4a.fsf@assigned-by-dhcp.cox.net>
	<20050825024134.GA31886@hpsvcnb.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 25 07:07:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E89x2-00014r-QI
	for gcvg-git@gmane.org; Thu, 25 Aug 2005 07:06:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750832AbVHYFGt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVHYFGt
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 01:06:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:45492 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750832AbVHYFGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Aug 2005 01:06:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050825050646.IHPN19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 Aug 2005 01:06:46 -0400
To: Carl Baldwin <cnb@fc.hp.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7744>

> So, I've tried cloning, pulling to|from, pushing to|from and resolving
> merges in a repository with undo information stored under
> .git/refs/undo.  None of these operations seem to notice the existence
> of this directory.  I think this is good.

What I meant was that, when "undo/bar" is a tree object, things
may work in a funny way:

    $ git pull ../repo-with-undo/.git refs/undo/bar

    $ git push ../other-repo/.git undo/bar:refs/heads/foo
    $ cd ../other-repo && git resolve master foo 'Attempt to merge undo'

I think this undo/redo first needs to be thought about how best
it is used.  My guess is that the workflow you have in mind is
something like this:

    $ git checkout master
    $ hack hack hack
    # Hmph, it almost works, and but my boss says work on
    # some other feature that is more urgent
    $ git undo
    Saved current state as 2005-08-24T20:32:22
    $ work work work
    $ git commit -m 'Boring but urgent fix'
    # Ok, now let's back to the thing I wanted to do.
    $ git redo
    # I happen to know it is the last undo, so I did not name
    # it, but I could have said 2005-08-24T20:32:22
    $ hack more
    $ git commit -m 'Finally fix frotz.'

I see some problems in this.

One is minor.  As you mentioned about "giving undo a symbolic
name", after you accumulate a handful undo, you would need them
to have descriptive names, and a way to list them before using
"git redo".

But as Linus suggested in another reply, you could as well have
done this without inventing these two commands.

    $ git checkout master
    $ hack hack hack
    # Hmph, it almost works, and but my boss says work on
    # some other feature that is more urgent
    $ git commit -m 'WIP - fix frotz'
    $ git branch anchor-frotz
    $ git reset --hard master^
    $ work work work
    $ git commit -m 'Boring but urgent fix'
    # Ok, now let's go back to the thing I wanted to do.
    $ git pull . anchor-frotz
    $ rm .git/heads/anchor-frotz
    $ git reset --soft master^
    $ hack more
    $ git commit -m 'Finally fix frotz.'

The above flow would be something somebody not so organized
(like myself) would do.  A perfect person would have done this:

    $ git checkout -b frotz master
    $ hack hack hack
    # Hmph, it almost works, and but my boss says work on
    # some other feature that is more urgent
    $ git commit -m 'WIP - fix frotz'
    $ git checkout master
    $ work work work
    $ git commit -m 'Boring but urgent fix'
    # Ok, now let's go back to the thing I wanted to do.
    $ git checkout frotz
    $ git reset --soft HEAD^
    $ hack more
    $ git commit -m 'Finally fix frotz.'
    $ git checkout master
    $ git pull . frotz
    $ rm .git/refs/heads/frotz

The "perfect person" approach has an added benefit that you
could have made intermediate commits while doing "hacking",
because your hackery is always done in the "frotz" branch.

Of course, the scenarios your undo/redo is useful for may not be
limited to this "handling interrupt" use case.  If that is the
only thing it solves, then I do not see much point having them
as new commands.  I think the undo/redo has potential beyond
that.

So let's first clarify what kind of workflow these new commands
would help, how well that workflow is applicable in general, and
then how well these new commands would help that workflow.

> I would be glad to write up documentation and provide a patch.

Sure.  I think a set of patches for new commands, and new
options to existing commands should ideally include the
following:

 - Justification, such as:

   - The problems new commands/options address.
   - The expected workflow the new commands/options fit in.
   - How useful that workflow is.
   - How impossible or cumbersome to achieve that workflow using
     existing tools.

   Some of these should go to the commit log message, and the
   documentation to describe the "best practice" workflow using
   the new feature should go to Documentation/howto/ directory.

 - Documentation.  Files Documentation/git-*.txt to describe
   new commands or updates to existing pages, new entry in
   Documentation/Makefile as necessary, and a new link from
   Documentation/git.txt to reach that page.

 - Implementation.

 - Test scripts in t/ directory, either a new test script or
   updates to existing ones, if the patch is to fix existing
   implementation.
