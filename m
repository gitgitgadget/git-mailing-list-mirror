Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4056CC433F5
	for <git@archiver.kernel.org>; Thu, 13 Jan 2022 01:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiAMBQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 20:16:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56465 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiAMBQG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 20:16:06 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF952100B78;
        Wed, 12 Jan 2022 20:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wp9BX/kCLhptO/sON4pD9Efct0AZTpZHX2XECd
        YQ0mk=; b=MGyKRZOWOlYVsCM54uJhP0sz2ueqi2E2fqvDBqv8HnARblhCEuADhm
        9dO6UFXPO8wRlU3pPl73hnJnGwcPaquGfaTZRiyCibFJDVWzn7Wc16laow1nyHWB
        5PK6i1KhzJQoE/IXS2Hs+cNZiaZ90zbSJ7KXW0j+oFNsXUG3Kv2pI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D5123100B77;
        Wed, 12 Jan 2022 20:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3B54E100B76;
        Wed, 12 Jan 2022 20:16:04 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v4 3/3] fetch --negotiate-only: do not update submodules
References: <20211222001134.28933-1-chooglen@google.com>
        <20220113004501.78822-1-chooglen@google.com>
        <20220113004501.78822-4-chooglen@google.com>
Date:   Wed, 12 Jan 2022 17:16:03 -0800
In-Reply-To: <20220113004501.78822-4-chooglen@google.com> (Glen Choo's message
        of "Wed, 12 Jan 2022 16:45:01 -0800")
Message-ID: <xmqqr19cjuzw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60B6B1DA-740E-11EC-B02D-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 7bbff5a029..8b8bde8809 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -76,6 +76,7 @@ static struct transport *gtransport;
>  static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int recurse_submodules_cli = RECURSE_SUBMODULES_DEFAULT;
>  static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
>  static int shown_url = 0;
>  static struct refspec refmap = REFSPEC_INIT_FETCH;
> @@ -167,7 +168,7 @@ static struct option builtin_fetch_options[] = {
>  		 N_("prune remote-tracking branches no longer on remote")),
>  	OPT_BOOL('P', "prune-tags", &prune_tags,
>  		 N_("prune local tags no longer on remote and clobber changed tags")),
> -	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
> +	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_cli, N_("on-demand"),
>  		    N_("control recursive fetching of submodules"),
>  		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
>  	OPT_BOOL(0, "dry-run", &dry_run,
> @@ -2014,6 +2015,27 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
> +
> +	if (recurse_submodules_cli != RECURSE_SUBMODULES_DEFAULT)
> +		recurse_submodules = recurse_submodules_cli;

This made me wonder what should happen if the command line option
was given and explicitly told us to use the default, but after
following the option_fetch_parse_recurse_submodules() codeflow, I
realized that it will never return RECURSE_SUBMODULES_DEFAULT, so it
is OK.  It is a bit misleading that _DEFAULT does not mean "use the
default settings" here---it merely means "this variable was left
untouched".  But I suppose that it is in line with all the other
uses of RECURSE_SUBMODULES_DEFAULT, in which case it is OK for now.

> +	if (negotiate_only) {
> +		switch (recurse_submodules_cli) {
> +		case RECURSE_SUBMODULES_OFF:
> +		case RECURSE_SUBMODULES_DEFAULT: {
> +			/*
> +			 * --negotiate-only should never recurse into
> +			 * submodules. Skip it by setting recurse_submodules to
> +			 * RECURSE_SUBMODULES_OFF.
> +			 */
> +			recurse_submodules = RECURSE_SUBMODULES_OFF;
> +			break;
> +		}

It is not immediately obvious to me why we need an extra block
here.  If there is no reason, let's not have it---there is no reason
to puzzle readers into wondering if anything funny is going on if
there is nothing unusual.

> +		default:
> +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
> +		}
> +	}
> +

Other than that, looking good.

Thanks.
