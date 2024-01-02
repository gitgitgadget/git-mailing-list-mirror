Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B098F14F65
	for <git@vger.kernel.org>; Tue,  2 Jan 2024 16:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="eZetvwOS"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 542882E61B;
	Tue,  2 Jan 2024 11:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=/gumDWlLUORB
	b0pNINEa5mth4OUIeskBZ6Rjl6QL5xM=; b=eZetvwOSIy1RgwKYa+ShdWieyo2s
	do/81DvpR7OiuY4Nbxh2bYCsRi3969fU2yLoIPXQIGrHjVC9gMotwGHRWhxkItyO
	JMKjo7wXtLW3/zOT1jp8eUG2GRtnDkpjN0RPY56UdwQyBQZKGOLeiuS/3tugYLNW
	zDDnIXyT4Ht4q3Y=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4C9E32E61A;
	Tue,  2 Jan 2024 11:20:47 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E8D002E618;
	Tue,  2 Jan 2024 11:20:43 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?S=C3=B6ren?= Krecker <soekkle@freenet.de>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com
Subject: Re: [PATCH v2 1/1] Replace SID with domain/username
In-Reply-To: <20231229120319.3797-2-soekkle@freenet.de> (=?utf-8?Q?=22S?=
 =?utf-8?Q?=C3=B6ren?= Krecker"'s
	message of "Fri, 29 Dec 2023 13:03:19 +0100")
References: <20231229120319.3797-1-soekkle@freenet.de>
	<20231229120319.3797-2-soekkle@freenet.de>
Date: Tue, 02 Jan 2024 08:20:42 -0800
Message-ID: <xmqqplyjg10l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E0F34774-A98A-11EE-B260-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

S=C3=B6ren Krecker <soekkle@freenet.de> writes:

> Replace SID with domain/username in erromessage, if owner of repository
> and user are not equal on windows systems.

"erromessage" -> "error messages" or something?

This may not be a question raised by anybody who know Windows, but
because I do not do Windows, it makes me wonder if this is losing
information.  Can two SID for the same user be active at the same
time, which would cause user_sid_to_user_name() potentially yield
the same string for two different SID?

In any case, I am reasonably sure that Dscho will say yes or no to
this patch (the above "makes me wonder" does not need to be
resolved) and I can wait until then.

Thanks.

> Signed-off-by: S=C3=B6ren Krecker <soekkle@freenet.de>
> ---
>  compat/mingw.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/compat/mingw.c b/compat/mingw.c
> index 42053c1f65..05aeaaa9ad 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2684,6 +2684,26 @@ static PSID get_current_user_sid(void)
>  	return result;
>  }
> =20
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
> +	return translate_sid_to_user;
> +}
> +
>  static int acls_supported(const char *path)
>  {
>  	size_t offset =3D offset_1st_component(path);
> @@ -2767,7 +2787,7 @@ int is_path_owned_by_current_sid(const char *path=
, struct strbuf *report)
>  		} else if (report) {
>  			LPSTR str1, str2, to_free1 =3D NULL, to_free2 =3D NULL;
> =20
> -			if (ConvertSidToStringSidA(sid, &str1))
> +			if (user_sid_to_user_name(sid, &str1))
>  				to_free1 =3D str1;
>  			else
>  				str1 =3D "(inconvertible)";
> @@ -2776,7 +2796,7 @@ int is_path_owned_by_current_sid(const char *path=
, struct strbuf *report)
>  				str2 =3D "(none)";
>  			else if (!IsValidSid(current_user_sid))
>  				str2 =3D "(invalid)";
> -			else if (ConvertSidToStringSidA(current_user_sid, &str2))
> +			else if (user_sid_to_user_name(current_user_sid, &str2))
>  				to_free2 =3D str2;
>  			else
>  				str2 =3D "(inconvertible)";
> @@ -2784,8 +2804,8 @@ int is_path_owned_by_current_sid(const char *path=
, struct strbuf *report)
>  				    "'%s' is owned by:\n"
>  				    "\t'%s'\nbut the current user is:\n"
>  				    "\t'%s'\n", path, str1, str2);
> -			LocalFree(to_free1);
> -			LocalFree(to_free2);
> +			free(to_free1);
> +			free(to_free2);
>  		}
>  	}
