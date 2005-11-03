From: Junio C Hamano <junkio@cox.net>
Subject: Re: Now What?
Date: Thu, 03 Nov 2005 00:58:50 -0800
Message-ID: <7vvezajeet.fsf@assigned-by-dhcp.cox.net>
References: <E1EXTw5-00063o-Gt@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 03 09:59:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EXavv-0004UP-5N
	for gcvg-git@gmane.org; Thu, 03 Nov 2005 09:58:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750750AbVKCI6w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Nov 2005 03:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751242AbVKCI6w
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Nov 2005 03:58:52 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:43451 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750750AbVKCI6w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Nov 2005 03:58:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051103085827.ZLKC9394.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 3 Nov 2005 03:58:27 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EXTw5-00063o-Gt@jdl.com> (Jon Loeliger's message of "Wed, 02
	Nov 2005 19:30:37 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11069>

Jon Loeliger <jdl@freescale.com> writes:

> I feel that an explanation of all of the behind-the-scripts-
> in-.git communication files is needed.  In particular these:
>
>     FETCH_HEAD
>     MERGE_HEAD
>     LAST_MERGE
>     MERGE_MSG
>
> These need to be mentioned and explained because they
> frequently form exactly the critical missing link or
> starting point after a failed fetch or merge.

I am not so sure if it would help to know details of the above
four files to answer "Now What" question, but I'll try to
describe them near the end of this message.

Before that, here is a cookbook failed pull/merge resolution
procedure.

	$ git pull some-where
	Gaah ... resolve by hand.

Oops, it failed.  Now what?

First, if your index did not match your HEAD before
pulling/merging, the merge strategies will refuse to merge in
the changes and would fail without touching your working tree
(so you would not even see "resolve by hand" message).  If you
want to proceed, you need to somehow match your HEAD and your
index to retry.  There are two possibilities.

(1) if you were deep in a middle of something, snapshot your
    changes and rewind the current tree.

	$ git commit -a -m 'WIP'
	$ git branch save-wip
        $ git reset --hard HEAD^

    and then retry merge or pull.  Later you would want to
    resurrect what you did from save-wip branch (e.g. "git diff
    save-wip^ save-wip | git apply" after finishing your
    merge).

(2) if you did not have much worth saving, just rewind the
    changes.  Optionally you could save the diff just in case.

	$ git diff HEAD >tmp-wip.diff
        $ git reset --hard

    and then retry merge or pull.

Now that case is out of our way, I'll discuss the case where
your index did match your HEAD from here on.  You pulled from
remote, merge strategy tried to do its work, and did not find a
clean automerge.

At this point, the automerge procedure would have already
updated your index for paths that cleanly merged.  The rest are
left in your working tree, so this diff would show what remains
to be resolved:

        $ git diff

You would most likely see some <<<< ==== >>>> conflict markers.
Resolving them by hand is hopefully something familiar to CVS or
SVN migrants, so "Now what" document may not have to talk about
what these conflict markers mean ("between <<<< and ==== are
your version, between ==== and >>>> are their version", or
something like that --- I may be getting this particular detail
wrong in this sentence, so you should check).

After resolving them by hand, you would want to see what got
changed from _your_ version for sanity checking, because you are
hopefully more familiar with your version than theirs, and
reading diff between theirs might be more difficult.  So check

	$ git diff HEAD

to see what changes this pull brought in, including the conflict
resolution you just did.  On the other hand,

	$ git diff MERGE_HEAD

would show diff from their head, so you would see what you did
to their tree.

After checking the diffs, if things look OK, compiling and
testing is the same procedure as you would normally do before
making any commit.  Then

	$ git commit -a

(as usual, you can drop '-a' if you manually 'git-update-index'
all the necessary paths before this step) would give you the
regular commit message editor, with a reminder "you are
committing a merge", with prepared message "merge from
some-where repository".  Edit it and exit the editor normally to
make the merge commit, and you are done.

Now to the communication files.

>     FETCH_HEAD

This file lists refs the git-fetch command (run from git-pull)
retrieved from the remote.  Usually it marks everything but one
as 'not-for-merge'.  The one that is not marked as
'not-for-merge' is the commit you are merging into the current
head.  This is not looked at by the merge machinery, but
git-pull uses it to decide which commits to pass to git-merge.

>     MERGE_HEAD

This is present only after a failed automerge, by git-merge, and
lists the commits that you are merging into the current head
(typically only one) -- the same as the ones not marked as
'not-for-merge' in FETCH_HEAD, because this file records the
commits given to git-merge.

>     LAST_MERGE

This is more or less historical curiosity and only git-resolve
uses it.  Records almost the same information as MERGE_HEAD.

>     MERGE_MSG

This is created by git-pull from FETCH_HEAD to format a human
readable autocommit log.

> Finally, a procedure or style question.  Should this
> write-up be in the form of a structured FAQ?  A stand-alone
> expository document?

One useful thing would be to have a cut&paste ready example that
would cover constructing two branches/repos, pulling a branch
from one to the other and causing an actual conflict, and show
how to resolve it and make a commit, in a section in Tutorial.
I think we already have something like that there.

Another good thing would be, after proofreading this message and
making necessary corrections, send it as a patch form to add it
as a new file under Documentation/howto/.
