Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3641C6369E
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 01:10:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68309221FB
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 01:10:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387520AbgLCBKI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 20:10:08 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55983 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgLCBKI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 20:10:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 59BEC8C2FE;
        Wed,  2 Dec 2020 20:09:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SkVJKGP0pJZd9a9oYwUm3/e3za4=; b=PHKOUK
        CD3umOjDaAeKIgdQghrxTWLXY7FfHTnaaCXhUK6ZPM0wjhnAv0uFYEc/3/G1BHPw
        PsOdtWIi2nsFn92pPqMf1telQpHZU7l54Fpd8tB1Md/F1Y5U1jGUciPBOx3+fYu9
        vqnbI6WAu6C/MPFxBJLcHnPKjePqGFZQRsxXk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RWYiGpJoPauKVDijSI0ySAZpDlWdwSuc
        hcq4Yc/wlBT1DMaquQigKVVf7xttt1Om2aDUeEx6C8x3vrgdA+muUj8k58ubYoaQ
        gkb6+VDlDgooIxwwJ1dhTgc1gFEd+wUSfpxJ15+3dASR5pihM81ZGx1u3mfT2iaO
        bLjTsytcNFw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 44E738C2FD;
        Wed,  2 Dec 2020 20:09:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D7AC8C2FC;
        Wed,  2 Dec 2020 20:09:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        git@vger.kernel.org
Subject: Re: [PATCH v1 07/27] diff-merges: move checks for first_parent_only
 out of the module
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201108213838.4880-1-sorganov@gmail.com>
        <20201108213838.4880-8-sorganov@gmail.com>
Date:   Wed, 02 Dec 2020 17:09:22 -0800
In-Reply-To: <20201108213838.4880-8-sorganov@gmail.com> (Sergey Organov's
        message of "Mon, 9 Nov 2020 00:38:18 +0300")
Message-ID: <xmqq360nk859.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E3AE400-3504-11EB-9C4A-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> The checks for first_parent_only don't in fact belong to this module,
> as the primary purpose of this flag is history traversal limiting, so
> get it out of this module and rename the
>
> diff_merges_first_parent_defaults_to_enable()
>
> to
>
> diff_merges_default_to_enable()

Again, neither is a great name.

More importantly, I do not think that I agree with the reasoning
given in the first paragraph.  The first-parent-only traversal means
that we pretend there is no second and later parents, so it makes
quite a lot of sense that the choice of that option affects how a
merge commit discovered during the traversal is show by default
(namely, as if it is just a single-parent commit).

If there are other reasons why we want to force the callers to check
for first-parent option (for example, it may make it easier to tweak
how each caller makes its decisions separately in later steps of
this series), the changes proposed by this step may be a right
solution, so I am not outright opposed to this patch, but the
rationale given above is not a strong enough justification for the
change, at least to me.

> +void diff_merges_default_to_enable(struct rev_info *revs) {

Perhaps "show_merges_by_default()".

> +	if (revs->ignore_merges < 0)		/* No -m */
>  		revs->ignore_merges = 0;

Perhaps "show_merges_in_cc_by_default()" (or "cc" spelled out as
"dense_combined").

>  void diff_merges_default_to_dense_combined(struct rev_info *revs) {
> -	if (revs->ignore_merges < 0) {
> -		/* There was no "-m" variant on the command line */
> +	if (revs->ignore_merges < 0) {		/* No -m */
>  		revs->ignore_merges = 0;
> -		if (!revs->first_parent_only && !revs->combine_merges) {
> -			/* No "--first-parent", "-c", or "--cc" */
> +		if (!revs->combine_merges) {	/* No -c/--cc" */
>  			revs->combine_merges = 1;
>  			revs->dense_combined_merges = 1;
>  		}
> diff --git a/diff-merges.h b/diff-merges.h
> index 648c410497cb..cf411414898d 100644
> --- a/diff-merges.h
> +++ b/diff-merges.h
> @@ -11,7 +11,7 @@ void diff_merges_setup_revs(struct rev_info *revs);
>  
>  void diff_merges_default_to_dense_combined(struct rev_info *revs);
>  
> -void diff_merges_first_parent_defaults_to_enable(struct rev_info *revs);
> +void diff_merges_default_to_enable(struct rev_info *revs);
>  
>  
>  #endif
