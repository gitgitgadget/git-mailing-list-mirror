Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87D23C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:45:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465A020637
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 13:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qsi8vyBI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfLFNp5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 08:45:57 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58987 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfLFNp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 08:45:57 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B4FBC1C298;
        Fri,  6 Dec 2019 08:45:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=16pElyQRSTlpg2d/VlCgcdcDOzk=; b=qsi8vy
        BI7DFMPY5rYHWj96IEpxRkPFkSSsWDRfArcLlKG3nS0QplfVNk5gYaW1WByxbWsh
        IQ0vP8CwF72X865vilmG5cJ/jKhwqwZZFM8ZJ9rxRK9XgIOBBxwTG7h+lam2HKm4
        Z0YhFSwVK5zrO7TIkMwdfz1iCfoaQ5kc9y1bQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KiCGI9dVrcXjF613EyRwYuaMBPolFCNa
        WtpWYLzy7LUc1ysgc15Y8V9p7WanBdxAOORmg3iKfDDNrxu9A2xLRqsYUcfYGrnf
        0CUKwd5q+Bw60JWff4OYS/4piswi4LAFW2e+JK4LY5yAGXYlngPqEJIvRXbopT42
        vPVyyxqysPY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AD6F01C297;
        Fri,  6 Dec 2019 08:45:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 170541C296;
        Fri,  6 Dec 2019 08:45:54 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 7/7] apply --allow-overlap: fix a corner case
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
        <15c4cce5a027d56c7ddbe5523cf0f3beabd06ed7.1575637705.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Dec 2019 05:45:52 -0800
In-Reply-To: <15c4cce5a027d56c7ddbe5523cf0f3beabd06ed7.1575637705.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Fri, 06 Dec 2019
        13:08:25 +0000")
Message-ID: <xmqqr21hy3cf.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B9173BDA-182E-11EA-8A29-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Yes, yes, this is supposed to be only a band-aid option for `git add -p`
> not Doing The Right Thing. But as long as we carry the `--allow-overlap`
> option, we might just as well get it right.

It probably depends on the definition of "right", where it may not
even exist (otherwise it wouldn't be a band-aid but be a real
feature) ;-)

> This fixes the case where one hunk inserts a line before the first line,
> and is followed by a hunk whose context overlaps with the first one's
> and which appends a line at the end.

The in-code comment makes me wonder if we need to further loosen the
check in the other direction, though.  What makes begin more special
than end?  Can a hunk be seen that pretends to extend to the end but
no longer does because there was an overlapping hunk that has been
wiggled in?

>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  apply.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/apply.c b/apply.c
> index f8a046a6a5..720a631eaa 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -2661,6 +2661,16 @@ static int find_pos(struct apply_state *state,
>  	unsigned long backwards, forwards, current;
>  	int backwards_lno, forwards_lno, current_lno;
>  
> +	/*
> +	 * When running with --allow-overlap, it is possible that a hunk is
> +	 * seen that pretends to start at the beginning (but no longer does),
> +	 * and that *still* needs to match the end. So trust `match_end` more
> +	 * than `match_beginning`.
> +	 */
> +	if (state->allow_overlap && match_beginning && match_end &&
> +	    img->nr - preimage->nr != 0)
> +		match_beginning = 0;
> +
>  	/*
>  	 * If match_beginning or match_end is specified, there is no
>  	 * point starting from a wrong line that will never match and
