Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC30C433ED
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:55:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DF9D610CB
	for <git@archiver.kernel.org>; Mon, 17 May 2021 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245732AbhEQV4U (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 May 2021 17:56:20 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62393 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238505AbhEQV4T (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 May 2021 17:56:19 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 494B213EFA1;
        Mon, 17 May 2021 17:55:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GT9LoXcZ06FSR6rCE4otiIBwV8Iq2J6WL7DEXw
        schAg=; b=Eoe8aTXw0e0oozJE81AIT59qd7MzaDnC+XlhCmYAiczs8OLU8Gu3pn
        csWSQGG6YBohzOE+vTuhWQooJ0fexFZx0GHTUXMFuDdq8sJwOd6+dmJ0V1fswHkj
        fRfEAUHHI+Vwfr98W9bEjG/VECW3dl3TDxTCxgiAJloDpUd5zWX44=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4232313EFA0;
        Mon, 17 May 2021 17:55:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6EB2713EF9C;
        Mon, 17 May 2021 17:54:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com,
        git@jeffhostetler.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 2/4] csum-file.h: increase hashfile buffer size
References: <pull.916.git.1616785928.gitgitgadget@gmail.com>
        <pull.916.v2.git.1621254292.gitgitgadget@gmail.com>
        <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
Date:   Tue, 18 May 2021 06:54:57 +0900
In-Reply-To: <9dc602f6c4221e2259778842ec3d1eda57508333.1621254292.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 17 May 2021
        12:24:50 +0000")
Message-ID: <xmqqk0nx58lq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8665D1F2-B75A-11EB-979C-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The hashfile API uses a hard-coded buffer size of 8KB and has ever since
> it was introduced in c38138c (git-pack-objects: write the pack files
> with a SHA1 csum, 2005-06-26). It performs a similar function to the
> hashing buffers in read-cache.c, but that code was updated from 8KB to
> 128KB in f279894 (read-cache: make the index write buffer size 128K,
> 2021-02-18). The justification there was that do_write_index() improves
> from 1.02s to 0.72s.
>
> There is a buffer, check_buffer, that is used to verify the check_fd
> file descriptor. When this buffer increases to 128K to fit the data
> being flushed, it causes the stack to overflow the limits placed in the
> test suite. By moving this to a static buffer, we stop using stack data
> for this purpose, but we lose some thread-safety. This change makes it
> unsafe to write to multiple hashfiles across different threads.

So... is the longer term plan to heap-allocate the buffer itself,
and replace the .buffer member of hashfile from an embedded char
array to a pointer?  The hashfile structure is initialized once per
the entire file (like the on-disk index), and the same buffer will
be used throughout the life of that hashfile instance, so it may not
be too bad to allocate on the heap.

Just after the previous step justified its simplification of its
progress logic based on how small the buffer is, this step makes it
16 times as big, which felt a tiny bit dishonest.  We probably
should say somewhere that 128k is still small enough that the
rewrite in the previous step is still valid ;-)

