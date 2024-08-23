Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609081953B9
	for <git@vger.kernel.org>; Fri, 23 Aug 2024 21:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724447597; cv=none; b=jwH7m7UAizhU5oY+WIzCg/QRQDANfuY+EcxDu12VLvQRX+/IY3L8jWmTcrtoqWLHy9Qp+iF2Q4wCffyoDvUWJ5DEFNPXahUZ6hmAPMTuInqCUKPdd9xNosnYqz6G2kFmxlbD/wvkiFKKVDbhUZ185WqW8CGiGzFqyJOv2X+kAsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724447597; c=relaxed/simple;
	bh=V/pvX0Bua1szlMsRlKcaQHlDH+TCIALMK3HZ3uXXvIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LGlC3AqDqyBfXorFB1OCx4PTHaAEvBQnq2K9jpFsk8X6Xmwh2SZc3yw/bADbdwv96Z0AI/T3EE/XInfvahLgZgdiYziP+7N4RSqU6hTILw0WIMiXJOkWF09kN3kajX6aZR+l3Rg/SUld0SZI0OKv+SwGuhhe8u4ghm0Fkyz8oL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j63OgyCx; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j63OgyCx"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id CDBB226599;
	Fri, 23 Aug 2024 17:13:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=V/pvX0Bua1sz
	lMsRlKcaQHlDH+TCIALMK3HZ3uXXvIw=; b=j63OgyCxvVJyAJgVb+AYP6qzcCFi
	jO3Y5h4k1Woz8MSF5Q5HURaaitQC4+Dt8gAo79zOYgBa0hopBOFgOFBiZb13wDfn
	kO3V5tvnqLJqwx7uKHiYwUvtnwgG2gdeKT8JQTqjG/rWtwnT5Az+my6zdcYRZBK4
	L5zA7tMa3sdGhA0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C696826598;
	Fri, 23 Aug 2024 17:13:15 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B03926597;
	Fri, 23 Aug 2024 17:13:11 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] remote: plug memory leaks at early returns
In-Reply-To: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Fri, 23 Aug 2024 22:21:10 +0200")
References: <82cb986c-6830-4d9a-bad1-fe4cab6a76eb@web.de>
Date: Fri, 23 Aug 2024 14:13:09 -0700
Message-ID: <xmqqseuvndsq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 809C9688-6194-11EF-93CA-E92ED1CD468F-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  builtin/remote.c | 23 +++++++++++++++--------
>  1 file changed, 15 insertions(+), 8 deletions(-)

Looks straight-forward.  Does this allow us to mark any test script
as leak-free?  I understand that Patrick has another round of
leakfixes topic that is not yet published, and I'd prefer to see us
not step each other's toes.

Will queue in the meantime but may drop it if Patrick says it
already is covered or something.

Thanks.

> diff --git a/builtin/remote.c b/builtin/remote.c
> index d1f9292ed2..0acc547d69 100644
> --- a/builtin/remote.c
> +++ b/builtin/remote.c
> @@ -164,6 +164,7 @@ static int add(int argc, const char **argv, const c=
har *prefix)
>  	struct strbuf buf =3D STRBUF_INIT, buf2 =3D STRBUF_INIT;
>  	const char *name, *url;
>  	int i;
> +	int result =3D 0;
>
>  	struct option options[] =3D {
>  		OPT_BOOL('f', "fetch", &fetch, N_("fetch the remote branches")),
> @@ -230,8 +231,10 @@ static int add(int argc, const char **argv, const =
char *prefix)
>  			       fetch_tags =3D=3D TAGS_SET ? "--tags" : "--no-tags");
>  	}
>
> -	if (fetch && fetch_remote(name))
> -		return 1;
> +	if (fetch && fetch_remote(name)) {
> +		result =3D 1;
> +		goto out;
> +	}
>
>  	if (master) {
>  		strbuf_reset(&buf);
> @@ -241,14 +244,15 @@ static int add(int argc, const char **argv, const=
 char *prefix)
>  		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
>
>  		if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, =
buf2.buf, "remote add"))
> -			return error(_("Could not setup master '%s'"), master);
> +			result =3D error(_("Could not setup master '%s'"), master);
>  	}
>
> +out:
>  	strbuf_release(&buf);
>  	strbuf_release(&buf2);
>  	string_list_clear(&track, 0);
>
> -	return 0;
> +	return result;
>  }
>
>  struct branch_info {
> @@ -715,6 +719,7 @@ static int mv(int argc, const char **argv, const ch=
ar *prefix)
>  	struct rename_info rename;
>  	int i, refs_renamed_nr =3D 0, refspec_updated =3D 0;
>  	struct progress *progress =3D NULL;
> +	int result =3D 0;
>
>  	argc =3D parse_options(argc, argv, prefix, options,
>  			     builtin_remote_rename_usage, 0);
> @@ -747,9 +752,11 @@ static int mv(int argc, const char **argv, const c=
har *prefix)
>
>  	strbuf_addf(&buf, "remote.%s", rename.old_name);
>  	strbuf_addf(&buf2, "remote.%s", rename.new_name);
> -	if (repo_config_rename_section(the_repository, buf.buf, buf2.buf) < 1=
)
> -		return error(_("Could not rename config section '%s' to '%s'"),
> -				buf.buf, buf2.buf);
> +	if (repo_config_rename_section(the_repository, buf.buf, buf2.buf) < 1=
) {
> +		result =3D error(_("Could not rename config section '%s' to '%s'"),
> +			       buf.buf, buf2.buf);
> +		goto out;
> +	}
>
>  	if (oldremote->fetch.raw_nr) {
>  		strbuf_reset(&buf);
> @@ -870,7 +877,7 @@ static int mv(int argc, const char **argv, const ch=
ar *prefix)
>  	strbuf_release(&buf);
>  	strbuf_release(&buf2);
>  	strbuf_release(&buf3);
> -	return 0;
> +	return result;
>  }
>
>  static int rm(int argc, const char **argv, const char *prefix)
> --
> 2.30.2
