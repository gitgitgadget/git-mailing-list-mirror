From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] [PATCH 0/5] Implement 'prior' commit object links (and
Date: Sun, 30 Apr 2006 16:19:44 -0700
Message-ID: <7vfyjuwt0v.fsf@assigned-by-dhcp.cox.net>
References: <20060429165151.2570.qmail@science.horizon.com>
	<e30b48$ovk$1@sea.gmane.org> <7viros1585.fsf@assigned-by-dhcp.cox.net>
	<e30k0n$ij5$1@sea.gmane.org> <e32kkf$amc$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 01 01:19:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FaLCg-0002II-OC
	for gcvg-git@gmane.org; Mon, 01 May 2006 01:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWD3XTr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 30 Apr 2006 19:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751235AbWD3XTr
	(ORCPT <rfc822;git-outgoing>); Sun, 30 Apr 2006 19:19:47 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10426 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750759AbWD3XTq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Apr 2006 19:19:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060430231945.XWB21197.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 30 Apr 2006 19:19:45 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e32kkf$amc$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	30 Apr 2006 17:21:37 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19363>

Jakub Narebski <jnareb@gmail.com> writes:

>>> This is not any different from usual "parent" at all (but you
>>> have to think about it a bit to realize it).
>> 
>> I would say that "prior" is not THAT different from usual "parent",
>> rather than it is not ANY different.
>> 
>> My doubts about recording previous head of a "union" (pu-like) branch
>> is that for merge (e.g. 'pu' to 'next', cherrypick to/from 'pu', 'pu'
>> rebase) is that for merge algorithm all parents are equivalent, with
>> eventual exception of first which can be treated special ('ours').
>
> Additionally with "prior" (or at least some convention on which of parents
> is to prior head of "union (pu-like) branch) I think we could fast-forward
> such branches...

This is why I said you have to think about it a bit to realize
that the "prior" is not _ANY_ different from the ordinary parent
for something like "pu".

We can fast-forward if (1) you pulled from "pu" the last time,
and (2) you haven't added anything on top of it on your own, and
(3) you pull from "pu" again, if the previous "pu" (i.e. your
"pu") is a parent of the updated "pu".  We do not need "prior"
for that.  The old "pu" being _one_ _of_ the parents, not even
necessarily be the first one, would do just fine.

If you have built on top of the last "pu", obviously we do not
want to fast-forward with or without "prior".

Your doubts about the merge is also unfounded.  The current "pu"
head is (against my own recommendation not to do so) a hydra
cap.  It is a direct child of the previous "pu" that merges all
the leftover bits along with what was in 'next' when the commit
was made, so you could do something like this to experiment:

	git branch test-1 pu^1
	echo >>Makefile '# End of Makefile'
        git commit -m 'build on top of previous "pu"' Makefile
        git pull . pu ;# Merge whatever happened in "pu"
        
