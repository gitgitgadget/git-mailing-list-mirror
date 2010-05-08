From: Jeff King <peff@peff.net>
Subject: Re: Re: Problem with git merge/rebase with conflicts
Date: Sat, 8 May 2010 01:20:36 -0400
Message-ID: <20100508052036.GF14998@coredump.intra.peff.net>
References: <19426.38028.501924.921359@winooski.ccs.neu.edu>
 <7v8w7wj134.fsf@alter.siamese.dyndns.org>
 <19427.10872.708654.433450@winooski.ccs.neu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eli Barzilay <eli@barzilay.org>
X-From: git-owner@vger.kernel.org Sat May 08 07:20:53 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAcT5-0003ud-JJ
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:20:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751183Ab0EHFUj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:20:39 -0400
Received: from peff.net ([208.65.91.99]:45024 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014Ab0EHFUi (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:20:38 -0400
Received: (qmail 2841 invoked by uid 107); 8 May 2010 05:20:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 08 May 2010 01:20:53 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 08 May 2010 01:20:36 -0400
Content-Disposition: inline
In-Reply-To: <19427.10872.708654.433450@winooski.ccs.neu.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146639>

On Thu, May 06, 2010 at 04:45:44PM -0400, Eli Barzilay wrote:

> 1. False belief: After you edit and `git add' a file, you will need to
>    commit it to make the change part of your history.
> 
>    Obvious counter example: edit a file and `git add' it; undo the
>    edit in the file and `git add' again -- you now have nothing to
>    commit.
> 
>    A way that I think will solve this: make `git add' notify you that
>    the changes that you just added canceled earlier changes and you're
>    back to a clean state.

I don't understand how this is a false belief. You _haven't_ made
anything a part of your history. It was already there, and you've done
nothing to the history.

But I thought your original question started out with a conflicted
merge:

>   mkdir /tmp/r1; cd /tmp/r1; git init
>   echo foo > file; git add file; git commit -m first
>   cd /tmp; git clone r1 r2
>   cd /tmp/r1; echo abc > file; git commit -m abc file
>   cd /tmp/r2; echo xyz > file; git commit -m xyz file
>   git fetch
>   git merge origin
>   echo xyz > file
>   git add file
>   git status -s

In that case you _do_ have to commit, or your history will not contain
the merge! Even though you happened to reject the other sides changes,
you still want to generate a merge commit showing that in your history
you have examined and rejected the other side's changes.

The only failing here, if any, is that "git status" does not say "you
are in the middle of a merge, and should commit it".

> 2. False belief: If you have a completely clear working directory and
>    index, then there's nothing for you to commit.  (At least without
>    forcing an empty commit.)
> 
>    Counter example: run this (simplified example)
> 
>      rm -rf /tmp/test; mkdir /tmp/test; cd /tmp/test; git init
>      echo foo > file; git add file; git commit -m first
>      git branch a-branch;   echo abc > file; git commit -m abc file
>      git checkout a-branch; echo xyz > file; git commit -m xyz file
>      git merge master; echo xyz > file; git add file
>      git status
> 
>    That last `status' will happily tell you that "nothing to commit
>    (working directory clean)" -- but `git commit' *will* commit the
>    merge.

Yeah, probably it should detect the presence of .git/MERGE_HEAD and
print a different message.

> 3. False belief: if your working directory and your index are dirty,
>    then there *is* something for you to commit.
> 
>    Obvious counter example: edit a file and `git add' it; undo the
>    edit in the file but *don't* `git add' again -- `git status -s'
>    will now say:
> 
>      MM file
> 
>    And now:
> 
>      $ git commit .
>      # On branch master
>      nothing to commit (working directory clean)
> 
>    but the status is still not cleared.  Trying to checkout a
>    different branch gives me the barf.

I think you misunderstand how "git commit ." works. It already means
"git add . && git commit". So you are actually _removing_ the thing to
commit in the first step. Running "git commit" would work.

Which is what you suggest:

>    A way that I think will solve this: make `git commit <path>' add
>    the paths before committing -- and if `add' says something, it will
>    say that here and clarify what happened.  But this is probably too
>    much of a change, so alternatively `git commit' would notice that
>    there was nothing to commit because of this state, and `add' the
>    right files to clear out the status (after saying something about
>    it).

Except that I guess you want the add process to say "the thing you added
is the same as HEAD, so you just reverted the original thing you added".
Personally I would find such a notification annoying.

-Peff
