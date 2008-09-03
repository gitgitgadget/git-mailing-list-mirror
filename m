From: Petr Baudis <pasky@suse.cz>
Subject: Calling ssh from git-gui
Date: Wed, 3 Sep 2008 18:54:55 +0200
Message-ID: <20080903165455.GU10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org, msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Sep 03 18:56:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KaveL-0007QJ-2C
	for gcvg-git-2@gmane.org; Wed, 03 Sep 2008 18:56:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753557AbYICQzD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Sep 2008 12:55:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753547AbYICQzB
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Sep 2008 12:55:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44576 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753494AbYICQzA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Sep 2008 12:55:00 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 0040C3939B4B; Wed,  3 Sep 2008 18:54:55 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94814>

  Hi,

  I'm quite at loss by now searching for a reasonable solution for
invoking ssh (either directly or through git fetch/git push) from
git-gui, which is very problematic right now - doubly so when
considering both UNIX and Win32.

  There are several scenarios to consider:

  (i) SSH to known host with key managed by a running agent.
  (ii) SSH to host without agent running or without keys set up.
  (iii) SSH to unknown host (unregistered fingerprint).

  Currently, (i) is the only scenario git-gui can handle, which means
that users usually have to use Other Means (tm) to "seed" their ssh tool
(OpenSSH or PuTTY) - it forces them to install keys and manually connect
to the machine once. Furthermore, this is pretty much undocumented (and
even if it was, GUI users assume they don't have to read documentation)
and there is no way to give the user feedback why on the earth is the
thing hanging.

  Handling (ii) and (iii) unfortunately turned out to be very tricky.

  On Linux, things are at least manageable - running ssh in a separate
session and setting $SSH_ASKPASS to point at a GUI helper should do.
(Even though the separate session part might get rather tricky to
implement in TCL.) On Windows, there is PuTTY and OpenSSH to consider:

  With PuTTY, I know about no good solutions for both (ii) and (iii)
short of including PuTTY code with custom frontend in msysGit itself -
this might be interesting approach, though. PuTTY is licenced under
something that looks like an MIT licence and can run on UNIX too.

  With OpenSSH, I was not able to get $SSH_ASKPASS to work, even after
going through the ordeal of setting up msysdvlpr and compiling my own
setsid.exe - setsid.exe cat /dev/tty shows it does not exist, yet
OpenSSH still declines to call $SSH_ASKPASS. By now, I'm at loss and
running out of time to investigate this further.


  To sum it up, there are two possible solutions to driving ssh through
git-gui:

  * Call setsid'd ssh with $SSH_ASKPASS; this might get very tricky to
implement in TCL. Either git-gui.sh could execute wish setsid'd already
(which is probably not portable and changes current semantics as git-gui
detaches from the current terminal, but that could be ok), or Git itself
could get support of setsid()ing before calling ssh (probably better
option). To get this working on Win32 would require further work and
possibly ssh or msys code hacking. (Heck, we could customize the ssh we
ship with msysGit to remove the braindead no-controlling-terminal
requirement.)

  * Use PuTTY code with custom frontend for the ssh transport. This is
probably not realistic since I can't think of any benefits this would
get non-Win32 users now - though for Win32 users the benefits might be
significant; making embedding-friendly PuTTY frontend (not even
necessarily git-specific) could be nic next year's GSoC project
candidate?


  Comments, thoughts?

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
