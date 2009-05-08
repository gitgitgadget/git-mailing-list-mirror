From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re:
Date: Fri, 8 May 2009 14:49:50 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0905081432150.4983@localhost.localdomain>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504>
 <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com>
 <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain> <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain> <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil>
 <OWEdfN5mNBoNl1TcdOvhhNfi_nLsao-aFrHkz_rNtuX_4lqXHisfcQ@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Fri May 08 23:52:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Xzp-0000sT-9p
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 23:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755063AbZEHVwW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 17:52:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754210AbZEHVwV
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 17:52:21 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:40581 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751176AbZEHVwV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 8 May 2009 17:52:21 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48Lnp3O017584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 8 May 2009 14:50:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n48LnoCC021748;
	Fri, 8 May 2009 14:49:51 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <OWEdfN5mNBoNl1TcdOvhhNfi_nLsao-aFrHkz_rNtuX_4lqXHisfcQ@cipher.nrlssc.navy.mil>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.462 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118633>



On Fri, 8 May 2009, Brandon Casey wrote:
> 
> Before (cold cache):
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  98.60    6.365501         111     57432           lstat64
> 
> After (cold cache, no lstat fix, just cache_preload):
> % time     seconds  usecs/call     calls    errors syscall
> ------ ----------- ----------- --------- --------- ----------------
>  90.90   23.717981         413     57432           lstat64

Yes, interesting. I really smells like it's all fixed performance and 
there is a single lock around it. That 111us -> 413us increase is very 
consistent with four cores all serializing on the same lock. So it 
parallelizes to all four cores, but then will take exactly as long in 
total.

Quite frankly, 2.6.9 is so old that I have absolutely _no_ memory of what 
we used to do back then. Not that I follow NFS all that much even now - I 
did some of the original page cache and dentry work on the Linux NFS 
client way back when, but that was when I actually used NFS (and we were 
converting everything to the page cache).

I've long since forgotten everything I knew, and I'm just as happy about 
that. But clearly something is bad, and equally clearly it worked much 
better for you a couple of months ago. Which does imply that there's 
probably some centos issues.

Can you ask your MIS people if it would be possible to at least _test_ a 
new kernel? In 2.6.9, I'm quite frankly inclined to just say "it will 
likely never get fixed unless centos knows what it is", but if you test a 
more modern kernel and see similar issues, then I'll be intrigued.

It's kind of sad, but at the same time, NFS was using the BKL up into 
2.6.26 or something like that (about a year ago). And your kernel is 
based on something _much_ older.

That said, even with the BKL, NFS should allow all the actual IO to be 
done in parallel (since the BKL is dropped on scheduling). But it's really 
wasting a _lot_ of CPU time, and that hurts you enormously, even though 
the cold-cache case still seems to win, judging by your other email:

> Best without patch: 6.02 (systime 1.57)
> 
>   0.43user 1.57system 0:06.02elapsed 33%CPU (0avgtext+0avgdata 0maxresident)k
>   5336inputs+0outputs (12major+15472minor)pagefaults 0swaps
> 
> Best with patch (preload_cache,lstat reduction): 2.69 (systime 10.47)
> 
>   0.45user 10.47system 0:02.69elapsed 405%CPU (0avgtext+0avgdata 0maxresident)k
>   5336inputs+0outputs (12major+13985minor)pagefaults 0swaps

so there's a _huge_ increase in system time (again), but the change from 
33% CPU -> 405% CPU makes up for it and you get lower elapsed times.

But that 7x increase in system time really is sad. I do suspect it's 
likely due to spinning on the BKL. And if so, then a modern kernel should 
fix it.

			Linus
