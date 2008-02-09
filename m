From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Fix "git clone" for git:// protocol
Date: Sat, 9 Feb 2008 12:16:04 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802091205530.13593@iabervon.org>
References: <alpine.LSU.1.00.0802091657000.11591@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Feb 09 18:16:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNtJc-0006Hg-Ts
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 18:16:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754785AbYBIRQH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 12:16:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754862AbYBIRQG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 12:16:06 -0500
Received: from iabervon.org ([66.92.72.58]:60145 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754785AbYBIRQF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 12:16:05 -0500
Received: (qmail 4879 invoked by uid 1000); 9 Feb 2008 17:16:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Feb 2008 17:16:04 -0000
In-Reply-To: <alpine.LSU.1.00.0802091657000.11591@racer.site>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73245>

On Sat, 9 Feb 2008, Johannes Schindelin wrote:

> In the commit "Reduce the number of connects when fetching", we checked 
> the return value of git_connect() to see if the connection was successful.
> 
> However, for the git:// protocol, there is no need to have another 
> process, so the return value is NULL.
> 
> The thing is: git_connect() does not return at all if it fails, so we need 
> not check the return value of git_connect().

Huh. Sure enough. Actually, there's a similar problem in transport.c, 
where it assumes that the return value of git_connect is non-zero, which 
makes it not reuse the connection (not that you can really tell). It might 
be good to roll in a fix for that. Or maybe git_connect should return a 
pointer to a static struct child_process if it doesn't need a subprocess, 
just to distinguish "we're doing it ourselves" from "it's not being done"? 
If not, maybe the variables that store the return from git_connect should 
be renamed to "subproc" or something that doesn't suggest they can't be 
NULL if you're actually connected.

	-Daniel
*This .sig left intentionally blank*
