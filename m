From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of
 builtin-push.
Date: Thu, 10 May 2007 04:33:40 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705100421490.18541@iabervon.org>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
 <7vhcqlma1l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705100328260.18541@iabervon.org>
 <7vmz0dktdf.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705100355560.18541@iabervon.org>
 <7virb1ks1v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu May 10 10:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm45q-0000Ot-M2
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755675AbXEJIdm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755880AbXEJIdl
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:33:41 -0400
Received: from iabervon.org ([66.92.72.58]:3747 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675AbXEJIdl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:33:41 -0400
Received: (qmail 4169 invoked by uid 1000); 10 May 2007 08:33:40 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 10 May 2007 08:33:40 -0000
In-Reply-To: <7virb1ks1v.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46847>

On Thu, 10 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >> And I think it does today.
> >
> > Hmm, and I guess URIs on the command line work the same way. How about 
> > requiring a '/' somewhere in a repository argument in order to treat it as 
> > a repository instead of a remote name? Then "../next-door-neighbour" would 
> > work, "./gitcvs.git" would work (in the odd case where you actually have a 
> > bare repository sitting in your working directory), but we'd avoid the 
> > current default of pushing to a bare repository in "./origin/" if nothing 
> > at all is configured.
> 
> When I wrote the message you are responding to, I thought this
> was a regression from the current behaviour, which (IIRC--it's
> getting late and I am tired to double check) essentially says if
> the token is a name of the directory, the target repository is a
> local one, but "we'd avoid..." part seems to suggest that you
> actually did this deliberately as a fix to some problem in the
> current behaviour.  I am not however sure what it exactly is.
> Could you care to elaborate the part after "we'd avoid..." to
> clarify what the problem is, please?

The problem, in general, is that, if the remote name you specify (or 
"origin" if you don't specify any) is not configured as a remote, it is 
treated as a filename in the current directory for a local push. E.g.:

$ git init
$ git push
fatal: 'origin': unable to chdir or not a git archive
fatal: The remote end hung up unexpectedly

It's actually trying to push to ./origin/, which is totally nuts as a 
default repository to push to. Similarly, if you typo an actual remote 
name. Furthermore, builtin-push.c has an error message for the situation 
where the repository specification is wrong, suggesting that there is 
some invalid repository specification, but it isn't reachable. And it 
carefully prevents remote names from starting with a '/', suggestion that 
that is the distinguishing characteristic between directly-specified 
repository URIs and configured remotes (which can't really be right, of 
course).

I think the right answer is to say that configured remotes cannot contain 
slashes, and directly-specified URIs must contain slashes, and it'll all 
be clear.

	-Daniel
*This .sig left intentionally blank*
