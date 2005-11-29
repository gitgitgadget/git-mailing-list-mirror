From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 01:29:29 -0800
Message-ID: <7voe43iyyu.fsf@assigned-by-dhcp.cox.net>
References: <20051129080529.20705.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 13:16:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh1o6-000441-Cz
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 10:29:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVK2J3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 04:29:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVK2J3d
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 04:29:33 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:2947 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1750946AbVK2J3b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 04:29:31 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129092809.IJD17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 04:28:09 -0500
To: linux@horizon.com
In-Reply-To: <20051129080529.20705.qmail@science.horizon.com>
	(linux@horizon.com's message of "29 Nov 2005 03:05:29 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12935>

linux@horizon.com writes:

> (In particular, and unlike other SCMs, "push" and "pull" are
> based on merging!  So I can't even understand what pulling from
> Linus's tree does until I understand merging.)

If you do "git pull git://.../linux-2.6/", it fetches the
objects and stores Linus "master" into .git/FETCH_HEAD, and then
merges that into whatever branch you happen to be on (but you
already know that).

> BUT... what's the second argument to git-read-tree for, if it
> always has to be HEAD?

git-read-tree is purely "a building block to be scripted" in
your second mail (private?).  In my message you are replying to,
I outlined what the end-user level tool, git-pull (and git-merge
it uses) does, which is built using git-read-tree, and we happen
to always pass HEAD as its second argument.  But it does not
have to be that way.  One thing planned in the future is to do a
merge in a temporary working directory, not in your primary
working tree, and when we implement that, the second argument
will be whatever branch head you are pulling into, not
necessarily your current HEAD.

> BTW, I'd change the description of git-read-tree from

Thanks.  I am a bit too tired tonight so I may send you a
correction later if what I am going to comment here turns out to
be incorrect, but a quick glance tells me this is a good
clarification.

> ...  I was wondering why the
> hell a 2-way merge looked more complex than a 3-way.

2-way is called merge but it is not about the merge at all
(git-merge is mostly about 3-way merge).  It is more about
checkout.  Suppose you have checked out branch A, and have local
modificiations (both in index and in working tree).  You would
want to switch to branch B by "git checkout B" (without -f).
2-way "read-tree -m -u" is used to ensure that you take your
local modifications with you while checking out branch B into
your working tree, meaning:

 (1) local changes already registered in the index stays in the
     index file; obviously this can be done only if A and B are
     the same at such paths.

 (2) local changes not registered in the index stays in the
     working tree; similar restriction applies but the rules are
     more involved.

Similar to 3-way case, 2-way will refuse to lose your local
modifications, and that is the 2-way case table in
Documentation/git-read-tree.txt is about.

> This is git-merge, as opposed to the more primitive git-read-tree -m
> plus git-merge-index, right?

Everything I wrote in the previous message was about the
end-user tools git-pull/git-merge. 

> - Doesn't any non-trivial merge or invocation of git-update-index
>   produce blob objects in the database that become garbage if you
>   do this?

We produce garbage blobs all the time, and we do not care.  Even
the following sequence that does not involve any merge produces
a garbage blob for the first version of A that was faulty:

        $ git checkout
        $ edit A
        $ git update-index A
        $ make ;# oops, there is a mistake.
        $ edit A
        $ make ;# this time it is good.
        $ git commit -a -m 'Finally compiles.'

Occasional fsck-objects, prune and repack are your friends.

> - Is there any difference between "git-reset --hard" and "git-checkout -f"?

"reset --hard" does more thorough job removing unwanted files
from your working tree.  It looks at your current HEAD, the
commit you are resetting to (when you say "reset --hard
<commit>"), and your index file, and paths mentioned by any of
these three that should not remain (that is, not in the commit
you are resetting to) are removed from your working tree.  In
addition, "reset --hard <commit>" updates the branch head and
can be used to rewind it.  On the other hand, "checkout -f"
tells git to *ignore* what is in the index, so any file in the
working tree that used to be in the index (or old branch you
were working on) that does not exist in the branch you are
checking out is not removed.

On a related topic of removing unwanted paths, earlier I said
2-way is used to make sure "git checkout" takes your changes
with you when you switch branches.  As a natural consequence of
this, if you do not have any local changes, "git checkout"
without "-f" does the right thing -- it removes unwanted paths
that existed in the original branch but not in the branch you
are switching to.

> Okay, so git-update-index will overwrite a staged file with a
> fresh stage-0 copy.  And git-commit will refuse to commit
> (to be precise, it'll stop at the git-write-tree stage) if there
> are unresolved conflicts.

Sorry, I was unclear that I was talking about end-user level
tool.  The update-index here is not about the conflict
resolution in the index file read-tree documentation talks
about.  That has already been done when "merge" ran in the
conflicting case.  In the conflicting case, the working tree
holds 3-way merge conflicting result, and the index holds HEAD
version at stage0 for such a path.  Hand resolving after
update-index is to record what you eventually want to commit
(i.e. you are not replacing higher stage entry in the index with
stage0 entry -- you are replacing stage0 entry with another).

> If you want to see the unmodified input files, you can find their
> IDs with "git-ls-files -u" and then get a copy with "git-cat-file blob"
> or "git-unpack-file".  git-merge-index is basically a different way to
> process the output of git-ls-files -u.

Yes, in principle.  But in practice you usually do not use these
low level tools yourself.  When git-merge returns with
conflicting paths, most of them have already been collapsed into
stage0 and git-ls-files --unmerged would not show.  The only
case I know of that you may still see higher stage entries in
the index these days is merging paths with different mode bits.
We used to leave higher stage entries when both sides added new
file at the same path, but even that we show as merge from
common these days.
