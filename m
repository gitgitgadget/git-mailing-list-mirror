Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3DC4332B
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D89156500D
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 10:27:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233430AbhCLKWm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 05:22:42 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63282 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233255AbhCLKWU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 05:22:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3054DBA130;
        Fri, 12 Mar 2021 05:22:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=jPza/OUSXLdXgorr7N/GiOVnLQ4=; b=aHTLrVOHlN6pNBI1y28g
        h0Cw4xht49NzeZiwKUM5+T/j0GMYH5oKPeJXdgF73AqvLkbmrCUQJnghcvizz1Ay
        NSsxQEcK+RxIANhtlVHPPNnCyR0JFVhsUnGLRYZVbi6GcQajRaB4A5y2uQaFEsO6
        CCSsjba7Tka7hDripxrM7qo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=tuECzgSXZlHExQb2hAyEpAEdbTTtgtTYPtgWp44facrmk4
        bVRb7s+WVIp/5UoucQ8firciaHlMZjuUvcLlikda+Kfj3c1HNkoGfse4SnVMqLsz
        2vdgcUqUTIMkrvbhfkCp5fJg6Orer/ZUr4pZw7WocWuZZadixGhV+uLjmp5G8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 28D6DBA12F;
        Fri, 12 Mar 2021 05:22:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A941CBA12E;
        Fri, 12 Mar 2021 05:22:19 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v8 08/37] hook: add 'run' subcommand
References: <20210311021037.3001235-1-emilyshaffer@google.com>
        <20210311021037.3001235-9-emilyshaffer@google.com>
Date:   Fri, 12 Mar 2021 02:22:19 -0800
Message-ID: <xmqqk0qc8yec.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D3965D74-831C-11EB-A708-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> +static int run(int argc, const char **argv, const char *prefix)
> +{
> +	struct strbuf hookname = STRBUF_INIT;
> +	struct run_hooks_opt opt;
> +	int rc = 0;
> +
> +	struct option run_options[] = {
> +		OPT_STRVEC('e', "env", &opt.env, N_("var"),
> +			   N_("environment variables for hook to use")),
> +		OPT_STRVEC('a', "arg", &opt.args, N_("args"),
> +			   N_("argument to pass to hook")),
> +		OPT_END(),
> +	};
> +
> +	run_hooks_opt_init(&opt);
> +
> +	argc = parse_options(argc, argv, prefix, run_options,
> +			     builtin_hook_usage, 0);
> +
> +	if (argc < 1)
> +		usage_msg_opt(_("You must specify a hook event to run."),
> +			      builtin_hook_usage, run_options);
> +
> +	strbuf_addstr(&hookname, argv[0]);
> +	opt.run_hookdir = should_run_hookdir;
> +
> +	rc = run_hooks(hookname.buf, &opt);
> +
> +	strbuf_release(&hookname);
> +	run_hooks_opt_clear(&opt);
> +
> +	return rc;
> +}

This looks like a small and clean example that is good for people to
emulate when using the new run-hooks API.  You opt_init(), futz with
the its fields, call run_hooks(), and finally opt_clear() to release
the resources.
