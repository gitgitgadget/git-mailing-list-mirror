Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B96C433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 19:28:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhLGTbh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 14:31:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53211 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229953AbhLGTbg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 14:31:36 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D03D4154FAD;
        Tue,  7 Dec 2021 14:28:05 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FNUDYnQM+aYl
        8ASCqrhHR+Ij5/F4DarV9MwEMU/S/jo=; b=X2VwkpJg7kR8hQPWUqdDh9nWANhj
        7cWdSWT8ttjZu/8f+vOVKcZqHZqckMEATXe2AKpImbdxRLVxCImE3PoqY5X7C5K+
        E8VQymmCTrDQwo7Z+y16MJXml0fSgm8mYFPG1/RdnCDC3niRH9jQhUUf9bdUtUEi
        vldWQyBCSocA2Q8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CA038154FAB;
        Tue,  7 Dec 2021 14:28:05 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BFD8D154FA2;
        Tue,  7 Dec 2021 14:28:01 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, emilyshaffer@google.com,
        avarab@gmail.com
Subject: Re: [PATCH v5 1/2] branch: accept multiple upstream branches for
 tracking
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <cover.1638859949.git.steadmon@google.com>
        <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
Date:   Tue, 07 Dec 2021 11:28:00 -0800
In-Reply-To: <ba7d557725e70f2ae8f10ae5992c8168eb97f2fc.1638859949.git.steadmon@google.com>
        (Josh Steadmon's message of "Mon, 6 Dec 2021 23:12:07 -0800")
Message-ID: <xmqqk0gg6wqn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CAED56D6-5793-11EC-A36F-98D80D944F46-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> +static int install_branch_config_multiple_remotes(int flag, const char=
 *local, const char *origin,
> +		struct string_list *remotes)

The line got overly long so perhaps cut the line after "*local,",
as "origin" and "remotes" conceptually are closer together.

What is in the string list?  Names of refs at the remote "origin",
instead of a single ref there?

>  {
>  	const char *shortname =3D NULL;
>  	struct strbuf key =3D STRBUF_INIT;
> -	int rebasing =3D should_setup_rebase(origin);
> -
> -	if (skip_prefix(remote, "refs/heads/", &shortname)
> -	    && !strcmp(local, shortname)
> -	    && !origin) {
> -		warning(_("Not setting branch %s as its own upstream."),
> -			local);

When 'origin' is NULL in the original caller, it means a local
tracking, and making sure we do not say "my 'master' branch builds
on top of itself" makes sense.

> -		return 0;
> -	}
> +	int i, rebasing =3D should_setup_rebase(origin);
> +
> +	if (remotes->nr < 1)
> +		BUG("must provide at least one remote for branch config");
> +
> +	if (!origin)
> +		for (i =3D 0; i < remotes->nr; i++)
> +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname=
)
> +			    && !strcmp(local, shortname)) {
> +				warning(_("Not setting branch %s as its own upstream."),
> +					local);
> +				return 0;

I am a bit surprised with this warning and early return before
inspecting the remainder of the list.  When 'origin' is NULL,
i.e. we are talking about the local building on top of another local
branch, if the function is called for the local branch 'main' with
'main' in the remotes list alone, we do want to issue the warning
and exit without doing anything (i.e. degenerating to the original
behaviour of taking a single string variable, when a string list
with a single element is given).  But if the remotes list has 'main'
and 'master', would we want to just "skip" the same one, but still
handle the other ones as if the "same" branch were not in the list?

> @@ -75,8 +80,17 @@ int install_branch_config(int flag, const char *loca=
l, const char *origin, const
> =20
>  	strbuf_reset(&key);
>  	strbuf_addf(&key, "branch.%s.merge", local);
> -	if (git_config_set_gently(key.buf, remote) < 0)
> +	/*
> +	 * We want to overwrite any existing config with all the branches in
> +	 * "remotes". Override any existing config with the first branch, but=
 if
> +	 * more than one is provided, use CONFIG_REGEX_NONE to preserve what
> +	 * we've written so far.
> +	 */
> +	if (git_config_set_gently(key.buf, remotes->items[0].string) < 0)
>  		goto out_err;
> +	for (i =3D 1; i < remotes->nr; i++)
> +		if (git_config_set_multivar_gently(key.buf, remotes->items[i].string=
, CONFIG_REGEX_NONE, 0) < 0)
> +			goto out_err;
> =20
>  	if (rebasing) {
>  		strbuf_reset(&key);
> @@ -87,29 +101,62 @@ int install_branch_config(int flag, const char *lo=
cal, const char *origin, const
>  	strbuf_release(&key);
> =20
>  	if (flag & BRANCH_CONFIG_VERBOSE) {
> -		if (shortname) {
> -			if (origin)
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track remote branch '%s' from '%s' by =
rebasing.") :
> -					  _("Branch '%s' set up to track remote branch '%s' from '%s'."),
> -					  local, shortname, origin);
> -			else
> -				printf_ln(rebasing ?
> -					  _("Branch '%s' set up to track local branch '%s' by rebasing.")=
 :
> -					  _("Branch '%s' set up to track local branch '%s'."),
> -					  local, shortname);
> +		int plural =3D remotes->nr > 1;
> +		int all_shortnames =3D 1;
> +		const char *msg_fmt;
> +		struct strbuf ref_string =3D STRBUF_INIT;
> +
> +		for (i =3D 0; i < remotes->nr; i++)
> +			if (skip_prefix(remotes->items[i].string, "refs/heads/", &shortname=
)) {
> +				strbuf_addf(&ref_string, "'%s', ", shortname);
> +			} else {
> +				all_shortnames =3D 0;
> +				strbuf_addf(&ref_string, "'%s', ", remotes->items[i].string);

So, all_shortnames =3D=3D true means everything was a local branch in
the 'origin' remote, and when it has a non-branch (like a tag),
all_shortnames becomes false?

> +			}
> +		/* The last two characters are an extraneous ", ", so trim those. */
> +		strbuf_setlen(&ref_string, ref_string.len - 2);

As you are starting from an empty ref_string, a more idiomatic way
to build concatenated string would be to prefix when you add a new
item, e.g.

	loop {
		if (ref_string already has items)
			ref_string.append(", ");
		ref_string.append(this_item);
	}

> +		if (all_shortnames && origin) {
> +			if (rebasing && plural)
> +				msg_fmt =3D "Branch '%s' set up to track remote branches %s from '=
%s' by rebasing.";

What does it mean to keep my 'topic' branch up-to-date by rebasing
on top of more than one remote sources?  By merging, I can sort-of
understand (i.e. creating an octopus), but would it make sense to
track more than one remote sources in general?  Is it common?

When the benefit is not clear, it might make more sense not to do
this when there are already multiple tracking sources defined for
the original; it might be a mistake that we may not want to spread
with the new option.

Of course, it is very possible that I am missing a perfectly valid
use case where having more than one makes good sense.  If so, please
do not take the above comments as an objection, but adding some
comments before the function to explain when having remote list with
more than one items makes sense and how such a setting can be used
to avoid future readers asking the same (stupid) question as I just
did.


> +			else if (rebasing && !plural)
> +				msg_fmt =3D "Branch '%s' set up to track remote branch %s from '%s=
' by rebasing.";
> +			else if (!rebasing && plural)
> +				msg_fmt =3D "Branch '%s' set up to track remote branches %s from '=
%s'.";
> +			else if (!rebasing && !plural)
> +				msg_fmt =3D "Branch '%s' set up to track remote branch %s from '%s=
'.";
> +
> +			printf_ln(_(msg_fmt), local, ref_string, origin);

I am not sure how well the "plural" thing works with i18n.  It may
suffice for the original in English to have only two choices between
one or more-than-one, but not all languages are English.  Counting
the actual number (I guess remotes->nr is it) and using Q_() to
choose between the possible variants.  I think =C3=86var knows about this
much better than I do.

But if we are not doing this "set multiple" and instead go the
"detect existing multiple and refrain from spreading the damage"
route, all of that is moot.

Thanks.
