From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] merge-base.c: pathological case fix.
Date: Thu, 11 Aug 2005 22:27:51 -0700
Message-ID: <7vwtmr912g.fsf@assigned-by-dhcp.cox.net>
References: <7virydlzal.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508110840080.3295@g5.osdl.org>
	<7vbr44f5s1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0508111601000.3295@g5.osdl.org>
	<7vk6isc5x1.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 07:28:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3S5K-0007Cp-Ss
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 07:28:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbVHLF1x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 Aug 2005 01:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751048AbVHLF1x
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Aug 2005 01:27:53 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:63726 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750865AbVHLF1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Aug 2005 01:27:53 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050812052752.TVUI1367.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 12 Aug 2005 01:27:52 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I wrote:

> + *                  F
> + *                 / \
> + *            E   A   D
> + *             \ /   /  
> + *              B   /
> + *               \ /
> + *                C
> + *
> + * First we push E and F to list to be processed.  E gets bit 1
> + * and F gets bit 2.  The list becomes:
> + * ...
> + * Next, we pop B and something very interesting happens.  It has flags==3
> + * so it is also placed on the result list, and its parents are marked
> + * uninteresting, retroactively, and placed back on the list:
> + *
> + *    list=C(7), result=C(7) B(3)
> + * 
> + * Now, list does not have any interesting commit.  So we find the newest
> + * commit from the result list that is not marked uninteresting.  Which is
> + * commit B.

I suspect we could have "list" where all commits on it is
uninteresting, while "result" has an interesting commit that
turns out to be reachable from one of the uninteresting commits
that is still on "list", and we miss it because we give up as
soon as "list" contains nothing but uninteresting ones.

I have not come up with such a pathological example, but if that
is indeed the case, we would still end up terminating the
well-contamination too early.  I have a suspicion that no matter
how we cut it we would have this horizon effect anyway, and if
we want to really do the perfect job then we cannot avoid
traversing to the root.

Since merge-base is aiming to be a heuristic that works well
enough in practice, I think we should declare victory now and
not aim for perfection, which is an enemy of the good.
