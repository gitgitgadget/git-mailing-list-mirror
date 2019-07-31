Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B001F731
	for <e@80x24.org>; Wed, 31 Jul 2019 17:52:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbfGaRwd (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 13:52:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54319 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729476AbfGaRwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 13:52:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3FEAA16DD64;
        Wed, 31 Jul 2019 13:52:31 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zpjf/TBewRhzr58MYkWJ1vmttqQ=; b=b8VNnZ
        laHlcXm4PVaLHxwGDl3b0tjMxwymxWlsqAooY6aqu16T5e7qS2mJr3aqX13v41qR
        MRHZQH8hzHd9Tu/Y1FEsFKz2nX2gfNNO+8Zw6kmWl7dbqSfZLTOOQXO4fchhTxXK
        jJuLHESNsuayk47parfhBLgKEdeIPMPLCRRIE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=oQDMaThkfenVvMaGiR93B7t9RLZGrB0n
        VZGEvvU7spwIvuBDfNQzfZBCZbaC5+yQxO15DzhbHeTg/0TWWx3HiNNnWeOTDUIy
        ksapxHWxtZb/ZOsyVF8jBoO+52P3J7SJDefjvCkOIhcPsQGS9VDpsqE2piDyUemc
        8M6P7DiUf4I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3781416DD63;
        Wed, 31 Jul 2019 13:52:31 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9331016DD62;
        Wed, 31 Jul 2019 13:52:30 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <git@jeffhostetler.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 01/11] Start to implement a built-in version of `git add --interactive`
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
        <0a5ec9345d2f9cc6cd348231219d4af428a28e94.1563289115.git.gitgitgadget@gmail.com>
Date:   Wed, 31 Jul 2019 10:52:29 -0700
In-Reply-To: <0a5ec9345d2f9cc6cd348231219d4af428a28e94.1563289115.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Tue, 16 Jul 2019
        07:58:37 -0700 (PDT)")
Message-ID: <xmqq1ry6qeg2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F79F8A88-B3BB-11E9-B1D1-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> +add.interactive.useBuiltin::

I am not sure if three-level name is a good thing to use here.

If we have end-user controllable (like branch or remote names)
unbounded number of subcommand/submode to "add", and "interactive"
is merely one of it, then three-level name is a perfect fit, but
otherwise, not.

> @@ -185,6 +186,14 @@ int run_add_interactive(const char *revision, const char *patch_mode,
>  {
>  	int status, i;
>  	struct argv_array argv = ARGV_ARRAY_INIT;
> +	int use_builtin_add_i =
> +		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
> +	if (use_builtin_add_i < 0)
> +		git_config_get_bool("add.interactive.usebuiltin",
> +				    &use_builtin_add_i);
> +
> +	if (use_builtin_add_i == 1 && !patch_mode)
> +		return !!run_add_i(the_repository, pathspec);

I am hoping that eventually "add -p" will also be routed to the new
codepath.  Would it make sense to have "&& !patch_mode" here,
especially at this step where run_add_i() won't do anything useful
anyway yet?

> @@ -319,6 +328,7 @@ static int add_config(const char *var, const char *value, void *cb)
>  		ignore_add_errors = git_config_bool(var, value);
>  		return 0;
>  	}
> +
>  	return git_default_config(var, value, cb);
>  }

Good addition while at it.
