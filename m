Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0807C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 18:40:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346371AbiCXSlk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 14:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242030AbiCXSlj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 14:41:39 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559C55745
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 11:40:06 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CB423104477;
        Thu, 24 Mar 2022 14:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5iCHk+iHhU0S9p74JMqFeZme1ADLzBhxiYAp7s
        OAsUc=; b=vTzFE4O/8E3XRIHdSGJZKil6EZzmD7VPQNwR/bxv47TKHEQA8dCsum
        se2PCQsUPRNUC6XExv6FyqOjPd1Mtc4t3PmfusN4i2fgYiM22t27vkHaUpzc9CmN
        ezTDx8KcAr+s25nqZdatgXzY7QECjp4KLY1RJoApABgdxJVo4Pr4w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8728E104474;
        Thu, 24 Mar 2022 14:40:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 202AC104473;
        Thu, 24 Mar 2022 14:40:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, me@ttaylorr.com,
        derrickstolee@github.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH v1 2/3] pack-bitmap.c: add "break" statement in
 "open_pack_bitmap()"
References: <cover.1648119652.git.dyroneteng@gmail.com>
        <70500b63434f6e454631b3a8fde07c62b5adfef0.1648119652.git.dyroneteng@gmail.com>
Date:   Thu, 24 Mar 2022 11:40:02 -0700
In-Reply-To: <70500b63434f6e454631b3a8fde07c62b5adfef0.1648119652.git.dyroneteng@gmail.com>
        (Teng Long's message of "Thu, 24 Mar 2022 19:44:00 +0800")
Message-ID: <xmqq7d8ji48t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1EA3000-ABA1-11EC-BE49-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teng Long <dyroneteng@gmail.com> writes:

> There will be only one operant ".bitmap" file in repo, so let's
> add "break" statement in "open_pack_bitmap()" when looping all
> the packs in repo.

Googling "operant" only gives a psychology term X-<.

    : behavior (such as bar pressing by a rat to obtain food) that
    operates on the environment to produce rewarding and reinforcing
    effects.

I do not quite get this.  We expect that there may be more than one
.pack in the object store, and that is why we iterate over the packs
get_all_packs() gives us.  Then for each of these packs, we try to
open pack bitmap.

Ah, are you referring to the current limitation that we can have
only one .bitmap file, even when there are many packs in the object
store?

I wonder if that limitation is something we need to hardcode here.

IOW, when we ever extend the feature to allow more than one, we may
have to extend the "struct bitmap_index" so that we can have bitmap
info from more than one on-disk files, and the implementation of
open_pack_bitmap_1() (which is "read bitmap for this one pack" as
opposed to "read bitmpa for this repository" which is this function)
would certainly have to change, but would we need to revert this
change to the function?  If we do not omit this patch, i.e. even if
we know there can be only one pack that may have a corresponding
bitmap but if the code does not know it and has to try git_open()
only to see it fail, how much wasted effort are we talking about?

> Signed-off-by: Teng Long <dyroneteng@gmail.com>
> ---
>  pack-bitmap.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 931219adf0..b1357137bf 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -484,8 +484,10 @@ static int open_pack_bitmap(struct repository *r,
>  	assert(!bitmap_git->map);
>  
>  	for (p = get_all_packs(r); p; p = p->next) {
> -		if (open_pack_bitmap_1(bitmap_git, p) == 0)
> +		if (open_pack_bitmap_1(bitmap_git, p) == 0) {
>  			ret = 0;
> +			break;
> +		}
>  	}
>  
>  	return ret;
