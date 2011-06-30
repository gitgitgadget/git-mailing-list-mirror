From: David Fries <david@fries.net>
Subject: Re: [PATCH] (trivial) add helpful "use --soft" for bare reset
Date: Thu, 30 Jun 2011 17:08:43 -0500
Message-ID: <20110630220843.GC26701@spacedout.fries.net>
References: <20110626221428.GA26780@spacedout.fries.net>
 <7vk4c3qlqa.fsf@alter.siamese.dyndns.org>
 <20110630190608.GB26701@spacedout.fries.net>
 <7vwrg3ozi5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Bronson <bronson@rinspin.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 01 00:09:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcPPz-0006qA-Ve
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 00:09:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929Ab1F3WI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Jun 2011 18:08:57 -0400
Received: from SpacedOut.fries.net ([67.64.210.234]:49085 "EHLO
	SpacedOut.fries.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753775Ab1F3WI4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2011 18:08:56 -0400
Received: from SpacedOut.fries.net (david@localhost [127.0.0.1])
	by SpacedOut.fries.net (8.14.3/8.14.3/Debian-9.4) with ESMTP id p5UM8i4w024167
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 Jun 2011 17:08:44 -0500
Received: (from david@localhost)
	by SpacedOut.fries.net (8.14.3/8.14.3/Submit) id p5UM8hR9024154;
	Thu, 30 Jun 2011 17:08:43 -0500
Content-Disposition: inline
In-Reply-To: <7vwrg3ozi5.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.3.7 (SpacedOut.fries.net [127.0.0.1]); Thu, 30 Jun 2011 17:08:44 -0500 (CDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176511>

On Thu, Jun 30, 2011 at 01:06:26PM -0700, Junio C Hamano wrote:
> David Fries <david@fries.net> writes:
> 
> > diff --git a/builtin/reset.c b/builtin/reset.c
> > index 98bca04..d0d4d66 100644
> > --- a/builtin/reset.c
> > +++ b/builtin/reset.c
> > @@ -332,7 +332,7 @@ int cmd_reset(int argc, const char **argv, const char *prefix)
> >  		setup_work_tree();
> >  
> >  	if (reset_type == MIXED && is_bare_repository())
> > -		die(_("%s reset is not allowed in a bare repository"),
> > +		die(_("%s reset is not allowed in a bare repository, see update-ref"),
> >  		    _(reset_type_names[reset_type]));


Let me go back and respond to your first reply,

> Take a step back and think a bit _why_ you wanted to flip the branch to
> point at a different commit. Did you push an incorrect commit to the
> repository? The right way to fix that mistake is by pushing the correct
> one, possibly with --force. You can also repoint a ref at a different
> commit with "update-ref $the_ref $right_commit". It will let you correct a
> branch that is not the primary branch pointed at with the HEAD pointer in
> the bare repository, unlike "reset --soft".

Back when I knew less it was a push, rebase, push failed, reset the
bare repository so it would work.  I didn't know about push -f, but
that's what you call a learning curve, learn something by figuring out
how to get something done, then later figure out there's a much easier
way.

But at work push -f no longer works, it's administratively denied from
remote for certain branches, the kind that you generally never want to
rewind.  But on occasion we do.  The options are to administratively
change permissions, push -f, change back, or login to the server,
clone, push -f, or manipulate the bare repository directly.  Modifying
the bare repository is the quickest and git-update-ref works, it just
isn't in the porcelain commands, so less likely to be known.

> There still is one thing that worries me remains here, even though I may
> be worried too much. I tend to think that giving an incorrect advice is
> far worse than not giving one.
> 
> Are you absolutely sure that the user wanted to update only the tip of a
> ref without affecting the index nor the working tree, when a mixed reset
> is issued in a bare repository, and there is _no other_ explanation why
> the user issued a forbidden command?

I guess I think of reset as moving the current branch and needing to
know how much collateral damage it can do, modify the branch location,
modify index, modify working files.  I'm not concerned about a user
actually being in a bare repository thinking they're not, because
resetting the index or working directory can loose information that
you can't get back by looking at the ref-log until gc runs, and
nothing woring on the index or working directory will work so they'll
figure it out soon enough.

> For example, I have ~/git.git and /pub/scm/git/git.git on a single machine
> somewhere. The former is with a working tree and the latter is a bare
> repository. I usually live in ~/git.git/ on that machine, but sometimes I
> would do things like:
> 
> 	$ git repack -a -d ;# working area
> 	$ cd /pub/scm/git/git.git ;# clean up from time to time ...
>         $ git repack -a -d ;# ... the public one as well
> 
> I may disconnect from my screen session to the machine after I do this,
> and I may have forgotten where I was the next time I come back to the
> machine.  After I reconnect to the same screen session, I may say "git
> reset" to get back to a known state, which is what I often want to do in
> the working area repository ~/git.git, mistakenly thinking that I am in my
> usual ~/git.git directory.

But you are doing a `git-reset some_ref` to move to some other commit,
or `git-reset` to discard any index changes and leave the branch where
it is?  The first makes it clear you want to move where the branch is
pointing, the second does nothing as far as the commit the branch is
on.  For the first case they are either in the repository they
intended to or not, but either way they are intending to move the
current branch.  In the second case they're not even trying to move
the branch.

> In such a scenario, the mistake is not that I used a wrong command "reset"
> in an attempt to update the tip of the branch. The mistake is that I tried
> to use the right command to update the index, but I did it in a wrong
> place. "Did you mean to do that somewhere else?" would be a much more
> appropriate advice in that case.

Yes, your message would be appropriate in that case, but there's no
way for git to guess that.  Besides if it's a knowledgeable user just
executing the wrong command in the wrong repository, any error message
is enough for them pause, pay attention, figure out that's not what
they expected, realize what they did, and go on their merry way.  The
message is for someone who's used to resetting their non-bare
repository, goes to the bare repository and left to hang as it doesn't
work and man git-reset(1) doesn't offer any hints (if they look).

My worry is git-update-ref's behavior is unexpected when someone's
used to git-commit, git-branch etc, as in
`git-branch new_branch old_branch^` vs
`git-update-ref new_branch old_branch^` 
as someone has to know to add refs/heads to git-update-ref where they
don't with git-branch.

The point of the patch is trying to help out a user who is learning,
and provide something to point them in the right direction.  

-- 
David Fries <david@fries.net>    PGP pub CB1EE8F0
http://fries.net/~david/
