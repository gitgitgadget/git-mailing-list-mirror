Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9989C4338F
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:38:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C69560200
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 16:38:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhGWP5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 11:57:47 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61008 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhGWP5r (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 11:57:47 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5100A154F3A;
        Fri, 23 Jul 2021 12:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=h+3qbUnqUsWh/PwxnGPc1+5UIRx2+PEQswXcVs
        X4HNU=; b=IfEYwjtrva2ZRav3GxAnhQXh4WdvgMA+QKccPKGkauPa6VxiMhMVpD
        9fgfkt5iXkpTbz7j0H7UAj1qAWrXlqfBhTlpAikb23hpgEBvn2RoiQGXGU7yap7u
        BsIsnxU7zMsiyKlKU+2+FNOmSHnGtIsLGpwSx854YCqSZyMBTRdDU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 488A7154F39;
        Fri, 23 Jul 2021 12:38:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8ED31154F38;
        Fri, 23 Jul 2021 12:38:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v2 2/5] [GSOC] ref-filter: add %(raw) atom
References: <pull.1000.git.1626939557.gitgitgadget@gmail.com>
        <pull.1000.v2.git.1627031043.gitgitgadget@gmail.com>
        <eafb79bad62f13fc8fd70ba1dce3e8fbab870e52.1627031043.git.gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 09:38:15 -0700
In-Reply-To: <eafb79bad62f13fc8fd70ba1dce3e8fbab870e52.1627031043.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Fri, 23 Jul 2021 09:04:00
        +0000")
Message-ID: <xmqqh7glouiw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6214883A-EBD4-11EB-B2A8-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  struct atom_value {
>  	const char *s;
> +	size_t s_size;
>  	int (*handler)(struct atom_value *atomv, struct ref_formatting_state *state,
>  		       struct strbuf *err);
>  	uintmax_t value; /* used for sorting when not FIELD_STR */
>  	struct used_atom *atom;
>  };
>  
> +#define ATOM_VALUE_INIT { \
> +	.s_size = -1 \
> +}

This will get turned into size_t that is unsigned, and comparisons
like this one and ...

>  	case QUOTE_NONE:
> -		strbuf_addstr(s, str);
> +		if (len != -1)
> +			strbuf_add(s, str, len);
> +		else
> +			strbuf_addstr(s, str);

this one ...

> +		if (v->s_size != -1)
> +			strbuf_add(&state->stack->output, v->s, v->s_size);
> +		else
> +			strbuf_addstr(&state->stack->output, v->s);
>  	return 0;
>  }

may work as expected, but it makes readers wonder if there is
significance to negative values other than -1 (in other words, what
does it mean if v->s_size == -2, for example?).

It may make sense to 

 * Turn atom_value.s_size field into ssize_t instead of size_t

 * Rewrite (v->s_size != -1) comparison to (v->s_size < 0)


Optionally we could introduce #define ATOM_SIZE_UNSPECIFIED (-1) and
use it to initialize .s_size in ATOM_VALUE_INIT, but if we are just
going to test "is it negative, then it is not given", then it probably
is not needed.

Other changes in the whole series relative to what has been queued
looked all sensible to me.

THanks.




   
