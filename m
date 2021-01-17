Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D022C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 06:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9EAE23120
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 06:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbhAQGXT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 01:23:19 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55634 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbhAQGXG (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 01:23:06 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 89AFE10402A;
        Sun, 17 Jan 2021 01:22:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eIv4EDb/WXbRu50z7kawNTkN3C0=; b=ITKyBP
        3vUZ9dz3DzsoJFauLnkgJ/oCLlwYX/8KK8kjVJGyZR4G0urWbfNQUn/GiFpiUA2D
        FmFQVCTWQ1kEYA53rfgktjk91hugBog31eFn+AXzAqsU1bhW9Dy2/pFLo1dJcI38
        8JeUVXL+9xJbOUzl1JpgikbYkNFLPvuC/1XTY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XhRUQIIkeqsBgVUPtrs/2WXlYjtYshSl
        CsuypIFAQZ3o3MbMOnHovk18/GqvtLz3zmyhfURE0haPZ3gkrW+aqfo6F5pArmFT
        ihDzJDLJQMQ89DvxURrVMI8wjnbKcE1Fm5Dj8v8Ql28KZexExV9VjGnyNB5IIphR
        y8eNppb75G8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8262F104029;
        Sun, 17 Jan 2021 01:22:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C2F63104028;
        Sun, 17 Jan 2021 01:22:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?6IOh5ZOy5a6B?= <adlternative@gmail.com>
Subject: Re: [PATCH v4 1/3] ls_files.c: bugfix for --deleted and --modified
References: <pull.832.v3.git.1610626942677.gitgitgadget@gmail.com>
        <pull.832.v4.git.1610856136.gitgitgadget@gmail.com>
        <f4d9af8a3124bcd37a35b1863441406f6d939f11.1610856136.git.gitgitgadget@gmail.com>
Date:   Sat, 16 Jan 2021 22:22:20 -0800
In-Reply-To: <f4d9af8a3124bcd37a35b1863441406f6d939f11.1610856136.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Sun, 17 Jan 2021 04:02:14
        +0000")
Message-ID: <xmqqv9bwm6ar.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5C10134A-588C-11EB-8211-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> This situation may occur in the original code: lstat() failed
> but we use `&st` to feed ie_modified() later.
>
> It's buggy!

Wasteful extra paragraph with almost no information contents over
what has already been said in the first paragraph.

> Therefore, we can directly execute show_ce without the judgment of
> ie_modified() when lstat() has failed.

But it introduces another bug, as you do not even see why a path
cannot be lstat'ed, no?

>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>  builtin/ls-files.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index c8eae899b82..6f97a23c2dc 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -347,9 +347,12 @@ static void show_files(struct repository *repo, struct dir_struct *dir)
>  			if (ce_skip_worktree(ce))
>  				continue;
>  			err = lstat(fullname.buf, &st);
> -			if (show_deleted && err)
> -				show_ce(repo, dir, ce, fullname.buf, tag_removed);
> -			if (show_modified && ie_modified(repo->index, ce, &st, 0))
> +			if (err) {
> +					if (show_deleted)
> +						show_ce(repo, dir, ce, fullname.buf, tag_removed);
> +					if (show_modified)
> +						show_ce(repo, dir, ce, fullname.buf, tag_modified);
> +			}else if (show_modified && ie_modified(repo->index, ce, &st, 0))
>  				show_ce(repo, dir, ce, fullname.buf, tag_modified);
>  		}
>  	}
