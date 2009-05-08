From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re:
Date: Fri, 08 May 2009 18:04:52 -0500
Message-ID: <twBG1KnSrgPNk7NoVey4mgig1BeAk7e1GHOT90PSV9ZGTs-zCWYdtA@cipher.nrlssc.navy.mil>
References: <454B76988CBF42F5BCACA5061125D263@caottdt504> <81b0412b0905071013y241f7eas8417127e51ff52fa@mail.gmail.com> <D75C0FA80F7041FFAAC50B314788AD6F@caottdt504> <alpine.LFD.2.01.0905071148500.4983@localhost.localdomain> <A07C3E66E84D46ACB37EDC7D396CCA62@caottdt504> <alpine.LFD.2.01.0905071248250.4983@localhost.localdomain> <alpine.LFD.2.01.0905071312000.4983@localhost.localdomain> <alpine.LFD.2.01.0905071446500.4983@localhost.localdomain> <81b0412b0905080117v3aad0c44o7b3bbcc7fe70d3b1@mail.gmail.com> <alpine.LFD.2.01.0905080734260.4983@localhost.localdomain> <eFUCK0_CEtLa6Qvg6X1SqHmCgRnY3_3dy3OCJK26lGP-_kDRyWtlRA@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905080857130.4983@localhost.localdomain> <Ah7lj3UWxgwxNiQs6kqiiVurulv4F00ssWrb3OzfTrXYlK8ZBCSBOQ@cipher.nrlssc.navy.mil> <OWEdfN5mNBoN
 l1TcdOvhhNfi_nLsao-aFrHkz_rNtuX_4lqXHisfcQ@cipher.nrlssc.navy.mil> <alpine.LFD.2.01.0905081432150.4983@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Bevan Watkiss <bevan.watkiss@cloakware.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 09 01:06:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2Z9B-0003bw-Lt
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 01:06:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752663AbZEHXGL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2009 19:06:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbZEHXGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 8 May 2009 19:06:09 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57622 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbZEHXGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2009 19:06:08 -0400
Received: by mail.nrlssc.navy.mil id n48N4qpU020846; Fri, 8 May 2009 18:04:52 -0500
In-Reply-To: <alpine.LFD.2.01.0905081432150.4983@localhost.localdomain>
X-OriginalArrivalTime: 08 May 2009 23:04:52.0884 (UTC) FILETIME=[65556540:01C9D031]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118638>

Linus Torvalds wrote:
> 
> On Fri, 8 May 2009, Brandon Casey wrote:
>> Before (cold cache):
>> % time     seconds  usecs/call     calls    errors syscall
>> ------ ----------- ----------- --------- --------- ----------------
>>  98.60    6.365501         111     57432           lstat64
>>
>> After (cold cache, no lstat fix, just cache_preload):
>> % time     seconds  usecs/call     calls    errors syscall
>> ------ ----------- ----------- --------- --------- ----------------
>>  90.90   23.717981         413     57432           lstat64
> 
> Yes, interesting. I really smells like it's all fixed performance and 
> there is a single lock around it. That 111us -> 413us increase is very 
> consistent with four cores all serializing on the same lock. So it 
> parallelizes to all four cores, but then will take exactly as long in 
> total.

Makes sense to me.

> Quite frankly, 2.6.9 is so old that I have absolutely _no_ memory of what 
> we used to do back then. Not that I follow NFS all that much even now - I 
> did some of the original page cache and dentry work on the Linux NFS 
> client way back when, but that was when I actually used NFS (and we were 
> converting everything to the page cache).
> 
> I've long since forgotten everything I knew, and I'm just as happy about 
> that. But clearly something is bad, and equally clearly it worked much 
> better for you a couple of months ago. Which does imply that there's 
> probably some centos issues.

In case you're not aware CentOS is just repacked RHEL.  I'm not sure if
centos has the resources for investigating problems.  We also have RHEL
licenses, so hopefully I'll be able to come up with something to submit
to them.

> Can you ask your MIS people if it would be possible to at least _test_ a 
> new kernel? In 2.6.9, I'm quite frankly inclined to just say "it will 
> likely never get fixed unless centos knows what it is", but if you test a 
> more modern kernel and see similar issues, then I'll be intrigued.

I think it's possible.  Just not on this specific machine.  Not sure what
we have lying around multi-processor wise.  Also, it won't happen until
next week since it's late Friday afternoon here.

btw, I've since done some more testing on some centos5.3 boxes we have.
I get similar results (less ancient kernel 2.6.18).  I've also scanned
through the errata announcements that RedHat has released for their
kernel updates.  A few of them involve NFS.  Possibly, whatever RedHat
modified in the 5.X kernel was also backported to the 4.X kernel.

> It's kind of sad, but at the same time, NFS was using the BKL up into 
> 2.6.26 or something like that (about a year ago). And your kernel is 
> based on something _much_ older.
> 
> That said, even with the BKL, NFS should allow all the actual IO to be 
> done in parallel (since the BKL is dropped on scheduling). But it's really 
> wasting a _lot_ of CPU time, and that hurts you enormously, even though 
> the cold-cache case still seems to win, judging by your other email:
>
>> Best without patch: 6.02 (systime 1.57)
>>
>>   0.43user 1.57system 0:06.02elapsed 33%CPU (0avgtext+0avgdata 0maxresident)k
>>   5336inputs+0outputs (12major+15472minor)pagefaults 0swaps
>>
>> Best with patch (preload_cache,lstat reduction): 2.69 (systime 10.47)
>>
>>   0.45user 10.47system 0:02.69elapsed 405%CPU (0avgtext+0avgdata 0maxresident)k
>>   5336inputs+0outputs (12major+13985minor)pagefaults 0swaps
> 
> so there's a _huge_ increase in system time (again), but the change from 
> 33% CPU -> 405% CPU makes up for it and you get lower elapsed times.
> 
> But that 7x increase in system time really is sad. I do suspect it's 
> likely due to spinning on the BKL. And if so, then a modern kernel should 
> fix it.

Thanks, I'll try to test next week.

-brandon
