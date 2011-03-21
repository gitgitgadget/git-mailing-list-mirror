From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Mon, 21 Mar 2011 23:01:40 +0100
Message-ID: <4D87CAC4.2010001@web.de>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <7v1v254ma7.fsf@alter.siamese.dyndns.org> <7vhbb1320t.fsf@alter.siamese.dyndns.org> <4D87B51A.4060609@web.de> <4D87C467.3090907@morey-chaisemartin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:01:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1nAg-0008PE-1r
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 23:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754687Ab1CUWBs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2011 18:01:48 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:46391 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754583Ab1CUWBr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2011 18:01:47 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id A2BCB18A3AB1E;
	Mon, 21 Mar 2011 23:01:40 +0100 (CET)
Received: from [93.240.120.88] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q1nAS-0007hP-00; Mon, 21 Mar 2011 23:01:40 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <4D87C467.3090907@morey-chaisemartin.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+aZOCEw7NWM/N3koIYPunOsO9OaaRIIjeP52pC
	XFEA62No6AAD1dSRnYNk24QgZNTs4YeaTt+ETbZvZfZN1goZNf
	DssySZbgHyZTAgYN2fSg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169677>

Am 21.03.2011 22:34, schrieb Nicolas Morey-Chaisemartin:
> On 21/03/2011 21:29, Jens Lehmann wrote:
>>
>>>  - Update should refrain from touching the submodule itself. It may want
>>>    to recurse into the submodule of the unmerged one, but people involved
>>>    in submodule work should think things through;
>>
>> I don't think recursing would make any sense here. It might be unknown
>> to what commit the sub-submodules should be updated to if their commits
>> differ in the unmerged branches. So I'd vote for not recursing at all in
>> this case (which is what your patch does).
>>
> 
> After a bit of thinking about the way we use git at my company, there is something that could be done here. It may be completely useless for most people (or maybe even stupid and feel free to enlighten me!)
> We work with continuous integration on two level of git (1 integration which only has submodules and lots of source repositories).
> The usual thing when a user want to push its diff is:
> - commit in the submodules on his branch
> - Update the submodules refs in the integration repo on his branch
> - Pull master 
> - See there are conflicts
> - Blindly pull master in all the conflicted submodules. Push the merge
> - Commit in the integration repo and pray it works !
> 
> Although in the scheme git submodule update by itself does not make much sense. What people actually do is pretty much a git submodule update --merge of the conflicting SHA1 for each submodule.
> 
> For the moment we used either ruby scripts or a list of commands that users blindly follows without understanding much of it, and seeing something like that (there's probably a nicest way to do it) in git would be great.

Hmm, I'm not sure if I fully understand your use case. Maybe being able
to tell pull to run a "git merge <sha1-from-upstream>" in submodules
where the superproject's merge produced conflicts would help you?

>>>  - Status does not have anything to report for an unmerged submodule. It
>>>    may want to recurse into the submodule of the unmerged one, but people
>>>    involved in submodule work should think things through; and
>>
>> I do think status does have something to report here. First its job is to
>> list all submodules, so currently unmerged submodules should show up too,
>> and then it tells the user something about the state of the submodule. So
>> I would propose to print a line for the submodule starting with a special
>> character that tells the user the submodule has a merge conflict. We
>> could e.g. use a '*' here (additionally to '-' for uninitialized and '+'
>> for those submodules where the HEAD differs from the commit recorded in
>> the superproject).
>>
> Being a big user of __git_ps1, my brain now considers '*' has uncached diff and '+' has cached diff. I'd rather have something as 'U' that stands outs.

That is a good argument against '*'. I don't have strong feelings about
that, I just came up with '*' because "git submodule status" already uses
'-' and '+' in it's output. But anyways, 'U' is fine for me too.
