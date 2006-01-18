From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Wed, 18 Jan 2006 14:29:02 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601181359400.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
 <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de>
 <7vek37rj83.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601170001130.25300@iabervon.org>
 <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601171150050.25300@iabervon.org>
 <7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601181214150.25300@iabervon.org>
 <7v4q41wevw.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 20:27:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzIxc-0002pw-N0
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 20:27:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964776AbWART1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 14:27:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964920AbWART1J
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 14:27:09 -0500
Received: from iabervon.org ([66.92.72.58]:13580 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964916AbWART1I (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 14:27:08 -0500
Received: (qmail 27973 invoked by uid 1000); 18 Jan 2006 14:29:02 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jan 2006 14:29:02 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v4q41wevw.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14861>

On Wed, 18 Jan 2006, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > ... I thought we 
> > decided that the stuff that doesn't know about subprojects sees them as 
> > opaque, rather than as their contents, so your toplevel git diff doesn't 
> > show you a millions lines when you switch from linux-2.6.14 to 15.
> 
> It was discussed in the context of "gitlink" approach as a way
> to keep things simple.  In the "bind" approach, I am doing
> things a bit differently, and this "toplevel has everything" is
> one big difference.

I thought that had been a question of what is best as an interface, but 
either is plausible.

> > I thought we decided that committing the superproject wouldn't
> > commit the subprojects.
> 
> I see it as a policy.  We can forbid the modification of the
> subproject part of the index (i.e. detect and refuse to commit
> and/or do "git reset --mixed" only for the subproject part) so
> that the commit outlined in the "bind" approach does not _have_
> to make a new commit, if you want to work that way.  But if
> somebody else wants to make a related set of changes to the
> superproject and bound subprojects, we _could_ allow a commit
> per subproject.

I think it makes most sense, for the purpose of consolidating code paths, 
if the superproject may only be committed with clean subprojects; the 
porcelain has the option of responding to unclean subprojects by 
committing them to make them clean, and then there is only a single case 
for how the superproject commit happens. I think it makes most sense as a 
command line option, like -a is; if you want to commit dirty suprojects, 
you use --subprojects, and it does that. If you're not expecting to need 
it, you won't start doing the wrong commit.

> > I hope people will want to prepare their commits to the kernel subproject 
> > as would be suitable for pushing to Linus, which would suggest that they'd 
> > tend to do a commit in the kernel subproject embedded in their 
> > superproject separately from doing the commit in the superproject, and 
> > so the branch head would match the index but not the bind line when they 
> > got to committing the superproject.
> 
> Yes, that is the workflow I outlined in the footnote part you
> did not quote.  I think it is cleaner to do things that way: to
> have a separate, kernel-only repository+worktree and do pure
> kernel work there, and fetch into the superproject branch that
> keeps track of the kernel subproject in that superproject.

I actually meant that I expected people to go into superproject/linux-2.6, 
make changes, and commit there, using the place it appears in their 
superproject working tree as a working tree for the subproject, so the 
opposite of your footnote, but still doing the subproject commit as a step 
before the superproject commit.

For example, they might want to send the subproject changes upstream as a 
patch, get feedback, reset the subproject, do revised changes, commit 
that, get it merged upstream, and then commit the changes to the 
superproject, including in the message the fact that the changes have been 
pushed upstream. But they may still want to do this all within the working 
tree of the superproject, so that they can test their changes in context.

> Having more than one working tree with .git/, everything except
> HEAD and index undef which are symlinked to one copy, like you
> do, would be a natural way to work.
> 
> 	embed/.git/HEAD -> refs/heads/master
> 
> 	embed/linux-2.6/.git/HEAD -> refs/heads/kernel
> 	embed/linux-2.6/.git/refs -> ../.git/refs
> 	embed/linux-2.6/.git/objects -> ../.git/objects
> 
> Then, after hacking on the collective whole to make the whole
> thing work in "embed" directory, you would:
> 
> 	$ cd linux-2.6
>         $ git commit
> 
> to make commit that can be sent Linus, at the same time updating
> the "kernel" branch.  Then come back to the toplevel, tell git
> that you updated the "kernel" branch so it does not complain
> that the "bind" in the HEAD commit does not match "kernel" head,
> and make a toplevel commit.

I'm not sure having a .git directory for a subproject inside a 
subdirectory of the superproejct's working tree is all that good an idea, 
and I don't think it should be necessary in any case, because the toplevel 
index has all the information from the subproject index. The only think 
would be having "git commit" notice what you're doing when you run it from 
a directory that's a subproject.

	-Daniel
*This .sig left intentionally blank*
