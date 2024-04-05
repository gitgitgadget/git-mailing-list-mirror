Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D721B299
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 16:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712335887; cv=none; b=Rsc6y8nSHDQhLS+KTGLeCQJ1HCmnSfM/Iw1N7HVMKdyeG6cRG/SZ4Cm7AEar//TIcigdyKTXUxp7N8HtJ8Hk+wL+x7y4Ks3QZSd4ForDUNjQrjhY3LORzuo3hG+2z4yPOifH863s5Aa/ldmF4gs+4TPN50nyqx59m8srxBCb4yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712335887; c=relaxed/simple;
	bh=QJe6RrI+hN1DWdnQFjAobAWSojxTsWtQZjMdNKvH4Hk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mdyf9SBEGaHTKPoiz8jLjT3CiF64nUTNgtWldzTWxMA6JO46qDani9w/91Kh+EtwsJBqInTuVjNasJtBkLuZkLpkBPq5CJH74vXUeQ3nWwPeJLXn4kwGRbPi2cBWJkAbRN6loGoRVngX+4kXtjbN+nxvldHwXLcWIoMTc+N/5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O8tYhamX; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O8tYhamX"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5FB8A1EFB44;
	Fri,  5 Apr 2024 12:51:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QJe6RrI+hN1D
	WdnQFjAobAWSojxTsWtQZjMdNKvH4Hk=; b=O8tYhamXPFFjTl9GBwN8HUgQT/oz
	EaZAet1ASaJqGLKX7ebSVjEszp6y0k3F7AqdlWBGnOdpciTsoYqbC2EC38xzS7WC
	mq0zDANKdopYXvlKsYmvB74u7Vrumkd/ToxNYZ9yYjx+Us8yhiLVrtNCEzsXITl5
	BGEYIvAFVTnv5M8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 57E6D1EFB43;
	Fri,  5 Apr 2024 12:51:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B6DF71EFB42;
	Fri,  5 Apr 2024 12:51:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 1/2] apply: avoid fixed-size buffer in create_one_file()
In-Reply-To: <1b5f3b1d-60e2-4fe7-9ac8-a63ad861cd16@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 5 Apr 2024 12:53:23 +0200")
References: <df774306-f29b-4a75-a282-59db89812b9a@web.de>
	<1b5f3b1d-60e2-4fe7-9ac8-a63ad861cd16@web.de>
Date: Fri, 05 Apr 2024 09:51:23 -0700
Message-ID: <xmqqfrvzwy5w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BCFBAF4C-F36C-11EE-B28B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Changes since v1:
> - Split out removal of mksnpath() into a separate patch.
> - Use errno only before calling free(3).

Relative to the previous round, the body of the loop has become much
easier to follow.  Nice clean-up.

Thanks, both.

>  apply.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 432837a674..e171b42904 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4441,6 +4441,7 @@ static int create_one_file(struct apply_state *st=
ate,
>  			   const char *buf,
>  			   unsigned long size)
>  {
> +	char *newpath =3D NULL;
>  	int res;
>
>  	if (state->cached)
> @@ -4502,24 +4503,26 @@ static int create_one_file(struct apply_state *=
state,
>  		unsigned int nr =3D getpid();
>
>  		for (;;) {
> -			char newpath[PATH_MAX];
> -			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
> +			newpath =3D mkpathdup("%s~%u", path, nr);
>  			res =3D try_create_file(state, newpath, mode, buf, size);
>  			if (res < 0)
> -				return -1;
> +				goto out;
>  			if (!res) {
>  				if (!rename(newpath, path))
> -					return 0;
> +					goto out;
>  				unlink_or_warn(newpath);
>  				break;
>  			}
>  			if (errno !=3D EEXIST)
>  				break;
>  			++nr;
> +			FREE_AND_NULL(newpath);
>  		}
>  	}
> -	return error_errno(_("unable to write file '%s' mode %o"),
> -			   path, mode);
> +	res =3D error_errno(_("unable to write file '%s' mode %o"), path, mod=
e);
> +out:
> +	free(newpath);
> +	return res;
>  }
>
>  static int add_conflicted_stages_file(struct apply_state *state,
> --
> 2.44.0
