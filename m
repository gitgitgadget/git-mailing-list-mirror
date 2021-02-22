Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFDDC433E0
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 21:41:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3862E64DD3
	for <git@archiver.kernel.org>; Mon, 22 Feb 2021 21:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhBVVl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 16:41:29 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56123 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbhBVVlK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 16:41:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 77A5B12009A;
        Mon, 22 Feb 2021 16:40:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oXdcAnXTBSD7MMYc0EnuFqUGBS8=; b=CFnD7w
        kqQk4iQ2utEUZ8PR2panUM+fjCzprwZE7ggQY/ZDDtWlu42AbekVCFiUrNUzHpmj
        6/bGxlyi+bSbFktN8tfKZzUnRuIv20jrkzUj4DU9iUVVgVWVOGxX2UUJwpaN1Fmi
        tfAU5t9nPXUmDEeHUZawPSLgnIvMXS5w0mvHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vTdO6xDQfnCuZw1artSaAyj8e+fCCCvY
        qvYZzsvKhejAuohv9OpJBZ6pprvemEhdT1fRs6waJcDtXTL+E9Tidk41G0uXTSSg
        kUT3VmWmTk7bx5EkBwIlBPJW43W+IYTzNJ45sdpe8nLpPeCnA/azgL2Ex7zzJUAN
        PJIDRiQJUyU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 70F79120099;
        Mon, 22 Feb 2021 16:40:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8DCC3120095;
        Mon, 22 Feb 2021 16:40:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v6] difftool.c: learn a new way start at specified file
References: <pull.870.v5.git.1613480198.gitgitgadget@gmail.com>
        <pull.870.v6.git.1613739235241.gitgitgadget@gmail.com>
Date:   Mon, 22 Feb 2021 13:40:15 -0800
In-Reply-To: <pull.870.v6.git.1613739235241.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Fri, 19 Feb 2021 12:53:54 +0000")
Message-ID: <xmqq4ki37pds.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E100AF8-7556-11EB-ADF5-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> `git difftool` only allow us to select file to view in turn.
> If there is a commit with many files and we exit in the middle,
> we will have to traverse list again to get the file diff which
> we want to see. Therefore,teach the command an option
> `--skip-to=<path>` to allow the user to say that diffs for earlier
> paths are not interesting (because they were already seen in an
> earlier session) and start this session with the named path.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     difftool.c: learn a new way start at specified file
>     
>      * The patch of the previous version implemented the jump through
>        environment variables. The current version is based on the "diff
>        --skip-to=" feature implemented by gitster, which implements a
>        possible solution for the jump of difftool.

So there was absolutely no need to change anything in difftool,
because it just passes down anything that it does not understand
down to the underlying "git diff"?

Very interesting.

Thanks, will queue.  Let's see if we get comments from others.
