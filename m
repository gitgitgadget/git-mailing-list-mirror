Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2EA6C433F5
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 01:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbiANB0O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 20:26:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56640 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235916AbiANB0N (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 20:26:13 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4112D161C1E;
        Thu, 13 Jan 2022 20:26:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ubc5i32G0I7EGYMJpcRc35rfZb11C2iGbU273u
        dxn/A=; b=UEjT5mB5gGBXyg3RmrmnhkafANFCD5uMQYWKuLXhuypQXahhgtfMJ3
        ePptEWc6FhZLt/a9tPGqtiJq3kfXVIPTEZeWlt6WdO7HUUJH3u9ko05vNe7pxwv8
        YpVOgdFY0uvdJf9/jt0w2rsn8IwmkdqdFpRLIGkPgLlk+DaZ89p6U=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 39418161C1C;
        Thu, 13 Jan 2022 20:26:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8DE1F161C1B;
        Thu, 13 Jan 2022 20:26:10 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH 4/7] reftable: avoid writing empty keys at the block layer
References: <pull.1185.git.git.1642010868.gitgitgadget@gmail.com>
        <e4c1cc58265ca7ae7b32b9faf41324883011d1a6.1642010868.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 17:26:09 -0800
In-Reply-To: <e4c1cc58265ca7ae7b32b9faf41324883011d1a6.1642010868.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 12 Jan 2022
        18:07:45 +0000")
Message-ID: <xmqqpmovds5q.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F487E1D4-74D8-11EC-BBEF-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/reftable/block_test.c b/reftable/block_test.c
> index 4b3ea262dcb..5112ddbf468 100644
> --- a/reftable/block_test.c
> +++ b/reftable/block_test.c
> @@ -42,6 +42,11 @@ static void test_block_read_write(void)
>  			  header_off, hash_size(GIT_SHA1_FORMAT_ID));
>  	reftable_record_from_ref(&rec, &ref);
>  
> +	ref.refname = "";
> +	ref.value_type = REFTABLE_REF_DELETION;
> +	n = block_writer_add(&bw, &rec);
> +	EXPECT(n == REFTABLE_API_ERROR);
> +

The preimage of this hunk has been invalidated by your 9c498398
(reftable: make reftable_record a tagged union, 2021-12-22).

I see that the hn/reftable-coverity-fixes topic, which the commit is
a part of, has been expecting a reroll since last year---are you
plannning to rebuild that series after landing this series first?

