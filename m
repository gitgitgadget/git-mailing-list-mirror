From: Junio C Hamano <junkio@cox.net>
Subject: Re: Automatic merge failed, fix up by hand
Date: Tue, 23 Aug 2005 17:29:49 -0700
Message-ID: <7vek8kmb2a.fsf@assigned-by-dhcp.cox.net>
References: <1124831571.13042.27.camel@firebird.lenb.worldpath.net>
	<7vhddgnw9q.fsf@assigned-by-dhcp.cox.net>
	<1124836282.14730.4.camel@toshiba>
	<7vzmr8mci2.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 24 02:31:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7j9O-0000er-Mo
	for gcvg-git@gmane.org; Wed, 24 Aug 2005 02:29:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932510AbVHXA3w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Aug 2005 20:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVHXA3w
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Aug 2005 20:29:52 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43922 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932510AbVHXA3v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2005 20:29:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050824002951.QSHL1860.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 Aug 2005 20:29:51 -0400
To: Len Brown <len.brown@intel.com>
In-Reply-To: <7vzmr8mci2.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 23 Aug 2005 16:58:45 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7692>

Junio C Hamano <junkio@cox.net> writes:

> I think merge-base, even though we attempted to fix it recently,
> is still confused and that is one of the reasons why you are
> getting this.
>
>     prompt$  git-rev-parse origin test-lenb-merge
>     81065e2f415af6c028eac13f481fb9e60a0b487b
>     702c7e7626deeabb057b6f529167b65ec2eefbdb
 -->8-- snip -->8--
>     +  Merge ../to-linus-stable/
>     ++ [ACPI] re-enable platform-specific hotkey drivers by default
>     +  ARM: 2851/1: Fix NWFPE extended precision exception handling
>     ++ [origin~34] intelfb/fbdev: Save info->flags in a local variable
>     prompt$  git-rev-parse origin~34
>     3edea4833a1efcd43e1dff082bc8001fdfe74b34

I spoke too fast.  merge-base is not giving you an incorrect
answer.  It just happens that the answer was way suboptimal.

The "[ACPI] re-enable platform-specific hotkey" is what it
chose, and my monkey guessing origin~34 happened to be better
merge base, but the logic used by merge-base is to pick the
latest (from wallclock wise) commit among several candidates,
and by that criteria it did the "right" thing.

In this case, the "right" thing was a wrong decision.  So we
probably should revisit how we choose the "best" merge base
among candidates.  I think "origin~34" which happened to be the
last one output by "git show-branch" was just an accident, not a
good rule to follow, so changing merge-base to use the one that
the other command shows the last would not be a good way to fix
this.

Probably the ideal way would be to give merge-base an option to
spit out all the candidates, and have the script try to see
which ones yield the least number of non-trivial merges.

Linus?
