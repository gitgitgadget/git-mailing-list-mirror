From: Junio C Hamano <junkio@cox.net>
Subject: Re: Partitioned packs
Date: Tue, 03 Apr 2007 18:58:11 -0700
Message-ID: <7vlkh8uci4.fsf@assigned-by-dhcp.cox.net>
References: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Chris Lee" <clee@kde.org>
X-From: git-owner@vger.kernel.org Wed Apr 04 03:58:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYulM-0004QW-Iq
	for gcvg-git@gmane.org; Wed, 04 Apr 2007 03:58:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966274AbXDDB6N (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 21:58:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966275AbXDDB6N
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 21:58:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:57389 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966274AbXDDB6N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 21:58:13 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070404015814.ZCDQ373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Apr 2007 21:58:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id ipyB1W00S1kojtg0000000; Tue, 03 Apr 2007 21:58:12 -0400
In-Reply-To: <db69205d0704031836u3b3dfc2pb9825dd649aca58@mail.gmail.com>
	(Chris Lee's message of "Tue, 3 Apr 2007 18:36:44 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43704>

"Chris Lee" <clee@kde.org> writes:

> I've been running some experiments, as hinted earlier by the
> discussion about just how much git-index-pack sucks (which, really,
> isn't much since the gaping memleak is gone now).
>
> These experiments include trying to see if there's a noticeable
> performance improvement by splitting out objects of different types
> into different packs. So far, it definitely seems to make a
> difference, though not the one I was initially expecting. For all of
> these tests, I did 'sysctl -w vm.drop_caches=3' before running, to
> effectively simulate a cold-cache run.

Are you running on a 64-bit machine or 32-bit?

I wonder what the numbers would be if you partition into the
same number of packs of similar sizes as your experiment, but
partitioning based on not by type but by age or other factors.

What I am getting at is that you may not be seeing the effect of
access pattern based on the type at all.  For example, the
performance can be affected by other factors, such as necessity
to use smaller number of pack_windows per pack.  use_pack()
iterates through the currently active windows on a linked list
per pack, and a window is 32MB on 32-bit machines, so you would
literally need hundreds of them to access that 3GB pack (the
total is limited to 256MB so 8 windows are recycled).  It is
possible that simply using more packs and knowing which pack you
need to access upfront may be cutting down the cost of finding
the pack window to use.  A single pack would have a linked list
of 8 active windows, while two packs would have one linked list
of each, so the average linear search cost would be half.
