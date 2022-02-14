Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D238C433F5
	for <git@archiver.kernel.org>; Mon, 14 Feb 2022 20:57:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiBNU5K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Feb 2022 15:57:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiBNU4w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Feb 2022 15:56:52 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F999FABF1
        for <git@vger.kernel.org>; Mon, 14 Feb 2022 12:56:31 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 130B3182267;
        Mon, 14 Feb 2022 15:16:45 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tkX2Bojv197Nnqnt0BRMuFBe8zBn7wM1YRzDYF
        rptdg=; b=ctiKZjH7YMrUYj1ezfPutt6Lu0OOHa5l2RGTVkwvCog6CraV12Xsat
        D8gGBgvk59tYXXfyaED/Jax1fSOBQtAxOKZRYwP7QWmx2IOh8oVCyy1RlhlBg2EJ
        F9vAyvibZPxA+V7b5bTZ+7ygyq9Y/esMTO5tNhK2epRVcSmAO38BI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E6065182266;
        Mon, 14 Feb 2022 15:16:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4758A182265;
        Mon, 14 Feb 2022 15:16:42 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, pclouds@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH] dir: force untracked cache with core.untrackedCache
References: <pull.1058.git.1644860224151.gitgitgadget@gmail.com>
Date:   Mon, 14 Feb 2022 12:16:41 -0800
In-Reply-To: <pull.1058.git.1644860224151.gitgitgadget@gmail.com> (Derrick
        Stolee via GitGitGadget's message of "Mon, 14 Feb 2022 17:37:04
        +0000")
Message-ID: <xmqqzgmt19w6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 06304D0A-8DD3-11EC-AF07-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> The GIT_FORCE_UNTRACKED_CACHE environment variable writes the untracked
> cache more frequently than the core.untrackedCache config variable. This
> is due to how read_directory() handles the creation of an untracked
> cache. The old mechanism required using something like 'git update-index
> --untracked-cache' before the index would actually contain an untracked
> cache. This was noted as a performance problem on macOS in the past, and
> this is a resolution for that issue.

"The old mechanism" meaning "core.untrackedCache does not add a new
one; it only updates an existing one"?  What "this" refers to that
was noted as a problem on macOS is not quite clear; is "writing
untracked cache is a performance problem"? And the last "this" which
is a resolution is "not to add untrackedCache merely because the
configuration variable says we are allowed to use it"?

> The decision to not write the untracked cache without an environment
> variable tracks back to fc9ecbeb9 (dir.c: don't flag the index as dirty
> for changes to the untracked cache, 2018-02-05). The motivation of that
> change is that writing the index is expensive, and if the untracked
> cache is the only thing that needs to be written, then it is more
> expensive than the benefit of the cache. However, this also means that
> the untracked cache never gets populated, so the user who enabled it via
> config does not actually get the extension until running 'git
> update-index --untracked-cache' manually or using the environment
> variable.

OK.  It was invented solely as a test mechanism it seems, but at
least to the workflow of Microsoft folks, once we spent cycles to
prepare UNTR data, it helps their future use of the index to spend
a bit more cycle to write it out, instead of discarding.

I have to wonder if there are workflows that are sufficiently
different from what Microsoft folks use that the write-out cost of
more frequent updates to the untracked cache outweigh the runtime
performance boost of not having to run around and readdir() for
untracked files?

ad0fb659 (repo-settings: parse core.untrackedCache, 2019-08-13)
explains that unset core.untrackedCache means "keep", and "true"
means untracked cache is "automatically added", which this change is
not invalidated, so I guess there is no need to update anything in
the documentation for this change.  In fact, we might be able to
sell this change as a bugfix (i.e. "I set the configuration to
'true' but it wasn't written out when it should have").

> diff --git a/dir.c b/dir.c
> index d91295f2bcd..79a5f6918c8 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -2936,7 +2936,9 @@ int read_directory(struct dir_struct *dir, struct index_state *istate,
>  
>  		if (force_untracked_cache < 0)
>  			force_untracked_cache =
> -				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", 0);
> +				git_env_bool("GIT_FORCE_UNTRACKED_CACHE", -1);
> +		if (force_untracked_cache < 0)
> +			force_untracked_cache = (istate->repo->settings.core_untracked_cache == UNTRACKED_CACHE_WRITE);
>  		if (force_untracked_cache &&
>  			dir->untracked == istate->untracked &&
>  		    (dir->untracked->dir_opened ||
>
> base-commit: b80121027d1247a0754b3cc46897fee75c050b44
