From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Funny error with git gc...
Date: Fri, 15 May 2009 12:16:57 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905151212160.3343@localhost.localdomain>
References: <alpine.DEB.1.00.0905152000520.4449@intel-tinevez-2-302> <7vmy9etey8.fsf@alter.siamese.dyndns.org> <alpine.LFD.2.01.0905151128230.3343@localhost.localdomain> <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 15 21:17:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M52u8-00085S-7S
	for gcvg-git-2@gmane.org; Fri, 15 May 2009 21:17:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752238AbZEOTRF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 May 2009 15:17:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751225AbZEOTRD
	(ORCPT <rfc822;git-outgoing>); Fri, 15 May 2009 15:17:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:57752 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750717AbZEOTRC (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 May 2009 15:17:02 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FJGwdg003959
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 May 2009 12:16:59 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4FJGvNK016628;
	Fri, 15 May 2009 12:16:58 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.00.0905152105340.26154@pacific.mpi-cbg.de>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119283>



On Fri, 15 May 2009, Johannes Schindelin wrote:
> > 
> > 	[core]
> > 		packedGitWindowSize = 16k
> > 		packedGitLimit = 1M
> > 
> > you should hopefully be able to repack (slowly) even with a low file 
> > descriptor limit, because of the total limit on the size.
> 
> I don't think so, because the window size has nothing to do with the 
> amount of open windows, right?

No, but the packedGitLimit does.

So the argument is that you can't fit all that many open windows in 1M. 

> No, in this case, nothing was disabled.  auto-gc did not kick in, probably 
> due to funny Git usage in hg2git.

Ahh. Scripting.

> > Dscho? What are your pack-file statistics in this case?
> 
> Mostly around 50kB.

Can you give us an approximation for how many are under 16kB or so?

The 16kB cutoff is where it's usually just better to malloc+read (because 
even if you don't end up using all the 16kB, just a page-fault or two is 
already more expensive than just doing the memcpy implied in a 16k read() 
system call).

> But using malloc()+read() to avoid my use case sounds not 
> straight-forward; it is rather a work-around than a proper solution.

Well, it's a workaround that is correct for other reasons too. So it's 
likely worth doing.

The "proper solution" is likely to not avoid repacking. Scripted stuff 
that does that is buggy.

			Linus
