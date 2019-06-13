Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BED3B1F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732856AbfFMQLh (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:11:37 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60732 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731233AbfFMQLc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:11:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 85D3E1594B2;
        Thu, 13 Jun 2019 12:11:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=teLQWh0rQ2ZL5aUKVhGI63/5AaU=; b=R0gTG1
        AkJyBk8VuBWUTQQRyiZaYYQ7qLB2jPNO3cf+MraW6MRRuj2SuT1neeLfmHHgtsyW
        Huqpx8WLR7ksxjj9nkcKVKnl9Zvf9ydhA8lGZW1dz8M8Az6kQahdixi0whAt7TEY
        Du2ncfcO2QomNFJb301U0zK9IvaYy5Kusct14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AIgA/aI8e2oKmkexJHFrvrubS0Q7ZFFY
        GZlETfEm+5pCiLZ1pSIw4CLDEc/2WReZmlWorT+sPHjonXed5rRDYtwqcDVgxjIw
        8UQbFj8phXpXElq+xMUTfanu2MeGbiIUBZO6ypTUyb+BKu5Wx5O4hBr9pP6R8AWy
        Ykix5i+nTpw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AF961594B1;
        Thu, 13 Jun 2019 12:11:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BA8931594AF;
        Thu, 13 Jun 2019 12:11:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/4] kwset: allow building with GCC 8
References: <pull.265.git.gitgitgadget@gmail.com>
        <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Jun 2019 09:11:29 -0700
In-Reply-To: <c1527a71672056859a4613f2318bcbfce31e8b50.1560426581.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 13 Jun 2019
        04:49:45 -0700 (PDT)")
Message-ID: <xmqqmuilwjm6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7D9E10C-8DF5-11E9-AD53-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> The kwset functionality makes use of the obstack code, which expects to
> be handed a function that can allocate large chunks of data. It expects
> that function to accept a `size` parameter of type `long`.
>
> This upsets GCC 8 on Windows, because `long` does not have the same
> bit size as `size_t` there.
>
> Now, the proper thing to do would be to switch to `size_t`. But this
> would make us deviate from the "upstream" code even further, making it
> hard to synchronize with newer versions, and also it would be quite
> involved because that `long` type is so invasive in that code.
>
> Let's punt, and instead provide a super small wrapper around
> `xmalloc()`.

Yay.

The above description makes it sound as if this patch is an ugly
workaround, but I think this is "the proper thing" to do, as long as
the use of obstack stuff in this context is meant to allocate less
than MAX_LONG bytes at a time, even if long is somtimes smaller than
size_t.

Thanks.

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  kwset.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/kwset.c b/kwset.c
> index 4fb6455aca..efc2ff41bc 100644
> --- a/kwset.c
> +++ b/kwset.c
> @@ -38,7 +38,13 @@
>  #include "compat/obstack.h"
>  
>  #define NCHAR (UCHAR_MAX + 1)
> -#define obstack_chunk_alloc xmalloc
> +/* adapter for `xmalloc()`, which takes `size_t`, not `long` */
> +static void *obstack_chunk_alloc(long size)
> +{
> +	if (size < 0)
> +		BUG("Cannot allocate a negative amount: %ld", size);
> +	return xmalloc(size);
> +}
>  #define obstack_chunk_free free
>  
>  #define U(c) ((unsigned char) (c))
