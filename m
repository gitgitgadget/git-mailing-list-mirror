From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on recursive merge..
Date: Fri, 11 Nov 2005 14:25:49 -0800
Message-ID: <7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 23:27:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EahLJ-0000gA-AS
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 23:25:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751216AbVKKWZw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 17:25:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751278AbVKKWZw
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 17:25:52 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:58367 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1751216AbVKKWZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 17:25:51 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111222457.XDQU776.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 17:24:57 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 7 Nov 2005 16:33:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11639>

Linus Torvalds <torvalds@osdl.org> writes:

>> Another thing to consider is if it is fast enough for everyday
>> trivial merges.
>
> Hmm. True. The _really_ trivial in-index case triggers for me pretty 
> often, but I haven't done any statistics. It might be only 50% of the 
> time.

Just for fun, I randomly picked two heads/master commits from
linux-2.6 repository (one was when I happened to have pulled the
last time, and the other was when I thought this might be an
interesting exercise and pulled again), and fed the commits
between the two to a little script that looks at commits and
tries to stat what they did (the script ignores renames so they
appear as deletes and adds).

Here is what the script spitted out:

        Total commit objects: 3957
        Trivial Merges: 72 (1.82%)
        Merges: 225 (5.69%)
        Number of paths touched by non-merge commits:
                average 4.50, median 2, min 2, max 199
        Number of merge parents:
                average 2.00, median 2, min 2, max 2
        Number of merge bases:
                average 1.00, median 1, min 1, max 1
        File level merges:
                average 37.61, median 8, min 0, max 555
        Number of changed paths from the first parent:
                average 379.09, median 66, min 1, max 7553
        File level 3-ways:
                average 1.96, median 1, min 0, max 37
        Paths deleted:
                average 47.56, median 15, min 0, max 554

This counts what happened in individual devleoper's trees,
subsystem maintainer trees and your tree, not just what you saw
yourself.

Some observations.

 - Trivial Merges count is surprisingly high.  About 1/3 of
   merges are pure in-index merges.

 - Most of the commits (developer commits, not merges) are
   small and touches only a couple of paths.

 - Nobody does octopus ;-).

 - We did not have multi-base merge case during the period
   looked at (but the sample count is very low).

 - merge-one-file was called for only a handful (median 8)
   files, which is negligibly small compared to the total 17K
   files in the kernel tree, and fairly small compared to the
   number of changed paths from the first parent (meaning,
   read-tree trivial collapsing helped majorly).  Among them,
   the number of paths that needed real file-level 3-way merges
   were even smaller (avg 1.96).

   All three of these points together is a fine demonstration
   that you designed git really right.

The samples were between these two commits:

commit 6693e74a16ef563960764bd963f1048392135c3c
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Tue Oct 25 20:40:09 2005 -0700

commit 388f7ef720a982f49925e7b4e96f216f208f8c03
Author: Linus Torvalds <torvalds@g5.osdl.org>
Date:   Fri Nov 11 09:26:39 2005 -0800
