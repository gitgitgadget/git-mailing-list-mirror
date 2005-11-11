From: Junio C Hamano <junkio@cox.net>
Subject: Re: Strange merge conflicts against earlier merge.
Date: Fri, 11 Nov 2005 09:29:10 -0800
Message-ID: <7v64qzozyx.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90511091638k726d605r170717539225a712@mail.gmail.com>
	<20051111075257.GA4765@c165.ib.student.liu.se>
	<20051111114511.GQ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 18:31:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaciG-0000sX-2g
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 18:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750910AbVKKR3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 12:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750919AbVKKR3M
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 12:29:12 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:5618 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750910AbVKKR3L (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Nov 2005 12:29:11 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051111172822.GYWD29333.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 11 Nov 2005 12:28:22 -0500
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11618>

Petr Baudis <pasky@suse.cz> writes:

> Does core GIT have support for multibase merges, except for the
> recursive merge strategy? How do you do it?

There were lengthy discussion on this and a lot of work that
went into the resolution.  We do three things.

 - The first implementation does a trial read-tree 3-way using
   each of the base candidates without smudging the working
   tree, and counts paths that need file-level merges, to guess
   the best base, and uses that base.  This is in the 'stupid'
   stratagy.

 - The above turned out to have a risky corner case, especially
   when one side reverted a patch and the other one did not.  To
   address this, read-tree was rewritten and 3-way form of
   read-tree can take more than three trees these days, letting
   you feed it all the merge base candidates.  This code is used
   in 'resolve' strategy.

 - The 'recursive' strategy tries to come up with a merge of the
   candidate bases and uses it as the base of the final merge.
