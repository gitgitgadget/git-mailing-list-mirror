Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132C3C433B4
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC899610E9
	for <git@archiver.kernel.org>; Thu, 20 May 2021 00:21:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbhETAWX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 20:22:23 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60387 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbhETAWX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 20:22:23 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AAEA41332C9;
        Wed, 19 May 2021 20:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=o2aCJg8oW+3YOtgx4pMP6PbBB/AiRilba9G3kK
        xkybc=; b=JcyCeyyoX2IBftPIATXLm9XYgW+VqYxjU8V4Xk6/9ZVnq2jYIk5snX
        5Gdmmb9hRNVIQMcweuGqi1XV3z/F+y6OhgFE4tQkQoZcRcxs4rwR+vBgpUAmOCSn
        A7Hce99IxNADzo2pASy7YC/wInqT/MhEmRGS20Lno29am3kHsb3vg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A39321332C8;
        Wed, 19 May 2021 20:21:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F12B21332C5;
        Wed, 19 May 2021 20:20:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] trace2: refactor to avoid gcc warning under -O3
References: <patch-1.1-87d9bcf1095-20210505T083951Z-avarab@gmail.com>
        <patch-1.1-782555daade-20210511T130231Z-avarab@gmail.com>
        <YJrEy8IPi+PFWuzT@coredump.intra.peff.net>
        <YJrIMbr6VkYGQMfs@coredump.intra.peff.net>
Date:   Thu, 20 May 2021 09:20:58 +0900
In-Reply-To: <YJrIMbr6VkYGQMfs@coredump.intra.peff.net> (Jeff King's message
        of "Tue, 11 May 2021 14:08:49 -0400")
Message-ID: <xmqqim3ew905.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40E8DE6E-B901-11EB-96C3-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I also wondered briefly why we needed the out-parameter at all, and not
> just letting the caller look at errno. The answer is that we need to
> preserve it across the close() call. The more usual thing in our code
> base _would_ be to use saved_errno, but not have it as an out-parameter.
>
> I.e.:
>
> diff --git a/trace2/tr2_dst.c b/trace2/tr2_dst.c
> index ae052a07fe..bda283e7f4 100644
> --- a/trace2/tr2_dst.c
> +++ b/trace2/tr2_dst.c
> @@ -204,15 +204,16 @@ static int tr2_dst_try_uds_connect(const char *path, int sock_type, int *out_fd)
>  
>  	fd = socket(AF_UNIX, sock_type, 0);
>  	if (fd == -1)
> -		return errno;
> +		return -1;
>  
>  	sa.sun_family = AF_UNIX;
>  	strlcpy(sa.sun_path, path, sizeof(sa.sun_path));
>  
>  	if (connect(fd, (struct sockaddr *)&sa, sizeof(sa)) == -1) {
> -		int e = errno;
> +		int saved_errno = errno;
>  		close(fd);
> -		return e;
> +		errno = saved_errno;
> +		return -1;
>  	}
>  
> ...
>
> I do prefer that approach, since I think it's more idiomatic for our
> code base, but for the sake of wrapping up this simple fix which has
> been discussed much more than I think it deserves, I am OK with either.
> :)

I think this alternative is more readable as well.

I'll mark the topic to be "Expecting a reroll" in the what's cooking
report.

Thanks.
