Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2122C43600
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:42:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B56761186
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 05:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233319AbhDIFm3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 01:42:29 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65273 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhDIFmY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 01:42:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EFB1DB7178;
        Fri,  9 Apr 2021 01:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fz2y+UvZHfV49lr0TfIDgtryN1E=; b=KO3gaj
        K6s8Gw128XLDoiK6jiPoRoTbZrDPC+/A6FG5ALcTH0JwnXUmJawU/j+a1+I09woq
        2jXZ2STtQ4pQLpePXoUAVUNl1g+i5+auuEFupfpl/SowdIEahyyWHEyHbLRmxTnI
        XlL3X7QYdwxiZ0HVGgDH0hQgt/W/2SHBO0qOU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pEaHIHYkGp7uWwTaflsWFj7dgkUTGIqg
        hVdPKUCh2mDTLB7HPgDGNyBwCfZ+Sa392FoKBbsu4JeRWSZ5VnxWQIlkR5pzC2rV
        c9SFdI8cIVe5Q61z22qEzx+xDptoFNcA9gKy4NFHp5qBKni+WYTpXhD87lk/gcqZ
        1aCmSsPHDWE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D8134B7176;
        Fri,  9 Apr 2021 01:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4E675B7175;
        Fri,  9 Apr 2021 01:41:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/6] fetch: teach independent negotiation (no packfile)
References: <cover.1617929278.git.jonathantanmy@google.com>
        <4696c8e901808853d17af10d5a6d95cd4711c6d5.1617929278.git.jonathantanmy@google.com>
Date:   Thu, 08 Apr 2021 22:41:53 -0700
In-Reply-To: <4696c8e901808853d17af10d5a6d95cd4711c6d5.1617929278.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Thu, 8 Apr 2021 18:10:02 -0700")
Message-ID: <xmqqczv4nhem.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A737E60-98F6-11EB-82C7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> There are 2 code paths that do not go through fetch_refs_via_pack() that
> needed to be individually excluded: the bundle transport (excluded
> through requiring smart_options, which the bundle transport doesn't
> support) and transport helpers that do not support takeover.
> Fortunately, none of these support protocol v2.

I am a bit puzzled by this mention of "Fortunately".  If one says
"this shiny new feature only works with protocol v2" and "transport
X does not support protocol v2", doesn't it imply that the shiny new
feature cannot be used with the transport X, which is unfortunate?

I can understand "while interacting with the bundle transport, you
cannot do independent negotiation, but there is nothing to negotiate
with a static file that is a bundle anyway, so nothing is lost" as
an explanation, though.

>  Documentation/technical/protocol-v2.txt |  8 +++
>  builtin/fetch.c                         | 27 +++++++-
>  fetch-pack.c                            | 89 +++++++++++++++++++++++--
>  fetch-pack.h                            | 11 +++
>  object.h                                |  2 +-
>  t/t5701-git-serve.sh                    |  2 +-
>  t/t5702-protocol-v2.sh                  | 89 +++++++++++++++++++++++++
>  transport-helper.c                      | 10 +++
>  transport.c                             | 30 +++++++--
>  transport.h                             |  6 ++
>  upload-pack.c                           | 18 +++--
>  11 files changed, 275 insertions(+), 17 deletions(-)

It is a bit surprising that there isn't much code removed, as I
expected that we'd be factoring out and reusing existing code used
in negotiation for fetching into a new helper function (hence the
existing codepath would lose a lot of code to be replaced by a call
to a new helper function), but that is apparently not what is going
on.

I'll have to revisit this step and the next step tomorrow.

Thanks.
