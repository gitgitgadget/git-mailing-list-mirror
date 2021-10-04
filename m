Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9A75C433F5
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 20:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B234561360
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 20:52:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234829AbhJDUyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 16:54:23 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65521 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbhJDUyW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 16:54:22 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 3AADC15BC1F;
        Mon,  4 Oct 2021 16:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fySz6gAea9uSuH3++7bYvz7YTvkuSEr3iU0k69
        AUipk=; b=CAvVezktgBGg8gYaeNTJk2r5BatQJim13KWs4Ix+Yma+ppNI7IuQVY
        sQpsqnyJg4VFkCmNszl5S8OS/gk0nRvBxbXKcHB+93Agn6Tg7Weh0No1Yv1f+RFN
        sZMsZLvZ9r6nqcJoxeIxJySb8/QSRcnm/9FG0J+5XV8C7FLRD5D5g=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32A7F15BC1D;
        Mon,  4 Oct 2021 16:52:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8A11615BC1C;
        Mon,  4 Oct 2021 16:52:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Robert Leftwich <robert@gitpod.io>, git@vger.kernel.org,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: Bug/regression report - 'git stash push -u' fatal errors when
 sub-repo present
References: <CACr9BXmP1vQMK4b27Uc4R-3WWYHUYfCEEMN+hnth4yUg+UN7Zg@mail.gmail.com>
        <7b83c77e-dd87-f688-3da1-7826cf6b0d4e@web.de>
        <xmqqk0iydns7.fsf@gitster.g>
        <1d26a9f3-dcb5-408a-581e-40411e6a2179@web.de>
        <6df361a5-8e15-63a7-dbb8-77405c6edf0e@gmail.com>
Date:   Mon, 04 Oct 2021 13:52:29 -0700
In-Reply-To: <6df361a5-8e15-63a7-dbb8-77405c6edf0e@gmail.com> (Derrick
        Stolee's message of "Mon, 4 Oct 2021 16:06:22 -0400")
Message-ID: <xmqqzgrov7g2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDB82152-2554-11EC-8408-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> And yes, I believe that make_cache_entry() and add_index_entry_with_check()
> are the only places that need this internal version. If we find others,
> then we can add them as necessary. The tests in t1092 are getting rather
> robust, although they don't do much for this test case:
>> +test_expect_success 'stash -u ignores sub-repository' '
>> +	test_when_finished "rm -rf sub-repo" &&
>> +	git init sub-repo &&
>> +	git stash -u
>> +'
>
> Seems like a good test to have, anyway.
>
> I look forward to seeing this as a full patch.

Just one thing I want to pick your brains for ;-)

I said this earlier ...

>>> "git update-index" should never allow to create a "tree" kind of
>>> cache entry (making it sparse again should be the task of systems
>>> internal, and should not be done by end-user feeding a pre-shrunk
>>> "tree" kind of entry to record a sparsely populated state, if I
>>> understand correctly), so its call to verify_path(), if it ends with
>>> a directory separator, should say "that's not a good path".

... without knowing what you had in mind when you did the "tree kind
of entry in the index".  Are we on the same page, or do we think it
might be beneficial to give end-users a long-enough rope
to hang themselves, aka get into the lower details of
implementation?

One _could_ imagine that allowing

 $ git update-index --cacheinfo 40000,609869396314577e5a,t/

given by the end user to drop all entries under t/* and replace them
with a single sparse-dir-entry might be a good way to allow
scripters the same power as the C-code to take advantage of the
sparse checkout feature.  It needs to be paired with some mechanism
to allow sparse-dir-entry observed by the end users with a plumbing,
e.g. even though ls-files unconditionally calls ensure_full_index(),

 $ git ls-files --show-sparse

may show the sparse-dir-entry by bypassing the call.

Thanks.
