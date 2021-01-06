Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 977EDC433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:06:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4681423107
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 08:06:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbhAFIGG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 03:06:06 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54314 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbhAFIGG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 03:06:06 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DC7789D448;
        Wed,  6 Jan 2021 03:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=LsN63tCqoJe4MqBKim95Yuz4z7U=; b=JbrBUN9i9/S6O+btUgDj
        CMLhFabRkfTcSiv6szYxgV3Q0Z/ZpMWcOHgaKIqEpO0dbd6BQczF6q8YNFGZsiJt
        awGjVkEQmI4jGhih0+WptucyxTHvk9x0I3rNjsigLCP23qH8t/bZJF7tJfcNSbn2
        6UTk5yWwV62qPWUx1WbYnoQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=IV5nzg94mhAyHu0RNPlqPwSpS46/+HEYmv0s5rQD0BUYrA
        Cqlt1msYKQSCW+9yKasmn4wqb5ltV4GuHvGl29oUE88TgS3cOQ84RSYSQFmBt5cF
        TpuOFKZipSniYU3pk7q2MHD93RQ1yt84ogjG74BdoyNY8L9qcc+Smj2NByQmo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D32439D447;
        Wed,  6 Jan 2021 03:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4C7819D446;
        Wed,  6 Jan 2021 03:05:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] for-each-repo: do nothing on empty config
References: <pull.834.git.1609857770445.gitgitgadget@gmail.com>
        <CAPig+cQ4B6s7RzGH=1QhSc_2kKy-Mbp9fyK4VoTntdAfCT4d9A@mail.gmail.com>
        <db7bf751-7541-59b9-a3a0-ec07e28eb9de@gmail.com>
Date:   Wed, 06 Jan 2021 00:05:22 -0800
Message-ID: <xmqqa6tmtrr1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ED65A426-4FF5-11EB-8E2D-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>> Probably not worth a re-roll, but the above has higher cognitive load than:
>> 
>>     if (!value)
>>         return 0;
>>
>> which indicates clearly that the command succeeded, whereas `return
>> result` makes the reader scan all the code above the conditional to
>> figure out what values `result` could possibly hold.
>
> True. Looking at this again, it might be better to just update the
> loop to be
>
> 	for (i = 0; values && i < values->nr; i++) {
>
> which would run the loop zero times when there are zero results.

It is misleading, though.  It forces readers to first assume that
the loop body may update "values" from non-NULL to NULL in some
condition and hunt for such a code in vain.

If some clean-up starts to become needed after the loop, the "if the
value array is empty, immediately return 0" may have to be rewritten
to "if empty, jump to the clean-up part after the loop", but until
then, what Eric gave us would be the easiest to read, I would think.

> To me, "nonexistent" or "does not exist" doesn't adequately describe
> this (hypothetical) situation.
>
> Perhaps "fail-subcommand" might be better?

I wonder if "false" or "exit 1" would fit the bill.  In any case, a
comment may help, perhaps?

	test_expect_success 'do nothing and succeed on empty/missing config' '
		# if this runs even once, "false" ensures a failure
		git for-each-repo --config=bogus.config -- false
	'
