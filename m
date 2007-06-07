From: Junio C Hamano <gitster@pobox.com>
Subject: Re: pull/merge --no-commit
Date: Thu, 07 Jun 2007 11:58:22 -0700
Message-ID: <7vvedzpp69.fsf@assigned-by-dhcp.cox.net>
References: <46678909.10608@alcatel-lucent.com>
	<7vfy54qqu8.fsf@assigned-by-dhcp.cox.net>
	<46684EFD.1080804@alcatel-lucent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: kurt_p_lloyd <kplloyd@alcatel-lucent.com>
X-From: git-owner@vger.kernel.org Thu Jun 07 20:58:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwNC0-00019L-Oc
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 20:58:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763462AbXFGS6Z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 14:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932755AbXFGS6Z
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 14:58:25 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35147 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763462AbXFGS6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 14:58:24 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070607185823.LZAD5800.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 7 Jun 2007 14:58:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 8iyN1X00l1kojtg0000000; Thu, 07 Jun 2007 14:58:23 -0400
In-Reply-To: <46684EFD.1080804@alcatel-lucent.com> (kurt p. lloyd's message of
	"Thu, 07 Jun 2007 14:31:25 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49378>

kurt_p_lloyd <kplloyd@alcatel-lucent.com> writes:

> Maybe there is a different workflow to effectively achieve what
> I want via steps 1, 2, and 3 (way above).  In other words, OK I do
> a 'pull', and all 3 steps occur together.  Then suppose that I
> contemplate the changes that got committed, and that I disapprove
> of either a majority or all of those changes.  I'd like to be able
> to cleanly and easily recover from this with no related commits and
> "revert commits" in git log.

Let's say you did this:

 $ git pull $other_party

A "pull" is a "fetch" (download their history and objects)
followed by a "merge" (integrate that history with your
history).  When it goes without merge conflicts you need to
resolve by hand, the above will move your HEAD to reflect the
new histroy of your project, including the fact that you merged
with the $other_party, at this point.  The above command gives
you the overview of the change in the form of diffstat.

You would naturally want to inspect and convince yourself that
you did not pull crap from the $other_party.  A special symbol
ORIG_HEAD is set up after a "merge" (be it a "fast forward" or a
true merge) that lets you easily access where the tip of your
branch was before the merge.

To view the damage the $other_party inflicted on you as a whole:

 $ git diff ORIG_HEAD..

Or to inspect individual patches:

 $ git log -p ORIG_HEAD..

Some people seem to prefer "git log --reverse -p ORIG_HEAD..",
which would give their changes in chronological order.

If it turns out that you pulled crap from the $other_party, you
can get rid of that away from the history of your branch with:

 $ git reset --hard ORIG_HEAD

> I'll add my own deliberate commits if
> and when I decide that I really /would/ like some or all of those
> changes eventually, in which case I would still like the proper
> context to exist in the "database" for me to bring the selective
> remote changes into my local branch in a natural way.

In git managed projects that care about the readability of
global history, this often is done by asking $other_party to
redo the branch, discarding broken/undesirable bits.

But if you do not have the clout to do so over the $other_party,
then you could, after the above sequence, cherry pick good bits
from what the $other_party has and you don't.  This however will
make your history and their history to have different commits
that record the result of the same patch application; if you
later pull from the $other_party again, you will end up having
two copies of the (logically) same commit in your history.
