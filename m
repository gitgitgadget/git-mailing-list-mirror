From: Bernhard Posselt <mail@bernhard-posselt.com>
Subject: Re: Memory corruption when rebasing with git version 1.8.1.5 on arch
Date: Tue, 19 Mar 2013 11:42:45 +0100
Message-ID: <51484125.9000307@bernhard-posselt.com>
References: <5139D76D.80703@bernhard-posselt.com> <20130308212831.GA9217@sigill.intra.peff.net> <513A7D80.5000501@bernhard-posselt.com> <20130309044850.GB12167@sigill.intra.peff.net> <513B14EC.4040504@bernhard-posselt.com> <20130310070505.GA15324@sigill.intra.peff.net> <513C7267.2090608@bernhard-posselt.com> <20130311051840.GB13510@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 19 11:43:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UHu15-0000s4-5m
	for gcvg-git-2@plane.gmane.org; Tue, 19 Mar 2013 11:43:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839Ab3CSKnM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Mar 2013 06:43:12 -0400
Received: from suou.newyork.w1r3.net ([204.62.14.108]:59349 "EHLO
	suou.newyork.w1r3.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765Ab3CSKnL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Mar 2013 06:43:11 -0400
Received: from [192.168.2.152] (p549270AF.dip.t-dialin.net [84.146.112.175])
	by suou.newyork.w1r3.net (Postfix) with ESMTPSA id E6C5241A0D;
	Tue, 19 Mar 2013 11:43:10 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
In-Reply-To: <20130311051840.GB13510@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218499>

Ok, sorrry for not responsding for quite a while, we had the 5.0 release and had too much to do.

I found out why it segfaults: I had a .gitconfig file (sry must have somehow missed that no idea why actually) with the following contents:

http://dpaste.com/1027662/

it seems that the memory corruption does not happen anymore when i change

[apply]
         whitespace = fix

to

[apply]
         #whitespace = fix


so fixing whitespaces may be the culprit

On 03/11/2013 06:18 AM, Jeff King wrote:
> On Sun, Mar 10, 2013 at 12:45:43PM +0100, Bernhard Posselt wrote:
>
>>>    valgrind -q --trace-children=yes --log-file=/tmp/valgrind.out \
>>>      git pull --rebase https://github.com/Raydiation/core
>> The log file was empty and it seemed to apply everything nice when
>> running valgrind. When i tried to run it without valgrind it failed
>> with memory corruption.
> Thanks, we are maybe getting closer. It's weird that it works OK with
> valgrind. If the valgrind log is empty, though, I'm confused about where
> the output you pasted below came from.
>
>> ==22291== Invalid write of size 1
>> ==22291==    at 0x4C2DB93: memcpy@@GLIBC_2.14 (in
>> /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
>> ==22291==    by 0x4076B1: update_pre_post_images (in /usr/lib/git-core/git)
>> ==22291==    by 0x40A60F: apply_fragments (in /usr/lib/git-core/git)
>> ==22291==    by 0x40C29F: check_patch_list (in /usr/lib/git-core/git)
>> ==22291==    by 0x40CC35: apply_patch (in /usr/lib/git-core/git)
>> ==22291==    by 0x40F584: cmd_apply (in /usr/lib/git-core/git)
>> ==22291==    by 0x4058E7: handle_internal_command (in /usr/lib/git-core/git)
>> ==22291==    by 0x404DD1: main (in /usr/lib/git-core/git)
> Hmm, it would be nice to have line numbers. Can you try compiling with
> "-g -O0"?
>
> The function where the problem is deals with whitespace munging. Just a
> guess, but do you have any whitespace config options set (e.g.,
> apply.whitespace)?
>
> -Peff
