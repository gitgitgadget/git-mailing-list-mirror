From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Mon, 28 Nov 2005 21:54:05 -0800
Message-ID: <7vhd9wngn6.fsf@assigned-by-dhcp.cox.net>
References: <20051128234256.1508.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 07:03:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgyRR-00032I-B7
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 06:54:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbVK2FyI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 00:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbVK2FyI
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 00:54:08 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:12206 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751257AbVK2FyH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 00:54:07 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129055239.YCJU17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 00:52:39 -0500
To: linux@horizon.com
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12919>

linux@horizon.com writes:

> (Being able to back up the object database is obviously simple, but what
> happens if the index holds HEAD+1, the working directory holds HEAD+2,
> and I try to mere the latest changes from origin?  Are either HEAD+1 or
> HEAD+2 in danger of being lost, or will checking them in later overwrite
> the merge, or what?)

Thanks for the complaints.  No sarcasm intended.  Yours is
exactly the kind of message we (people who've been around here
for too long) need to hear.

Although the technical details are hidden in the documentation
which needs reorganization to make them easier to find [*1*] as
you point out, the guiding principle for merge is quite simple.

To the git barebone Porcelain layer (things that start with
git-*, not with cg-*) [*2*], a merge is always between the
current HEAD and one or more remote branch heads, and the index
file must exactly match the tree of HEAD commit (i.e. the
contents of the last commit) when it happens.  In other words,
"git-diff --cached HEAD" must report no changes [*3*].  So
HEAD+1 must be HEAD in your above notation, or merge will refuse
to do any harm to your repository (that is, it may fetch the
objects from remote, and it may even update the local branch
used to keep track of the remote branch with "git pull remote
rbranch:lbranch", but your working tree, .git/HEAD pointer and
index file are left intact).

You may have local modifications in the working tree files.  In
other words, "git-diff" is allowed to report changes (the
difference between HEAD+2 and HEAD+1 in your notation).
However, the merge uses your working tree as the working area,
and in order to prevent the merge operation from losing such
changes, it makes sure that they do not interfere with the
merge. Those complex tables in read-tree documentation define
what it means for a path to "interfere with the merge".  And if
your local modifications interfere with the merge, again, it
stops before touching anything.

So in the above two "failed merge" case, you do not have to
worry about lossage of data --- you simply were not ready to do
a merge, so no merge happened at all.  You may want to finish
whatever you were in the middle of doing, and retry the same
pull after you are done and ready.

When things cleanly merge, these things happen:

 (1) the results are updated both in the index file and in your
     working tree,
 (2) index file is written out as a tree,
 (3) the tree gets committed, and 
 (4) the HEAD pointer gets advanced.

Because of (2), we require that the original state of the index
file to match exactly the current HEAD commit; otherwise we will
write out your local changes already registered in your index
file (the difference between HEAD+1 and HEAD in your notation)
along with the merge result, which is not good.  Because (1)
involves only the paths different between your branch and the
remote branch you are pulling from during the merge (which is
typically a fraction of the whole tree), you can have local
modifications in your working tree as long as they do not
overlap with what the merge updates.

When there are conflicts, these things happen:

 (0) HEAD stays the same.

 (1) Cleanly merged paths are updated both in the index file and
     in your working tree.

 (2) For conflicting paths, the index file records the version
     from HEAD. The working tree files have the result of
     "merge" program; i.e. 3-way merge result with familiar
     conflict markers <<< === >>>.

 (3) No other changes are done.  In particular, the local
     modifications you had before you started merge will stay the
     same and the index entries for them stay as they were,
     i.e. matching HEAD.

After seeing a conflict, you can do two things:

 * Decide not to merge.  The only clean-up you need are to reset
   the index file to the HEAD commit to reverse (1) and to clean
   up working tree changes made by (1) and (2); "git-reset" can
   be used for this.

 * Resolve the conflicts.  "git-diff" would report only the
   conflicting paths because of the above (1) and (2).  Edit the
   working tree files into a desirable shape, git-update-index
   them, to make the index file contain what the merge result
   should be, and run "git-commit" to commit the result.


[Footnotes]

*1* It is a shame that the most comprehensive definition of
3-way read-tree semantics is in t/t1000-read-tree-m-3way.sh test
script.

*2* Cogito (things that start with cg-*) seems to try to be
cleverer.  Pasky might want to brag about the rules in Cogito
land.

*3* This is a bit of lie.  In certain special cases, your index
are allowed to be different from the tree of HEAD commit;
basically your index entries are allowed to match the result of
trivial merge already (e.g. you received the same patch from
external source to produce the same result as what you are
merging).  For example, if a path did not exist in the common
ancestor and your head commit but exists in the tree you are
merging into your repository, and if you already happen to have
that path exactly in your index, the merge does not have to
fail.  This is case #2 in the 3-way read-tree table in t/t1000.
