From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re:
Date: Fri, 8 May 2009 09:15:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504>  <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com>  <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504>  <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain>  <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
  <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain>  <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain>  <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com>
 <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain> <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 08 18:18:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2SmT-0000sX-9d
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 18:18:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753006AbZEHQST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 12:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752746AbZEHQSS
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 12:18:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:45963 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751414AbZEHQSR (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 12:18:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48GFqMv021079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 May 2009 09:16:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48GFoCq004632;
	Fri, 8 May 2009 09:15:51 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118616>



On Fri, 8 May 2009, Brandon Casey wrote:
> 
> plain 'git checkout' on linux kernel over NFS.

Thanks.

> Best time without patch: 1.20 seconds
> 
>   0.45user 0.71system 0:01.20elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
>   0inputs+0outputs (0major+15467minor)pagefaults 0swaps
> 
> Best time with patch (core.preloadindex = true): 1.10 seconds
> 
>   0.43user 4.00system 0:01.10elapsed 402%CPU (0avgtext+0avgdata 0maxresident)k
>   0inputs+0outputs (0major+13999minor)pagefaults 0swaps
> 
> Best time with patch (core.preloadindex = false): 0.84 seconds
> 
>   0.42user 0.39system 0:00.84elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
>   0inputs+0outputs (0major+13965minor)pagefaults 0swaps

Ok, that is _disgusting_. The parallelism clearly works (402%CPU), but the 
system time overhead is horrible. Going from 0.39s system time to 4s of 
system time is really quite nasty.

Is there any possibility you could oprofile this (run it in a loop to get 
better profiles)? It very much sounds like some serious lock contention, 
and I'd love to hear more about exactly which lock it's hitting.

Also, you're already almost totally CPU-bound, with 96% CPU for the 
single-threaded csase. So you may be running over NFS, but your NFS server 
is likely pretty good and/or the client just captures everything in the 
caches anyway.

I don't recall what the Linux NFS stat cache timeout is, but it's less 
than a minute. I suspect that you ran things in a tight loop, which is why 
you then got effectively the local caching behavior for the best times. 

Can you do a "best time" check but with a 60-second pause between runs 
(and before), to see what happens when the client doesn't do caching?

> Best time with read_cache_preload patch only: 1.38 seconds
> 
>   0.45user 4.42system 0:01.38elapsed 352%CPU (0avgtext+0avgdata 0maxresident)k
>   0inputs+0outputs (0major+13990minor)pagefaults 0swaps

Yeah, here you're not getting any advantage of fewer lstats, and you 
show the same "almost entirely CPU-bound on four cores" behavior, and the 
same (probable) lock contention that has pushed the system time way up.

> The read_cache_preload() changes actually slow things down for me for this
> case.
> 
> Reduction in lstat's gives a nice 30% improvement.

Yes, I think the one-liner lstat avoidance is a real fix regardless. And 
the preloading sounds like it hits serialization overhead in the kernel, 
which I'm not at all surprised at, but not being surprised doesn't mean 
that I'm not interested to hear where it is.

The Linux VFS dcache itself should scale better than that (but who knows - 
cacheline ping-pong due to lock contention can easily cause a 10x slowdown 
even without being _totally_ contended all the time). So I would _suspect_ 
that it's some NFS lock that you're seeing, but I'd love to know more.

Btw, those system times are pretty high to begin with, so I'd love to know 
kernel version and see a profile even without the parallel case and 
presumably lock contention. Because while I probably have a faster 
machine anyway, what I see iis:

	[torvalds@nehalem linux]$ /usr/bin/time git checkout
	0.13user 0.05system 0:00.19elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
	0inputs+0outputs (0major+13334minor)pagefaults 0swaps

ie my "system" time is _much_ lower than yours (and lower than your system 
time). This is the 'without patch' time, btw, so this has extra lstat's. 
And my system time is still lower than my user time, so I wonder where all 
_your_ system time comes from. Your system time is much more comparable to 
user time even in the good case, and I wonder why?

Could be just that kernel code tends to have more cache misses, and my 8MB 
cache captures it all, and yours doesn't. Regardless, a profile would be 
very interesting.

			Linus
