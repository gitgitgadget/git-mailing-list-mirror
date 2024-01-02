Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE628154AB
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 17:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OwMzJ85U"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 35F9D2EFD6;
	Tue,  2 Jan 2024 12:43:50 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=dcPqwaSONlDe
	HIPFdYBYf50+tg4NOxtAUS60t4jo0os=; b=OwMzJ85U11TqCv+v+YFI8lOPBb6n
	V15/VBR/5EapSMcdut1FiUOnMKqEWsZfRcUJbSxJPin1ie0dsdk7hPDJqI9SeQCg
	ER5WM4lfe6WmFM5i8MJxWuiKRprOpNpmLx7Yu+APUgw+tM9uvpoFNQVXJl0w8exp
	27mT/YNnAsZOKAY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E21F2EFD5;
	Tue,  2 Jan 2024 12:43:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CFD592EFD4;
	Tue,  2 Jan 2024 12:43:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH v3 1/1] Replace SID with domain/username
In-Reply-To: <20231231091245.2853-2-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Sun, 31 Dec 2023 10:12:45 +0100")
References: <CAPig+cT4jy4MkyGxtSOZj6U3vUxLaRa-4wr7PON-EebAjT8pwQ@mail.gmail.com>
	<20231231091245.2853-1-soekkle@freenet.de>
	<20231231091245.2853-2-soekkle@freenet.de>
Date: Tue, 02 Jan 2024 09:43:45 -0800
Message-ID: <xmqqsf3feilq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7AFCDA6E-A996-11EE-9129-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

S=C3=B6ren Krecker <soekkle@freenet.de> writes:

> Replace SID with domain/username in error message, if owner of reposito=
ry
> and user are not equal on windows systems.
>
> Old message:
> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/sourc=
e/repos/git'
> 'C:/Users/test/source/repos/git' is owned by:
> 	'S-1-5-21-571067702-4104414259-3379520149-500'
> but the current user is:
> 	'S-1-5-21-571067702-4104414259-3379520149-1001'
> To add an exception for this directory, call:
>
> 	git config --global --add safe.directory C:/Users/test/source/repos/gi=
t
> '''
>
> New massage:

"massage"???

> '''
> fatal: detected dubious ownership in repository at 'C:/Users/test/sourc=
e/repos/git'
> 'C:/Users/test/source/repos/git' is owned by:
>         'DESKTOP-L78JVA6/Administrator'
> but the current user is:
>         'DESKTOP-L78JVA6/test'
> To add an exception for this directory, call:
>
>         git config --global --add safe.directory C:/Users/test/source/r=
epos/git
> '''

The same "does this lose information?" comment applies to this one
as well, as the fundamental approach is unchanged.

> +static BOOL user_sid_to_user_name(PSID sid, LPSTR *str)
> +{
> +	SID_NAME_USE pe_use;
> +	DWORD len_user =3D 0, len_domain =3D 0;
> +	BOOL translate_sid_to_user;
> +
> +	/* returns only FALSE, because the string pointers are NULL*/
> +	LookupAccountSidA(NULL, sid, NULL, &len_user, NULL, &len_domain,
> +			  &pe_use);=20
> +	/*Alloc needed space of the strings*/
> +	ALLOC_ARRAY((*str), (size_t)len_domain + (size_t)len_user);=20
> +	translate_sid_to_user =3D LookupAccountSidA(NULL, sid, (*str) + len_d=
omain, &len_user,
> +				   *str, &len_domain, &pe_use);
> +	*(*str + len_domain) =3D '/';
> +	if (translate_sid_to_user =3D=3D FALSE) {
> +		FREE_AND_NULL(*str);
> +	}

Is this "FREE_AND_NULL" about clearing after you see an error?  If
so, shouldn't "overwrite the byte after the domain part with a slash"
be done only when you have no error, i.e., perhaps

	translate_sid_to_user =3D LookupAccountSidA(...);
	if (!translate_sid_to_user)
		FREE_AND_NULL(*str);
	else
        	(*str)[len_domain] =3D '/';

or something along the line?

> +	return translate_sid_to_user;
> +}
