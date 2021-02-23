Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C90C433E9
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9FF564E7C
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 07:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhBWHoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Feb 2021 02:44:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63881 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbhBWHoJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Feb 2021 02:44:09 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26929B8835;
        Tue, 23 Feb 2021 02:43:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w9kVoP0DEW8j3ZQk45lJOrbtY0k=; b=bzGbcw
        BT3DsSEzvm9iQC37PHd2UBjrgPtLwjqzYL+S6DQfFm6OqVcZg+U8hzQ+u1AbywpU
        CemvIhhMEmQOxZgoAdYJ7FF7k1HX7+LwmGiItPgTyUF/CoAziXcHUmu+/43gUgv7
        7KbZg4UvCsziTnddM3tuMhKKOYLIX6UcN+5/8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kgqd8rf14N2JLMRTrL13b2IhxqSlKe6B
        Wa9Wm7ieSwbYpR81/KbleYB6rOwhd2v5nSnET11v756UysZRsw/XZ7xd5er7zNv4
        3fRo1PA1lXjRuZ3x8rc0JHWhHQ+nH6botidC2jQnLSFdJc8bUPAAc5dRepiPIYMt
        m2Uv+koIM5c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EE50B8834;
        Tue, 23 Feb 2021 02:43:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9DDB2B8833;
        Tue, 23 Feb 2021 02:43:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v4 0/8] repack: support repacking into a geometric sequence
References: <cover.1611098616.git.me@ttaylorr.com>
        <cover.1614047097.git.me@ttaylorr.com>
Date:   Mon, 22 Feb 2021 23:43:22 -0800
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com> (Taylor Blau's message of
        "Mon, 22 Feb 2021 21:24:59 -0500")
Message-ID: <xmqq7dmz5iw5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CEA338A2-75AA-11EB-8644-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:


>     ++	/*
>     ++	 * order packs by descending mtime so that objects are laid out
>     ++	 * roughly as newest-to-oldest
>     ++	 */
>      +	if (a->mtime < b->mtime)
>      +		return 1;
>     ++	else if (b->mtime < a->mtime)
>     ++		return -1;
>      +	else
>      +		return 0;

I think this strategy makes sense when this repack using this new
feature is run for the first time in a repository that acquired many
packs over time.  I am not sure what happens after the feature is
used a few times---it won't always be the newest sets of packs that
will be rewritten, but sometimes older ones are also coalesced, and
when that happens the resulting pack that consists primarily of older
objects would end up having a more recent timestamp, no?

Even then, I do agree that newer to older would be beneficial most
of the time, so this is of course not an objection against this
particular sort order.
