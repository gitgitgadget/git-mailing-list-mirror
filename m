Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D45E94133
	for <git@archiver.kernel.org>; Fri,  6 Oct 2023 22:12:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjJFWMe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Oct 2023 18:12:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233397AbjJFWMd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Oct 2023 18:12:33 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D295BD
        for <git@vger.kernel.org>; Fri,  6 Oct 2023 15:12:32 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BDB861B05B9;
        Fri,  6 Oct 2023 18:12:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=bTnMD2NrUjaC1277wHyG5CC/LquydOPZhbFVOr
        W9LVI=; b=o2VutNBYoIlyDGe00n8YA1vJYOfFufpV7TmOjhW8RB2+PNmbgbXM3a
        WJO6AjfqnNi5v7h5bGGp4TqZL67T9p2RO7PwikhX2LXSBNLO5uhnV0JGXVHLcfTu
        wrNPc+8NRKTb1NdcSB3NJl27wY/GuG92vtdbuGJtdP3QoMOYHeep4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B59F71B05B8;
        Fri,  6 Oct 2023 18:12:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DE481B05B6;
        Fri,  6 Oct 2023 18:12:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 4/4] files-backend.c: avoid stat in 'loose_fill_ref_dir'
In-Reply-To: <e193a45318244d9f8b05dfe2fb1ce57f6a4f6428.1696615769.git.gitgitgadget@gmail.com>
        (Victoria Dye via GitGitGadget's message of "Fri, 06 Oct 2023 18:09:29
        +0000")
References: <pull.1594.git.1696615769.gitgitgadget@gmail.com>
        <e193a45318244d9f8b05dfe2fb1ce57f6a4f6428.1696615769.git.gitgitgadget@gmail.com>
Date:   Fri, 06 Oct 2023 15:12:26 -0700
Message-ID: <xmqqttr37645.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6FA9F1A6-6495-11EE-8A8F-25B3960A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Unlike other existing usage of 'get_dtype', the 'follow_symlinks' arg is set
> to 1 to replicate the existing handling of symlink dirents. This
> unfortunately requires calling 'stat' on the associated entry regardless of
> platform, but symlinks in the loose ref store are highly unlikely since
> they'd need to be created manually by a user.

Yeek.  I wonder what breaks if we do not do this follow_symlinks()
part, i.e., either just replace stat() with lstat() in the original
without any of these four patches (which would be simple to figure
out what breaks), or omit [3/4] and let get_dtype() yield DT_LNK.

It seems that it comes from a7e66ae3 ([PATCH] Make do_each_ref()
follow symlinks., 2005-08-16), and just like I commented on there in
its log message back then, I still doubt that following a symbolic
link is a great idea here in this codepath.

But optimization without behaviour change is a good way to ensure
that optimization does not introduce new bugs, and because keeping
the historical behaviour like the patches [3/4] and this patch does
is more work (meaning: if it proves unnecessary to dereference
symbolic links, we can remove code instead of having to write new
code to support the new behaviour), let's take the series as-is, and
defer it to future developers to further clean-up the semantics.

> Note that this patch also changes the condition for skipping creation of a
> ref entry from "when 'stat' fails" to "when the d_type is anything other
> than DT_REG or DT_DIR". If a dirent's d_type is DT_UNKNOWN (either because
> the platform doesn't support d_type in dirents or some other reason) or
> DT_LNK, 'get_dtype' will try to derive the underlying type with 'stat'. If
> the 'stat' fails, the d_type will remain 'DT_UNKNOWN' and dirent will be
> skipped. However, it will also be skipped if it is any other valid d_type
> (e.g. DT_FIFO for named pipes, DT_LNK for a nested symlink). Git does not
> handle these properly anyway, so we can safely constrain accepted types to
> directories and regular files.

Sounds good.

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  refs/files-backend.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Thanks.

