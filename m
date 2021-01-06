Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55531C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C68323142
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 23:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727310AbhAFXwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 18:52:36 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52843 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbhAFXwg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 18:52:36 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 58D91B4B24;
        Wed,  6 Jan 2021 18:51:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Unmx2DHkaLNu
        jQZ+4KVIz0TgYBg=; b=CORr6hEkWaS6gaZ6gFuHCpSbKDn+kACKWo9xlMIUsSIg
        Weckr887yD7xyNq1QmFXPtVCu71Tkp4se0bNEOi9DBiwDL9lH6fUHQ6m6SrrS+6z
        8JfNXmEzydZ723AuBwXoGsvrMdLt9Eo+AUGeFaHo1GUGLiu3Iu+mrpE8Csu+LFI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SxqIfm
        UpjNle+10i4adZJd6tbr1Sft/Y0GitJCj3ZRn4iLSfQueHBd4kjtmG0U0gjuPoEM
        Cc5wxN++DgPqZiAH1yUztXPDg1PS9fRfPm4lteCnUr83ghJYeDLyV91JB2WOdScL
        XBKkkmcprj7T+Rz/12QwolvWtILJ8YE0Ga5ho=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51794B4B23;
        Wed,  6 Jan 2021 18:51:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C92E1B4B20;
        Wed,  6 Jan 2021 18:51:50 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     tboegi@web.de
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Dan.Moseley@microsoft.com
Subject: Re: [PATCH/RFC v1 1/1] git mv foo FOO ; git mv foo bar gave an assert
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
        <20210106105302.16878-1-tboegi@web.de>
Date:   Wed, 06 Jan 2021 15:51:50 -0800
In-Reply-To: <20210106105302.16878-1-tboegi@web.de> (tboegi@web.de's message
        of "Wed, 6 Jan 2021 11:53:02 +0100")
Message-ID: <xmqqpn2hoc89.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 2562CB7C-507A-11EB-89C2-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

tboegi@web.de writes:

> From: Torsten B=C3=B6gershausen <tboegi@web.de>
>
> The following sequence, on a case-insensitive file system,
> (strictly speeking with core.ignorecase=3Dtrue)
> leads to an assertion, and leaves .git/index.lock behind.

"an assertion failure" you mean.

>
> git init
> echo foo >foo
> git add foo
> git mv foo FOO
> git mv foo bar
>
> This regression was introduced in Commit 9b906af657,
> "git-mv: improve error message for conflicted file"
>
> Don't check if the case-insensitive version is in the index.
> In the sense of 9b906af657 supply the user with a more helpful message.
>
> This fixes
> https://github.com/git-for-windows/git/issues/2920
>
> Reported-By: Dan Moseley <Dan.Moseley@microsoft.com>
> Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
> ---
>
> Note:
> There is an ongoing effort to replace cache_file_exists() with
> index_file_exists().  So this patch may need to be re-done.

Thanks for a heads-up.

>
> Note2: @Dan Moseley: Do you want to continue with this work ?
>
> builtin/mv.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 7dac714af9..8572a5dae0 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -221,8 +221,11 @@ int cmd_mv(int argc, const char **argv, const char=
 *prefix)
>  				}
>  				argc +=3D last - first;
>  			}
> -		} else if (!(ce =3D cache_file_exists(src, length, ignore_case))) {
> -			bad =3D _("not under version control");
> +		} else if (!(ce =3D cache_file_exists(src, length, 0))) {
> +			if (cache_file_exists(src, length, ignore_case))
> +				bad =3D _("not under version control (upper/lower mixup)");
> +			else
> +				bad =3D _("not under version control");
>  		} else if (ce_stage(ce)) {
>  			bad =3D _("conflicted");
>  		} else if (lstat(dst, &st) =3D=3D 0 &&
> --
> 2.28.0.97.gdc04167d37
