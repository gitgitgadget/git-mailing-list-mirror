From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use diff* with --exit-code in git-am, git-rebase and git-merge-ours
Date: Sat, 24 Mar 2007 23:01:31 -0700
Message-ID: <7vwt15c150.fsf@assigned-by-dhcp.cox.net>
References: <20070325005613.GE11507@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 25 08:01:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVLna-0000G8-PB
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 08:01:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752228AbXCYGBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 02:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753155AbXCYGBd
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 02:01:33 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50053 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752228AbXCYGBc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 02:01:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325060132.FEZO1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 02:01:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id eu1X1W00E1kojtg0000000; Sun, 25 Mar 2007 02:01:32 -0400
In-Reply-To: <20070325005613.GE11507@steel.home> (Alex Riesen's message of
	"Sun, 25 Mar 2007 01:56:13 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43032>

Alex Riesen <raa.lkml@gmail.com> writes:

> This simplifies the shell code, reduces its memory footprint, and
> speeds things up. The performance improvements should be noticable
> when git-rebase works on big commits.

Thanks.

Unlike some optimizations that tilts the tradeoffs to favor
often-used case by penalizing the less often-used case, this
change does not penalize any case while optimizing some cases,
so there is nothing we are losing.  I'll take the patch for this
reason.

However, I have a few comments.

Have you run any benchmark?  I suspect "and speeds things up" is
a gross overstatement.  A qualified "SOMETIMES speeds things up"
would be a more honest thing to say.

Both of the changes to git-am are definitely good.  Under normal
usage, we expect that we would see some diff, and the optimization
applies to that normal case.

> diff --git a/git-merge-ours.sh b/git-merge-ours.sh
> index 4f3d053..2b6a5c0 100755
> --- a/git-merge-ours.sh
> +++ b/git-merge-ours.sh
> @@ -9,6 +9,6 @@
>  # because the current index is what we will be committing as the
>  # merge result.
>  
> -test "$(git-diff-index --cached --name-status HEAD)" = "" || exit 2
> +git-diff-index --quiet --cached HEAD || exit 2
>  
>  exit 0

I think this does not change the performance profile in the real
life.  When the user uses the command correctly, we expect that
index and HEAD to match, and in that case the diff would take
the same amount of processing with or without --quiet.  The
change does not penalize the opposite case, so it is not a wrong
thing to do, but this is an optimization to error out early.

The first change to git-rebase optimizes the case to handle
"still to be adopted upstream" case ("upstream swallowed our
change" case would perform the same as before), so the
optimization would be more visible by people with slower
upstream and/or people patches of lessor quality that are
rejected by upstream often.  In other words, the amount of
speeding up by this change really depends on the user (there is
no slowdown for anybody so that is Ok).

The other optimizes the "erroring out early" uninteresting case.
