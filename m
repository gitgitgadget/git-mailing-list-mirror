Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD171C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72F24222C3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FreJiIJp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbgAOTQh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:16:37 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61210 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgAOTQh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 14:16:37 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EE35C94188;
        Wed, 15 Jan 2020 14:16:34 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LA0EloPlsM03zogc+As4XQhnS5o=; b=FreJiI
        JpW5nUHgg5BLpLz8hlW//bpI7qTYEPs3zegxXSCcihfEDD97r/XqWroHZkE7SQ2B
        WX5sfzxD+W7UVJTVe9DaPQ7plFHgB4gqApEmDKf8Ya62abesD4XjAsjnT4xrwYRt
        Mj0DRH1IGvQjQDr/6mTBL+ukwDfSCRqR1sk2E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SyhjR+QjqJrIA29xYTh66O6YEgpA0gmc
        eTdcjHBBEzmGJCHJ7GDWO+37Gis3swkNxr3VG7MAJHpkITKFpFiFrtb1rwbxj4dj
        niM+QYyEp4u2bYQ3yecSRknB+ououy5Hq3+pmUEJF3Kq3cCZwCmiCf4p/GDdX5DZ
        8G6Jb7PKgmw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E627B94185;
        Wed, 15 Jan 2020 14:16:34 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1AE229417E;
        Wed, 15 Jan 2020 14:16:31 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, peff@peff.net,
        newren@gmail.com, Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 0/8] Harden the sparse-checkout builtin
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
Date:   Wed, 15 Jan 2020 11:16:29 -0800
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com> (Derrick Stolee
        via GitGitGadget's message of "Tue, 14 Jan 2020 19:25:54 +0000")
Message-ID: <xmqqzheoil82.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89FE559C-37CB-11EA-9059-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Also, let's improve Git's response to these more complicated scenarios:
>
>  1. Running "git sparse-checkout init" in a worktree would complain because
>     the "info" dir doesn't exist.
>  2. Tracked paths that include "*" and "" in their filenames.
>  3. If a user edits the sparse-checkout file to have non-cone pattern, such
>     as "*" anywhere or "" in the wrong place, then we should respond
>     appropriately. That is: warn that the patterns are not cone-mode, then
>     revert to the old logic.

It seems somebody ate a letter to make "<some letter>" into "" an
empty string, so I cannot quite grok the above list---two out of
three bullet points are not quite readable.

