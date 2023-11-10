Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AFA4C8E
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 06:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HOpmRJ4i"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085E85240
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 22:13:54 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id F207D27913;
	Thu,  9 Nov 2023 23:55:52 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HgZjYL7qE2Za28mX+xWQeDLX1kniRHF2otwvJk
	YDVt8=; b=HOpmRJ4iaibekPRTK2PCHxGpBER2uXNNWTlAAZcvG+vN9GTLPXyRsO
	zT/f0sYV9vyyycObaWbvtlU2dadq2cS8XfEutfMYuy0gGCbYvdJINm/xtNNK47Vy
	V7feVZwz+EL1ynNaQSHCx6YfxC4cY+vZjZ3qDtJwJkdk46KTsH4Xc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id EA31427912;
	Thu,  9 Nov 2023 23:55:52 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8762D2790A;
	Thu,  9 Nov 2023 23:55:49 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
In-Reply-To: <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
	(Taylor Blau's message of "Thu, 9 Nov 2023 17:34:11 -0500")
References: <20231109070310.GA2697602@coredump.intra.peff.net>
	<cover.1699569246.git.me@ttaylorr.com>
	<af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
Date: Fri, 10 Nov 2023 13:55:48 +0900
Message-ID: <xmqqedgyw6jv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 6AE2BD6E-7F85-11EE-823D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> +static int pair_chunk_expect_fn(const unsigned char *chunk_start,
> +				size_t chunk_size,
> +				void *data)
> +{
> +	struct pair_chunk_data *pcd = data;
> +	if (chunk_size / pcd->record_size != pcd->record_nr)
> +		return -1;
> +	*pcd->p = chunk_start;
> +	return 0;
> +}

I know one of the original places did the "divide the whole by
per-record size and see if it matches the number of records", the
same as we see above, but the check in the above could also be

	if (chunk_size != st_mult(pcd->record_size, pcd->record_nr))
		return -1;

which would also catch the case where chunk_size is not a multiple
of the record size.  Your conversion of OOFF in midx.c loses this
protection as the original uses the multiplication-and-compare, but
the rewrite to call pair_chunk_expect would call the above and
checks with the truncating-divide-and-compare.

Does the distinction matter?  I dunno.  If the record/chunk
alignment is asserted elsewhere, then the distinction should not
matter, but even if it were, seeing a truncating division used in
any validation makes my skin tingle.

Other than that, the series was a pleasant read.

Thanks.


