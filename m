From: Andreas Ericsson <ae@op5.se>
Subject: Re: out of memory problem
Date: Tue, 23 Sep 2008 09:50:15 +0200
Message-ID: <48D89FB7.3000509@op5.se>
References: <alpine.LFD.2.00.0809211556030.19373@homelinux>	 <48D749F7.3030008@op5.se> <4120f6ec0809220828i3b38eda3tfc4974df8a2568cb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git mailing list <git@vger.kernel.org>
To: guo tang <tangguo77@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 23 09:51:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki2gE-0001ka-9L
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 09:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751911AbYIWHuV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 03:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbYIWHuV
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 03:50:21 -0400
Received: from mail.op5.se ([193.201.96.20]:42980 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751755AbYIWHuU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 03:50:20 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id DF6CD1B80081;
	Tue, 23 Sep 2008 09:40:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.209
X-Spam-Level: 
X-Spam-Status: No, score=-4.209 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.190, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 68sqEf1cOL6z; Tue, 23 Sep 2008 09:40:46 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 3226C1B80051;
	Tue, 23 Sep 2008 09:40:46 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <4120f6ec0809220828i3b38eda3tfc4974df8a2568cb@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96532>

guo tang wrote:
> On Mon, Sep 22, 2008 at 12:32 AM, Andreas Ericsson <ae@op5.se> wrote:
> 
>> Guo Tang wrote:
>>
>>> Gentlemen,
>>>
>>> I try to run "git gc" on linux kernel tree. The virtual memory keeps going
>>> up until over 3GB, then crash. Tried twice with the v1.6.0.2, same result.
>>> Then I used the git coming with FC9 (v1.5.5.1), the peak virutal memory
>>> usage is about 1.5GB. "git gc" finished without any trouble.
>>> Could there be a memory leak in v1.6.0.2?
>>>
>>>
>> There could be, but most likely it's commit
>> 38bd64979a2a3ffa178af801c6a62e6fcd658274 (Enable threaded delta
>> search on BSD and Linux). Do you have multiple cpu's in the
>> computer where 'git gc' was running? If so, and if you've set
>> pack.threads = 0, or --threads=0 it will autodetect the number
>> of CPU's you have and then saturate all of them with work. Each
>> thread will however consume memory close to that of a single
>> process running the repack, so for large repositories you might
>> want to set pack.threads = 1 in such large repositories.
> 
> 
> It is a Pentium M single core machine. But I am not sure whether it is using
> just a single thread or
> multiple threads. I will  try setting pack.threads parameter next I run into
> trouble.
> 

Unless you explicitly told it to run multiple threads (which
would be a bit silly on a single-core machine), it just ran
one thread.

>> It's a shame you didn't save the unpacked repository, or this could
>> have been properly debugged. While it's possible there is a memory
>> leak, it's a dismal project trying to locate it by staring at the
>> code, and the time it takes to repack huge repositories with memory
>> intensive parameters is sort of prohibitive for finding the possible
>> leak by bisection.
> 
> 
> Yes, the repository is already packed now. One question, beside the
> bisecting method, do we have
> this ability built into kernel:
> 1. Turn a flag on for a process.
> 2. OS will keep track off process malloc(), free() calls and the call stack.
> 
> 3. For the malloc() calls without the the free() call (a memory leak), OS
> will keep it count based on malloc() call stack.
> 4. After some time, be able to dump this information out based on biggest
> leak spot.
> 

No, there's not. The kernel isn't the one handing out the memory when you
call malloc(). That's handled by the C library, which can (and usually does)
allocate a larger area of memory than the application needs, so that it
doesn't have to run a system call for every malloc() call you do.

You can pre-load a different memory allocator though, which can do whatever
it wants with calls to malloc(), including ofcourse logging which function
called them and how much memory was requested.

Google for "memory leak check linux" and you'll get something like 750000
results.


> The complain when I ran out of memory if from mmap failure. Is it the same
> as malloc() failure?
> 

Sort of. Read 'man 2 mmap' for a more exhaustive description.

> This kind of tool is available in Windows with its umdh (user mode heap
> dump) tool.
> 

There are a number of tools to detect leaks under Linux/Unix as well.
valgrind is probably the most frequently used of all such leak checkers.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
