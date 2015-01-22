From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Pretty format specifier for commit count?
Date: Thu, 22 Jan 2015 11:10:42 +0100
Message-ID: <54C0CCA2.3060307@drmicha.warpmail.net>
References: <20150119012926.GA24004@thin> <54BD0C85.1070001@drmicha.warpmail.net> <20150120011724.GA1944@thin> <20150120214952.GA18778@peff.net> <20150120231110.GC14475@cloud>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: josh@joshtriplett.org, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 11:10:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEEix-0005AO-7z
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 11:10:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752904AbbAVKKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 05:10:47 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59519 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750897AbbAVKKo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Jan 2015 05:10:44 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailout.nyi.internal (Postfix) with ESMTP id 14C3C2094F
	for <git@vger.kernel.org>; Thu, 22 Jan 2015 05:10:44 -0500 (EST)
Received: from frontend1 ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 22 Jan 2015 05:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=x-sasl-enc:message-id:date:from
	:mime-version:to:cc:subject:references:in-reply-to:content-type
	:content-transfer-encoding; s=smtpout; bh=ym10Q1iLmC+tSZM+zSJfVW
	SqsQI=; b=XopyK+S2ZJgzXiHIlKEyvMLEwdFam2R3a1/q/A6SYexMbuCGD27jjk
	enkMAtg/6doj37lwhScQcAIUmvo2LYeptXcUyjcN74TelUQc8ovIvNkVMJJxyj6u
	/B/uoTccxSERb52CTMG1gMDF5RhRUbVDVob/vaR1aeCL9qsiLtFqA=
X-Sasl-enc: wd41M1QpZ0y23VgW5qmj0kKxXZEC3ZTipchSz4uMzhIX 1421921443
Received: from localhost.localdomain (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 719B8C00015;
	Thu, 22 Jan 2015 05:10:43 -0500 (EST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <20150120231110.GC14475@cloud>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262813>

josh@joshtriplett.org schrieb am 21.01.2015 um 00:11:
> On Tue, Jan 20, 2015 at 04:49:53PM -0500, Jeff King wrote:
>> On Mon, Jan 19, 2015 at 05:17:25PM -0800, Josh Triplett wrote:
>>
>>>> Can you be a bit more specific about the type count that you are after?
>>>> "git describe" counts commits since the most recent tag (possibly within
>>>> a specific subset of all tags). Is that your desired format?
>>>
>>> That might work, since the repository in question has no tags; I'd
>>> actually like "commits since root commit".
>>
>> That's basically a generation number. But I'm not sure if that's really
>> what you want; in a non-linear history it's not unique (two children of
>> commit X are both X+1).
> 
> That would actually be perfectly fine.  If I need to distinguish
> branches, I can either use branch/tag names, or append a commit hash.  I
> don't mind the following:
> 
>  /-B-\
> A     D
>  \-C-/
> 
> A=1
> B=C=2
> D=3
> 
> I could (and probably should) append "+hash" to the version number for
> uniqueness, and if I care what order B and C sort in, I can use tags,
> branches, or some other more clever mechanism.
> 
>> It sounds like you really just want commits
>> counting up from the root, and with side branches to have their own
>> unique numbers. So something like:
>>
>>        C
>>       /
>>   A--B--D
>>
>>   A=1
>>   B=2
>>   C=3
>>   D=4
>>
>> except the last two are assigned arbitrarily. You need some rules for
>> linearizing the commits.
> 
> I don't care about the numbers assigned to anything not reachable from
> the committish I start from.
> 
>> But that's not deterministic as you add more starting points (either new
>> ref tips, or just new merges we have to cross). For example, imagine
>> this:
>>
>>          G--H
>>         /    \
>>        C--E   \
>>       /    \   \
>>   A--B--D---F---I
>>
>> If we start at I, then we might visit H and G first, meaning we learn
>> about C much earlier than we otherwise would. Then we hit F, and get to
>> C from there. But now it it may be in a different position with respect
>> to D!
> 
> Right, the numbers need to always stay the same as you add more commits
> over time.  If walking a given graph assigns a given set of generation
> numbers, walking any subgraph should assign all the same generation
> numbers to the common nodes.
> 
>> I suspect your problem statement may simply assume a linear history,
>> which makes this all much simpler. But we are not likely to add a
>> feature to git that will break badly once you have a non-linear history. :)
> 
> Not assuming a linear history, but assuming a linear changelog file. :)
> 
>> I think in the linear case that a generation number _would_ be correct,
>> and it is a useful concept by itself. So that may be the best thing to
>> add.
> 
> Sounds good to me.
> 
> - Josh Triplett

We do have a linear history when we walk with --first-parent :)

So, for the changelog for commits "on a branch", where "on a branch" is
not the git concept but defined by "git rev-list --first-parent" (more
like hg branches), the count from root would be deterministic and the
right concept given the appropriate branch workflow.

Generation numbers are monotonous but may increase by steps greater than
1 on that "branch" if I remember them correctly. I.e., merge commits are
"weighted" by the number of commits that get merged in.

Michael
