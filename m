Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0813C43467
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 761FB221FE
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 18:34:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="UCMlZYTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392028AbgJPSeo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 14:34:44 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52785 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391999AbgJPSem (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 14:34:42 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 325601006DB;
        Fri, 16 Oct 2020 14:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=HjGlNSOI5T+vEse77c1BBEiXBRU=; b=UCMlZY
        TKcm3EEKmfXkTmR4HEkYO20+ReBpk3w/Pyl5/jw0MLnq+z1H+rproJX2e9SdB2cv
        j6CuMNsexbB3Al9cTUf5yA9lP4FjFVQmPx3bqHRMrjGIjI8yLMfyXsvq7pB/IgJz
        L4Oa3y2bF2iv4tVGC0N7uEyGQR4kwM3+YqQ50=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wkHCdWaqS1UJ4Cz14WYR4LDBcJhgc9vT
        Y1W/nTzkPCn3u1ZqztH7BBW0koJBHDzo4C4i0fo+R/BOf7cKY1aIY5N1LM9v8QuD
        phw9HEIvuYrk8Pw91wY1JjTHulqSesCEFfxMU/o7gfDlN1qbn1VBv11YD3cRi1dC
        7NSeTDlsybY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2A2731006DA;
        Fri, 16 Oct 2020 14:34:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 707361006D8;
        Fri, 16 Oct 2020 14:34:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] commit: use config-based hooks (config-based hooks part
 II)
References: <20201014232517.3068298-1-emilyshaffer@google.com>
Date:   Fri, 16 Oct 2020 11:34:34 -0700
In-Reply-To: <20201014232517.3068298-1-emilyshaffer@google.com> (Emily
        Shaffer's message of "Wed, 14 Oct 2020 16:25:17 -0700")
Message-ID: <xmqq4kmuc951.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E25F094-0FDE-11EB-8949-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> @@ -983,7 +984,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
>  		return 0;
>  	}
>  
> -	if (!no_verify && find_hook("pre-commit")) {
> +	if (!no_verify && hook_exists("pre-commit", configured_hookdir_opt())) {

So, the migration from find_hook(), which is the traditional "only
on the filesystem in $GIT_DIR/hooks", to hook_exists(), which knows
the ones defined in the configuration files, is the same as the
previous round's.  Understood.

> diff --git a/commit.c b/commit.c
> index f53429c0ac..b338f50103 100644
> --- a/commit.c
> +++ b/commit.c
> @@ -21,6 +21,7 @@
>  #include "commit-reach.h"
>  #include "run-command.h"
>  #include "shallow.h"
> +#include "hook.h"
>  
>  static struct commit_extra_header *read_commit_extra_header_lines(const char *buf, size_t len, const char **);
>  
> @@ -1635,8 +1636,11 @@ int run_commit_hook(int editor_is_used, const char *index_file,
>  {
>  	struct strvec hook_env = STRVEC_INIT;
>  	va_list args;
> +	const char *arg;
> +	struct strvec hook_args = STRVEC_INIT;
>  	int ret;
>  
> +
>  	strvec_pushf(&hook_env, "GIT_INDEX_FILE=%s", index_file);

Noise.

> @@ -1646,9 +1650,13 @@ int run_commit_hook(int editor_is_used, const char *index_file,
>  		strvec_push(&hook_env, "GIT_EDITOR=:");
>  
>  	va_start(args, name);
> -	ret = run_hook_ve(hook_env.v, name, args);
> +	while ((arg = va_arg(args, const char *)))
> +		strvec_push(&hook_args, arg);
>  	va_end(args);
> +
> +	ret = run_hooks(hook_env.v, name, &hook_args, configured_hookdir_opt());

And this is the calling convention change.  Generally speaking,
run_hook_ve() and friends (does it still have friends?) are on their
way out, and run_hooks() will be the only thing we need to learn in
the future.

> diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> index b3485450a2..fc93bc3d23 100755
> --- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> +++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
> @@ -5,8 +5,8 @@ test_description='pre-commit and pre-merge-commit hooks'
>  . ./test-lib.sh
>  
>  HOOKDIR="$(git rev-parse --git-dir)/hooks"
> -PRECOMMIT="$HOOKDIR/pre-commit"
> -PREMERGE="$HOOKDIR/pre-merge-commit"
> +PRECOMMIT="$(pwd)/$HOOKDIR/pre-commit"
> +PREMERGE="$(pwd)/$HOOKDIR/pre-merge-commit"

What makes this change necessary?  Are we going to chdir around or
something?  Isn't the configuration file the ONLY thing that needs
to know their full location?

Should and does hook.*.command configuration honor ~ expansion?  I
think our $TRASH_DIRECTORY is our $HOME during tests, so 

	git config hook.foo.command "~/.git/hooks/success.sample"

might be a worthy thing to test.  Also, do we have a clear
definition on what happens to a relative pathname specified for the
hook commands, or is it left "undefined--do not do that"?  If the
former, that would also be worth testing.  I'd imagine that majority
of hooks defined in ~/.gitconfig WILL point at full path so testing
relative path may not matter too much for that particular use case,
but for ones defined in .git/config, I suspect it would be most
natural to take it as relative to the root of the working tree.

It may be a good change in the longer term, but it felt surprising
to see such a change that would affect 103-5=98 lines of existing
tests was made centrally here, without any explanation in the
proposed log message.

Thanks.

>  # Prepare sample scripts that write their $0 to actual_hooks
>  test_expect_success 'sample script setup' '
> @@ -103,6 +103,19 @@ test_expect_success 'with succeeding hook' '
>  	test_cmp expected_hooks actual_hooks
>  '
>  
> +# NEEDSWORK: when 'git hook add' and 'git hook remove' have been added, use that
> +# instead
> +test_expect_success 'with succeeding hook (config-based)' '
> +	test_when_finished "git config --unset hook.pre-commit.command success.sample" &&
> +	test_when_finished "rm -f expected_hooks actual_hooks" &&
> +	git config hook.pre-commit.command "$HOOKDIR/success.sample" &&
> +	echo "$HOOKDIR/success.sample" >expected_hooks &&
> +	echo "more" >>file &&
> +	git add file &&
> +	git commit -m "more" &&
> +	test_cmp expected_hooks actual_hooks
> +'
> +
>  test_expect_success 'with succeeding hook (merge)' '
>  	test_when_finished "rm -f \"$PREMERGE\" expected_hooks actual_hooks" &&
>  	cp "$HOOKDIR/success.sample" "$PREMERGE" &&
