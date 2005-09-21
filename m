From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Core GIT] Long-term cherrypicking
Date: Wed, 21 Sep 2005 13:57:04 -0700
Message-ID: <7vzmq6p2an.fsf@assigned-by-dhcp.cox.net>
References: <20050921164015.GC21971@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 22:58:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIBeP-0002Kc-Tz
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 22:57:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964822AbVIUU5H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 16:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964833AbVIUU5H
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 16:57:07 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:41463 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S964822AbVIUU5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Sep 2005 16:57:05 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050921205705.BVOA21449.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 21 Sep 2005 16:57:05 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050921164015.GC21971@pasky.or.cz> (Petr Baudis's message of
	"Wed, 21 Sep 2005 18:40:15 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9077>

Let me see if I understand what you are trying to solve.

S is subsystem line of development, L is Linus line of
development, M is a merge from L into S.

A' and B' are resulting commits from e-mail patch, that contain
changes introduced to S by A and B commits, respectively.

 S:     A - B - C - M - D - ...
      /           /      
 L:  O- X - A'- Y - Z - ...

After sending off patches A and B, L accepts only A and creates
commit A'.  After a while, S pulls from L and merges at M [*1*].
In the meantime, there are other changes on both ends (C and Y).
Also note that I am not drawing commits in S that are not to
be sent to L via e-mail nor pull request -- there may be other
commits on lines between B and C, C and M, etc.

M contains changes B and C which are lacking from L.  On top of
that, a commit D is made and S wants to ask L to incorporate
changes in S but not in L (B, C and D), but finding B, C and D
is cumbersome [*2*].  You solved this by 'git cherry' to go
beyond M, which is a valid workaround, but then the problem
becomes how to find where to stop.

I am assuming the reason this is a cherry-pick problem is
because S does not necessarily send everything out, and whenever
S does 'format-patch L' to generate a list of patches, only a
subset of them is actually sent out.  If that is the case, how
about maintaining another branch T on the S side, which is
private to S?

T starts out as the same commit as the head of L.  Whenever S
has merge-worthy commits, run 'git-cherry-pick' to copy them
over to T, and 'format-patch L' is run in T, not in S, to
generate patches to be sent out.

T being a private tree allows you to rebase every once in a
while to L [*3*], so that already applied patches are dropped
from it.


[Footnote]

*1* I am assuming that merge M would not be made any more
difficult by having A and A' on both sides.  Is it a problem in
practice?

*2* Finding B for resend may be debatable -- it is more of an
inter developer communication issue.

*3* For the above workflow to work, I think the current 'git
rebase' needs to be improved much in two aspects.  (1) The
current 'cherry' uses 'git-patch-id' which shares the same
strictness with 'git-apply' and would not tolerate much fuzz
between what you send out and what got actually applied. (2)
'rebase' keeps going when a merge is not cleanly done, noting
them to sort them out by hand at the end.  This loses the order
of commits in the tree being rebased and very unwieldy.  I have
a plan to fix this in the TODO list for some time.
