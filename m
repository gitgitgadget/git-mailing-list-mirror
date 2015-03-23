From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] git submodule purge
Date: Mon, 23 Mar 2015 22:32:27 +0100
Message-ID: <5510866B.40501@web.de>
References: <20150316134407.GA31794@pks-tp.elego.de> <20150316200353.GB5186@google.com> <20150317075636.GA354@pks-pc>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Patrick Steinhardt <ps@pks.im>,
	Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 23 22:32:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya9xc-0000IB-Bt
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 22:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752881AbbCWVcc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2015 17:32:32 -0400
Received: from mout.web.de ([212.227.17.11]:61340 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752508AbbCWVcb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 17:32:31 -0400
Received: from [192.168.178.41] ([79.211.96.44]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0Lpw6t-1Z6l1X20F5-00fl8B; Mon, 23 Mar 2015 22:32:28
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150317075636.GA354@pks-pc>
X-Provags-ID: V03:K0:aL/Jg4txoS0LptbOQUv/vSzgiLogj1lbBSiV7XCyiaFCOosiQfz
 Rc8cZ6ESzrN1uXPpj+ZW0er1fPVvTrhdrHax2/YVxBlbvDaTmNR1GRy42Y8A0IULuz68cq+
 nmRsyYy0N6uuzneTK3GHjTX8wt/XuqB6YKsRWpXWsDHnUPpiDzqDj9khVEimMXni5SGkHmk
 eIL9PydJ23d2v+Fai2dfQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266164>

Am 17.03.2015 um 08:56 schrieb Patrick Steinhardt:
> On Mon, Mar 16, 2015 at 01:03:53PM -0700, Jonathan Nieder wrote:
>> (+cc: Jens and Heiko, submodule experts)
>> Hi,
>>
>> Patrick Steinhardt wrote:
>>
>>> This proposal is just for discussion. If there is any interest I
>>> will implement the feature and send some patches.
>>>
>>> Currently it is hard to properly remove submodules. That is when
>>> a submodule is deinitialized and removed from a repository the
>>> directory '.git/modules/<SM_NAME>' will still be present and
>>> there is no way to remove it despite manually calling `rm` on it.
>>> I think there should be a command that is able to remove those
>>> dangling repositories if the following conditions are met:
>>>
>>> - the submodule should not be initialized
>>>
>>> - the submodule should not have an entry in .gitmodules in the
>>>    currently checked out revision
>>>
>>> - the submodule should not contain any commits that are not
>>>    upstream
>>>
>>> - the submodule should not contain other submodules that do not
>>>    meet those conditions
>>>
>>> This would ensure that it is hard to loose any commits that may
>>> be of interest. In the case that the user knows what he is doing
>>> we may provide a '--force' switch to override those checks.
>>
>> Those conditions look simultaneously too strong and too weak. ;-)
>>
>> In principle, it should be safe to remove .git/modules/<name> as
>> long as
>>
>>   (1) it (and its submodules, sub-sub-modules, etc) doesn't have any
>>       un-pushed local commits.
>>
>>   (2) it is not being referred to by a .git file in the work tree of
>>       the parent repository.
>>
>> Condition (1) can be relaxed if the user knows what they are losing
>> and is okay with that.  Condition (2) can be avoided by removing
>> (de-initing) the copy of that submodule in the worktree at the same
>> time.
>>
>> The functionality sounds like a useful thing to have, whether as an
>> option to 'git submodule deinit' or as a new subcommand.  In the long
>> term I would like it to be possible to do everything 'git submodule'
>> can do using normal git commands instead of that specialized
>> interface.  What command do you think this would eventually belong in?
>> (An option to "git gc", maybe?)
>>
>> Thanks,
>> Jonathan
>
> Thanks for your feedback.
>
> Considering that purging the submodule is tightly coupled with
> de-initializing it, it might make sense to provide this
> functionality as part of `git submodule deinit`. Maybe something
> like `git submodule deinit --purge` would work for the user.
> Problem is if the user first removes the submodule and does not
> first deinitialize it he is not able to purge the repository
> afterwards as deinit will complain about the submodule not being
> matched anymore. We could just make `deinit --purge` work with
> removed submodules, but that does not feel very natural to me.

Hmm, cmd_deinit() seems to cope with submodules removed by the
user just fine (as long as they are still present in the index).
To me it feels natural to extend deinit to remove the repo from
.git/modules too when --purge is given (as long as no unpushed
commits are present or -f is given).

> `git gc` feels saner in that regard, but I don't think it would
> be easy to spot for users as this command is in general not used
> very frequently by them. One could argue though that it does not
> need to be discoverable.

The error message of "git submodule deinit --purge" for a
submodule that isn't recorded in the index anymore could point
the user to the appropriate gc command. But how do we tell gc
which submodule it should purge? "--purge=<submodule-name>"
maybe?
