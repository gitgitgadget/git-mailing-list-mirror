From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-branch: show detached HEAD
Date: Tue, 02 Jan 2007 22:53:41 -0800
Message-ID: <7v7iw4r47e.fsf@assigned-by-dhcp.cox.net>
References: <7vac11yirf.fsf@assigned-by-dhcp.cox.net>
	<1167780131528-git-send-email-hjemli@gmail.com>
	<20070103051811.GB23358@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lars Hjemli <hjemli@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 03 07:53:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H200Q-0000BO-LY
	for gcvg-git@gmane.org; Wed, 03 Jan 2007 07:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754658AbXACGxo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Jan 2007 01:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754670AbXACGxn
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Jan 2007 01:53:43 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:41087 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754658AbXACGxn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jan 2007 01:53:43 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070103065342.YNQZ9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Wed, 3 Jan 2007 01:53:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6Wtw1W00m1kojtg0000000; Wed, 03 Jan 2007 01:53:57 -0500
To: "Shawn O. Pearce" <spearce@spearce.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35846>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Lars Hjemli <hjemli@gmail.com> wrote:
>> This makes git-branch show a detached HEAD as '* (no branch)'.
>
> It would be nicer if when you are on a remote tracking branch or
> on a tag that the name of the tag or the remote tracking branch is
> shown rather than '* (no branch)'.

That would be utterly confusing if you are talking about the
same detached HEAD semantics as I and Carl discussed today.  I
like what Lars's patch does (although I felt that it was too big
for only doing this which made it harder to judge), but I would
even make it stronger to say something like:

	* You are not on ANY branch right now.
          master
          next
          pu
          ...

You will never be _on_ a remote tracking branch.  So far we did
not allow HEAD to point at outside refs/heads/ and we still
don't.  When HEAD is detached from any branch, however, it can
store a bare 40-hex (plus LF) commit object name instead of
being a symref.  You are not on any branch at that point.

Most importantly, if we allow commits to be built on top of HEAD
while it is detached from any branch, the commit will _not_
advance any branch.  So showing the remote tracking branch the
way you suggest will be misleading.

If we do not allow commits to be built on top, we would still
allow something to be done other than switching out of "detached
mode" to be useful.  For example, reset to move around which
commit to look at would be a useful thing.  Another of my
unstated desire is to get rid of the use of special "bisect"
branch during bisection using detached HEAD.  Again, if we
highlight remote tracking branch whose tip happens to be the
same commit as the current HEAD as you suggest, that would lead
to quite confusing behaviour.  Sometimes it would say the same
thing as you are _on_ that branch (which confuses you because
you are _not_ on that branch in reality), sometimes it would
highlight nothing to show you are not on any branch.
