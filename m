From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon problem
Date: Wed, 12 Jul 2006 22:44:35 -0700
Message-ID: <7vveq2ukho.fsf@assigned-by-dhcp.cox.net>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx>
	<7vlkqz1lja.fsf@assigned-by-dhcp.cox.net>
	<E1G0kNV-0006LK-QW@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 07:44:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0u0I-00025I-E9
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 07:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWGMFoj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 01:44:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbWGMFoi
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 01:44:38 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:58065 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751053AbWGMFoi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Jul 2006 01:44:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060713054437.OFUX12909.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 13 Jul 2006 01:44:37 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G0kNV-0006LK-QW@moooo.ath.cx> (Matthias Lederhofer's message
	of "Wed, 12 Jul 2006 21:28:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23816>

Matthias Lederhofer <matled@gmx.net> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> This breaks the newer clients that knows how to do side-band
>> doesn't it?
> Probably, this patch is just to give a starting point where the
> problem could be.
>
>> Would this replacement patch help?
> [use write instead of safe_write]
>
> This seems to fix it.  Perhaps it should be xwrite instead of write.
>
>> Maybe we should check if fd 2 is sane at daemon startup, and
>> otherwise open /dev/null for writing and dup2 it to fd 2?
> daemon startup is probably not the right place because as long as the
> terminal is open this will be fine.

Hmph.  In the part of my message you did not quote:

	$ git-daemon 0<&- 1>&- 2>&- --export-all /pub/git

leaves listening sockets at fd 0/1 without any fd 2, and

	$ git-daemon 2>&- --export-all /pub/git

allocates listening socket at FD 2 (because FD 0 and FD 1 are
occupied).

Now, after we do accept(), we spawn a subprocess in handle(),
and in the child process dup2() the fd connected to the peer to
fd 0 and 1 of the child process -- and we do not do anything to
fd 2 of the child process.  So in the latter case, my tentative
patch would write error message to the listening socket -- ugh.

And as you say, fd 2 might be connected to the terminal and
healthy when you start the daemon, but later you can close the
terminal, so there is no sane place for us to try anything
sensible.

The only "right" solution I could think of is to properly
daemonize git-daemon when not running under --inetd mode.  Close
and open /dev/null the low three fds, and dissociate the process
from the controlling terminal (did I forget anything else --
perhaps chdir("/") at the top?).  And we keep the current
behaviour of assuming the sane set of low three fds when a new
option --debug is given to help people look at its stderr.  The
tentative patch to upload-pack would become moot at that point.

Hmm?
