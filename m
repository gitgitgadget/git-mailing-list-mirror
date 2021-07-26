Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E937C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5652F60F6D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 19:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhGZSkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 14:40:07 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:50643 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhGZSkG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 14:40:06 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DE831136DEB;
        Mon, 26 Jul 2021 15:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oUYpkadqLzXTJTyVEap6oGIHGUprkZwtZNsD2a
        GQJMw=; b=ALFUOKu35N/t8wQZMRpfBylrHWGBgY/zT5OqQBrlDHzULKONldXWtL
        mf14zy4OYbmLyddYbKveCf9XngVGbBaaTrLsnbBmN1IUN81nNCvdDn5wdLCWRNJM
        HPq1iQCvI+Uc6wTFhuatmqtCyP/5DrkCPmVxBHyXXOr0YJy4K/bx0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6BEB136DEA;
        Mon, 26 Jul 2021 15:20:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 85629136DE9;
        Mon, 26 Jul 2021 15:20:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     andrzej@ahunt.org
Cc:     git@vger.kernel.org, phillip.wood123@gmail.com, newren@gmail.com
Subject: Re: [PATCH v2 01/12] fmt-merge-msg: free newly allocated temporary
 strings when done
References: <20210620151204.19260-1-andrzej@ahunt.org>
        <20210725130830.5145-1-andrzej@ahunt.org>
        <20210725130830.5145-2-andrzej@ahunt.org>
Date:   Mon, 26 Jul 2021 12:20:29 -0700
In-Reply-To: <20210725130830.5145-2-andrzej@ahunt.org> (andrzej@ahunt.org's
        message of "Sun, 25 Jul 2021 15:08:19 +0200")
Message-ID: <xmqqr1fkj30i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B35ED2A-EE46-11EB-8331-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

andrzej@ahunt.org writes:

> diff --git a/fmt-merge-msg.c b/fmt-merge-msg.c
> index 0f66818e0f..b969dc6ebb 100644
> --- a/fmt-merge-msg.c
> +++ b/fmt-merge-msg.c
> @@ -108,6 +108,7 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
>  	struct origin_data *origin_data;
>  	char *src;
>  	const char *origin, *tag_name;
> +	char *to_free = NULL;
>  	struct src_data *src_data;
>  	struct string_list_item *item;
>  	int pulling_head = 0;
> @@ -183,12 +184,13 @@ static int handle_line(char *line, struct merge_parents *merge_parents)
>  	if (!strcmp(".", src) || !strcmp(src, origin)) {
>  		int len = strlen(origin);
>  		if (origin[0] == '\'' && origin[len - 1] == '\'')
> -			origin = xmemdupz(origin + 1, len - 2);
> +			origin = to_free = xmemdupz(origin + 1, len - 2);
>  	} else
> -		origin = xstrfmt("%s of %s", origin, src);
> +		origin = to_free = xstrfmt("%s of %s", origin, src);
>  	if (strcmp(".", src))
>  		origin_data->is_local_branch = 0;
>  	string_list_append(&origins, origin)->util = origin_data;
> +	free(to_free);
>  	return 0;
>  }

Thanks; obviously correct.

