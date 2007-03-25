From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sun, 25 Mar 2007 00:50:02 -0700
Message-ID: <7vircp92z9.fsf@assigned-by-dhcp.cox.net>
References: <200703231023.58911.andyparkins@gmail.com>
	<7vlkhmg6c3.fsf@assigned-by-dhcp.cox.net>
	<200703241550.05590.andyparkins@gmail.com>
	<7vfy7tajiz.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 09:50:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVNUe-0008JL-SF
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 09:50:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753346AbXCYHuG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 03:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753441AbXCYHuG
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 03:50:06 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:63961 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753346AbXCYHuE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 03:50:04 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325075003.FTTY1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 03:50:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id evq21W0051kojtg0000000; Sun, 25 Mar 2007 03:50:02 -0400
In-Reply-To: <7vfy7tajiz.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 25 Mar 2007 00:07:16 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43038>

Junio C Hamano <junkio@cox.net> writes:

> I think you can do something along the following line.
>
>  (1) You say "for-each-ref --all" to get the ref information
>      that is after update.
>
>  (2) Instead of looping and processing one at a time, grab all
>      information upfront.  replace the object name you obtained
>      in (1) for the ref being updated with the oldrev info you
>      discovered.
>
>  (3) Handle the branch one at a time, but instead of using --all,
>      use the result of (2) as the "state of the repository and
>      its refs before this update".
>
> In other words, you have enough information to reconstruct the
> view of the repository before your push took place.  After
> running "for-each-ref --all" once upfront, you reconstruct such
> a view, and after that you do not ever look at where the real
> refs are in the repository.  That would perhaps alleviate the
> issue of racing pushers as a side effect.

A couple of issues around the above suggestion.

Incidentally, the above fixes the "pushing tag and then commit,
and pushing commit and then tag, would give different results"
problem, as "what's new" computation would not consider the
commits the updated tag brought in as "old" commits anymore.

The above fixes "when pushing two branches that share new
commits, the shared commits will not be shown on any reports"
problem, but if you literally implement it the way I suggested,
you would instead list such shared commits that are new to the
repository in reports for both branches.  This may or may not be
a problem, depending on your definition of "new to the
repository".  On one hand, they *are* new commits introduced by
this push (that updates both branches), so in that sense,
showing them on reports for both branches may be the right thing
to do.  On the other hand, you would not see these shared
commits on the report for the latter branch if you did the same
push as two separate "git push $URL A; git push $URL B"
invocations, so showing them only on the report for one of the
branches may be the right thing to do, even when they are pushed
together (by the way, this is one of the reasons that I think
"new to the repository" is wrong.  I do not think its semantics
is well-defined).

If you want to implement the latter semantics, then after you
handle one branch in step (3), you can replace the internal view
of "what the repository looked like before this push" by
replacing the commit associated with the branch you just have
dealt with (which you replaced with its $oldrev in step (2) in
the data read from 'for-each-ref --all') with its $newrev.  Then
the shared commits would be part of the old state of the
repository when you handle the other ref, and would not show up
in its report.  If you do this, you would not want to replace
the data after handing a tag, in order to preserve the fix for
"new tag hides new commits" problem.
