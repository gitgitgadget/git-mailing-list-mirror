Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368AAC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:29:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BD2461502
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 09:29:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbhKQJcM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 04:32:12 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60080 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234997AbhKQJcK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 04:32:10 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7C8F016C5B6;
        Wed, 17 Nov 2021 04:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=pZcxf/DZiGWZJRc4C87NgxPGv599pUCOVUO+9YPw3UA=; b=XBuK
        kGZKhgvMDV2TwVKDPJpkEEJk6VkIzl9z/u6yPT8/dGJM1KcDCeerZZ28gPBWyY9V
        s0y8M/1JZViKzr2++iKFtN1xvsNDb7SEl2+jW35ZevUNbl2t4IQ0b6OV5eU24GM9
        KTV2nMXjbLlDL7mb9a5zlOF6WwLBp92i/yT+VSY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 686A016C5B5;
        Wed, 17 Nov 2021 04:29:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BCAF316C5B4;
        Wed, 17 Nov 2021 04:29:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 0/2] Sparse index: fetch, pull, ls-files
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
Date:   Wed, 17 Nov 2021 01:29:08 -0800
Message-ID: <xmqqlf1n2krf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D1844E7A-4788-11EC-8FA7-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This is based on ld/sparse-index-blame (merged with 'master' due to an
> unrelated build issue).
>
> Here are two relatively-simple patches that further the sparse index
> integrations.
>
> Did you know that 'fetch' and 'pull' read the index? I didn't, or this would
> have been an integration much earlier in the cycle. They read the index to
> look for the .gitmodules file in case there are submodules that need to be
> fetched. Since looking for a file by name is already protected, we only need
> to disable 'command_requires_full_index' and we are done.

This reminds me of one thing.  Our strategy so far has been:

 - start with blindly calling ensure_full();

 - audit the code and adjust each code path that needs to walk to

   . keep walking the full index, but narrow the scope of
     ensure_full_index() if we can; or

   . stop assuming we need to walk the full index, but teach it to
     "skip" the tree-in-index that we are not interested in.

 - declare victory and drop the blind call to ensure_full().

But what makes sure, after all of the above happens, that no new
changes that assume it can walk the full index enters in the
codebase?

In other words, after "fetch" is declared "sparse clean" with patch
[1/2], what effort from us will it take to stay clean?

Thanks.
