Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48FFFC433E9
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE42D23602
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 00:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392956AbhAUAZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 19:25:38 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:50203 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403875AbhATXTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 18:19:45 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4173FF9C4;
        Wed, 20 Jan 2021 18:00:57 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=up2auwwIN0ij0IrBG75NvKL5dhU=; b=HQV4y2
        zhNc+3/NRpJWzJloxqqX1XR3NM6ifNlIEMjNRyCW/R4tfqZ7XF9wUtKkwweP9Gng
        w/2yj5CL/W3hnll8PucEZVyK518sIywSsjh4IqYAr3zRVitd0ZSdmc4sgihU6jJY
        iOiJWX9CJcGY9oyxTh8P1mfPI6HnwIzzfe0RQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cQmWRTrMuyNtcZBdDOTXkcxlZOZ5/NWP
        cgoUSmXiUnj7hZWjN1lODoy8WDBUUUP8aOGIHvp9uNSME/ZcqlzkXoNwG2N/Z8E3
        jP3h8YZsePgLGTDIOa/8FsHMAtLlNYLpPfDHeSxHEFIaqe/9HmRCGJeBnEiRJpqe
        xow/vxilDZY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D896FF9C3;
        Wed, 20 Jan 2021 18:00:57 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E43E9FF9C2;
        Wed, 20 Jan 2021 18:00:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rebase: add a config option for --no-fork-point
References: <20210120044435.53509-1-alexhenrie24@gmail.com>
Date:   Wed, 20 Jan 2021 15:00:53 -0800
In-Reply-To: <20210120044435.53509-1-alexhenrie24@gmail.com> (Alex Henrie's
        message of "Tue, 19 Jan 2021 21:44:35 -0700")
Message-ID: <xmqqturbdxi2.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 59B762B2-5B73-11EB-A502-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie <alexhenrie24@gmail.com> writes:

> @@ -1095,6 +1097,12 @@ static int rebase_config(const char *var, const char *value, void *data)
>  		return 0;
>  	}
>  
> +	if (!strcmp(var, "rebase.forkpoint")) {
> +		if (!git_config_bool(var, value))
> +			opts->fork_point = 0;
> +		return 0;
> +	}

It is curious that this code seems to deliberatly ignore

	[rebase] forkpoint = true

but honors

	[rebase] forkpoint = false

Intended?  IOW, why isn't this just like this?

	if (!strcmp(var, "rebase.forkpoint")) {
		opts->fork_point = git_config_bool(var, value);
		return 0;
	}

> @@ -1306,7 +1314,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	const char *gpg_sign = NULL;
>  	struct string_list exec = STRING_LIST_INIT_NODUP;
>  	const char *rebase_merges = NULL;
> -	int fork_point = -1;
>  	struct string_list strategy_options = STRING_LIST_INIT_NODUP;
>  	struct object_id squash_onto;
>  	char *squash_onto_name = NULL;
> @@ -1406,7 +1413,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			N_("mode"),
>  			N_("try to rebase merges instead of skipping them"),
>  			PARSE_OPT_OPTARG, NULL, (intptr_t)""},
> -		OPT_BOOL(0, "fork-point", &fork_point,
> +		OPT_BOOL(0, "fork-point", &options.fork_point,
>  			 N_("use 'merge-base --fork-point' to refine upstream")),
>  		OPT_STRING('s', "strategy", &options.strategy,
>  			   N_("strategy"), N_("use the given merge strategy")),
> @@ -1494,7 +1501,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			die(_("cannot combine '--keep-base' with '--root'"));
>  	}
>  
> -	if (options.root && fork_point > 0)
> +	if (options.root && options.fork_point > 0)
>  		die(_("cannot combine '--root' with '--fork-point'"));

Is that because of this code?

If so, perhaps the configuration parser should set the .fork_point
to (-1), so that "[rebase] forkpoint = false" that appears in your
~/.gitconfig file can be countermanded with "[rebase] forkpoint"
that is placed in .git/config for one particular project that you do
not mind using the feature?

> +test_expect_success '--fork-point and --root both given' '
> +	test_must_fail git rebase --fork-point --root 2>err &&
> +	test_i18ngrep "cannot combine" err
> +'
> +
> +test_expect_success 'rebase.forkPoint true and --root given' '
> +	test_config rebase.forkPoint true &&
> +	git rebase --root
> +'

test_expect_success 'rebase.forkPoint true overrides earlier false' '
	test_config rebase.forkPoint false &&
	test_config rebase.forkPoint true &&
	... check "git rebase" does use the fork-point feature here ...
'

Thanks.
