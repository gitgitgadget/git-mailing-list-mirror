Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75788C433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 07:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbhLUHWf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 02:22:35 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:56008 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbhLUHWe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 02:22:34 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AD55E173AFA;
        Tue, 21 Dec 2021 02:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6xvKwZ2EklfY7DceJEYTMw1+aEhWTzp9CVH7K1
        mAVrA=; b=oeCnWk5la8xoBwxZIhmNeADC1spVdaAvh4BOjZj3e4AqruScHmaiom
        hCjT8WRbBLZ6uTctUuqXrERnl36KFwOXk4RqBnzpCVjKZJDcA6PEluuemVYj/KDf
        IVQUdua4qRmRraqt3l+UiLIonhnmm5zfvGLlIgOffwjHfwIb44FJ8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 99956173AF9;
        Tue, 21 Dec 2021 02:22:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DE14E173AF8;
        Tue, 21 Dec 2021 02:22:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/9] trace2: convert tr2tls_thread_ctx.thread_name from
 strbuf to char*
References: <pull.1099.git.1640012469.gitgitgadget@gmail.com>
        <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
Date:   Mon, 20 Dec 2021 23:22:29 -0800
In-Reply-To: <3a4fe07e40e967622035844ff10ded1ed71d94fc.1640012469.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Mon, 20 Dec 2021
        15:01:02 +0000")
Message-ID: <xmqqsfumqv62.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C2493C34-622E-11EC-B1B6-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Use a 'char *' to hold the thread name rather than a 'struct strbuf'.
> The thread name is set when the thread is created and should not be
> be modified afterwards.  Replace the strbuf with an allocated pointer
> to make that more clear.

Sounds good.  Use of strbuf is perfectly fine while you compute the
final value of the string, but as a more permanent location to store
the result, it often is unsuitable (and strbuf_split_buf() is a prime
example of how *not* to design your API function around the type).

> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
> index 7da94aba522..cd8b9f2f0a0 100644
> --- a/trace2/tr2_tls.c
> +++ b/trace2/tr2_tls.c
> @@ -35,6 +35,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>  					     uint64_t us_thread_start)
>  {
>  	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
> +	struct strbuf buf_name = STRBUF_INIT;
>  
>  	/*
>  	 * Implicitly "tr2tls_push_self()" to capture the thread's start
> @@ -47,12 +48,13 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>  
>  	ctx->thread_id = tr2tls_locked_increment(&tr2_next_thread_id);
>  
> -	strbuf_init(&ctx->thread_name, 0);
>  	if (ctx->thread_id)
> -		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
> -	strbuf_addstr(&ctx->thread_name, thread_name);
> -	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
> -		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);
> +		strbuf_addf(&buf_name, "th%02d:", ctx->thread_id);
> +	strbuf_addstr(&buf_name, thread_name);
> +	if (buf_name.len > TR2_MAX_THREAD_NAME)
> +		strbuf_setlen(&buf_name, TR2_MAX_THREAD_NAME);
> +
> +	ctx->thread_name = strbuf_detach(&buf_name, NULL);

This is not exactly a new problem, but if we use a mechanism to
allow arbitrary long string (like composing with strbuf and
detaching the resulting string as is), instead of having a fixed
name[] array embedded in the ctx structure, I wonder if applying the
maximum length this early makes sense.  Such a truncation would
allow more than one ctx structures to share the same name, which
somehow feels error prone, inviting a mistake to use .thread_name
member as an identifier, when its only intended use is to give a
human-readable and not necessarily unique label.  Of course, if the
maximum is reasonably low, like a few dozen bytes, it may even make
sense to embed an array of the fixed size and not worry about an
extra pointer.

> diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
> index a90bd639d48..d968da6a679 100644
> --- a/trace2/tr2_tls.h
> +++ b/trace2/tr2_tls.h
> @@ -9,7 +9,7 @@
>  #define TR2_MAX_THREAD_NAME (24)
>  
>  struct tr2tls_thread_ctx {
> -	struct strbuf thread_name;
> +	char *thread_name;

That is, something like

	char thread_name[TR2_MAX_THREAD_NAME + 1];

perhaps with moving it to the end of the struct to avoid padding
waste, would make more sense than the posted patch, if we accept
an early truncation and information loss.

The other extreme would also make equally more sense than the posted
patch.  Just grab strbuf_detach() result without truncation and
point at it with "char *thread_name" here, and if the output layer
wants to limit the names to some reasonable length, deal with the
TR2_MAX_THREAD_NAME at that layer, without losing information too
early.  It might be a much bigger surgery, I am afraid, because the
users of ctx->thread_name (and old ctx->thread_name.buf) all are
relying on the string being shorter than TR2_MAX_THREAD_NAME.

>  	uint64_t *array_us_start;
>  	size_t alloc;
>  	size_t nr_open_regions; /* plays role of "nr" in ALLOC_GROW */
