From: Junio C Hamano <junkio@cox.net>
Subject: Re: Use of the -f flag on checkout
Date: Thu, 29 Sep 2005 02:02:14 -0700
Message-ID: <7vpsqsgsbt.fsf@assigned-by-dhcp.cox.net>
References: <433B84BD.8030003@pobox.com>
	<7vbr2cmle2.fsf@assigned-by-dhcp.cox.net>
	<200509290754.30017.alan@chandlerfamily.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 29 11:03:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EKuJ2-00059j-1P
	for gcvg-git@gmane.org; Thu, 29 Sep 2005 11:02:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751295AbVI2JCQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Sep 2005 05:02:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVI2JCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Sep 2005 05:02:16 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:18630 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751295AbVI2JCP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Sep 2005 05:02:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050929090214.WMUN9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Sep 2005 05:02:14 -0400
To: Alan Chandler <alan@chandlerfamily.org.uk>
In-Reply-To: <200509290754.30017.alan@chandlerfamily.org.uk> (Alan Chandler's
	message of "Thu, 29 Sep 2005 07:54:29 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9479>

Alan Chandler <alan@chandlerfamily.org.uk> writes:

> I notice that Jeff is using the -f flag on checkout whereas you don't.
>
> What is the risk in not using it (ie what are the cases when you should use 
> it)?

'git checkout' without '-f' means "I know my index file is
derived from my current HEAD commit.  I may have recorded
changes since the HEAD commit in index and also in the working
tree.  I now want to switch to the named branch head commit but
I'd like to take those local changes with me."

My examples worked in topic branches and after finishing work in
each branch (meaning, making commits to record changes to each
branch I was working on), switched to another branch.  After
making a commit, the index file exactly matches the current HEAD
(i.e. "git diff HEAD" would report empty) and the working tree
exactly matches the index file (i.e. "git diff" would report
empty too), so there is no local changes to carry around.

Note that this is not always possible.  If the local
modifications you have contradict with what the switched-to
branch has, 'git checkout' would complain and refuse to check
things out.  But if you know your index file and the working
tree is in sync with the HEAD commit, 'git checkout' is the
preferred way to switch branches.  It is somewhat more efficient,
too.

On the other hand, what 'git checkout -f' is telling git is that
"I do not want you to trust what the index file records or what
the current HEAD is.  I just want to have my index matched to
the named branch head commit, and have those blobs recorded in
that commit checked out in the working tree".  It is designed to
work even when you do not have a clue about the relationship
between what your index records, what your working tree files
are and what your current HEAD commit has, and can be used as
the last resort after a failed merge really messed up your
working tree and you would rather start the merge from scratch.
Switching to the current branch ('git checkout -f HEAD') makes
sense in that situation, while 'git checkout HEAD' never does.

Here is a short demonstration (my "ls" is aliased to "ls -aF").

        $ git show-branch
        * [master] Initial - have frotz
         ! [nitfol] Add nitfol
          ! [rezrov] Add rezrov
        ---
          + [rezrov] Add rezrov
         +  [nitfol] Add nitfol
        +++ [master] Initial - have frotz
        $ ls
        ./  ../  .git/	frotz

The 'master' branch has one file, 'frotz'.  Two branches are
derived from it, 'rezrov' and 'nitfol', each adds one file with
the same name as the branch name, without touching 'frotz'.  We
are on the 'master' branch.

        $ git checkout nitfol
        $ git ls-files
        frotz
        nitfol
        $ ls
        ./  ../  .git/	frotz  nitfol

We use 'git checkout' without '-f'.  It checked out 'nitfol' and
kept 'frotz'.

        $ git checkout -f rezrov
        $ git ls-files
        frotz
        rezrov
        $ ls
        ./  ../  .git/	frotz  nitfol  rezrov

This time, we tried 'git checkout' with '-f'.  It checked out
'rezrov' and kept 'frotz', but failed to remove 'nitfol',
because we told it to ignore the fact that we came from 'nitfol'
branch.  If it were allowed to use that information, it would
have noticed that the original branch had 'nitfol' recorded but
the branch we are switching to did not have it, and would have
removed it from the working tree.  Also notice that the index
file matches the 'rezrov' commit -- it does not know about
'nitfol' file anymore.

        $ rm -f nitfol
        $ date >xyzzy
        $ git add xyzzy

Now, after removing the unwanted 'nitfol' file, let's introduce
some local changes.  Remember we are still on 'rezrov' branch.

        $ git checkout nitfol
        $ git ls-files
        frotz
        nitfol
        xyzzy
        $ ls
        ./  ../  .git/	frotz  nitfol  xyzzy
        $ git diff --name-status HEAD
        A	xyzzy

Now we tell 'git checkout' to switch to 'nitfol' branch, without
losing our local changes.  The file 'nitfol' is back (checked
out), and 'rezrov' is gone (because this time it was allowed to
trust the current HEAD and noticed 'rezrov' was there in the
original but not in the branch we are switching to).

However, neither the working file nor the index matches the
'nitfol' branch head -- it kept the local addition of new file
'xyzzy' (i.e. your local changes were preserved).

One typical scenario I use 'git checkout' without '-f' is:

    * on some branch, start working on something.
    * realize that the change I am making belongs to a different
      topic.
    * 'git checkout' to that other topic branch, with my
      changes.
    * keep working and make commit on the other topic branch.
    * come back (with 'git checkout') to the original branch.

But usually I am even less organized -- I'd usually end up
doing:

    * on some branch, start working on something.
    * realize that some the changes I am making belong to a
      different topic, while other changes belong to the
      curren branch.
    * stash away "git diff HEAD" output.  revert parts that
      are not relevant to the current topic branch.
    * make commit on the current topic branch.
    * 'git checkout' to that other topic branch.  Apply the
      rest of the diff output.
    * keep working and make commit on the other topic branch.

Personally I don't remember using 'git checkout -f' myself.
When I really want to sync my index file and the working tree to
the current branch head, I tend to do 'git reset --hard'
instead.  Unlike 'git checkout -f HEAD', this removes the files
I added to the working tree and the index since my current HEAD
commit.  One downside is that 'git reset --hard' *is* a very
expensive operation.
