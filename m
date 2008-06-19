From: Ben Schmidt <mail_ben_schmidt@yahoo.com.au>
Subject: Further Re: Getting the path right for git over SSH
Date: Fri, 20 Jun 2008 03:13:40 +1000
Message-ID: <485A93C4.3060603@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 19 19:15:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9Nib-0000jA-Rc
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 19:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756047AbYFSRNo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 13:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbYFSRNo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 13:13:44 -0400
Received: from outbound.icp-qv1-irony-out2.iinet.net.au ([203.59.1.107]:7175
	"EHLO outbound.icp-qv1-irony-out2.iinet.net.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752085AbYFSRNo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 13:13:44 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AqkAALgwWkh8qAm+/2dsb2JhbAAIsC8
X-IronPort-AV: E=Sophos;i="4.27,673,1204470000"; 
   d="scan'208";a="331443040"
Received: from unknown (HELO [192.168.1.11]) ([124.168.9.190])
  by outbound.icp-qv1-irony-out2.iinet.net.au with ESMTP; 20 Jun 2008 01:13:40 +0800
User-Agent: Thunderbird 2.0.0.12 (Macintosh/20080213)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85495>

[Further to my previous message...]

[When starting a non-interactive non-login shell from an ssh session...]
 >   What bash does is source /etc/bashrc and ~/.bashrc--it evidently
 >   treats ssh like rsh and does a little more than is documented even for
 >   rsh (search for rsh in the bash man page for details).

So another, simpler, system-wide solution is to set your $PATH in
/etc/bashrc. However, this is not documented in the bash man page (which
is why I came up with the more complicated solution, as I hadn't
realised this behaviour at that stage). So I'm not sure whether it is
standard/will occur on all systems, etc.

If you're like me and like to have interactive stuff in bashrc and login
stuff in profile, you can arrange your files like this (very similar to
before, but ~/.bashrc needn't source /etc/profile now, nor do its check
with $- and grep, as /etc/bashrc does that and avoids setting $PS1).

    In /etc/profile

      # System-wide .profile for sh(1)
      PATH=...
      export PATH
      # Source /etc/bashrc for interactive shells.
      [ -n "$PS1" -a -r /etc/bashrc ] && source /etc/bashrc
      ... stuff for login shells (more environment mostly)

    In /etc/bashrc

      # System-wide .bashrc file for interactive bash(1) shells.
      # If the shell isn't actually interactive it is an ssh session, and
      # we want to source etc/profile instead.
      if [ -z "$PS1" ] ; then
        [ -r /etc/profile ] && source /etc/profile
        return
      fi
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
      # we want to source ~/.profile instead.
      if [ -z "$PS1" ] ; then
        source ~/.profile
        return
      fi
      ... stuff for interactive shells (aliases and terminal stuff mostly)

Ben.
