Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD65207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 05:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1035228AbdDUFBh (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Apr 2017 01:01:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57197 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1035172AbdDUFBf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Apr 2017 01:01:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0BD577D4BF;
        Fri, 21 Apr 2017 01:01:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xQAwV+9uNRJf6MFYEEceTEJYpF4=; b=qvCb0c
        KUVLF0hUu2Rkon8NzrWTqHGW5kNGdACm2XTnHxf4RAaol+Frt5wfAOPz3S5VuSed
        zcl5ntosxv/h1okKK0O4BMUf50eepvuADHk4/GybHt8He2yxcsJRAAXT6HlAU+jm
        FtEi+IzNV2WD/2Ph7WfqqLQsbfM5feURe+tpM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=DUv46AA9LIGUR33W/qoMPPdIzIFkH+tp
        UwTibNofk/p4ktbcLKnh//L3VaHgesJQWRWcUAhwBrQt0EZG8bH9HyI+HR9qAHE7
        5ZTVX75IhkkGWvdfka/e31LUknz8xYgEy6Wq51RGdhLVb1HMMkzSXVfGcEztdX0f
        hOIoy3ea1Dw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 01F847D4BE;
        Fri, 21 Apr 2017 01:01:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4A4F77D4BD;
        Fri, 21 Apr 2017 01:01:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH] completion: optionally disable checkout DWIM
References: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net>
Date:   Thu, 20 Apr 2017 22:01:32 -0700
In-Reply-To: <20170420201229.fxiylgp2v2v4sz3w@sigill.intra.peff.net> (Jeff
        King's message of "Thu, 20 Apr 2017 16:12:30 -0400")
Message-ID: <xmqqzifa4amr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96D9BCF6-264F-11E7-BE82-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> When we complete branch names for "git checkout", we also
> complete remote branch names that could trigger the DWIM
> behavior. Depending on your workflow and project, this can
> be either convenient or annoying.
> ...
> This is flexible enough for me, but it's possible somebody would want
> this on a per-repo basis. I don't know that we want to read from `git
> config`, though, because it's relatively expensive to do so. People who
> want per-repo settings are probably better off with a hook that triggers
> when they "cd" around, and sets up their preferences.

Sounds OK.  I am kind of surprised that --no-guess is the only way
to turn off this dwimming (not in the completion side, but there
does not seem to be a way to tell "git checkout" that you do not
need that create-missing-branch-out-of-remote-tracking).

>  contrib/completion/git-completion.bash | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 1150164d5..f53b18fae 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -28,6 +28,14 @@
>  # completion style.  For example '!f() { : git commit ; ... }; f' will
>  # tell the completion to use commit completion.  This also works with aliases
>  # of form "!sh -c '...'".  For example, "!sh -c ': git commit ; ... '".
> +#
> +# You can set the following environment variables to influence the behavior of
> +# the completion routines:
> +#
> +#   GIT_COMPLETION_CHECKOUT_NO_GUESS
> +#
> +#     When non-empty, do not include "DWIM" suggestions in git-checkout
> +#     completion (e.g., completing "foo" when "origin/foo" exists).
>  
>  case "$COMP_WORDBREAKS" in
>  *:*) : great ;;
> @@ -1248,7 +1256,8 @@ _git_checkout ()
>  		# check if --track, --no-track, or --no-guess was specified
>  		# if so, disable DWIM mode
>  		local flags="--track --no-track --no-guess" track_opt="--track"
> -		if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
> +		if [ -n "$GIT_COMPLETION_CHECKOUT_NO_GUESS" -o \
> +		     -n "$(__git_find_on_cmdline "$flags")" ]; then
>  			track_opt=''
>  		fi
>  		__git_complete_refs $track_opt
