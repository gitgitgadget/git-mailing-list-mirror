Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A32BC433F5
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 05:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4771C61206
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 05:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbhIKFBk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 01:01:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51068 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhIKFBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 01:01:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C5861CA728;
        Sat, 11 Sep 2021 01:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZebCV3a9YucAUz+1YOStGV7+JMEuHbRDeS9sBp
        seQwk=; b=naGaSqbv7jt9YXq1KXe0PLwDUqCWT6lHE4+1RuBs4+5559KmAgKX//
        Yn5rLK5qgTeBMN4Acp+apCRvjtw9IkOUVFB8elx4sqonVNgYc4XjMSaigTHF2RM/
        V5W7vJu2OM3E7ZPwTMHMG8q3lAe7A6fgbqeFEd4mjnpEi6Av5Dvz4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE261CA727;
        Sat, 11 Sep 2021 01:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 479B1CA726;
        Sat, 11 Sep 2021 01:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 1/8] midx: expose 'write_midx_file_only()' publicly
References: <cover.1631331139.git.me@ttaylorr.com>
        <4afa03b972a1885c60fbf3716f22a7ab58056383.1631331139.git.me@ttaylorr.com>
Date:   Fri, 10 Sep 2021 22:00:26 -0700
In-Reply-To: <4afa03b972a1885c60fbf3716f22a7ab58056383.1631331139.git.me@ttaylorr.com>
        (Taylor Blau's message of "Fri, 10 Sep 2021 23:32:29 -0400")
Message-ID: <xmqqsfybn1ud.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2E18542A-12BD-11EC-969C-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>  	if (ends_with(file_name, ".idx")) {
>  		display_progress(ctx->progress, ++ctx->pack_paths_checked);
> -		if (ctx->m && midx_contains_pack(ctx->m, file_name))
> -			return;
> +		if (ctx->m) {
> +			if (midx_contains_pack(ctx->m, file_name))
> +				return;
> +		} else if (ctx->to_include) {
> +			if (!string_list_has_string(ctx->to_include, file_name))
> +				return;

What's the expected number of elements on the to_include list?  I am
wondering about the performance implications of using linear search
over the string-list, of course.  Is it about the same order of the
number of packfiles in a repository (up to several dozens, or 1000
at most unless you are insane, or something like that)?
