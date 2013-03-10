From: Bernhard Posselt <mail@bernhard-posselt.com>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Sun, 10 Mar 2013 12:45:43 +0100
Message-ID: <513C7267.2090608@bernhard-posselt.com>
References: <5139D76D.80703@bernhard-posselt.com> <20130308212831.GA9217@sigill.intra.peff.net> <513A7D80.5000501@bernhard-posselt.com> <20130309044850.GB12167@sigill.intra.peff.net> <513B14EC.4040504@bernhard-posselt.com> <20130310070505.GA15324@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Mar 10 12:46:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEei4-0003Js-Qr
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 12:46:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751965Ab3CJLqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Mar 2013 07:46:10 -0400
Received: from suou.newyork.w1r3.net ([204.62.14.108]:59329 "EHLO
	suou.newyork.w1r3.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751764Ab3CJLqJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Mar 2013 07:46:09 -0400
Received: from [192.168.1.139] (194-208-147-142.tele.net [194.208.147.142])
	by suou.newyork.w1r3.net (Postfix) with ESMTPSA id 2FCD941A04;
	Sun, 10 Mar 2013 12:46:08 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130221 Thunderbird/17.0.3
In-Reply-To: <20130310070505.GA15324@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217801>

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
First time I've used Archlinux ABS and build from source :)

The log file was empty and it seemed to apply everything nice when 
running valgrind. When i tried to run it without valgrind it failed with 
memory corruption.
Heres the output with debug symbols, fetched with tail -f:

==22291== Invalid write of size 1
==22291==    at 0x4C2DB93: memcpy@@GLIBC_2.14 (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==22291==    by 0x4076B1: update_pre_post_images (in /usr/lib/git-core/git)
==22291==    by 0x40A60F: apply_fragments (in /usr/lib/git-core/git)
==22291==    by 0x40C29F: check_patch_list (in /usr/lib/git-core/git)
==22291==    by 0x40CC35: apply_patch (in /usr/lib/git-core/git)
==22291==    by 0x40F584: cmd_apply (in /usr/lib/git-core/git)
==22291==    by 0x4058E7: handle_internal_command (in /usr/lib/git-core/git)
==22291==    by 0x404DD1: main (in /usr/lib/git-core/git)
==22291==  Address 0x5f245c0 is 0 bytes after a block of size 384 alloc'd
==22291==    at 0x4C2C04B: malloc (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==22291==    by 0x4C2C2FF: realloc (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==22291==    by 0x4F057B: xrealloc (in /usr/lib/git-core/git)
==22291==    by 0x4DDF9F: strbuf_grow (in /usr/lib/git-core/git)
==22291==    by 0x409E9C: apply_fragments (in /usr/lib/git-core/git)
==22291==    by 0x40C29F: check_patch_list (in /usr/lib/git-core/git)
==22291==    by 0x40CC35: apply_patch (in /usr/lib/git-core/git)
==22291==    by 0x40F584: cmd_apply (in /usr/lib/git-core/git)
==22291==    by 0x4058E7: handle_internal_command (in /usr/lib/git-core/git)
==22291==    by 0x404DD1: main (in /usr/lib/git-core/git)
==22291==
==22291== Invalid read of size 1
==22291==    at 0x4C2DCB4: memcpy@@GLIBC_2.14 (in 
/usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==22291==    by 0x40B0D5: apply_fragments (in /usr/lib/git-core/git)
==22291==    by 0x40C29F: check_patch_list (in /usr/lib/git-core/git)
==22291==    by 0x40CC35: apply_patch (in /usr/lib/git-core/git)
==22291==    by 0x40F584: cmd_apply (in /usr/lib/git-core/git)
==22291==    by 0x4058E7: handle_internal_command (in /usr/lib/git-core/git)
==22291==    by 0x404DD1: main (in /usr/lib/git-core/git)
==22291==  Address 0x5f245e1 is not stack'd, malloc'd or (recently) free'd
==22291==
