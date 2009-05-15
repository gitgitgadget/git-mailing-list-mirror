From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 21:08:27 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 15 21:08:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52lc-0004Ck-Bk
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:08:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753436AbZEOTIQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:08:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753244AbZEOTIQ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:08:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:56750 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753087AbZEOTIP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 May 2009 15:08:15 -0400
Received: (qmail invoked by alias); 15 May 2009 19:08:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp004) with SMTP; 15 May 2009 21:08:15 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+euKB5Sv2eMHiNuVFoRjmh209neP3kCnHqnM8FOJ
	FVyIfXiYcz7+cw
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119281>

Hi,

On Fri, 15 May 2009, Linus Torvalds wrote:

> On Fri, 15 May 2009, Junio C Hamano wrote:
> 
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > 
> > > if you need a chuckle, like me, you might appreciate this story: in 
> > > one of my repositories, "git gc" dies with
> > >
> > > 	unable to open object pack directory: ...: Too many open files
> > >
> > > turns out that there are a whopping 1088 packs in that repository...
> > 
> > Isn't it a more serious problem than a mere chuckle?  How would one 
> > recover from such a situation (other than "mv .git/objects/pack-*; for 
> > p in pack-*.pack; do git unpack-objects <$p; done")?
> 
> Well, you can probably just increase the file limits and try again. 
> Depending on setup, you may need root to do so, though.
> 
> I also think you _should_ be able to avoid this by just limiting the 
> pack size usage. IOW, with some packed_git_limit, something like
> 
> 	[core]
> 		packedGitWindowSize = 16k
> 		packedGitLimit = 1M
> 
> you should hopefully be able to repack (slowly) even with a low file 
> descriptor limit, because of the total limit on the size.

I don't think so, because the window size has nothing to do with the 
amount of open windows, right?

> That said, I do agree that ulimit doesn't always work on all systems 
> (whether due to hard system limits or due to not having permission to 
> raise the limits), and playing games with pack limits is non-obvious. We 
> should really try to avoid getting into such a situation. But I think git 
> by default avoids it by the auto-gc, no? So you have to disable that 
> explicitly to get into this bad situation.

No, in this case, nothing was disabled.  auto-gc did not kick in, probably 
due to funny Git usage in hg2git.

> One solution - which I think may be the right one regardless - is to not 
> use "mmap()" for small packs or small SHA1 files.
> 
> mmap is great for random-access multi-use scenarios (and to avoid some 
> memory pressure by allowing sharing of pages), but for anything that is 
> just a couple of pages in size, mmap() just adds big overhead with 
> little upside.
> 
> So if we use malloc+read for small things, we'd probably avoid this. Now, 
> if you have a few thousand _large_ packs, you'd still be screwed, but the 
> most likely reason for having a thousand packfiles is that you did daily 
> "git pull"s, and have lots and lots of packs that are pretty small.
> 
> Dscho? What are your pack-file statistics in this case?

Mostly around 50kB.

But using malloc()+read() to avoid my use case sounds not 
straight-forward; it is rather a work-around than a proper solution.

For performance, I agree that malloc()+read() might be a sensible thing in 
a lot of cases.

Ciao,
Dscho
