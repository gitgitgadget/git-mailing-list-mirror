From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 13:40:37 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512191236290.25300@iabervon.org>
References: <43A628F6.1060807@serice.net> <7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Paul Serice <paul@serice.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 19:48:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoPwJ-0004bR-9c
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 19:40:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964884AbVLSSje (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 13:39:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964883AbVLSSje
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 13:39:34 -0500
Received: from iabervon.org ([66.92.72.58]:6151 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S964879AbVLSSje (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 13:39:34 -0500
Received: (qmail 3020 invoked by uid 1000); 19 Dec 2005 13:40:37 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Dec 2005 13:40:37 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vzmmxlkbq.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13831>

On Sun, 18 Dec 2005, Junio C Hamano wrote:

> Paul Serice <paul@serice.net> writes:
> 
> > The best way to reproduce the problem is to locally clone your
> > repository.  When you perform a push, git-send-pack will directly set
> > up pipes connected to stdin and stdout of git-receive-pack.  You
> > should then set up hook/post-update or hook/update to try to write
> > lots of text to stdout.  (You want to use the local protocol because
> > ssh is robust enough to mask the worst behavior.)
> 
> My immediate reaction was "do not do it then", but you are
> right.  Hooks are run after all the protocol exchanges are done,
> so they should be free to throw any garbage at the other end.

If we extend it to transfer multiple things, wouldn't we want to run hooks 
after each of them, rather than all at the end?

As for the policy:

We definitely want to let hooks write to stdout, because git programs that 
you might want to run in hooks write to stdout. I can't figure out what 
"cvs" does with trigger script output and "at" and "cron" email the output 
to the owners. I'd sort of like to avoid making people expect that there 
is necessarily a path for text going back to the user directly. We may, 
for example, want to support these hooks with pushes over HTTP(/WebDAV). I 
also think that messages are likely to be at least as useful to the owner 
of the target repository as the person pushing, which is why I'd prefer a 
log file. E.g., if you've got a group central repository that different 
people push to, it may be other group members who want to know what 
happened with the output from a post-update hook, not the group member who 
pushed.

	-Daniel
*This .sig left intentionally blank*
