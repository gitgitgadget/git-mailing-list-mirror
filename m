From: Ben Schmidt <mail_ben_schmidt@yahoo.com.au>
Subject: Getting the path right for git over SSH
Date: Wed, 18 Jun 2008 21:22:12 +1000
Message-ID: <4858EFE4.3050204@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 18 13:33:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8vuq-0002LX-DE
	for gcvg-git-2@gmane.org; Wed, 18 Jun 2008 13:33:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752795AbYFRLcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2008 07:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752786AbYFRLcd
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jun 2008 07:32:33 -0400
Received: from outbound.icp-qv1-irony-out2.iinet.net.au ([203.59.1.107]:53550
	"EHLO outbound.icp-qv1-irony-out2.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752735AbYFRLcc (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jun 2008 07:32:32 -0400
X-Greylist: delayed 615 seconds by postgrey-1.27 at vger.kernel.org; Wed, 18 Jun 2008 07:32:31 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhEBAPeMWEh8qAm+/2dsb2JhbAAIsDQ
X-IronPort-AV: E=Sophos;i="4.27,664,1204470000"; 
   d="scan'208";a="330890268"
Received: from unknown (HELO [192.168.1.11]) ([124.168.9.190])
  by outbound.icp-qv1-irony-out2.iinet.net.au with ESMTP; 18 Jun 2008 19:22:13 +0800
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85376>

Hi,

I wrote the post below on the Apple Mac OS X Server mailing list, though
not subscribed to that list, because I found a solution that I thought
others might appreciate having documented, as I found it quite a bit of
trouble getting it right myself. Though written for Mac OS X, the
essentials apply to any Unix-like system. As the OP's problem arose when
using Git, I thought perhaps some other Git users may appreciate the
ideas as well, so I am forwarding this mail to you. If you think it
would be helpful, post it to a mailing list or FAQ somewhere, or
whatever else you like, and Google will hopefully find it and help other
users with it. The original message and my followup, which isn't
threaded, are here:

http://lists.apple.com/archives/macos-x-server/2008/May/msg00678.html
http://lists.apple.com/archives/macos-x-server/2008/Jun/msg00251.html

Ben.



> Hi all,
>
> I've recently begun administering a Mac OS X Server 10.5.3 Leopard
> server used, in part, for my company's developers. We use a couple of
> tools (i.e., git, a version control system) that typically invoke non-
> interactive, non-login shells to do stuff. However, I discovered that
> when a user logs in via one of these tools, which in turn invokes SSH,
> the bash shell that user uses has a very minimal $PATH set. Thus, my
> question:
>
> Is there some place on Mac OS X Server to alter a non-interactive,
> non- login bash shell's $PATH in a system-wide way? The only solutions
> I've come across are all per-user solutions (e.g., ~/.bashrc or
> ~/.profile, ~/.ssh/environment, and so on).

These kinds of issues have been annoying me, too, and Googling to find a
solution led me to your post. After more trouble than I would have
liked, I discovered and came up with the following. (Don't get
disheartened part way through; there is a pretty good climax at the
end!) (Also, though I am on Mac OS X Client/User 10.4.9, I expect all
this applies to Mac OS X Server, and probably to 10.5, too.)

- When ssh is started without a commandline, an interactive login shell
   is started. This is nice! Everything works!

- When ssh is started with a commandline, a non-interactive non-login
   shell is started. However...bash does not use $BASH_ENV in this case,
   so setting it in ~/.ssh/environment (e.g. to /etc/profile) doesn't
   help. What bash does is source /etc/bashrc and ~/.bashrc--it evidently
   treats ssh like rsh and does a little more than is documented even for
   rsh (search for rsh in the bash man page for details). This is pretty
   much never what I want, as I would like all ssh logins to be 'login
   shells' and use /etc/profile and ~/.profile, but only those that are
   interactive to use ~/.bashrc. I came up with this fairly robust
   per-user solution, which I flooded with comments to help me remember
   what's used when:

   In /etc/profile

     # System-wide .profile for sh(1)
     PATH=...
     export PATH
     # Source /etc/bashrc for interactive shells.
     [ -n "$PS1" -a -r /etc/bashrc ] && source /etc/bashrc
     ... stuff for login shells (more environment mostly)

   In /etc/bashrc

     # System-wide .bashrc file for interactive bash(1) shells.
     ... stuff for interactive shells (aliases and terminal stuff mostly)

   In ~/.profile

     # For login shells (interactive or not).
     # For interactive non-login shells see ~/.bashrc.
     # For non-interactive non-login ssh shells see ~/.bashrc.
     # For other non-interactive non-login shells see $BASH_ENV.
     # At present this is sourced by ~/.bashrc for the ssh case, so
     # all ssh sessions act like login sessions.
     PATH=...
     export PATH
     # Source ~/.bashrc for interactive shells.
     if [ -n "$PS1" -a -r ~/.bashrc ]; then source ~/.bashrc ; fi
     ... stuff for login shells (more environment mostly)

   In ~/.bashrc

     # For interactive non-login shells
     # and non-interactive non-login ssh shells.
     # For login shells (interactive or not) see first existent of
     # ~/.bash_profile, ~/.bash_login and ~/.profile.
     # For other non-interactive non-login shells see $BASH_ENV.
     # At present, this is sourced by ~/.profile so runs for all
     # interactive shells (login or not).
     # If the shell isn't actually interactive it is an ssh session, and
     # we want to source /etc/profile and ~/.profile instead. We can't
     # use a simple test of $PS1 and must test $- because /etc/bashrc
     # (also sourced when bash detects ssh) sets $PS1. (We empty it
     # here.)
     if echo $- | grep -q i ; then : ; else
       [ -r /etc/profile ] && source /etc/profile
       PS1=
       source ~/.profile
       return
     fi
     ... stuff for interactive shells (aliases and terminal stuff mostly)

   This is OK if you're a single user wanting your shell to behave like
   you want it to, particularly if you're setting up your own account on
   a remote machine. Note that I have made one functional modification to
   /etc/profile: only sourcing /etc/bashrc if interactive; on my version
   of OS X it is sourced for all login shells, interactive or not. I
   have written ~/.bashrc so it will work OK without that change, though,

   But if you're a sysadmin, you don't want to deal with all this crap
   for every user, particularly if/when they break it.

- Setting $PATH and/or other environment variables directly via
   ~/.ssh/environment, rather than trying to get bash to run a script
   does work, but is another per-user solution.

- Eventually I came up with this system-wide solution. Add

     ForceCommand /usr/local/bin/ssh_session

   to /etc/sshd_config which makes ssh run that command regardless of
   what the user requested. It sets $SSH_ORIGINAL_COMMAND, though, so we
   can just use that to do what the user originally asked for, and seems
   to reliably work when used with eval. We can fall back to login if a
   command is not requested. This is what my /usr/local/bin/ssh_session
   script does:

     #!/bin/bash
     export SSH_SESSION=1
     if [ -z "$SSH_ORIGINAL_COMMAND" ] ; then
       export SSH_LOGIN=1
       exec login -fp "$USER"
     else
       export SSH_LOGIN=
       [ -r /etc/profile ] && source /etc/profile
       [ -r ~/.profile ] && source ~/.profile
       eval exec "$SSH_ORIGINAL_COMMAND"
     fi

   It is of course important to

     chmod +x /usr/local/bin/ssh_session

   I obviously haven't allowed for ~/.bash_profile or ~/.bash_login, but
   others are likely to want a different solution for these specifics
   anyway. The important thing is that you can easily see where to add
   environment variables or other commands for all cases, the login case,
   and the non-login (command execution) case. I believe the command
   execution case also applies to subsystems (e.g. sftp).

   There are potentially some difficulties if using X forwarding, due to
   use of the login command, as documented in the sshd_config man page at
   the UseLogin directive; but I think these would be minor--they would
   only occur if you start an interactive ssh session with X forwarding,
   but more likely than not you would make a different ssh process do
   this with -Nf or run a specific command rather than an interactive
   session, I think. And they may not occur at all when -fp is used.

   All that said, this seems to be working well so far for me!

Hope this can help some others.

Ben Schmidt.
Melbourne, Australia.
