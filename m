Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4402CC433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:37:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03BC46121E
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 21:37:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233656AbhDGVhi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 17:37:38 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61484 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbhDGVhf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 17:37:35 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 68A881274EB;
        Wed,  7 Apr 2021 17:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=urlqOkibVrMZuyJydYMq+NhWLn8=; b=BtnkVh
        Wco8mujcVIm6qNDrXEC0ddxvIeOiTxRtFLla/Na9+2Kg6Y5XG/0nm3sDxnDm/Iok
        rvynwPOKv+fJTvT5XCxFsy+kMXaBMSF5GaX/PdTEDZvp1gDzFhUcosGvBrurPRZE
        6fUJgA1mGYaRfgtAsvsWyxmIts6nd0sG3N1J0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vdp68MwIvjsF4K1LzDt3vEwI6P4ymAUL
        4PXjq9xUWA1XsxoKnC9cMZrJ1N4QEQznSeBSHHNh+Unun9aG6X7EH9OtoBnL7Bda
        1fm3KyXlHdaPnVtvX5ZBDaUZzYqBLUibo1+6wBeOLFpf/nDeb7vzmFA2E6Ywkc28
        nbD270EQONE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4E44E1274EA;
        Wed,  7 Apr 2021 17:37:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 81DB21274E9;
        Wed,  7 Apr 2021 17:37:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Miriam Rubio <mirucam@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 2/4] bisect--helper: reimplement
 `bisect_visualize()`shell function in C
References: <20210407173334.68222-1-mirucam@gmail.com>
        <20210407173334.68222-3-mirucam@gmail.com>
Date:   Wed, 07 Apr 2021 14:37:18 -0700
In-Reply-To: <20210407173334.68222-3-mirucam@gmail.com> (Miriam Rubio's
        message of "Wed, 7 Apr 2021 19:33:31 +0200")
Message-ID: <xmqqo8epydwx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6EB53D76-97E9-11EB-8C4C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Miriam Rubio <mirucam@gmail.com> writes:

This bit

> -		case "$1" in
> -		git*|tig) ;;
> -		-*)	set git log "$@" ;;
> -		*)	set git "$@" ;;
> -		esac

in the original corresponds to the following.

> +	} else {
> +		if (argv[0][0] == '-') {
> +			strvec_pushl(&args, "log", NULL);
> +			flags |= RUN_GIT_CMD;

If it begins with "-", we assume that is an option to "git log".  OK.

> +		} else if (strcmp(argv[0], "tig") && !starts_with(argv[0], "git"))
> +			flags |= RUN_GIT_CMD;

The condition (if it is not "tig" and does not start with "git") is
the opposite for the first case arm where we just use the rest of
the command line as is.  We take it as a git subcommand name and its
arguments.  OK.

> +		strvec_pushv(&args, argv);

And the remainder of the command line is pushed into the arguments.

OK.

> +	}

And this part from the original

> -	eval '"$@"' --bisect -- $(cat "$GIT_DIR/BISECT_NAMES")

corresponds to the rest.  What the original calls "$@" is already
captured in args.

> +	strvec_pushl(&args, "--bisect",  NULL);

We lost the "--" ("end of options and revs, now the pathspec
follows") here.  Not good.

> +	strbuf_read_file(&sb, git_path_bisect_names(), 0);
> +	strvec_split(&args, sb.buf);

This is probably quite wrong.  What we will place in the
BISECT_NAMES file, as it is a list of pathspec elements (i.e. a
pathspec), can contain spaces.  For that reason, when we write to
the file, we use sq_quote_argv() on each pathspec elements.

See builtin/bisect--helper.c::bisect_start()

If I understand correctly, strvec_split() is to split a buffer at
runs of whitespaces, which is a helper for a very different purpose.

Perhaps sq_dequote_to_strvec() is what we want to use here?

> +	strbuf_release(&sb);
> +	res = run_command_v_opt(args.v, flags);
> +	strvec_clear(&args);
> +	return res;
> +}
> +
>  int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  {
>  	enum {
> @@ -1046,7 +1085,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		BISECT_STATE,
>  		BISECT_LOG,
>  		BISECT_REPLAY,
> -		BISECT_SKIP
> +		BISECT_SKIP,
> +		BISECT_VISUALIZE

Perhaps it is a good time to add trailing comma after this new
token.  cf. Documentation/CodingGuidelines (look for "since early
2012").  The next patch to add yet another enum won't have to touch
the line added here that way.

Everything below looked trivially correct.

Thanks.
