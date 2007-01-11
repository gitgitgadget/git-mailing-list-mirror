From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 12:23:45 -0800
Message-ID: <7vfyah48j2.fsf@assigned-by-dhcp.cox.net>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com>
	<Pine.LNX.4.63.0701041327490.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com>
	<7v8xgileza.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
	<20070107163112.GA9336@steel.home>
	<7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com>
	<Pine.LNX.4.64.0701101521410.3594@woody.osdl.org>
	<81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com>
	<Pine.LNX.4.64.0701110823300.3594@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 21:24:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H56T2-0006YU-V3
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 21:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbXAKUYF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 15:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbXAKUYF
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 15:24:05 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52589 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751485AbXAKUYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 15:24:03 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070111202401.LBBL9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 11 Jan 2007 15:24:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 9wP91W00a1kojtg0000000; Thu, 11 Jan 2007 15:23:10 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org> (Linus
	Torvalds's message of "Thu, 11 Jan 2007 08:38:51 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36607>

Linus Torvalds <torvalds@osdl.org> writes:

> That said, I think we actually have another problem entirely:
>
> Look at "write_cache()", Junio: isn't it leaking memory like mad?
>
> Shouldn't we have something like this?
>
> It's entirely possible that the _real_ problem with the "flush the index 
> all the time" was that it just caused this bug: tons and tons of lost 
> memory, causing git-merge-recursive to grow explosively (~6MB per 
> cache flush, and a _lot_ of cache flushes), which on a 384MB machine 
> quickly uses up memory and causes totally unnecessary swapping.

You are right -- there is absolutely no reason to retain this
memory.  It is a serialized representation of cache-tree data
only to be stored in the index, and no other user of this data
exists.  Thanks for spotting this.

Writing out 6MB per every path changed in a merge would still be
an unnecessary overhead over the one in 'next', so there is no
reason to replace 'next' with this single liner of yours, but I
am interested in seeing how much of the 20-minute vs 1-minute
difference is attributable to this leak, just out of curiosity.

Alex, if you have a chance, could you apply Linus's single-liner
on top of 'master', without either of the merge-recursive
patches in 'next', and see what kind of numbers you would get?
