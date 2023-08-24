Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E33FC3DA66
	for <git@archiver.kernel.org>; Thu, 24 Aug 2023 01:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239003AbjHXBUJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Aug 2023 21:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbjHXBTi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Aug 2023 21:19:38 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687AA8
        for <git@vger.kernel.org>; Wed, 23 Aug 2023 18:19:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CE9E1A304B;
        Wed, 23 Aug 2023 21:19:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2tkMLPpLdZo2mhr7wr58ekbypox2N7OyKZicIG
        QAz3I=; b=g+9wLGvpfYG6J4OhyM54ITqjVlOKUJWean2mwBjxkLY4O55Gd+Ko9Q
        65snOCXnKz7AA7spwRdYk0uG1tRb1qRMMDK7ix9TFoc45h81wb5nQWaV1R26ygl6
        IlJqEfyO5U5IOmKyPUiPn23Q584W91TcsTGOVR3a1jGyw8ppmexYI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 833EF1A304A;
        Wed, 23 Aug 2023 21:19:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E9AF01A3049;
        Wed, 23 Aug 2023 21:19:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, jonathantanmy@google.com,
        calvinwan@google.com, glencbz@gmail.com
Subject: Re: [PATCH v2 2/4] config: report config parse errors using cb
References: <pull.1551.git.git.1689891436.gitgitgadget@gmail.com>
        <cover.1692827403.git.steadmon@google.com>
        <cb92a1f2e3098bede386d04da32fcc4f27fca51f.1692827403.git.steadmon@google.com>
Date:   Wed, 23 Aug 2023 18:19:33 -0700
In-Reply-To: <cb92a1f2e3098bede386d04da32fcc4f27fca51f.1692827403.git.steadmon@google.com>
        (Josh Steadmon's message of "Wed, 23 Aug 2023 14:53:49 -0700")
Message-ID: <xmqqttspck4a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49345A20-421C-11EE-8102-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> From: Glen Choo <chooglen@google.com>
>
> In a subsequent commit, config parsing will become its own library, and
> it's likely that the caller will want flexibility in handling errors
> (instead of being limited to the error handling we have in-tree).

And the in-tree error handling is abstracted out as the
git_config_err_fn() function; in other words, we become the first
client of the library interface, which makes sense.

> @@ -1035,8 +1088,6 @@ static int git_parse_source(struct config_source *cs, config_fn_t fn,
>  	int comment = 0;
>  	size_t baselen = 0;
>  	struct strbuf *var = &cs->var;
> ...
> +	/*
> +	 * FIXME for whatever reason, do_event passes the _previous_ event, so
> +	 * in order for our callback to receive the error event, we have to call
> +	 * do_event twice
> +	 */
> +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> +	do_event(cs, CONFIG_EVENT_ERROR, &event_data);
> +	return -1;
>  }

This indeed is very curious and needs to be looked into before we
proceed further.  How does the current control flow cope with the
behaviour?

> @@ -2322,7 +2342,9 @@ void read_early_config(config_fn_t cb, void *data)
>   */
>  void read_very_early_config(config_fn_t cb, void *data)
>  {
> -	struct config_options opts = { 0 };
> +	struct config_options opts = {
> +		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
> +	};
>  
>  	opts.respect_includes = 1;
>  	opts.ignore_repo = 1;

This uses a bit more assignments to various members of opts. to
initialize it, which could have been done with designated
initializer, like the one in read_protected_config() used to do.

> @@ -2760,12 +2784,14 @@ int repo_config_get_pathname(struct repository *repo,
>  static void read_protected_config(void)
>  {
>  	struct config_options opts = {
> -		.respect_includes = 1,
> -		.ignore_repo = 1,
> -		.ignore_worktree = 1,
> -		.system_gently = 1,
> +		.parse_options = CP_OPTS_INIT(CONFIG_ERROR_DIE),
>  	};
>  
> +	opts.respect_includes = 1;
> +	opts.ignore_repo = 1;
> +	opts.ignore_worktree = 1;
> +	opts.system_gently = 1;
> +

It is curious why you want to switch to manual assignment, instead
of keeping the designated initializer for this one.  I would have
expected the initialization in read_very_early_config() to start
using designated initializer to be consistent, instead.

Thanks.
