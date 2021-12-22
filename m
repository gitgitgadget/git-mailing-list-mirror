Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B8FEC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 22:50:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241892AbhLVWuY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 17:50:24 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56185 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbhLVWuY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 17:50:24 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D82E7151E6F;
        Wed, 22 Dec 2021 17:50:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vtp9rogFcuUT4Hc7KkvY4q0yxOz3tDcEQwKhLa
        xm7a8=; b=kVNcuY/yYpS1v+vYyoDpgoFAT20na7SppTsuCPx4WnHhYsnnztPBg2
        Wd0f4aoixm3PtjBkT4HMQsHVeZMgA9U6iPeyDq7jjdyj4Na7G6K4ky9NZOkk94qm
        x0akB4U1SqeIvJAhIZ9Bx4D0OAcMQLF6VtoJ+DFVUQgAe+9Qf3yrY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D05B7151E6D;
        Wed, 22 Dec 2021 17:50:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3903C151E68;
        Wed, 22 Dec 2021 17:50:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH v5 16/16] reftable: be more paranoid about 0-length
 memcpy calls
References: <pull.1152.v4.git.git.1639482476.gitgitgadget@gmail.com>
        <pull.1152.v5.git.git.1640199396.gitgitgadget@gmail.com>
        <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:50:18 -0800
In-Reply-To: <e16bf0c5212ae85daa0d6aa2c78d551824b542bd.1640199396.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Wed, 22 Dec 2021
        18:56:36 +0000")
Message-ID: <xmqq1r24gsph.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A34196C-6379-11EC-9054-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  reftable/record.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/reftable/record.c b/reftable/record.c
> index fbaa1fbef56..423e687b220 100644
> --- a/reftable/record.c
> +++ b/reftable/record.c
> @@ -126,7 +126,8 @@ static int encode_string(char *str, struct string_view s)
>  	string_view_consume(&s, n);
>  	if (s.len < l)
>  		return -1;
> -	memcpy(s.buf, str, l);
> +	if (l)
> +		memcpy(s.buf, str, l);
>  	string_view_consume(&s, l);
>  
>  	return start.len - s.len;
> @@ -153,7 +154,9 @@ int reftable_encode_key(int *restart, struct string_view dest,
>  
>  	if (dest.len < suffix_len)
>  		return -1;
> -	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
> +
> +	if (suffix_len)
> +		memcpy(dest.buf, key.buf + prefix_len, suffix_len);
>  	string_view_consume(&dest, suffix_len);
>  
>  	return start.len - dest.len;
> @@ -569,7 +572,8 @@ static int reftable_obj_record_decode(void *rec, struct strbuf key,
>  	uint64_t last;
>  	int j;
>  	r->hash_prefix = reftable_malloc(key.len);
> -	memcpy(r->hash_prefix, key.buf, key.len);
> +	if (key.len)
> +		memcpy(r->hash_prefix, key.buf, key.len);
>  	r->hash_prefix_len = key.len;
>  
>  	if (val_type == 0) {

I am not sure why any of these are needed.

For a code path that involves a <ptr, len> pair, where ptr is lazily
allocated only when we have contents to store, i.e. ptr can remain
NULL until len becomes non-zero, memcpy(dst, ptr, len) can become a
problem as the standard requires ptr to be a valid even when len is
0 (ISO/IEC 9899:1999, 7.21.1 String function conventions, paragraph
2), but none of these three calls to memcpy() do any such thing.

Puzzled.
