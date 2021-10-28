Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9057DC433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:51:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D09610EA
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 16:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhJ1Qxy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 12:53:54 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50980 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbhJ1Qxq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 12:53:46 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0C7E3F7BC9;
        Thu, 28 Oct 2021 12:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LuFQHU6c292mVsKsFhtgsLRrgyVj3Lru8bgz6/
        p/vsk=; b=aH8uFk+dtnZpVX1eT244/xrziXWfbJA8SqF5j4wxE1HN2+gux0lor1
        Da5HXqgO8fjUh5CKzeiYm02cFHCQD/bCQNzhz+7aSZ2dfLErBFP4aoAk5iT8NO7Z
        actT+Q/b/+bMIfHdPWAvkBtC7hTrqqtkvDv248QvN+IfkWvdpRAhA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 02D0EF7BC8;
        Thu, 28 Oct 2021 12:51:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 67974F7BC5;
        Thu, 28 Oct 2021 12:51:18 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git
 pull --no-verify"
References: <YXfwanz3MynCLDmn@pflmari>
        <YXhwGQOTfD+ypbo8@coredump.intra.peff.net> <YXlBhmfXl3wFQ5Bj@pflmari>
        <YXlD5ecNSdeBSMoS@coredump.intra.peff.net> <YXlTpzrY7KFqRlno@pflmari>
        <xmqq4k92w7do.fsf@gitster.g> <YXpFTJTo0pKhM7xG@pflmari>
        <YXpZddOixrJDd//s@pflmari>
        <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
        <YXrFaJXbuSuwfhQ7@pflmari> <YXrFy9I1KPz3IZyp@pflmari>
Date:   Thu, 28 Oct 2021 09:51:17 -0700
In-Reply-To: <YXrFy9I1KPz3IZyp@pflmari> (Alex Riesen's message of "Thu, 28 Oct
        2021 17:46:19 +0200")
Message-ID: <xmqqv91hrt2y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 45906ABC-380F-11EC-B4FA-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Riesen <alexander.riesen@cetitec.com> writes:

> Subject: Re: [PATCH 2/2] Fix "commit-msg" hook unexpectedly called for "git pull --no-verify"

Perhaps

    Subject: [PATCH] pull: honor --no-verify and do not call the commit-msg hook

instead.

> From: Alex Riesen <raa.lkml@gmail.com>
>
> The option was incorrectly auto-translated to "--no-verify-signatures",
> which causes the unexpected effect of the hook being called.
> And an even more unexpected effect of disabling verification of signatures.
>
> The manual page describes the option to behave same as the similarly
> named option of "git merge", which seems to be the original intention
> of this option in the "pull" command.
>
> Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
> ---
>  builtin/pull.c          |  6 ++++++
>  t/t5521-pull-options.sh | 24 ++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/builtin/pull.c b/builtin/pull.c
> index 425950f469..e783da10b2 100644
> --- a/builtin/pull.c
> +++ b/builtin/pull.c
> @@ -84,6 +84,7 @@ static char *opt_edit;
>  static char *cleanup_arg;
>  static char *opt_ff;
>  static char *opt_verify_signatures;
> +static char *opt_verify;
>  static int opt_autostash = -1;
>  static int config_autostash;
>  static int check_trust_level = 1;
> @@ -160,6 +161,9 @@ static struct option pull_options[] = {
>  	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
>  		N_("abort if fast-forward is not possible"),
>  		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
> +	OPT_PASSTHRU(0, "verify", &opt_verify, NULL,
> +		N_("control use of pre-merge-commit and commit-msg hooks"),
> +		PARSE_OPT_NOARG),
>  	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
>  		N_("verify that the named commit has a valid GPG signature"),
>  		PARSE_OPT_NOARG),
> @@ -688,6 +692,8 @@ static int run_merge(void)
>  		strvec_pushf(&args, "--cleanup=%s", cleanup_arg);
>  	if (opt_ff)
>  		strvec_push(&args, opt_ff);
> +	if (opt_verify)
> +		strvec_push(&args, opt_verify);
>  	if (opt_verify_signatures)
>  		strvec_push(&args, opt_verify_signatures);

Looks quite straight-forward, especially that now this just mimicks
how --[no-]verify-signatures is passed through.

Thanks, will queue.
