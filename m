Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCAC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 23:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234982AbiAMXpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Jan 2022 18:45:05 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62413 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiAMXpF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jan 2022 18:45:05 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBDC1161504;
        Thu, 13 Jan 2022 18:45:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CXCjy0bcxGCYgYzHWVegVNHoriEExcghLS11uZ
        YtR9U=; b=k7R2Sf3P0sMpsEq/ya43btz/zs9Mhtr879/1guTQ1UXo0CWVL8uiR5
        MjdbUMqaWrUTHs7vigZxRUCwKnuSZYzPxsA2nDIMYpYLAM13VVAQJVtiJUTBn4c2
        mSBxwilSX4kDK5DOYDpErsimTsRkql3pMs/0c9Vba4hPy3JpI6V3o=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B43A8161503;
        Thu, 13 Jan 2022 18:45:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9E497161501;
        Thu, 13 Jan 2022 18:45:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH] promisor-remote.c: use oidset for deduplication
References: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com>
Date:   Thu, 13 Jan 2022 15:45:00 -0800
In-Reply-To: <pull.1187.git.git.1642105926064.gitgitgadget@gmail.com> (John
        Cai via GitGitGadget's message of "Thu, 13 Jan 2022 20:32:05 +0000")
Message-ID: <xmqqilunfber.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D32AAA70-74CA-11EC-8F9F-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/object-file.c b/object-file.c
> index 8be57f48de7..baec8f099de 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1519,6 +1519,7 @@ static int do_oid_object_info_extended(struct repository *r,
>  	struct cached_object *co;
>  	struct pack_entry e;
>  	int rtype;
> +	struct oidset to_fetch = OIDSET_INIT;
>  	const struct object_id *real = oid;
>  	int already_retried = 0;
>  
> @@ -1587,7 +1588,8 @@ static int do_oid_object_info_extended(struct repository *r,
>  			 * TODO Investigate checking promisor_remote_get_direct()
>  			 * TODO return value and stopping on error here.
>  			 */
> -			promisor_remote_get_direct(r, real, 1);
> +			oidset_insert(&to_fetch, real);
> +			promisor_remote_get_direct(r, &to_fetch);
>  			already_retried = 1;
>  			continue;
>  		}

Everything that migrated from oid_array to oidset should be OK
because it is likely that existing oid_array_clear() would not
compile until it is replaced with oidset_clear(), at which point
the oidset will be cleared when we are done with it.

However, this one did not use an oid_array and did not have to clear
to release the resources.  So it is very likely that nobody clears
to_fetch that is introduced by this patch, no?

I suspect that this introduces a new leak.
