From: Junio C Hamano <junkio@cox.net>
Subject: Re: git merge and merge message
Date: Sun, 11 Mar 2007 13:56:46 -0700
Message-ID: <7vwt1nv6r5.fsf@assigned-by-dhcp.cox.net>
References: <200703111505.l2BF54Kq006625@localhost.localdomain>
	<20070311160424.GA629@fieldses.org>
	<200703111815.l2BIFHbq010315@localhost.localdomain>
	<Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Xavier Maillard <zedek@gnu.org>,
	"J. Bruce Fields" <bfields@fieldses.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 21:56:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQV63-0001oL-De
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 21:56:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbXCKU4s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 16:56:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbXCKU4s
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 16:56:48 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41524 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932130AbXCKU4r (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 16:56:47 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070311205647.YKXE24587.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sun, 11 Mar 2007 16:56:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZYwm1W00l1kojtg0000000; Sun, 11 Mar 2007 16:56:47 -0400
In-Reply-To: <Pine.LNX.4.64.0703111309410.9690@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 11 Mar 2007 13:19:00 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41980>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> At the same time, I think that the kind of behaviour that Xavier is 
> talking about, where you actually end up having feature branches for your 
> own project, and then using
>
> 	git merge -m "Merge feature Xyz" xyz-branch
>
> is potentially a really good way of making it clear that the code along 
> the branch you merged did Xyz.
>
> My other rule in life is that a tool should not *force* a certain policy 
> (although encouraging good behaviour by making that the *easy* thing to do 
> is a good idea), so I think that it would probably be ok to add a flag to 
> "git merge" to say "force a merge commit", which would disable the 
> fast-forward behaviour.
>
> (And if you don't support it for "git pull", maybe that's enough of a 
> disincentive that you won't see the "maintainer marking his territory by 
> peeing in the snow" behaviour).
>
> Comments? Do people think it would be a good idea to do
>
> 	git merge --no-fast-forward -m "Merge feature Xyz" xyz-branch
>
> as an option?
>
> 			Linus

For one thing, this would make the earlier "first parent log
summary" idea useful again.

The big picture of the evolution history of my 'next' can be
seen by taking only the first parent ancestry, since the commit
message in each of them has the summary of commit^..commit,
coming from the fmt-merge-message output.  This is because there
won't be any fast-forward on 'next' as I never fork off of the
tip of 'next'.

However, that is not true for my 'master'.  When I merge a topic
back into 'master' when the 'master' hasn't added any obvious
and trivial fixups or improvements since the topic forked, it
would result in a fast-forward.  --no-fast-forward can be used
to cure this.

So in that sense I think --no-fast-forward is a useful
ingredient to make a history that is easy to read in "fast
parent log" fashion, but:

  (1) it is only just one "enabler" -- you still need the
      discipline to build your history that way, and

  (2) it is dubious if it is really useful to present the
      history in "fast parent log" fashion for even trivial
      topics.

Regarding (2), a fast-forward into the trunk (or master) is a
sign that nothing else was going on in the meantime, so it is
either the series was very short (suggesting "_trivial_ changes
on top of master"), and/or the only focus of the project during
that timeperiod (suggesting "trivial changes _on top of
master_"), either of which may mean that it would be good enough
to just have a commit log message that says "This concludes the
series I started at commit Xyz to do blah" without having an
extra forced merge.

If the answer to (2) is "yes, it is useful", then maybe building
such a history needs to be helped with more tool support (that
is my point (1) above).  

For example, _if_ I wanted to (mind you, in reality I don't
think I necessarily do), I could forbid direct single-parent
commits on top of 'master' branch, and force --no-fast-forward
when merging to 'master' branch.  That perhaps would be achieved
by marking the branch with 'branch.master.integrationonly = true'
configuration.
