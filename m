From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Problem with git merge/rebase with conflicts
Date: Thu, 6 May 2010 16:45:44 -0400
Message-ID: <19427.10872.708654.433450@winooski.ccs.neu.edu>
References: <19426.38028.501924.921359@winooski.ccs.neu.edu>
	<7v8w7wj134.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 06 22:45:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OA7xA-0003GA-Jj
	for gcvg-git-2@lo.gmane.org; Thu, 06 May 2010 22:45:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932571Ab0EFUpr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 May 2010 16:45:47 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:59906 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932522Ab0EFUpq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 May 2010 16:45:46 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OA7x2-0004fI-NF; Thu, 06 May 2010 16:45:44 -0400
In-Reply-To: <7v8w7wj134.fsf@alter.siamese.dyndns.org>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146497>

On May  6, Junio C Hamano wrote:
> Eli Barzilay <eli@barzilay.org> writes:
> 
> > 1. I get this:
> > 3. Again, starting from the same setup:
> 
> I don't have time to look at the second one,

(FWIW, I can't recreate it now -- very weird since when I sent that
message it was definitely repeatable.)


> but these are quite obvious and natural.  "status" in these cases
> notices that you haven't made any change relative to HEAD (in either
> the index nor in the working tree) after all, and that is what is
> being reported.

Yes, I agree that they're doing "obviously" doing the right thing, but
I don't think that they're natural enough...  I'm not saying that it's
doing something broken, just that some of the interface (=> printouts)
could eliminate surprises.  Here are some problems that I've seen,
IMO, some of them are indications that this is not natural.  I'll
prefix each one with the false belief that I had (and that I didn't
see any text that would correct it...).

1. False belief: After you edit and `git add' a file, you will need to
   commit it to make the change part of your history.

   Obvious counter example: edit a file and `git add' it; undo the
   edit in the file and `git add' again -- you now have nothing to
   commit.

   A way that I think will solve this: make `git add' notify you that
   the changes that you just added canceled earlier changes and you're
   back to a clean state.

2. False belief: If you have a completely clear working directory and
   index, then there's nothing for you to commit.  (At least without
   forcing an empty commit.)

   Counter example: run this (simplified example)

     rm -rf /tmp/test; mkdir /tmp/test; cd /tmp/test; git init
     echo foo > file; git add file; git commit -m first
     git branch a-branch;   echo abc > file; git commit -m abc file
     git checkout a-branch; echo xyz > file; git commit -m xyz file
     git merge master; echo xyz > file; git add file
     git status

   That last `status' will happily tell you that "nothing to commit
   (working directory clean)" -- but `git commit' *will* commit the
   merge.

   A way that I think will solve this: clearly there is somewhere
   something that makes the commit possible (probably .git/MERGE*
   files) -- so make `git status' inspect these and say something
   about it instead of saying that there's nothing to commit.  (The
   other option would be to make `git add' clear out the merge state
   too, but this is probably very broken.)

2a. A related problem: usually when I try to checkout a different
   branch when I have changes, git barfs at me.  But after that script
   is run, I can `git checkout master' with no errors or warnings, and
   the merge commit is gone.  It looks like checkout is even careful
   enough to remove the .git/MERGE* files, so making it barf (or at
   least spit out some warning) is probably easy...

3. False belief: if your working directory and your index are dirty,
   then there *is* something for you to commit.

   Obvious counter example: edit a file and `git add' it; undo the
   edit in the file but *don't* `git add' again -- `git status -s'
   will now say:

     MM file

   And now:

     $ git commit .
     # On branch master
     nothing to commit (working directory clean)

   but the status is still not cleared.  Trying to checkout a
   different branch gives me the barf.

   A way that I think will solve this: make `git commit <path>' add
   the paths before committing -- and if `add' says something, it will
   say that here and clarify what happened.  But this is probably too
   much of a change, so alternatively `git commit' would notice that
   there was nothing to commit because of this state, and `add' the
   right files to clear out the status (after saying something about
   it).

4. `git rebase' issues -- I've sent a separate message about that, and
   IMO adding those notes to what rebase says would clear up most of
   the confusion, and probably if the above are done then it will also
   help rebase to be more robust.

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
