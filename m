From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on git fetch to bare repo
Date: Mon, 12 Feb 2007 21:28:10 -0800
Message-ID: <7vejou39ud.fsf@assigned-by-dhcp.cox.net>
References: <17867.41997.561756.679778@lisa.zopyra.com>
	<20070209023941.GE10574@coredump.intra.peff.net>
	<17872.53830.887188.137662@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 06:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGqD9-000288-Re
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 06:28:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161074AbXBMF2M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 00:28:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbXBMF2M
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 00:28:12 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:50342 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161074AbXBMF2L (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 00:28:11 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213052811.BLSD21704.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 13 Feb 2007 00:28:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id NtUA1W00j1kojtg0000000; Tue, 13 Feb 2007 00:28:11 -0500
In-Reply-To: <17872.53830.887188.137662@lisa.zopyra.com> (Bill Lear's message
	of "Mon, 12 Feb 2007 14:47:02 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39494>

Bill Lear <rael@zopyra.com> writes:

> The problem I have with doing all of my fetching and merging in my
> private repo is this: I have an update hook in my public repo that I
> use to communicate my changes to my peers.  The problem is when I pull
> from a peer's repo into my private repo, make some of my changes, and
> then publish (push) my changes to the public repo, HIS changes are
> pushed as well, and the update script naturally picks up on these and
> broadcasts them.  My peer group ends up getting the same update
> message about his commits that they have already received.  Multiply
> this among 6 peers and it becomes a real headache.

I suspect that is because your "email when pushed" hook lists
what commits are new on the branch.  I do not use any "email
when pushed" hook myself, so I do not know how yours is set up,
but I suspect it is doing a moral equivalent of:

	#!/bin/sh
	name=<name of the branch the email will talk about>
	old=<commit before this push updates the branch tip>
        new=<commit this push is trying to update the branch tip with>

	git shortlog $old..$new |
        mailx -s "branch $name updated" recipients

That behaviour might be desirable when branches in the
repositories are more or less independent, but in situations
like yours where commit are cross pushed into each other's
branches, you are not necessarily interested in the progress of
each branch.

One solution would be to list only the new commits introduced by
the push into the repository, regardless of the branch.  You can
replace the "git-shortlog $old..$new" with:

	git shortlog $new --not --all

to get that information, I think.
