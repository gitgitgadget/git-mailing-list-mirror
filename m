Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8814E1BF
	for <git@vger.kernel.org>; Sat, 24 Feb 2024 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708816395; cv=none; b=C/bhil8/Cli9MZia6K+YBlFJXpeBbDKzp4a1/BZfM11CelxoRLtYKDHZ0KpvsOC78stXEV0xh+b2JMe5MbI37gwgJ9FUTSyzHrE1IT+cM/pqHRUKsS3fDFD2DHnHwV/weby+l9n//OgaKOk2qtpAjnE9ViNSHw7xH6FW7ebRVBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708816395; c=relaxed/simple;
	bh=HIUETKUtcnUKZ/pNweA3Ilklq5WOXGar0jLkWU1phX8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lYxTZvIvDuQXN/gQgNWtcavHJ45c91EyiZaURjC8/f7YCf4HeqqDlNsYBXfT0xP8mjjn4tlDBj/7eHRfD1DIkmC4kjn8k1pLPXC+XiCw+poRDATzkcK84TjdogBgSSDQc8+dL/OudWmtmJSqvFzPIkGsLUPDx5p+cF5J3XeIgbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=VVrxxsyb; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VVrxxsyb"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0FF7230051;
	Sat, 24 Feb 2024 18:13:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HIUETKUtcnUK
	Z/pNweA3Ilklq5WOXGar0jLkWU1phX8=; b=VVrxxsybSbwRoOhIuI8CWZcw9KaG
	0GyY69HUk9SSmWzhCYwkChMvlguw07MgiQQ84lfdrNrgly4zoc6yCR4JJfLTA2D4
	NGYMTkS4w7UDlB9GQ/6nCm3QQG70PYru0k1aOMm2NKfiSYKhQgdC2TXv6ohnEu4J
	1C9LMDGkmjHOYe4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id E544930050;
	Sat, 24 Feb 2024 18:13:06 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 87D3B3004D;
	Sat, 24 Feb 2024 18:13:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/6] parse-options: factor out register_abbrev() and
 struct parsed_option
In-Reply-To: <20240224212953.44026-4-l.s.r@web.de> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message
	of "Sat, 24 Feb 2024 22:29:50 +0100")
References: <20240224212953.44026-1-l.s.r@web.de>
	<20240224212953.44026-4-l.s.r@web.de>
Date: Sat, 24 Feb 2024 15:13:01 -0800
Message-ID: <xmqqttlxjw1u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 42CB93E4-D36A-11EE-B2A2-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

>  static enum parse_opt_result parse_long_opt(
>  	struct parse_opt_ctx_t *p, const char *arg,
>  	const struct option *options)
>  {
>  	const char *arg_end =3D strchrnul(arg, '=3D');
> -	const struct option *abbrev_option =3D NULL, *ambiguous_option =3D NU=
LL;
> -	enum opt_parsed abbrev_flags =3D OPT_LONG, ambiguous_flags =3D OPT_LO=
NG;
> -	int allow_abbrev =3D !(p->flags & PARSE_OPT_KEEP_UNKNOWN_OPT);
> +	struct parsed_option abbrev =3D { .option =3D NULL, .flags =3D OPT_LO=
NG };
> +	struct parsed_option ambiguous =3D { .option =3D NULL, .flags =3D OPT=
_LONG };

There is this "allow_abbrev" thing ...

> ...
>  			if (!skip_prefix(arg + 3, long_name, &rest)) {
>  				/* abbreviated and negated? */
> -				if (allow_abbrev &&
> -				    !strncmp(long_name, arg + 3,
> +				if (!strncmp(long_name, arg + 3,
>  					     arg_end - arg - 3))
> -					goto is_abbreviated;
> -				else
> -					continue;
> +					register_abbrev(p, options,
> +							flags ^ opt_flags,
> +							&abbrev, &ambiguous);
> +				continue;
>  			}
>  		}

... whose use goes away completely from the loop.  We still call
register_abbrev(), but the helper function becomes no-op when
p->flags had KEEP_UNKNOWN_OPT bit set, so everything cancels out.

OK.
