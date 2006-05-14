From: Junio C Hamano <junkio@cox.net>
Subject: Re: The git newbie experience
Date: Sun, 14 May 2006 15:09:15 -0700
Message-ID: <7vfyjcntro.fsf@assigned-by-dhcp.cox.net>
References: <446778B8.7080201@inoi.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 00:09:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FfOm8-0004Oz-V7
	for gcvg-git@gmane.org; Mon, 15 May 2006 00:09:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbWENWJS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 May 2006 18:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751032AbWENWJR
	(ORCPT <rfc822;git-outgoing>); Sun, 14 May 2006 18:09:17 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:61361 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750805AbWENWJR (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 May 2006 18:09:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514220916.QITT19284.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 14 May 2006 18:09:16 -0400
To: Tommi Virtanen <tv@inoi.fi>
In-Reply-To: <446778B8.7080201@inoi.fi> (Tommi Virtanen's message of "Sun, 14
	May 2006 21:36:40 +0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19986>

Tommi Virtanen <tv@inoi.fi> writes:

> My best idea so far is to add a "git commit -A" option, that
> essentially does the "update-index --refresh". Whenever index
> has a file state != HEAD, update-index it. The modified unrelated
> files will have index state == HEAD. Or altering "git commit -a"
> to do that.

I am not sure what you are trying to achieve by --refresh.  It
does not update the object names in the index.  Maybe you are
thinking about --again, but that is when you did something to
the index yourself, so it would not buy you much in the "novice
faced with merge" case.

Anyway, I think the time to commit is too late to save somebody
who does not understand the index.  How would you explain why
you sometimes need to use -A and sometimes -a?  That is why I
suggested to make "git pull" and "git merge" refuse to work if
there are local changes for novice users, where the definition
of novice is "git commit -a" is the only way to make a commit.
We can have [core] novice = yes in .git/config for that.

If somebody does not understand the index, if the merge is
prevented because the local change does conflict with it, how
would you explain why sometimes you can merge and sometimes you
cannot?

But if you insist going that route, I would say we could make
"git commit -a" on a merge commit to do a bit more magic.

For example, we could make -a do something special for a merge
by looking at the presense of .git/MERGE_HEAD.

	- if "commit -a", and without .git/MERGE_HEAD, just grab
          all the local modifications that are not in index yet,
          and commit it.

	- upon "commit -a", and when .git/MERGE_HEAD exists,
          grab the paths that ls-files -u reports, update-index
          them.  Other automerged paths are already registered
          in the index.

> Except, trying to solve usability problems by _adding_ options
> is just insane.

I am not sure if it is "usability" but additional option to
simplify things does not sound right, I'd agree.

> For example, we had a case where we absolutely _had_ to keep
> an ugly workaround in the tree, in a file not otherwise
> edited, but we definitely did not want to commit the kludge,
> at least not to the branch that was really being worked on. So
> such restricted mode would just have meant either people could
> not merge, or they had to use index anyway.

Your example is a very ill-thought out one.

If you are leaving the uncommitable kludge around, you cannot be
using "commit -a" with the normal non-merge workflow.  Why
would you worry about not being able to do "commit -a" on a
merge then?

For the beginning user without index, I would rewrite your
scenario like this.

- Jack is a beginning user of git and does not (want to) understand
  the index (right now).

- Jack works on branch X, say his HEAD points to X1. He has an edited,
  uncommitted files with the names A, B and C.

- Jack wants to pull new changes made by others to his branch.
  But "git merge" invoked from "git pull" says he needs to stash
  away the local changes to do the merge.

- Jack stashes away what he has been working on and cleans up
  his mess.

  git diff >P.diff
  git checkout HEAD A B C

- Jack then pulls.  There are merge conflicts in files D, E, ..., Z.

- Jack resolves the merge conflicts and is ready to commit the resulting
  merge. Note files A, B and C do not have his unfinished work.

  There is no "if Jack does this or that" problem; he says "git
  commit -a" because that is the only "commit" command he knows
  about.

- Jack then reapplies what he stashed away with "git apply P.diff"
  and keeps working.

Maybe "git stash" command that does "git diff --full-index" with
some frills, and "git unstash" command which does an equivalent
of "git am -3" would help this workflow (bare "git apply" does
not do the three-way merge like am does).
