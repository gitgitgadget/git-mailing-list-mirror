From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-new-workdir doesn't understand packed refs
Date: Wed, 18 Apr 2007 09:23:14 -0700
Message-ID: <7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
References: <20070417161720.GA3930@xp.machine.xx>
	<Pine.LNX.4.64.0704172253140.14155@beast.quantumfyre.co.uk>
	<20070418055215.GA32634@xp.machine.xx>
	<7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
	<20070418081122.GB32634@xp.machine.xx>
	<Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Baumann <waste.manager@gmx.de>, git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Wed Apr 18 18:23:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeCwH-0007de-Gv
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 18:23:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754119AbXDRQXQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 12:23:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754130AbXDRQXQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 12:23:16 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:44478 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbXDRQXQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 12:23:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070418162315.ENUS1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Wed, 18 Apr 2007 12:23:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ogPE1W00n1kojtg0000000; Wed, 18 Apr 2007 12:23:15 -0400
In-Reply-To: <Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
	(Julian Phillips's message of "Wed, 18 Apr 2007 12:55:15 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44910>

Julian Phillips <julian@quantumfyre.co.uk> writes:

>>>  (1) We could by convention declare a worktree whose .git/refs
>>>      is a symlink, and have git-gc and friends check for it, and
>>>      either refuse to run or automatically chdir and run there.
>>>
>>>      If we were to do this, we probably should check more than
>>>      just .git/refs but some other symlinks under .git/ as well.
>>>
>>>  (2) We could dereference .git/packed-refs, when it is a
>>>      symlink, by hand, just like we dereference a symlink HEAD
>>>      by hand (see resolve_ref() in refs.c), and run the
>>>      creat-to-temp-and-then-rename sequence to update the real
>>>      file that is pointed at by it.
>>>
>>
>> Its not all the clear which one is the best, but (2) sounds as the most
>> promosing aproach. Hopefully, I'll have time to cook up a patch this
>> evening.
>
> Personally I think (1) might be slightly better, in the refuse to run
> form.  gc is a repository operation, not a working directory one - and
> by refusing to run in a workdir this is made clear.  You could print
> out a message that includes the location of the actual repo to be more
> friendly though.

I've seen Peter's patch that attempts to do (2), and I think
that probably is a right direction.  A worktree that borrows a
repository from another worktree is trying to allow you to do
as many things you would normally do in the original worktree,
with a caveat: certain things are less safe and/or confusing and
you must know what you are doing if you use such a setting.

> But whatever solution you go for, you can't use _any_ workdir that
> points at a repo that is having gc run on, either directly or
> indirectly, without risky odd behaviour.

And I think the above is just one of certain things that are
less safe (one "confusing" is that working on the same branch
would result in gremlin updates).  

There still is an issue of what to do if the .git/packed-refs is
a symlink to a symlink.  Peter's patch does a wrong thing, by
creat-then-rename overwriting the symlinked target; at least we
should detect that case and error out, I think.

Recursively dereferencing the symbolic link by hand to a limit
to avoid infinite recursion (error out when we reach the limit)
would be a more elaborate solution that probably is the right
thing to do.
