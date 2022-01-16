Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E9BC433F5
	for <git@archiver.kernel.org>; Sun, 16 Jan 2022 23:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236429AbiAPXTr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Jan 2022 18:19:47 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60674 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232895AbiAPXTq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Jan 2022 18:19:46 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AF7ED11D704;
        Sun, 16 Jan 2022 18:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8zFWPr8Waj5VwsQG3vcuDQWsSPWZEjLkXT8pOg
        X7a+0=; b=Ckof16Ve8fLDlsd7QeUbnHYCQnYhBw4VxybwAAyXhc3zcU+wLgtqWY
        skhqx2qdkwxgZs3ONmFXagQvnBYOgMICkE7/RtSc9Azo40VCAzFuTK0pDTP3we0o
        MKZeV0vkucX9XHNO7TsWSFqfhRKim0MGh92IdEzFAuTAaQFZHphmI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A6ECD11D703;
        Sun, 16 Jan 2022 18:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 17C3011D702;
        Sun, 16 Jan 2022 18:19:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] merge-ort: avoid assuming all renames detected
References: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com>
Date:   Sun, 16 Jan 2022 15:19:43 -0800
In-Reply-To: <pull.1194.git.git.1642212566346.gitgitgadget@gmail.com> (Elijah
        Newren via GitGitGadget's message of "Sat, 15 Jan 2022 02:09:26
        +0000")
Message-ID: <xmqqwnizxo8g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CA78F3F0-7722-11EC-8CBB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/merge-ort.c b/merge-ort.c
> index c3197970219..143d274f117 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -3060,6 +3060,10 @@ static int detect_and_process_renames(struct merge_options *opt,
>  	trace2_region_enter("merge", "regular renames", opt->repo);
>  	detection_run |= detect_regular_renames(opt, MERGE_SIDE1);
>  	detection_run |= detect_regular_renames(opt, MERGE_SIDE2);
> +	if (renames->needed_limit != 0) {

Don't compare with NULL or 0, i.e.

	if (renames->needed_limit) {

> +		renames->cached_pairs_valid_side = 0;
> +		renames->redo_after_renames = 0;
> +	}
>  	if (renames->redo_after_renames && detection_run) {
>  		int i, side;
>  		struct diff_filepair *p;

