Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE3C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22B522063A
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 18:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="r41oE5DC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390754AbgHQSf2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 14:35:28 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61324 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389681AbgHQSfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 14:35:16 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 62F1FDACA9;
        Mon, 17 Aug 2020 14:35:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mkfL7ny+6IDmJur27OzQQLztU0g=; b=r41oE5
        DC5s4S31G+g876pmzCecF55wJ+sviGk0Ddw25Wr1T1u7JHH9Jp1n766ScYt41TLy
        cQSb/rtJYLW/XECiXfdDiey73X2w5706hybaIyzHbg6libhndSX2vuy3FshD0lm6
        qo3w8Huf6TnTdpnJqSggOEUEOJf2hyMiAlb58=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=dTRqekl8hPdKZ2w5GU0bSxKTO72Vkkdg
        cjRGa//6BfAu37wZIAvP60wnkolY8Pg/SbBT0K/nLFBvxDzAkhvZh2iUMPu2cDaS
        1ZUifl5x6RQ2z8YC3Y3l+gQ3WLVfq5mZBiyIDPCkXTf1lhH7t1Wk1aN88rymXgo3
        Q4eIqNAQjeU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5BE2FDACA8;
        Mon, 17 Aug 2020 14:35:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A0EB8DACA6;
        Mon, 17 Aug 2020 14:35:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] add -p: use ALLOC_GROW_BY instead of ALLOW_GROW
References: <pull.702.git.1597670589.gitgitgadget@gmail.com>
        <ae6ace43af9b25ee8f67b01ed1ec50064c8b006f.1597670589.git.gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 11:35:09 -0700
In-Reply-To: <ae6ace43af9b25ee8f67b01ed1ec50064c8b006f.1597670589.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Mon, 17 Aug 2020 13:23:07
        +0000")
Message-ID: <xmqqy2md15pe.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 61BF398E-E0B8-11EA-860F-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This simplifies the code slightly, especially the third case where
> hunk_nr was incremented a few lines before ALLOC_GROW().

OK, we lose memset()s that appear to be separate but is a part of
adding more elements.  Makes sense.

>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  add-patch.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
>
> diff --git a/add-patch.c b/add-patch.c
> index f899389e2c..a15fa407be 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -457,11 +457,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  			eol = pend;
>  
>  		if (starts_with(p, "diff ")) {
> -			s->file_diff_nr++;
> -			ALLOC_GROW(s->file_diff, s->file_diff_nr,
> +			ALLOC_GROW_BY(s->file_diff, s->file_diff_nr, 1,
>  				   file_diff_alloc);
>  			file_diff = s->file_diff + s->file_diff_nr - 1;
> -			memset(file_diff, 0, sizeof(*file_diff));
>  			hunk = &file_diff->head;
>  			hunk->start = p - plain->buf;
>  			if (colored_p)
> @@ -483,11 +481,9 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  				 */
>  				hunk->splittable_into++;
>  
> -			file_diff->hunk_nr++;
> -			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
> +			ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
>  				   file_diff->hunk_alloc);
>  			hunk = file_diff->hunk + file_diff->hunk_nr - 1;
> -			memset(hunk, 0, sizeof(*hunk));
>  
>  			hunk->start = p - plain->buf;
>  			if (colored)
> @@ -511,7 +507,7 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  			if (file_diff->mode_change)
>  				BUG("double mode change?\n\n%.*s",
>  				    (int)(eol - plain->buf), plain->buf);
> -			if (file_diff->hunk_nr++)
> +			if (file_diff->hunk_nr)
>  				BUG("mode change in the middle?\n\n%.*s",
>  				    (int)(eol - plain->buf), plain->buf);
>  
> @@ -520,9 +516,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>  			 * is _part of_ the header "hunk".
>  			 */
>  			file_diff->mode_change = 1;
> -			ALLOC_GROW(file_diff->hunk, file_diff->hunk_nr,
> +			ALLOC_GROW_BY(file_diff->hunk, file_diff->hunk_nr, 1,
>  				   file_diff->hunk_alloc);
> -			memset(file_diff->hunk, 0, sizeof(struct hunk));
>  			file_diff->hunk->start = p - plain->buf;
>  			if (colored_p)
>  				file_diff->hunk->colored_start =
