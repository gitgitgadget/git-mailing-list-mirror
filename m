From: Bernhard Posselt <mail@bernhard-posselt.com>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Sun, 10 Mar 2013 12:04:58 +0100
Message-ID: <513C68DA.8060700@bernhard-posselt.com>
References: <5139D76D.80703@bernhard-posselt.com> <20130308212831.GA9217@sigill.intra.peff.net> <513A7D80.5000501@bernhard-posselt.com> <20130309044850.GB12167@sigill.intra.peff.net> <513B14EC.4040504@bernhard-posselt.com> <20130310070505.GA15324@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 10 12:05:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEe4f-0005K2-1h
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 12:05:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3CJLF0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 07:05:26 -0400
Received: from suou.newyork.w1r3.net ([204.62.14.108]:59327 "EHLO
	suou.newyork.w1r3.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751282Ab3CJLFZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 07:05:25 -0400
Received: from [192.168.1.139] (194-208-147-142.tele.net [194.208.147.142])
	by suou.newyork.w1r3.net (Postfix) with ESMTPSA id CAB9241A04;
	Sun, 10 Mar 2013 12:05:23 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130310070505.GA15324@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217798>

On 03/10/2013 08:05 AM, Jeff King wrote:
> On Sat, Mar 09, 2013 at 11:54:36AM +0100, Bernhard Posselt wrote:
>
>>> Also, I can almost reproduce here, as PatrickHeller/core.git is public.
>>> However, I suspect the problem is particular to your work built on top,
>>> which looks like it is at commit 0525bbd73c9015499ba92d1ac654b980aaca35b2.
>>> Is it possible for you to make that commit available on a temporary
>>> branch?
>> What do you mean exactly by that?
> I just meant to push the work from your local repository somewhere where
> I could access it to try to replicate the issue. What you did here:
>
>> git clone https://github.com/Raydiation/memorycorruption
>> cd memorycorruption
>> git pull --rebase https://github.com/Raydiation/core
> ...should be plenty. Unfortunately, I'm not able to reproduce the
> segfault.  All of the patches apply fine, both normally and when run
> under valgrind.
>
>> Heres the output of the GIT_TRACE file
>> [...]
>> trace: built-in: git 'apply' '--index' '/srv/http/owncloud/.git/rebase-apply/patch'
> This confirms my suspicion that the problem is in "git apply".
>
> You had mentioned before that the valgrind log was very long.  If you're
> still able to reproduce, could you try running it with valgrind like
> this:
>
>    valgrind -q --trace-children=yes --log-file=/tmp/valgrind.out \
>      git pull --rebase https://github.com/Raydiation/core
>
> Logging to a file instead of stderr should mean we still get output for
> commands that are invoked with their stderr redirected (which is the
> case for the "git apply" in question), and using "-q" should eliminate
> the uninteresting cruft from the log.
>
> -Peff
Do you need debug symbols?

==2395== Invalid write of size 1
==2395==    at 0x4C2DB93: memcpy@@GLIBC_2.14 (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==2395==    by 0x4076B1: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40A60F: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40C29F: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40CC35: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40F584: ??? (in /usr/lib/git-core/git)
==2395==    by 0x4058E7: ??? (in /usr/lib/git-core/git)
==2395==    by 0x404DD1: ??? (in /usr/lib/git-core/git)
==2395==    by 0x58F3A14: (below main) (in /usr/lib/libc-2.17.so)
==2395==  Address 0x5f245c0 is 0 bytes after a block of size 384 alloc'd
==2395==    at 0x4C2C04B: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==2395==    by 0x4C2C2FF: realloc (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==2395==    by 0x4F057B: ??? (in /usr/lib/git-core/git)
==2395==    by 0x4DDF9F: ??? (in /usr/lib/git-core/git)
==2395==    by 0x409E9C: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40C29F: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40CC35: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40F584: ??? (in /usr/lib/git-core/git)
==2395==    by 0x4058E7: ??? (in /usr/lib/git-core/git)
==2395==    by 0x404DD1: ??? (in /usr/lib/git-core/git)
==2395==    by 0x58F3A14: (below main) (in /usr/lib/libc-2.17.so)
==2395==
==2395== Invalid read of size 1
==2395==    at 0x4C2DCB4: memcpy@@GLIBC_2.14 (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==2395==    by 0x40B0D5: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40C29F: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40CC35: ??? (in /usr/lib/git-core/git)
==2395==    by 0x40F584: ??? (in /usr/lib/git-core/git)
==2395==    by 0x4058E7: ??? (in /usr/lib/git-core/git)
==2395==    by 0x404DD1: ??? (in /usr/lib/git-core/git)
==2395==    by 0x58F3A14: (below main) (in /usr/lib/libc-2.17.so)
==2395==  Address 0x5f245e1 is not stack'd, malloc'd or (recently) free'd
==2395==
