Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0782A74E23
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710442664; cv=none; b=m/6qDqwhyUHe3oBEFjBlSiUZfehb3jnNTyegRzO7SlvgUdlcQzeKnH9V92xTP6wFE0OVLC8qJWRMvIMnnkwV9CJp4E/vt64afql9akdy7M8rMTbI0wCQ08bfV33q9Kh70JihugqJ+ouzWANjTs+sYeZyVdtPZ5hGJGQpPSWHZjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710442664; c=relaxed/simple;
	bh=UXFLpKfv7dz2GzQ2HkD3hKx6s/hb45K1xMsHg2X1Oqo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EyQIjvbEbaOzOU3M8v8LESYXSdG8lAA5WAlEMBes/vkkYnbmXMNsb6IGw4HcijY0tLIAXMGe32cOLN3JVU1GFFxRFiQgko8hNt5CZstRhzhLEilNXDK96WMJuG233cFVtvxB/8eVNjd8I18Chx1WMQtl8TY06SJqaIR94EK1+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=krwtR2Nk; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="krwtR2Nk"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 866C41D8D45;
	Thu, 14 Mar 2024 14:57:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=UXFLpKfv7dz2
	GzQ2HkD3hKx6s/hb45K1xMsHg2X1Oqo=; b=krwtR2NkPVOd+FfkMLjOv1FT3P4D
	lad3B2t6FLUTsOiDYr1weycw6ATF14ZYwddbbHv2y3gMaDurqKQuWstsNJ23jtQ6
	8TDO78r1fm+kZkiEbC5SN3zw8J6UHElHOamhEYkQLq38O/uVCXFfqolOwMmoCIhn
	hjtbv7fvPbiMBpw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D7D51D8D44;
	Thu, 14 Mar 2024 14:57:41 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF2EB1D8D41;
	Thu, 14 Mar 2024 14:57:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] checkout: plug some leaks in git-restore
In-Reply-To: <64c1c3cc-51d7-4168-9731-4389889e1449@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 14 Mar 2024 19:08:58 +0100")
References: <04a9e001-5cd6-402c-86eb-f3751aa6f354@gmail.com>
	<8faa0cd5-25e8-4a8f-ad8b-5fc1b6e5138b@gmail.com>
	<64c1c3cc-51d7-4168-9731-4389889e1449@gmail.com>
Date: Thu, 14 Mar 2024 11:57:39 -0700
Message-ID: <xmqq8r2kvdy4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 BB99CA1A-E234-11EE-A528-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 4fe049cf37..2e8b0d18f4 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -1704,10 +1704,11 @@ static char cb_option =3D 'b';
> =20
>  static int checkout_main(int argc, const char **argv, const char *pref=
ix,
>  			 struct checkout_opts *opts, struct option *options,
> -			 const char * const usagestr[],
> -			 struct branch_info *new_branch_info)
> +			 const char * const usagestr[])
>  {
>  	int parseopt_flags =3D 0;
> +	struct branch_info new_branch_info =3D { 0 };
> +	int ret;

Ah, nice.  This is one thing I missed.

The callers of checkout_main() do not even care about the
new_branch_info structure so there is no point having them allocate
and pass a pointer to one to call this function.

The remainder is just as expected.  Will queue.  Thanks.
