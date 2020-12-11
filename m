Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A684C4167B
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:56:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1606F23F57
	for <git@archiver.kernel.org>; Fri, 11 Dec 2020 06:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391245AbgLKGzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Dec 2020 01:55:31 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59139 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436599AbgLKGy4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Dec 2020 01:54:56 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 12D3D8B97E;
        Fri, 11 Dec 2020 01:54:14 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=dHxHnYUHS63qHOWJI5InpjsmtCE=; b=W1d+QYkD5Ca9SQoJ9ZM5
        SVqOHq9Am3usWe0xz+QTNiATdxIf24cBeT5m/mTZqDwdv3aONTDgYVNa7Sn/Ac5H
        AY6nYpLy4SyXTYdynt07OtwMt+CplgDRImVWcciWr1m+7/j4F6loq7odgQ4wUS4x
        7mqpVzaE2OC36WL3dick76A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=UiIzIALWM20az/5Obz/cQ/+HM6ePFrE15Bwgbnd5b+eunR
        9+O7rEhVJ1uLSii77ndrnU8rr+ilbbwzhVpvhUNcH4A7Ty88jvm1Uhvtu68TEf4x
        IlcFTSQVuPzWS2aurA4s2KbVDEFobbClyGgavw1TNpF6QGNLs0ufPMO6XUFUY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08C878B97D;
        Fri, 11 Dec 2020 01:54:14 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8331C8B97C;
        Fri, 11 Dec 2020 01:54:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Subject: Re: [PATCH v5 2/3] pull: move default warning
References: <20201210100538.696787-1-felipe.contreras@gmail.com>
        <20201210100538.696787-3-felipe.contreras@gmail.com>
Date:   Thu, 10 Dec 2020 22:54:12 -0800
Message-ID: <xmqqy2i4ltnv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADAAD284-3B7D-11EB-B7F7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Eventually we want to be able to display the warning only when
> fast-forward merges are not possible.
>
> In order to do so we need to move the default warning up to the point
> where we can check if we can fast-forward or not.

Makes sense.

> Additionally, config_get_rebase() was probably never its true home.

I agree with this point.  I've always found it suboptimal.

> This requires a temporary variable to check if we are in the
> "default mode" (no --rebase or --no-rebase specified).

Two points:

 - "mode" is so overused a word; a more focused word is preferrable.

 - by introducing a local variable in cmd_pull() and passing a
   pointer to it to config_get_rebase(), we can easily avoid having
   to rely on an extra global variable.

I'd suggest addressing the above along the following lines.

   -static enum rebase_type config_get_rebase(void)
   +static enum rebase_type config_get_rebase(int *rebase_unspecified)
    {
   +        *rebase_unspecified = 0;

            ... various "return" of configured values ...

   +        *rebase_unspecified = 1;
            return REBASE_FALSE;
    }

Then the caller would declare

	int rebase_unspecified = 0;

and call 

	if (opt_rebase < 0)
		opt_rebase = config_get_rebase(&rebase_unspecified);

to possibly cause it to set to true, and use that instead of the
global variable to decide if we want to give the help text.  When
the helper is not called due to opt_rebase already being set, it is
not using configured value but using the choice from the command
line, so rebase_unspecified is still false after this point.

> @@ -1040,6 +1029,21 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
>  	if (opt_rebase && merge_heads.nr > 1)
>  		die(_("Cannot rebase onto multiple branches."));

And this is the point where we finish various error checks and
starts to run either rebase or merge.  It is as late as we could
delay the "non-ff and you are not configured" message.  In other
words, the place chosen in cmd_pull() to move this code to is
optimal.

> +	if (default_mode && opt_verbosity >= 0 && !opt_ff) {
> +		advise(_("Pulling without specifying how to reconcile divergent branches is\n"
> +			 "discouraged. You can squelch this message by running one of the following\n"
> +			 "commands sometime before your next pull:\n"
> +			 "\n"
> +			 "  git config pull.rebase false  # merge (the default strategy)\n"
> +			 "  git config pull.rebase true   # rebase\n"
> +			 "  git config pull.ff only       # fast-forward only\n"
> +			 "\n"
> +			 "You can replace \"git config\" with \"git config --global\" to set a default\n"
> +			 "preference for all repositories. You can also pass --rebase, --no-rebase,\n"
> +			 "or --ff-only on the command line to override the configured default per\n"
> +			 "invocation.\n"));
> +	}

Either as a part of this step, as a part of the next step, or a
separate follow-up patch, we should

 - create a single-purpose helper function that only calls advise()
   with the message and returns; name it show_advice_pull_non_ff().

 - correct the if() statement above, so that regardless of verbosity
   level, we can do _something_ common when the history does not
   fast-forward.  I.e.

	if (rebase_unspecified && !opt_ff) {
		if (opt_verbosity >= 0)
			show_advice_pull_non_ff();
	}

These would allow us to further turn the logic to

	if (rebase_unspecified && !opt_ff) {
		if (opt_verbosity >= 0 && advice_pull_non_ff)
			show_advice_pull_non_ff();
		die("not a fast-forward; must merge or rebase");
	}

later in the far future, and we do not want that die() to be
affected by verbosity settings.

I'll queue such a fix-up patch on top of the series before pushing
the integration results out on 'seen'.

Thanks.
