Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D670BC433F5
	for <git@archiver.kernel.org>; Fri, 26 Nov 2021 06:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352568AbhKZGdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Nov 2021 01:33:38 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54673 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352694AbhKZGbi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Nov 2021 01:31:38 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AB6DB171930;
        Fri, 26 Nov 2021 01:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=SohlTEi3fDDK
        khrZUgDONDDPj6AEpKDTKQxvX9ZCqwY=; b=TZTWejaDDaIBKdKbiltzzM51Tgqk
        foGJx5hVff08oMmNb4jrGRXLKyAkFDCdtmh/3P9Y5LPVDgp1WQByzfksiT6kJODS
        10yPSwPG4jBUh8NQuftEnlkDDrwSALbnxIGeqnOZ/6f50gKy/3lBDe+2NiYx2MjI
        fiy0eXIJ0BKV7gI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9955A17192F;
        Fri, 26 Nov 2021 01:28:25 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A874B17192E;
        Fri, 26 Nov 2021 01:28:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH] mingw: avoid fallback for {local,gm}time_r()
References: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 22:28:20 -0800
In-Reply-To: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
 ("Carlo
        Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message of "Thu,
 25 Nov 2021
        05:23:12 +0000")
Message-ID: <xmqq35nja0sb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0D465BE2-4E82-11EC-B4E5-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Carlo Marcelo Arenas Bel=C3=B3n via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Carlo=3D20Marcelo=3D20Arenas=3D20Bel=3DC3=3DB3n?=3D <=
carenas@gmail.com>
>
> mingw-w64's pthread_unistd.h had a bug that mistakenly (because there i=
s
> no support for the *lockfile() functions required[1]) defined
> _POSIX_THREAD_SAFE_FUNCTIONS and that was being worked around since
> 3ecd153a3b (compat/mingw: support MSys2-based MinGW build, 2016-01-14).
>
> the bug was fixed in winphtreads, but as a sideeffect, leaves the

s/the/The/; s/sideeffect/side effect/;

> reentrant functions from time.h not longer visible and therefore breaks

s/not longer/no longer/

> the build.
>
> since the intention all along was to avoid using the fallback functions=
,

s/since/Since/;

> formalize the use of POSIX by setting the corresponding feature flag an=
d
> to make the intention clearer compile out the fallback functions.

I cannot parse the last sentence.  I am guessing "... make the
intention clearer by compiling out..." or "... make the intention
clearer to compile out...", but I cannot quite tell.

> diff --git a/compat/mingw.c b/compat/mingw.c
> index 9e0cd1e097f..e14f2d5f77c 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -1083,6 +1083,7 @@ int pipe(int filedes[2])
>  	return 0;
>  }
> =20
> +#ifndef __MINGW64__
>  struct tm *gmtime_r(const time_t *timep, struct tm *result)
>  {
>  	if (gmtime_s(result, timep) =3D=3D 0)
> @@ -1096,6 +1097,7 @@ struct tm *localtime_r(const time_t *timep, struc=
t tm *result)
>  		return result;
>  	return NULL;
>  }
> +#endif
> =20
>  char *mingw_getcwd(char *pointer, int len)
>  {
> diff --git a/git-compat-util.h b/git-compat-util.h
> index d70ce142861..c8005db3fb6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -127,7 +127,9 @@
>  /* Approximation of the length of the decimal representation of this t=
ype. */
>  #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
> =20
> -#if defined(__sun__)
> +#ifdef __MINGW64__
> +#define _POSIX_C_SOURCE 1
> +#elif defined(__sun__)
>   /*
>    * On Solaris, when _XOPEN_EXTENDED is set, its header file
>    * forces the programs to be XPG4v2, defeating any _XOPEN_SOURCE
>
> base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
