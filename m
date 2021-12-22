Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB51BC433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:51:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241992AbhLVWvY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:51:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61568 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbhLVWvW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:51:22 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 01923102D45;
        Wed, 22 Dec 2021 17:51:22 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=SSAHQxaj0GGDE1x9sqjbkJZbQiFMz466Lg8ZJG5UyyE=; b=BYoZ
        3Dm7AT3PEm18KsUZayvErZCKc90BsBskoP5SeYwqH7JZJ+Yoiu77/kATYi/43A3U
        FcmpGnFGoDZvwXTpODqnyKCL+f29OwMqBG4Gw/hPPq51nG3ncGMOjjzY2s7TzYzJ
        BI/E/SMUf0VF4YxmTEsSB822wYT8FP6wSTbdFNE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE0C3102D44;
        Wed, 22 Dec 2021 17:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 598BE102D43;
        Wed, 22 Dec 2021 17:51:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 10/16] reftable: handle null refnames in
 reftable_ref_record_equal
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <67d858ec59e1c62d5e227e85e117b3cfcb3dda2a.1640199396.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:51:20 -0800
Message-ID: <xmqqfsqkfe3b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AEA4460A-6379-11EC-89DD-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Spotted by Coverity.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/record.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>
> diff --git a/reftable/record.c b/reftable/record.c
> index 8536bd03aa9..8bbcbff1e69 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -1154,9 +1154,11 @@ int reftable_ref_record_equal(struct reftable_ref_record *a,
>  			      struct reftable_ref_record *b, int hash_size)
>  {
>  	assert(hash_size > 0);
> -	if (!(0 == strcmp(a->refname, b->refname) &&
> -	      a->update_index == b->update_index &&
> -	      a->value_type == b->value_type))
> +	if (!null_streq(a->refname, b->refname))
> +		return 0;
> +
> +	if (a->update_index != b->update_index ||
> +	    a->value_type != b->value_type)
>  		return 0;

The original assumed that the .refname member of these two records
are filled, so strcmp() would have segfaulted if they were set to
NULL, which equates to an empty string.  I assume that this patch
is to fix that and change nothing else?

The original said: we'll make an early return with 0 unless
all three conditions hold true; (1) names are the same, (2)
update_index members are the same, and (3) value_type members
are the same.

We now say, "we return early with 0 if names are different", and "we
also return early with 0 if update-index or value-type members are
different".

I just found the splitting into two separate statements looked
different from the original, but they do mean the same, so it is OK.

In fact, I think the !(A && B && C) is much less readable than
(!A || !B || !C) in this case, so I am OK with the new version.

Looking good.  Thanks.

