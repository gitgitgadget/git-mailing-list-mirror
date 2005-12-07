From: Junio C Hamano <junkio@cox.net>
Subject: Re: server-info dumbing-down
Date: Wed, 07 Dec 2005 14:45:58 -0800
Message-ID: <7vzmncmspl.fsf@assigned-by-dhcp.cox.net>
References: <20051207215853.GL22159@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 07 23:46:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ek83D-0004S4-Ad
	for gcvg-git@gmane.org; Wed, 07 Dec 2005 23:46:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030398AbVLGWqD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 17:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751778AbVLGWqB
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 17:46:01 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56780 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751813AbVLGWqA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 17:46:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051207224443.DUJE17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 17:44:43 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051207215853.GL22159@pasky.or.cz> (Petr Baudis's message of
	"Wed, 7 Dec 2005 22:58:53 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13351>

Petr Baudis <pasky@suse.cz> writes:

>   I've noticed few commits from Dec 4 landing into the git repository,
> which remove various computations and corresponding lines from the
> server info (3e15c67 and few ancestors). I'm curious about this - were
> the computations that hugely computationally expensive? If not, wouldn't
> it be better to leave it in for future use (since it doesn't cost a lot)
> rather than making the future deployment of anything using this data
> much harder since the server infos won't have it anymore?

T and D lines were expensive.  Very expensive.

They are not used by existing Porcelains.

It is dubious if those lines are useful.

The information those lines were attempting to give Porcelains
were designed way before dumb-transport clients were completed,
and it was purely a guesswork what _might_ be needed by them.

For example, I did not foresee that dumb-transport clients would
grab all the .idx files to see which packs are needed themselves
without consulting T lines (which turns out to be the right
thing to do anyway), and once they have the .idx file, clients
can do better computation themselves to pick which pack is the
best one to fetch without help from the T and D lines.

For example, if we implement the "staggered overlapping packs"
you suggested, the clients will face a choice when walking the
commit chain.  Two packs may give the object currently being
sought after.  Which one to pick?  One strategy would be to pick
the one that contains least number of objects we already have.
Another would be to pick the one that contains the most number
of objects we do not have yet.  This can be done with only
having .idx files, and you need to have .idx files for both of
them to realize that you have a choice to begin with.

IIRC, in your "staggered packs" approach, some recent objects
are left unpacked and also in the latest pack.  Clients that
have all the objects in the latest pack are better off walking
individual commits, while other clients that are way behind are
better off fetching the pack.  To help them, we would need to
describe the object database differently from the way
objects/info/packs attempted with those T and D lines.  We need
to say "if you do not have these objects, do not walk individual
commits beyond this commit, even though they are available as
loose objects, because you are better off grabbing this pack
instead".

For these reasons, I feel that the whole thing should be
stripped down first.  The improvements to the dumb-transport
clients may need additional information to be computed by
server-info, but it is far more likely than not that those
additional information would be quite different from what T and
D lines were giving them.  

The repacking strategy, the repacking program to prepare the
repository to be helpful to dumb-transport clients, the logic in
the clients to take advantage of that repacking strategy, and
the additional information server-info supplies to help that
happen, need to be designed together, and in this order.  The
old T/D lines were developed in a wrong order --- we did not
know what the best repacking strategy was (and I suspect we
still don't) and these lines were done without knowing if they
are useful.
