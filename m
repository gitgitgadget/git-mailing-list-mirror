Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E550F1F454
	for <e@80x24.org>; Fri,  8 Nov 2019 05:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725794AbfKHF2z (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Nov 2019 00:28:55 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61743 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfKHF2z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Nov 2019 00:28:55 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 74AD59C062;
        Fri,  8 Nov 2019 00:28:53 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iiyYJLAw6iS52bgVqQHk21z9N00=; b=FYAzDo
        bEs49mErey4ejM++PLEt9RfaVZAAZmW3yqVx/zSY1CEaLDxrresr9+dsLi2+PJLy
        0FT8jdl7VQdmq8F9qUOrzoWd1R6u0BJGl//Sv3pWp+vBjdLZp6cRvrkDGOtJMUVR
        ALgLCRQGxEGLOVhAVDFapDZC7DbYPd/PePumc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y5jyOrt4LOu2uVqa7tY40nIAD2sA0q6q
        y0tzJZ5PbV6lsfcs4Zsg+BY9Z3MO3hIWlbnN/y1059q+lvBmaSoQu9getQ72u9bb
        KKGlUillnsyxx0t/fK3HDGHVMFna6n0rqYzhc89BWSSPcEtXdInlwiJ9E3LP1/BW
        vyZIL2ZhAGI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6CD879C061;
        Fri,  8 Nov 2019 00:28:53 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9D9CA9C05D;
        Fri,  8 Nov 2019 00:28:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Subject: Re: [PATCH 3/3] commit: give correct advice for empty commit during a rebase
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
        <0d168b4a75c65e786f4b14f5da723957c32fa390.1571787022.git.gitgitgadget@gmail.com>
        <9d550cd9-08a2-eee5-7d7f-63678285accc@gmail.com>
        <nycvar.QRO.7.76.6.1910251341550.46@tvgsbejvaqbjf.bet>
        <df0e77e9-b764-690e-c814-5d90fb141def@gmail.com>
Date:   Fri, 08 Nov 2019 14:28:48 +0900
In-Reply-To: <df0e77e9-b764-690e-c814-5d90fb141def@gmail.com> (Phillip Wood's
        message of "Fri, 25 Oct 2019 15:01:19 +0100")
Message-ID: <xmqqwocblywf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A55D4276-01E8-11EA-8E5E-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Phillip Wood <phillip.wood123@gmail.com> writes:

>>> I don't this patch can distinguish between an empty cherry-pick
>>> performed by the user while a rebase is in progress and an empty pick
>>> performed by rebase as both create CHERRY_PICK_HEAD while
>>> .git/rebase-merge exists. It seems to assume that CHERRY_PICK_HEAD was
>>> created by rebase and prints advise based on that which may or may not
>>> be the correct. I think we could distinguish the two by checking if
>>> CHERRY_PICK_HEAD matches .git/rebase-merge/stopped-sha or REBASE_HEAD.
>>
>> I guess we could, but then, I would rather worry about that in the next
>> cycle. In this cycle, I would rather fix the common case, which is that
>> a `git rebase -i` fails and tells me to `git cherry-pick --skip` instead
>> of `git rebase --skip`.
>>
>> And even if I performed a `git cherry-pick` during a `git rebase` and
>> the result would be an empty commit, I'd rather be told to `git rebase
>> --skip` to continue...
>>
>> But if you feel strongly that this should be fixed differently, I'll
>> gladly leave it to you ;-)
>
> I'm happy to wait until the next cycle once we've decided what to do
> about CHERRY_PICK_HEAD during rebases.

So, is that agreed between the two?  

Should I eject js/advise-rebase-skip topic out of my tree and wait
for the decision wrt CHERRY_PICK_HEAD?

Thanks.
