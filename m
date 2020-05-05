Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1952C47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:08:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B041B20721
	for <git@archiver.kernel.org>; Tue,  5 May 2020 05:08:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LUz0eT8P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgEEFH7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 May 2020 01:07:59 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60975 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgEEFH7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 May 2020 01:07:59 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BCC860826;
        Tue,  5 May 2020 01:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EQzdZ2zjlLN6nY/zD/qMNA4mPuI=; b=LUz0eT
        8PTUvxokkNyxoJPoHF2g3vmzV0GKKeLhegIQql5zqS7rI02/rhb0+QeRVpLc/FHK
        N0/GTN5FIkmOAmcGfJonG9vxnZgrqmyXR7BdAux13e0GfZ5fiViB25tO3ZAKLk7h
        xD5XgTsMVjLse80cTTchi4feG9vX6QtBWVicU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CpyiRifB8a9zPnpPJXEu1400AzlndkId
        H3YshjpyMQ0UvuBNG9IRM46UL35GCIyFjMxcgwkqYFCvr9oNF6ZXyH1PgqAnid8A
        z0h7VwhrhLe38q3yjV28+/8S1F65bTYWt8Mi6t7GUdXZbTwigBTyVnkBCKyhVPFX
        kMy+335wQ6U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6155D60825;
        Tue,  5 May 2020 01:07:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C389060824;
        Tue,  5 May 2020 01:07:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, chriscool@tuxfamily.org,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH 1/4] list-objects-filter: treat NULL filter_options as "disabled"
References: <cover.1588633810.git.me@ttaylorr.com>
        <bb7d99ee2582d60e2413df56cb2c3fb06c18de8e.1588633810.git.me@ttaylorr.com>
Date:   Mon, 04 May 2020 22:07:54 -0700
In-Reply-To: <bb7d99ee2582d60e2413df56cb2c3fb06c18de8e.1588633810.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 4 May 2020 17:12:27 -0600")
Message-ID: <xmqqh7wvc6l1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60C3CA76-8E8E-11EA-9A22-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> From: Jeff King <peff@peff.net>
>
> In most callers, we have an actual list_objects_filter_options struct,
> and if no filtering is desired its "choice" element will be
> LOFC_DISABLED. However, some code may have only a pointer to such a
> struct which may be NULL (because _their_ callers didn't care about
> filtering, either). Rather than forcing them to handle this explicitly
> like:
>
>   if (filter_options)
>           traverse_commit_list_filtered(filter_options, revs,
> 	                                show_commit, show_object,
> 					show_data, NULL);
>   else
>           traverse_commit_list(revs, show_commit, show_object,
> 	                             show_data);
>
> let's just treat a NULL filter_options the same as LOFC_DISABLED. We
> only need a small change, since that option struct is converted into a
> real filter only in the "init" function.

This is not a problem the patch introduces, but anytime we improve
the revision traversal API, Documentation/MyFirstObjectWalk.txt
risks to be left behind (in the sense that it still is correct but
is now suboptimal) or outright broken (when we change the function
signature).  I wonder if we can do some "mark-up" to that tutorial
so that we can extract runnable code in some of the tests and make
sure the code snippet in the documentation is still OK.

As to the patch, there apparently is no existing caller that passes
NULL to the function (or they would be immediately segfaulting), so
by definition, this step alone cannot break anything, but at the
same time, it is a bit hard to assess if this is a good change with
this step alone.  So let's read on.

Thanks.

>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  list-objects-filter.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/list-objects-filter.c b/list-objects-filter.c
> index 1e8d4e763d..0a3ef3cab3 100644
> --- a/list-objects-filter.c
> +++ b/list-objects-filter.c
> @@ -663,6 +663,9 @@ struct filter *list_objects_filter__init(
>  
>  	assert((sizeof(s_filters) / sizeof(s_filters[0])) == LOFC__COUNT);
>  
> +	if (!filter_options)
> +		return NULL;
> +
>  	if (filter_options->choice >= LOFC__COUNT)
>  		BUG("invalid list-objects filter choice: %d",
>  		    filter_options->choice);
