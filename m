Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C475C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 06:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1D66613AF
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 06:13:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbhDFGNz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 02:13:55 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58602 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233272AbhDFGNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 02:13:54 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8509CB464F;
        Tue,  6 Apr 2021 02:13:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lRi0aJ/oabEbIluZUlBdtbsYigU=; b=lCfGKD
        l9n1ncMuFPGF+LU+azxs9dhocemzxlIxtHHbR+Bd3FOUNjIxHQbjtfGusbZK0uPV
        Wpdra7jrZuKmLMo6XePfhxNelUf1MGFr+mHq8BfKfIyJ8dCaCtOidpZJ+zhDTT3T
        vN0EDaHoymIcwHgNzF+9MjebIecWKUoYRvv3s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=qCeYK7279SjR73jNeyVn17addUdJjomM
        G2ndEmYHaCdNUeJfsrcANNTqgYQCjiBen9atqt1Y0xd7Z8FhJj8FHq7i5Plo6a0W
        tnzKnYD6e/iR2zwMiwynSeuRwhQSSnjyZfY+WVg/7GjC0XtN+UyE/KeOsypmF+6C
        ZFEix4QxXa4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7CBE4B464E;
        Tue,  6 Apr 2021 02:13:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0171BB464D;
        Tue,  6 Apr 2021 02:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, newren@gmail.com, ross@skydio.com,
        abe@skydio.com, brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-apply: try threeway first when "--3way" is used
References: <20210406025551.25213-1-jerry@skydio.com>
Date:   Mon, 05 Apr 2021 23:13:45 -0700
In-Reply-To: <20210406025551.25213-1-jerry@skydio.com> (Jerry Zhang's message
        of "Mon, 5 Apr 2021 19:55:51 -0700")
Message-ID: <xmqqblas2b52.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EAA6DB8-969F-11EB-8476-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> The apply_fragments() method of "git apply"
> can silently apply patches incorrectly if
> a file has repeating contents. In these
> cases a three-way merge can apply it correctly

Is that "can apply"?  Isn't it "has a better chance to correctly
apply"?

> or show a conflict. However, because the patches
> apply "successfully" using apply_fragments(),
> git will never fall back to the merge, even
> if the "--3way" flag is used, and the user has
> no way to ensure correctness by forcing the
> three-way merge method.
>
> Change the behavior so that when "--3way" is
> used, git will always try the three-way merge
> first and will only fall back to apply_fragments()
> in caseswhere blobs are not available or some other

Missing SP before two words.

> error (but not in the case of a merge conflict).

We may want to note a possible backward compatibility fallout to
warn reviewers here in the proposed log message.

>  -3::
>  --3way::
> +	Attempt 3-way merge if the patch records the identity of blobs it is supposed
> +	to apply to and we have those blobs available locally, possibly leaving the
>  	conflict markers in the files in the working tree for the user to
>  	resolve.  This option implies the `--index` option, and is incompatible
>  	with the `--reject` and the `--cached` options.

OK.  This patch obviously expects it to graduate before the other
"--3way and --cached at the same time" patch.

> diff --git a/apply.c b/apply.c
> index 6695a931e979a968b28af88d425d0c76ba17d0d4..62d65ef8d9c0b68857db55198c73db1f41589df1 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -3569,10 +3569,10 @@ static int try_threeway(struct apply_state *state,
>  		write_object_file("", 0, blob_type, &pre_oid);
>  	else if (get_oid(patch->old_oid_prefix, &pre_oid) ||
>  		 read_blob_object(&buf, &pre_oid, patch->old_mode))
> -		return error(_("repository lacks the necessary blob to fall back on 3-way merge."));
> +		return error(_("repository lacks the necessary blob to do 3-way merge."));

s/do/perform/ perhaps?

> @@ -3637,10 +3637,9 @@ static int apply_data(struct apply_state *state, struct patch *patch,
>  	if (load_preimage(state, &image, patch, st, ce) < 0)
>  		return -1;
>  
> -	if (patch->direct_to_threeway ||
> -	    apply_fragments(state, &image, patch) < 0) {

The original was "If the logic flow that came before us already
decided we should skip the straight application of the patch and
jump directly to the three-way codepath.  Otherwise try the straight
application and perform 3-way only when it fails".

The "direct-to-threeway" logic was introduced by 099f3c42 (apply:
--3way with add/add conflict, 2012-06-07).

> +	if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0) {
>  		/* Note: with --reject, apply_fragments() returns 0 */
> -		if (!state->threeway || try_threeway(state, &image, patch, st, ce) < 0)
> +		if (patch->direct_to_threeway || apply_fragments(state, &image, patch) < 0)
>  			return -1;

This says something different.  "If 3-way was not asked, jump
directly to inside the block.  Otherwise, try 3-way first, and go
inside the block only if 3-way did not work."  And the inside the
block is the straight patch application.  It says "if we have
already decided we should do the 3-way and nothing else, just fail.
Otherwise try the straight patch application and if it fails, then
fail the whole thing."

This looks like a correct "inversion" of the fallback codepath.

> @@ -5017,7 +5016,7 @@ int apply_parse_options(int argc, const char **argv,
>  		OPT_BOOL(0, "apply", force_apply,
>  			N_("also apply the patch (use with --stat/--summary/--check)")),
>  		OPT_BOOL('3', "3way", &state->threeway,
> -			 N_( "attempt three-way merge if a patch does not apply")),
> +			 N_( "attempt three-way merge, fall back on normal patch if that fails")),

OK.

Overall, the change is very cleanly done.

Will queue.  Thanks.


