From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Subject: Re: git push bug?
Date: Thu, 18 Oct 2007 18:01:08 +0200
Organization: Transmode AB
Message-ID: <1192723269.9433.21.camel@gentoo-jocke.transmode.se>
References: <1192719040.9433.5.camel@gentoo-jocke.transmode.se>
	 <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
Reply-To: joakim.tjernlund@transmode.se
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Thu Oct 18 18:01:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IiXoO-0007le-BJ
	for gcvg-git-2@gmane.org; Thu, 18 Oct 2007 18:01:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934107AbXJRQBP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Oct 2007 12:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933221AbXJRQBO
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Oct 2007 12:01:14 -0400
Received: from mail.transmode.se ([83.241.175.147]:22634 "EHLO
	tmnt04.transmode.se" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933975AbXJRQBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Oct 2007 12:01:12 -0400
Received: mail.transmode.se 192.168.46.15 from 192.168.1.15 192.168.1.15 via HTTP with MS-WebStorage 6.0.6249
Received: from gentoo-jocke by mail.transmode.se; 18 Oct 2007 18:01:09 +0200
In-Reply-To: <0DAC53EF-021D-441C-9520-9795AAB6DE54@zib.de>
X-Mailer: Evolution 2.10.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61539>

On Thu, 2007-10-18 at 17:14 +0200, Steffen Prohaska wrote:
> On Oct 18, 2007, at 4:50 PM, Joakim Tjernlund wrote:
> 
> >
> > I thougth I could create a new branch on the server using:
> >
> > # > git push ssh://devsrv/var/git/os2kernel.git linus:refs/linus
> > Warning: No xauth data; using fake authentication data for X11  
> > forwarding.
> > updating 'refs/linus' using 'refs/heads/linus'
> >  from 0000000000000000000000000000000000000000
> >  to bbf25010f1a6b761914430f5fca081ec8c7accd1
> > Generating pack...
> > Done counting 0 objects.
> > Writing 0 objects...
> > Total 0 (delta 0), reused 0 (delta 0)
> > error: refusing to create funny ref 'refs/linus' locally
> > ng refs/linus funny refname
> > error: failed to push to 'ssh://devsrv/var/git/os2kernel.git'
> >
> > but that doesn't work. Am I doing this wrong?
> 
> Include 'heads' in your remote refspec:
> 
>     git push ssh://devsrv/var/git/os2kernel.git linus:refs/heads/linus

Now the push went OK:
git push  ssh://devsrv/var/git/os2kernel.git linus:refs/head/linus
Warning: No xauth data; using fake authentication data for X11 forwarding.
updating 'refs/head/linus' using 'refs/heads/linus'
  from 0000000000000000000000000000000000000000
  to   bbf25010f1a6b761914430f5fca081ec8c7accd1
Generating pack...
Done counting 0 objects.
Writing 0 objects...
Total 0 (delta 0), reused 0 (delta 0)
refs/head/linus: 0000000000000000000000000000000000000000 -> bbf25010f1a6b761914430f5fca081ec8c7accd1

but there is no linus branch in the server repo!

However:
 git push  ssh://devsrv/var/git/os2kernel.git linus

creates a linus branch in the server and 

 git push  ssh://devsrv/var/git/os2kernel.git :linus
 Warning: No xauth data; using fake authentication data for X11 forwarding. 
 deleting 'refs/heads/linus'
 refs/heads/linus: bbf25010f1a6b761914430f5fca081ec8c7accd1 -> deleted
 Everything up-to-date

deletes the linus branch on the server and so does
git push  ssh://devsrv/var/git/os2kernel.git :refs/heads/linus

ahh, now I see. When creating the branch the refspec needs to be refs/heads/linus,
not refs/head/linus

refs/head/linus will create just that on the server. git branch does not look
there, only in refs/heads

Seems like it is a bit too easy to make mistakes here. Why can I delete
a branch with :linus but not create one with linus:linus?
Also confusing that git lets me create refs/head/linus when git branch
cannot find it.

 Jocke

> You may need to cleanup though. I'm not sure if the remote side
> already created 'refs/linus'. The error message only indicates that
> locally git refused to create the "funny refname". Pushing a refspec
> with an empty local part should delete the "funny refname" on the
> remote:
> 
>     git push ssh://devsrv/var/git/os2kernel.git :refs/linus
> 
> Did this solve your problem?
> 
> 	Steffen
> 
