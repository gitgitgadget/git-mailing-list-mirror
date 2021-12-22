Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA01C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242029AbhLVWv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:51:28 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51947 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241984AbhLVWv2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:51:28 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A804B10EBF5;
        Wed, 22 Dec 2021 17:51:27 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=E2dmsqrw1mJbJrj1ynYH1/AHP5FFQyFp6+azJlKqq70=; b=dULJ
        UBLDlVLkPxNFSd7XhB2hwyfjDg6BhpKD8tP7BqFwQgt+Roc8dSZ44pcjuJQ4sSV6
        n7ywnQEBmf33Rq2twTJRnuVNQL9yC6pDeO3hsWHsM6yCZgzIRd5CdFAxqONgUEpu
        cUDzdIhD9x/8ja5ZlGegeUXxK0TTRh0IKiN1BLw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F3BD10EBF4;
        Wed, 22 Dec 2021 17:51:27 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08FC810EBF3;
        Wed, 22 Dec 2021 17:51:26 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 01/16] reftable: fix OOB stack write in print functions
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <e7f1be7bbec0427d5c10453631c3486936ed2bf0.1640199396.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:51:25 -0800
Message-ID: <xmqq8rwcfe36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B20659BE-6379-11EC-8092-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/record.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/reftable/record.c b/reftable/record.c
> index 6a5dac32dc6..8536bd03aa9 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -254,7 +254,7 @@ static void hex_format(char *dest, uint8_t *src, int hash_size)
>  void reftable_ref_record_print(struct reftable_ref_record *ref,
>  			       uint32_t hash_id)
>  {
> -	char hex[2 * GIT_SHA256_RAWSZ + 1] = { 0 }; /* BUG */
> +	char hex[GIT_MAX_HEXSZ + 1] = { 0 }; /* BUG */
>  	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
>  	switch (ref->value_type) {
>  	case REFTABLE_REF_SYMREF:
> @@ -586,7 +586,7 @@ static struct reftable_record_vtable reftable_obj_record_vtable = {
>  void reftable_log_record_print(struct reftable_log_record *log,
>  			       uint32_t hash_id)
>  {
> -	char hex[GIT_SHA256_RAWSZ + 1] = { 0 };
> +	char hex[GIT_MAX_HEXSZ + 1] = { 0 };
>  
>  	switch (log->value_type) {
>  	case REFTABLE_LOG_DELETION:

Wow.  The first one is future-proofing in case we learn to use even
larger hash, but the latter is an outright bug that makes reviewers
feel embarrassed, isn't it?

Thanks for noticing and fixing it.

