From: Petr Baudis <pasky@suse.cz>
Subject: Re: "tla missing -s" equivalent with git/cogito
Date: Wed, 18 Jan 2006 19:55:42 +0100
Message-ID: <20060118185542.GT28365@pasky.or.cz>
References: <43CE5666.90502@itaapy.com> <46a038f90601180956r69ba5dffl2106f697a6be4750@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: luis@itaapy.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:54:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIRy-0002dW-Hy
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:54:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWARSy1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030298AbWARSy1
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:54:27 -0500
Received: from w241.dkm.cz ([62.24.88.241]:41686 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030256AbWARSy1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 13:54:27 -0500
Received: (qmail 25282 invoked by uid 2001); 18 Jan 2006 19:55:42 +0100
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90601180956r69ba5dffl2106f697a6be4750@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14856>

Dear diary, on Wed, Jan 18, 2006 at 06:56:38PM CET, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> said that...
> Andreas' response is good is you're into pure git. Let me add some
> cogito tricks ;-)
> 
> On 1/19/06, Belmar-Letelier <luis@itaapy.com> wrote:
> > arch-tla equivalent of
> >
> > $ cd project--luis--0.1
> > $ tla missing -sD paul@mail.com--public/project--paul--0.1
> 
>  $ cd project-luis
>  # only if have to do cg-branch-add the first time!
>  $ cg-branch-add paul http://server/git/project.git
>  $ cg-fetch paul
>  # show what paul has that we don't
>  $ cg-log -r master:paul
>  $ cg-diff -r master:paul

I usually do this as

	$ cg-log -m -r paul

which is shorter (and in some situations more accurately describes which
commits are actually going to get merged).

But I believe that Belmar-Letelier might be happier with git-cherry,
since he wants to do cherrypicking (and wrapping that in cg-log might
not be bad idea).

> > or I cherry pick only one of them (here patch-6) with
> >
> > $ tla replay  somefriend@mail.com--public/project--branchA--0.1--patch-6
> 
>   # export the patches paul has that we don't
>   $ mkdir .patchesfrompaul
>   $ git-format-patch --mbox --signoff -o .patchesfrompaul master paul
>   # review the contents of .patchesfrompaul and decide what patches you want
>   $ git-am -3 .patchesfrompaul/0006-fix-frob-invocation.txt

If you just want to pick one commit, it shouldn't be more difficult than

	$ cg-diff -p -r commitid | cg-patch
	$ cg-commit -c commitid

but I was actually thinking about wrapping this up to something like
cg-cherrypick or cg-pick. Perhaps I will just overload cg-patch, though
- I want to add support for autocommitting the patches there anyway.

> When you cherry pick patches, if the patch applies cleanly, the next
> time you do a merge from that branch it will be skipped automagically.
> If the patch needs serious editing, there's a good chance that git
> will try to apply it again.

No, it will not be skipped automagically - GIT really does not properly
support merging  of branch you've cherrypicked before. It might work,
but that's just luck - very similar to the luck you might have when
re-merging branches in CVS using the original merge base.

Imagine having branch with two patches 1 and 2. There is a file X:

	a

Ppatch1:

	-a
	+b
	+c

Patch2:

	-b
	+a
	c

Resulting file:

	a
	c

Now, you've cherrypicked patch1, so your file is:

	b
	c

Now you want to merge the branch as a whole. Cherrypicking-aware VCS
would just merge the patch2, but you are taking the whole diff:

	a
	+c

And you get a conflict instead of b\nc.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
