From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP PATCH 0/3] implement merge strategy for submodule links
Date: Fri, 18 Jun 2010 15:55:10 +0200
Message-ID: <4C1B7ABE.8080905@web.de>
References: <cover.1276059473.git.hvoigt@hvoigt.net> <201006170239.01951.johan@herland.net> <4C1A8FDC.7010309@web.de> <201006181140.16652.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>, Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Fri Jun 18 15:55:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OPc2U-0002Fd-Jo
	for gcvg-git-2@lo.gmane.org; Fri, 18 Jun 2010 15:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932949Ab0FRNzQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jun 2010 09:55:16 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45645 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932422Ab0FRNzP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jun 2010 09:55:15 -0400
Received: from smtp05.web.de  ( [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 9B01A15741388;
	Fri, 18 Jun 2010 15:55:13 +0200 (CEST)
Received: from [80.128.82.62] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OPc2L-0002E5-00; Fri, 18 Jun 2010 15:55:13 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <201006181140.16652.johan@herland.net>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+WNTcW5idZnc8LukXbF5WBLBAg1IaOTuBLZbRY
	DxbclY9LT34/S5Bppz2F9rwT3HSeB66PcX8nov1zXh77oGb3GR
	ssLMuBqcbwXhOwRQ5xzA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149348>

Am 18.06.2010 11:40, schrieb Johan Herland:
> On Thursday 17 June 2010, Jens Lehmann wrote:
>> Am 17.06.2010 02:39, schrieb Johan Herland:
>>> But this is pure speculation, and as you say, I'd like to see what
>>> workflows Jens and Heiko are actually using.
>>
>> Ok, here we go. And as I have difficulties thinking about that when
>> looking at a single graph, I'll draw two: The upper for the superproject
>> and the lower for the submodule.
>>
>> Superproject:
>>   -----2         [Alice's branch]
>>  /      \
>> 1--3-----4---5   [master]
>>     \       /
>>      ------6     [Bob's branch]
>>
>>        ^   ^
>>        |   |     [commits of the submodule committed in the superproject]
>>
>> Submodule:
>>   ---B           [feature_a]
>>  /    \
>> A--C---D---E     [master]
>>     \     /
>>      ----F       [feature_b]
>>
>> Alice hacks away on her feature branch and notices she has to make
>> changes to a submodule. She creates the "feature_a" branch there with
>> commit 'B' and asks the maintainer of the submodule to review and merge
>> her change. Our policy is to never commit submodule commits that are not
>> merged yet, as they could just vanish (e.g. by rebasing; imagine having
>> git as a submodule and committing a SHA1 from the "pu" branch in the
>> superproject ... a later bisect might get really frustrating). So the
>> submodule maintainer merges 'B' into 'D' and tells Alice that. She
>> commits 'D' for the submodule in her '2' commit and asks the maintainer
>> of the superproject to review and merge that. The moment he merges that
>> into '4', 'D' gets recorded in the master branch of the superproject for
>> the submodule.
>>
>> Meanwhile Bob also needs a change in the submodule for his work in the
>> superproject and adds commit 'F' on the "feature_b" branch there. He
>> waits for the submodule maintainer to merge that into 'E' so he can do
>> commit '6'.
>>
>> But now the submodule commit 'D' in the superproject commit '4' has
>> become an obstacle for him and the superprojects maintainer. Bob can't
>> rebase or cherrypick beyond or up to '4' because he will get a merge
>> conflict. If he asks to merge his branch into '5', the superprojects
>> maintainer will get a merge conflict and tells to him to resolve that.
> 
> Just verifying here: The superproject graph (with referenced submodule 
> commits in parentheses) looks like this:
> 
>    --------2(D)            [Alice's branch]
>   /         \
>  1(A)--3(A)--4(D)---5(?)   [master]
>         \          /
>          ---------6(E)     [Bob's branch]
> 
> ...and the conflict that causes problems when merging '4' and '6', is the 
> 'A'->'D' vs. 'A'->'E' submodule updates.

That's correct.


>> This is somehow similar to merging binary files. But for submodules Git
>> has a chance to tell the combined version of both changes in the
>> fast-forward case, whereas it can't know that for binary files. And yes,
>> merge conflicts could happen for the same reasons they may happen to
>> files: The changes in Bob's branch could break something in Alice's
>> branch. But that applies for files just like it does for submodule
>> commits, no?
> 
> Correct. I guess this means that - for the fast-forward case - Git can 
> automatically record this resolution in the index, hence not requiring the 
> user to "confirm" the resolution with 'git add'.

Yup, I think we agree here and I just wanted to explain our regular
workflow and show that such a strategy would help us very much.


>> And the non-fast-forward case happens e.g. when Alice and Bob do not wait
>> for the submodule maintainer to merge their changes:
>>
>> Superproject:
>>   ---2         [Alice's branch]
>>  /    \
>> 1--3---4---5   [master]
>>     \     /
>>      ----6     [Bob's branch]
>>
>>      ^   ^
>>      |   |       [commits of the submodule committed in the superproject]
>>
>> Submodule:
>>   ---B           [feature_a]
>>  /    \
>> A--C---D---E     [master]
>>     \     /
>>      ----F       [feature_b]
>>
>> In this case submodule commit 'B' is recorded in '2' and thus '4', while
>> commit 'F' will be recorded in '6'. So when '4' and '6' are merged, a
>> valid guess for '5' would be to use submodule commit 'E', as it is the
>> first one based on both 'B' and 'F'.
> 
> Again, to verify: The superproject graph (with referenced submodule commits 
> in parentheses) looks like this:
> 
>    --------2(B)            [Alice's branch]
>   /         \
>  1(A)--3(A)--4(B)---5(?)   [master]
>         \          /
>          ---------6(F)     [Bob's branch]

Correct.


>> But I think this approach will solve a lot of the problems we - and maybe
>> others - have with submodule merges without doing any harm to other
>> workflows.
> 
> For the fast-forward case, I fully agree.
> 
> For the non-fast-forward case, I would suggest to search for submodule 
> merges that contain both submodule commits (as described in [1]), and then:
> 
> - If there are no merges, do nothing (leave a conflict).
> 
> - If there is exactly one merge, then check it out (but do not record it as 
> resolved in the index).
> 
> - If there are more merge alternatives, present them as equal alternatives, 
> but do nothing (leave a conflict).

Nice summary. Heiko, would you please post a new patch implementing this
approach?
