Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FD0C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4BA120776
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 14:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727170AbgC3OBg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 10:01:36 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:36354 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgC3OBg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Mar 2020 10:01:36 -0400
Received: from [92.30.123.115] (helo=[192.168.1.38])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1jIuyq-0005KD-7o; Mon, 30 Mar 2020 15:01:32 +0100
Subject: Re: Feature request: rebase -i inside of rebase -i
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        George Spelvin <lkml@SDF.ORG>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20200320223015.GA19579@SDF.ORG>
 <xmqq36a2bpxz.fsf@gitster.c.googlers.com> <20200320233528.GB19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003211135380.46@tvgsbejvaqbjf.bet>
 <20200321175612.GC19579@SDF.ORG>
 <nycvar.QRO.7.76.6.2003252008490.46@tvgsbejvaqbjf.bet>
 <20200326001821.GB8865@SDF.ORG>
 <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <0eef4721-1646-48f2-1102-71159d06b049@iee.email>
Date:   Mon, 30 Mar 2020 15:01:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2003281510260.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On 28/03/2020 14:25, Johannes Schindelin wrote:
> Hi George,
>
> On Thu, 26 Mar 2020, George Spelvin wrote:
>
>> On Wed, Mar 25, 2020 at 08:26:48PM +0100, Johannes Schindelin wrote:
>>> On Sat, 21 Mar 2020, George Spelvin wrote:
>>>> My assumption has been that, for simplicity, there would only be one
>>>> commit in progress, and aborting it aborts everything.
>>> But that does not necessarily make sense. Imagine that you rebase the
>>> latest three commits, interactively. Then a merge conflict in the third
>>> makes you realize that the first commit is no longer needed.
>>>
>>> Enter the nested rebase. You manually re-schedule the failed `pick` via
>>> `git rebase --edit-todo` and then run the nested rebase: `git reset --hard
>>> && git rebase -i --nested HEAD~2`.
>>>
>>> Except that you made a typo and said `HEAD~3` instead of `HEAD~2`. You
>>> delete the entire todo list to get a chance to restart the nested rebase.
>>>
>>> But now the entire rebase gets aborted?
>> Um, this example is not persuasive.  If I just leave the excess commit at
>> the front of the to-do list, then it will be recreated without change.
> There are _many_ ways to mess up a nested rebase, including (but not
> limited to) `--onto`, forgetting `-r`, editing the todo list too much in
> an editor without undo.
>
> If you are suggesting that a nested `git rebase -i` would not need a way
> to abort _just_ the nested rebase, then I fear we must stop the
> conversation right here. That's not going to fly.
>
>> (Note that if I choose too *small* a nubmer by accident, I can insert a
>> "break" at the front of the list and then rebase --nested starting from
>> there.)
> There are many ways how a savvy user would be able to work around the
> absence of a proper way to abort a nested rebase. The common theme for all
> of those is:
>
> - they are all quite involved and require knowledge of internals
>
> - they won't change the fact that it would be seriously negligent for us
>   to _not_ offer a way to abort nested rebases.
>
Perhaps we can go the other way on this one.

I'd agree that attempting to nest (misunderstood mistaken) rebases is
digging a too deep hole that we'd not get out of. However we do have
other rebases available, specifically the "rebasing merges"
https://git-scm.com/docs/git-rebase#_rebasing_merges.

I know rebasing merges is way down the man page, but it has all the
power and flexibility needed _if_ we can step across from the mistaken
rebase step (we are at the command prompt aren't we?) into the rebasing
merge mode.

This will require a little bit of expansion of the insn (instruction)
sheet so as to _include commented lines of the rebase steps completed_
so far, along with the labels, resets, merges, etc, so that the user can
_see_ where they they are within their failed progress (along with a
title line telling them their initial command and that they are now on a
rebasing merge insn;-).

From there they can update the insn to reset back to the correct point,
redo the correct picks, and then get back to their remaining rebase steps.

It's a thought anyway.

HTH

Philip


