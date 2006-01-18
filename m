From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: RFC: Subprojects
Date: Wed, 18 Jan 2006 13:21:59 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601181214150.25300@iabervon.org>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
 <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de>
 <7vek37rj83.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601170001130.25300@iabervon.org>
 <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601171150050.25300@iabervon.org>
 <7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 19:20:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzHuz-0002Nu-Ud
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 19:20:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbWARSUI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jan 2006 13:20:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030250AbWARSUI
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jan 2006 13:20:08 -0500
Received: from iabervon.org ([66.92.72.58]:9484 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030257AbWARSUG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jan 2006 13:20:06 -0500
Received: (qmail 27566 invoked by uid 1000); 18 Jan 2006 13:22:00 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 18 Jan 2006 13:22:00 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14850>

On Tue, 17 Jan 2006, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Incidentally, I don't think we'd want "gitlink" objects with the "gitlink" 
> > approach; we'd want trees to contain commit objects for subprojects. The 
> > "gitlink" thing that corresponds to ".git/HEAD" isn't an object, it's a 
> > tree entry, which, like ".git/HEAD" (or, more appropriately, 
> > ".git/refs/heads/something") maps a name to the hash of a commit object.
> 
> > Hmm... maybe libification should go ahead of subprojects. If access to the 
> > index weren't so often open-coded, it would just be a matter of having 
> > these entries in the data structure, but not actually returned by any 
> > current call, and it would be just like they were in some other structure. 
> 
> And libification has been waiting for the core to settle ;-) We
> have to start somewhere.

Well, we could do a pass at cleaning, organizing, and documenting the 
internals, which is sort of the start to each of them.

> > Side issue here: this implies that the kernel objects are in the 
> > superproject's repository, or at least accessible from it. So prune has to 
> > not remove them. So, if you've committed changes to a subproject but not 
> > yet committed the fact that you want to use the changed subproject into 
> > the superproject, fsck-objects has to find them somewhere.
> 
> Yes.  I was planning to have "$GIT_DIR/bind" that says:
> 
> 	master kernel=linux-2.6/ gcc=gcc-4.0/
> 
> meaning:
> 
> 	The project kept track by "master" branch binds the
> 	project kept track by "kernel" branch as its subproject
> 	at its linux-2.6/ subdirectory.
> 
> or something like that, so when you make a commit, you update
> those other branches as needed.  You already raised that issue
> at the end of your message, and I will explain how I think that
> can/should be done as a response to that part later.

Okay, so you're using additional branch heads in the superproject to track 
the current state of the subprojects. That makes sense, although I think 
it would confuse people less if they were held separately. IIRC, 
refs/subprojects/kernel/heads/master is a perfectly good ref name these 
days, so that might be a good idea. That would also mean that 
refs/tags/v2.6.14 and refs/tags/v2.7.2.3 wouldn't get confused (being 
linux and gcc tags, respectively), because they'd be under the appropriate 
subprojects.

I assume these get updated by checkout when you check out the commit with 
them as bind lines?

> >> Reading such a commit is easy:
> >> 
> >> 	$ git-read-tree $tree ;# ;-)
> >> 
> >> But that is cheating.  
> >
> > This is for backwards compatibility, I assume?
> 
> This is done more for not having to touch *anything* that does
> "index vs working file", "tree vs index" and "tree vs working
> file via index".  It also is the easiest way to keep the "a
> commit object name can be used in place of the tree object name
> of the tree it contains" invariant.  Also I suspect this
> organization might help recursive subprojects, but if it is the
> case, that is just a byproduct, not a design goal.

Ah, okay, so it's cheating for checkout, because checkout is supposed to 
understand everything, but not cheating for other things. I thought we 
decided that the stuff that doesn't know about subprojects sees them as 
opaque, rather than as their contents, so your toplevel git diff doesn't 
show you a millions lines when you switch from linux-2.6.14 to 15.

> >> When you have such an index, writing out various trees are:
> >> 
> >> 	$ git-write-tree ;# $tree
> >> 	$ git-write-tree --prefix=linux-2.6/ ;# $linuxsub^{tree}
> >> 	$ git-write-tree --prefix=gcc-4.0/ ;# $gccsub^{tree}
> >> 	$ git-write-tree \
> >>           --bound=linux-2.6/ --bound=gcc-4.0/ ;# $primarysub^{tree}
> >
> > The hard thing here is getting the commits for the trees. The bind lines 
> > need commits, which means either identifying that we already have the 
> > correct commit object, because we didn't change anything in the 
> > subproject, or generating a new commit object with some message and the 
> > right parent. And we want to use commit objects, not tree objects, in the 
> > bind lines, so that, once we track a problem to the change of which commit 
> > is bound, we can treat the subproject as a project and debug it with 
> > bisect, rather than just having one tree that works and one that doesn't.
> 
> Your wording "get the commit" is a bit misleading.  Even when
> the tree for a subproject happens to match a commit in the
> subproject in a distant past, we would not want to use it unless
> the user explicitly asked for it.  IOW, we do not actively go
> and look for a commit.

We don't search the history for just any commit, but we have to look 
somewhere...

> Our subproject tree either matches the subproject branch head,
> in which case we just reuse it, or we make a new commit on top
> of that ourselves.

I hadn't realized that the subprojects had branch heads. It makes much 
more sense that you'd expect to be able to just write out bind lines if 
you've got that information.

I thought we decided that committing the superproject wouldn't commit the 
subprojects. If this is what we decided, then the subproject tree is 
required to match the branch head, because we must have committed the 
subproject already (which is good, because otherwise the user will get 
confused about which commit message to write when).

> Let's say my project breaks with the latest kernel, and I
> suspect that it would work with v2.6.13 sources.  To test that
> theory, I could:
> 
>         $ git branch -f kernel v2.6.13 ;# rewind
> 
> 	$ git ls-files linux-2.6/ |
>           xargs git update-index --force-remove
>         $ git read-tree --prefix=linux-2.6/ -u kernel
> 
> to construct such a tree.  Maybe the latter two-command sequence
> "ls-files & read-tree --prefix" sequence deserves to become a
> command, "git update-subproject kernel" [*1*].

Shouldn't "git read-tree --prefix=linux-2.6/ -u kernel" remove everything 
else in the index in linux-2.6 itself, making the "git update-index 
--force-remove" unnecessary?

> The result may work as-is, or I may need to do some further
> futzing in linux-2.6/ directory before the result works.  Once
> the result starts working, I'd want to make a commit:
> 
>  - I compare the result of write-tree for linux-2.6/ portion and
>    the tree object name contained in the head commit of the
>    "kernel" branch.  If they match, then the current "kernel"
>    branch head commit is what I'll place on the "bind" line in
>    my commit; I do not have to make a new commit in the "kernel"
>    subproject in this case.
> 
>  - If the tree object does not match the "kernel" head, that
>    means I have tweaked the kernel part further, on top of
>    v2.6.13.  So I make a commit for the kernel subproject (whose
>    parent is obviously v2.6.13), update the kernel branch head
>    with that commit, and then record that tip-of-the-tree commit
>    for the subproject on the "bind" line in my commit for the
>    toplevel.

Equivalently, you make a commit for the kernel subproject, update the 
branch head, and start over; the first case should apply now.

> Or let's say my project builds with the latest kernel (IOW, I
> did not do the branch -f kernel in the above), and I made some
> custom tweaks in the kernel area.  The above precedure would
> result in a new commit on top of the latest kernel, update the
> "kernel" branch head, and make a commit for the toplevel that
> records the updated "kernel" branch head on its "bind" line.
> 
> Note that the above procedure did not use the commit object name
> recorded on the "bind" line at all in either case.  From the
> mechanism point of view, it is the right thing to do.  From the
> usability point of view, however, we may want to take notice
> that "bind" line commit and the bound branch head do not match,
> and remind/warn the user about it.  If the reason why they are
> different is because the user rewound the bound branch to use a
> known working version, or made fixes in the subproject and
> pulled the result into the bound branch (in which case there is
> no funny rewinding involved), then this warning is
> extraneous. But in the normal case of keep reusing the same
> vintage of subprojects (and maybe making necessary adjustments
> to subprojects while working on the main project), the commit
> object on the "bind" line of the HEAD commit and bound branch
> head should match.

I hope people will want to prepare their commits to the kernel subproject 
as would be suitable for pushing to Linus, which would suggest that they'd 
tend to do a commit in the kernel subproject embedded in their 
superproject separately from doing the commit in the superproject, and 
so the branch head would match the index but not the bind line when they 
got to committing the superproject.

	-Daniel
*This .sig left intentionally blank*
