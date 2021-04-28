Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB815C43461
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6BDE60234
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 07:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhD1HdN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 03:33:13 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57288 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236792AbhD1HdM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 03:33:12 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 387E3AFCF8;
        Wed, 28 Apr 2021 03:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=km5/kwDvUoN8AZzHN7eMwz4dtjcaMLnaLSdtiQ
        kKWSw=; b=hkSKjbwkjJAOJADmAwKWvxEsQFFAzpmRYh1r29gyWV/YugiqUxi6FJ
        VZ4yHJI10sd6olniX1uIRg9lOP4vik8mZzVJZQBQHTmJlhmNdryeYRN5O5BmY/cW
        ICyIdehQkLKINHyyz27CwSQL14nnp++VBnIgyxJztZwYkOqtmrUis=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E1F1AFCF7;
        Wed, 28 Apr 2021 03:32:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9D0A1AFCF2;
        Wed, 28 Apr 2021 03:32:26 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH V2] git-apply: modify prints to account for --3way changes
References: <20210427011314.28156-1-jerry@skydio.com>
        <20210427194005.14318-1-jerry@skydio.com>
Date:   Wed, 28 Apr 2021 16:32:26 +0900
In-Reply-To: <20210427194005.14318-1-jerry@skydio.com> (Jerry Zhang's message
        of "Tue, 27 Apr 2021 12:40:05 -0700")
Message-ID: <xmqq7dkmc19x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E17946EE-A7F3-11EB-AF27-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Subject: Re: [PATCH V2] git-apply: modify prints to account for --3way changes

Sorry that I missed this in the previous round, but what do you mean
by "prints" here?

> "git apply" specifically calls out when it is falling back to 3way
> merge application.  Since the order changed to preferring 3way and
> falling back to direct application, continue that behavior by
> printing whenever 3way fails and git has to fall back.

I am guessing it is safe to s/modify prints/adjust messages/ after
reading this explanation.

> Signed-off-by: Jerry Zhang <jerry@skydio.com>
> ---
> V1 -> V2:
> - Moved --quiet flag to separate patch
>
>  apply.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/apply.c b/apply.c
> index a36d4002ca..7aa49e2048 100644
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
