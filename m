Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2AF17980
	for <git@vger.kernel.org>; Wed,  3 Jan 2024 00:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v37VCPX8"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7BFA11D8302;
	Tue,  2 Jan 2024 19:43:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jYPMDcKlI68A
	TPBoP9aA/6Z/WW6NY8qWEhmcsLLS2Xo=; b=v37VCPX8KU1rN1883C6YJgCo3/LF
	0aAdSJJGXnMMGe7yDzd93fv6CKbzdNO5V9Zmk71uQY+5VkGkbv8Aqcpx1FQz+RdP
	gRS758wPjuySrBhKrvtdwrIYenmdePhEdmeSdp3+3dioz/6ZdGMau+VJeqMqvuJo
	KO3BpzidK0SjRNM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 7407C1D8301;
	Tue,  2 Jan 2024 19:43:18 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AB8A91D8300;
	Tue,  2 Jan 2024 19:43:16 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH V4 1/1] Replace SID with domain/username
In-Reply-To: <20240102191514.2583-2-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Tue, 2 Jan 2024 20:15:14 +0100")
References: <xmqqsf3feilq.fsf@gitster.g>
	<20240102191514.2583-1-soekkle@freenet.de>
	<20240102191514.2583-2-soekkle@freenet.de>
Date: Tue, 02 Jan 2024 16:43:15 -0800
Message-ID: <xmqqa5pnckm4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 156405FC-A9D1-11EE-8D42-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

S=C3=B6ren Krecker <soekkle@freenet.de> writes:

> Replace SID with domain/username in error message, if owner of reposito=
ry
> and user are not equal on windows systems. Each user should have a uniq=
ue
> SID (https://learn.microsoft.com/en-us/windows-server/identity/ad-ds/ma=
nage/understand-security-identifiers#what-are-security-identifiers).

That paragraph your URL refers to does say that a SID that is used
for an account will never be reused to identify a different account.
But I am not sure if it means a user will never be assigned more
than one SID (in other words, the reverse is not necessarily true).

The paragraph also mentions that a SID can identify a non-user
entity like a computer account (as opposed to "a user account")---I
do not know what its implications are in the context of this patch,
though.

> This means that domain/username is not a loss of information.

This statement does not (grammatically) make sense, but more
importantly, loss of information may not be a bad thing in this
case.  If more than one SIDs are given to a user account and
processes working for that account, these different SIDs may be
translated, by using LookupAccountSidA(), to the same string for a
single user@domain, and it would be an operation that loses
information in that sense.

But if what we *care* about is user@domain between the current
process and the owner of the directory in question being the same
(or not), then such a loss of information is a *good* thing. =20

So I dunno.  Arguing what we care about (is that exact SID equality
between the "owner of the directory" and the "user, which the
current process is working on behalf of", or do we care about the
equality of the "accounts"?) may be a better way to justify this
change, if you ask me.

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
> +	if (translate_sid_to_user =3D=3D FALSE) {
> +		FREE_AND_NULL(*str);
> +	}

Style: do not enclose a single-statement block inside {}.

> +	else
> +		(*str)[len_domain] =3D '/';
> +	return translate_sid_to_user;
> +}

> @@ -2767,7 +2788,9 @@ int is_path_owned_by_current_sid(const char *path=
, struct strbuf *report)
>  		} else if (report) {
>  			LPSTR str1, str2, to_free1 =3D NULL, to_free2 =3D NULL;
> =20
> -			if (ConvertSidToStringSidA(sid, &str1))
> +			if (user_sid_to_user_name(sid, &str1))
> +				to_free1 =3D str1;
> +			else if (ConvertSidToStringSidA(sid, &str1))
>  				to_free1 =3D str1;

Do these two helper functions return pointers pointing into the same
kind of memory that you can free with the same function?  That is ...

> ...
>  				    "'%s' is owned by:\n"
>  				    "\t'%s'\nbut the current user is:\n"
>  				    "\t'%s'\n", path, str1, str2);
> -			LocalFree(to_free1);
> -			LocalFree(to_free2);
> +			free(to_free1);
> +			free(to_free2);

... the original code seems to say that the piece of memory we
obtain from ConvertSidToStringSidA() must not be freed by calling
free() but use something special called LocalFree().  I am assuing
that your user_sid_to_user_name() returns a regular piece of memory
that can be freed by calling regular free()?  Do we need to keep
track of where we got the memory from and use different function to
free each variable, or something (again I do not do Windows so I'll
defer all of these to Dscho, who is CC'ed this time).

Thanks and a happy new year.

>  		}
>  	}

