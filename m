Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 23E1E1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 06:21:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbeKLQNh (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 11:13:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60186 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbeKLQNg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 11:13:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF628101279;
        Mon, 12 Nov 2018 01:21:43 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sduLqw3p4HYn
        87vWbZ42qCpoa6Y=; b=RUMaDG/u2xmMCxDJ0syuYQOWi3N9wGv/kT/NJcuaSEkr
        SwrqCHEIpEDdsvW16mwC/KjUWEe1r00j8tPr30241g6K5/gWpFlxCwDbPOibyR6G
        PLcxEfYSQuLH0/EoSjqK2D5CcZ4nIrZBZo+puAABW+DUod7x/ve1PZOTk0zu+cM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=AMXpWv
        xPMB/NQKWqKAlfImwNIpPCLS9G7cWzK8Cx/zkbq3hOGKzr0BFUnpwFc7FVidrB8b
        IT9ZfPMFdMuhEnPph8a9lrxtPQjeCUsB1ri/Ki/aldpQs2qyTWD3Ha5FmIpZdWYS
        2892dztXbrFr79mo3DZfSfiNrI04FYnSr3iis=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A85CE101278;
        Mon, 12 Nov 2018 01:21:43 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 18A06101277;
        Mon, 12 Nov 2018 01:21:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] checkout: print something when checking out paths
References: <20181110133525.17538-1-pclouds@gmail.com>
Date:   Mon, 12 Nov 2018 15:21:42 +0900
In-Reply-To: <20181110133525.17538-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 10 Nov 2018 14:35:25 +0100")
Message-ID: <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 392B6810-E643-11E8-AD42-BFB3E64BB12D-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Since the purpose of printing this is to help disambiguate. Only do it
> when "--" is missing (the actual reason though is many tests check
> empty stderr to see that no error is raised and I'm too lazy to fix
> all the test cases).

Heh, honesty is good but in this particular case the official reason
alone would make perfect sense, too ;-)

As with progress output, shouldn't this automatically be turned off
when the standard error stream goes to non tty, as the real purpose
of printing is to help the user sitting in front of the terminal and
interacting with the command?

And by this, I do not mean to say that "When -- is missing" can go
away.  I agree that "--" is a clear sign that the user knows what
s/he is doing---to overwrite the paths in the working tree that
match the pathspec.

> @@ -371,17 +374,27 @@ static int checkout_paths(const struct checkout_o=
pts *opts,
>  		struct cache_entry *ce =3D active_cache[pos];
>  		if (ce->ce_flags & CE_MATCHED) {
>  			if (!ce_stage(ce)) {
> -				errs |=3D checkout_entry(ce, &state, NULL);
> +				errs |=3D checkout_entry(ce, &state,
> +						       NULL, &nr_checkouts);
>  				continue;

As we count inside checkout_entry(), we might not actually write
this out when we know that the working tree file is up to date
already but we do not increment in that case either, so we keep
track of the accurate count of "updates", not path matches (i.e. we
are not reporting "we made sure this many paths are up to date in
the working tree"; instead we are reporting how many paths we needed
to overwrite in the working tree).

>  			}
>  			if (opts->writeout_stage)
> -				errs |=3D checkout_stage(opts->writeout_stage, ce, pos, &state);
> +				errs |=3D checkout_stage(opts->writeout_stage,
> +						       ce, pos,
> +						       &state, &nr_checkouts);

Likewike.

>  			else if (opts->merge)
> -				errs |=3D checkout_merged(pos, &state);
> +				errs |=3D checkout_merged(pos, &state,
> +							&nr_checkouts);

Likewise.

>  			pos =3D skip_same_name(ce, pos) - 1;
>  		}
>  	}
> -	errs |=3D finish_delayed_checkout(&state);
> +	errs |=3D finish_delayed_checkout(&state, &nr_checkouts);
> +
> +	if (opts->count_checkout_paths)
> +		fprintf_ln(stderr, Q_("%d path has been updated",
> +				      "%d paths have been updated",
> +				      nr_checkouts),
> +			   nr_checkouts);

This one may want to be protected behind isatty(2).  Or the default
value of count_checkout_paths could be tweakedbased on isatty(2).

> @@ -1064,6 +1077,7 @@ static int parse_branchname_arg(int argc, const c=
har **argv,
>  		has_dash_dash =3D 1; /* case (3) or (1) */
>  	else if (dash_dash_pos >=3D 2)
>  		die(_("only one reference expected, %d given."), dash_dash_pos);
> +	opts->count_checkout_paths =3D !opts->quiet && !has_dash_dash;

i.e. "&& isatty(2)" as well.

Of course, "--[no-]count-paths" could be added to override this.
