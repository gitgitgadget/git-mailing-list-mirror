From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of
 builtin-push.
Date: Thu, 10 May 2007 12:40:44 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705101150020.18541@iabervon.org>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
 <7vhcqlma1l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705100328260.18541@iabervon.org>
 <7vmz0dktdf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705100355560.18541@iabervon.org>
 <7virb1ks1v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705100421490.18541@iabervon.org>
 <7v3b25kr0t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 18:41:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmBhT-0000H1-Nx
	for gcvg-git@gmane.org; Thu, 10 May 2007 18:41:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754775AbXEJQkq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 12:40:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756385AbXEJQkq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 12:40:46 -0400
Received: from iabervon.org ([66.92.72.58]:2449 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754548AbXEJQkp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 12:40:45 -0400
Received: (qmail 8882 invoked by uid 1000); 10 May 2007 16:40:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 May 2007 16:40:44 -0000
In-Reply-To: <7v3b25kr0t.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46876>

On Thu, 10 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > On Thu, 10 May 2007, Junio C Hamano wrote:
> >
> >> Daniel Barkalow <barkalow@iabervon.org> writes:
> >> 
> >> >> And I think it does today.
> >> >
> >> > Hmm, and I guess URIs on the command line work the same way. How about 
> >> > requiring a '/' somewhere in a repository argument in order to treat it as 
> >> > a repository instead of a remote name? Then "../next-door-neighbour" would 
> >> > work, "./gitcvs.git" would work (in the odd case where you actually have a 
> >> > bare repository sitting in your working directory), but we'd avoid the 
> >> > current default of pushing to a bare repository in "./origin/" if nothing 
> >> > at all is configured.
> >> 
> >> When I wrote the message you are responding to, I thought this
> >> was a regression from the current behaviour, which (IIRC--it's
> >> getting late and I am tired to double check) essentially says if
> >> the token is a name of the directory, the target repository is a
> >> local one, but "we'd avoid..." part seems to suggest that you
> >> actually did this deliberately as a fix to some problem in the
> >> current behaviour.  I am not however sure what it exactly is.
> >> Could you care to elaborate the part after "we'd avoid..." to
> >> clarify what the problem is, please?
> >
> > The problem, in general, is that, if the remote name you specify (or 
> > "origin" if you don't specify any) is not configured as a remote, it is 
> > treated as a filename in the current directory for a local push. E.g.:
> >
> > $ git init
> > $ git push
> > fatal: 'origin': unable to chdir or not a git archive
> > fatal: The remote end hung up unexpectedly
> 
> Ahh.  You were trying to give it a better error message.
> 
> I think I lied in the previous message.  I said we try to see if
> it is a local directory name before using that name, but we do
> not do it, and leave the error detection to the lower level on
> the other side (push spawns send-pack which in turn spawns
> receive-pack) instead.
> 
> Perhaps an alternative is to see if the name is configured as a
> remote (if so, we obviously use it), and if not do stat() to see
> if it is a directory (if so, use it as a local repository).
> Then we do not have to impose new restriction of slash at all,
> although it might complicate the code a bit more.

The problem I see with allowing paths without slashes is if you've got a 
subproject with a name similar to a remote name, and type the wrong one 
(particularly due to tab-completion), or if you've got a remote name you 
use in other projects that matches a subproject in a project where you 
aren't using that remote name. I think that a repository in your working 
directory is unlikely to be something you actually want to push to or 
fetch from (and if this is actually what you want, ./directory is the 
usual unixy thing for saying, no really, I want a relative path in the 
current directory, and would work here; and it would be good practice 
anyway, so that you don't get tripped up if you create a remote 
configuration with that name later). Obviously, ../something has a slash; 
it should also take ':' to mean a URI (which I didn't realize last night), 
so that "person@machine:directory.git" is a URI.

I think, as a general rule, that it would be cleanest to distinguish 
lexically between repository names that indicate configured remotes and 
repository names that are URIs, particularly if we only break usage that 
people only do for writing git regression tests.

	-Daniel
*This .sig left intentionally blank*
