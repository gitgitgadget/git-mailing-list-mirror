Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F4221F461
	for <e@80x24.org>; Mon, 26 Aug 2019 17:09:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732490AbfHZRJg (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 13:09:36 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65021 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728560AbfHZRJg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 13:09:36 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 946C07367B;
        Mon, 26 Aug 2019 13:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=t8OTeJMWFNul9x/N+OprvLbW6dM=; b=w4bgpH
        Dx80l999/9cupWyIi8wJwosLnsjBA47ydjC4zJRQ0LcAYB1/XknW1Ivql5ZfxTxE
        xAnqNpDFZOA89MDc1yseE0LUcQGroFPYVmGhj0c4ClLYo4sKxLGS8IC9qeRRuu1K
        De6xIlSlHLICyQCdHs4Q5XFAGH4EkIkiw/sR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tzh00H21yt4QH0Q/pcUZArd8ZzUCZMIw
        OIhf9WtbGRfixVEIw40r+JpUpz4Cbaz5b/1PHMkQhjU6M6Xks5Q65Uw8i89WGOfY
        Ei0FEE2XYq5ay/m4gCKmTBjtvTCBAAH9v2Qs4okycZGWbu+/DiEmTO+kBPL0pPKW
        9GpcvP/+dmU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8D3867367A;
        Mon, 26 Aug 2019 13:09:34 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A37AC73676;
        Mon, 26 Aug 2019 13:09:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Adam Roben via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Adam Roben <adam@roben.org>
Subject: Re: [PATCH 1/1] mingw: fix launching of externals from Unicode paths
References: <pull.135.git.gitgitgadget@gmail.com>
        <8f2d64a88518d05579701b7093ecbc197ebca2c7.1566686335.git.gitgitgadget@gmail.com>
Date:   Mon, 26 Aug 2019 10:09:28 -0700
In-Reply-To: <8f2d64a88518d05579701b7093ecbc197ebca2c7.1566686335.git.gitgitgadget@gmail.com>
        (Adam Roben via GitGitGadget's message of "Sat, 24 Aug 2019 15:38:56
        -0700 (PDT)")
Message-ID: <xmqqv9ujhn07.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 449A6764-C824-11E9-AF76-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Adam Roben via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Note that the only problem in this function was calling
> `GetFileAttributes()` instead of `GetFileAttributesW()`. The calls to
> `access()` were fine because `access()` is a macro which resolves to
> `mingw_access()`, which already handles Unicode correctly. But
> `lookup_prog()` was changed to use `_waccess()` directly so that we only
> convert the path to UTF-16 once.

Nicely explained.  Thanks.

>
> To make things work correctly, we have to maintain UTF-8 and UTF-16
> versions in tandem in `lookup_prog()`.
>
> Signed-off-by: Adam Roben <adam@roben.org>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  compat/mingw.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 8141f77189..9f02403ebf 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1161,14 +1161,21 @@ static char *lookup_prog(const char *dir, int dirlen, const char *cmd,
>  			 int isexe, int exe_only)
>  {
>  	char path[MAX_PATH];
> +	wchar_t wpath[MAX_PATH];
>  	snprintf(path, sizeof(path), "%.*s\\%s.exe", dirlen, dir, cmd);
>  
> -	if (!isexe && access(path, F_OK) == 0)
> +	if (xutftowcs_path(wpath, path) < 0)
> +		return NULL;
> +
> +	if (!isexe && _waccess(wpath, F_OK) == 0)
>  		return xstrdup(path);
> -	path[strlen(path)-4] = '\0';
> -	if ((!exe_only || isexe) && access(path, F_OK) == 0)
> -		if (!(GetFileAttributes(path) & FILE_ATTRIBUTE_DIRECTORY))
> +	wpath[wcslen(wpath)-4] = '\0';
> +	if ((!exe_only || isexe) && _waccess(wpath, F_OK) == 0) {
> +		if (!(GetFileAttributesW(wpath) & FILE_ATTRIBUTE_DIRECTORY)) {
> +			path[strlen(path)-4] = '\0';
>  			return xstrdup(path);
> +		}
> +	}
>  	return NULL;
>  }
