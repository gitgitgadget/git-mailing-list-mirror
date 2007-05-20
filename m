From: Junio C Hamano <junkio@cox.net>
Subject: Re: merge summaries
Date: Sun, 20 May 2007 02:07:15 -0700
Message-ID: <7vveenq2ws.fsf@assigned-by-dhcp.cox.net>
References: <25A3C618-8D12-42A8-9478-D3A4E7633CE7@zib.de>
	<alpine.LFD.0.98.0705181130580.3890@woody.linux-foundation.org>
	<7vodki55px.fsf@assigned-by-dhcp.cox.net>
	<73A1C4C5-50E9-4844-85F8-00D99682B6D4@zib.de>
	<7vy7jkwr96.fsf@assigned-by-dhcp.cox.net>
	<7vy7jkva41.fsf@assigned-by-dhcp.cox.net>
	<0E590255-A3F4-4D36-B798-80364ACD0D06@zib.de>
	<7vwsz3rjb6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun May 20 11:07:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HphO8-00041r-TW
	for gcvg-git@gmane.org; Sun, 20 May 2007 11:07:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbXETJHc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 05:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753191AbXETJHc
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 05:07:32 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:47739 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbXETJHb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 05:07:31 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520090731.LAHS19731.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 05:07:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1M7G1X0091kojtg0000000; Sun, 20 May 2007 05:07:26 -0400
In-Reply-To: <7vwsz3rjb6.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 20 May 2007 01:27:41 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47799>

Junio C Hamano <junkio@cox.net> writes:

> Steffen Prohaska <prohaska@zib.de> writes:
>
>> But this is true not only for the upstream master but for every branch.
>> The first-parent-path of any commit documents (at least in summaries)
>> which features were introduced to the branch at which place. If a
>> topic pulls from upstream, features already available in the upstream
>> are introduced to the topic at this time. Why not summarize this?

Because it does not matter from the overall picture at that
point.  In an earlier message I said that the summary is useful
in a very short term -- the summary messages are useful while
the person who did the merge (or somebody who is simply
following him) is looking at near the tip of the branch, but
when you are later viewing the older parts of the history from
10,000 feet above, the distinction between what were pulled into
the local branch of the person who made the merge vs what the
person already had on the branch when he made the merge becomes
more or less irrelevant.  The end result is that the project now
got the fruits of labor that happened on both sides.

> Strictly speaking, it is not even correct with the upstream
> master.  I believe even my own 'maint' has fast forward merge
> that I pulled from other people, and that part of the history if
> you follow first-parent, you would not be following the "project's"
> history (if there is such a thing, and if you are equating it
> with "JC's view of the history").

Regrettably, I have to say that --first-parent is, although it is
often a useful way to get an approximation, a bad option that
tends to instill a wrong mental model to people new to git.

In git, unlike CVS and SVN (I do not know now Monotone,
Mercurial and BitKeeper's branches work with this respect),
branches in git do not have their "own" identity in global
history that is recorded in the commit ancestry graph.  The only
way you can ask "how did this branch come about to this state?"
is to look at your own reflog, and that is strictly a local
thing (i.e. the history as you observed it).

Even when you are "the upstream maintainer" [*1*], there are
cases where you pushed your tips out to the open, other people
built their work on top of it while you were not adding anything
to your tree, and you end up pulling from them.  Such a pull
will result in a fast-forward merge, and that is rightly so.
They did all the work, and the collective history of the project
during that time literally followed what the other person did,
not the "upstream maintainer".  However, from the point of view
of somebody who is following the upstream maintainer's tree,
what he would observe is that at one point of the time the tip
of the tree was the last commit the upstream maintainer pushed
out (which became the base of the other person's work), and then
the next time you look at the tree there are bunch of commits by
the other person, appearing all at once even though there is no
"real" merge commit that summarizes the work done on the "side
branch".  Which some of the readers might feel a bit confusing
and inconsistent, but that is really the correct interpretation
of the history.  The reason I feel --first-parent helps this
confusion is that people would think it would be consistent if
we do not allow fast-forward merges and instead always forced a
real merge in such a case (then you would consistently get the
merge summary).  In other words, the first parent is not
inherently special -- and people should view history that way,
but --first-parent and merge.summary give this false impression
that it is somehow special.

Anyhow, enough rambling for a day.  Now I have two releases
to do tonight ;-)

[Footnote]

*1* In git, strictly speaking, there is no up or down, but as a
social convention, I get updates from Shawn, Paulus, Bruce and
few other people via pull, and it would not be too incorrect to
say I'm more upstream than they are, and all others are more
downstream.
