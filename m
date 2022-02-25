Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F092CC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 06:57:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbiBYG6E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 01:58:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiBYG6E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 01:58:04 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EABBBF15
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 22:57:32 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4F8018736A;
        Fri, 25 Feb 2022 01:57:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5Edo+eKRNXDj4EPs2D91dQGhTks/PHcIdCH05y
        1QV88=; b=IA7Fr9ES//6XSYMtwxztsLChUrSss8u+B6kZZVIdMhF4p0X/fFnBDV
        V0RXj7V03vQQq6bnuWx1fTfQOv0F/TGtkcU4g0i6A78eKesKmLq3/mxo3CPv1eT7
        lgoGTdUEoDUfm1FyNF8z3laIUQi19i+UXUFznMdCYkwlXdwdK6e1w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 928DB187369;
        Fri, 25 Feb 2022 01:57:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id EDBD4187368;
        Fri, 25 Feb 2022 01:57:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Robert Coup via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
        John Cai <johncai86@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Robert Coup <robert@coup.net.nz>
Subject: Re: [PATCH v2 6/8] maintenance: add ability to pass config options
References: <pull.1138.git.1643730593.gitgitgadget@gmail.com>
        <pull.1138.v2.git.1645719218.gitgitgadget@gmail.com>
        <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
Date:   Thu, 24 Feb 2022 22:57:28 -0800
In-Reply-To: <cfa6dca8ef4a64b6233e3b7b6021571447fc5ba9.1645719218.git.gitgitgadget@gmail.com>
        (Robert Coup via GitGitGadget's message of "Thu, 24 Feb 2022 16:13:36
        +0000")
Message-ID: <xmqqsfs7fn6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 32EC76BA-9608-11EC-A54F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Robert Coup via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +	if (config_opts)
> +		for (i = 0; i<config_opts->nr; i++)

Style.  SP on both sides of '<'.

> +			strvec_pushl(&maint.args, "-c", config_opts->v[i], NULL);

>  	strvec_pushl(&maint.args, "maintenance", "run", "--auto", NULL);
>  	strvec_push(&maint.args, quiet ? "--quiet" : "--no-quiet");

It is unclear if it is generally a good idea to pass hardcoded set
of configuration variables to begin with, but provided if it makes
sense [*], the implementation seems OK.

	Side note.  And this is a big *IF*, as we can see in all
	other helper functions in run-commands.h, nobody has such a
	privision.  If supporting such a "feature" makes sense, we
	probably would need to do so with a common interface that
	can be used across run_command() API, not with an ad-hoc
	interface that is only usable with run_auto_maintenance(),
	which may look somewhat similar to how we have a common way
	to pass set of environment variables.

> diff --git a/run-command.h b/run-command.h
> index 07bed6c31b4..24021abd41f 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -222,8 +222,11 @@ int run_command(struct child_process *);
>  
>  /*
>   * Trigger an auto-gc
> + *
> + * config_opts is an optional list of additional config options to
> + * pass to the maintenance process in the form "some.option=value".
>   */
> -int run_auto_maintenance(int quiet);
> +int run_auto_maintenance(int quiet, const struct strvec *config_opts);
>  
>  #define RUN_COMMAND_NO_STDIN		(1<<0)
>  #define RUN_GIT_CMD			(1<<1)
n
