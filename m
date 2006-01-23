From: Martin Atukunda <matlads@dsmagic.com>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 15:50:13 +0300
Message-ID: <20060123125013.GA4472@igloo.ds.co.ug>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Jan 23 13:50:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F119h-0001rX-NU
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 13:50:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWAWMua (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 07:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWAWMua
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 07:50:30 -0500
Received: from mail1.imul.com ([217.113.72.31]:44380 "EHLO mail1.infocom.co.ug")
	by vger.kernel.org with ESMTP id S1751327AbWAWMua (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2006 07:50:30 -0500
Received: from entandikwa.ds.co.ug ([::ffff:217.113.73.39])
  by mail1.infocom.co.ug with esmtp; Mon, 23 Jan 2006 15:50:16 +0300
  id 000F98A4.43D4D108.00001149
Received: from igloo.ds.co.ug (igloo.ds.co.ug [192.168.129.66])
	by entandikwa.ds.co.ug (Postfix) with ESMTP id 4CC616631
	for <git@vger.kernel.org>; Mon, 23 Jan 2006 15:52:09 +0300 (EAT)
Received: from matlads by igloo.ds.co.ug with local (Exim 4.60)
	(envelope-from <matlads@dsmagic.com>)
	id 1F119B-0001BH-Gc
	for git@vger.kernel.org; Mon, 23 Jan 2006 15:50:13 +0300
To: git@vger.kernel.org
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15083>

This proposal doesn't seem to cator for the event when a directory is
renamed or moved to a different location, or am I missing something?

- Martin -
On Sun, Jan 22, 2006 at 05:35:14PM -0800, Junio C Hamano wrote:
> This is still a draft/WIP, but "release early" is a good
> discipline, so...
> 
> -- >8 --
> 
> Notes on Subproject Support
> ===========================
> Junio C Hamano <junkio@cox.net>
> v1.0 January 22, 2006
> 
> Scenario
> --------
> 
> The examples in the following discussion show how this proposal
> plans to help this:
> 
> . A project to build an embedded Linux appliance "gadget" is
>   maintained with git.
> 
> . The project uses linux-2.6 kernel as its subcomponent.  It
>   starts from a particular version of the mainline kernel, but
>   adds its own code and build infrastructure to fit the
>   appliance's needs.
> 
> . The working tree of the project is laid out this way:
> +
> ------------
>  Makefile       - Builds the whole thing.
>  linux-2.6/     - The kernel, perhaps modified for the project.
>  appliance/     - Applications that run on the appliance, and
>                   other bits.
> ------------
> 
> . The project is willing to maintain its own changes out of tree
>   of the Linux kernel project, but would want to be able to feed
>   the changes upstream, and incorporate upstream changes to its
>   own tree, taking advantage of the fact that both itself and
>   the Linux kernel project are version controlled with git.
> 
> The idea here is to:
> 
> . Keep `linux-2.6/` part as an independent project.  The work by
>   the project on the kernel part can be naturally exchanged with
>   the other kernel developers this way.  Specifically, a tree
>   object contained in commit objects belonging to this project
>   does *not* have linux-2.6/ directory at the top.
> 
> . Keep the `appliance/` part as another independent project.
>   Applications are supposed to be more or less independent from
>   the kernel version, but some other bits might be tied to a
>   specific kernel version.  Again, a tree object contained in
>   commit objects belonging to this project does *not* have
>   appliance/ directory at the top.
> 
> . Have another project that combines the whole thing together,
>   so that the project can keep track of which versions of the
>   parts are built together.
> 
> We will call the project that binds things together the
> 'toplevel project'.  Other projects that hold `linux-2.6/` part
> and `appliance/` part are called 'subprojects'.
> 
> Notice that `Makefile` at the top is part of the toplevel
> project in this example, but it is not necessary.  We could
> instead have the appliance subproject include this file.  In
> such a setup, the appliance subproject would have had `Makefile`
> and `appliance/` directory at the toplevel.
> 
> 
> Setting up
> ----------
> 
> Let's say we have been working on the appliance software,
> independently version controlled with git.  Also the kernel part
> has been version controlled separately, like this:
> ------------
> $ ls -dF current/*/.git current/*
> current/Makefile    current/appliance/.git/  current/linux-2.6/.git/
> current/appliance/  current/linux-2.6/
> ------------
> 
> Now we would want to get a combined project.  First we would
> clone from these repositories (which is not strictly needed --
> we could use `$GIT_ALTERNATE_OBJECT_DIRECTORIES` instead):
> 
> ------------
> $ mkdir combined && cd combined
> $ cp ../current/Makefile .
> $ git init-db
> $ mkdir -p .git/refs/subs/{kernel,gadget}/{heads,tags}
> $ git clone-pack ../current/linux-2.6/ master | read kernel_commit junk
> $ git clone-pack ../current/appliance/ master | read gadget_commit junk
> ------------
> 
> We will introduce a new command to set up a combined project:
> 
> ------------
> $ git bind-projects \
> 	$kernel_commit linux-2.6/ \
> 	$gadget_commit appliance/
> ------------
> 
> This would do an equivalent of:
> 
> ------------
> $ git read-tree --prefix=linux-2.6/ $kernel_commit
> $ git read-tree --prefix=appliance/ $gadget_commit
> ------------
> [NOTE]
> ============
> Earlier outlines sent to the git mailing list talked
> about `$GIT_DIR/bind` to record what subproject are bound to
> which subtree in the curent working tree and index.  This
> proposal instead records that information in the index file
> when `--prefix=linux-2.6/` is given to `read-tree`.
> 
> Also note that in this round of proposal, there is no separate
> branches that keep track of heads of subprojects.
> ============
> 
> Let's not forget to add the `Makefile`, and check the whole
> thing out from the index file.
> ------------
> $ git add Makefile
> $ git checkout-index -f -u -q -a
> ------------
> 
> Now our directory should be identical with the `current`
> directory.  After making sure of that, we should be able to
> commit the whole thing:
> 
> ------------
> $ diff -x .git -r ../current ../combined
> $ git commit -m 'Initial toplevel project commit'
> ------------
> 
> Which should create a new commit object that records what is in
> the index file as its tree, with `bind` lines to record which
> subproject commit objects are bound at what subdirectory, and
> updates the `$GIT_DIR/refs/heads/master`.  Such a commit object
> might look like this:
> ------------
> tree 04803b09c300c8325258ccf2744115acc4c57067
> bind 5b2bcc7b2d546c636f79490655b3347acc91d17f linux-2.6/
> bind 0bdd79af62e8621359af08f0afca0ce977348ac7 appliance/
> author Junio C Hamano <junio@kernel.org> 1137965565 -0800
> committer Junio C Hamano <junio@kernel.org> 1137965565 -0800
> 
> Initial toplevel project commit
> ------------
> 
> 
> Making further commits
> ----------------------
> 
> The easiest case is when you updated the Makefile without
> changing anything in the subprojects.  In such a case, we just
> need to create a new commmit object that records the new tree
> with the current `HEAD` as its parent, and with the same set of
> `bind` lines.
> 
> When we have changes to the subproject part, we would make a
> separate commit to the subproject part and then record the whole
> thing by making a commit to the toplevel project.  The user
> interaction might go this way:
> ------------
> $ git commit
> error: you have changes to the subproject bound at linux-2.6/.
> $ git commit --subproject linux-2.6/
> $ git commit
> ------------
> 
> With the new `--subproject` option, the directory structure
> rooted at `linux-2.6/` part is written out as a tree, and a new
> commit object that records that tree object with the commit
> bound to that portion of the tree (`5b2bcc7b` in the above
> example) as its parent is created.  Then the final `git commit`
> would record the whole tree with updated `bind` line for the
> `linux-2.6/` part.
> 
> 
> Checking out
> ------------
> 
> After cloning such a toplevel project, `git clone` without `-n`
> option would check out the working tree.  This is done by
> reading the tree object recorded in the commit object (which
> records the whole thing), and adding the information from the
> "bind" line to the index file.
> 
> ------------
> $ cd ..
> $ git clone -n combined cloned ;# clone the one we created earlier
> $ cd cloned
> $ git checkout
> ------------
> 
> This round of proposal does not maintain separate branch heads
> for subprojects.  The bound commits and their subdirectories
> are recorded in the index file from the commit object, so there
> is no need to do anything other than updating the index and the
> working tree.
> 
> 
> Switching branches
> ------------------
> 
> Along with the traditional two-way merge by `read-tree -m -u`,
> we would need to look at:
> 
> . `bind` lines in the current `HEAD` commit.
> 
> . `bind` lines in the commit we are switching to.
> 
> . subproject binding information in the index file.
> 
> to make sure we do sensible things.
> 
> Just like until very recently we did not allow switching
> branches when two-way merge would lose local changes, we can
> start by refusing to switch branches when the subprojects bound
> in the index do not match what is recorded in the `HEAD` commit.
> 
> Because in this round of the proposal we do not use the
> `$GIT_DIR/bind` file nor separate branches to keep track of
> heads of the subprojects, there is nothing else other than the
> working tree and the index file that needs to be updated when
> switching branches.
> 
> 
> Merging
> -------
> 
> Merging two branches of the toplevel projects can use the
> traditional merging mechanism mostly unchanged.  The merge base
> computation can be done using the `parent` ancestry information
> taken from the two toplevel project branch heads being merged,
> and merging of the whole tree can be done with a three-way merge
> of the whole tree using the merge base and two head commits.
> For reasons described later, we would not merge the subproject
> parts of the trees during this step, though.
> 
> When the two branch heads use different versions of subproject,
> things get a bit tricky.  First, let's forget for a moment about
> the case where they bind the same project at different location.
> We would refuse if they do not have the same number of `bind`
> lines that bind something at the same subdirectories.
> 
> ------------
> $ git merge 'Merge in a side branch' HEAD side
> error: the merged heads have subprojects bound at different places.
>  ours:
> 	linux-2.6/
> 	appliance/
>  theirs:
> 	kernel/
> 	gadget/
> 	manual/
> ------------
> 
> Such renaming can be handled by first moving the bind points in
> our branch, and redoing the merge (this is a rare operation
> anyway).  It might go like this:
> 
> ------------
> $ git bind-projects \
> 	$kernel_commit kernel/ \
> 	$gadget_commit gadget/
> $ git commit -m 'Prepare for merge with side branch'
> $ git merge 'Merge in a side branch' HEAD side
> error: the merged heads have subprojects bound at different places.
>  ours:
> 	kernel/
> 	gadget/
>  theirs:
> 	kernel/
> 	gadget/
> 	manual/
> ------------
> 
> Their branch added another subproject, so this did not work (or
> it could be the other way around -- we might have been the one
> with `manual/` subproject while they didn't).  This suggests
> that we may want an option to `git merge` to allow taking a
> union of subprojects.  Again, this is a rare operation, and
> always taking a union would have created a toplevel project that
> had both `kernel/` and `linux-2.6/` bound to the same Linux
> kernel project from possibly different vintage, so it would be
> prudent to require the set of bound subprojects to exactly match
> and give the user an option to take a union.
> 
> ------------
> $ git merge --union-subprojects 'Merge in a side branch HEAD side
> error: the subproject at `kernel/` needs to be merged first.
> ------------
> 
> Here, the version of the Linux kernel project in the `side`
> branch was different from what our branch had on our `bind`
> line.  On what kind of difference should we give this error?
> Initially, I think we could require one is the fast forward of
> the other (ours might be ahead of theirs, or the other way
> around), and take the descendant.
> 
> Or we could do an independent merge of subprojects heads, using
> the `parent` ancestry of the bound subproject heads to find
> their merge-base and doing a three-way merge.  This would leave
> the merge result in the subproject part of the working tree and
> the index.
> 
> [NOTE]
> This is the reason we did not do the whole-tree three way merge
> earlier.  The subproject commit bound to the merge base commit
> used for the toplevel project may not be the merge base between
> the subproject commits bound to the two toplevel project
> commits.
> 
> So let's deal with the case to merge only a subproject part into
> our tree first.
> 
> 
> Merging subprojects
> -------------------
> 
> An operation of more practical importance is to be able to merge
> in changes done outside to the projects bound to our toplevel
> project.
> 
> ------------
> $ git pull --subproject=kernel/ git://git.kernel.org/.../linux-2.6/
> ------------
> 
> might do:
> 
> . fetch the current `HEAD` commit from Linus.
> . find the subproject commit bound at kernel/ subtree.
> . perform the usual three-way merge of these two commits, in
>   `kernel/` part of the working tree.
> 
> After that, `git commit \--subproject` option would be needed to
> make a commit.
> 
> [NOTE]
> This suggests that we would need to have something similar to
> `MERGE_HEAD` for merging the subproject part.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Due to a shortage of devoted followers, the production of great leaders has been discontinued.
