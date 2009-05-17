From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: On data structures and parallelism
Date: Sun, 17 May 2009 13:35:44 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905171308010.3301@localhost.localdomain>
References: <20090517152335.GC11543@zakalwe.fi> <alpine.LFD.2.01.0905170950230.3301@localhost.localdomain> <alpine.LFD.2.01.0905171038320.3301@localhost.localdomain> <alpine.DEB.1.10.0905171230070.26653@asgard>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Heikki Orsila <shdl@zakalwe.fi>, git@vger.kernel.org
To: david@lang.hm
X-From: git-owner@vger.kernel.org Sun May 17 22:36:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5n5h-00048F-4w
	for gcvg-git-2@gmane.org; Sun, 17 May 2009 22:36:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbZEQUgF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2009 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752250AbZEQUgE
	(ORCPT <rfc822;git-outgoing>); Sun, 17 May 2009 16:36:04 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36400 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751918AbZEQUgA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 May 2009 16:36:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4HKZjfb028261
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 17 May 2009 13:35:47 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n4HKZisd002141;
	Sun, 17 May 2009 13:35:45 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.DEB.1.10.0905171230070.26653@asgard>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.464 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119408>



On Sun, 17 May 2009, david@lang.hm wrote:
> 
> do things change with SSDs? I've heard that even (especially??) with the Intel
> SSDs you want to have several operations going in paralllel to get the best
> out of them.

There's a slight, but noticeable, improvement.

This is: "echo 3 > /proc/sys/vm/drop_caches; time git diff" run in a loop. 

With 'core.preloadindex = true':

	real	0m1.138s
	real	0m1.116s
	real	0m1.132s
	real	0m1.120s
	real	0m1.106s
	real	0m1.132s

and with it set to 'false':

	real	0m1.256s
	real	0m1.258s
	real	0m1.242s
	real	0m1.240s
	real	0m1.244s
	real	0m1.242s

so it's about a 10% improvement. Which is pretty good, considering 
that

 (a) those disks are fast enough that even for that totally cache-cold 
     case, I get about 35% CPU utilization for the single-threaded case.

     And that's despite this being a 3.2GHz Nehalem box, so 35% CPU is 
     really quite remarkably good. Om my (much slower) laptop with a 
     1.2GHz Core 2, I get 2-3% CPU-time (and the whole operation takes 20 
     seconds).

 (b) Not all the IO ends up being parallelized, since there is a 
     per-directory mutex that means that even though we start 20 threads, 
     it probably gets a much smaller amount of real parallelism due to 
     locking.

in general, the IO parallelization obviously helps most when the IO is 
slow _and_ overlaps perfectly. Perfect overlap doesn't end up happening 
due to the per-directory lookup semaphore (think of it like a bank 
conflict in trying to parallelize memory accesses), but with a slow NFS 
connection you should get reasonably close to that optimal situation.

But with a single spindle, and rotating media, there really is sadly very 
little room for optimization. I suspect a SATA with TCQ disk might be able 
to do _somewhat_ better than my old PATA-only laptop (discounting the fact 
that my PATA laptop harddisk is extra slow due to being just 4200rpm: any 
desktop disk will be much faster), but I doubt the index preloading is 
really all that noticeable.

In fact, I just tested on another machine, and saw no difference 
what-so-ever. If anything, it was slightly slower. I suspect TCQ is a 
bigger win with writes.

			Linus
