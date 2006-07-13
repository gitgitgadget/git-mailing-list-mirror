From: Matthias Lederhofer <matled@gmx.net>
Subject: Re: git-daemon problem
Date: Thu, 13 Jul 2006 09:42:52 +0200
Message-ID: <E1G0vqW-00077L-1t@moooo.ath.cx>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx> <7vlkqz1lja.fsf@assigned-by-dhcp.cox.net> <E1G0kNV-0006LK-QW@moooo.ath.cx> <7vveq2ukho.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 13 09:43:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0vqq-0007fa-E0
	for gcvg-git@gmane.org; Thu, 13 Jul 2006 09:43:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWGMHm4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 13 Jul 2006 03:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWGMHm4
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Jul 2006 03:42:56 -0400
Received: from moooo.ath.cx ([85.116.203.178]:42671 "EHLO moooo.ath.cx")
	by vger.kernel.org with ESMTP id S1751501AbWGMHmz (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 13 Jul 2006 03:42:55 -0400
To: Junio C Hamano <junkio@cox.net>
Mail-Followup-To: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vveq2ukho.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23820>

Junio C Hamano <junkio@cox.net> wrote:
> Matthias Lederhofer <matled@gmx.net> writes:
> > Junio C Hamano <junkio@cox.net> wrote:
> >> Maybe we should check if fd 2 is sane at daemon startup, and
> >> otherwise open /dev/null for writing and dup2 it to fd 2?
> > daemon startup is probably not the right place because as long as the
> > terminal is open this will be fine.
> 
> Hmph.  In the part of my message you did not quote:
> 
> 	$ git-daemon 0<&- 1>&- 2>&- --export-all /pub/git
> 
> leaves listening sockets at fd 0/1 without any fd 2, and
> 
> 	$ git-daemon 2>&- --export-all /pub/git
> 
> allocates listening socket at FD 2 (because FD 0 and FD 1 are
> occupied).
> 
> Now, after we do accept(), we spawn a subprocess in handle(),
> and in the child process dup2() the fd connected to the peer to
> fd 0 and 1 of the child process -- and we do not do anything to
> fd 2 of the child process.  So in the latter case, my tentative
> patch would write error message to the listening socket -- ugh.
> 
> And as you say, fd 2 might be connected to the terminal and
> healthy when you start the daemon, but later you can close the
> terminal, so there is no sane place for us to try anything
> sensible.
> 
> The only "right" solution I could think of is to properly
> daemonize git-daemon when not running under --inetd mode.  Close
> and open /dev/null the low three fds, and dissociate the process
> from the controlling terminal (did I forget anything else --
> perhaps chdir("/") at the top?).  And we keep the current
> behaviour of assuming the sane set of low three fds when a new
> option --debug is given to help people look at its stderr.  The
> tentative patch to upload-pack would become moot at that point.
> 
> Hmm?

Now I see what you mean.  Checking the fds at daemon startup should
work too (using xwrite/write instead of safe_write).

Is daemon(3) portable?  Otherwise it should be:
fork(); setsid(); chdir("/"); open("/dev/null", O_RDWR, 0); dup2(..);
(looking at the daemon(3) implementations of glibc and freebsd libc)
The freebsd implementation of daemon(3) ignores SIGHUP for fork() and
setsid() with the comment "A SIGHUP may be thrown when the parent
exits below."

With the option to run in background (or the other way around -- not
to run in background) should also come an option to write a pid file.
