From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 16:30:01 -0400 (EDT)
Message-ID: <alpine.LNX.2.00.0905151611541.2147@iabervon.org>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain> <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de>
 <alpine.LFD.2.01.0905151212160.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 22:30:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5433-0004cm-Ks
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 22:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753233AbZEOUaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 16:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753229AbZEOUaE
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 16:30:04 -0400
Received: from iabervon.org ([66.92.72.58]:41507 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751349AbZEOUaB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 16:30:01 -0400
Received: (qmail 7973 invoked by uid 1000); 15 May 2009 20:30:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 May 2009 20:30:01 -0000
In-Reply-To: <alpine.LFD.2.01.0905151212160.3343@localhost.localdomain>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119293>

On Fri, 15 May 2009, Linus Torvalds wrote:

> On Fri, 15 May 2009, Johannes Schindelin wrote:
> > > 
> > > 	[core]
> > > 		packedGitWindowSize = 16k
> > > 		packedGitLimit = 1M
> > > 
> > > you should hopefully be able to repack (slowly) even with a low file 
> > > descriptor limit, because of the total limit on the size.
> > 
> > I don't think so, because the window size has nothing to do with the 
> > amount of open windows, right?
> 
> No, but the packedGitLimit does.
> 
> So the argument is that you can't fit all that many open windows in 1M. 
> 
> > No, in this case, nothing was disabled.  auto-gc did not kick in, probably 
> > due to funny Git usage in hg2git.
> 
> Ahh. Scripting.
> 
> > > Dscho? What are your pack-file statistics in this case?
> > 
> > Mostly around 50kB.
> 
> Can you give us an approximation for how many are under 16kB or so?
> 
> The 16kB cutoff is where it's usually just better to malloc+read (because 
> even if you don't end up using all the 16kB, just a page-fault or two is 
> already more expensive than just doing the memcpy implied in a 16k read() 
> system call).
> 
> > But using malloc()+read() to avoid my use case sounds not 
> > straight-forward; it is rather a work-around than a proper solution.
> 
> Well, it's a workaround that is correct for other reasons too. So it's 
> likely worth doing.
> 
> The "proper solution" is likely to not avoid repacking. Scripted stuff 
> that does that is buggy.

I think it's going to be not-too-uncommon in fast-import scripts to want 
to checkpoint periodically so that you don't lose your progress if 
interacting with the foreign system starts failing partway through, and 
you'll obviously want to repack afterwards rather than in the middle. But 
if you have different input characteristics than the tool was optimized 
for, you could end up with a ton of packs by the time it finishes.

Obviously, you don't want to avoid repacking before you actually use the 
repository, but I think it's reasonable to wait until the end of the 
script to repack, which might actually be too late.

	-Daniel
*This .sig left intentionally blank*
