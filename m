Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FCEC4332F
	for <git@archiver.kernel.org>; Mon, 26 Dec 2022 04:50:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiLZEq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Dec 2022 23:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiLZEqz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Dec 2022 23:46:55 -0500
Received: from relay10.mail.gandi.net (relay10.mail.gandi.net [IPv6:2001:4b98:dc4:8::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEF210E9
        for <git@vger.kernel.org>; Sun, 25 Dec 2022 20:46:51 -0800 (PST)
Received: (Authenticated sender: i@isandrew.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8C2FC240004;
        Mon, 26 Dec 2022 04:46:47 +0000 (UTC)
Message-ID: <d3859314-1b5f-5984-77d7-81f4e883b4e2@isandrew.com>
Date:   Mon, 26 Dec 2022 13:46:44 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: Theirs merge strategy
To:     rsbecker@nexbridge.com, git@vger.kernel.org
References: <5b64c7f5-59e3-f319-4efa-4624907436b6@isandrew.com>
 <007c01d91888$74673500$5d359f00$@nexbridge.com>
Content-Language: en-US
From:   git@isandrew.com
In-Reply-To: <007c01d91888$74673500$5d359f00$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/26/22 02:43, rsbecker@nexbridge.com wrote:
> On December 25, 2022 12:19 PM, Andrew wrote:
>> Would it be possible to revisit the decision to not have a "theirs"
>> merge strategy?
>>
>> I think there are legitimate reasons to use it, beyond the plenty of rope argument.
>>
>> One example is you're working with a successfully written and operating branch
>> through multiple releases, but due to some external change (product direction,
>> upstream changes) you decide that an approach in a different branch is
>> better.  You want to use the other branch, while keeping the history of the
>> successful prior releases, for all the normal reasons one wants to keep history.  A
>> hard reset wouldn't help in this case.
>>
>> The decision to remove it was to prevent people from having bad workflows.  In
>> reality, in lieu of theirs people use ours in reverse which is even worse.
>>
>> The previous discussion I found was at
>> https://marc.info/?l=git&m=121637513604413&w=2
> This use case applies more generally in some release workflows. A valid (and common in my world) workflow can have with multiple release branches, and the same pull request going to a selection of release branch. Conflicts occasionally happen in the pull request merge, but the pull request, in a high audit situation cannot be modified - conflicts are resolved later under a separate signature. The -s theirs permits the pull requests to be merged intact with no changes (as required by various audit rules).
>
I agree with the above on the risk of code leakage, that's why I use 
ours/theirs.

And just to get preliminary discussion out of the way, I found another 
discussion at https://marc.info/?l=git&m=150635053217381&w=2 .

The argument is made that using -s ours in reverse is actually a good 
workflow, when what you wanted was -s theirs.  I believe this is wrong 
on two points.

1. If you have two branches, branch-a implementing process A and 
branch-b implementing process B, simply dropping work on branch-a in 
favor of branch-b with an "ours" commit to indicate the end of branch-a 
may be fine.  However, if you have branches of differing significance, 
(say) master implementing process A and branch-b implementing process B, 
a "-s ours" merge wouldn't touch master so you would have failed your 
initial goal (make master tree equal branch-b tree).

2. Let's say you go through the acrobatics of swapping branch names 
after "merge -s ours" in commit "c".  The history of the new master 
would then indicate that you were implementing process B up until "c", 
and after that you were implementing process A, but that's _doubly_ 
incorrect.  You were implementing process A up until "c", and after the 
merge there was _no_ change.

Definitionally, a merge "incorporates changes from the named commits 
into the current branch".  A normal merge does this.  A -s theirs merge 
would do this.  A -s ours merge _doesn't_ do this, which is 
counterintuitive, unobvious (you wouldn't know this unless you inspect 
the merge commit itself), and consequently when it appears in the 
history it's hugely confusing. I would actually argue that, of the two, 
ours is the strategy that shouldn't exist.

In any case, using -s ours there's no way to view a history showing 
doing process A until a merge, then doing process B after, using normal 
conventions.

It's not my intention to convince anyone that they should incorporate 
"-s theirs" into their workflow, or even that "-s theirs" is good, just 
that other people do have decent reasons for wanting this and to ask you 
to consider reinstating the theirs strategy.

