Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05628C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B859F6100C
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 07:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231327AbhD0HrJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 03:47:09 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64157 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230438AbhD0HrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 03:47:09 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CEA9BC0994;
        Tue, 27 Apr 2021 03:46:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=CtguxxVp/y+OT8IAVFzpSrbtvWuNn7BcAgLKAP
        7yZTI=; b=pC8FdMwk074AoxDOHmgGor2XPa6eKeddqamN5vd7lWeRqEJ2gvtVRe
        I/h2X3quvmzQfV/yhfB1F3iQw7Ok0ilK3aQpr2gyETe/XL7G/tnhUjvU0iByfjET
        Eldd090HP2DGl+BmtjdcEJk1wmsolnszzhUNR8BGYOujUxMiSczzk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C4E01C0993;
        Tue, 27 Apr 2021 03:46:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 52636C0992;
        Tue, 27 Apr 2021 03:46:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: modify prints to account for --3way changes
References: <20210427011314.28156-1-jerry@skydio.com>
Date:   Tue, 27 Apr 2021 16:46:24 +0900
In-Reply-To: <20210427011314.28156-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 26 Apr 2021 18:13:14 -0700")
Message-ID: <xmqqczugdvan.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAF55C4C-A72C-11EB-8507-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> "git apply" specifically calls out when it
> is falling back to 3way merge application.
> Since the order changed to preferring 3way
> and falling back to direct application,
> continue that behavior by printing whenever
> 3way fails and git has to fall back.

That makes sense.


> Add a --quiet flag to "git apply" so the user
> can turn down the verbosity.

It makes sense, too.

But aren't they a different change that should belong to a separate
patch?  After all, the first point is to give the same kind of
fallback warning/report as we used to before we swapped the fallback
order, and no users needed extra "more silent" setting to deal with
the fallback warning messages.  Allowing to set the verbosity even
lower may be desirable, but that is an independent new feature,
isn't it?

I wonder if it is the more correct approach to replace
OPT__VERBOSE() with OPT_VERBOSITY() here, instead of adding a
separate OPT_SET_INT() like you did.

Thanks.

> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
>  apply.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index 8532b48e4f..2abf2e8a61 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3572,7 +3572,7 @@ static int try_threeway(struct apply_state *state,
>  		 read_blob_object(&buf, &pre_oid, patch->old_mode))
>  		return error(_("repository lacks the necessary blob to perform 3-way merge."));
>  
> -	if (state->apply_verbosity > verbosity_silent)
> +	if (state->apply_verbosity > verbosity_silent && patch->direct_to_threeway)
>  		fprintf(stderr, _("Performing three-way merge...\n"));
>  
>  	img = strbuf_detach(&buf, &len);
> @@ -3639,6 +3639,10 @@ static int apply_data(struct apply_state *state, struct patch *patch,
>  		return -1;
>  
>  	if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
> +		if (state->apply_verbosity > verbosity_silent &&
> +		    state->threeway && !patch->direct_to_threeway)
> +			fprintf(stderr, _("Falling back to direct application...\n"));
> +
>  		/* Note: with --reject, apply_fragments() returns 0 */
>  		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
>  			return -1;
> @@ -5050,6 +5054,8 @@ int apply_parse_options(int argc, const char **argv,
>  		OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
>  			N_("allow overlapping hunks")),
>  		OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
> +		OPT_SET_INT('q', "quiet", &state->apply_verbosity,
> +			N_("be quiet"), -1),
>  		OPT_BIT(0, "inaccurate-eof", options,
>  			N_("tolerate incorrectly detected missing new-line at the end of file"),
>  			APPLY_OPT_INACCURATE_EOF),
