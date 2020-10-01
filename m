Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F74C47423
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 18:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FA720796
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 18:21:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vXFMgg0A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732368AbgJASVm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 14:21:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63439 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbgJASVX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 14:21:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 9F0C28FE2A;
        Thu,  1 Oct 2020 14:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yfHwL7GPubvS
        JIs5hTCoRp3Dwh0=; b=vXFMgg0AAKIcmXrc5Iol6maW8xN9mlEM0eICUWe9PrAy
        5odq61UQpBT0gXHnX8LG1gIUeMJt0hYX5sD/+Kdsg9MB0hNr4IV7mm8JWTuCRQmw
        5kAOvKKAduV2omg6ee0w+NOgQiy51uc4FAKTcPLRyRZe9AYDZrMLzYddeUm8PxE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I4TCyq
        NKyImugu4YsyVj17qIENJNTtch4D1t0dGKn8AZ0Q5qoZUxlLOcVEXl1LBj8jSCo9
        N8iCRX+fwjjCRUluSUOH1j1rA501P9hohgPIhAPr20WDGBum3eru7jXrjtvf71iE
        c/bIxVyvpe8IDXPg/g5sZkztPupx1iM+abUtU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 980928FE29;
        Thu,  1 Oct 2020 14:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 230D18FE28;
        Thu,  1 Oct 2020 14:21:19 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?TWljaGHFgiBLxJlwaWXFhA==?= <michal@isc.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/2] diff: add -I<regex> that ignores matching changes
References: <20201001120606.25773-1-michal@isc.org>
        <20201001120606.25773-2-michal@isc.org>
Date:   Thu, 01 Oct 2020 11:21:18 -0700
In-Reply-To: <20201001120606.25773-2-michal@isc.org> (=?utf-8?B?Ik1pY2hh?=
 =?utf-8?B?xYIgS8SZcGllxYQiJ3M=?=
        message of "Thu, 1 Oct 2020 14:06:05 +0200")
Message-ID: <xmqqy2kpbye9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: E6B71BC0-0412-11EB-B748-01D9BED8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Micha=C5=82 K=C4=99pie=C5=84 <michal@isc.org> writes:

> Apart from adding a new field to struct diff_options, also define a new
> flag, XDF_IGNORE_REGEX, for the 'xdl_opts' field of that structure.
> This is done because the xpparam_t structure (which is used for passing
> around the regular expression supplied to -I) is not zeroed out in all
> call stacks involving xdl_diff() and thus only performing a NULL check
> on xpp->ignore_regex could result in xdl_mark_ignorable_regex() treatin=
g
> garbage on the stack as a regular expression.  As the 'flags' field of
> xpparam_t is initialized in all call stacks involving xdl_diff(), addin=
g
> a flag check avoids that problem.

You mentioned in your cover letter about this, and I tend to agree
that this feels like a hack, at least from the first glance.  The
next feature that wants to have an optional pointer in xpparam_t and
have the code behave differently with the data pointed by it would
need to waste another bit the same way.  Do you already know (read:
I am not asking you to dig to find out immediately---just asking if
you already know the answer) if there is an inherent reason why they
cannot be memset(0) before use?  It seems like a much better
approach to ensure that we clear the structure.  Doesn't existing
anchors array share the same issue (at least anchors_nr must be
cleared if there is no interesting anchors) already?  IOW, should
"git grep anchors_nr" be a valid way to identify _all_ places where
you need to clear the ignore_regex field?

> +-I<regex>::
> +	Ignore changes whose all lines match <regex>.
> +

The implementation seems to allow only one regex, but I suspect we'd
want to mimic

    $ printf "%s\n" a a a >test_a
    $ printf "%s\n" b b b >test_b
    $ diff -Ia     test_a test_b
    $ diff     -Ib test_a test_b
    $ diff -Ia -Ib test_a test_b

and until that happens, the explanation needs to say something about
earlier <regex> being discarded when this option is given more than
once.

> @@ -5203,6 +5205,17 @@ static int diff_opt_patience(const struct option=
 *opt,
>  	return 0;
>  }
> =20
> +static int diff_opt_ignore_regex(const struct option *opt,
> +				 const char *arg, int unset)
> +{
> +	struct diff_options *options =3D opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	options->xdl_opts |=3D XDF_IGNORE_REGEX;
> +	options->ignore_regex =3D arg;

When given twice or more, the earlier value gets lost (it does not
leak, luckily, though).

> +	return 0;
> +}

If we somehow can lose the use of XDF_IGNORE_REGEX bit, we do not
have to have this as a callback.  Instead, it can be OPT_STRING with
the current semantics of "only the last one is used", or we can use
OPT_STRING_LIST to keep all the expressions.

On the other hand, I wonder if it would be a valid approach to make
the new field(s) in diff_options a "regex_t *ignore_regex" (and add
an "int ignore_regex_nr" next to it, if we shoot for multiple -I
options), instead of "const char *".  For that, we would need a
callback even without XDF_IGNORE_REGEX bit having to futz with
xdl_opts field.

Doing so would give us a chance to compile and notice a malformed
regular expression in diff.c, before it hits xdiff/ layer, which may
or may not be a good thing.

> @@ -1019,6 +1019,39 @@ static void xdl_mark_ignorable(xdchange_t *xscr,=
 xdfenv_t *xe, long flags)
>  	}
>  }

I agree with what you said in the cover letter that it would be a
good idea to name the existing xdl_mark_ignorable() and the new one
in such a way that they look similar and parallel, by renaming the
former to xdl_mark_ignorable_lines or something.

> +static void
> +xdl_mark_ignorable_regex(xdchange_t *xscr, const xdfenv_t *xe,
> +			 const char *ignore_regex)

I know some coding standard do chomp line immediately before the
function name (I grew up with one), but that is not what this
project uses, and judging from the surrounding code, it is not what
the upstream xdiff source we borrowed uses, either.

> +{
> +	xdchange_t *xch;
> +	regex_t regex;
> +
> +	if (regcomp(&regex, ignore_regex, REG_EXTENDED | REG_NEWLINE))
> +		die("invalid regex: %s", ignore_regex);

If we compile in diff.c layer and pass regex_t down here, we won't
have to fail here this deep in the callchain.

> +	for (xch =3D xscr; xch; xch =3D xch->next) {
> +		regmatch_t regmatch;
> +		xrecord_t **rec;
> +		int ignore =3D 1;
> +		long i;
> +
> +		rec =3D &xe->xdf1.recs[xch->i1];
> +		for (i =3D 0; i < xch->chg1 && ignore; i++)
> +			ignore =3D !regexec_buf(&regex, rec[i]->ptr, rec[i]->size,
> +					      1, &regmatch, 0);
> +		rec =3D &xe->xdf2.recs[xch->i2];
> +		for (i =3D 0; i < xch->chg2 && ignore; i++)
> +			ignore =3D !regexec_buf(&regex, rec[i]->ptr, rec[i]->size,
> +					      1, &regmatch, 0);
> +
> +		/*
> +		 * Do not override --ignore-blank-lines.
> +		 */
> +		xch->ignore |=3D ignore;

Well, you could optimize out the whole regexp matching by adding

		if (xch->ignore)
			continue;

before the two loops try to find a non-matching line, no?

> +	}
> +}
> +
>  int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xpparam_t const *xpp,
>  	     xdemitconf_t const *xecfg, xdemitcb_t *ecb) {
>  	xdchange_t *xscr;
> @@ -1040,6 +1073,9 @@ int xdl_diff(mmfile_t *mf1, mmfile_t *mf2, xppara=
m_t const *xpp,
>  		if (xpp->flags & XDF_IGNORE_BLANK_LINES)
>  			xdl_mark_ignorable(xscr, &xe, xpp->flags);
> =20
> +		if ((xpp->flags & XDF_IGNORE_REGEX) && xpp->ignore_regex)
> +			xdl_mark_ignorable_regex(xscr, &xe, xpp->ignore_regex);
> +
>  		if (ef(&xe, xscr, ecb, xecfg) < 0) {
> =20
>  			xdl_free_script(xscr);

Thanks for an exciting read ;-)

