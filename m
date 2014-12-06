From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH/RFC v2] Squashed changes for multiple worktrees vs. submodules
Date: Sat, 06 Dec 2014 13:44:37 +0100
Message-ID: <5482FA35.40600@web.de>
References: <1417390076-2953-1-git-send-email-max@max630.net> <547E24E4.7050100@web.de> <20141202221611.GB9128@wheezy.local> <5480BEB9.8070109@web.de> <CACsJy8BWv8U6+sujEj8HgMGmgFJR_YgCroYHcG1jsoGtbVCD7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Max Kirillov <max@max630.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 06 13:44:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxEjA-00068y-6V
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 13:44:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752527AbaLFMoo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 07:44:44 -0500
Received: from mout.web.de ([212.227.15.14]:54260 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752389AbaLFMon (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Dec 2014 07:44:43 -0500
Received: from [192.168.178.41] ([79.211.123.29]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LilYb-1XRTPR2C1l-00cxMc; Sat, 06 Dec 2014 13:44:40
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <CACsJy8BWv8U6+sujEj8HgMGmgFJR_YgCroYHcG1jsoGtbVCD7Q@mail.gmail.com>
X-Provags-ID: V03:K0:qXWFSvfEpcjMxNepXO2CN6bmPh3bDyRH6OqAEdL07PnPYccqeDB
 rBVlH5dHYJRf8ZoQCOF1CpwxdXbbo6QfqGvEjfN7CpVALN2V+myzU54XqNuHpltciLixMHc
 V2yXli89bOzStPAnpuA+Gnd1GzG4lyA8UxRT1fB1fa7kdp3/62pweX1wxRFFSVABBeedS69
 eGevORdW6a1Bs4erK37IQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260950>

Am 05.12.2014 um 02:33 schrieb Duy Nguyen:
> On Fri, Dec 5, 2014 at 3:06 AM, Jens Lehmann <Jens.Lehmann@web.de> wrote:
>> Wow, so the .git/config is shared between all worktrees? I
>> suspect you have very good reasons for that,
>
> most of config vars are at repo-level, not worktree-level, except
> maybe submodule.* and something else.

Yeah, that would have been my first guess too.

 > Technically we could use
> "include.path" to point to a non-shared file, where we store
> worktree-specific config.

I like that, but am not sure how hard that would be to
implement.

>> but I believe
>> that'll make multiple work trees surprise the user from time
>> to time when used with submodules. Because initializing a
>> submodule in one worktree initializes it in all other
>> worktrees too (I suspect other users regard "git submodule
>> init" being a worktree local command too). And setting
>> "submodule.<name>.update" to "none" will also affect all
>> other worktrees. But I'd need to have separate settings for
>> our CI server, e.g. to checkout the sources without the
>> largish documentation submodule in one test job (=worktree)
>> while checking out the whole documentation for another job
>> building the setup in another worktree.
>>
>> And if I understand the "checkout: reject if the branch is
>> already checked out elsewhere" thread correctly, I won't be
>> able to build "master" in two jobs at the same time?
>
> If you do "git checkout --to ... master^{}", it should run fine.

So I'd have to teach our CI-server that incantation ... and
must hope nothing else breaks because of the detached HEAD.

 > I'm
> still considering doing something better with the read-only refs, but
> haven't found time to really think it through yet.

Hmm, what about different namespaces for the refs in the repo
borrowed from? Maybe only when it is bare? Dunno ...

>> Thanks. But I changed my mind about the details (now that I
>> know about .git/config and multiple worktrees). I think you'd
>> have to connect a .git directory in the submodule to the
>> common git dir directly, as you cannot use the core.worktree
>> setting (which could be different between commits due to
>> renames) when putting it into <worktree>/.git/modules. And
>> then you couldn't remove or rename a submodule anymore,
>> because that fails when it contains a .git directory.
>>
>> Seems like we should put a "Warning: may do unexpected things
>> when used with submodules" (with some examples about what might
>> happen) in the multiple worktrees documentation. And I don't
>> believe anymore that teaching submodules to use the common git
>> dir makes that much sense after I know about the restrictions
>> it imposes.
>
> I'm ok with such a warning fwiw.

I believe you'd need to prominently advertise that changing
settings in .git/config affects all worktrees anyway to avoid
surprising users (at least I didn't expect it ;-), so adding
a word or to that this also impacts submodules should suffice.
