Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DB5C4332F
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 21:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbiJMVNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbiJMVNJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 17:13:09 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B0DB192BA7
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 14:12:44 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6A81B1BDD43;
        Thu, 13 Oct 2022 17:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=h1Hy66nPeJSPNPnK7tkNDh4bpOQT92HEIP3674xE+jc=; b=Seb7
        8e1tZqBZmV2hOuw56OcJ/NiWuogcg9tKE14+ISoVcQHiWQIz64f0sSZHYZzc3Mkn
        Ge0aj3vvsqrafXrvmdwumUEmoQPSE45KaJzPhS+FlwNAnf7XFVkVGpmOrC+pjPqe
        J8adsiDEtPjYMIB6Q1DXuh0xSLxVu9eQvwrjOB8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 623681BDD42;
        Thu, 13 Oct 2022 17:12:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 979251BDD41;
        Thu, 13 Oct 2022 17:12:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 4/7] trace2: rename the thread_name argument to
 trace2_thread_start
References: <pull.1373.git.1664900407.gitgitgadget@gmail.com>
        <pull.1373.v2.git.1665600750.gitgitgadget@gmail.com>
        <637b422b8606b3b6d954e6a1959aae450507cdfa.1665600750.git.gitgitgadget@gmail.com>
Date:   Thu, 13 Oct 2022 14:12:35 -0700
Message-ID: <xmqqtu47ctrw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C3139866-4B3B-11ED-B022-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Rename the `thread_name` argument in `tr2tls_create_self()` and
> `trace2_thread_start()` to be `thread_base_name` to make it clearer
> that the passed argument is a component used in the construction of
> the actual `struct tr2tls_thread_ctx.thread_name` variable.
>
> The base name will be used along with the thread id to create a
> unique thread name.
> ...
> -struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
> +struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_base_name,
>  					     uint64_t us_thread_start)
>  {
>  	struct tr2tls_thread_ctx *ctx = xcalloc(1, sizeof(*ctx));
> @@ -50,7 +50,7 @@ struct tr2tls_thread_ctx *tr2tls_create_self(const char *thread_name,
>  	strbuf_init(&ctx->thread_name, 0);
>  	if (ctx->thread_id)
>  		strbuf_addf(&ctx->thread_name, "th%02d:", ctx->thread_id);
> -	strbuf_addstr(&ctx->thread_name, thread_name);
> +	strbuf_addstr(&ctx->thread_name, thread_base_name);
>  	if (ctx->thread_name.len > TR2_MAX_THREAD_NAME)
>  		strbuf_setlen(&ctx->thread_name, TR2_MAX_THREAD_NAME);

This hunk is very illustrative and highlights the difference between
thread_base_name parameter and .thread_name member in the context.

Good.

