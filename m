Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4BE620954
	for <e@80x24.org>; Mon,  4 Dec 2017 14:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753275AbdLDOXJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 09:23:09 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61039 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753248AbdLDOXI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 09:23:08 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC344CBF70;
        Mon,  4 Dec 2017 09:23:07 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SqPzqZiY7tUu2lCCdLoBgmv3Vh8=; b=yDPeXr
        7/3imfeS6umQWqahYUo989585t8G+k3nAWZMmBzYMFhcQtyOxZPdHM0LhaR2vvxs
        UR3ceSxfqV/gqtmdyEoNJfSCywLEe5synysnh+44YJMkUZRJkvyHTgGofOxWTMik
        i9lq5e+zTL/huDkYtAn2XXdAG2D3xQBF6+zMA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=k4BSZ5+Sa7xDVnBSVlyx49mVNegpuZfv
        VAQXnvxeUh0gEcEP8kDZ4JvZ1ScUHtXrrpS8c0+36Lt2g+02GRCAWGhUrSBEwj2e
        hoALCnkPRNPJ8m9hkQqEde3aF170cW0jFMBlypH/tMlkixeTTos8axV1lXhBn5VT
        0tJ5qLemNCo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A4D6ECBF6F;
        Mon,  4 Dec 2017 09:23:07 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1D35FCBF6E;
        Mon,  4 Dec 2017 09:23:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Donald R Laster Jr <laster@dlaster.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/4] diff: use skip_to_optional_val()
References: <20171204125617.4931-1-chriscool@tuxfamily.org>
        <20171204125617.4931-3-chriscool@tuxfamily.org>
Date:   Mon, 04 Dec 2017 06:23:05 -0800
In-Reply-To: <20171204125617.4931-3-chriscool@tuxfamily.org> (Christian
        Couder's message of "Mon, 4 Dec 2017 13:56:16 +0100")
Message-ID: <xmqqh8t6o9me.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5B34082-D8FE-11E7-A0D3-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> @@ -4540,13 +4535,13 @@ int diff_opt_parse(struct diff_options *options,
>  		return stat_opt(options, av);
>  
>  	/* renames options */
> -	else if (starts_with(arg, "-B") || starts_with(arg, "--break-rewrites=") ||
> -		 !strcmp(arg, "--break-rewrites")) {
> +	else if (starts_with(arg, "-B") ||
> +		 skip_to_optional_val(arg, "--break-rewrites", &optarg)) {
>  		if ((options->break_opt = diff_scoreopt_parse(arg)) == -1)
>  			return error("invalid argument to -B: %s", arg+2);
>  	}

This is curious; "optarg" gets something, but it is not used (what
is passed to scoreopt_parse() is still "arg".

It merely is curious and not wrong; the actual parsing of the whole
thing is done in scoreopt_parse() and skip_to_optional_val() is used
merely as a substitute for "the thing must either be --break-rewrites
or must begin with --break-rewrites=" check that is done with
starts_with() and !strcmp().

It probably makes sense to allow skip_to_optional() to take a NULL
for the third parameter to clarify a callsite like this.  Otherwise
the readers will wonder who consumes optarg, and why it is OK for it
to be sometimes set and sometimes left undefined.

> -	else if (starts_with(arg, "-M") || starts_with(arg, "--find-renames=") ||
> -		 !strcmp(arg, "--find-renames")) {
> +	else if (starts_with(arg, "-M") ||
> +		 skip_to_optional_val(arg, "--find-renames", &optarg)) {

Likewise.

> @@ -4554,8 +4549,8 @@ int diff_opt_parse(struct diff_options *options,
>  	else if (!strcmp(arg, "-D") || !strcmp(arg, "--irreversible-delete")) {
>  		options->irreversible_delete = 1;
>  	}
> -	else if (starts_with(arg, "-C") || starts_with(arg, "--find-copies=") ||
> -		 !strcmp(arg, "--find-copies")) {
> +	else if (starts_with(arg, "-C") ||
> +		 skip_to_optional_val(arg, "--find-copies", &optarg)) {
>  		if (options->detect_rename == DIFF_DETECT_COPY)
>  			options->flags.find_copies_harder = 1;
>  		if ((options->rename_score = diff_scoreopt_parse(arg)) == -1)

Likewise.
