Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D945136103
	for <git@vger.kernel.org>; Fri,  9 Feb 2024 22:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707517107; cv=none; b=EsBfZmRG3ncmZ1QBdG3isikPCfCztc2abl2xaA5KCQ9YzLbw6cQK3k5ukYSii4Nqrz0qFRgGjs9PFeVFATSq+H2qoEU8Dbns3Pe3Kf3WcCodC7UrBXR/4j87H1pzU9zpAlFvmE3vx+Fr5+nfMF63WFx0E2OlJ3/jPm8hWp7D5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707517107; c=relaxed/simple;
	bh=DBGdK0jx/9EzMjDGVFXP5VuxHb4xr5T8R1H/aMigckc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aPaGu86viBdTthBaalX6HANwZO0ongclii2MhmLd+ayf1MPQ8NrK+Gz/kYO4S5oCnkaiuDtp/JDyWrKuJhXIb82p/TPDDdpSt7k5C4BKff03MjFH4XpPVTii5AAHBhEHAXh0qi9KMZOblhMwPyGLPrpNZRM/cYhlaEHrubjqvfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GpN43LyZ; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GpN43LyZ"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58B5D1C512F;
	Fri,  9 Feb 2024 17:18:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=DBGdK0jx/9Ez
	MjDGVFXP5VuxHb4xr5T8R1H/aMigckc=; b=GpN43LyZfV/uToU2PNgXMSqtID1w
	a/Je3PaJtpCYIpregHBo5CrRV3YzEaXMfK6MFlLXGaDbQEecmsi/8FKUK2iUuXC+
	Jc9oYp6+kiJaHOeREaVE29tC0fOnqTt3t3Fykdnzg1A+eOu5PENBbkt7oxGbH8q8
	eSfOGmiz/gwOGBw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 502281C512C;
	Fri,  9 Feb 2024 17:18:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD4381C512B;
	Fri,  9 Feb 2024 17:18:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Chandra Pratap
 <chandrapratap376@gmail.com>,  Chandra Pratap
 <chandrapratap3519@gmail.com>,  Jeff King <peff@peff.net>,  Kyle
 Lippincott <spectral@google.com>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 2/2] receive-pack: use find_commit_header() in
 check_nonce()
In-Reply-To: <8b350cae-2180-4ac7-a911-d40043576445@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 9 Feb 2024 21:41:47 +0100")
References: <ff0db7e3-abce-44ea-a1e3-16e1fdaf4c75@web.de>
	<8b350cae-2180-4ac7-a911-d40043576445@web.de>
Date: Fri, 09 Feb 2024 14:18:22 -0800
Message-ID: <xmqqmss9cmdt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 23A9F064-C799-11EE-BAE0-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> @@ -620,17 +605,18 @@ static int constant_memequal(const char *a, const=
 char *b, size_t n)
>  	for (i =3D 0; i < n; i++)
>  		res |=3D a[i] ^ b[i];
>  	return res;
>  }
>
> -static const char *check_nonce(const char *buf, size_t len)
> +static const char *check_nonce(const char *buf)
>  {
> -	char *nonce =3D find_header(buf, len, "nonce", NULL);
> +	size_t noncelen;
> +	const char *found =3D find_commit_header(buf, "nonce", &noncelen);
> +	char *nonce =3D found ? xmemdupz(found, noncelen) : NULL;

OK, the changes to this function are all quite trivially correct.

>  	timestamp_t stamp, ostamp;
>  	char *bohmac, *expect =3D NULL;
>  	const char *retval =3D NONCE_BAD;
> -	size_t noncelen;
>
>  	if (!nonce) {
>  		retval =3D NONCE_MISSING;
>  		goto leave;
>  	} else if (!push_cert_nonce) {
> @@ -668,11 +654,10 @@ static const char *check_nonce(const char *buf, s=
ize_t len)
>  	if (bohmac =3D=3D nonce || bohmac[0] !=3D '-') {
>  		retval =3D NONCE_BAD;
>  		goto leave;
>  	}
>
> -	noncelen =3D strlen(nonce);
>  	expect =3D prepare_push_cert_nonce(service_dir, stamp);
>  	if (noncelen !=3D strlen(expect)) {
>  		/* This is not even the right size. */
>  		retval =3D NONCE_BAD;
>  		goto leave;
> @@ -765,11 +750,11 @@ static void prepare_push_cert_sha1(struct child_p=
rocess *proc)
>  		sigcheck.payload =3D xmemdupz(push_cert.buf, bogs);
>  		sigcheck.payload_len =3D bogs;
>  		check_signature(&sigcheck, push_cert.buf + bogs,
>  				push_cert.len - bogs);
>
> -		nonce_status =3D check_nonce(push_cert.buf, bogs);
> +		nonce_status =3D check_nonce(sigcheck.payload);

Hmph.  sigc->payload is used as a read-only member in
check_signature(), and the xmemdupz() copy we made earlier is
readily available as a replacement for the counted (push_cert.buf,
bogs) string.  Very nice finding.

>  	}
>  	if (!is_null_oid(&push_cert_oid)) {
>  		strvec_pushf(&proc->env, "GIT_PUSH_CERT=3D%s",
>  			     oid_to_hex(&push_cert_oid));
>  		strvec_pushf(&proc->env, "GIT_PUSH_CERT_SIGNER=3D%s",
> --
> 2.43.0
