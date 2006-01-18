From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Wed, 18 Jan 2006 10:49:07 -0800
Message-ID: <7v4q41wevw.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
	<200601161144.48245.Josef.Weidendorfer@gmx.de>
	<7vek37rj83.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601170001130.25300@iabervon.org>
	<7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601171150050.25300@iabervon.org>
	<7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601181214150.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:50:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIMt-0001Hi-4W
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:49:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030264AbWARStM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030275AbWARStM
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:49:12 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:46498 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1030264AbWARStL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jan 2006 13:49:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118184658.ILEH26964.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 18 Jan 2006 13:46:58 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.64.0601181214150.25300@iabervon.org> (Daniel
	Barkalow's message of "Wed, 18 Jan 2006 13:21:59 -0500 (EST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14853>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I assume these get updated by checkout when you check out the commit with 
> them as bind lines?

I did not think of that when I wrote that message, but you are right.

> Ah, okay, so it's cheating for checkout, because checkout is supposed to 
> understand everything, but not cheating for other things.

Yeah; to put it another way, read-tree of the toplevel tree and
checking it out is equivalent to do the skelton read-tree
followed by --prefix read-tree of all the bound projects, so
checkout can optimize.

> ... I thought we 
> decided that the stuff that doesn't know about subprojects sees them as 
> opaque, rather than as their contents, so your toplevel git diff doesn't 
> show you a millions lines when you switch from linux-2.6.14 to 15.

It was discussed in the context of "gitlink" approach as a way
to keep things simple.  In the "bind" approach, I am doing
things a bit differently, and this "toplevel has everything" is
one big difference.

> I thought we decided that committing the superproject wouldn't
> commit the subprojects.

I see it as a policy.  We can forbid the modification of the
subproject part of the index (i.e. detect and refuse to commit
and/or do "git reset --mixed" only for the subproject part) so
that the commit outlined in the "bind" approach does not _have_
to make a new commit, if you want to work that way.  But if
somebody else wants to make a related set of changes to the
superproject and bound subprojects, we _could_ allow a commit
per subproject.

> Shouldn't "git read-tree --prefix=linux-2.6/ -u kernel" remove everything 
> else in the index in linux-2.6 itself, making the "git update-index 
> --force-remove" unnecessary?

I agree that "-u" should imply that.  The current "read-tree
--prefix=linux-2.6/" in proposed updates refuses if linux-2.6/
appears in the original index.

> I hope people will want to prepare their commits to the kernel subproject 
> as would be suitable for pushing to Linus, which would suggest that they'd 
> tend to do a commit in the kernel subproject embedded in their 
> superproject separately from doing the commit in the superproject, and 
> so the branch head would match the index but not the bind line when they 
> got to committing the superproject.

Yes, that is the workflow I outlined in the footnote part you
did not quote.  I think it is cleaner to do things that way: to
have a separate, kernel-only repository+worktree and do pure
kernel work there, and fetch into the superproject branch that
keeps track of the kernel subproject in that superproject.

Having more than one working tree with .git/, everything except
HEAD and index undef which are symlinked to one copy, like you
do, would be a natural way to work.

	embed/.git/HEAD -> refs/heads/master

	embed/linux-2.6/.git/HEAD -> refs/heads/kernel
	embed/linux-2.6/.git/refs -> ../.git/refs
	embed/linux-2.6/.git/objects -> ../.git/objects

Then, after hacking on the collective whole to make the whole
thing work in "embed" directory, you would:

	$ cd linux-2.6
        $ git commit

to make commit that can be sent Linus, at the same time updating
the "kernel" branch.  Then come back to the toplevel, tell git
that you updated the "kernel" branch so it does not complain
that the "bind" in the HEAD commit does not match "kernel" head,
and make a toplevel commit.
