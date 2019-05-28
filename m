Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8B391F462
	for <e@80x24.org>; Tue, 28 May 2019 20:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727456AbfE1UbM (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 16:31:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52457 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbfE1UbL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 16:31:11 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 33D391454C4;
        Tue, 28 May 2019 16:31:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=stzaB2yglRvR+1o7DBOQieNTaN4=; b=CekPEn
        3FOtLRWHozYe/QJSUIIHQyouomrx8/E5KkMaJxKKAhSe49ZM8Lq2QtyeYW7/+RlL
        /mBOEzSQKYMay27JLHGo95Pxc05CFNe1/iDVzu+kzHupbOtbZCvFXWT9iFQcim78
        gFbrahanAZnisl8AAOaZb8pL+6Q7nAeEuIDng=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kzODIDT9f1g3Av/aie0I9KDyvb4S7fFz
        TmEpvBFUrx+UuTJuCAZpvq7wE/DhIW5dayRpb+DABqUpAyL8eJCnMnwwUk0Ehgjj
        XOeL/prJ8bo3rWa9xH7O8V80YT1TwLUQjQAIEt3MuNHTCrrKoROprQw9mRgSnTGU
        ROx0goztjDQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B2F41454C3;
        Tue, 28 May 2019 16:31:09 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73F621454C1;
        Tue, 28 May 2019 16:31:08 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/1] sha1-file: split OBJECT_INFO_FOR_PREFETCH
References: <pull.228.git.gitgitgadget@gmail.com>
        <2737e62966cae2f00d75a93446bad76e5816d07e.1559056745.git.gitgitgadget@gmail.com>
Date:   Tue, 28 May 2019 13:31:07 -0700
In-Reply-To: <2737e62966cae2f00d75a93446bad76e5816d07e.1559056745.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Tue, 28 May 2019
        08:19:07 -0700 (PDT)")
Message-ID: <xmqqblzm1fuc.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8647E2E2-8187-11E9-9289-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The OBJECT_INFO_FOR_PREFETCH bitflag was added to sha1-file.c in 0f4a4fb1
> (sha1-file: support OBJECT_INFO_FOR_PREFETCH, 2019-03-29) and is used to
> prevent the fetch_objects() method when enabled.
>
> However, there is a problem with the current use. The definition of
> OBJECT_INFO_FOR_PREFETCH is given by adding 32 to OBJECT_INFO_QUICK. This is
> clearly stated above the definition (in a comment) that this is so
> OBJECT_INFO_FOR_PREFETCH implies OBJECT_INFO_QUICK. The problem is that using
> "flag & OBJECT_INFO_FOR_PREFETCH" means that OBJECT_INFO_QUICK also implies
> OBJECT_INFO_FOR_PREFETCH.

So the right test to see prefetch is in effect is not

	if (!!(flag & TWO_BITS))

but to use

	if ((flag & TWO_BITS) == TWO_BITS)

instead?

> Split out the single bit from OBJECT_INFO_FOR_PREFETCH into a new
> OBJECT_INFO_SKIP_FETCH_OBJECT as the single bit and keep
> OBJECT_INFO_FOR_PREFETCH as the union of two flags. This allows a clearer use
> of flag checking while also keeping the implication of OBJECT_INFO_QUICK.

OK, I guess that would work and with far less damage to the existing
code.

>
> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> ---
>  object-store.h | 10 +++++++---
>  sha1-file.c    |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/object-store.h b/object-store.h
> index dd3f9b75f0..c90628d839 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -282,10 +282,14 @@ struct object_info {
>  #define OBJECT_INFO_IGNORE_LOOSE 16
>  /*
>   * Do not attempt to fetch the object if missing (even if fetch_is_missing is
> - * nonzero). This is meant for bulk prefetching of missing blobs in a partial
> - * clone. Implies OBJECT_INFO_QUICK.
> + * nonzero).
>   */
> -#define OBJECT_INFO_FOR_PREFETCH (32 + OBJECT_INFO_QUICK)
> +#define OBJECT_INFO_SKIP_FETCH_OBJECT 32
> +/*
> + * This is meant for bulk prefetching of missing blobs in a partial
> + * clone. Implies OBJECT_INFO_SKIP_FETCH_OBJECT and OBJECT_INFO_QUICK
> + */
> +#define OBJECT_INFO_FOR_PREFETCH (OBJECT_INFO_SKIP_FETCH_OBJECT | OBJECT_INFO_QUICK)
>  
>  int oid_object_info_extended(struct repository *r,
>  			     const struct object_id *,
> diff --git a/sha1-file.c b/sha1-file.c
> index ad02649124..0299fdd516 100644
> --- a/sha1-file.c
> +++ b/sha1-file.c
> @@ -1371,7 +1371,7 @@ int oid_object_info_extended(struct repository *r, const struct object_id *oid,
>  		/* Check if it is a missing object */
>  		if (fetch_if_missing && repository_format_partial_clone &&
>  		    !already_retried && r == the_repository &&
> -		    !(flags & OBJECT_INFO_FOR_PREFETCH)) {
> +		    !(flags & OBJECT_INFO_SKIP_FETCH_OBJECT)) {
>  			/*
>  			 * TODO Investigate having fetch_object() return
>  			 * TODO error/success and stopping the music here.
