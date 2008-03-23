From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Working copy revision and push pain
Date: Sun, 23 Mar 2008 12:42:18 -0700
Message-ID: <7vhcex4485.fsf@gitster.siamese.dyndns.org>
References: <47E64F71.3020204@jwatt.org> <47E668E1.80804@jwatt.org>
 <alpine.LSU.1.00.0803231534050.4353@racer.site>
 <200803231720.44320.johan@herland.net> <47E6923E.1050904@jwatt.org>
 <7vd4pl713g.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>
To: Jonathan Watt <jwatt@jwatt.org>
X-From: git-owner@vger.kernel.org Sun Mar 23 20:43:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdW64-0005pD-C7
	for gcvg-git-2@gmane.org; Sun, 23 Mar 2008 20:43:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755910AbYCWTmb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Mar 2008 15:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755834AbYCWTmb
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Mar 2008 15:42:31 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34161 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755449AbYCWTma (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Mar 2008 15:42:30 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 41D751CDB;
	Sun, 23 Mar 2008 15:42:29 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 3EC3E1CDA; Sun, 23 Mar 2008 15:42:22 -0400 (EDT)
In-Reply-To: <7vd4pl713g.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 23 Mar 2008 11:21:39 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77952>

Junio C Hamano <gitster@pobox.com> writes:

> Jonathan Watt <jwatt@jwatt.org> writes:
>
> My understanding is if you push into a non-bare tree in merc, they make
> the branch head into "unmerged" state, and as far as the work tree is
> concerned you are still on the previous commit, and you merge "the other
> commit" that was pushed into from sideways to update the branch tip with
> pushed-into commit.
>
> In git, if you detach HEAD when you push into a checked-out 'master', your
> work tree won't be associated with 'master' anymore, and to merge the
> pushed-into state into the history of 'master', you would need:
> ...
> The second point bothers me quite a lot, as you are assuming that the
> user at the repository that was pushed into does _not_ know what is going
> on, and may keep working on a detached HEAD _without knowing_ what is
> going on.

Let's back up a bit and try again.

I was trying to say what Mercurial presents at the UI level may be much
nicer with respect to pushing into a checked out repository.  Their notion
of 'head' (and 'branch' in general) is quite different from ours in that
their branch can have more than one 'head's that the user can choose to
merge into its 'tip', and 'push' does not update the 'tip'.  It instead
adds a new (unmerged) 'head' or fast-forwards an existing 'head', and the
user can choose to merge them into 'tip' when convenient (please correct
me here, since I am talking from my reading their documentation and I may
have misread it).

In git, a branch is just a ref and points at a single commit, and push and
fetch updates a single ref.  There is no direct notion of "these other
refs are related to this branch ref and you may want to merge them" at the
low level plumbing layer, so if you push to update a ref, git does what it
is told to do.  The branch ref is directly updated, and won't get split to
be merged back later like Mercurial does.

My objection to the "always detach HEAD automatically" is because that
solution, while it may solve the issue of work tree and HEAD getting
inconsistent silently behind user's back, would introduce more confusion.

 - The repository loses where we were (so we would add a hack to record
   which branch you were on), and operations after that silent detaching
   will _not_ advance your local branch anymore, because the push took
   over the branch 'tip'.  If you switch to some other branch, you lose.

 - The final merge happens in the wrong direction.  The other commit is
   already called the official 'tip' of the branch because push took over
   the branch 'tip', and after merging it into your stale HEAD, you have
   to update 'master' with the merge made on the detached HEAD.

 - It's your repository and the commit you were on when this push from
   sideways happened should _stay_ as the official 'tip' of the branch,
   until you tell git so.  In that sense, pushing into a non-bare
   repository's refs/heads/ hierarchy directly is conceptually wrong,
   whether the branch in question is currently checked out or not.

Although we do not have their split branch heads, we do have a similar
concept by the name of "branch tracking".  Your 'master' is marked as
being related to 'remotes/origin/master' by "git clone" and by "git
checkout -b foo remotes/origin/foo", and recent "git checkout" to switch
to such a branch will report how diverged you are from the other party.

The mothership-satellite configuration described in FAQ is about using
this facility, because "git push" into a non-bare repository is exactly a
"git fetch" run in the reverse direction (i.e. fetching to pushed-into
repository from pushed-from repository).
