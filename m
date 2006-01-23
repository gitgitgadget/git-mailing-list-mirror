From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 12:57:29 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601231200380.25300@iabervon.org>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601222104120.25300@iabervon.org> <7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
 <7v64ob1omh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jan 23 18:56:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F15uc-00088j-Ab
	for gcvg-git@gmane.org; Mon, 23 Jan 2006 18:55:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964851AbWAWRz1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 12:55:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964854AbWAWRz1
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 12:55:27 -0500
Received: from iabervon.org ([66.92.72.58]:4109 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964851AbWAWRz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2006 12:55:27 -0500
Received: (qmail 31468 invoked by uid 1000); 23 Jan 2006 12:57:29 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2006 12:57:29 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v64ob1omh.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15087>

On Sun, 22 Jan 2006, Junio C Hamano wrote:

> Junio C Hamano <junkio@cox.net> writes:
> 
> BTW, let's digress a bit.
> 
> I think recording "commit" in the tree objects is in line with
> the logical organization described in README: "blob" and "tree"
> represent a state, and have *nothing* to do with how we came
> about to that state.  The historyh is described in "commit"
> objects.  The bound commit approach keeps that property.
>
> The "gitlink" approach, as I understand how Linus outlined in
> his original suggestion, is a bit different.  The link objects
> appear in tree objects, and when you "git cat-file link" one of
> them, you would see something like this:
> 
>         commit	5b2bcc7b2d546c636f79490655b3347acc91d17f
>         name	kernel
> 
> So in that sense, "gitlink" approach departs from the original
> premise of "commit" being the only thing that ties things
> together.  Tree objects with "gitlink" know where they are in
> the history [*1*].
> 
> By this, I do not mean to say that "gitlink" approach is
> inferior because it breaks that original premise.  I am just
> pointing it out as a difference between two approaches.

I think it's hard to say whether the history of a subproject is part of 
the state of the superproject or part of its history. They're certainly 
not the same history, because the superproject history may record that 
the superproject switched from one fork of a subproject to a different 
fork, or reverted the subproject to an earlier version, or other such 
things. (It's the whole data/metadata issue: when you take a step back, 
one level's data and metadata are all data, and there's more stuff that's 
metadata.)

I'd say that with either commits in trees or gitlink objects, it's still 
only the commits that tie things together; but some of the things that 
they tie together are opaquely things tied to other things. Tree objects 
with gitlink/commits don't know where *they* are in the history; they 
just happen to store things which know about a different history.

> Now, the current way index file is used is as a staging area to
> create a new commit on top of the tip of the current branch.
> However, it is interesting to note that logically, by itself
> *alone*, it cannot be used that way.  The information the index
> file records is something that can be used to write out a tree
> object, and not a commit, because it does not know where the
> current state sits in the history.  We have two separate files,
> $GIT_DIR/HEAD that records which branch we are on, and the
> branch head ref the HEAD points at, which records where the
> current index came from, for that purpose.  The latter tells us
> what commit we should use as the parent commit if we create such
> a commit, and the former tells us which branch head to update
> once we create one.  So in that sense, the index file is just a
> staging area to create a new tree, not a new commit.

Of course, we don't strictly need $GIT_DIR/HEAD to create a commit; 
that's only needed for what we generally do with the commit once we have 
it. We do need the branch head ref (or, more abstractly, the commit that 
we read to generate the index we modified) in order to create the commit.

> We could have done things differently.  I am not advocating to
> do the following change, but offering a possibility as a thought
> experiment.  It just felt interesting enough to point them out.
> 
> The index file could have recorded what commit the current state
> recorded in the index came from.  By recording the commit the
> index was read from in the index itself, independently from the
> $GIT_DIR/refs/heads/$branch file, we could have been able to
> allow fetching into the current branch.  When the $branch file
> for the current branch was updated by a fast-forward fetch, we
> would notice that the commit recorded there no longer match what
> is recorded in the index.

I actually think this would have been a good idea. I think we've had 
approximately every possible bug that could come from inconsistancy 
between the files that give the parents and the index file. (I think Linus 
didn't do it that way initially just because he was thinking of it as a 
cache, and there's little point in caching something small, and by the 
time we started looking at it as primary information on its own, we'd 
stopped thinking about what should go in it.)

> Another interesting consequence is if the development is a
> single repository and linear, we did not even need any file in
> $GIT_DIR/refs/ ("branchless git").  The commit recorded as the
> topmost in the index file itself would have served as the tip of
> the development, and we would have been able to tangle the
> history starting from the commit in the index file.

Well, you wouldn't be able to check out an old version and then return to 
the present without dredging the objects database for the dangling commit. 
My memory has gotten fuzzy, but I think HEAD may have originally been just 
a file, and we effectively had this (except that HEAD and the index were 
not the same file as far as the filesystem was concerned).

> While we are doing a thought experiment, let's say we allow to
> record more than one commits the current index is based upon.
> 'git merge' would record all the parent commits there, so that
> writing out the merge result out of the index file as a tree and
> then recording these commits as parents would have been the way
> to create a merge commit.  We would not need the auxiliary file
> $GIT_DIR/MERGE_HEAD if we did so.
>
> In other words, if the index file recorded the commits its
> contents were based upon, instead of being a staging area for a
> new tree, it would have been a staging area for a new commit.
> 
> Now, the latest proposal, borrowing your idea, records the
> subproject commits bound to subdirectories in the index itself.
> This is halfway to make the index file a staging area for the
> next commit.  If we were to do that, we also *could* record the
> commits the current index is based upon, so that it can truly be
> used as a staging area to create a new commit, not just a tree.
> 
> On the other hand, this could be a reason *not* to do the
> `update-index --bind` to record the subproject information in
> the index file.  An auxiliary file such as $GIT_DIR/bind might
> be sufficient, just like $GIT_DIR/MERGE_HEAD has been good
> enough for us so far.  One difference between MERGE_HEAD and
> bind is that the former is very transient -- only exists during
> a merge while the latter is persistent while the top commit is
> checked out and being worked on.

We've been able to make MERGE_HEAD work, but I remember there being 
problems even there when people tried to abandon merges by changing 
branches. Do you see an advantage to having the index only record the 
information used for making a tree, and keeping the information for making 
a commit in other files?

> [Footnote]
> 
> *1* One good property of "gitlink" approach is that we *could*
> extend this blob-like object to store arbitrary human readable
> information to represent a point-in-time from an arbitrary
> foreign SCM system.  IOW, we do not necessarily have to require
> `commit` line that name a git commit to be there.  It could say
> "Please slurp http://www.kernel.org/pub/software/.../git.tar.gz
> and extract it in git/ directory".
> 
> Of course, for such a toplevel project commit, the tool may not
> be able to do a checkout automatically and require the user to
> cat-file the link, download a tarball and extract the subtree
> there manually.
> 
> The bound commit approach requires you to have git commit object
> names on the `bind` lines, and it is fundamentally much harder
> to extend it to allow interfacing with foreign (non-)SCM
> systems.

I don't think this would really be useful. The reason to have the included 
revision stored in a way that's explicitly marked for git to find is that 
git can do useful things with the information (such as checking it out for 
you, but more importantly, making sure that changes to what revision 
you're working with propagate to changes in what revision you specify 
should be there). If the bound project is foreign, this clearly isn't 
going to happen, so there's not much point. For your example above, you 
could just have a regular file, "git/README", with the content "Please 
download http://.../git.tar.gz, and extract it here", and it would be at 
least as good.

	-Daniel
*This .sig left intentionally blank*
