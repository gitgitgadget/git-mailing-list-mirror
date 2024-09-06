Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35C81B85E0
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 20:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725655771; cv=none; b=jd3gg990/YFpMIYePWTVuDUcm3Y7W9L5/kFvpSWIuRJRdXUM8ZXVDQrDL/Pl1XLsBEZKhV1Fy6ezweNJoTLS7LjnNKQq831e9wSuKIi63AaZ7pmxXba77NLI1jJuLVOuSFRTze38NOL5aS+JOu0lXhfAlO6CpQ3HAhMfRbTHzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725655771; c=relaxed/simple;
	bh=d6arOUsov+LqaKqd4QVgbSYIPZ8XHwCOxjUl6sj6ho4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QtkJEUM5eBdlNX4gGo8JGM/+39Ty9/bClwZdeW6q8RQvuA+6R9JsOT4zBmUge+4i6vaKiD+D5n7am563/eTRDIuTU/z3nMaERU6Mgm320//BpsOb2u38ZjEN/eShBw8VMYhNuCGODcxUNF7NK0ng1roOTZcibcfzMuD92cenFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=NgdBekaR; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NgdBekaR"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 28DD61E84F;
	Fri,  6 Sep 2024 16:49:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=d6arOUsov+LqaKqd4QVgbSYIPZ8XHwCOxjUl6s
	j6ho4=; b=NgdBekaRhu25gmNwGiPaP5sdJySRF7MFAA7NJdvSYt1iWyFxziWpwc
	+sgBNSqh8O9Xszx1NYvBMbmgDu8PmNg5LW6GBU217cFrLqeqFlADibVJtz/R+e6b
	vU6u35eV5P2SNS4SqN8J2l3+Qo176Vh4S4vXlGLE5LUkkQ8X9vb28=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F8B31E84E;
	Fri,  6 Sep 2024 16:49:23 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 83F131E84D;
	Fri,  6 Sep 2024 16:49:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Alex Henrie <alexhenrie24@gmail.com>
Cc: git@vger.kernel.org,  bert.wesarg@googlemail.com
Subject: Re: [PATCH] apply: support --ours, --theirs, and --union for
 three-way merges
In-Reply-To: <20240906044222.4881-1-alexhenrie24@gmail.com> (Alex Henrie's
	message of "Thu, 5 Sep 2024 22:22:36 -0600")
References: <20240906044222.4881-1-alexhenrie24@gmail.com>
Date: Fri, 06 Sep 2024 13:49:21 -0700
Message-ID: <xmqqwmjov772.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7ED29318-6C91-11EF-A93E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Alex Henrie <alexhenrie24@gmail.com> writes:

> --ours, --theirs, and --union are already supported in `git merge-file`
> for automatically resolving conflicts in favor of one version or the
> other, instead of leaving conflict markers in the file. Support them in
> `git apply -3` as well because the two commands do the same kind of
> file-level merges.

An unrelated #leftoverbits tangent.  

We probably should teach add "union" as a valid choice in
.recursive_variant in merge-recursive.c:parse_merge_opt(), together
with "ours" and "theirs" that are already supported.

> In case in the future --ours, --theirs, and --union gain a meaning
> outside of three-way-merges, they do not imply --3way but rather must be
> specified alongside it.

OK.  At least the code insists on having --3way specified, instead
of silently ignoring --ours given without --3way, so it is good.

> +static int apply_option_parse_favorite(const struct option *opt,
> +				       const char *arg, int unset)
> +{
> +	struct apply_state *state = opt->value;
> +
> +	BUG_ON_OPT_ARG(arg);
> +	BUG_ON_OPT_NEG(unset);
> +
> +	if (!strcmp(opt->long_name, "ours"))
> +		state->merge_opts.variant = XDL_MERGE_FAVOR_OURS;
> +	else if (!strcmp(opt->long_name, "theirs"))
> +		state->merge_opts.variant = XDL_MERGE_FAVOR_THEIRS;
> +	else
> +		state->merge_opts.variant = XDL_MERGE_FAVOR_UNION;
> +	return 0;
> +}

If you MUST use a opt-callback, then do not assume anything that is
not ours or theirs will always be union.  Help future developers by
making your assumption more explicit, i.e.

	if (..."ours"...)
		do ours thing;
	else if (... "theirs" ...)
		do theirs thing;
	else if (... "union" ...)
		do union thing;
	else
		BUG("unexpected option '--%s'", opt->long_name);

Having said that, I do not think you want or need a callback in this
case to begin with.

>  static int apply_option_parse_whitespace(const struct option *opt,
>  					 const char *arg, int unset)
>  {
> @@ -5151,6 +5177,18 @@ int apply_parse_options(int argc, const char **argv,
>  			N_("also apply the patch (use with --stat/--summary/--check)")),
>  		OPT_BOOL('3', "3way", &state->threeway,
>  			 N_( "attempt three-way merge, fall back on normal patch if that fails")),
> +		OPT_CALLBACK_F(0, "ours", state, NULL,
> +			N_("for conflicts, use our version"),
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> +			apply_option_parse_favorite),
> +		OPT_CALLBACK_F(0, "theirs", state, NULL,
> +			N_("for conflicts, use their version"),
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> +			apply_option_parse_favorite),
> +		OPT_CALLBACK_F(0, "union", state, NULL,
> +			N_("for conflicts, use a union version"),
> +			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
> +			apply_option_parse_favorite),

Instead of embedding the whole ll_merge_options in apply_state, just
define a new integer member "merge_variant", and use OPT_SET_INT()
on that field.  That way, you won't have to do the callback interface
and worry about keeping the function's if/elseif cascade in sync
with these options that call the same function.

Then, instead of passing state->merge_opts, you can initialize
ll_merge_options instance in three_way_merge() with whatever is
needed from the apply_state (like the merge_variant mentioned
above).

> -	if (status) {
> +	if (state->merge_opts.variant) {
> +		/*
> +		 * XDL_MERGE_FAVOR_(OURS|THEIRS|UNION) automatically resolves
> +		 * conflicts, but the ll_merge function is not yet smart enough
> +		 * to report whether or not there were conflicts, so just print
> +		 * a generic message.
> +		 */
> +		fprintf(stderr, _("Applied patch to '%s'.\n"), patch->new_name);

I do not think this extra message or the comment is warranted.  When
you said "--ours" you told the machinery that you favor our version,
so there is no place to be "smart enough to report".  Instead of
normal 3-way merge, you told it there won't be any conflict.  There
is nothing to report.

The else clause of the original "if (status)" does report "applied
patch cleanly" when apply_verbosity is set to report it.  As far as
the command is concerned, if you told it to use "ours" and got a
merge result, that was also applied cleanly.  So you can just drop
this hunk and let the existing code take care of the rest (including
honoring the verbosity settings).

Other than that, looks fairly straight-forward.

I didn't read the tests, though.

Thanks.
