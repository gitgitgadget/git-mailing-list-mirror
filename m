From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] plumber's puzzle
Date: Sun, 22 Apr 2007 16:52:51 -0700
Message-ID: <7vejmcklv0.fsf@assigned-by-dhcp.cox.net>
References: <7v647ombi6.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221341080.9964@woody.linux-foundation.org>
	<7vps5wkph5.fsf@assigned-by-dhcp.cox.net>
	<alpine.LFD.0.98.0704221546160.9964@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Apr 23 01:53:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hflrb-0000hw-Lg
	for gcvg-git@gmane.org; Mon, 23 Apr 2007 01:53:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965655AbXDVXwy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 19:52:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965656AbXDVXwx
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 19:52:53 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:37984 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965655AbXDVXwx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 19:52:53 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070422235252.RUYK1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Apr 2007 19:52:52 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id qPss1W0041kojtg0000000; Sun, 22 Apr 2007 19:52:52 -0400
In-Reply-To: <alpine.LFD.0.98.0704221546160.9964@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sun, 22 Apr 2007 16:03:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45289>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sun, 22 Apr 2007, Junio C Hamano wrote:
>> 
>> I should be happy that I figured out what is going on, but I am
>> not very happy with this patch.
>
> That actually looks like the right patch.
>
> The "fflush() before fork()" thing is a real issue, and a real bug. Stdio 
> is buffered, and yes, fork() will duplicate the buffer if not flushed.
>
> Of course, I'm not 100% sure that is the right _place_ for the fflush() 
> call. I wonder if we should just do the fflush() closer to the place that 
> generates the data. As it is, we may have other things like that lurking.
>
> Of course, delaying the fflush as long as possible is likely good for 
> performance, so doing it just before the fork() (even if it may be ugly 
> and somewhat unexpected at that point to have to do it) may just be the 
> right thing regardless...

Another possibility I considered is to call low-level _exit so
that we bypass not just stdio flushing but also atexit().  But I
think "fflush() before fork()" is cleaner.
