From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] Check for IO errors after running a command
Date: Mon, 25 Jun 2007 02:44:14 -0700
Message-ID: <7vy7i8xtap.fsf@assigned-by-dhcp.pobox.com>
References: <87abuq1z6f.fsf@rho.meyering.net>
	<7vzm2pwws8.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0706240951440.3593@woody.linux-foundation.org>
	<alpine.LFD.0.98.0706241010480.3593@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jun 25 11:44:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I2l7K-0008Ta-A3
	for gcvg-git@gmane.org; Mon, 25 Jun 2007 11:44:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751729AbXFYJoQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Jun 2007 05:44:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751782AbXFYJoQ
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jun 2007 05:44:16 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:65509 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751710AbXFYJoP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jun 2007 05:44:15 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070625094416.UODB3339.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 25 Jun 2007 05:44:16 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id FlkE1X0021kojtg0000000; Mon, 25 Jun 2007 05:44:15 -0400
cc: Matthias Lederhofer <matled@gmx.net>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50886>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Side note: I think I made a mistake in making the run_command() a NORETURN 
> function and putting the exit() into it. It's probably better to instead 
> just make it return "int", and make the caller do
>
> 	exit(run_command(...));
>
> and that makes it much prettier to have "run_command()" just return early 
> if an error happens (or doesn't happen).
>
> For example, then we could just do
>
> 	status = p->fn(...);
> 	if (status)
> 		return status;
> 	/* Somebody closed stdout? */
> 	if (fstat(fileno(stdout), &st))
> 		return 0;
> 	/* Ignore write errors for pipes and sockets.. */
> 	if (S_ISFIFO(st.st_mode) || S_ISSOCK(st.st_mode))
> 		return 0;
>
> which makes it easy to explain what's going on, and avoids having any deep 
> indentation at all.

I took the liberty of munging your two patches to follow your
comments above (it was a perfect guinea-pig opportunity for
Johannes's "rebase -i").

The changes to git.c (run_command) conflicted with GIT_WORK_TREE
changes in a minor way.  Matthias, could you sanity check the
result once I push it out to 'next', please?
