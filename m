Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7AB1BDC8
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 17:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722446947; cv=none; b=GKaZxwNUyu5PCDcz6XnCeFGWaABAY5zLwL/wTdDzSHgsrJiq2lvx/M4+lAbGfwRblJ0sD9/aQbQApZuykEPBBeiMpNbGow6jXJaGt+6HWK4DO6iEv0dsxdrfWQmxNM7MKx5sCvfbZsM2+ubQh4QkklmtMiWaImhw1Ng102KUo7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722446947; c=relaxed/simple;
	bh=NvwBaFCvQURPEdgB7H2Xv1Z1MvnuOD7p1hHQiMv5tDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SaBVWLhpyP9uGzFk7Ag1S1FLX3++kauUlFrjH38byqWExWdREmMcp6YCAETzpC330DP5BrEL5sqcI3x4ubyrfy/TDpqhju8D7s16lpsOmN8ZfSzmQQNG8wGp+vOYSh55qjh+o2ah0ow7/dsjEEIZtsjGSoRgICpW+zC7PCJfZVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kXpKwAFh; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kXpKwAFh"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D9C8725279;
	Wed, 31 Jul 2024 13:29:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=NvwBaFCvQURPEdgB7H2Xv1Z1MvnuOD7p1hHQiM
	v5tDE=; b=kXpKwAFhjvp5yYOtzH33ZC7ibX4Tm9BbMmySwmGQL6Ra/4xUG+F3qN
	1ZuXPs3OVBM5gw5q5CEtAdViiG/lnSluV6zWzd+5Hr5PgszuqJzkJVMPafg0zSNX
	4gn8pt8rCgcCpbNl2OS9BAKyphSLX4s8zvd41gRzVvNpoEvB6mlQA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D0E9525278;
	Wed, 31 Jul 2024 13:29:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D6D8425275;
	Wed, 31 Jul 2024 13:29:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  John Cai <johncai86@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] strbuf: refactor strbuf_trim_trailing_ch()
In-Reply-To: <20240731134014.2299361-3-christian.couder@gmail.com> (Christian
	Couder's message of "Wed, 31 Jul 2024 15:40:12 +0200")
References: <20240731134014.2299361-1-christian.couder@gmail.com>
	<20240731134014.2299361-3-christian.couder@gmail.com>
Date: Wed, 31 Jul 2024 10:29:00 -0700
Message-ID: <xmqqle1h5v37.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 60AA7FA0-4F62-11EF-8E67-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> We often have to split strings at some specified terminator character.
> The strbuf_split*() functions, that we can use for this purpose,
> return substrings that include the terminator character, so we often
> need to remove that character.
>
> When it is a whitespace, newline or directory separator, the
> terminator character can easily be removed using an existing triming
> function like strbuf_rtrim(), strbuf_trim_trailing_newline() or
> strbuf_trim_trailing_dir_sep(). There is no function to remove that
> character when it's not one of those characters though.

OK.

> Let's introduce a new strbuf_trim_trailing_ch() function that can be
> used to remove any trailing character, and let's refactor existing code
> that manually removed trailing characters using this new function.

It is disappointing that this new one is not adequate to rewrite any
of the existing strbuf_trim* functions in terms of it, but that's
probably OK.  At least this one we have two existing callers, but
makes me wonder if these callers are doing sensible things in the
first place.  After trimming trailing commas, there may be trailing
newlines to be trimmed, and then again whitespaces around the whole
thing may need to be trimmed---what kind of input is that?  The
value has to be " junk \n\n,,,", but " junk, \n\n, " will only
become "junk, \n\n," without further cleaned up, and it is very
dubious how that is useful.

But that is not an issue this patch introduces ;-)

> diff --git a/trace2/tr2_cfg.c b/trace2/tr2_cfg.c
> index d96d908bb9..356fcd38f4 100644
> --- a/trace2/tr2_cfg.c
> +++ b/trace2/tr2_cfg.c
> @@ -33,10 +33,7 @@ static int tr2_cfg_load_patterns(void)
>  
>  	tr2_cfg_patterns = strbuf_split_buf(envvar, strlen(envvar), ',', -1);
>  	for (s = tr2_cfg_patterns; *s; s++) {
> -		struct strbuf *buf = *s;
> -
> -		if (buf->len && buf->buf[buf->len - 1] == ',')
> -			strbuf_setlen(buf, buf->len - 1);
> +		strbuf_trim_trailing_ch(*s, ',');
>  		strbuf_trim_trailing_newline(*s);
>  		strbuf_trim(*s);
>  	}
> @@ -72,10 +69,7 @@ static int tr2_load_env_vars(void)
>  
>  	tr2_cfg_env_vars = strbuf_split_buf(varlist, strlen(varlist), ',', -1);
>  	for (s = tr2_cfg_env_vars; *s; s++) {
> -		struct strbuf *buf = *s;
> -
> -		if (buf->len && buf->buf[buf->len - 1] == ',')
> -			strbuf_setlen(buf, buf->len - 1);
> +		strbuf_trim_trailing_ch(*s, ',');
>  		strbuf_trim_trailing_newline(*s);
>  		strbuf_trim(*s);
>  	}
