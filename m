From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's cooking in git.git (Apr 2012, #06; Sun, 15)
Date: Thu, 19 Apr 2012 08:45:52 +0200
Message-ID: <4F8FB4A0.7090403@viscovery.net>
References: <7vpqb8xjj9.fsf@alter.siamese.dyndns.org> <4F8E6A12.9090708@viscovery.net> <4F8F1BC1.3030607@ramsay1.demon.co.uk> <4F8FADCF.5000006@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 19 08:46:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKl7y-0001Qd-9C
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 08:46:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224Ab2DSGp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 02:45:58 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:58307 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751968Ab2DSGp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 02:45:57 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.76)
	(envelope-from <j.sixt@viscovery.net>)
	id 1SKl89-0004Zb-FM; Thu, 19 Apr 2012 08:46:13 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 998801660F;
	Thu, 19 Apr 2012 08:45:52 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:11.0) Gecko/20120327 Thunderbird/11.0.1
In-Reply-To: <4F8FADCF.5000006@viscovery.net>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195927>

Am 4/19/2012 8:16, schrieb Johannes Sixt:
> Am 4/18/2012 21:53, schrieb Ramsay Jones:
>> Johannes Sixt wrote:
>>> Am 4/16/2012 8:44, schrieb Junio C Hamano:
>>>> * nd/threaded-index-pack (2012-04-11) 3 commits
>>>>  - index-pack: support multithreaded delta resolving
>>>>  - index-pack: split second pass obj handling into own function
>>>>  - compat/win32/pthread.h: Add an pthread_key_delete() implementation
>>>
>>> With this series, t9300.92 (fast-import, Q: verify pack) consistently
>>> fails for me on Windows.
>>>
>>> I'll have to see when I can dig deeper into this topic...
>>
>> Hmm, this works just fine for me.
> 
> It's a Heisenbug. I see different failure modes:
> 
> error: inflate: data stream error (incorrect header check)
> fatal: serious inflate inconsistency
> 
> fatal: premature end of pack file, 79 bytes missing
> 
> fatal: premature end of pack file, 72 bytes missing
> 
> (and I even saw successful runs). It's always the same pack,
> pack-54fa663f5ec35*.pack. But running index-pack --verify manually does
> not fail. The packs look good because the installed index-pack (which was
> built without this topic) does not report an error, either.

Here's one backtrace:

#0  error (err=0x55f6e6 "inflate: %s (%s)") at usage.c:122
#1  0x004ba96d in git_inflate (strm=0x12afdb8, flush=0) at zlib.c:144
#2  0x00434823 in get_data_from_pack (obj=0xd82608)
    at builtin/index-pack.c:486
#3  0x00434f6e in resolve_delta (delta_obj=0xd82608, base=0xd891e0,
    result=0x12b01f0) at builtin/index-pack.c:687
#4  0x0043528a in find_unresolved_deltas_1 (base=0xd891e0, prev_base=0x0)
    at builtin/index-pack.c:743
#5  0x004352ee in find_unresolved_deltas (base=0xd891e0)
    at builtin/index-pack.c:759
#6  0x004353cd in second_pass (obj=0xd81bc0) at builtin/index-pack.c:798
#7  0x004354c4 in threaded_second_pass (arg=0xd811e8)
    at builtin/index-pack.c:821
#8  0x00505200 in win32_start_routine (arg=0xd811e8)
    at compat/win32/pthread.c:20
#9  ...

I don't see any mutual exclusion happening in this chain. Perhaps it is
not needed, provided that the pread() call in get_data_from_pack is
atomic. But our git_pread() from compat/pread.c, which we use on Windows,
is not atomic.

:-(

I don't think that it is possible to make git_pread() atomic because it
would have to be protected against all file accesses that can modify the
file position.

Is get_data_from_pack() the only function that accesses the pack data?
Then we could add some mutual exclusion there.

-- Hannes
