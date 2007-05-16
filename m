From: Junio C Hamano <junkio@cox.net>
Subject: Re: pull/push inconsistencies
Date: Tue, 15 May 2007 17:24:28 -0700
Message-ID: <7vtzudhayr.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Martin Langhoff" <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 02:24:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ho7Jk-00038P-Rv
	for gcvg-git@gmane.org; Wed, 16 May 2007 02:24:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758527AbXEPAYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 May 2007 20:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759349AbXEPAYa
	(ORCPT <rfc822;git-outgoing>); Tue, 15 May 2007 20:24:30 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:37657 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758527AbXEPAYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 May 2007 20:24:30 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070516002429.VCON24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Tue, 15 May 2007 20:24:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id zcQV1W0031kojtg0000000; Tue, 15 May 2007 20:24:29 -0400
In-Reply-To: <46a038f90705151553h553ae9d3kc3d43af72f385a42@mail.gmail.com>
	(Martin Langhoff's message of "Wed, 16 May 2007 10:53:11 +1200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47395>

"Martin Langhoff" <martin.langhoff@gmail.com> writes:

> I am noticing some UI inconsistencies with pull/push. Not sure where
> they are -- and quite busy atm -- if they are in bash I might be able
> to hunt them down and fix. In case anyone else cares...
>
> --
>
> When tracking several branches from a repo, git-pull does a fetch (of
> all the remote heads) and merges _only the tracking branch currently
> checked out_. That's ok. However, if I checkout another tracking
> branch and issue git-pull, the merge does not happen because git-fetch
> finds nothing new on the remote side. git-pull should merge anyway if
> remotes/origin/<trackinghead> is ahead of the local head.

That's my expectation and I am a bit surprised if it doesn't.

> My second issue is that git-push does not update
> remotes/<repo>/<headname> so if I do git-push && gitk --all it looks
> as if I haven't pushed. Misleading again. :-/

The standard answer is not to push into a live repository
without understanding what you are doing.

I've been debating this myself, but I do not think of a good
canned configuration to satisfy different workflows.

 - Central repository setup a la CVS would want to:

	$ git clone $remote

   would create

	[remote "origin"]
        	url = $remote
                pull = refs/heads/*:refs/remotes/origin/*

   and would want to rely on the "only-fast-forward" safety to
   push into the corresonding branch.

	$ git push

   would push only corresponding branch, so there is no need for
   configuration.

   However, this is usually good only for the CVS-style shared
   central bare repository.

 - When using multiple private repositories, hopping between
   mothership and satellite, often the arrangement to allow
   fetch and push be symmetrical is desired:

	satellite$ git clone $mothership

   would create:

   	[remote "origin"]
        	url = $mothership
                pull = refs/heads/*:refs/remotes/origin/*

   on the satellite.  But if mothership could push into
   satellite, you would also want to have

	[remote "satellite"]
                url = $satellite
                push = refs/heads/*:refs/remotes/origin/*

   to make "git push satellite" run on mothership and "git fetch
   origin" run on satellite be equivalent.

   In this workflow, it is clear that a push from the mothership
   alone would not affect the working tree of the satellite; in
   fact, pushing into tracking branches from the mothership is
   arranged to mirror fetching into tracking branches from the
   satellite, with the explicit purpose of not affecting the
   working tree of the satellite, so there is less room for
   confusion.

   However, we cannot make this the default, which would break
   the traditional CVS-style shared central repository

 - A developer who publishes to his public distribution point
   (bare):

	public$ git clone --bare $my_private_repo

        private$ git push $public

   This pushes the matching refs between the two, which is the
   right thing, without any configuration.  You would not
   accidentally publish newly created throwaway branches you
   used while working inside the private repository.

Unfortunately, historically "git-push" was publisher's tool (the
last workflow was the primary target).  Later central bare
repository support was also documented.  The second workflow is
not very well supported.

And pushing into live repository using 'matching refs' is almost
always a mistake, unless the user knows what he is doing.

> Third issue - if I do
>
>  # we start with a cloned repo that is in sync with
>  # its "origin" repo. No local commits to speak of...
>  # git-fetch brings updates to 3 remote branches - none affecting the current
>  # checked out branch...
>   git-fetch
>   git-commit some/path
>   git-push
>
> the output of git-push will show _4_ branches being pushed. For some
> reason git-push says that it's pushing remotes/origin/branchname ->
> origin/branchname for all the branches fetched recently -- and not
> modified! I expect only _1_ branch to be named during push - the only
> one.

git-push without parameters and configuration pushes matching
branches.  This has been true from day one.  Again, I think we
should be able to make this safer so that "git-push" in cloned
repository would do something more restricted (perhaps limiting
to refs/heads?), but I do not think of a universally acceptable
canned configuration.

> None of the above are showstoppers, but the user feedback of these
> commands - the very core workflow for beginners - is quite confusing.

Yes, git is distributed and perhaps the expectation to be able
to "git push" without saying where to and what to push is coming
from some centralized system mindset.  If somehow we can disable
"git push" before a sensible refspecs are configured, that would
be an improvement for new users, but the "push matching refs"
behaviour is very handy for already established workflows of
people who publish things.

When pushing into your public distribution point, which does
_NOT_ have remotes/* hierarchy by definition, what will match
between your private working repository and your public
distribution point are heads/ and tags/ and all goes well.  You
do not want to accidentally push your new throwaway branches.
