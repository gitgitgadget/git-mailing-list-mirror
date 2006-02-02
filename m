From: Junio C Hamano <junkio@cox.net>
Subject: Re: Two ideas for improving git's user interface
Date: Wed, 01 Feb 2006 18:25:46 -0800
Message-ID: <7vek2mzec5.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
	<7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011125370.5397@localhost.localdomain>
	<7vhd7ibza2.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011307250.21884@g5.osdl.org>
	<7v8xsu91vf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602011433290.21884@g5.osdl.org>
	<87lkwupsbr.wl%cworth@cworth.org>
	<7v1wym4msq.fsf@assigned-by-dhcp.cox.net>
	<87irrya7bx.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 02 03:26:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4UAh-0003a0-4F
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 03:26:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422866AbWBBCZt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 21:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422867AbWBBCZt
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 21:25:49 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:4270 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1422866AbWBBCZs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 21:25:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060202022320.LYYL26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 21:23:20 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87irrya7bx.wl%cworth@cworth.org> (Carl Worth's message of "Wed,
	01 Feb 2006 17:16:18 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15478>

Carl Worth <cworth@cworth.org> writes:

> If not, we should be able to simplify things since a lot of the
> UI complexity being discussed (-a vs. no -a, path names vs. no path
> names), hinges on the handling of skewed files.

I am in agreement with you that "skewed files" might lead to
confusion, but I do not see how that relates to "-a vs no -a" nor
"path names vs no path names" issues.

Let's say we try to detect and forbid committing skewed files.  How
would we do that?  For the sake of clarity, let's say we fixed the
commit command the way I said in the message you are responding.

Now:

1. "git commit" is the traditional one; it commits the current index.
   We enumerate paths that 'git-diff-index --cached --name-only HEAD'
   tells are different (they are the paths to be committed -- what
   about merges?  Maybe take union from all parents?).  Then we see if
   the paths from "git-diff-files --name-only" (locally modified
   files) overlap with them.  Overlapping ones will be skewed if we
   make a commit.

2. "git commit --also fileA..." updates fileA... on top of the current
   index and commits that.  After doing "git update-index fileA...",
   the story is the same as the previous case.

3. "git commit fileA..." initializes a temporary index from the
   current HEAD, updates fileA... and commits that.  We would need a
   check to make sure index matches HEAD at specified paths, but after
   that check passes, there is no skewed files being committed and
   there is nothing more to check.

4. "git commit -a" by definition would not have skewed files and there
   is nothing to check.

So what you say sounds doable.  But I wonder if that really helps
much.

Let's say we want to give an interface to a class of users who do
_not_ want to worry about the presense of the index file.  That means
they will _never_ run "git update-index" themselves, although "git
commit", "git add", and "git merge" may run update-index for them
internally.  Essentially, you tell them to always use "git commit -a"
or "git commit fileA...", and do not teach them "git commit", "git
commit --also fileA...".  IOW they will be doing only 3 or 4.  In this
case, we do not need any of the "skewed files" check.

The extra checks in 1 and 2 would prevent index-unaware users from
making obvious mistakes, but if they do not understand index then they
would still be surprised anyway.  For example, "git commit" commits
the files they previously run "git add" on, but leaves other modified
files in the working tree uncommitted.  This is different from either
3 or 4 that they have learned so far.  If they did "git commit fileA",
the file earlier they run "git add" is not committed.  If they did
"git commit -a", files other than the added files are also committed.
So in that sense the above checks are doable but I do not think it
helps that much to alleviate the confusion.

These extra checks in 1 and 2 may protect index-aware users from
making mistakes, to a certain degree.  I am not convinced enough
myself to pay the cost of extra checks, though, because my workflow is
to do the final review exactly like what you said below.

> My workflow has been to always perform a final review of such a diff
> while composing the commit message. I'd like to be able to do that
> with git.

That matches my workflow.  I do either one of these (I never use "git
commit paths..."):

	$ work work work
        $ I may do update-index [--add|--remove] here
        $ git diff --cached
        $ git commit

	$ work work work
        $ I may do update-index [--add|--remove] here
        $ git diff HEAD
        $ git commit -a

In either cases "skewed files" do not matter.  This can be summarized
in a short paragraph:

	If you are going to commit with "git commit" (no parameters),
	check the final result with "git diff --cached".  If you are
	going to commit with "git commit -a", check with "git diff
	HEAD".

I said why I do not do "git commit paths..." myself, but I think this
"skewed files" discussion adds another thing to be careful about if
you use it.  If you do this (with the current tool, you drop --also):

	$ work on file A
        $ git diff A
        ... that looks fine so far ...
        $ git update-index A
        $ work more on file A
        $ git diff A
        ... incrementally that looks fine ...
        $ git commit --also A

you would end up commiting something you have not done the "final
review".  You need to have the final check before such a commit:

	$ work on file A
        $ git diff A
        ... that looks fine so far ...
        $ git update-index A
        $ work more on file A
        $ git diff A
        ... incrementally that looks fine ...
 +++++  $ git diff HEAD
        $ git commit --also A

This includes all changes that are not in the index and are not going
to be included in the commit (i.e. changes to files other than A).
For that you may need to do something like:

	git-diff-index --cached HEAD ;# already in index but do not look at A
        git-diff-index HEAD -- A ;# and path A is taken from working tree

which is a bit cumbersome.

Without --also (the new semantics), the check would be
straightforward:

	$ work on file A
        $ git diff A
        ... that looks fine so far ...
        $ git update-index A
        $ work more on file A
        $ git diff A
        ... incrementally that looks fine ...
 +++++  $ git diff HEAD -- A
	$ git commit A
