Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FA9EC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 06:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbhLVGqN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 01:46:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63009 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbhLVGqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 01:46:13 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E4CBF15C03B;
        Wed, 22 Dec 2021 01:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GlJaObsgQ8wEFZjNvaN9Kkl7gjMU0zzL0Gn2A+
        2TLQ0=; b=k99de1CJqVik8tzjgiQ7uLagDkPAuLmPncvldreI5Ux/P99i8VOkUb
        UhPaapp8WRlbNvheNDJv1Zf4ZRw5gso2YceCnPTZvZ3Qndl1JtCmoPnSEy7qksJF
        u//R7hdqigqw4KL3n7sduT2BoldvGkhH73PuluBG2u/bh6QFumaWI=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DCC2415C03A;
        Wed, 22 Dec 2021 01:46:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 47B5615C038;
        Wed, 22 Dec 2021 01:46:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v3 3/3] builtin/fetch: die on --negotiate-only and
 --recurse-submodules
References: <20211217000235.68996-1-chooglen@google.com>
        <20211222001134.28933-1-chooglen@google.com>
        <20211222001134.28933-4-chooglen@google.com>
Date:   Tue, 21 Dec 2021 22:46:07 -0800
In-Reply-To: <20211222001134.28933-4-chooglen@google.com> (Glen Choo's message
        of "Tue, 21 Dec 2021 16:11:34 -0800")
Message-ID: <xmqq5yrhkuhc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D85A59C6-62F2-11EC-B8E2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> +This is incompatible with `--recurse-submodules[=yes|on-demand]`.
>  Internally this is used to implement the `push.negotiate` option, see
>  linkgit:git-config[1].

Makes sense.

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 883bb1b10c..54f970130e 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -75,6 +75,7 @@ static struct transport *gtransport;
>  static struct transport *gsecondary;
>  static const char *submodule_prefix = "";
>  static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
> +static int recurse_submodules_explicit = RECURSE_SUBMODULES_DEFAULT;
>  static int recurse_submodules_default = RECURSE_SUBMODULES_ON_DEMAND;
>  static int shown_url = 0;
>  static struct refspec refmap = REFSPEC_INIT_FETCH;
> @@ -166,7 +167,7 @@ static struct option builtin_fetch_options[] = {
>  		 N_("prune remote-tracking branches no longer on remote")),
>  	OPT_BOOL('P', "prune-tags", &prune_tags,
>  		 N_("prune local tags no longer on remote and clobber changed tags")),
> -	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules, N_("on-demand"),
> +	OPT_CALLBACK_F(0, "recurse-submodules", &recurse_submodules_explicit, N_("on-demand"),
>  		    N_("control recursive fetching of submodules"),
>  		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
>  	OPT_BOOL(0, "dry-run", &dry_run,
> @@ -1997,12 +1998,23 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	argc = parse_options(argc, argv, prefix,
>  			     builtin_fetch_options, builtin_fetch_usage, 0);
>  
> +	if (recurse_submodules_explicit != RECURSE_SUBMODULES_DEFAULT)
> +		recurse_submodules = recurse_submodules_explicit;
> +
>  	if (negotiate_only) {
> -		/*
> -		 * --negotiate-only should never recurse into
> -		 * submodules, so there is no need to read .gitmodules.
> -		 */
> -		recurse_submodules = RECURSE_SUBMODULES_OFF;
> +		switch (recurse_submodules_explicit) {
> +		case RECURSE_SUBMODULES_OFF:
> +		case RECURSE_SUBMODULES_DEFAULT: {
> +			/*
> +			 * --negotiate-only should never recurse into
> +			 * submodules, so there is no need to read .gitmodules.
> +			 */
> +			recurse_submodules = RECURSE_SUBMODULES_OFF;
> +			break;
> +		}
> +		default:
> +			die(_("--negotiate-only and --recurse-submodules cannot be used together"));
> +		}
>  	}

Nice. Very cleanly done.
