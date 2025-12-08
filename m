Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EA941A9F91
	for <git@vger.kernel.org>; Mon,  8 Dec 2025 20:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765225140; cv=none; b=NKMjQi4wL4NmVDnYbnI1VXvcgnkMJUsIQKpAdoa9mWSIsOxZgJGNmpjEQIPXvl59HjPq+fydRhCVhchJP9f6/H6vqmwUKMGTqE9gahCKEL3woF+UUcmsCqz79T7+VjVv+knrXoJ1vudD/SPSMbelhH59VE4Q9wWi9f2s8Td07g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765225140; c=relaxed/simple;
	bh=LkhfYouPKncYkwa8h1e71KyYjL+7hxbzmEOsRxmBaB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxdN5QymF5ttl3zoOrBe19T7sWKGWfyFWyCA7mMSuXKa5HcE8jHQa4LHiwhx7pmAnldVHwJm/+3HHm+6locZJi6YXg5LmFRNZ8MTRZXd6ksZH+8WUClCcohgyBqhcvfLyuqZ6alKnJ41OOq1kuPIc0tlb5s15P2zCr89a6E1gYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dqS7VN3f; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dqS7VN3f"
Received: (qmail 305595 invoked by uid 109); 8 Dec 2025 20:18:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=LkhfYouPKncYkwa8h1e71KyYjL+7hxbzmEOsRxmBaB0=; b=dqS7VN3fGuEW3RNtbSrt7qlax4X+t1g2JwMuIbh9t1KD9er3hsNmCM3rUZxLByKf/4hmgdDiEEAd3W/gCIst6M+FSTG9RjfDHQf0tjlDXfE1JaLjvQaIgX2nfI93gkiqX9y1BoJAp7O/RZuusR5i9Da8yNnSLO6rZ3WN/xicK0j1md9bwwgJIcNapKmY33QvwBkrKpT12SYA4/d4an94k6ers6ZMGKFDz+k7Rg+dPAvhvB/JenL4AN/9B1eFLWgJFLTruTu8VC05vX2G1p3fceBsaSsa+rc5fwfxwlbrinhnLsI/0mKVurPmdsyqAMVAGMC2c/Az6/6EEGmi7KhyMw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Dec 2025 20:18:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 389895 invoked by uid 111); 8 Dec 2025 20:18:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 08 Dec 2025 15:18:59 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 8 Dec 2025 15:18:56 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connect: plug protocol capability leak
Message-ID: <20251208201856.GB216526@coredump.intra.peff.net>
References: <xmqqfr9mnbu9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfr9mnbu9.fsf@gitster.g>

On Sun, Dec 07, 2025 at 01:40:46PM +0900, Junio C Hamano wrote:

> diff --git a/connect.c b/connect.c
> index 8352b71faf..c6f76e3082 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -240,6 +240,8 @@ static void process_capabilities(struct packet_reader *reader, size_t *linelen)
>  	size_t nul_location = strlen(line);
>  	if (nul_location == *linelen)
>  		return;
> +
> +	free(server_capabilities_v1);
>  	server_capabilities_v1 = xstrdup(line + nul_location + 1);
>  	*linelen = nul_location;
>  

The fix looks obviously correct.

I couldn't help but notice that "v1" here is a little confusing, as it
is really "v0". Or I guess if you want to be pedantic, "v1" is v0 with
the extra useless version string probe that nobody actually sends. So it
technically is also the v1 capabilities string, but I think v0 is more
descriptive.

Anyway, way off the topic of your patch, and maybe not even worth fixing
independently. I removed a couple of confusing "v1 protocol" mentions in
the test suite, but I don't know if this one would actually bother
anyone.

-Peff
