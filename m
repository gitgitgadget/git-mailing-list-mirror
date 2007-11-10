From: bob <kranki@mac.com>
Subject: Re: git packs
Date: Sat, 10 Nov 2007 02:19:13 -0500
Message-ID: <B20E1D71-BCDB-4189-952F-3B809A342870@mac.com>
References: <F6DD8DCD-416B-4DDF-B384-7213C9ED5565@mac.com> <alpine.LFD.0.9999.0711100011150.21255@xanadu.home> <FC175E4F-D9BE-42CC-B0BB-561B2EDCD941@mac.com> <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 10 08:19:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iqkd1-0007x7-TB
	for gcvg-git-2@gmane.org; Sat, 10 Nov 2007 08:19:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbXKJHTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Nov 2007 02:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbXKJHTZ
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Nov 2007 02:19:25 -0500
Received: from smtpoutm.mac.com ([17.148.16.75]:55497 "EHLO smtpoutm.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbXKJHTY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Nov 2007 02:19:24 -0500
Received: from mac.com (asmtp002-s [10.150.69.65])
	by smtpoutm.mac.com (Xserve/smtpout012/MantshX 4.0) with ESMTP id lAA7JNbn024128
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 23:19:24 -0800 (PST)
Received: from [192.168.2.23] (c-66-176-54-4.hsd1.fl.comcast.net [66.176.54.4])
	(authenticated bits=0)
	by mac.com (Xserve/asmtp002/MantshX 4.0) with ESMTP id lAA7JKkF001230
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO)
	for <git@vger.kernel.org>; Fri, 9 Nov 2007 23:19:21 -0800 (PST)
In-Reply-To: <alpine.LFD.0.999.0711092211250.15101@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64314>

I will try a few things and see if I can get a script put together
that generates the inflate problem.  The data that I am
using is a backup of my original repository.  So, I can
play all that I want.  But it would be a lot easier if I
could just generate some files using dd or something.

I'll also try the 64-bit compile on my Mac Pro and see
if it works.

My only reason for keeping this directory under git is
that I find git so easy to work with across multiple
machines.  I own 10+ computers and I use git to
provide easy transfers/updates from machine to
machine normally without any issues and a great
deal of reliability.

This directory is a website that I use
internally to keep track of things important to me.
For instance, the one large file is a movie of the
inside of my house before they sheet-rocked it
so that later I would have an easier time finding
things in the walls.  There is some html and php
that I wrote in it which I did want versioned.

Maybe I should just drop back to using two
directories, one of the large files which are
static anyway and a git repo for the html and php.
I was just trying to keep everything in the
repo for simplicity.

No matter which direction that I decide, I will still
try to provide the script.  Thank you both (Luke Lu)
for the feedback.


On Nov 10, 2007, at 1:38 AM, Linus Torvalds wrote:

>
>
> On Sat, 10 Nov 2007, bob wrote:
>>
>> The reason that I ask is that I have been playing different
>> scenarios using git 1.5.3.5 under MacOSX 10.4.10 mostly
>> all day and every time that
>>
>> A) 	a file approaches or exceeds 2gig on an 'add', it
>> 	results in:
>> 		fatal: Out of memory? mmap failed: Cannot allocate memory
>
> Git wants to handle single files as one single entity, so single  
> big files
> really do end up being very painful. The costs of compressing them and
> generating deltas would probably get prohibitively high *anyway*,  
> but it
> does mean that if you have gigabyte files, you do want a 64-bit VM.
>
> I thought OS X could do 64 bits these days. Maybe not.
>
> Anyway, that explains the "cannot allocate memory". Git simply  
> wants to
> mmap the whole file. You don't have enough VM space for it.
>
> (And if you seriously want to work with multi-gigabyte files, git  
> probbaly
> isn't going to perform wonderfully well, even if it *should* work  
> fine if
> you just have a full 64-bit environment that allows the mmap).
>
>> B) 	the repository size less the .git subdirectory approaches
>> 	4gig on a 'fetch' it results in:
>>
>> 	Resolving 3356 deltas...
>> 	fatal: serious inflate inconsistency: -3 (unknown compression  
>> method)
>
> That sounds really broken. I'm not seeing what would cause that, apart
> from some really bad data corruption and/or broken zlib  
> implementation.
> But if the pack-file really is 2GB+ in size, I could imagine some sign
> issues cropping up.
>
> git will generally use "unsigned long" (which is probably just 32- 
> bit on
> your setup), but since git in those circumstances would be limited  
> by the
> size of the VM _anyway_, that's not really much of a limitation  
> (although
> probably broken on the crazy Windows "LLP64" model). But maybe we have
> some place where we use a signed thing, or zlib does, and I could  
> see that
> causing breakage.
>
> But that code-sequence really should never even come *close* to the  
> 31-bit
> limit, as long as the individual objects themselves aren't bigger  
> than the
> available VM space (and git currently assumes "unsigned long" is
> sufficiently big to cover the VM space, which is not technically  
> correct,
> but should be fine on OS X too).
>
> That said, we should use "off_t" in that function. I suspect we have a
> number of people (read: me) who have grown too used to living in a  
> 64-bit
> world..
>
>> I have been testing on my laptop which has a 32-bit Intel Core Duo.
>
> Ok, so you're 32-bit limited even if there is were to be some 64-bit
> support for OS X.
>
>> Also, I have run the same tests on a dual quad-core Intel processor
>> which is 64 bit, (but not sure that Apple uses the 64 bits in  
>> 10.4.10).  I
>> get the same results as above.
>
> I'm pretty sure OS X defaults to a 32-bit environment, but has at  
> least
> *some* 64-bit support. It would definitely need to be enabled  
> explicitly
> (since they made the *insane* decision to move over to Intel laptop  
> chips
> six months before they got 64-bit support! Somebody at Apple is a  
> total
> idiot, and should get fired).
>
> So it would be interesting to hear if a 64-bit build would make a
> difference.
>
>> The zlib is at the latest revision of 1.2.3 and gcc is at 4.0.1
>> which from what I can tell supports large files, because 'off_t'  
>> is 8 bytes
>> which is the size used for a 'stat' file size.
>
> See above: single files are size-limited, but with a large off_t like
> yours, you should be fine. Except we may have screwed up.
>
>> I am just wondering if these size limitations exist for MacOSX
>> or maybe I am doing something wrong (which is probably
>> the case).
>
> We *have* had issues with broken implementations of "pread()" on some
> systems.
>
> You could try setting NO_PREAD in the Makefile and compiling with the
> compatibility function.. That's the only thing that comes to mind  
> as being
> worth trying in that area.
>
> And if you have some script to generate the repository (ie you aren't
> using "live data", but are testing the limits of the system), if  
> you can
> make that available, so that people with non-OSX environments can  
> test,
> that would be interesting..
>
> I certainly have some 32-bit environments too (old linux boxes),  
> but I'm
> too lazy to write a test-case, so I was hoping you'd be using some  
> simple
> scripts that I could just test and see if I can see the behaviour you
> describe myself.
>
> That said, I have worked with a 3GB pack-file (one of the KDE trial
> repos). That worked fine. But git does tend to want a *lot* of  
> memory for
> really big repositories, so I suspect that if you actually work  
> with 2GB+
> pack-files, you'll be wanting a 64-bit environment just because  
> you'll be
> wanting more than 2GB of physical RAM in order to be able to access it
> efficiently.
>
> 			Linus
