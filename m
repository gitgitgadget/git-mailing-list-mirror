From: Andreas Ericsson <ae@op5.se>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 07:14:56 +0200
Message-ID: <471448D0.6080200@op5.se>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 07:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhemK-0002Su-6Q
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 07:15:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760032AbXJPFPF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 01:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759970AbXJPFPF
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 01:15:05 -0400
Received: from mail.op5.se ([193.201.96.20]:54621 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758378AbXJPFPB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 01:15:01 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id B26191730744;
	Tue, 16 Oct 2007 07:14:59 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N6KVrnSzKRKd; Tue, 16 Oct 2007 07:14:58 +0200 (CEST)
Received: from nox.op5.se (unknown [172.27.77.30])
	by mail.op5.se (Postfix) with ESMTP id 14AD11730739;
	Tue, 16 Oct 2007 07:14:57 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.5 (X11/20070727)
In-Reply-To: <uodezisvg.fsf@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61078>

Eli Zaretskii wrote:
>> Date: Mon, 15 Oct 2007 20:45:02 -0400 (EDT)
>> From: Daniel Barkalow <barkalow@iabervon.org>
>> cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de, ae@op5.se, 
>>     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
>>
>> I believe the hassle is that readdir doesn't necessarily report a README in 
>> a directory which is supposed to have a README, when it has a readme 
>> instead.
> 
> Sorry I'm asking potentially stupid questions out of ignorance: why
> would you want readdir to return `README' when you have `readme'?
> 

Because it might have been checked in as README, and since git is case
sensitive that is what it'll think should be there when it reads the
directories. If it's not, users get to see

	removed: README
	untracked: readme

and there's really no easy way out of this one, since users on a case-
sensitive filesystem might be involved in this project too, so it
could be an intentional rename, but we don't know for sure. Just
clobbering the in-git file is wrong, but overwriting a file on disk
is wrong too. git tries hard to not ever lose any data for the user.

> 
>>>> - no acceptable level of performance in filesystem and VFS (readdir,
>>>>   stat, open and read/write are annoyingly slow)
>>> With what libraries?  Native `stat' and `readdir' are quite fast.
>>> Perhaps you mean the ported glibc (libgw32c), where `readdir' is
>>> indeed painfully slow, but then you don't need to use it.
>> We want getting stat info, using readdir to figure out what files exist, 
>> for 106083 files in 1603 directories with a hot cache to take under 1s; 
>> otherwise "git status" takes a noticeable amount of time with a medium-big 
>> project, and we want people to be able to get info on what's changed 
>> effectively instantly. My impression is that Windows' native stat and 
>> readdir are plenty fast for what normal Windows programs want, but we 
>> actually expect reasonable performance on an unreasonably-big 
>> metadata-heavy input.
> 
> If that's the issue, then it's not a good idea to call `stat' and
> `readdir' on Windows at all.  `stat' is a single system call on Posix
> systems, while on Windows it usually needs to go out of its way
> calling half a dozen system services to gather the `struct stat' info.
> You need to call something like FindFirstFile, which can do the job of
> `stat' and `readdir' together (and of `fnmatch', if you need to filter
> only some files) in one go.  I don't know whether this will scan 100K
> files under one second (maybe I will try it one of these days), but it
> will definitely be faster than `readdir'+`stat' by maybe as much as an
> order of magnitude.
> 

To be honest though, there are so many places which do the readdir+stat
that I don't think it'd be worth factoring it out, especially since it
*works* on windows. It's just slow, and only slow compared to various
unices. I *think* (correct me if I'm wrong) that git is still faster
than a whole bunch of other scm's on windows, but to one who's used to
its performance on Linux that waiting several seconds to scan 10k files
just feels wrong.


>> We also expect to be able to make a sequence of file system operations 
>> such that programs starting at any time see the same database as the files 
>> containing the database get restructured.
> 
> Sorry, I don't understand this; please tell more about the operations,
> ``the same database'' issue (what database?)

The object database, located under .git/objects.

> and what do you mean by
> ``the files containing the database get restructured''.
> 

/* I'm on a limb here. Nicolas Pitre knows the git packfile format, so
 * perhaps he'll be kind enough to correct me if I'm wrong */

The mmap() stuff is primarily convenient when reading huge packfiles. As
far as I understand it, they're ordered by some sort of delta similarity
score, so mmap()'ing 100MiB or so of a certain packfile will most likely
mean we have a couple of thousand "connected" revisions in memory. That
database gets sort of restructured as the memory-chunk that's mmap()'ed
get moved to read in the next couple of thousand revisions.

In all honesty, this doesn't matter much for already fully packed projects
unless they're significantly larger than the Linux kernel, since git is so
amazingly good at compressing large repos to a small size. Linux is ~180
MiB fully packed, and most developer's systems could just read() that
entire packfile into memory without much problem. But then again, no-one's
ever had problems supporting the "normal" cases.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
