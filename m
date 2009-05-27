From: Andreas Ericsson <ae@op5.se>
Subject: Re: Problem with large files on different OSes
Date: Wed, 27 May 2009 16:22:54 +0200
Message-ID: <4A1D4CBE.1010905@op5.se>
References: <submission.1M9Gk0-0000N8-MQ@mail.cs.st-andrews.ac.uk> <C933C1BA-0170-4469-8099-2C0E95C61D24@dbservice.com> <submission.1M9JpE-0005AW-92@mail.cs.st-andrews.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Tomas Carnecky <tom@dbservice.com>, git@vger.kernel.org
To: Christopher Jefferson <caj@cs.st-andrews.ac.uk>
X-From: git-owner@vger.kernel.org Wed May 27 16:23:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9K2E-0000KW-HB
	for gcvg-git-2@gmane.org; Wed, 27 May 2009 16:23:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758111AbZE0OXF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2009 10:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756099AbZE0OXD
	(ORCPT <rfc822;git-outgoing>); Wed, 27 May 2009 10:23:03 -0400
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:39730 "HELO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755360AbZE0OXB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 May 2009 10:23:01 -0400
Received: from source ([72.14.220.156]) by na3sys009aob109.postini.com ([74.125.148.12]) with SMTP
	ID DSNKSh1MvxmHoNBFm4bBSpnWGcHcj7vVK6zE@postini.com; Wed, 27 May 2009 07:22:56 PDT
Received: by fg-out-1718.google.com with SMTP id e12so1745458fga.10
        for <git@vger.kernel.org>; Wed, 27 May 2009 07:22:54 -0700 (PDT)
Received: by 10.86.4.7 with SMTP id 7mr220008fgd.46.1243434174744;
        Wed, 27 May 2009 07:22:54 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id 3sm2679029fge.19.2009.05.27.07.22.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 27 May 2009 07:22:53 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <submission.1M9JpE-0005AW-92@mail.cs.st-andrews.ac.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120069>

Christopher Jefferson wrote:
> 
> On 27 May 2009, at 15:01, Tomas Carnecky wrote:
> 
>>>
>>> The problem appears to be the different maximum mmap sizes available 
>>> on different OSes. Whic I don't really mind the maximum file size 
>>> restriction git imposes, this restriction varying from OS to OS is 
>>> very annoying, fixing this required rewriting history to remove the 
>>> commit, which caused problems as the commit had already been pulled, 
>>> and built on, by a number of developers.
>>>
>>> If the requirement that all files can be mmapped cannot be easily 
>>> removed, would be it perhaps be acceptable to impose a (soft?) 
>>> 1GB(ish) file size limit? I suggest 1GB as all the OSes I can get 
>>> hold of easily (freeBSD, windows, Mac OS X, linux) support a mmap of 
>>> size > 1GB.
>>
>> I think this is a limitation of a 32bit build of git. I just tried 
>> with a 64bit build and it added the file just fine. The compiler on 
>> MacOSX (gcc) produces 32bit builds by default, even if the system 
>> supports 64bit executables. But gcc on 64bit Linux (at least the 
>> installations I have at home) produces a 64bit executables by default. 
>> Solaris/OpenSolaris behaves like MacOSX, no idea about *BSD or 
>> Windows. Maybe this is why git works on Linux but not MacOSX even on 
>> the same hardware.
>> Btw, I built git with: make install prefix=... CC="gcc -m64", no 
>> modifications needed (MacOSX 10.5.7).
> 
> The git installs I am using are all 32bit, this machine doesn't have a 
> 64bit processor (it is one of the few macs released without one). It's 
> nice to know long term this problem will go away, that all suggests 
> introducing some limit is not approriate, as while 32bit users have some 
> arbitary limit above which they cannot go, I am sure all 64-bit OSes 
> will manage to easily mmap any file. Of course warning such users they 
> are producing packs that are not going to work on 32bit compiles of git 
> isn't a stupid idea.
> 

mmap()'ing large files (> 4GB) work just fine on Linux. You can't mmap()
more than 4GB at a time though (I think; I didn't try), but since we
don't do that anyway I doubt that was the problem.

The file you produced with your dd command should have ended up being
1239MB, or 1.21GB, so the real hard limit for MacOSX seem to be 1GB
if, indeed, there is one. On the other hand, the error message you
got ("fatal: Out of memory, malloc failed") seems to indicate the
system actually had no memory left when you tried to garbage-collect
your repository. Are you using a dual-core system? If so, please try
again with

   pack.threads = 1

set in the .git/config file of that particular repository. Each
thread will allocate roughly the same amount of memory, so if
both of them had to handle that huge blob at the same time, they'd
have exploded memory usage up to 1.3GB + the compressed size of
them + DAG-bookkeeping etc etc.

I'm guessing we'd have seen error reports from other OSX users
if it was actually impossible to mmap() 1GB files in git on OSX.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
