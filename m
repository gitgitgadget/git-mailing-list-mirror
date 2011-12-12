From: Gelonida N <gelonida@gmail.com>
Subject: Re: best way to fastforward all tracking branches after a fetch
Date: Mon, 12 Dec 2011 11:24:22 +0100
Message-ID: <4EE5D656.20400@gmail.com>
References: <jbvj5o$skt$1@dough.gmane.org> <7vmxay5h0g.fsf@alter.siamese.dyndns.org> <4EE5D3CD.6020604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 12 11:24:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ra33y-0000gX-SI
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 11:24:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386Ab1LLKYq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 05:24:46 -0500
Received: from lo.gmane.org ([80.91.229.12]:45858 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750934Ab1LLKYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 05:24:45 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1Ra33s-0000fA-44
	for git@vger.kernel.org; Mon, 12 Dec 2011 11:24:44 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 11:24:44 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 12 Dec 2011 11:24:44 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 ""
In-Reply-To: <4EE5D3CD.6020604@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186903>

I forgot one other use case:

- wanting to pull from tracking branches without fastforwarding is not
such a smart idea.

of course I can do
git merge from  remotes/origin/branch
but this is more to type and would vary depending on whether 'd like to
pull from an unpushed tracking branch or from a freshly fetched tracking
branch.


On 12/12/2011 11:13 AM, Gelonida N wrote:
> Thanks for this rather long answer,
> 
> On 12/12/2011 09:09 AM, Junio C Hamano wrote:
>> Gelonida N <gelonida@gmail.com> writes:
>>
>>> What is the best way to fastforward all fastforwardable tracking
>>> branches after a git fetch?
>>
>> This lacks context and invites too many tangents, so I'll only touch a few
>> of them.
>>
>> First of all, why do you want to do this?
>>
> 
> To explain the scenario:
> - small project
> - every person works on master and multiple topic branches
>    and might alternate rather often
> - sometimes several persons work on the same topic branch
>   but most of the time not in parallel.
> - one person is working from several machines (starting work on
>   one and continuing on another)
> - additionally we do many pushed in order to be sure,
>   that our data is backed up in case of disk failures.
> - sometimes I just want to 'build' from a branch, that I am not
>    working on. but there I create mostly not even a tracking branch
> 
> before changing a machine I want to be sure to have pushed everything. I
> wanted to get rid of the warning, that some branches cannot be pushed,
> because they aren't fastforwarded
> 
> when checking out a branch I want to avoid, that I have to pull manually.
> 
> 
> 
>> In other words, wouldn't a post-checkout hook be a better place to do
>> this kind of thing, perhaps like this (completely untested)? 
>>
>>     #!/bin/sh
>>     old=$1 new=$2 kind=$3
>>
>>     # did we checkout a branch?
>>     test "$kind" = 1 || exit 0
>>
>>     # what did we check out?
>>     branch=$(git symbolic-ref HEAD 2>/dev/null) || exit 0
>>
>>     # does it track anything? otherwise nothing needs to be done
>>     upstream=$(git for-each-ref --format='%(upstream)' "$branch")
>>     test -z "$upstream" || exit 0
>>
>>     # are we up-to-date? if so no need to do anything
>>     test 0 = $(git rev-list "..$upstream" | wc -l) && exit 0
>>
>>     # do we have something we made? if so no point trying to fast-forward
>>     test 0 = $(git rev-list "$upstream.." | wc -l) || exit 0
>>
>>     # attempt a fast-forward merge with it
>>     git merge --ff-only @{upstream}
>>
> 
> This is a solution, I wouldn't get rid of the warnings though when
> running git push.
> 
