From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] combine-diff: add safety check to --cc.
Date: Thu, 02 Feb 2006 16:02:56 -0800
Message-ID: <7v64nxmhqn.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602012212200.21884@g5.osdl.org>
	<7v8xsuuto5.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602012334360.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602012353130.21884@g5.osdl.org>
	<Pine.LNX.4.64.0602020002110.21884@g5.osdl.org>
	<7voe1qtbr5.fsf_-_@assigned-by-dhcp.cox.net>
	<7vvevyrtn9.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602021454060.21884@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 01:03:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4oQ6-0006d8-H3
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 01:03:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964780AbWBCADA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 19:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964779AbWBCADA
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 19:03:00 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:14578 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S964780AbWBCAC7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Feb 2006 19:02:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203000041.CDVW17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Feb 2006 19:00:41 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602021454060.21884@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 2 Feb 2006 15:03:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15520>

Linus Torvalds <torvalds@osdl.org> writes:

> Ok, my testing shows that this is all wonderful.

Thanks for the compliment.

> And now when I look at Len's "Merge from hell", not only does it take less 
> than 2 seconds for git-diff-tree to calculate, it looks correct too. At 
> least I don't see anything that I consider extraneous, although it might, 
> of course, have removed too much, and I'd not notice.

Two seconds?  You must be using CPUs/disks/memory that are lot
faster than what I use (the kernel.org machine available to me
seems to do it at around 3.5 wallclock seconds).  Envy, envy,...

I've done a couple of fixups and added one missing feature and
have pushed it out in 'pu' after some final testing.  The
missing feature was line numbers from each parent.  I could not
count them right for a long time for some unknown silliness.

Before setting the output format in stone by having gitk
interpret it, I'd like to do a quick sanity-check poll.

Len's merge is a bit too wide, so I'll use GIT 1.0.0 commit as
an example.  Here is what I have right now.

        $ git diff-tree --cc v1.0.0 -- debian/changelog | head -n 15
        c2f3bf071ee90b01f2d629921bb04c4f798f02fa
        diff --cc debian/changelog
        index d36904c..376f0fa->4fa6c16
        @@@ +1,93 -1,87 -1,3 @@@
        ++git-core (1.0.0-0) unstable; urgency=low
        ++
        ++  * GIT 1.0.0
        ++
        ++ -- Junio C Hamano <junkio@cox.net>  Wed, 21 Dec 2005...
        ++
         +git-core (0.99.9n-0) unstable; urgency=low
         +
         +  * GIT 0.99.9n aka 1.0rc6
         +
         + -- Junio C Hamano <junkio@cox.net>  Wed, 14 Dec 2005...

Two things to note.

 * Somebody said he missed "index" lines.  There is one now, but
   I am wondering if it might be just be an added noise.  It
   gets absolutely horrible if you run diff-tree on Len's merge.
   On the other hand, being able to cut&paste them to "git
   cat-file blob" command line might be handy.

   Do we want to keep it?

   If we were to keep it, is the format OK?  It lists parent
   blob names (double-dot separated), an arrow, and then result
   blob name.  An alternative would be parent,parent..result,
   like this:

        index d36904c,376f0fa..4fa6c16

   which might be more consistent with the normal ones.

 * I show the line number from the result (+1,93) and then
   parents' line numbers (-1,87 for the first parent, -1,3 for
   the second parent).  To be consistent with the normal ones, I
   am thinking it might be better to move the line number for
   the result to the last.  One downside of that change is I
   tend to use the line number of the result to look up the full
   result more often than to use the line number of the parent,
   and something like Len's merge would push the most important
   line number off the edge of the screen.

   Do we want to keep it the way it is, or do we want to do
   this instead?

        @@@ -1,87 -1,3 +1,93 @@@
