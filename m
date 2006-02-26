From: Christopher Faylor <me@cgf.cx>
Subject: Re: [PATCH] fmt-merge-msg: avoid open "-|" list form for Perl 5.6
Date: Sun, 26 Feb 2006 15:40:27 -0500
Message-ID: <20060226204027.GC30735@trixie.casa.cgf.cx>
References: <81b0412b0602230000t58a88af6na1aa7e323dc0179d@mail.gmail.com> <7vwtfmihts.fsf@assigned-by-dhcp.cox.net> <81b0412b0602230135w472aa6f3v72980f6f63bb355f@mail.gmail.com> <81b0412b0602230141g46dbfaev6baa5083dee2d42@mail.gmail.com> <43FD84EB.3040704@op5.se> <81b0412b0602230210r3ffe6e2dta5dc86d6516692b9@mail.gmail.com> <43FDB8CC.5000503@op5.se> <81b0412b0602230607n22146a77k36929f0ad9e44d53@mail.gmail.com> <20060226195552.GA30735@trixie.casa.cgf.cx> <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Feb 26 21:40:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDSgx-0006ef-My
	for gcvg-git@gmane.org; Sun, 26 Feb 2006 21:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWBZUk2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 15:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbWBZUk2
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 15:40:28 -0500
Received: from c-24-61-23-223.hsd1.ma.comcast.net ([24.61.23.223]:16812 "EHLO
	cgf.cx") by vger.kernel.org with ESMTP id S1750748AbWBZUk2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 26 Feb 2006 15:40:28 -0500
Received: by cgf.cx (Postfix, from userid 201)
	id AD5CF13C3E2; Sun, 26 Feb 2006 15:40:27 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0602261217080.22647@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16799>

On Sun, Feb 26, 2006 at 12:18:19PM -0800, Linus Torvalds wrote:
>On Sun, 26 Feb 2006, Christopher Faylor wrote:
>>If the speed of cygwin's fork is an issue then I'd previously suggested
>>using spawn*.  The spawn family of functions were designed to emulate
>>Windows functions of the same name.  They start a new process without
>>the requirement of forking.
>
>I thought that cygwin didn't implement the posix_spawn*() family?

Right.  It just implements the windows version of spawn.  I looked more
closely at the posix_spawn functions after you last suggested it and,
while it would be possible to implement this in cygwin, these functions
are a lot more heavyweight than the windows-like implementation of spawn
that are already in cygwin.  So, they would come with their own
performance penalty.

The cygwin/windows version of spawn is basically like an extended version
of exec*():

pid = spawnlp (P_NOWAIT, "/bin/ls", "ls", "-l", NULL);

will start "/bin/ls" and return a pid which can be used in waitpid.
There is still some overhead to this function but it basically is just a
wrapper around the Windows CreateProcess, which means that it doesn't
go through the annoying overhead of Cygwin's fork.

The posix_spawn stuff is in my todo list but the Windows spawn stuff
could be used now.

cgf
