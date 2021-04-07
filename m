Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9550C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B09596120E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 22:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhDGWJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 18:09:45 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60550 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbhDGWJm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 18:09:42 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2BF68BCF84;
        Wed,  7 Apr 2021 18:09:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rJjMUbmAJqnrV9CIiJlyuJ6C62c=; b=rSPCyC
        sjEJ/mJWKi3bBE8EIve4F8R9yR/Nh/oXELFIYliGY5+RHed91A4wawE4//S2YpJg
        fZKKSDy1Whj88FoUWBkMqIJk/V9LHsGTdGHgLavuR0jEjcrgQkNq4XZyMuUwxWWu
        vVU1vWS2+U75w8igZkb6T/Xv8ZXW1osC+TTaI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U9dmBfe3P7+q3bRB3ZIvu0wSwU1gREL1
        k64nHFQzj4hd2p/m/dS3WbEaT4YZ6OFwYFRNiFxaT6/rstZimTMwshWtcBsmH/cW
        ZJm3ZdayjUAOBZ9oAShqmOVyuxMcpHBfMQErShpNYVcUj0lzWe22rS5m1k5tAdXE
        NZRsXC5JmQo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2354BBCF7F;
        Wed,  7 Apr 2021 18:09:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86AB0BCF7E;
        Wed,  7 Apr 2021 18:09:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Tanushree Tumane <tanushreetumane@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] bisect--helper: reimplement `bisect_run` shell
 function in C
References: <20210407173334.68222-1-mirucam@gmail.com>
        <20210407173334.68222-4-mirucam@gmail.com>
Date:   Wed, 07 Apr 2021 15:09:30 -0700
In-Reply-To: <20210407173334.68222-4-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 7 Apr 2021 19:33:32 +0200")
Message-ID: <xmqqeeflycf9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EDB00292-97ED-11EB-AE80-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

> From: Tanushree Tumane <tanushreetumane@gmail.com>
>
> Reimplement the `bisect_run()` shell function
> in C and also add `--bisect-run` subcommand to
> `git bisect--helper` to call it from git-bisect.sh.
>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Signed-off-by: Tanushree Tumane <tanushreetumane@gmail.com>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>

If I am reading the patch correctly, this removes the need for the
$GIT_DIR/BISECT_RUN file that used to be used to keep track of the
state?  If that is true, it is worth noting in the proposed log
message.

As far as I can see, nobody creates $GIT_DIR/BISECT_RUN anymore.

    $ git grep -e path_bisect_run -e BISECT_RUN
    bisect.c:static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
    bisect.c:	unlink_or_warn(git_path_bisect_run());
    builtin/bisect--helper.c:		BISECT_RUN,
    builtin/bisect--helper.c:			 N_("use <cmd>... to automatical...
    builtin/bisect--helper.c:	case BISECT_RUN:
    t/t6030-bisect-porcelain.sh:	test_path_is_missing ".git/BISECT_RUN" &&

What if a run script tried to read from (or checked the presence of)
the file for its correct operation (e.g. I would imagine that "do
this operation when run interactively, but do the same operation
silently when run from the git-bisect machinery" may be a reasonable
thing to do)?

This change just unintendedly broke such a script, didn't it?  The
change makes me a bit worried.

> +	if (bisect_next_check(terms, NULL))
> +		return BISECT_FAILED;
> +
> +	if (argc)
> +		sq_quote_argv(&command, argv);
> +	else
> +		return BISECT_FAILED;
> +
> +	run_args.v[0] = xstrdup(command.buf);
> +	run_args.nr = 1;
> +
> +	while (1) {
> +		strvec_clear(&args);
> +
> +		printf(_("running %s"), command.buf);
> +		res = run_command_v_opt(run_args.v, RUN_USING_SHELL);

Nicely used sq_quote_argv() with RUN_USING_SHELL here.  Goodl.

> +		if (res < 0 && res >= 128) {
> +			error(_("bisect run failed: exit code %d from"
> +				" '%s' is < 0 or >= 128"), res, command.buf);
> +			strbuf_release(&command);
> +			return res;
> +		}
> +
> +		if (res == 125)
> +			strvec_push(&args, "skip");
> +		else if (res > 0)
> +			strvec_push(&args, terms->term_bad);
> +		else
> +			strvec_push(&args, terms->term_good);
> +

bisect_state() does so much that it was a bit hard to follow for me
(who hasn't been following the bisect-in-C topic very closely), but
the code around here roughly corresponds to the following snippet in
the original scripted version.

> -		git bisect--helper --bisect-state $state >"$GIT_DIR/BISECT_RUN"
> -		res=$?
> -
> -		cat "$GIT_DIR/BISECT_RUN"
> -
> -		if sane_grep "first $TERM_BAD commit could be any of" "$GIT_DIR/BISECT_RUN" \
> -			>/dev/null
> -		then
> -			gettextln "bisect run cannot continue any more" >&2
> -			exit $res
> -		fi

I see that the contents of the file BISECT_RUN is shown to the user
in the original but is that part of what bisect_state() does, or did
we lose it during this round of conversion?

> +		res = bisect_state(terms, args.v, args.nr);
> +		if (res == BISECT_INTERNAL_SUCCESS_MERGE_BASE) {
> +			printf(_("bisect run success"));
> +			res = BISECT_OK;
> +		} else if (res == BISECT_ONLY_SKIPPED_LEFT)
> +			error(_("bisect run cannot continue any more"));
> +		else if (res)
> +			error(_("bisect run failed:'git bisect--helper --bisect-state"
> +				" %s' exited with error code %d"), args.v[0], res);
> +		else
> +			continue;

In any case, being able to check the return value from bisect_state()
and switch is so much nicer than having to sane_grep in BISECT_RUN.

> +		strbuf_release(&command);
> +		strvec_clear(&args);
> +		strvec_clear(&run_args);
> +
> +		return res;
> +	}
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -1086,7 +1146,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		BISECT_LOG,
>  		BISECT_REPLAY,
>  		BISECT_SKIP,
> -		BISECT_VISUALIZE
> +		BISECT_VISUALIZE,
> +		BISECT_RUN,

Now this new one has the trailing comma.  I'd suggest doing so in
the previous step.

Thanks.
