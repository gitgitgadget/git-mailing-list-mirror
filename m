Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BEC7C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 04:21:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1347C60FDA
	for <git@archiver.kernel.org>; Tue, 25 May 2021 04:21:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhEYEWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 00:22:40 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:58588 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbhEYEWj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 00:22:39 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5C3412927E;
        Tue, 25 May 2021 00:21:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fQJP44rDz9tgJxKTq4vX9akH/jBLINyfwGP/Q4
        dFr9Q=; b=dum2615AdKh8R9sYBKv0bTTv2dpX8o+2/p9MKJuo0s4jxIISRCAEgY
        vwa4R3irME8WJVUWj9BHbIGjqOmQF6cktaEBemsXBVgVY3dYbvbqtfCXNyLq5kun
        sNr2c6N8g6jysoA5gJDj7cdGcCb1nYgaa3mz4yn0guT5vCP1LgYIw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE8E912927D;
        Tue, 25 May 2021 00:21:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 34E3412927C;
        Tue, 25 May 2021 00:21:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, ajrhunt@google.com, peff@peff.net
Subject: Re: [PATCH] init: fix bug regarding ~/ expansion in init.templateDir
References: <b079bc0288429919aca482a689ee87e70b719303.1621914058.git.matheus.bernardino@usp.br>
Date:   Tue, 25 May 2021 13:21:04 +0900
In-Reply-To: <b079bc0288429919aca482a689ee87e70b719303.1621914058.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Tue, 25 May 2021 00:41:01 -0300")
Message-ID: <xmqqlf83h2a7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A059C90E-BD10-11EB-B4BC-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> We used to read the init.templateDir setting at builtin/init-db.c using
> a git_config() callback that, in turn, called git_config_pathname(). To
> simplify the config reading logic at this file and plug a memory leak,
> this was replaced by a direct call to git_config_get_value() at
> e4de4502e6 ("init: remove git_init_db_config() while fixing leaks",
> 2021-03-14). However, this function doesn't provide path expanding
> semantics, like git_config_pathname() does, so paths with '~/' and
> '~user/' are treated literally. This makes 'git init' fail to handle
> init.templateDir paths using these constructs:
>
> 	$ git config init.templateDir '~/templates_dir'
> 	$ git init
> 	'warning: templates not found in ~/templates_dir'
>
> Replace the git_config_get_value() call by git_config_get_pathname(),
> which does the '~/' and '~user/' expansions. Also add a regression test.
> Note that unlike git_config_get_value(), the config cache does not own
> the memory for the path returned by git_config_get_pathname(), so we
> must free() it.
>
> Reported on IRC by rkta.
>
> Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
> ---

The patch looks like a clean regression fix.

> +init_no_templatedir_env () {
> +	(
> +		sane_unset GIT_TEMPLATE_DIR &&
> +		NO_SET_GIT_TEMPLATE_DIR=t &&
> +		export NO_SET_GIT_TEMPLATE_DIR &&
> +		git init "$1"

	(
		sane_unset GIT_TEMPLATE_DIR &&
		NO_SET_GIT_TEMPLATE_DIR=t git init "$1"
	)

would be a shorter way to write it, but this is inheriting from the
original that used longhand, so it is OK, I guess.  We cannot lose
the subprocess because we do not want to lose GIT_TEMPLATE_DIR in
tests that run after a test that uses this function.

OK.  We could lose the outermost {} but let's take the patch as-is.

Thanks.

> +	)
> +}
> +
>  test_expect_success 'init with init.templatedir set' '
>  	mkdir templatedir-source &&
>  	echo Content >templatedir-source/file &&
>  	test_config_global init.templatedir "${HOME}/templatedir-source" &&
> -	(
> -		mkdir templatedir-set &&
> -		cd templatedir-set &&
> -		sane_unset GIT_TEMPLATE_DIR &&
> -		NO_SET_GIT_TEMPLATE_DIR=t &&
> -		export NO_SET_GIT_TEMPLATE_DIR &&
> -		git init
> -	) &&
> +
> +	init_no_templatedir_env templatedir-set &&
>  	test_cmp templatedir-source/file templatedir-set/.git/file
>  '
>  
> +test_expect_success 'init with init.templatedir using ~ expansion' '
> +	mkdir -p templatedir-source &&
> +	echo Content >templatedir-source/file &&
> +	test_config_global init.templatedir "~/templatedir-source" &&
> +
> +	init_no_templatedir_env templatedir-expansion &&
> +	test_cmp templatedir-source/file templatedir-expansion/.git/file
> +'
> +
>  test_expect_success 'init --bare/--shared overrides system/global config' '
>  	test_config_global core.bare false &&
>  	test_config_global core.sharedRepository 0640 &&
