Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 34D111F461
	for <e@80x24.org>; Tue,  2 Jul 2019 19:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbfGBTaM (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jul 2019 15:30:12 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:23561 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726150AbfGBTaM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jul 2019 15:30:12 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45dZ8041X7z5tl9;
        Tue,  2 Jul 2019 21:30:08 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id AAB4C1AEB;
        Tue,  2 Jul 2019 21:30:07 +0200 (CEST)
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        git@vger.kernel.org
References: <20190630051816.8814-1-eantoranz@gmail.com>
 <20190630065358.GB31264@sigill.intra.peff.net>
 <xmqq36jp7gd8.fsf@gitster-ct.c.googlers.com>
 <2cece7ff-49af-0cae-7cb8-7cc1821be1ca@gmail.com>
 <xmqqr2784alt.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <e8a39f00-7f88-7c32-ac18-12f17faf2c72@kdbg.org>
Date:   Tue, 2 Jul 2019 21:30:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqqr2784alt.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.07.19 um 19:20 schrieb Junio C Hamano:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> On 7/1/2019 2:35 PM, Junio C Hamano wrote:
>>> Jeff King <peff@peff.net> writes:
>>>
>>>>> First, we create a (temporary) merge commit of both branches (M3)
>>>>>
>>>>> ------------
>>>>> 	R1---R2---R3---R4---R5---R6---R7---M3
>>>>> 	 \         \              \       /
>>>>> 	  F1---F2---M1---F3---F4---M2---F5
>>>>> ------------
>>>>>
>> ...
>>> If M3 merge is always easier to manage than incremental stepwise
>>> rebase of the topic, then doing the "git merge --reverse-squash"
>>> would be a saner interface and also conceptually simpler.
>>
>> I agree that this would be a better way to expose this behavior,
>> and likely the implementation could be very clean.
> 
> What I was sort-of hoping to get comments on was actually something
> else.
> 
> Would there be cases where the merge M3 gets unmanageably complex
> even if rebasing the feature commits one by one is relatively simple
> (and how often would that happen)?  "merge --squash" would not work
> well (and extending the command to merge in a different direction
> would not help) in such a situation, but "rebase -i" would work
> much better (and "imerge" would, too).

I've come across the situation occasionally. Once I have resolved a
bunch of conflicts in M1 and M2, I think twice whether I should rebase
individual commits; it is typically much more tedious.

A common situation is that a line is "A" in F1, "B" in F2, and "C" in
R3; then I have to resolve ONE conflict in M1 ("<B=C>"), but with
individual commits rebased on top of R3, I have two conflicts, "<C=A>"
and "<AC=B>", neither of which is helped by rerere.

After merges M1 and M2, it is all a done deal, and M3 is typically a
much simpler merge than the sum of conflicts incurred by the individual
commits. I would generally not recommend a rebase in this situation.

But I wouldn't turn M3 into a squashed merged commit, either, as long as
F1...F5 aren't messy.

-- Hannes
