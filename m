Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62259C433F5
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 22:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiD0WhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236200AbiD0Wg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 18:36:59 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2EE6B661
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 15:33:46 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BF5E13638B;
        Wed, 27 Apr 2022 18:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=dMpGy7RezOmh
        sWaHBhteC7Bg0LsjiVVscjVYSuCNbGk=; b=C6YGjUEpHGWN4Stj0XsJYLc824ie
        4Uj/xsKKhezkalwayYl8NnGsSpxIFddjWez4Bu3vG76iHrkbGf4rUde7Zl9FwdRP
        74X9Vet0jn+9xsAIxWUD+LWg4dIHOsd5N1w9KuOgvQKHeCKqCH3WvPNoqauB36wv
        ECmstmipVGsT3kI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 417F113638A;
        Wed, 27 Apr 2022 18:33:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A64DE136389;
        Wed, 27 Apr 2022 18:33:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, Johannes.Schindelin@gmx.de,
        derrickstolee@github.com, rsbecker@nexbridge.com,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v2] git-compat-util: avoid failing dir ownership
 checks if running privileged
References: <20220427000522.15637-1-carenas@gmail.com>
        <20220427222649.63516-1-carenas@gmail.com>
Date:   Wed, 27 Apr 2022 15:33:43 -0700
In-Reply-To: <20220427222649.63516-1-carenas@gmail.com> ("Carlo Marcelo
 Arenas
        =?utf-8?Q?Bel=C3=B3n=22's?= message of "Wed, 27 Apr 2022 15:26:49 -0700")
Message-ID: <xmqqilqujgvs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 18DB8836-C67A-11EC-AF17-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:

> diff --git a/git-compat-util.h b/git-compat-util.h
> index 58fd813bd01..3c9883934f6 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -437,12 +437,50 @@ static inline int git_offset_1st_component(const =
char *path)
>  #endif
> =20
>  #ifndef is_path_owned_by_current_user
> +
> +#ifdef __TANDEM
> +#define ROOT_UID 65535
> +#else
> +#define ROOT_UID 0
> +#endif
> +
> +/*
> + * this helper function overrides a ROOT_UID with the one provided by
> + * an environment variable, do not use unless the original user is
> + * root
> + */
> +static inline void extract_id_from_env(const char *env, uid_t *id)
> +{
> +	const char *real_uid =3D getenv(env);
> +
> +	/* discard any empty values */
> +	if (real_uid && *real_uid) {
> +		char *endptr;
> +		unsigned long env_id;
> +		int saved_errno =3D errno;
> +
> +		errno =3D 0;
> +		env_id =3D strtoul(real_uid, &endptr, 10);
> +		if (!errno && !*endptr && env_id <=3D (uid_t)-1)
> +			*id =3D env_id;

So we refrain from touching *id when we cannot read from SUDO_UID;
let's make sure that the caller is prepared for that ...

> +		errno =3D saved_errno;
> +	}
> +}
> +
>  static inline int is_path_owned_by_current_uid(const char *path)
>  {
>  	struct stat st;
> +	uid_t euid;
> +
>  	if (lstat(path, &st))
>  		return 0;
> -	return st.st_uid =3D=3D geteuid();
> +
> +	euid =3D geteuid();
> +	if (euid =3D=3D ROOT_UID)
> +		extract_id_from_env("SUDO_UID", &euid);

... and it is.  euid is set to the real thing, and the tweak done by
the helper function may overwrite it only when the helper computed
a value without an error.

> +	return st.st_uid =3D=3D euid;

OK.  Looking good.

Will queue.

>  }
> =20
>  #define is_path_owned_by_current_user is_path_owned_by_current_uid
