From: Junio C Hamano <junkio@cox.net>
Subject: The index is based on blah, however, the HEAD points at different commit.
Date: Sun, 08 Apr 2007 23:10:16 -0700
Message-ID: <7vps6e5b93.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vwt0uypz7.fsf@assigned-by-dhcp.cox.net>
	<7vhcrvti9i.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 09 08:11:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Han5V-0008MI-BB
	for gcvg-git@gmane.org; Mon, 09 Apr 2007 08:10:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752989AbXDIGKU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Apr 2007 02:10:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752995AbXDIGKU
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Apr 2007 02:10:20 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:50918 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752989AbXDIGKS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Apr 2007 02:10:18 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070409061017.VRJX1606.fed1rmmtao104.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Apr 2007 02:10:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id kuAG1W00L1kojtg0000000; Mon, 09 Apr 2007 02:10:17 -0400
In-Reply-To: <7vhcrvti9i.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 05 Apr 2007 00:03:37 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44041>

Junio C Hamano <junkio@cox.net> writes:

> * jc/checkout (Thu Mar 29 01:23:12 2007 -0700) 4 commits
>  + Use BASE index extension in git-commit and git-merge.
>  + update-index --{set,get}-base
>  + Add BASE index extension.
>  + checkout: allow detaching to HEAD even when switching to the tip
>    of a branch
>
> I've rewritten the bottom commit not to require an explicit -d
> option when detaching.  You can say "git checkout master^0"
> instead to get a detached head that is at the tip of master.  I
> may make that one commit graduate to 'master' earlier than
> others.
>
> This series is primarily to make it safer when somebody else
> updates the tip of the branch you have currently checked out.
> As I said in previous messages, I think the series covers basic
> operations fine but there probably are gaps in the coverage.
> Motivated volunteers are needed to fill them.

Regarding this series, if you find a command sequence that does
this:

 (1) A command that is BASE aware (e.g. "git commit") is used to
     point HEAD at a commit and records it in the index; and then,

 (2) A command that is not yet BASE aware moves the HEAD
     (perhaps creating a commit) but does not cause the
     previously recorded BASE in the index to be updated to
     point at the new HEAD (e.g. "git am");

your next invocation of a command that is BASE aware would barf,
saying something like:

  * The index is based on 'c053f05... My earlier commit made in (1).', however, the HEAD
    points at different commit '4fc2da4... The last of commits made with (2).'

When this happens, please first run "git-runstatus" [*1*] and
"git-diff HEAD" to see if this is a false positive.  If the
output shows the differences from the HEAD you expect to see and
you are sure your index is derived from the current HEAD, and
not the error message indicates (in the above example, c053f05
is such a wrong commit), that means you ran some command that
needs to be taught about the BASE.

A work-around until that command is fixed is to run this:

	$ git update-index --set-base `git-rev-parse HEAD`

This corrects the base commit recorded in the index to match
your current HEAD commit to allows you to keep going.

Motivated volunteers can help us further by doing two more
things.  One is obviously to report such a case and identify
such a BASE unaware command, and even better, make it BASE
aware and send in patches.

Another thing is to make a habit of running 'git update-index
--get-base' after doing any git operation to see if the index
correctly records the base commit.  

Currently, when git-read-tree is used to update the index, the
base information is discarded, and 'git update-index --get-base'
will return empty.  Commands that are already BASE aware will
not trigger when the index does not record any base.  This is to
prevent too many false positives while this safety feature is
still in development, but that means more false negatives.  We
should minimize this base clobbering so that we can use multiple
work trees tied to the same repository more safely.

I'll follow-up this message with four patch series to make "git am"
and "git reset" BASE aware.


[Footnote]

*1* We need to fix "git status" to be usable for this as well,
but currently it shares much of its code with "git commit" and
triggers the same false positive)
