Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D578FEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 21:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFTVTj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 17:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjFTVTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 17:19:38 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A399D132
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 14:19:37 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 37CE123468;
        Tue, 20 Jun 2023 17:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l8l77KYB4pyxPZzn6ibbXe2nRbhpLXT1gQzBYC
        gY9no=; b=lFx7Ch2JNqG1QpwiXfxawoU58gmCsbOh4C30m0cASI8+vlCQo7r255
        EhCOzGOUdFeH67OWLZPCi5xoWKKCYCg3JJC/J1OulBSxOtYh9pA6ZZnkBBCDk99l
        IpAWYFCpqUZXEJ30EF8LlTSlslBCiu8rzGFigpIJERWaVYAY6Brvw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2EF9223467;
        Tue, 20 Jun 2023 17:19:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 466D223466;
        Tue, 20 Jun 2023 17:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <nasamuffin@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v3 04/12] config.c: pass ctx in configsets
References: <pull.1497.v2.git.git.1685472132.gitgitgadget@gmail.com>
        <pull.1497.v3.git.git.1687290231.gitgitgadget@gmail.com>
        <c5051ddc10dfa9665fbcbed30875369c4e972d17.1687290233.git.gitgitgadget@gmail.com>
Date:   Tue, 20 Jun 2023 14:19:33 -0700
In-Reply-To: <c5051ddc10dfa9665fbcbed30875369c4e972d17.1687290233.git.gitgitgadget@gmail.com>
        (Glen Choo via GitGitGadget's message of "Tue, 20 Jun 2023 19:43:43
        +0000")
Message-ID: <xmqqa5wtltlm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 274C5320-0FB0-11EE-AD44-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Glen Choo via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  static int config_read_push_default(const char *key, const char *value,
> -	const struct config_context *ctx UNUSED, void *cb)
> +	const struct config_context *ctx, void *cb)
>  {
> +	const struct key_value_info *kvi = ctx->kvi;
> +
>  	struct push_default_info* info = cb;
>  	if (strcmp(key, "remote.pushdefault") ||
>  	    !value || strcmp(value, info->old_name))
>  		return 0;
>  
> -	info->scope = current_config_scope();
> +	info->scope = kvi->scope;
>  	strbuf_reset(&info->origin);
> -	strbuf_addstr(&info->origin, current_config_name());
> -	info->linenr = current_config_line();
> +	strbuf_addstr(&info->origin, config_origin_type_name(kvi->origin_type));
> +	info->linenr = kvi->linenr;

Yay!

It is very pleasing to see these current_*() functions made
unnecessary.  This step only allows us to remove the _line() but not
yet _scope(), but as long as we lose them at the end, going one step
at a time is perfectly fine and readable.

> +const char *current_config_origin_type(void)
> +{
> +	enum config_origin_type type = CONFIG_ORIGIN_UNKNOWN;
> +
> +	if (reader_origin_type(&the_reader, &type))
> +		BUG("current_config_origin_type called outside config callback");
> +
> +	return config_origin_type_name(type);
> +}

We still rely on the fact that the_reader is a global singleton, but
that is of course OK in this early part of the series.

Looking nice.
