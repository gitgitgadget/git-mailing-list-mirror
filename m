From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH 2/2] Check for IO errors after running a command
Date: Mon, 25 Jun 2007 16:01:48 +0200
Message-ID: <877ipsw2sz.fsf@rho.meyering.net>
References: <87abuq1z6f.fsf@rho.meyering.net>
	<7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org>
	<7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 25 16:01:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2p8a-0001p3-14
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 16:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753640AbXFYOBv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 10:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753509AbXFYOBu
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 10:01:50 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:52489 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752782AbXFYOBu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 10:01:50 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 6D3A95A34F
	for <git@vger.kernel.org>; Mon, 25 Jun 2007 16:01:49 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id B32842F587; Mon, 25 Jun 2007 16:01:48 +0200 (CEST)
In-Reply-To: <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com> (Junio C. Hamano's message of "Mon\, 25 Jun 2007 02\:44\:14 -0700")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50895>

Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
...
>> For example, then we could just do
>>
>> 	status = p->fn(...);
>> 	if (status)
>> 		return status;
>> 	/* Somebody closed stdout? */
>> 	if (fstat(fileno(stdout), &st))
>> 		return 0;
>> 	/* Ignore write errors for pipes and sockets.. */
>> 	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
>> 		return 0;
>>
>> which makes it easy to explain what's going on, and avoids having any deep
>> indentation at all.
>
> I took the liberty of munging your two patches to follow your
> comments above

That has the disadvantage of ignoring *all* pipe and socket write errors.
IMHO, git would be better served if it didn't do that, since writing to
those can fail with EIO and even a new one: EACCES (though this latter
is only for sockets).  Also possible, according to POSIX: ENOBUFS.

Of course, one can probably argue that those are all unlikely.
They may be even less likely than an actual EPIPE, but the point is
that people and tools using git plumbing should be able to rely on
it to report such write failures, no matter how unusual they are.
