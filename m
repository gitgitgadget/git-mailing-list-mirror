Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F741C433F5
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 05:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2FDF160F8F
	for <git@archiver.kernel.org>; Sun, 17 Oct 2021 05:58:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244978AbhJQGA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Oct 2021 02:00:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63766 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232477AbhJQGAR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Oct 2021 02:00:17 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7200516A2A3;
        Sun, 17 Oct 2021 01:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iC0SqFjH90g+uC4Dvt3tF2o3Xm3gSxSA9x67fT
        15M40=; b=SMLb5aIX30rtbZeXIih/dbtesphY6zPvJTS2p8W2OikmkHFWjci42a
        82FpvGrmU2cZISArIuZ2dQEw0r2s5Yo2yOLKUquAHUNlv9bSuEdCp2TV1dXMVjgq
        RiuhG+xdOsnPaRi1XUYdRz2Bv8+G5znvOyAakDJ1h8Rdcde7u7gu0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 6AE0516A2A2;
        Sun, 17 Oct 2021 01:58:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CA7FE16A2A1;
        Sun, 17 Oct 2021 01:58:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 2/2] sparse-index: update index read to consider
 index.sparse config
References: <pull.1059.git.1634327697.gitgitgadget@gmail.com>
        <c6279b225454af0cf3b54586127eb91206593af3.1634327697.git.gitgitgadget@gmail.com>
        <xmqqh7di3qfu.fsf@gitster.g>
        <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com>
Date:   Sat, 16 Oct 2021 22:58:03 -0700
In-Reply-To: <e17b7e0f-edf0-0770-9b9b-dd092a8a7a41@gmail.com> (Derrick
        Stolee's message of "Sat, 16 Oct 2021 21:21:48 -0400")
Message-ID: <xmqq5ytw19ck.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 31D1487E-2F0F-11EC-8265-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I think you are slightly mistaken here: If index.sparse=true, then a
> full index will be converted to one on write, but not immediately upon
> read. This means that subsequent commands will read a sparse index, and
> they will either benefit from that or not depending on whether they are
> integrated with the sparse index or not.
>
> The new behavior here is that if index.sparse=false, then we convert
> a sparse index to a full one upon read, avoiding any chance that a
> Git command is operating on a sparse index in-memory.

And if index.sparse=true, then we convert a full on-disk index to a
sparse one in-core upon reading, right?  My comment was solely on
that side of the picture, not on the "index.sparse is set to false
so we automatically expand" case.

> The simplest summary I can say is here:
>
> * If index.sparse=false, then a sparse index will be converted to
>   full upon read.
>
> * If index.sparse=true, then a full index will be converted to sparse
>   on write.

Oh, I see, so yes I was very much misunderstanding what you guys are
trying to do.  I somehow thought that sparse-to-full and
full-to-sparse conversions (1) already happen on the write codepath,
and (2) this patch makes them both happen also on the read codepath.

IOW:

    * If index.sparse=false, a sparse index will be written as full,
      and if it is true, a non-sparse index will be written as
      sparse, even before these patches.

    * In addition, with these patches, if index.sparse=false, a
      sparse index will be expaned to full upon reading, and if it
      is true, a non-sparse index will be shrunk to sparse upon
      reading

was what I was expecting.

What your summary above is saying is very much different.
