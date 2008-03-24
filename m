From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] git-init: set receive.guardCurrentBranch = true for
 non-bare repositories
Date: Mon, 24 Mar 2008 09:50:07 -0700
Message-ID: <7v4pawvzgg.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0803232142460.4353@racer.site>
 <alpine.LSU.1.00.0803232144070.4353@racer.site>
 <7v4pax3r6l.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0803241158301.4353@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 17:51:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jdpt1-00062k-Tt
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 17:51:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755592AbYCXQuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 12:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753989AbYCXQuT
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 12:50:19 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60994 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753484AbYCXQuS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 12:50:18 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C90781244;
	Mon, 24 Mar 2008 12:50:16 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id AB8E91236; Mon, 24 Mar 2008 12:50:10 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78062>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sun, 23 Mar 2008, Junio C Hamano wrote:
> ...
>> As I described in my other message, I suspect that treating the current 
>> branch specially like this is a wrong approach.  The configuration might 
>> be a good idea, but shouldn't it prevent any local branch from getting 
>> updated?  Push into non-bare repository is simply a fetch run in reverse 
>> direction.
>
> That would break this work flow:
>
> 	# machine A
> 	$ git push B master:refs/heads/tmp
>
> 	# machine B
> 	$ git merge tmp
> 	$ git branch -d tmp

I am afraid that the above is irrelevant.

(1) You can push the temporary into anywhere outside refs/heads/ if that
    becomes the problem;

(2) Your change to forbid current branch already "breaks" another workflow
    (which I happen to use everyday) anyway:

	# machine A (primary development repository)
        $ git push k.org ;# master->master, next->next, ...

        # machine B (build test repository)
        $ git reset --hard
        $ for b in master maint next pu
          do git checkout $b && make clean test || break
	  done

(3) Because the proposed new feature is dependent on a configuration, both
    of the above can be "worked around" equally easily by disabling it.

> Besides, there is a _vital_ difference between the current branch,...

Actually that is exactly I used to think until I realized how flawed that
line of reasoning was.

Suppose you started treating the current branch any specially.  A few
issues immediately arise:

 * "I can update any other branches, but git rejected my push saying it
   does not want to update the current branch. why?"

 * "how do I know what branch is checked out currently over there to work
   around this limitation?"

 * "more importantly, how would I fix this?  do I ask the repository owner
   to check out different branch?"

The process of coming up with answers to these questions made me realize
that treating the current branch specially was just a hack to work around
only immediately observable effects of pushing into a live repository, and
not solving the real issue.  IOW, any of the answers I came up with
sounded like lame excuses.

Step back a bit and think _why_ you wanted to prevent current branch tip
from getting updated in the first place.  There are two issues:

 * Why is it _current_ branch, and not _these branches_, that can be
   configured by the user to be protected from a push from sideways?

 * Why is it undesirable for the work tree and the index to go out of sync
   with respect to the branch tip to begin with?

The latter is simpler to answer, so let's deal with it first.  The reason
why it is bad is because allowing a push to the current branch interferes
with the work actively being done in the repository, using the work tree
contents.  There is a person, you, who is actively editing the work tree
in order to advance the tip of the branch by making commits.  If the
branch tip moves without your knowing, that destabilizes your working
environment.  Your work tree wanted to make a new commit on top of some
known state, but that state was moved underneath you.  Not good.

When you are using the repository for real work (i.e. advance the tips of
its branches), you want a stable environment.  You do not want its HEAD
bobbing around outside your control, and silently detaching to cause your
later commits to go to unnamed branch without your knowing is just as bad
(which you already correctly objected to).

Now think.  What if one of these operations you do in the repository to
advance the tip was to merge from one of _your_ local branches?  Yes, you
end up merging something you did not expect to merge if you allowed a push
from sideways to affect that local branch, only because the branch
happened to be un-checked-out and you implemented this protection to
forbid only to current branch.  Allowing a push from sideways to any local
branch destabilizes your work environment, not just the current one.

The former question becomes easier to answer once you realize this.  It
was only because you were too narrowly focused on the immediately visible
effect of pushing into a live repository, and that is apparent in your
"there is a _vital_ difference" statement (again, I used to think the same
way, so it is not just you).  The difference is not _vital_ at all.  It
merely is being immediately observable.  The stability of the environment
you do real work in is more than just the branch currently checked out.
At least you would want "I do not want these refs to silently change
without me knowing".

Pushing to non-bare repository can happen in number of ways, and there are
a few _useful_ use cases to push into local branches of a live repository,
but the sane usage that allows such push has one common precondition: No
interesting edit is ever outstanding in the non-bare repository when push
happens.

For example, you could have a repository and its checkout of html branch
of git.git, and serve the former via dumb protocol for git-fetch clients,
while the latter is fed directly to web browsers.  Even if you push into
its html branch (that is checked out), you would not suffer, as _you
already know what you are doing_ and that is the reason you can even
arrange its post-update hook to run "reset --hard" for you.

The earlier "build test repository" example is the same way.  I might have
to debug problems that only manifest on the k.org machine, so it is unlike
I am forbidden from doing any "interesting edits" there, but when I do a
push from the primary machine, I know I am done with any edit on the k.org
repository (otherwise I'd still be logged in and working there, not
pushing from home), so I am sure "reset --hard" is safe and good.

These use cases share the precondition "no interesting edit is ever
outstanding".  But it is just an extension of a more general idea: Usually
nobody works in the work tree to advance its branches with commits made
there.  Instead, advancement of its branches always happen by push from
elsewhere.

If a real person works in the work tree, the story is different.  There
needs a boundary that defines his stable working environment that should
not be disrupted by a push from sideways.  You _could_ define it as "the
currently checked out branch, the index and the work tree".  I think it is
too narrow.  We could allow the user to define "this subset of local
branches", but I think it is one too many knob to tweak, and a reasonable
boundary is to define the boundary to include "local branches" into that
set, as they are also the ones you would update with the regular working
inside that work tree (i.e. checkout-hack-commit cycle).

In such a live repository, treating "git push" initiated from elsewhere
into it exactly the same way "git fetch" initiated in the repository in
the reverse direction would be the cleanest way to explain a non-confusing
workflow to the end users.  You are always in control of all of your local
branches, and you decide when to merge the tip of such a pushed-in ref
(this is the mothership-satellite configuration suggested in the FAQ entry
mentioned in the other thread).

I am not married to the idea of using refs/remotes/* for that purpose, and
it might turn out to be a good idea to have more elaborate setup, for
example, using refs/pushed/<branch-name>/ hierarchy to keep other's pushed
refs in there.  But one thing I am reasonably sure is that pushes should
not go to refs/heads/ directly whether the branch is checked out or not,
if the user of that pushed-into live repository wants to keep his sanity.
