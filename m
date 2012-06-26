From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git submodule vs GIT_WORK_TREE
Date: Wed, 27 Jun 2012 00:30:37 +0200
Message-ID: <4FEA380D.8070001@web.de>
References: <CAD77+gTVLsEOgWo+WDafzNOYOwSZQ2KkgBuibBXemVmGu_Fzgw@mail.gmail.com> <7vobo6cazk.fsf@alter.siamese.dyndns.org> <4FE9FF0C.8050409@web.de> <7vobo5c0n0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 00:30:47 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjeHV-0005pc-8P
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jun 2012 00:30:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753531Ab2FZWal (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 18:30:41 -0400
Received: from mout.web.de ([212.227.15.3]:62134 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751885Ab2FZWal (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 18:30:41 -0400
Received: from [192.168.178.48] ([79.193.92.179]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0Lk8gg-1S7pgd3mWY-00cFnl; Wed, 27 Jun 2012 00:30:38
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
In-Reply-To: <7vobo5c0n0.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:QUWMq8dG6/uHnC19kmMspaswBRQ7TV6ggRiSISpZ/b+
 czyKtKa8CUEE82hLfArIqePLPoy3aLgJAph9K2XnHLlBmELgkJ
 YGz3Msxu+vB6jj24vtI3tVeCLU+ELady4igwHtZssaWvG3reCv
 niAQx73CePjJCONqGf1YjB53BkCHnnq9KLYJeJCt6RJvWd+goy
 rMvSpX+JodCpUnabdA5ow==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200692>

Am 26.06.2012 21:51, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Am 26.06.2012 18:07, schrieb Junio C Hamano:
>> ...
>>> When the user exports GIT_WORK_TREE to tell git that the root of the
>>> working tree the user wants to work on resides there (which is
>>> needed when the user exports GIT_DIR to tell git that the user wants
>>> to work on that repository), that wish obviously applies only to
>>> that repository.  If git decides to visit the working tree of a
>>> different repository (e.g. a checkout of a submodule bound to the
>>> project GIT_WORK_TREE points at), even if it is done in response to
>>> the user action (e.g. like passing "--recurse-submodules" option),
>>> it should adjust GIT_WORK_TREE and GIT_DIR to be appropriate for
>>> operations in the submodule repository while doing so.  If the more
>>> recent "recursive" behaviour forgets to do so, it simply is a bug.
>>
>> I'm not sure what you mean by "appropriate for operations in the
>> submodule repository". Should the submodule work tree be searched
>> for under $GIT_WORK_TREE of the superproject or under $(pwd)?
> 
> I think either
> 
>  (1) unset GIT_WORK_TREE/GIT_DIR if the process chdirs to
>      $GIT_WORK_TREE/submodule and $GIT_WORK_TREE/submodule/.git is
>      the controlling reopsitory of that submodule working tree, or
> 
>  (2) set GIT_WORK_TREE/GIT_DIR to point at the working tree and
>      repository of the submodule.
> 
> would be appropriate.

Agreed.

>> As far as I can see all submodule code consistently clears all
>> environment variables used by git before descending into a
>> submodule (at least since February 2010 and 5ce9086dd). Maybe we
>> should change that so it sets the GIT_WORK_TREE environment to
>> "$GIT_WORK_TREE/submodule" to be consistent?
> 
> If the user has to use GIT_WORK_TREE to mark the root level of the
> superproject working tree as such, it is very likely that the
> controlling repository of the superproject does not live in the
> $GIT_WORK_TREE/.git directory (in other words, $GIT_DIR points at
> somewhere else).  Exporting GIT_WORK_TREE/submodule as the new value
> of GIT_WORK_TREE is sensible, but I do not see a reasonable way to
> deduce the value of GIT_DIR for the submodule in such a case.  The
> controlling repository of the superproject is located somewhere
> random; there is no reason to assume the repository for the
> submodule is somewhere at fixed relation to it.
> 
> Does it mean the short answer to Richard's situation is "Don't do
> it"?  I am not sure, but it is starting to sound like it.

Not at all, I was just trying to reach consensus on what the user
can reasonably expect when setting GIT_WORK_TREE in the presence of
submodules. I will look into it to see how we can handle the cases
where GIT_WORK_TREE and/or GIT_DIR are set.
