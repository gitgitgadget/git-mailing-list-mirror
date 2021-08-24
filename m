Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FFEC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:27:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDC461178
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:27:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234668AbhHXU2Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 16:28:24 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63345 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXU2X (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 16:28:23 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 56FF21517F4;
        Tue, 24 Aug 2021 16:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CIhscdd/I4OGINfH8ZyuDJa9Dc5Sjzi7Yqhc95
        uPy/I=; b=yb6EZ6Q3KT81aMLja7WA1tv+iT7X7Z3st6uWqRsYEaEWryBJKnFDNF
        4sqzPYuqPSbQkvom5pLej3BkZYhoohw82hw3WUxQh5x+SkLqAiMJ/Edx40NSL1tH
        P4gJ1QaL2fUAR48znPWUfqSTomXvZyAhKORCrjGQYKd2ewsJB9bq8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4F6B71517F3;
        Tue, 24 Aug 2021 16:27:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.116.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 96D791517F2;
        Tue, 24 Aug 2021 16:27:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        jonathantanmy@google.com
Subject: Re: [PATCH v4 05/25] midx: clear auxiliary .rev after replacing the
 MIDX
References: <cover.1617991824.git.me@ttaylorr.com>
        <cover.1629821743.git.me@ttaylorr.com>
        <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
Date:   Tue, 24 Aug 2021 13:27:34 -0700
In-Reply-To: <771741844be3570395abfda813ed5ef2fa78332e.1629821743.git.me@ttaylorr.com>
        (Taylor Blau's message of "Tue, 24 Aug 2021 12:16:02 -0400")
Message-ID: <xmqqa6l6oafd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B851B4B2-0519-11EC-BC80-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> When writing a new multi-pack index, write_midx_internal() attempts to
> clean up any auxiliary files (currently just the MIDX's `.rev` file, but
> soon to include a `.bitmap`, too) corresponding to the MIDX it's
> replacing.
>
> This step should happen after the new MIDX is written into place, since
> doing so beforehand means that the old MIDX could be read without its
> corresponding .rev file.
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  midx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/midx.c b/midx.c
> index 321c6fdd2f..73b199ca49 100644
> --- a/midx.c
> +++ b/midx.c
> @@ -1086,10 +1086,11 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
>  
>  	if (flags & MIDX_WRITE_REV_INDEX)
>  		write_midx_reverse_index(midx_name, midx_hash, &ctx);
> -	clear_midx_files_ext(the_repository, ".rev", midx_hash);
>  
>  	commit_lock_file(&lk);
>  
> +	clear_midx_files_ext(the_repository, ".rev", midx_hash);

This needs to take object_dir into account, no?

There are a few more calls to clear_midx_files_ext() added in 15/25
and they use the_repository, too.

>  cleanup:
>  	for (i = 0; i < ctx.nr; i++) {
>  		if (ctx.info[i].p) {
