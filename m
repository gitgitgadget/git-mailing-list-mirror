Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5B31F461
	for <e@80x24.org>; Thu, 11 Jul 2019 19:03:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbfGKTDP (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 15:03:15 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60939 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728555AbfGKTDP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jul 2019 15:03:15 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DF7EA695E2;
        Thu, 11 Jul 2019 15:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=TD10+9wqQm+E24lepaT40ESgkPg=; b=aEUPtr
        08WR9rXZ59f5xQwqkN88kiZU0KnNSAJXN9CsnUWcIwaGrCx8ch8nPDEmgrSxl8tO
        hzc4ZU1MS+b+uawd8fgHaZ9e5TMfEduwEGnNin6kh/9D2gi9ukUbbbGvFUGoIlsP
        CcNZIRtoHKARzBOoYICn2OwvLGGC0JSF//HvQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=juPgv6HTipsyp+T1SS3mqxPQhf4DRVQH
        0IdN1v7r8qqegYPH7oGkwn1/pnbmDxG3bDCHi2O9VwZMxhpe20fAQx7z361Jr2N+
        MbmLbLTQ4GpZN625D0u7+iMimfSKAL+BvcITPl2EP34tL+FtxJ2Gz8SOEggD5n8V
        lA+1LB1LJEk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C2C45695E0;
        Thu, 11 Jul 2019 15:03:12 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E3A7D695DF;
        Thu, 11 Jul 2019 15:03:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/1] diff: munmap() file contents before running external diff
References: <pull.213.git.gitgitgadget@gmail.com>
        <pull.213.v2.git.gitgitgadget@gmail.com>
        <8a0213291b2afc8db9243808319dc86b736122c8.1562833419.git.gitgitgadget@gmail.com>
Date:   Thu, 11 Jul 2019 12:03:07 -0700
In-Reply-To: <8a0213291b2afc8db9243808319dc86b736122c8.1562833419.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 11 Jul 2019
        01:23:41 -0700 (PDT)")
Message-ID: <xmqq36jcs8b8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86329AB4-A40E-11E9-9843-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When running an external diff from, say, a diff tool, it is safe to
> assume that we want to write the files in question. On Windows, that
> means that there cannot be any other process holding an open handle to
> said files, or even just a mapped region.
>
> So let's make sure that `git diff` itself is not holding any open handle
> to the files in question.
>
> In fact, we will just release the file pair right away, as the external
> diff uses the files we just wrote, so we do not need to hold the file
> contents in memory anymore.
>
> This fixes https://github.com/git-for-windows/git/issues/1315
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  diff.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/diff.c b/diff.c
> index 4d3cf83a27..42affb6dcf 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4206,6 +4206,8 @@ static void run_external_diff(const char *pgm,
>  	argv_array_pushf(&env, "GIT_DIFF_PATH_COUNTER=%d", ++o->diff_path_counter);
>  	argv_array_pushf(&env, "GIT_DIFF_PATH_TOTAL=%d", q->nr);
>  
> +	diff_free_filespec_data(one);
> +	diff_free_filespec_data(two);
>  	if (run_command_v_opt_cd_env(argv.argv, RUN_USING_SHELL, NULL, env.argv))
>  		die(_("external diff died, stopping at %s"), name);

Looks sensible; will queue.  Thanks.
