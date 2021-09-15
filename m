Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F584C433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 21:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E38E60F13
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 21:01:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbhIOVDF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 17:03:05 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52710 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbhIOVDF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 17:03:05 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 92D0715198B;
        Wed, 15 Sep 2021 17:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=FfDzQiY7dIeHUX6wZH8N5nQX9k1966iKWtgaYK
        Teu3o=; b=Cv5vs2nN0keXRULR33LVpHscw9A6fM7TBUwzuiNpuieXNbisHaOQGN
        eDrwOPgrCi813hRSlFxKYLtnwiEpNtDhmTYJBlJNiLLxp2K2p2bQ/M87g9Y412eE
        JaLgBTwuxDJvIfwhVZsH8Cpce4AdMJuRlwKKS0aEoCH60i+SPiRCk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8B1B215198A;
        Wed, 15 Sep 2021 17:01:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C1665151988;
        Wed, 15 Sep 2021 17:01:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/7] trace2: fix memory leak of thread name
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
        <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
Date:   Wed, 15 Sep 2021 14:01:39 -0700
In-Reply-To: <5f557caee004f22cee33e8753063f0315459d7e1.1631738177.git.gitgitgadget@gmail.com>
        (Jeff Hostetler via GitGitGadget's message of "Wed, 15 Sep 2021
        20:36:11 +0000")
Message-ID: <xmqqa6kdwo24.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2105A87E-1668-11EC-B828-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Do not leak the thread name (contained within the thread context) when
> a thread terminates.
>
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  trace2/tr2_tls.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
> index 067c23755fb..7da94aba522 100644
> --- a/trace2/tr2_tls.c
> +++ b/trace2/tr2_tls.c
> @@ -95,6 +95,7 @@ void tr2tls_unset_self(void)
>  
>  	pthread_setspecific(tr2tls_key, NULL);
>  
> +	strbuf_release(&ctx->thread_name);
>  	free(ctx->array_us_start);
>  	free(ctx);
>  }

So the idea is create allocates a new instance, and unset is to
release the resource held by it?

This is not a problem in _this_ patch but more about the base code
that is being fixed here, but using strbuf as thread_name member
sends a strong signal that it is designed to be inexpensive to
change thread_name after a context is created by create_self.  If
it is not the case, the member should be "const char *", which may
be computed using a temporary strbuf in create_self() and taken from
the strbuf with strbuf_detach(), I would think.

Thanks.
