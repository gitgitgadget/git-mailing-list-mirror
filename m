From: Junio C Hamano <junkio@cox.net>
Subject: Re: Moved files and merges
Date: Sun, 04 Sep 2005 01:27:08 -0700
Message-ID: <7vfysli6g3.fsf@assigned-by-dhcp.cox.net>
References: <4318E754.9000703@zytor.com>
	<7vek87djat.fsf@assigned-by-dhcp.cox.net>
	<7vek867e29.fsf@assigned-by-dhcp.cox.net>
	<7vy86erntu.fsf@assigned-by-dhcp.cox.net>
	<20050903190500.GB8379@mars.ravnborg.org>
	<7voe7arlqk.fsf@assigned-by-dhcp.cox.net>
	<20050903220355.GA1895@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>,
	Fredrik Kuivinen <freku045@student.liu.se>,
	"H. Peter Anvin" <hpa@zytor.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 04 10:27:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EBpqM-0006Di-DF
	for gcvg-git@gmane.org; Sun, 04 Sep 2005 10:27:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVIDI1L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Sep 2005 04:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751302AbVIDI1L
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Sep 2005 04:27:11 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19840 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751149AbVIDI1K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Sep 2005 04:27:10 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050904082710.KAIJ20473.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Sep 2005 04:27:10 -0400
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: Junio C. Hamano's message of "(unknown date)"
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8051>

Junio C Hamano <junkio@cox.net> writes:

> All true.  Let's redraw that simplified scenario, and see if
> what I said still holds.  It may be interesting to store my
> previous message and this one in a file and run diff between
> them.

There are a couple of things worth mentioning about the two
examples (one that I resolved favoring non-rename and
non-addition, and the other I resolved favoring rename and
addition) I gave tonight.

1. When I said "the principles are the same", I was primarily
   referring to the part that detects the 'previous' merge,
   which of its parents is 'ours' and which is 'theirs'.
   Although I handwaved that part in both examples, my gut
   feeling is that this part is probably harder than the part
   that adjusts trees before merging.  klibc vs klibc-kbuild
   case had a clear distinction between which commit is ours and
   which is theirs, but I am not sure if things are that black
   and white in real projects when a lot of criss-crossing
   merges are involved.

2. When adjusting trees, I treated removals and additions a bit
   differently, but there is no fundamental reason to do so.

   In the first example which had a removal, I adjusted the tree
   #2 and #6 by removing the path involved.  In the second
   example which had an addition, I did not adjust the tree #2
   and #6 to add that path.  But you _could_ do nothing to
   adjust for removal; i.e. leaving K in tree #2-adjusted and
   #6-adjusted in the first example. Also you _could_ adjust for
   the addition by copying K from #3 into #2-adjusted and
   copying K from #5 into #6-adjusted in the second example.

   If you did the former, merging the resulting #6-adjusted into
   #5 pivoting at #2-adjusted would leave a non-trivial conflict
   for you to resolve by hand.  #6-adjusted changes K from
   #2-adjusted while #5 would remove it from #2-adjusted.  This
   would be a remove-modify conflict (case 7 in the 3-way merge
   case table in t/t1000-read-tree-m-3way.sh).  But this is only
   non-trivial to git and what you want is obvious to you as the
   maintainer of the line of development that removed the file
   at #3.  You removed it the last time, and you remove it this
   time again.  I adjusted #2 and #6 to remove the path only to
   save you from this tedium upfront before the read-tree phase.

   Similarly, in the second example, if #2 and #6 are adjusted
   for the addition of K by copying K from #3 and #5 into them,
   the resulting merge would see that one line #2-adjusted to
   #6-adjusted changes K (whose contents is that of
   #3) to that of #5, while the other line #2-adjusted to #5
   changes K (whose contents is again that of #3) to that of
   #5.  Since this is both-change-identically (case 12 in the
   3-way merge table), it trivially resolves to keep K from #5,
   and the result is the same as what you would get from my
   second example which did nothing about additions.



   
