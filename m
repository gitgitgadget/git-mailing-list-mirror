Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3BB7CA0EC0
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:39:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbjIKVdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243626AbjIKRZK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 13:25:10 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0776CF5
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 10:25:06 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B60741C1818;
        Mon, 11 Sep 2023 13:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=7vts6AoIpYtd0XDbPaEC6mR4CZn9PBPe934gYB
        LsjbY=; b=u89fCNbAY/Tr+ezYpph+Od/n3tgQIQRCjHLDvPvEUqgpD6INdxsAyc
        LzVJtXd5kD8Kjq9on0ikWSYdcPQjo+G0aXpEuRSd3Y1PZWh9xVgXKK3lSyGUo4lz
        wF7zB+HbIwDfO/gZ0XLdCqEV0AgqKIK6jaQOC9ZIZzn1eWQQ9oiC8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 675D01C1817;
        Mon, 11 Sep 2023 13:25:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 306011C1816;
        Mon, 11 Sep 2023 13:25:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Linus Arver <linusa@google.com>
Subject: Re: [PATCH v2 4/6] trailer: teach find_patch_start about --no-divider
In-Reply-To: <f5f507c4c6c4514af7dca35e307ca68e72435afb.1694240177.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Sat, 09 Sep 2023 06:16:15
        +0000")
References: <pull.1563.git.1691211879.gitgitgadget@gmail.com>
        <pull.1563.v2.git.1694240177.gitgitgadget@gmail.com>
        <f5f507c4c6c4514af7dca35e307ca68e72435afb.1694240177.git.gitgitgadget@gmail.com>
Date:   Mon, 11 Sep 2023 10:25:01 -0700
Message-ID: <xmqqv8cgvd02.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 249118C4-50C8-11EE-979B-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> Currently, find_patch_start only finds the start of the patch part of
> the input (by looking at the "---" divider) for cases where the
> "--no-divider" flag has not been provided. If the user provides this
> flag, we do not rely on find_patch_start at all and just call strlen()
> directly on the input.
>
> Instead, make find_patch_start aware of "--no-divider" and make it
> handle that case as well. This means we no longer need to call strlen at
> all and can just rely on the existing code in find_patch_start. By
> forcing callers to consider this important option, we avoid the kind of
> mistake described in be3d654343 (commit: pass --no-divider to
> interpret-trailers, 2023-06-17).

OK.  The code pays attention to "---" so making it stop doing so
when the "--no-*" option is given will make the function responsible
for finding the beginning of the patch.

I wonder if we should rename this function while we are at it,
though.  When "--no-divider" is given, the expected use case is
*not* to have a patch at all, and it is dubious that a function
whose name is find_patch_start() can possibly do anything useful.

The real purpose of this function is to find the end of the log
message, isn't it?  And the caller uses the end of the log message
it found and gives it to find_trailer_start() and find_trailer_end()
as the upper boundary of the search for the trailer block.
