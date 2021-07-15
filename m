Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8376C636C8
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE00C61374
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 21:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhGOVPI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 17:15:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59641 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbhGOVPI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 17:15:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 79BD213C69E;
        Thu, 15 Jul 2021 17:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UL8lYKm5LbnMCauSRSoCchyI9wUM1z10wLWylV
        jDdGk=; b=lCjJJmvrrovzskYAOyj4WpB658kxkxMuccZDnB7AzyxpBB1VW/Q0ln
        /kI5WgIJE4wv2YjRzGK5JXPmQheP/kqGUtx1U3Ds+UUqNABDBAKECblyJAkXzcoU
        MxEsLTmXxK5exzsBq4p5Qwo3QS2LUUc1qE1E6A+MaK6nvgtQbuhAI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7275113C69A;
        Thu, 15 Jul 2021 17:12:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9178213C699;
        Thu, 15 Jul 2021 17:12:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Son Luong Ngoc <sluongng@gmail.com>
Subject: Re: [PATCH 3/5] pull: handle conflicting rebase/merge options via
 last option wins
References: <pull.1047.git.git.1626316849.gitgitgadget@gmail.com>
        <3c07ce978caa832b08c6bef1c48c061e41a6fd0b.1626316849.git.gitgitgadget@gmail.com>
        <xmqq7dhrtrc2.fsf@gitster.g>
        <CABPp-BExWMSFr7CQskjKVhr5fiWCnxoaN_RaJ2Yir+36aiyBjQ@mail.gmail.com>
        <xmqqpmvjs61c.fsf@gitster.g>
        <CABPp-BE8Qiu8Sdk8FD+UcAtZnToXFOv+Y+8Rwf3DyiZP6Te-SQ@mail.gmail.com>
Date:   Thu, 15 Jul 2021 14:12:09 -0700
In-Reply-To: <CABPp-BE8Qiu8Sdk8FD+UcAtZnToXFOv+Y+8Rwf3DyiZP6Te-SQ@mail.gmail.com>
        (Elijah Newren's message of "Thu, 15 Jul 2021 13:40:04 -0700")
Message-ID: <xmqqh7gvs2mu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52351DA4-E5B1-11EB-9E9D-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Jul 15, 2021 at 12:58 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > Let me ask two questions:
>> >
>> > 1. When is it beneficial for users to set both pull.ff and pull.rebase?
>> > 2. Is it harmful to users for us to allow both to be set when we will
>> > just ignore one?
>> >
>> > I believe the answer to (1) is "never", and the answer to (2) is "yes".
>>
>> I agree (1) never gives you anything, even though it does not hurt,
>> and (2) is "meh".
>
> Okay, let's drop this series then.

Not so fast.  I did have problem with some combinations you hinted
(vaguely---so it is more like "combinations I thought you hinted"),
but making sure various combinations of options and configuration
variables work sensibly is a worthy goal to have, I would think.



