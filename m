Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F99011711
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 04:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721104653; cv=none; b=NjdIFDTOIVu7woGeH1GTFmumNyvCX6OYt7+DPelRCv+ZWAO1NZacuzM4N19ztz8mSNn6nWGRJ5R0N3TJ/7vN8LFWd3f8gXEalLVsjWJJ9WiDKIDHTxluLZZsKvKAYv2D7Wc35yNn6e5wcJ2QHETOzPEaiRZ8pHDdiimx5j3cgYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721104653; c=relaxed/simple;
	bh=MlhdZP82XcZHykJdaICpL+813RP9qmkovkwrn74S8PM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I0NJjMUSlAUGTR2ejLS319xnF/g8SmoUSw1U5l0XsTiDhUQcFyvbI50c0z5UFRdbA5rmq7+FZ4AgghdCm4jYf+TJaJ3XUXkV8wMhoJEsDoFlTpWCj8v+P3DKdVUJGMmqmBV2/HkGHO+WHT/Rw4I+68Rcl5ASCdTD2iA0rk8Kq6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 12337 invoked by uid 109); 16 Jul 2024 04:37:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jul 2024 04:37:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6189 invoked by uid 111); 16 Jul 2024 04:37:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jul 2024 00:37:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jul 2024 00:37:27 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
	Patrick Steinhardt <ps@pks.im>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3] t-strvec: improve check_strvec() output
Message-ID: <20240716043727.GA1429885@coredump.intra.peff.net>
References: <35b0ba6b-d485-44f2-a19f-3ce816f8b435@web.de>
 <5bbef273-382e-4096-9ca6-d74781223e55@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5bbef273-382e-4096-9ca6-d74781223e55@web.de>

On Sun, Jul 14, 2024 at 12:17:53PM +0200, René Scharfe wrote:

> +	do { \
> +		const char *expect[] = { __VA_ARGS__ }; \
> +		if (check_uint(ARRAY_SIZE(expect), >, 0) && \
> +		    check_pointer_eq(expect[ARRAY_SIZE(expect) - 1], NULL) && \
> +		    check_uint((vec)->nr, ==, ARRAY_SIZE(expect) - 1) && \
> +		    check_uint((vec)->nr, <=, (vec)->alloc)) { \
> +			for (size_t i = 0; i < ARRAY_SIZE(expect); i++) { \
> +				if (!check_str((vec)->v[i], expect[i])) { \
> +					test_msg("      i: %"PRIuMAX, i); \
> +					break; \
> +				} \
> +			} \
> +		} \
> +	} while (0)

The linux32 CI job seems to complain about this, since the concrete type
of "i" (a size_t) is "unsigned int" there, but PRIuMAX is %llu.
Presumably you just need to cast to uintmax_t.

-Peff
