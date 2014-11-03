From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH 0/4] Multiple worktrees vs. submodules fixes
Date: Mon, 03 Nov 2014 21:57:13 +0100
Message-ID: <5457EC29.8040005@web.de>
References: <1413090791-14428-1-git-send-email-max@max630.net> <CACsJy8BUtkWKE+P_sHgpAY6wJ9tpzxZRtZHULiLoO=dGnBjkHQ@mail.gmail.com> <543D58D9.5060606@web.de> <xmqqoatezhnx.fsf@gitster.dls.corp.google.com> <20141014183431.GA8157@wheezy.local> <543D7EBA.4040206@web.de> <20141014221509.GA10580@wheezy.local> <543EC390.4000709@web.de> <20141016205453.GA8441@wheezy.local> <54441147.5080204@web.de> <20141020041109.GA5784@wheezy.local> <CACsJy8C34PyK4rPQC_wFgms=gVCs2FN_5aUSMfzJawErZHHwFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>, Max Kirillov <max@max630.net>
X-From: git-owner@vger.kernel.org Mon Nov 03 21:57:25 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XlOgk-0007sE-QI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Nov 2014 21:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbaKCU5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2014 15:57:18 -0500
Received: from mout.web.de ([212.227.17.12]:51773 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753917AbaKCU5R (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2014 15:57:17 -0500
Received: from [192.168.178.41] ([79.211.117.185]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0M1XDJ-1Y4hxA3yrR-00tRiR; Mon, 03 Nov 2014 21:57:14
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACsJy8C34PyK4rPQC_wFgms=gVCs2FN_5aUSMfzJawErZHHwFg@mail.gmail.com>
X-Provags-ID: V03:K0:ZRzMfovqF+FAIodFcn+Rnz4cV69UiWVJYWTMZUJ2b8bmdwmTUgt
 tjX/mDRhFi4KSzas+CQSajknUmcRWc6QwJoaaRkK1d9pAGuLOEwzXegBK2joip20SaQ3l6V
 m5WZUIlTn//iplgkh46MaZQjRjz8oacXW1lOOiW2ebC0g1jpQmUrTLBwDWUwC/ZSXIqIWQK
 rGQzlDBfKDojaCaBSEq4Q==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.11.2014 um 13:54 schrieb Duy Nguyen:
> Ping.. any idea how to go from here..

I didn't dig deep enough into the multiple worktrees topic to
know what "$MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB"
might mean, but a submodule whose repo lives under
.git/modules/$SUBMODULE_NAME should have its worktree in
$SUBMODULE_PATH of the superproject's worktree.

So if we share submodule repos, the sharable stuff should
live under $MAIN_REPO/.git/modules/$SUBMODULE_NAME/. But
everything that can't be put there should stay under the
.git/modules/$SUBMODULE_NAME directory in every worktree.
The same redirection mechanism the superproject uses to
redirect to $MAIN_REPO/.git should be used to redirect
the sharable stuff from .git/modules/$SUBMODULE_NAME to
$MAIN_REPO/.git/modules/$SUBMODULE_NAME/.

I believe this should be the default. Optionally we might
want to enable the user to put $MAIN_REPO/.git/modules
someplace else (outside the superprojects $MAIN_REPO) to
be able to reuse the object store of submodules that are
shared between different superprojects.

Does that make sense?

> On Mon, Oct 20, 2014 at 11:11 AM, Max Kirillov <max@max630.net> wrote:
>> On Sun, Oct 19, 2014 at 09:30:15PM +0200, Jens Lehmann wrote:
>>> Am 16.10.2014 um 22:54 schrieb Max Kirillov:
>>>> On Wed, Oct 15, 2014 at 08:57:20PM +0200, Jens Lehmann wrote:
>>>>> Am 15.10.2014 um 00:15 schrieb Max Kirillov:
>>>>>> I think the logic can be simple: it a submodule is not
>>>>>> checked-out in the repository "checkout --to" is called
>>>>>> from, then it is not checked-out to the new one also. If it
>>>>>> is, then checkout calls itself recursively in the submodule
>>>>>> and works like being run in standalone repository.
>>
>>>>> But when I later decide to populate the submodule in a
>>>>> "checkout --to" work tree, should it automagically also
>>>>> use the central storage, creating the modules/<name>
>>>>> directory there if it doesn't exist yet? I think that'd
>>>>> make sense to avoid having the work tree layout depend
>>>>> on the order commands were ran in. And imagine new
>>>>> submodules, they should not be handled differently from
>>>>> those already present.
>>
>>>> Like place the common directory to
>>>> $MAIN_REPO/.git/modules/$SUB/ and worktree-specific part to
>>>> $MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB, rather
>>>> than placing all into the socond one? It would make sense to
>>>> make, but then it would be imposible to checkout a diferent
>>>> repository into the same submodule in different superproject
>>>> checkouts. However stupid is sounds, there could be cases
>>>> if, for example, at some moment submodule is being replaced
>>>> by another one, and older worktrees should work with older
>>>> submodule, while newer uses the newer submodule.
>>
>>> Yes, but I believe that the user must be careful to not
>>> reuse the same submodule name for a different repo anyways,
>>> no matter if shared or not. Currently you'll get a warning
>>> about that when trying to add a submodule whose name is
>>> already found in .git/modules to avoid such confusion.
>>
>> Yes, while trying to write tests for this case I discovered
>> that there are warnings and the recommended way is to use
>> different names for different repositories even if they are
>> pointing to the same path. Then always placing common
>> directory into the .git/modules/<module> could be a good
>> idea, and in very special cases users could manually create
>> repositories with custom placement.
>>
>>>> Also, could you clarify the usage of the /modules/
>>>> directory. I did not notice it to affect anything after the
>>>> submofule is placed there. Submodule operations use the
>>>> submodule repositories directly (through the git link, which
>>>> can point anywhere), or in .gitmodules file, or maybe in
>>>> .git/config. So there is actually no need to have that
>>>> gitdir there. Is it correct?
>>
>>> Nope. When submodules are cloned their git directory is
>>> placed under .git/modules/<submodule name>, the .git file
>>> in the work tree points there and the core.worktree setting
>>> points back from there to the work tree.
>>
>> I meant is the fact that gitdir is placed in modules, rather
>> than in any other place, is used anywhere. There are 2
>> places to put the gitdir of submodule in linked copy:
>> 1. $MAIN_REPO/.git/worktrees/$WORKTREE/modules/$SUB
>> 2. $MAIN_REPO/.git/modules/$SUB/worktrees/$SUB_WTNAME
>> First one is suggested by submodule way of placing gitdirs,
>> and the second one by worrktree way. There are reasons to
>> have the second one - garbage collection and check that 2
>> branch is not checked out twice. Are there resons to have
>> the 1st one? The one is to prevent use of different
>> repositories with the same name, anything else?
>>
>> --
>> Max
>
>
>
