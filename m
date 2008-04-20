From: Roman Shaposhnik <rvs@sun.com>
Subject: Re: Git performance on OS X
Date: Sat, 19 Apr 2008 17:21:13 -0700
Message-ID: <F9D9143D-D849-4454-91CD-024D691652C3@sun.com>
References: <1208633300-74603-1-git-send-email-pdebie@ai.rug.nl>
 <alpine.LFD.1.10.0804191443550.2779@woody.linux-foundation.org>
 <FEFAB19F-742A-452E-87C1-CD55AD0996DB@ai.rug.nl>
 <m3od85qxcl.fsf@localhost.localdomain>
 <alpine.LFD.1.10.0804191547320.2779@woody.linux-foundation.org>
 <alpine.LFD.1.10.0804191551540.2779@woody.linux-foundation.org>
 <0BE9BBE3-EA9D-4A66-A086-A2A1B289B0DD@ai.rug.nl>
 <alpine.LFD.1.10.0804191619240.2779@woody.linux-foundation.org>
 <A07C1A99-084B-4DFC-90CB-B8BDAF7E72EF@sun.com>
 <alpine.LFD.1.10.0804191658430.2779@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; delsp=yes; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Apr 20 02:22:06 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JnNJl-0004nW-Fq
	for gcvg-git-2@gmane.org; Sun, 20 Apr 2008 02:22:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753224AbYDTAVT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Apr 2008 20:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753015AbYDTAVT
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Apr 2008 20:21:19 -0400
Received: from brmea-mail-3.Sun.COM ([192.18.98.34]:39254 "EHLO
	brmea-mail-3.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYDTAVS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Apr 2008 20:21:18 -0400
Received: from fe-amer-10.sun.com ([192.18.109.80])
	by brmea-mail-3.sun.com (8.13.6+Sun/8.12.9) with ESMTP id m3K0LIGj020454
	for <git@vger.kernel.org>; Sun, 20 Apr 2008 00:21:18 GMT
Received: from conversion-daemon.mail-amer.sun.com by mail-amer.sun.com
 (Sun Java System Messaging Server 6.2-8.04 (built Feb 28 2007))
 id <0JZL00L01KWV3X00@mail-amer.sun.com> (original mail from rvs@sun.com)
 for git@vger.kernel.org; Sat, 19 Apr 2008 18:21:18 -0600 (MDT)
Received: from [192.168.0.100] ([129.150.64.18])
 by mail-amer.sun.com (Sun Java System Messaging Server 6.2-8.04 (built Feb 28
 2007)) with ESMTPSA id <0JZL0096KKZFIME0@mail-amer.sun.com>; Sat,
 19 Apr 2008 18:21:18 -0600 (MDT)
In-reply-to: <alpine.LFD.1.10.0804191658430.2779@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79940>

On Apr 19, 2008, at 5:06 PM, Linus Torvalds wrote:
> On Sat, 19 Apr 2008, Roman Shaposhnik wrote:
>>>
>>> Is there any system-level profiler for OS X to get a clue where  
>>> that cost
>>> is, in case it's not the lstat() at all?
>>
>> If it happens on Leopard, DTrace would be a perfect way to query  
>> the system:
>
> Well, I'd really like to see a traditional _time_ profile, not system
> call counts.

Good point. I just thought your original question was simply about  
confirming
a hunch of an enormous # of lstat syscalls. Now, if by _time_ profile
you mean how much time gets spent in each syscall than the following
should help (time is in nanoseconds):

$ dtrace -n 'syscall::*:entry /pid==$target/ { self->ts=timestamp; }  
syscall::*:return /pid==$target/ { @[probefunc]=sum(timestamp-self- 
 >ts); }' -c "echo Hello World"
dtrace: description 'syscall::*:entry ' matched 468 probes
Hello World
dtrace: pid 1400 has exited

   getpid                                                         1392
   sysi86                                                         2799
   getrlimit                                                      2918
   setcontext                                                     4273
   fstat64                                                        6220
   mmap                                                          15419
   munmap                                                        22593
   write                                                         27860
   ioctl                                                         30750

The script can be modified slightly to also profile all of the libc.

On the other hand, if by real system profile you mean a full fledged
sampling of the application itself than I can suggest running Git
under Shark, and not under Instruments. Although I'm extremly
curious about *why* would you need a full fledged *application*
level profile of Git as opposed to a profile of how Git interacts
with an OS.

> The system call profile is trivial - it's generally going to be pretty
> similar under OS X and Linux (modulo library differences, but git  
> doesn't
> really use any really complex libraries that would do system calls).
>
> The problem we've had in the past is that Linux is simply an order of
> magnitude faster (sometimes more) at some operations than OS X is, so
> issues that show up on OS X don't even show up on Linux.
>
> This was the case for doing lots of small "mmap()/munmap()" calls, for
> example, where we literally had a load where OS X was two orders of
> magnitude slower. We switched over to reading the files with "pread()"
> instead of mmap(), and that fixed that particular issue.

Totally understood!

Thanks,
Roman.
