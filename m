From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: CAREFUL! No more delta object support!
Date: Wed, 29 Jun 2005 17:05:32 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506291644120.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506291142510.14331@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jun 29 23:01:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dnjfp-0004xW-Hl
	for gcvg-git@gmane.org; Wed, 29 Jun 2005 23:00:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbVF2VHv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Jun 2005 17:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbVF2VHv
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jun 2005 17:07:51 -0400
Received: from iabervon.org ([66.92.72.58]:48903 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S262397AbVF2VHY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 29 Jun 2005 17:07:24 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DnjkT-00000P-00; Wed, 29 Jun 2005 17:05:33 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506291142510.14331@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 29 Jun 2005, Linus Torvalds wrote:

> and you now have moved over _all_ the objects that were referenced in "a",
> but not in "b". Including tags etc. So after that last stage, when you've
> unpacked the objects, the only thing left to do is to make the refs in "b"  
> point to the new references from "a" (which basically boils down to a
> "cp", except it would be good to verify that the refs in "b" still have
> the same values as they did before we did the object push).
> 
> Daniel (or anybody else), interested? Please?

I'll probably get to this over the weekend.

> Of course, you can do this one branch at a time, too, if you want to, but
> the above was meant as an example of how you can actually do all the
> branches in one single pack-file, which is a lot more efficient (if you do
> it one branch at a time, you'll quite possible end up transferring objects
> that are reachable in other branches multiple times, while the "all in one
> go" thing will pack each object just once).

It should transfer each only once if you recalculate "refs_in_b" after
each push, right? Or is the marking for "--objects ^commit" still not
tight wrt object and tree files? I think branch-at-a-time is preferable
for the case where the source doesn't want to send quite everything, and
the target doesn't necessarily want everything named the same.

> Now, have I actually _tested_ the above? Hell no. But all the heavy 
> lifting should now be done for doing an efficient "git push" that pushes 
> all branches in one go (or one at a time, it's your choice on how you end 
> up using git-rev-list).

The one thing I can think of is whether things will blow up if the target
repository has heads that aren't in the source, at which point the source
has no clue what to exclude. I.e.:

parent -- new-b
  \
   new-a

If I've moved the head on b forward to new-b, and a wants to push new-a
(as a new branch, perhaps), refs_in_b has only new-b, refs_in_a has parent
and new-a, and git-rev-list in a can't see that b has parent (and
everything upwards of that). You probably just don't want to do this, but
I bet that some people will (e.g. projects that synchronize through a
shared-owner repository).

	-Daniel
*This .sig left intentionally blank*
