Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE3C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BC9420756
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgKKHK6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:10:58 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:63928 "EHLO bsmtp2.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgKKHK6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 02:10:58 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp2.bon.at (Postfix) with ESMTPSA id 4CWG9B55TLz5tlJ;
        Wed, 11 Nov 2020 08:10:54 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 9473120FA;
        Wed, 11 Nov 2020 08:10:53 +0100 (CET)
Subject: Re: git rebase/git rebase --abort cause inconsistent state
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Eugen Konkov <kes-kes@yandex.ru>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
References: <1526558917.20201106203213@yandex.ru>
 <CABPp-BGAJiaU5aeC3sGvp3znQw1esrn9c19gyOZQBymYvNFCaw@mail.gmail.com>
 <43de6950-a33c-f3da-2a76-72719fef5af3@kdbg.org>
 <16910030549.20201109134640@yandex.ru>
 <xmqqft5icsd9.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2011102312020.18437@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ea62f9b7-483b-9187-25ee-b6116a25b757@kdbg.org>
Date:   Wed, 11 Nov 2020 08:10:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2011102312020.18437@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.11.20 um 23:28 schrieb Johannes Schindelin:
> On Mon, 9 Nov 2020, Junio C Hamano wrote:
>> Eugen Konkov <kes-kes@yandex.ru> writes:
>>
>>>> You start at branch dev. Then you use the two argument form
>>>
>>>>       git rebase dev local/dev
>>>
>>>> and when you later
>>>
>>>>       git rebase --abort
>>>
>>>> then you are not warped back to dev, but to local/dev:
>>>
>>> I suppose `git rebase --abort` should return me back to `dev`, because
>>> this is the state I was before the command. hmm... suppose it will not
>>> return to original branch when [branch] parameter is specified for git
>>> rebase
>>
>> Yes, "git rebase [--onto C] A B" has always been a short-hand for
>>
>> 	git checkout B
>> 	git rebase [--onto C] A
>>
>> which means that if the second rebase step aborts, rebase wants to
>> go back to the state before the rebase started, i.e. immediately
>> after "checkout B" was done.
>>
>> I think the root cause of the problem is that addition of the
>> "--autostash" feature (which came much later than the two-arg form)
>> was designed poorly.  If it wanted to keep the "two-arg form is a
>> mere short-hand for checkout followed by rebase" semantics to avoid
>> confusing existing users (which is probably a good thing and that
>> seems to be what the code does), then the auto-stash should have
>> been added _after_ we switch to the branch we rebase, i.e. B.  That
>> way, the stash would be applicable if the rebase gets aborted and
>> goes back to the original B, where the stash was taken from.
> 
> That makes a ton of sense to me.

Not to me. In particular, I would prefer to move away from the mental 
model "two-arg form is shorthand for checkout followed by rebase".

First of all, it does not match the mental model of inexperienced users. 
You have to have been deep in Git operations long enough to know that 
the two-arg form is implemented by an initial checkout so that the 
rebase can proceed as if it were the usual one-arg form.

Second, this initial checkout in two-arg form is not necessary at all to 
begin the rebase. As a first step, the commits to be rebased must be 
determined. For this, the traditional way is to ask for the range 
BASE..HEAD (and in order not to change this query for two-arg form, the 
checkout was added). But the commits can be determined with 
BASE..${second_arg:-HEAD} without requiring a checkout. Then the first 
unavoidable checkout is the one that goes to ONTO (with some further 
shortcuts in an interactive rebase).

I really don't give a dime for the initial checkout. After a botched 
two-arg rebase, I usually prefer that --abort brings me back to the 
branch were I was when I started, and not to the branch that was the 
second arg of the rebase.

>> In any case, the ship has long sailed, so ...

Well, then order it back. rebase is porcelain, not plumbing.

-- Hannes
