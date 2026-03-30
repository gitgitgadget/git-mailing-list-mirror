Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7AD3EBF1F
	for <git@vger.kernel.org>; Mon, 30 Mar 2026 22:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774910343; cv=none; b=h+Mk7bqazkdRvc+0ymtSEUO+q6+pWYk2QCukedGNnnb5dNhp7w8s8ZlerHtXyN+OGFby54fAMwynoBYBShZV9B3zhWjfhSX8b88nqkyPHI/RojnUVDisGzLvbhHJZI2fYx48BGw1V/XbaoH6YCot3HH73vTjT4LLX9VibrJeIHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774910343; c=relaxed/simple;
	bh=ir3KA6Zuq8Z3pqcdgECkSrr7she4ny4TPrOQvrSovtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aWCVsVjtDrL01dUtyx+qZbgtg74g6tzKZwVsmN93CZF1Vd9/+iIhsvYeKp4A+DfCdtwTqk4YiFHG4KgMw/mqI2CQBhlaSGYeBUBkqJYBS8wwtK/8jXx7S3reLJ5ouTV5a3UbNB13o9/Kwsn5DW8v5FvEEmb+DwLY4IiSpNq3qn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=K8xH8AiI; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="K8xH8AiI"
Received: (qmail 199149 invoked by uid 106); 30 Mar 2026 22:38:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ir3KA6Zuq8Z3pqcdgECkSrr7she4ny4TPrOQvrSovtk=; b=K8xH8AiIPYHAeyNvepev/pXAJyZp9UgRfmi4LiQiv8xU+H6HD6UB4m8q4fjBWrXhNM7AJowXE/tlG3GE16Ec3ik7rMjEOTW6I+wD6pzsFVedWb1kt7m33xP04v1Kc5xak5Xp9i25RDTPzuRcHEu8TFb+HZEB/xTiDLS2BLALxmoDMWCO5qZ1tvT8TgAQOEqPFOY+06TK/OrecG5nDBkUbvdRV8MY5PsvlbzfIwlvT3gMA25Wnqyf+0NtikWDUs7/C+KWEt1oDAAfSY1Gj10Iz3fFh3nBGfI/Vlavg+sHUilgqI4r5VHBR03uTUDQEW0fJ1xw2YvZb0XEQh3c5KeXIA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 30 Mar 2026 22:38:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 305958 invoked by uid 111); 30 Mar 2026 22:38:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 30 Mar 2026 18:38:50 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 30 Mar 2026 18:38:49 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 02/16] midx: use `string_list` for retained MIDX files
Message-ID: <20260330223849.GB41843@coredump.intra.peff.net>
References: <cover.1774820449.git.me@ttaylorr.com>
 <1391552dfc6624374bed89b25d1892d9b9d080f9.1774820449.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1391552dfc6624374bed89b25d1892d9b9d080f9.1774820449.git.me@ttaylorr.com>

On Sun, Mar 29, 2026 at 05:40:55PM -0400, Taylor Blau wrote:

> @@ -767,15 +766,12 @@ static void clear_midx_file_ext(const char *full_path, size_t full_path_len UNUS
>  				const char *file_name, void *_data)
>  {
>  	struct clear_midx_data *data = _data;
> -	uint32_t i;
>  
>  	if (!(starts_with(file_name, "multi-pack-index-") &&
>  	      ends_with(file_name, data->ext)))
>  		return;
> -	for (i = 0; i < data->keep_nr; i++) {
> -		if (!strcmp(data->keep[i], file_name))
> -			return;
> -	}
> +	if (string_list_has_string(&data->keep, file_name))
> +		return;

We are using has_string() here, so &data->keep will need to be sorted
(just keeping it in mind as we read further).

>  	if (keep_hash) {
> -		ALLOC_ARRAY(data.keep, 1);
> +		struct strbuf buf = STRBUF_INIT;
> +		strbuf_addf(&buf, "multi-pack-index-%s.%s", keep_hash, ext);
>  
> -		data.keep[0] = xstrfmt("multi-pack-index-%s.%s", keep_hash, ext);
> -		data.keep_nr = 1;
> +		string_list_insert(&data.keep, buf.buf);

OK, we use insert() here. But there is no difference between insert and
append, since the list only has one element. It is sorted either way. ;)

And we do not have to worry about being accidentally-quadratic because
there is no loop.

> -	ALLOC_ARRAY(data.keep, hashes_nr);
>  	for (i = 0; i < hashes_nr; i++)
> -		data.keep[i] = xstrfmt("multi-pack-index-%s.%s", keep_hashes[i],
> -				       ext);
> -	data.keep_nr = hashes_nr;
> -	data.ext = ext;
> +		string_list_append(&data.keep,
> +				   xstrfmt("multi-pack-index-%s.%s",
> +					   keep_hashes[i], ext));
> +	string_list_sort(&data.keep);

OK, and here we really do have a list, but we do append+sort to avoid
being quadratic. Good.

Since AFAICT we only care about set inclusion, I probably would have
used a strset instead, but for the numbers we are talking about it is
unlikely to matter much either way.

So looking good.

-Peff
