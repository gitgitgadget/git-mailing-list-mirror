Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FFAC2D0E4
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:59:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 088EF2222E
	for <git@archiver.kernel.org>; Tue, 17 Nov 2020 19:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BbJtkzWd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgKQT7g (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Nov 2020 14:59:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57071 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgKQT7f (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Nov 2020 14:59:35 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C74249E825;
        Tue, 17 Nov 2020 14:59:31 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SVvzG4Hz67JXBg1g2GMJqqTeC9k=; b=BbJtkz
        WdRbKFUeNwXBsrfvUfLBCAgpInQ8XaSjyDtPHbdPLbnqpPxMI4db9mu4oHL94Opq
        ei+9hVnoaMjGvjFp+jS/D6PvuDw+ok3rd8hSWWDYnTYOxMkYgzCQXQvTRyUeoCl9
        GcAAiP9tV5U9otKoXj7Z20HRJfBU2L65XJyuE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Qh1/heD1ze2JRzU91BzeuRlA38tD25bm
        SJVabgyl4Ql1pbJwIinZb0bQMJQdm0fQWiDOVqzPPQppvOXEL/zw6fsvnZ9AGbWq
        VMI99mwKpLPp/Ar8q9FZbm5iYxlv/5pQTMfC+DSyWFTSbb4xJA+ZVDOpVxMGKcrf
        JNekCTvqPjQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BEA4A9E824;
        Tue, 17 Nov 2020 14:59:31 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 391CB9E823;
        Tue, 17 Nov 2020 14:59:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] hooks: allow input from stdin
References: <pull.790.git.1605625363309.gitgitgadget@gmail.com>
Date:   Tue, 17 Nov 2020 11:59:30 -0800
In-Reply-To: <pull.790.git.1605625363309.gitgitgadget@gmail.com> (Orgad Shaneh
        via GitGitGadget's message of "Tue, 17 Nov 2020 15:02:43 +0000")
Message-ID: <xmqqh7pn69gd.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 681707B8-290F-11EB-BEEC-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Let hooks receive user input if applicable.
>
> Closing stdin originates in f5bbc3225 (Port git commit to C,
> 2007). Looks like the original shell implementation did have
> stdin open. Not clear why the author chose to close it on
> the C port (maybe copy&paste).

For "git commit" leaving the standard input open and let hook
interact with the end-user sitting at the terminal might be OK, but
doing this for any and all hooks probably breaks callers of hooks
that deal with transport protocols where their standard input is
*not* supposed to be molested (think: the main Git process is about
to read a packstream over the network and spawns a hook using the
standard run_hook*() interface---if the hook reads standard input,
the main process would lose the initial part of the pack stream).

> The only hook that passes internal information to the hook
> via stdin is pre-push, which has its own logic.

Hmph, doesn't "pre-receive" hook gets information from its standard
input?  In any case, it is natural that such hooks can and have to
be able to read from their standard input---they are spawned with
their input connected to Git process that feeds them input that are
necessary for them to make decision, so comparing them with random
other hooks that do not use information from Git to do their thing
is comparing apples and oranges.

So I think the patch we see as-is is probably not a good idea,
primarily because it lets run_hook_ve() to pretend that it still is
a generic interface to run any hooks by sitting in run_command.c,
but now its behaviour has been tweaked to fit only needs by "git
commit" and the like.  You probably need to add a new "options"
parameter to run_hook_ve() that allows the callers to say "this hook
is allowed to read from the standard input" etc., if we want to keep
it in run_command.c and let it pretend to be generally useful
interface.

Another possibility is to remove run_hook_ve(), and open code its
body in commit.c::run_commit_hook(), but that is less than ideal.

> Some references of users requesting this feature. Some of
> them use acrobatics to gain access to stdin:
> [1] https://stackoverflow.com/q/1067874/764870
> [2] https://stackoverflow.com/q/47477766/764870
> [3] https://stackoverflow.com/q/3417896/764870
> [4] https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/3165
> [5] https://github.com/typicode/husky/issues/442

Instead of wasting 7 lines here, it would be a much better approach
to just add a test or two that demonstrate sample usages and that
protect this new feature from accidentally getting broken at the
same time.

>     The only hook that passes internal information to the hook via stdin is
>     pre-push, which has its own logic.

>     
>     Some references of users requesting this feature. Some of them use
>     acrobatics to gain access to stdin: [1] 
>     https://stackoverflow.com/q/1067874/764870[2] 
>     https://stackoverflow.com/q/47477766/764870[3] 
>     https://stackoverflow.com/q/3417896/764870[4] 
>     https://github.com/FriendsOfPHP/PHP-CS-Fixer/issues/3165[5] 
>     https://github.com/typicode/husky/issues/442
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-790%2Forgads%2Fhooks-stdin-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-790/orgads/hooks-stdin-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/790
>
>  run-command.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/run-command.c b/run-command.c
> index 2ee59acdc8..a17b613216 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -1356,7 +1356,6 @@ int run_hook_ve(const char *const *env, const char *name, va_list args)
>  	while ((p = va_arg(args, const char *)))
>  		strvec_push(&hook.args, p);
>  	hook.env = env;
> -	hook.no_stdin = 1;
>  	hook.stdout_to_stderr = 1;
>  	hook.trace2_hook_name = name;
>  
>
> base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
