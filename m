Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1FB621F404
	for <e@80x24.org>; Thu,  4 Jan 2018 21:41:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753160AbeADVlp (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 16:41:45 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53043 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbeADVlp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 16:41:45 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3789BCEDCD;
        Thu,  4 Jan 2018 16:41:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OASuaOtJXJcaetX8Ab+ioRMIGxY=; b=emXKBU
        FC7sbVOWXJtep9k0Z9hhTN1bu501ACtfguJfySYBEsr9ygDCp2NSwGtp1KDUtMCG
        IyJfTxp/531/MEFDSFeMb5QVK8eHl9ONBurZTuYIJGlJ3wP1a7PCWDMGYXMib3PH
        9rNgmGQdu9bxjNPOkm/+eQfZGoaomiAcEP+aY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Km0hdGXp7p8v9l34978zbSO5OX2YjkNi
        /pQSVwgXc6QlB+A09Inw0rLS0Rlu03MSQ4lUakX435KgaY8YcuTJBIyvNLFE1DuI
        VNgQXot+3zfSZ65MRhJ+jwjCrM8vIF3bnCCq+2kJWmswzeCzv4tDuJwIf7Rlk7+l
        1ihTl9XcPLw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F9F8CEDCB;
        Thu,  4 Jan 2018 16:41:44 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0068CEDCA;
        Thu,  4 Jan 2018 16:41:43 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v3 1/5] stat_tracking_info: return +1 when branches not equal
References: <20180103214733.797-1-git@jeffhostetler.com>
        <20180103214733.797-2-git@jeffhostetler.com>
Date:   Thu, 04 Jan 2018 13:41:42 -0800
In-Reply-To: <20180103214733.797-2-git@jeffhostetler.com> (Jeff Hostetler's
        message of "Wed, 3 Jan 2018 21:47:29 +0000")
Message-ID: <xmqqr2r5e1yh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0E61CBC4-F198-11E7-A1FA-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> -		if (stat_tracking_info(branch, &num_ours,
> -				       &num_theirs, NULL)) {
> +		if (stat_tracking_info(branch, &num_ours, &num_theirs,
> +				       NULL, AHEAD_BEHIND_FULL) < 0) {
> ...
> -		if (stat_tracking_info(branch, &num_ours,
> -				       &num_theirs, NULL))
> +		if (stat_tracking_info(branch, &num_ours, &num_theirs,
> +				       NULL, AHEAD_BEHIND_FULL) < 0)

Mental note: any code that reacted to stat_tracking_info() returning
non-zero was reacting to "no useful info in num_{ours,theirs}".
They now have to compare the returned value with "< 0" for the same
purpose.

> ...
>   * Returns -1 if num_ours and num_theirs could not be filled in (e.g., no
> - * upstream defined, or ref does not exist), 0 otherwise.
> + * upstream defined, or ref does not exist).  Returns 0 if the commits are
> + * identical.  Returns 1 if commits are different.
>   */
>  int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
> -		       const char **upstream_name)
> +		       const char **upstream_name, enum ahead_behind_flags abf)
>  {
>  	struct object_id oid;
>  	struct commit *ours, *theirs;
> @@ -2019,6 +2026,8 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs,
>  		*num_theirs = *num_ours = 0;
>  		return 0;
>  	}
> +	if (abf == AHEAD_BEHIND_QUICK)
> +		return 1;
> ...
>  	argv_array_clear(&argv);
> -	return 0;
> +	return 1;
>  }

When a caller gets +1 from the function, it is not safe to peek into
*num_{ours,theirs} if it passed _QUICK.

> @@ -2064,7 +2073,8 @@ int format_tracking_info(struct branch *branch, struct strbuf *sb)
> -	if (stat_tracking_info(branch, &ours, &theirs, &full_base) < 0) {
> +	if (stat_tracking_info(branch, &ours, &theirs, &full_base,
> +			       AHEAD_BEHIND_FULL) < 0) {

Sane conversion to the new return value convention.

> diff --git a/wt-status.c b/wt-status.c
> index 94e5eba..8f7fdc6 100644
> --- a/wt-status.c
> +++ b/wt-status.c
> @@ -1791,7 +1791,8 @@ static void wt_shortstatus_print_tracking(struct wt_status *s)
>  
>  	color_fprintf(s->fp, branch_color_local, "%s", branch_name);
>  
> -	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base) < 0) {
> +	if (stat_tracking_info(branch, &num_ours, &num_theirs, &base,
> +			       AHEAD_BEHIND_FULL) < 0) {

Ditto.

> @@ -1928,7 +1929,8 @@ static void wt_porcelain_v2_print_tracking(struct wt_status *s)
>  		/* Lookup stats on the upstream tracking branch, if set. */
>  		branch = branch_get(branch_name);
>  		base = NULL;
> -		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind, &base) == 0);
> +		ab_info = (stat_tracking_info(branch, &nr_ahead, &nr_behind,
> +					      &base, AHEAD_BEHIND_FULL) >= 0);

If a later step plans to (conditionally) allow _QUICK to be passed
here, this conversion is questionable, because ab_info being true
no longer is a sign that nr_{ahead,behind} are valid.

I suspect that moving the "s/ab_info/sti/" bits around here from
step [2/5] to this commit may make the result after this patch more
consistent, but it is not a big deal either way.

>  		if (base) {
>  			base = shorten_unambiguous_ref(base, 0);
>  			fprintf(s->fp, "# branch.upstream %s%c", base, eol);

