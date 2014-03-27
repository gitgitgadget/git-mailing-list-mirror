From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible regression in master? (submodules without a "master"
 branch)
Date: Thu, 27 Mar 2014 23:55:21 +0100
Message-ID: <5334AC59.7010605@web.de>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>	<20140327155208.GM4008@odin.tremily.us> <53345E85.7070205@web.de> <xmqq8urvebok.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "W. Trevor King" <wking@tremily.us>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 27 23:55:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTJCy-0003kn-TS
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 23:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430AbaC0Wzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 18:55:33 -0400
Received: from mout.web.de ([212.227.15.4]:56403 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756166AbaC0Wzc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 18:55:32 -0400
Received: from [192.168.178.41] ([84.132.148.44]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0LwYs7-1X8jgL0hYN-018MbU; Thu, 27 Mar 2014 23:55:22
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq8urvebok.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:noMOEcPoXPOk9gTsFy7FqSMTs83oQUrOXIqtnmOojJxchUI3fSP
 RMzcEogNwxtPlyHuC+3NmpMVjKBKLYLPAQNslyF+XN2exmuY+ze7V44J8NfAggmvmQ3gdyu
 hjHbxrEt+8rg61vUhzLr1MnLTpz7vzO6psXUin2/zhMZEAdy5zQwyUnC2p1PaECxDqaS231
 9qTuBuadub5NsBF8iwXFg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245333>

Am 27.03.2014 19:30, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 27.03.2014 16:52, schrieb W. Trevor King:
>>> On Thu, Mar 27, 2014 at 03:21:49PM +0100, Johan Herland wrote:
>>>> I just found a failure to checkout a project with submodules where
>>>> there is no explicit submodule branch configuration, and the
>>>> submodules happen to not have a "master" branch:
>>>
>>> The docs say [1]:
>>>
>>>   A remote branch name for tracking updates in the upstream submodule.
>>>   If the option is not specified, it defaults to 'master'.
>>
>> But the "branch" setting isn't configured for Qt, the .gitmodules
>> file contains only this:
>>
>> [submodule "qtbase"]
>> 	path = qtbase
>> 	url = ../qtbase.git
>> ...
>>
>>> which is what we do now.  Working around that to default to the
>>> upstream submodule's HEAD is possible (you can just use --branch
>>> HEAD), but I think it's easier to just explicitly specify your
>>> preferred branch.
>>
>> That is *not* easier, as Johan did not have to do that before.
>>
>> I think your patch 23d25e48f5ead73c9ce233986f90791abec9f1e8 does
>> not do what the commit message promised:
>>
>>     With this change, folks cloning submodules for the first time via:
>>
>>       $ git submodule update ...
>>
>>     will get a local branch instead of a detached HEAD, unless they are
>>     using the default checkout-mode updates.
>>
>> And Qt uses the "default checkout-mode updates" and doesn't have
>> "branch" configured either. So we are facing a serious regression
>> here.
> 
> There are two potential issues (and a half) then:
> 
>  - When cloning with the "default checkout-mode updates", the new
>    feature to avoid detaching the HEAD should not kick in at all.

Yep.

>  - For a repository that does not have that "branch" thing
>    configured, the doc says that it will default to 'master'.
> 
>    I do not think this was brought up during the review, but is it a
>    sensible default if the project does not even have that branch?
> 
>    What are viable alternatives?
> 
>    - use 'master' and fail just the way Johan saw?
> 
>    - use any random branch that happens to be at the same commit as
>      what is being checked out?
> 
>    - use the branch "clone" for the submodule repository saw the
>      upstream was pointing at with its HEAD?
> 
>    - something else?

Good question. Me thinks that when a superproject doesn't have
'branch' configured and does set 'update' to something other than
'checkout' for a submodule it should better make sure 'master'
is a valid branch in there. Everything else sounds like a
misconfiguration on the superproject's part that warrants an
error. But I may be wrong here as I only use 'checkout' together
with a detached HEADs myself. Comments welcome.

>  - Johan's set-up was apparently not covered in the addition to t/
>    in 23d25e48 (submodule: explicit local branch creation in
>    module_clone, 2014-01-26)---otherwise we would have caught this
>    regression.  Are there other conditions that are not covered?

I suspect so. This is one of the reasons I started the submodule
testing framework I posted an RFC for a few days ago, as an attempt
to start a systematic approach to submodule testing. This is not
the first time a breakage was not caught by the tests, so we need
to do better here. (Note to self: test for the detached HEAD for
the checkout case in the framework too)
