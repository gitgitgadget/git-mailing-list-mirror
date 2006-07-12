From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-daemon problem
Date: Tue, 11 Jul 2006 21:42:33 -0700
Message-ID: <7vlkqz1lja.fsf@assigned-by-dhcp.cox.net>
References: <E1G0QeX-0003hG-0I@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 12 06:42:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0WYY-0008Jj-Ko
	for gcvg-git@gmane.org; Wed, 12 Jul 2006 06:42:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932417AbWGLEmg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Jul 2006 00:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932418AbWGLEmf
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Jul 2006 00:42:35 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:31471 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932417AbWGLEmf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jul 2006 00:42:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060712044234.EBLF22974.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 12 Jul 2006 00:42:34 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1G0QeX-0003hG-0I@moooo.ath.cx> (Matthias Lederhofer's message
	of "Wed, 12 Jul 2006 00:24:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23762>

Matthias Lederhofer <matled@gmx.net> writes:

> A few weeks ago upgrading from 1.3.x to 1.4.1 I had a problem with
> git-daemon.  I started git-daemon on a terminal but did not redirect
> stdin/stdout/stderr to /dev/null (actually using daemon(8) on freebsd
> without -f but just disowning the process and closing the terminal
> works fine too, nothing freebsd/daemon(8) specific).  After closing
> the terminal I was not able to use the git-daemon anymore with some
> versions of the git. So now I took some time and tried to find what
> was the reason for that.

HMMMMMMMMM.

I did this silly experiment.  Close, instead of connecting them
to /dev/null, the low 3 file descriptors:

$ git-daemon 0<&- 1>&- 2>&- --export-all /pub/git &
$ lsof -p $! | sed -n -e '/ FD /p' -e '/[0-9]u/p'
COMMAND     PID  USER   FD   TYPE  DEVICE    SIZE    NODE NAME
git-daemo 13921 junio    0u  IPv6 1973673             TCP *:9419 (LISTEN)
git-daemo 13921 junio    1u  IPv4 1973674             TCP *:9419 (LISTEN)

It gets worse.  This is what happens when you close only fd #2.

$ git-daemon 2>&- --export-all /pub/git &
$ lsof -p $! | sed -n -e '/ FD /p' -e '/[0-9]u/p'
COMMAND     PID  USER   FD   TYPE  DEVICE    SIZE    NODE NAME
git-daemo 13961 junio    0u   CHR   136,7               9 /dev/pts/7
git-daemo 13961 junio    1u   CHR   136,7               9 /dev/pts/7
git-daemo 13961 junio    2u  IPv6 1975187             TCP *:9419 (LISTEN)
git-daemo 13961 junio    3u  IPv4 1975188             TCP *:9419 (LISTEN)

Now, after we do accept(), we spawn a subprocess in handle(),
and in the child process dup2() the fd connected to the peer to
fd 0 and 1 of the child process -- and we do not do anything to
fd 2 of the child process.

If you do not close any of the low 3 file descriptors, fd 2 of
the child process is connected to whatever error stream of
daemon is, so you would not see this problem, but this certainly
is bad.

Maybe we should check if fd 2 is sane at daemon startup, and
otherwise open /dev/null for writing and dup2 it to fd 2?

Currently, under --inetd mode we have freopen of stderr, but
that does not help this issue.  It would make die() and error()
in daemon itself behave sanely but when you start the daemon
with the low file descriptors closed, fileno(stderr) may be
different from 2.
