Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70306EB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:35:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjFTVfn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjFTVfm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:35:42 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F47A170D
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:35:41 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C729A23688;
        Tue, 20 Jun 2023 17:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jZE47nEutAjPrttgtJywTj1c6d48IbkU34sMc9
        pZnfw=; b=XE6DCIOw2Fo17Rmm9ZC511tB7/dXSR4cWMdH/i/JoOK/eOia7h9wCN
        QvkLcXABBA+xrBVIxEwXBeAMIFsQWA1Rq0RgKvxHodp0yj+79xuXDmoomfCH6hOM
        bRwAIXMFjBEdeBjYfE20uzqEfuLMNjDAQ0FteUpCY7i0YMGgf99l8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BF4E023687;
        Tue, 20 Jun 2023 17:35:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E057623686;
        Tue, 20 Jun 2023 17:35:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 06/12] builtin/config.c: test misuse of format_config()
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <a2a891a069f46d3d77cafe61f64402c93cffaae4.1687290233.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 14:35:36 -0700
In-Reply-To: <a2a891a069f46d3d77cafe61f64402c93cffaae4.1687290233.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 20 Jun 2023 19:43:45
        +0000")
Message-ID: <xmqq4jn1lsuv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 65AA9666-0FB2-11EE-89CA-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> current_config_*() functions aren't meant to be called outside of
> config callbacks because they read state that is only set when iterating
> through config.

Interesting.  And config_context is about expressing the state of
the iteration, so presumably some of these callers that do not have
config_context to pass (because they happen outside iterations) will
now (can|have to) pass NULL or something to say "I am asking format
but from outside any iteration" or something?

> +test_expect_success 'urlmatch with --show-scope' '
> +	cat >.git/config <<-\EOF &&
> +	[http "https://weak.example.com"]
> +		sslVerify = false
> +		cookieFile = /tmp/cookie.txt
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	unknown	http.cookiefile /tmp/cookie.txt
> +	unknown	http.sslverify false
> +	EOF
> +	git config --get-urlmatch --show-scope HTTP https://weak.example.com >actual &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'urlmatch favors more specific URLs' '
>  	cat >.git/config <<-\EOF &&
>  	[http "https://example.com/"]
> @@ -2055,6 +2070,10 @@ test_expect_success '--show-origin blob ref' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success '--show-origin with --default' '
> +	test_must_fail git config --show-origin --default foo some.key
> +'
> +
>  test_expect_success '--show-scope with --list' '
>  	cat >expect <<-EOF &&
>  	global	user.global=true
> @@ -2123,6 +2142,12 @@ test_expect_success '--show-scope with --show-origin' '
>  	test_cmp expect output
>  '
>  
> +test_expect_success '--show-scope with --default' '
> +	git config --show-scope --default foo some.key >actual &&
> +	echo "unknown	foo" >expect &&
> +	test_cmp expect actual
> +'
> +
>  test_expect_success 'override global and system config' '
>  	test_when_finished rm -f \"\$HOME\"/.gitconfig &&
>  	cat >"$HOME"/.gitconfig <<-EOF &&
