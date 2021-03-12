Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713E4C4332D
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B07A64FDD
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233453AbhCLKXO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:23:14 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51985 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233314AbhCLKWq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 05:22:46 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C81D2127179;
        Fri, 12 Mar 2021 05:22:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=cyHMvBCfuJUCBPMcW8Qd081Jpho=; b=LPBkybqgFv4npSxGkEpl
        MdPH3joZpCTCmdR0Kzcsokid8DFoMxov67tfy7ILfQbhewl2UZSLm/+kKT6wWOo+
        B1+OKToXPve4qiDqp8VA7JYbhg7Dmx2OjE2zvgXmYH0Hk+3MrWdCDvw6drH+EV5O
        bmo5DtFdjqGNGOEKW5kgkgk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=eaORQvYAf4TjUd/82uGycQxPKj1jVat+SwIIjN3qYbEuDa
        7scdaEA9VPc0a9RKevd7aVNlKsQEb4xVtrftX4npcWxNW8vC3VHPVr5kBsXxWbbw
        0Vg0gqA+nVO7nTAEMCn9WRhyW2ef5Dsr8Uumll1bple/Gk4FYgMWmYQYlgAQk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BFDED127178;
        Fri, 12 Mar 2021 05:22:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 14206127177;
        Fri, 12 Mar 2021 05:22:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 18/37] commit: use config-based hooks
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-19-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 02:22:41 -0800
Message-ID: <xmqq5z1w8ydq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E18716F8-831C-11EB-8EC7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> -int run_commit_hook(int editor_is_used, const char *index_file,
> +int run_commit_hook(int editor_is_used, int parallelize, const char *index_file,
>  		    const char *name, ...)
>  {
> -	struct strvec hook_env = STRVEC_INIT;
> +	struct run_hooks_opt opt;
>  	va_list args;
> +	const char *arg;
>  	int ret;
>  
> -	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);
> +	run_hooks_opt_init_sync(&opt);
> +
> +	if (parallelize)
> +		opt.jobs = configured_hook_jobs();
> +
> +	strvec_pushf(&opt.env, "GIT_INDEX_FILE=%s", index_file);
>  
>  	/*
>  	 * Let the hook know that no editor will be launched.
>  	 */
>  	if (!editor_is_used)
> -		strvec_push(&hook_env, "GIT_EDITOR=:");
> +		strvec_push(&opt.env, "GIT_EDITOR=:");
>  
>  	va_start(args, name);
> -	ret = run_hook_ve(hook_env.v, name, args);
> +	while ((arg = va_arg(args, const char *)))
> +		strvec_push(&opt.args, arg);
>  	va_end(args);
> -	strvec_clear(&hook_env);
> +
> +	ret = run_hooks(name, &opt);
> +	run_hooks_opt_clear(&opt);
>  
>  	return ret;
>  }

This follows the textbook pattern established earlier and
demonstrated in [v8 08/37].  opt_init() to initialize, populate its
members, call run_hooks() and finally opt_clear().

Quite nicely demonstrated.

