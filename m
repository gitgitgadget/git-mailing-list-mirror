From: David Kastrup <dak@gnu.org>
Subject: Re: way to automatically add untracked files?
Date: Sun, 05 Aug 2007 09:32:28 +0200
Message-ID: <85fy2ycu7n.fsf@lola.goethe.zz>
References: <873ayymzc1.fsf@catnip.gol.com>
	<fc339e4a0708042100jdf0a0f1jd1fddfb5dc1c1052@mail.gmail.com>
	<alpine.LFD.0.999.0708042157150.5037@woody.linux-foundation.org>
	<7vr6mih8a8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Miles Bader <miles@gnu.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Aug 05 09:32:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHabP-0000Ah-KC
	for gcvg-git@gmane.org; Sun, 05 Aug 2007 09:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510AbXHEHch (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 5 Aug 2007 03:32:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754334AbXHEHch
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Aug 2007 03:32:37 -0400
Received: from mail-in-13.arcor-online.net ([151.189.21.53]:57345 "EHLO
	mail-in-13.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753904AbXHEHcg (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 5 Aug 2007 03:32:36 -0400
Received: from mail-in-11-z2.arcor-online.net (mail-in-11-z2.arcor-online.net [151.189.8.28])
	by mail-in-13.arcor-online.net (Postfix) with ESMTP id 04B2C1FD03C;
	Sun,  5 Aug 2007 09:32:35 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-11-z2.arcor-online.net (Postfix) with ESMTP id DEF3B345C62;
	Sun,  5 Aug 2007 09:32:34 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-057-031.pools.arcor-ip.net [84.61.57.31])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id ABFF02BB280;
	Sun,  5 Aug 2007 09:32:34 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id BA56F1C4F932; Sun,  5 Aug 2007 09:32:28 +0200 (CEST)
In-Reply-To: <7vr6mih8a8.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Sat\, 04 Aug 2007 22\:14\:55 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3857/Sun Aug  5 08:20:59 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54961>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> ... (except, as we found out last week, we've had a huge 
>> performance regression, so that's actually a really slow way to do it, and 
>> so it's actually faster to do
>>
>> 	git ls-files -o | git update-index --add --stdin
>> 	git commit -a
>>
>> instead...
>
> Is it still the case after the fix in rc4?  Other than the
> theoretical "on multi-core, ls-files and update-index can run in
> parallel" performance boost potential,

When I did my apprenticeship, one thing I learnt was that to
accomplish a repetitive task comprised of several steps, you organize
it in a way that does not require you to change the tool you are
holding/using until you have finished using it.

What's good for the user is good for the computer: even on single core
systems, working off a complete pipeline buffer before switching
context again will help keeping disk positioning and cache poisoning
down.  However, it will depend on the scheduler: if it never allows
pipes to even slighly fill up (which has been the normal behavior of
the Linux scheduler for years in spite of complaints I voiced several
times), you don't get the advantages from this sort of processing.
CFS could conceivably help in many use cases since then the context
switch depends on more than just "pipe has some minimal content?"
which is pretty much the worst choice for context switches in batch
processing.  However, as long as we are talking buffered I/O (FILE*
and block buffering), we are losing some parallelism potential and
gaining some blocking advantage.

> I thought the fixed "git-add ." would be the same...

Possibly.  After all, there _is_ overhead associated with pipes, and
currently released kernels' scheduling behavior reaps no cache
poisoning gains.  Whatever.  I think I'll do a large test.
Speculation is not everything.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
