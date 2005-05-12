From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [RFD] Add repoid identifier to commit
Date: Thu, 12 May 2005 10:35:57 -0700
Message-ID: <7vvf5ogxdu.fsf@assigned-by-dhcp.cox.net>
References: <1115847510.22180.108.camel@tglx> <428291CD.7010701@zytor.com>
	<1115854733.22180.202.camel@tglx> <428297DB.8030905@zytor.com>
	<1115858022.22180.256.camel@tglx>
	<7vekcdmd16.fsf@assigned-by-dhcp.cox.net>
	<1115884637.22180.277.camel@tglx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 12 19:29:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWHUa-0001dJ-Jb
	for gcvg-git@gmane.org; Thu, 12 May 2005 19:29:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262085AbVELRge (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 13:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262086AbVELRge
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 13:36:34 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:46226 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262085AbVELRg3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2005 13:36:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050512173558.OHPS16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 12 May 2005 13:35:58 -0400
To: tglx@linutronix.de
In-Reply-To: <1115884637.22180.277.camel@tglx> (Thomas Gleixner's message of
 "Thu, 12 May 2005 07:57:17 +0000")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Gleixner <tglx@linutronix.de> writes:

TG> Rn   o
TG>      | \
TG> Rn-1 o  |
TG>      |  o Mn
TG>      |  o Mn-1
TG> Rn-2 o /
TG> Rn-3 o

TG> The correct display looking at R is

TG> Rn
TG>  Mn
TG>  Mn-1
TG> Rn-1
TG> Rn-2
TG> Rn-3

TG> Looking from M it is

TG> Rn
TG>  Rn-1
TG>  Rn-2
TG> Mn
TG> Mn-2
TG> Rn-3

Thanks for a very clear explanation.  The situation is
intriguing in that both R and M after converging end up with
exactly the same HEAD with the same set of objects but still
would want to see history leading to the HEAD differently.

I wonder what happens to a third person S, who pulls from both R
and M.  What does S see?  

Does the commit order observed by S depend on which one S pulls
from first?  That is, if S pulls from R then at that point Mn-1
and Mn comes after Rn-1 in S's history?  And after that what
hapens if S pulls from M (which is obviously a no-op except that
it would update .git/refs/heads/M)?  Does the history for S
change?

IIRC, Cogito lets you "track" upstream branches.  When S starts
tracking R, does it see R's history and when S starts tracking M
its history view changes to that of M?

Let's further say R and M are both based on another upstream L,
and R and M have converged at this point.  S has been tracking L
and it merged from R and M.  If S did not have any local
modifications since L, then that is just two fast forward
merges.  What does the history look like to S?  Which comes
first---Mn or Rn-1?

The answer to the above could be "the merge order history is per
tree and not something to be exported or given away to other
trees", in which case it may make sense from S's point of view
that Mn and Rn-1 are compares solely based on their commit
timestamps.  You will get consistent history and switching which
tree is being tracked would not change the history.  Is the goal
here to give the merge order history from R and M to S?

If that is not needed, then you can record in an auxiliary file
that is local to each tree the timestamp of when merge happened
in that tree along with set of foreign commit objects, and teach
rev-tree or rev-list to read from that auxiliary file and use
that timestamp for foreign commit objects instead of commit time
recorded in them when sorting by time is needed.


