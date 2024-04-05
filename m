Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31497171E54
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 17:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712336959; cv=none; b=ZoaZU5AOiuZRqzyLIuV/1IFa8Hh2Sfdzpm/wpUVoESCRGPVy6LNmQl8JTfkXUqtG4S3bVS/7jE4nqCzByP9tvfT61d7+sQl5fxHU0An9bYze6fBs0LsoDjWxOnCEoryYyH9iUHPUnUU6b1heNW6oCDAsQZkAnpu9834aVIcZlZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712336959; c=relaxed/simple;
	bh=MaZaNum3r1Frt6NdaVNYNqDO+qCYst6wejmo2XDp63o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m4xONf6n7dKDvq8dM51ELZZYM+61c1I1yeYT7JIrJGFqJSNlIFng7RHpaytWXWDN3KzlHw3gRXD7LxTsjDEilhOUGuhMtEbJQzHvpFVAAcLYSlgSkP6cneLvfrrWGxUOc8ecgWsBJCPLoNXBiSiuArh+HmjW7zrZd3FNUqnUilo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rSg3W3tt; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rSg3W3tt"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CB2C221742;
	Fri,  5 Apr 2024 13:09:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MaZaNum3r1Fr
	t6NdaVNYNqDO+qCYst6wejmo2XDp63o=; b=rSg3W3ttEpjcgCznHrZIPyA7z53f
	ydoLvDRHH0Bgk0DdDxJag2tRAOFNqK8SA+wtRildaH0sqLt9qDbc4Yka5iRebfr9
	r5WOi6DFR4UApcCubIKi93tmfQEFBDABgOdwtCoOQxFdSPrJ8eDg6JDJ3QOeg5lV
	e7nhOWW5WZiD4K0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C3EBC21741;
	Fri,  5 Apr 2024 13:09:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5293A2173F;
	Fri,  5 Apr 2024 13:09:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] apply: don't leak fd on fdopen() error
In-Reply-To: <5ba55ee4-94c7-4094-a744-584fc623b391@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 5 Apr 2024 12:58:16 +0200")
References: <5ba55ee4-94c7-4094-a744-584fc623b391@web.de>
Date: Fri, 05 Apr 2024 10:09:12 -0700
Message-ID: <xmqqv84vvirr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 3A816BBC-F36F-11EE-99BE-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  apply.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/apply.c b/apply.c
> index 432837a674..1cfbc2f074 100644
> --- a/apply.c
> +++ b/apply.c
> @@ -4655,8 +4655,11 @@ static int write_out_one_reject(struct apply_sta=
te *state, struct patch *patch)
>  			return error_errno(_("cannot open %s"), namebuf);
>  	}
>  	rej =3D fdopen(fd, "w");
> -	if (!rej)
> -		return error_errno(_("cannot open %s"), namebuf);
> +	if (!rej) {
> +		error_errno(_("cannot open %s"), namebuf);
> +		close(fd);
> +		return -1;
> +	}

Ah, true, this fd is what we created in this function, and we should
close it.  Well spotted.

Will queue.

>
>  	/* Normal git tools never deal with .rej, so do not pretend
>  	 * this is a git patch by saying --git or giving extended
> --
> 2.44.0
