From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Tue, 17 Jan 2006 17:41:48 -0800
Message-ID: <7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
	<200601161144.48245.Josef.Weidendorfer@gmx.de>
	<7vek37rj83.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601170001130.25300@iabervon.org>
	<7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601171150050.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 02:42:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ez2Kl-0006UC-Sv
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 02:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWARBlv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 20:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751288AbWARBlv
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 20:41:51 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:51403 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751285AbWARBlu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 20:41:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118013952.WNGY17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 20:39:52 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14809>

Daniel Barkalow <barkalow@iabervon.org> writes:

> Incidentally, I don't think we'd want "gitlink" objects with the "gitlink" 
> approach; we'd want trees to contain commit objects for subprojects. The 
> "gitlink" thing that corresponds to ".git/HEAD" isn't an object, it's a 
> tree entry, which, like ".git/HEAD" (or, more appropriately, 
> ".git/refs/heads/something") maps a name to the hash of a commit object.

> Hmm... maybe libification should go ahead of subprojects. If access to the 
> index weren't so often open-coded, it would just be a matter of having 
> these entries in the data structure, but not actually returned by any 
> current call, and it would be just like they were in some other structure. 

And libification has been waiting for the core to settle ;-) We
have to start somewhere.

> Actually, it should be easy to have them in the index file but not in the 
> main index data structure, by skipping over them in the for loop near the 
> end of read_cache()....

Yeah, I guess I was vaguely thinking along those lines while I
was driving to work this morning.  I appreciate your spelling it
out to make things clearer.

> Side issue here: this implies that the kernel objects are in the 
> superproject's repository, or at least accessible from it. So prune has to 
> not remove them. So, if you've committed changes to a subproject but not 
> yet committed the fact that you want to use the changed subproject into 
> the superproject, fsck-objects has to find them somewhere.

Yes.  I was planning to have "$GIT_DIR/bind" that says:

	master kernel=linux-2.6/ gcc=gcc-4.0/

meaning:

	The project kept track by "master" branch binds the
	project kept track by "kernel" branch as its subproject
	at its linux-2.6/ subdirectory.

or something like that, so when you make a commit, you update
those other branches as needed.  You already raised that issue
at the end of your message, and I will explain how I think that
can/should be done as a response to that part later.

>> Reading such a commit is easy:
>> 
>> 	$ git-read-tree $tree ;# ;-)
>> 
>> But that is cheating.  
>
> This is for backwards compatibility, I assume?

This is done more for not having to touch *anything* that does
"index vs working file", "tree vs index" and "tree vs working
file via index".  It also is the easiest way to keep the "a
commit object name can be used in place of the tree object name
of the tree it contains" invariant.  Also I suspect this
organization might help recursive subprojects, but if it is the
case, that is just a byproduct, not a design goal.

>> When you have such an index, writing out various trees are:
>> 
>> 	$ git-write-tree ;# $tree
>> 	$ git-write-tree --prefix=linux-2.6/ ;# $linuxsub^{tree}
>> 	$ git-write-tree --prefix=gcc-4.0/ ;# $gccsub^{tree}
>> 	$ git-write-tree \
>>           --bound=linux-2.6/ --bound=gcc-4.0/ ;# $primarysub^{tree}
>
> The hard thing here is getting the commits for the trees. The bind lines 
> need commits, which means either identifying that we already have the 
> correct commit object, because we didn't change anything in the 
> subproject, or generating a new commit object with some message and the 
> right parent. And we want to use commit objects, not tree objects, in the 
> bind lines, so that, once we track a problem to the change of which commit 
> is bound, we can treat the subproject as a project and debug it with 
> bisect, rather than just having one tree that works and one that doesn't.

Your wording "get the commit" is a bit misleading.  Even when
the tree for a subproject happens to match a commit in the
subproject in a distant past, we would not want to use it unless
the user explicitly asked for it.  IOW, we do not actively go
and look for a commit.

Our subproject tree either matches the subproject branch head,
in which case we just reuse it, or we make a new commit on top
of that ourselves.

Let's say my project breaks with the latest kernel, and I
suspect that it would work with v2.6.13 sources.  To test that
theory, I could:

        $ git branch -f kernel v2.6.13 ;# rewind

	$ git ls-files linux-2.6/ |
          xargs git update-index --force-remove
        $ git read-tree --prefix=linux-2.6/ -u kernel

to construct such a tree.  Maybe the latter two-command sequence
"ls-files & read-tree --prefix" sequence deserves to become a
command, "git update-subproject kernel" [*1*].

The result may work as-is, or I may need to do some further
futzing in linux-2.6/ directory before the result works.  Once
the result starts working, I'd want to make a commit:

 - I compare the result of write-tree for linux-2.6/ portion and
   the tree object name contained in the head commit of the
   "kernel" branch.  If they match, then the current "kernel"
   branch head commit is what I'll place on the "bind" line in
   my commit; I do not have to make a new commit in the "kernel"
   subproject in this case.

 - If the tree object does not match the "kernel" head, that
   means I have tweaked the kernel part further, on top of
   v2.6.13.  So I make a commit for the kernel subproject (whose
   parent is obviously v2.6.13), update the kernel branch head
   with that commit, and then record that tip-of-the-tree commit
   for the subproject on the "bind" line in my commit for the
   toplevel.

Or let's say my project builds with the latest kernel (IOW, I
did not do the branch -f kernel in the above), and I made some
custom tweaks in the kernel area.  The above precedure would
result in a new commit on top of the latest kernel, update the
"kernel" branch head, and make a commit for the toplevel that
records the updated "kernel" branch head on its "bind" line.

Note that the above procedure did not use the commit object name
recorded on the "bind" line at all in either case.  From the
mechanism point of view, it is the right thing to do.  From the
usability point of view, however, we may want to take notice
that "bind" line commit and the bound branch head do not match,
and remind/warn the user about it.  If the reason why they are
different is because the user rewound the bound branch to use a
known working version, or made fixes in the subproject and
pulled the result into the bound branch (in which case there is
no funny rewinding involved), then this warning is
extraneous. But in the normal case of keep reusing the same
vintage of subprojects (and maybe making necessary adjustments
to subprojects while working on the main project), the commit
object on the "bind" line of the HEAD commit and bound branch
head should match.


[Footnote]

*1* One could also do a forward development on the kernel branch
in a separate working tree and fetch from there.  For example,
if our example "superproject" is in embed/ directory, and there
is a linux/ directory next to it to house a kernel repository,
we could:

        $ cd ../linux/
        $ edit && compile && test 
        $ git commit -m 'Fix for upstream, not just for embed'

to make an upstream fix, and then:

        $ cd ../embed/
        $ git fetch ../linux/ master:kernel

to update the "kernel" subproject branch head.  In such a case:

	$ git update-subproject kernel

would bring the subproject working tree and index up to date
with respect to the updated kernel branch.
