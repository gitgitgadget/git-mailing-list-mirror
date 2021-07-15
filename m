Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53740C636C9
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20456613D4
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 23:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbhGOXUL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 19:20:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56414 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbhGOXUK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 19:20:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7481E13D527;
        Thu, 15 Jul 2021 19:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=E+T8Zor66lDZo+RkyiUr5XWTjiquaZDFrbFdBY
        pXCaE=; b=uaoMUhaJgUInb8mnwHIkPvvNOWh9FuoZdTXb8It5DnH63iO9g0LZCa
        K/CautpKZ05BHQjaAtGOyzOnPocy0IO3swTBTTeiXxSoa6yxeeB6IV+cR6sOlL9K
        ZGvKixBVJnn/67dLuBNr/Io0a8iPVbuUxVy5THYOodyz3Rji1+VIA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6BEE413D526;
        Thu, 15 Jul 2021 19:17:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id BAEA913D522;
        Thu, 15 Jul 2021 19:17:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 3/4] diffcore-rename: treat a rename_limit of 0 as
 unlimited
References: <pull.1044.v2.git.git.1626225153.gitgitgadget@gmail.com>
        <pull.1044.v3.git.git.1626309924.gitgitgadget@gmail.com>
        <00a2072baea435060b525b3907121bdf980461e9.1626309924.git.gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 16:17:11 -0700
In-Reply-To: <00a2072baea435060b525b3907121bdf980461e9.1626309924.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Thu, 15 Jul 2021
        00:45:23 +0000")
Message-ID: <xmqqczrjrwug.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C9D98910-E5C2-11EB-9688-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/diffcore-rename.c b/diffcore-rename.c
> index 3375e24659e..513ba7b05f1 100644
> --- a/diffcore-rename.c
> +++ b/diffcore-rename.c
> @@ -1021,7 +1021,7 @@ static int too_many_rename_candidates(int num_destinations, int num_sources,
>  	 * memory for the matrix anyway.
>  	 */
>  	if (rename_limit <= 0)
> -		rename_limit = 32767;
> +		return 0; /* treat as unlimited */

OK.  As this short-cuts, the impact a non-positive value may have on
all the remainder of the function (like limit squared must be larger
than the matrix) would not have to be compensated for.  Very simple
and clean.

>  	if (st_mult(num_destinations, num_sources)
>  	    <= st_mult(rename_limit, rename_limit))
>  		return 0;
