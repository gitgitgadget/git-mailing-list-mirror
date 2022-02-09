Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661C8C433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 19:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbiBITpi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 14:45:38 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:48966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBITpf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 14:45:35 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905BEE01CE7B
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 11:45:35 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3461F18EE20;
        Wed,  9 Feb 2022 14:45:35 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qjfv9blpG2mh7zV7U5O7bh/AJD43eoJgtgPkrc
        Jpo0w=; b=XFB80bS0kzeR4tooA/08bAUXhpZtO/snHFqI6VWg4wGMcxjhQwAqmX
        pNSfcBi68ZZys9fMXoubDKA2j/W40+e4SFSodT4nfVKDj8XXYUsrE5VoSTSk+5jE
        yIkvxq2i6AlL9nFMHT5sicF+CiUvKllIWufC2GpQPQF2blvzOgtgM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2DC5418EE1F;
        Wed,  9 Feb 2022 14:45:35 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 8F1FF18EE1E;
        Wed,  9 Feb 2022 14:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 06/11] bisect--helper: make `--bisect-state` optional
References: <pull.1132.git.1643328752.gitgitgadget@gmail.com>
        <eddbdde222a01113d8facdcb17d6ec85676edbe7.1643328752.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 11:45:31 -0800
In-Reply-To: <eddbdde222a01113d8facdcb17d6ec85676edbe7.1643328752.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 28 Jan 2022
        00:12:27 +0000")
Message-ID: <xmqqh7977rj8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7B05772-89E0-11EC-AE6E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> @@ -1210,6 +1210,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  			     git_bisect_helper_usage,
>  			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_UNKNOWN);
>  
> +	if (!cmdmode && argc > 0) {
> +		set_terms(&terms, "bad", "good");
> +		get_terms(&terms);
> +		if (!check_and_set_terms(&terms, argv[0]))
> +			cmdmode = BISECT_STATE;
> +	}
> +

I do agree with "if we want to reuse this function without changing
it much, --bisect-state must become an optional and the default mode
of operation" as a goal, but I do not quite get this change.  From
the rephased description of the goal, what I would expect is more
like

	if (!cmdmode && possibly-other-conditions-like-argc-check)
		cmdmode = BISECT_STATE;

and nothing else.  Between the case where --bisect-state was and was
not given explicitly, check-and-set-terms is or is not called.  I
can see that checking would be _nice_ when we try to decide if the
first token makes sense as good/bad and the user wanted to do the
"state" thing impolicitly, but if it is worth checking in implicit
case, shouldn't we be checking when the --bisect-state is explicitly
given as well?

And the actual execution of the BISECT_STATE command is even more
puzzling, below.

>  	if (!cmdmode)
>  		usage_with_options(git_bisect_helper_usage, options);
>  
> @@ -1218,11 +1225,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		set_terms(&terms, "bad", "good");
>  		res = bisect_start(&terms, argv, argc);
>  		break;
> -	case BISECT_STATE:
> -		set_terms(&terms, "bad", "good");
> -		get_terms(&terms);
> -		res = bisect_state(&terms, argv, argc);
> -		break;
>  	case BISECT_TERMS:
>  		if (argc > 1)
>  			return error(_("--bisect-terms requires 0 or 1 argument"));
> @@ -1265,6 +1267,13 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
>  		get_terms(&terms);
>  		res = bisect_run(&terms, argv, argc);
>  		break;
> +	case BISECT_STATE:
> +		if (!terms.term_good) {
> +			set_terms(&terms, "bad", "good");
> +			get_terms(&terms);
> +		}
> +		res = bisect_state(&terms, argv, argc);
> +		break;

This case arm has been moved but because there is no fall-through in
this switch statement, the movement is a no-op.  But the code has
also changed with this patch.  We used to do set_terms/get_terms
unconditionally, but we do not even do so when terms_good (but not
terms_bad) is already set.

Is this an unrelated bugfix of some kind?  This does not look
related to "making --bisect-state optional and implicit default" at
all.  At least the proposed log message does not explain why.

Thanks.

>  	default:
>  		BUG("unknown subcommand %d", cmdmode);
>  	}
