From: Eli Barzilay <eli@barzilay.org>
Subject: Re: Re: Problem with git merge/rebase with conflicts
Date: Sat, 8 May 2010 01:52:02 -0400
Message-ID: <19428.64514.817261.34710@winooski.ccs.neu.edu>
References: <19426.38028.501924.921359@winooski.ccs.neu.edu>
	<7v8w7wj134.fsf@alter.siamese.dyndns.org>
	<19427.10872.708654.433450@winooski.ccs.neu.edu>
	<20100508052036.GF14998@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat May 08 07:54:49 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OAczw-0005FX-Rd
	for gcvg-git-2@lo.gmane.org; Sat, 08 May 2010 07:54:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401Ab0EHFwK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 May 2010 01:52:10 -0400
Received: from winooski.ccs.neu.edu ([129.10.115.117]:38548 "EHLO barzilay.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751156Ab0EHFwJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 May 2010 01:52:09 -0400
Received: from eli by barzilay.org with local (Exim 4.66)
	(envelope-from <eli@barzilay.org>)
	id 1OAcxG-0001gs-Qp; Sat, 08 May 2010 01:52:02 -0400
In-Reply-To: <20100508052036.GF14998@coredump.intra.peff.net>
X-Mailer: VM 8.0.12 under 23.1.1 (x86_64-unknown-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146645>

On May  8, Jeff King wrote:
> On Thu, May 06, 2010 at 04:45:44PM -0400, Eli Barzilay wrote:
> 
> > 1. False belief: After you edit and `git add' a file, you will
> >    need to commit it to make the change part of your history.
> > 
> >    Obvious counter example: edit a file and `git add' it; undo the
> >    edit in the file and `git add' again -- you now have nothing to
> >    commit.
> > 
> >    A way that I think will solve this: make `git add' notify you
> >    that the changes that you just added canceled earlier changes
> >    and you're back to a clean state.
> 
> I don't understand how this is a false belief. You _haven't_ made
> anything a part of your history. It was already there, and you've
> done nothing to the history.

Well, the false belief here is following every text that (very
reasonably) tells you that you should `git add' the file and then `git
commit' it.  Obviously, with a cooked example like that things are
made very clear -- but what if I worked on something for a while
(adding stuff to the index as I go), and missed the fact that the file
is eventually at exactly where it started?  Even with this it's
probably not too bad as is, but with merges it gets even more
potential to be confusing.  In any case, I'm not saying that anything
is wrong -- just that it would be nice if `git add' told me about it,
so I can never see a transcript that ends with:

  $ git add foo
  $ git commit
  ... nothing to commit

since that canceling add will tell me explicitly that this addition
got things back to a state of having no changes.  (And I don't see any
harm in that -- if you want to explicitly revert things back you'd use
reset or something, so this change is something that you'd only see if
you were confused as above.)


> But I thought your original question started out with a conflicted
> merge:
> 
> >   mkdir /tmp/r1; cd /tmp/r1; git init
> >   echo foo > file; git add file; git commit -m first
> >   cd /tmp; git clone r1 r2
> >   cd /tmp/r1; echo abc > file; git commit -m abc file
> >   cd /tmp/r2; echo xyz > file; git commit -m xyz file
> >   git fetch
> >   git merge origin
> >   echo xyz > file
> >   git add file
> >   git status -s
> 
> In that case you _do_ have to commit, or your history will not
> contain the merge! Even though you happened to reject the other
> sides changes, you still want to generate a merge commit showing
> that in your history you have examined and rejected the other side's
> changes.
> 
> The only failing here, if any, is that "git status" does not say
> "you are in the middle of a merge, and should commit it".

Yes, that was exactly the conclusion of my following point.  Well,
even more than that -- if `git add' will tell you about getting into a
clean state, then you'd get this for the first case above:

  $ git add foo
  note: this addition canceled out all changes
  $ git commit
  ... nothing to commit         # <-- this is obvious now
  $ git status -s
                                # <-- as is the lack of output here

and for the merge case, `git add' could note that, in addition to a
clean state, you still have a merge to finish, so it could say this:

  $ git merge blah
  ...
  $ git add foo
  note: this addition canceled out all changes,
  but you still have a pending merge to commit
  $ git status -s
  (merge pending)               # <-- this is my item#2 suggestion


> > 3. False belief: if your working directory and your index are dirty,
> >    then there *is* something for you to commit.
> > 
> >    Obvious counter example: edit a file and `git add' it; undo the
> >    edit in the file but *don't* `git add' again -- `git status -s'
> >    will now say:
> > 
> >      MM file
> > 
> >    And now:
> > 
> >      $ git commit .
> >      # On branch master
> >      nothing to commit (working directory clean)
> > 
> >    but the status is still not cleared.  Trying to checkout a
> >    different branch gives me the barf.
> 
> I think you misunderstand how "git commit ." works. It already means
> "git add . && git commit". So you are actually _removing_ the thing to
> commit in the first step. Running "git commit" would work.
> 
> Which is what you suggest:
> 
> >    A way that I think will solve this: make `git commit <path>'
> >    add the paths before committing -- and if `add' says something,
> >    it will say that here and clarify what happened.  But this is
> >    probably too much of a change, so alternatively `git commit'
> >    would notice that there was nothing to commit because of this
> >    state, and `add' the right files to clear out the status (after
> >    saying something about it).
> 
> Except that I guess you want the add process to say "the thing you
> added is the same as HEAD, so you just reverted the original thing
> you added".

Yes.


> Personally I would find such a notification annoying.

Isn't this something that you'd never do intentionally?  I'm not
talking about doing this for any specific file in the commit (actually
the `add' part of the commit) -- I'm suggesting that it will say that
only if the result of adding stuff made the following commit do
nothing.  So this message would only annoy you if you've done some
changes and added them, then you edit the files back to the original
state, and then use `git add' or `git commit <paths>' (!) to add the
changes so you're back to a clean state.  This sounds like a very odd
way of undoing changes (especially with git that gives me about 200
ways to undo changes more directly...).

-- 
          ((lambda (x) (x x)) (lambda (x) (x x)))          Eli Barzilay:
                    http://barzilay.org/                   Maze is Life!
