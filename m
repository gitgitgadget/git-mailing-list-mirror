From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Do not call git-rev-list from git-fetch-pack
Date: Fri, 21 Oct 2005 01:51:10 -0700
Message-ID: <7virvrw8w1.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510210413210.26388@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 21 10:53:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESscY-0007Wk-Ew
	for gcvg-git@gmane.org; Fri, 21 Oct 2005 10:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVJUIvN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 21 Oct 2005 04:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbVJUIvN
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Oct 2005 04:51:13 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13459 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S932550AbVJUIvM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Oct 2005 04:51:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051021085112.ZHWX9260.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 21 Oct 2005 04:51:12 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10427>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +	   Branch1 has 40 commits since it last merged with branch2,
> +	   and branch2 has 2 more commits since then.
> +
> +	   On the other end, branch1 is up-to-date, but branch2 is not.
> +	   When fetching branch1, the 40 commits get sent, the first
> +	   is acknowledged as common, and the local head of branch2
> +	   never gets sent.
> +
> +	   As a consequence, the whole history of branch2
> +	   (git-rev-list branch2 ^branch1) gets packed and transmitted.

Arrrgggggggh.  The description above captures the essense of the
problem very well, but faking dates and still popping by recency
looks like a really ugly hack to me.

Wouldn't it be cleaner if you traversed commits starting from
local refs, and assign distance from the tip of the branch to
each object (use generic object->util field for it), and
maintain an object_list that is sorted by depth, similar to
commit_list sorted by commit date?  Then you can pop from the
list by depth, closer to tip first, and tell the other end that
you have branch1, branch2, branch1^, branch2^, branch1~2,
branch2~1,...  which is the order the above situation benefits
from.
