From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Diffing submodule does not yield complete logs for merge commits
Date: Mon, 04 May 2015 21:32:49 +0200
Message-ID: <5547C961.7070909@web.de>
References: <CAHd499BqB_ZFKMNxSVCDTFx2Ge=TfCE6gexFn+rfRbS+ybLybA@mail.gmail.com>	<20150501175757.GA10569@book.hvoigt.net> <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Git <git@vger.kernel.org>
To: Robert Dailey <rcdailey.lists@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Mon May 04 21:33:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpM6z-0002nO-77
	for gcvg-git-2@plane.gmane.org; Mon, 04 May 2015 21:33:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbbEDTc7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 May 2015 15:32:59 -0400
Received: from mout.web.de ([212.227.17.11]:61573 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561AbbEDTc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 May 2015 15:32:57 -0400
Received: from [192.168.178.41] ([79.211.110.17]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LcgVn-1ZVKYV3JlH-00kAZt; Mon, 04 May 2015 21:32:52
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <CAHd499B=EcgYiTMFt9VYhj45bRkP8h9TBk1B0cr8fYFuXNe_mQ@mail.gmail.com>
X-Provags-ID: V03:K0:/q9BGZ0lBeEL7zMTFBdW/nvGWqYXfEezK8IPMDG1Ir2sYzTheC6
 0xH4KWYXui/CKgCHFwxx3FEK3glL9eJv5yCsYv1T4D/9Feioxk2AoJP9aoWU/mupQrcz8nE
 5TS16hdJtRPUJaQ25rZEGkgYHAOaSCWN+ni7+FvvdtP0A6O9FH8SfIvJsRCBiUx+27uKaRn
 EWvSCk0SW7L9kZs3N6pGQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268343>

Am 04.05.2015 um 17:05 schrieb Robert Dailey:
> On Fri, May 1, 2015 at 12:57 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>> Hi,
>>
>> On Wed, Apr 29, 2015 at 03:53:11PM -0500, Robert Dailey wrote:
>>> I am attempting to diff a submodule modified in my working copy and
>>> the only difference is a merge commit. However, I do not get the
>>> "full" range of commits introduced by the merge commit when I diff it:
>>>
>>> $ git diff --submodule=log Core
>>> Submodule Core 8b4ec60..def2f3b:
>>>    > Merge remote-tracking branch 'origin/master-ah3k'
>>>
>>> However if I go inside my submodule and run `git log` by hand, I get
>>> more information about the TRUE commits introduced:
>>>
>>> $ git log --oneline 8b4ec60..def2f3b
>>> def2f3b Merge remote-tracking branch 'origin/master-ah3k'
>>> 015c961 Remove log spam in FontManager
>>> 7713ba1 Update third party submodule to latest
>>> 10aac78 Merge pull request #9 in FE/core from
>>> feature/FE-1348-selecting-continue-on-zero-balance to master-ah3k
>>> 287882f FE-1376 Nedd to remain in check detail screen when selecting
>>> donation after SBI
>>> a5a6bed Do not overwrite the current check# within loop
>>> dfb8547 Adding list of checks to CRspChecks before saving
>>> 1be280a FE-1354: Guest logged out in specific multiple check scenario
>>> de06d5a [FE-1348] Fix PATT exit while checks still open
>>>
>>> It's almost as if the `git diff --submodule=log` approach is passing
>>> in --first-parent to git log, which would exclude commits in the range
>>> that I'm seeing when I run git log manually.
>>
>> That is exactly the case. In prepare_submodule_summary() that option is
>> set before doing the revision walk.
>>
>>> Is this by design? Is there a way to enable the full log history with
>>> `git diff` on a submodule?
>>
>> This stems from the first implementation for showing submodule diffs in
>> commit 752c0c24. I guess this was done deliberately to limit the amount
>> of output you get for a submodule. At the moment this is hardcoded but I
>> think there is nothing wrong with adding another option to include the
>> full log.
>>
>> Cheers Heiko
>
> I will go ahead and work on this feature. Here is what I'd like to see:
>
> 1. `git diff --submodule` should have the ability to display full logs
> vs current logs (i.e. without --first-parent)

I agree. Just recently I started missing that feature too at $DAYJOB.

> 2. `git submodule summary` should have an option to display full logs
> or "first-parent" logs.

No objection against that. Maybe now is a good time to make `git
submodule summary` use `git diff --submodule` internally to make
them behave the same?

> For #1, do you recommend adding a 3rd setting for `diff.submodule`
> config? Something like "full-log" or something? Or an entirely new
> config?

I'd go with a 3rd setting for diff.submodule (and "full-log" would
have been my first choice too ;-).

 > I noticed that in diff.h, the DIFF_OPT flags already consume
> 31 bits. If this is a 32-bit flag, there is only 1 bit left. If we go
> with a 3rd setting for `diff.submodule` I think this might consume the
> last bit.

Yup. But I'm not sure we can do anything about it.

> We could also make `git diff --submodule` default to the "full log"
> type, and if users want only first parent logs in submodule summary,
> they'd have to execute `git submodule summary` instead.

Please do not change defaults that people lived fine with for years
lightly. But I won't object changing that on a major version if a
majority of users request that.
