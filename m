From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix race and deadlock when sending pack
Date: Mon, 19 Dec 2005 01:49:44 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0512190130450.25300@iabervon.org>
References: <43A628F6.1060807@serice.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 19 07:49:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EoEpD-0001ae-Fs
	for gcvg-git@gmane.org; Mon, 19 Dec 2005 07:48:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030232AbVLSGsm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Dec 2005 01:48:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030235AbVLSGsm
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Dec 2005 01:48:42 -0500
Received: from iabervon.org ([66.92.72.58]:2311 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1030232AbVLSGsm (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Dec 2005 01:48:42 -0500
Received: (qmail 31829 invoked by uid 1000); 19 Dec 2005 01:49:44 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Dec 2005 01:49:44 -0500
To: Paul Serice <paul@serice.net>
In-Reply-To: <43A628F6.1060807@serice.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13817>

On Sun, 18 Dec 2005, Paul Serice wrote:

> Fix race and deadlock when sending pack.
> 
> The best way to reproduce the problem is to locally clone your
> repository.  When you perform a push, git-send-pack will directly set
> up pipes connected to stdin and stdout of git-receive-pack.  You
> should then set up hook/post-update or hook/update to try to write
> lots of text to stdout.  (You want to use the local protocol because
> ssh is robust enough to mask the worst behavior.)
> 
> The first problem is that git-send-pack closes git-receive-pack's
> stdout (which is inherited by the hooks) immediately after sending the
> pack.  This almost always causes the hooks to receive SIGPIPE when
> they try to write to stdout.
> 
> After fixing the SIGPIPE problem, you then run into a deadlock because
> git-send-pack is blocked trying to reap git-receive-pack and
> git-receive-pack (or one of its hooks) is blocked waiting for
> git-send-pack to read its output.
> 
> I've also added an example a one-liner to both hooks demonstrating how
> to redirect all subsequent output to stderr.  Because
> git-receive-pack's stderr is not redirected, it has always been safe
> to write to stderr.  Thus, all current status related output appears
> on stderr.  This can lead to confusing ordering of messages if only
> the hooks are using stdout.  The patch has the one-liner commented
> out, but perhaps it should be enabled by default.
> 
> In addition, this commit reverts the work-around provided by
> 128aed684d0b3099092b7597c8644599b45b7503 which redirected both stdout
> and stderr for the hooks to /dev/null.

Actually, that was stdin and stdout. If, for some reason, a hook looked at 
stdin, it could get surprising results. I don't think that it's actually a 
good idea to have output to stdout from hooks go to git-send-pack's 
stdout, since we may want to have git-send-pack report some sort of 
information of its own to stdout, which would then get confused with 
output from hooks. I think /dev/null, a log file, and stderr are the 
reasonable choices for what happens to output (and input pretty much has 
to be /dev/null).

	-Daniel
*This .sig left intentionally blank*
