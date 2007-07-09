From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Preferring shallower deltas on repack
Date: Mon, 09 Jul 2007 00:27:24 -0700
Message-ID: <7vbqemvxyb.fsf@assigned-by-dhcp.cox.net>
References: <20070709044326.GH4087@lavos.net>
	<7v1wfixhvk.fsf@assigned-by-dhcp.cox.net>
	<20070709065235.GJ4087@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: bdowning@lavos.net (Brian Downing)
X-From: git-owner@vger.kernel.org Mon Jul 09 09:27:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7nep-0007UK-PI
	for gcvg-git@gmane.org; Mon, 09 Jul 2007 09:27:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbXGIH11 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jul 2007 03:27:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751492AbXGIH11
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jul 2007 03:27:27 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59590 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751387AbXGIH10 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jul 2007 03:27:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070709072724.FZHT1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 9 Jul 2007 03:27:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id MKTQ1X0031kojtg0000000; Mon, 09 Jul 2007 03:27:24 -0400
In-Reply-To: <20070709065235.GJ4087@lavos.net> (Brian Downing's message of
	"Mon, 9 Jul 2007 01:52:35 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51966>

bdowning@lavos.net (Brian Downing) writes:

> (These timings are for the Git pack on Linux/amd64, --window and --depth
> both 100.  Since /usr/bin/time doesn't seem to report any useful memory
> statistics on Linux, I also have a "ps aux" line from when the memory
> size looked stable.  This was different from run to run but it shows the
> two are in the same order of magnitude.)
>
> Unpatched:
> 54.99user 0.18system 0:56.80elapsed 97%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (14major+32417minor)pagefaults 0swaps
> bdowning  5290 98.7  4.5 106788 92900 pts/1    R+   01:26   0:49 git pack-obj
>
> Patched:
> 55.37user 0.19system 0:56.35elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (0major+32249minor)pagefaults 0swaps
> bdowning  6086  100  4.5 106880 92996 pts/1    R+   01:29   0:49 git pack-obj

The number of minor faults are comparable (slightly favorable),
which is a good sign.

> The patched version is actually smaller in both SBCL's and Git's case
> (again, --window 100 and --depth 100):
>
> SBCL: 61696 bytes smaller (13294225-13232529)
> Git:  16010 bytes smaller (12690424-12674414)
>
> I believe the reason for this is that more deltas can get in under the
> depth limit.

Very sensible indeed.

>> It would become worrysome (*BUT* infinitely more interesting)
>> once you start talking about a tradeoff between slightly larger
>> delta and much shorter delta.  Such a tradeoff, if done right,
>> would make a lot of sense, but I do not offhand think of a way
>> to strike a proper balance between them efficiently.
>
> Yeah, I was thinking about that too, and came to the same conclusion.
> I suspect you'd have to save a /lot/ of delta depth to want to pay any
> more I/O, though.

That may not be so.  Deeper delta also means more I/O (and
worse, because they can be from discontiguous areas) plus delta
application.
