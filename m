From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re:
Date: Fri, 08 May 2009 12:27:05 -0500
Message-ID: <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504> <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com> <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain> <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 08 19:28:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2TsE-00010E-UA
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 19:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755120AbZEHR2b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 13:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754183AbZEHR2a
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 13:28:30 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57022 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753917AbZEHR2a (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 13:28:30 -0400
Received: by mail.nrlssc.navy.mil id n48HR8tS014408; Fri, 8 May 2009 12:27:08 -0500
In-Reply-To: <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain>
X-OriginalArrivalTime: 08 May 2009 17:27:06.0823 (UTC) FILETIME=[35D1E570:01C9D002]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118619>

Linus Torvalds wrote:
> 
> On Fri, 8 May 2009, Brandon Casey wrote:
>> plain 'git checkout' on linux kernel over NFS.
> 
> Thanks.
> 
>> Best time without patch: 1.20 seconds
>>
>>   0.45user 0.71system 0:01.20elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
>>   0inputs+0outputs (0major+15467minor)pagefaults 0swaps
>>
>> Best time with patch (core.preloadindex = true): 1.10 seconds
>>
>>   0.43user 4.00system 0:01.10elapsed 402%CPU (0avgtext+0avgdata 0maxresident)k
>>   0inputs+0outputs (0major+13999minor)pagefaults 0swaps
>>
>> Best time with patch (core.preloadindex = false): 0.84 seconds
>>
>>   0.42user 0.39system 0:00.84elapsed 96%CPU (0avgtext+0avgdata 0maxresident)k
>>   0inputs+0outputs (0major+13965minor)pagefaults 0swaps
> 
> Ok, that is _disgusting_. The parallelism clearly works (402%CPU), but the 
> system time overhead is horrible. Going from 0.39s system time to 4s of 
> system time is really quite nasty.
> 
> Is there any possibility you could oprofile this (run it in a loop to get 
> better profiles)? It very much sounds like some serious lock contention, 
> and I'd love to hear more about exactly which lock it's hitting.

Possibly, I'll see if our sysadmin has time to "play".

> Also, you're already almost totally CPU-bound, with 96% CPU for the 
> single-threaded csase. So you may be running over NFS, but your NFS server 
> is likely pretty good and/or the client just captures everything in the 
> caches anyway.
> 
> I don't recall what the Linux NFS stat cache timeout is, but it's less 
> than a minute. I suspect that you ran things in a tight loop, which is why 
> you then got effectively the local caching behavior for the best times. 

Yeah, that's what I did.

> Can you do a "best time" check but with a 60-second pause between runs 
> (and before), to see what happens when the client doesn't do caching?

No problem.

>> Best time with read_cache_preload patch only: 1.38 seconds
>>
>>   0.45user 4.42system 0:01.38elapsed 352%CPU (0avgtext+0avgdata 0maxresident)k
>>   0inputs+0outputs (0major+13990minor)pagefaults 0swaps
> 
> Yeah, here you're not getting any advantage of fewer lstats, and you 
> show the same "almost entirely CPU-bound on four cores" behavior, and the 
> same (probable) lock contention that has pushed the system time way up.
> 
>> The read_cache_preload() changes actually slow things down for me for this
>> case.
>>
>> Reduction in lstat's gives a nice 30% improvement.
> 
> Yes, I think the one-liner lstat avoidance is a real fix regardless. And 
> the preloading sounds like it hits serialization overhead in the kernel, 
> which I'm not at all surprised at, but not being surprised doesn't mean 
> that I'm not interested to hear where it is.
> 
> The Linux VFS dcache itself should scale better than that (but who knows - 
> cacheline ping-pong due to lock contention can easily cause a 10x slowdown 
> even without being _totally_ contended all the time). So I would _suspect_ 
> that it's some NFS lock that you're seeing, but I'd love to know more.
> 
> Btw, those system times are pretty high to begin with, so I'd love to know 
> kernel version and see a profile even without the parallel case and 
> presumably lock contention. Because while I probably have a faster 
> machine anyway, what I see iis:
> 
> 	[torvalds@nehalem linux]$ /usr/bin/time git checkout
> 	0.13user 0.05system 0:00.19elapsed 98%CPU (0avgtext+0avgdata 0maxresident)k
> 	0inputs+0outputs (0major+13334minor)pagefaults 0swaps
> 
> ie my "system" time is _much_ lower than yours (and lower than your system 
> time). This is the 'without patch' time, btw, so this has extra lstat's. 
> And my system time is still lower than my user time, so I wonder where all 
> _your_ system time comes from. Your system time is much more comparable to 
> user time even in the good case, and I wonder why?
> 
> Could be just that kernel code tends to have more cache misses, and my 8MB 
> cache captures it all, and yours doesn't. Regardless, a profile would be 
> very interesting.

Something is definitely up.

I provided timing results for your original preload_cache implementation
which affected status and diff, which was part of the justification for
merging it in.

   http://article.gmane.org/gmane.comp.version-control.git/100998

You can see that cold cache system time for 'git status' went from 0.36 to
0.52 seconds.  Fine.  I just ran it again, and now I'm getting system time
of 10 seconds!  This is the same machine.

Similarly for the cold cache 'git checkout' reruns:

Best without patch: 6.02 (systime 1.57)

  0.43user 1.57system 0:06.02elapsed 33%CPU (0avgtext+0avgdata 0maxresident)k
  5336inputs+0outputs (12major+15472minor)pagefaults 0swaps

Best with patch (preload_cache,lstat reduction): 2.69 (systime 10.47)

  0.45user 10.47system 0:02.69elapsed 405%CPU (0avgtext+0avgdata 0maxresident)k
  5336inputs+0outputs (12major+13985minor)pagefaults 0swaps


OS: Centos4.7

$ cat /proc/version
Linux version 2.6.9-78.0.17.ELsmp (mockbuild@builder16.centos.org) (gcc version 3.4.6 20060404 (Red Hat 3.4.6-9)) #1 SMP Thu Mar 12 20:05:15 EDT 2009

-brandon
