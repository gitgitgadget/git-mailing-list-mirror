Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531AC5914D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 20:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712089635; cv=none; b=GiNE8O+NP2vx0ooJiqcrrjVEX829itmrPddMr0p8kGCQIr4gWZbhyJm5RDIrJ4b2FYhSuEh43VXuKAjCTO/Xaq7C5vc1yDe+4V8mu/RKCDBMR5zu1pUJAzlcHsefJAdmAWGDYuPFhLkh7ds3ToeHqm6tNmyovheyfCcHSGJvZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712089635; c=relaxed/simple;
	bh=t22fst+/2C0kQIS3ttV8IJaN3GWiRh3qIlCnaNSwvI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AnecIbIIowSqCdSlQB/41gvGLinxaPIFDqDgioxYHlLPep9F5y2IpybYukwRzvzLf2r5EXj34NEjXNAjyq6XcIa5wBOjYDV5dsp4hk2Xv6zHzUMUX1qObik7Ls6/EueDKCy6dAkhlgCPI+dIddZth23LkkbmjV2LPcKFv9bhLw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=h83mFk6j; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="h83mFk6j"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id BE9622B66D;
	Tue,  2 Apr 2024 16:27:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=t22fst+/2C0kQIS3ttV8IJaN3GWiRh3qIlCnaN
	SwvI4=; b=h83mFk6jHphvVBY1NhbShXjAOlEccmtY0B13oVGcOIXf26i8Lp4Ck2
	X99uxDiFeakMVSTdj9HFeIWkN7qjm/8JRxJaoRndGj1lWBMI4GlQQHyVK9IKxBns
	ZEJKHVhQ3TCNyl5ZfNowEx44g1Xie7ynPEo/jh0iS8lCdmM8zl3sY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B6F982B66C;
	Tue,  2 Apr 2024 16:27:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 43FCA2B66B;
	Tue,  2 Apr 2024 16:27:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org,  Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH 1/2] http: reset POSTFIELDSIZE when clearing curl handle
In-Reply-To: <20240402200517.GA875182@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 2 Apr 2024 16:05:17 -0400")
References: <20240402200254.GA874754@coredump.intra.peff.net>
	<20240402200517.GA875182@coredump.intra.peff.net>
Date: Tue, 02 Apr 2024 13:27:08 -0700
Message-ID: <xmqqcyr74ijn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 61E0BA6A-F12F-11EE-B0FC-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> In get_active_slot(), we return a CURL handle that may have been used
> before (reusing them is good because it lets curl reuse the same
> connection across many requests). We set a few curl options back to
> defaults that may have been modified by previous requests.
>
> We reset POSTFIELDS to NULL, but do not reset POSTFIELDSIZE (which
> defaults to "-1"). This usually doesn't matter because most POSTs will
> set both fields together anyway. But there is one exception: when
> handling a large request in remote-curl's post_rpc(), we don't set
> _either_, and instead set a READFUNCTION to stream data into libcurl.
>
> This can interact weirdly with a stale POSTFIELDSIZE setting, because
> curl will assume it should read only some set number of bytes from our
> READFUNCTION. However, it has worked in practice because we also
> manually set a "Transfer-Encoding: chunked" header, which libcurl uses
> as a clue to set the POSTFIELDSIZE to -1 itself.
>
> So everything works, but we're better off resetting the size manually
> for a few reasons:
>
>   - there was a regression in curl 8.7.0 where the chunked header
>     detection didn't kick in, causing any large HTTP requests made by
>     Git to fail. This has since been fixed (but not yet released). In
>     the issue, curl folks recommended setting it explicitly to -1:
>
>       https://github.com/curl/curl/issues/13229#issuecomment-2029826058
>
>     and it indeed works around the regression. So even though it won't
>     be strictly necessary after the fix there, this will help folks who
>     end up using the affected libcurl versions.
>
>   - it's consistent with what a new curl handle would look like. Since
>     get_active_slot() may or may not return a used handle, this reduces
>     the possibility of heisenbugs that only appear with certain request
>     patterns.
>
> Note that the recommendation in the curl issue is to actually drop the
> manual Transfer-Encoding header. Modern libcurl will add the header
> itself when streaming from a READFUNCTION. However, that code wasn't
> added until 802aa5ae2 (HTTP: use chunked Transfer-Encoding for HTTP_POST
> if size unknown, 2019-07-22), which is in curl 7.66.0. We claim to
> support back to 7.19.5, so those older versions still need the manual
> header.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  http.c | 1 +
>  1 file changed, 1 insertion(+)

As always, well articulated.  Thanks.  Will queue.

> diff --git a/http.c b/http.c
> index e73b136e58..3d80bd6116 100644
> --- a/http.c
> +++ b/http.c
> @@ -1452,6 +1452,7 @@ struct active_request_slot *get_active_slot(void)
>  	curl_easy_setopt(slot->curl, CURLOPT_READFUNCTION, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_WRITEFUNCTION, NULL);
>  	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDS, NULL);
> +	curl_easy_setopt(slot->curl, CURLOPT_POSTFIELDSIZE, -1L);
>  	curl_easy_setopt(slot->curl, CURLOPT_UPLOAD, 0);
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
>  	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
