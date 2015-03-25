From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [RFC] git submodule purge
Date: Wed, 25 Mar 2015 20:47:59 +0100
Message-ID: <551310EF.8050700@web.de>
References: <20150316134407.GA31794@pks-tp.elego.de> <20150316200353.GB5186@google.com> <20150317075636.GA354@pks-pc> <5510866B.40501@web.de> <20150325090631.GA370@pks-pc.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:48:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YarHh-0002Z6-Ex
	for gcvg-git-2@plane.gmane.org; Wed, 25 Mar 2015 20:48:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752163AbbCYTsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2015 15:48:09 -0400
Received: from mout.web.de ([212.227.17.11]:56110 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751238AbbCYTsG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2015 15:48:06 -0400
Received: from [192.168.178.41] ([79.211.117.156]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0MGRdk-1YfH7L2Kzg-00DKoO; Wed, 25 Mar 2015 20:48:03
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
In-Reply-To: <20150325090631.GA370@pks-pc.localdomain>
X-Provags-ID: V03:K0:vgSmn3K0lc4xlmQaukc60UwYAt3hgnuNWP7qyNpukGvKf5CIqxu
 4EUZdFp3S8yyHOD0YMPuMRGPfH4XDvl0hUHiDoxNzNq2GPlisxReDYkf7OJXF4nOwRnBieY
 Ac+CLB5+QWzPxv34WGtOF0sOHD5FF+UIFRxtgxJ0B+BDW2i/R+tfQUYU9WBNcOnAef4t/7Z
 Nt61ErXi9UZ1vvwJoO7lw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266295>

Am 25.03.2015 um 10:06 schrieb Patrick Steinhardt:
> On Mon, Mar 23, 2015 at 10:32:27PM +0100, Jens Lehmann wrote:
>> Am 17.03.2015 um 08:56 schrieb Patrick Steinhardt:
>>> On Mon, Mar 16, 2015 at 01:03:53PM -0700, Jonathan Nieder wrote:
>>>> (+cc: Jens and Heiko, submodule experts)
>>>> Hi,
>>>>
>>>> Patrick Steinhardt wrote:
>>>>
>>>>> This proposal is just for discussion. If there is any interest I
>>>>> will implement the feature and send some patches.
>>>>>
>>>>> Currently it is hard to properly remove submodules. That is when
>>>>> a submodule is deinitialized and removed from a repository the
>>>>> directory '.git/modules/<SM_NAME>' will still be present and
>>>>> there is no way to remove it despite manually calling `rm` on it.
>>>>> I think there should be a command that is able to remove those
>>>>> dangling repositories if the following conditions are met:
>>>>>
>>>>> - the submodule should not be initialized
>>>>>
>>>>> - the submodule should not have an entry in .gitmodules in the
>>>>>     currently checked out revision
>>>>>
>>>>> - the submodule should not contain any commits that are not
>>>>>     upstream
>>>>>
>>>>> - the submodule should not contain other submodules that do not
>>>>>     meet those conditions
>>>>>
>>>>> This would ensure that it is hard to loose any commits that may
>>>>> be of interest. In the case that the user knows what he is doing
>>>>> we may provide a '--force' switch to override those checks.
>>>>
>>>> Those conditions look simultaneously too strong and too weak. ;-)
>>>>
>>>> In principle, it should be safe to remove .git/modules/<name> as
>>>> long as
>>>>
>>>>    (1) it (and its submodules, sub-sub-modules, etc) doesn't have any
>>>>        un-pushed local commits.
>>>>
>>>>    (2) it is not being referred to by a .git file in the work tree of
>>>>        the parent repository.
>>>>
>>>> Condition (1) can be relaxed if the user knows what they are losing
>>>> and is okay with that.  Condition (2) can be avoided by removing
>>>> (de-initing) the copy of that submodule in the worktree at the same
>>>> time.
>>>>
>>>> The functionality sounds like a useful thing to have, whether as an
>>>> option to 'git submodule deinit' or as a new subcommand.  In the long
>>>> term I would like it to be possible to do everything 'git submodule'
>>>> can do using normal git commands instead of that specialized
>>>> interface.  What command do you think this would eventually belong in?
>>>> (An option to "git gc", maybe?)
>>>>
>>>> Thanks,
>>>> Jonathan
>>>
>>> Thanks for your feedback.
>>>
>>> Considering that purging the submodule is tightly coupled with
>>> de-initializing it, it might make sense to provide this
>>> functionality as part of `git submodule deinit`. Maybe something
>>> like `git submodule deinit --purge` would work for the user.
>>> Problem is if the user first removes the submodule and does not
>>> first deinitialize it he is not able to purge the repository
>>> afterwards as deinit will complain about the submodule not being
>>> matched anymore. We could just make `deinit --purge` work with
>>> removed submodules, but that does not feel very natural to me.
>>
>> Hmm, cmd_deinit() seems to cope with submodules removed by the
>> user just fine (as long as they are still present in the index).
>> To me it feels natural to extend deinit to remove the repo from
>> .git/modules too when --purge is given (as long as no unpushed
>> commits are present or -f is given).
>>
>>> `git gc` feels saner in that regard, but I don't think it would
>>> be easy to spot for users as this command is in general not used
>>> very frequently by them. One could argue though that it does not
>>> need to be discoverable.
>>
>> The error message of "git submodule deinit --purge" for a
>> submodule that isn't recorded in the index anymore could point
>> the user to the appropriate gc command. But how do we tell gc
>> which submodule it should purge? "--purge=<submodule-name>"
>> maybe?
>
> This might work, but at least the option would need to provide a
> hint to the user that it has something to do with submodules. So
> if the feature was implemented by `git gc` I'd rather name the
> parameter "--purge-submodule=<submodule-name>" which in my
> opinion clearly states its intention, even though it is longer to
> type. But with working bash-completion this should be non-issue,
> especially as this command would not need to be run frequently.

Agreed.

> That said, I think by now I agree with the common (?) opinion
> that the command is best placed in `git submodule deinit --purge`
> and I will likely implement it there.

Me thinks that makes sense. But be aware that this will only work
for those submodules that are still present in the current index.

> Optionally I could
> implement `git gc --purge-submodule=<submodule-name>` as a second
> way to access the feature so that we have a way of purging them
> without using the submodules-interface. I doubt though that this
> will provide much of a benefit as the user still has to be aware
> that he is working with submodules as he has to provide the
> `--purge-submodule` option, so there is not much to be gained by
> this.

Hmm, I still believe cleaning up a submodule repo which is already
deinited makes sense. Using 'rm -rf .git/modules/<submodulename>'
will work just fine, but is missing any safeguards. The deinit
command takes submodule paths, not submodule names. So it looks
to me like 'git gc --purge-submodule=<submodule-name>' would make
sense here (and this command should check that the submodule has
already been deinited and fail otherwise telling the user so).
