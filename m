Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D54FBC433EF
	for <git@archiver.kernel.org>; Thu, 16 Jun 2022 16:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235685AbiFPQli (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jun 2022 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238281AbiFPQlc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jun 2022 12:41:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A623055B
        for <git@vger.kernel.org>; Thu, 16 Jun 2022 09:41:31 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FB4A1AEAAF;
        Thu, 16 Jun 2022 12:41:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7NzoiUhaTsZKA3oq9r90Eaxc30wRRRJ6qbnP+g
        41FvU=; b=xgDYxTNnzbNnKNUIy4zNJcAT61a7OTvnirEakEQf5XJ8eR3gFvtPBt
        vxvh2VscSDEq1AUQipP/BQgPxLV0UJ5YonV+FtPDv7fluww7JB5+u4cBbEJSpCY4
        pADtG7ZsP3dUA6P4K6frWtAaS26RE6ko5yUYnh5AsBwvIZ/H2CHoU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 07D2D1AEAAE;
        Thu, 16 Jun 2022 12:41:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id DEBC41AEAAD;
        Thu, 16 Jun 2022 12:41:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 10/11] relative_url(): fix incorrect condition
References: <pull.1264.git.1655336146.gitgitgadget@gmail.com>
        <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
Date:   Thu, 16 Jun 2022 09:41:24 -0700
In-Reply-To: <0bf70e65d2c9e187203a77088ff0f7d18510caca.1655336146.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Wed, 15 Jun 2022
        23:35:44 +0000")
Message-ID: <xmqqwndgv9vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29D29E32-ED93-11EC-A972-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In 63e95beb085c (submodule: port resolve_relative_url from shell to C,
> 2016-04-15), we added a loop over `url` where we are looking for `../`
> or `./` components.
>
> The loop condition we used is the pointer `url` itself, which is clearly
> not what we wanted.
>
> Pointed out by Coverity.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  remote.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/remote.c b/remote.c
> index 9b9bbfe80ec..bded6acbfe8 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -2846,7 +2846,7 @@ char *relative_url(const char *remote_url, const char *url,
>  	 * When the url starts with '../', remove that and the
>  	 * last directory in remoteurl.
>  	 */
> -	while (url) {
> +	while (*url) {
>  		if (starts_with_dot_dot_slash_native(url)) {
>  			url += 3;
>  			colonsep |= chop_last_dir(&remoteurl, is_relative);
		} else if (starts_with_dot_slash_native(url))
			url += 2;
		else
			break;
	}

Looking at the "problematic" code again, the original is bad in the
sense that it is utterly misleading, but not quite "incorrect", I
would think.

In other words, what the original wanted to write is an infinite
loop that uses an explicit "break" to terminate the iteration, so we
should have written "while (1)" in the first place.

We know that earlier part of the function already depends on url
being not NULL, and nothing in the loop makes it NULL.  *url that is
NUL would make the two starts_with_frotz() tests fail and causes the
loop to terminate by hitting "break", so while it is correct to
check *url, it is wasting cycles.

But this patch is not wrong per-se, so I still have it in my tree
;-)

Thanks.
