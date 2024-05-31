Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BE781204
	for <git@vger.kernel.org>; Fri, 31 May 2024 22:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717194491; cv=none; b=gJxJx9pDBNaNLArRwau/MxodtYBgrgcVWC5J2uNK+QdzCCtiFXdIUYpjIifZd3DtKIvb64c6NmHCCIG3aRv4kqz10I05Ld9B7/biONst8ubuHBGr2Nalgohx9Reh4lkMY/UswQQnkfajxjCPtmBb58R2XZEn5lA6OqP6WYnV2Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717194491; c=relaxed/simple;
	bh=8XBcc08iH8Isr1HNa5mcn3A1CMj7hF29j7TlRcbbxpo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rRtpbSIsJMYN0X6O4N8k/gTMo3sPS79AaNoDc3Mx97GEmzi23jvlyMD/E6d3LAP5sBIg78EnajfZ4BM1gdkvXcjaot19sJ8kjoSyOknTbpNSZrnD0qfkVwWcJ5YMwKXY0wgnNgF3k2QktUBHmuNlOoKLy1aeQm7a8FNisiF/S98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=k5NIaCdP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="k5NIaCdP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 2097C3DEA7;
	Fri, 31 May 2024 18:28:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=8XBcc08iH8Isr1HNa5mcn3A1CMj7hF29j7TlRc
	bbxpo=; b=k5NIaCdPmPHExPbKPEYQfQsrx+6ZXj0yEo+P24FeYAMoFRtEDWqt2F
	TqQaMU9Oxp0JPK+5MafysByE60gNBKxWhe14Lam7l45Gqem6dzR0FZIdgCZyk2MU
	NUe+gqyipiehyn97X0vVJRSX+CSpjza94OF6umP1GNeZMi3KwNaho=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 180433DEA6;
	Fri, 31 May 2024 18:28:09 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2EFD83DEA5;
	Fri, 31 May 2024 18:28:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 06/13] dir.c: always copy input to add_pattern()
In-Reply-To: <20240531113127.GF428814@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 31 May 2024 07:31:27 -0400")
References: <20240531112433.GA428583@coredump.intra.peff.net>
	<20240531113127.GF428814@coredump.intra.peff.net>
Date: Fri, 31 May 2024 15:28:04 -0700
Message-ID: <xmqq1q5hehvv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0D1C57C2-1F9D-11EF-8ECE-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

>   b. Now that we don't need the original string to hang around, we can
>      get rid of the "filebuf" mechanism entirely, and just free the file
>      contents after parsing. Since files are the sources we'd expect to
>      have the largest pattern sets, we should mostly break even on
>      stuffing the same data into the individual structs.

;-).

> diff --git a/dir.c b/dir.c
> index d812d521b0..8308d167c8 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -925,12 +925,7 @@ void add_pattern(const char *string, const char *base,
>  	int nowildcardlen;
>  
>  	parse_path_pattern(&string, &patternlen, &flags, &nowildcardlen);
> -	if (flags & PATTERN_FLAG_MUSTBEDIR) {
> -		FLEXPTR_ALLOC_MEM(pattern, pattern, string, patternlen);
> -	} else {
> -		pattern = xmalloc(sizeof(*pattern));
> -		pattern->pattern = string;
> -	}
> +	FLEX_ALLOC_MEM(pattern, pattern, string, patternlen);
>  	pattern->patternlen = patternlen;
>  	pattern->nowildcardlen = nowildcardlen;
>  	pattern->base = base;

Nice simplification.

> diff --git a/dir.h b/dir.h
> index b9e8e96128..c8ff308fae 100644
> --- a/dir.h
> +++ b/dir.h
> @@ -62,7 +62,6 @@ struct path_pattern {
>  	 */
>  	struct pattern_list *pl;
>  
> -	const char *pattern;
>  	int patternlen;
>  	int nowildcardlen;
>  	const char *base;
> @@ -74,6 +73,8 @@ struct path_pattern {
>  	 * and from -1 decrementing for patterns from CLI args.
>  	 */
>  	int srcpos;
> +
> +	char pattern[FLEX_ARRAY];
>  };

OK.  Looking good.

Thanks.
