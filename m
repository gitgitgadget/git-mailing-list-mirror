From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: On ref locking
Date: Mon, 25 Sep 2006 13:05:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0609251140550.9789@iabervon.org>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
 <200609231322.30214.chriscool@tuxfamily.org> <7veju2nthl.fsf@assigned-by-dhcp.cox.net>
 <200609240645.54467.chriscool@tuxfamily.org> <7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 25 19:06:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GRttv-0003vR-6j
	for gcvg-git@gmane.org; Mon, 25 Sep 2006 19:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751266AbWIYRFq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 13:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWIYRFq
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 13:05:46 -0400
Received: from iabervon.org ([66.92.72.58]:11012 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751266AbWIYRFp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Sep 2006 13:05:45 -0400
Received: (qmail 22972 invoked by uid 1000); 25 Sep 2006 13:05:43 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Sep 2006 13:05:43 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27746>

On Mon, 25 Sep 2006, Junio C Hamano wrote:

> The comments you added to the strawman I sent suggested use of
> rather heavyweight locks, which made me feel we were somehow
> going in a wrong direction.  Before going into the details of
> branch removing, let's first see if we can summarize what kind
> of guarantee we would want from ref updates.  The current
> locking scheme is very carefully and nicely done by Linus and
> Daniel Barkalow around June last year, and I do not want to lose
> good property of it.
> 
>  - When reading and/or listing refs you do not need to acquire
>    any lock.
> 
>  - When you are going to update an existing $ref, you create
>    $ref.lock, and do a compare-and-swap.
> 
> What the latter means is that an updater:
> 
>  (1) first learns the current value of the $ref, without
>      locking;
> 
>  (2) decides based on the knowledge from (1) what the next value
>      should be;
> 
>  (3) gets $ref.lock, makes sure $ref still is the value it
>      learned in (1), updates it to the desired value and
>      releases the lock.
> 
> The above 3-step sequence prevents updater-updater races with an
> extremely short critical section.  We only need to hold the lock
> while we do compare and swap.

I remember having a certain amount of disagreement over whether it's 
better to actually take the lock in (1), and hold it through (2), or only 
verify that it didn't change in (3) after taking the lock for real. If 
there's nothing substantial going on in (2), it doesn't matter. If users 
are producing content (e.g., git tag), they may want to make sure that 
nobody else is in the middle of writing something that would conflict.

I think I'd advocated getting the lock early if you're going to want it, 
and I don't remember what the convincing argument on the other side was 
for the cases under consideration at the time, beyond it not mattering 
significantly.

Note that we make sure to remove the lock when aborting due to signals 
(assuming we get a chance), so the size of the critical section doesn't 
matter too much to the chance of it getting left locked inappropriately. 
Of course, this is harder to do with the core code for a shell script than 
for C code.

	-Daniel
*This .sig left intentionally blank*
