Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE51221472
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 19:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733427286; cv=none; b=c9jz4oAmnSj0TxcXvR71yw+NHUWs7S1G2xCTcD4TGs9BSviO66HdTybF2foe/+WGEcnI8ZAnfOtA0qlmNMS7ZmuvH/j5aN1SkZpiY9JLG8vLLZAJDKjIZf7Fknl1Oa5E0zCOwKxjjynYZvcQGNa9+UsNy4KWdAx0FFzozzeIHt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733427286; c=relaxed/simple;
	bh=f+K6r9FchpmYSOxsL3GHlbTg0ZNjGp6u0sJce5FXLGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AUIwnv6PwCfJN0GejaWk8VrkzQKynJZv+jUL+mdBvAHFteJ1C+g89jxuxvAEIvTxzGf2Zz5Z4/Jv70Pa7sPl+iN4jjmx1SXWLZWXdHUWrQEP3NaWeeCQCdjka9zVGCMGA1dt8bgr3PkIKfWLi4nA9CTqTsMHmOqLkIuMDWVQ8rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Im3dPg8k; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Im3dPg8k"
Received: (qmail 31436 invoked by uid 109); 5 Dec 2024 19:34:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f+K6r9FchpmYSOxsL3GHlbTg0ZNjGp6u0sJce5FXLGA=; b=Im3dPg8kwyPf0axm/WcUcRQrPC/HkSaN1YKAIhsj1jwQXlQ6o+Eqp0jnpqoK+EViNhI4FtaqKSG1UI1SGaBGZ4YPZIOSHqxFu29FAiAKHGEMnh/KWqfaMY44gx46lnHWY541QeclLFrJGjn0fn94Pn0WeldFHkmiA1A4ClHm6Dcp7KdVLILhe3HhChI0M7dLH2rnXnOPwbtzbY/ujnjIBa+lpwedWrJwtriYmde8iATFHPyxYFjPdXtBck6WiB8BAQia2Q5WS93Lnl+LQ8Aas4Op+yPf+5aerwBU4J+hittkiIDzn+tNRY7wCnPBCSKqPuwJFodvkVXb4GNn1x3tXg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Dec 2024 19:34:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9210 invoked by uid 111); 5 Dec 2024 19:34:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Dec 2024 14:34:39 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Dec 2024 14:34:39 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/15] sign-compare: 32-bit support
Message-ID: <20241205193439.GC2629822@coredump.intra.peff.net>
References: <20241205-pks-sign-compare-v3-0-e211ee089717@pks.im>
 <20241205-pks-sign-compare-v3-7-e211ee089717@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241205-pks-sign-compare-v3-7-e211ee089717@pks.im>

On Thu, Dec 05, 2024 at 10:36:29AM +0100, Patrick Steinhardt wrote:

> @@ -24,7 +23,7 @@ static void verify_buffer_or_die(struct hashfile *f,
>  
>  	if (ret < 0)
>  		die_errno("%s: sha1 file read error", f->name);
> -	if (ret != count)
> +	if ((size_t)ret != (size_t)count)
>  		die("%s: sha1 file truncated", f->name);

You really only need the cast on the left-hand side here. "count" is
already an unsigned value (and will get promoted as necessary on a
system where "unsigned int" is smaller than "size_t").

It's probably not hurting too much, but my philosophy is that we should
do as few casts as strictly necessary. Casts are a blunt instrument for
telling the compiler we know what we are doing, and can cover up issues
(in this case a false positive, but imagine "count" was switched to
"int").

IMHO "count" should probably be a size_t here anyway, since we are
dealing with a buffer size. If you look at the call stack, it is based
on hashfile.buffer, which we'd expect to be small. But it is initialized
from a size_t, so really it is one errant hashfd_internal() from being a
truncation bug. That's not a mistake I expect to be likely, but I think
we are better off in general making code as obviously/trivially correct
as possible.

I think truncation is getting out of scope for your series, though, so
probably not worth doing right at this moment.

> diff --git a/pkt-line.c b/pkt-line.c
> index 90ea2b6974b1d0957cfdc5e2f9a2c30720723f12..f48b558ad23dd99f334d2d60e954ce9a83ac6114 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -363,7 +363,7 @@ static int get_packet_data(int fd, char **src_buf, size_t *src_size,
>  	}
>  
>  	/* And complain if we didn't get enough bytes to satisfy the read. */
> -	if (ret != size) {
> +	if ((size_t)ret != (size_t)size) {
>  		if (options & PACKET_READ_GENTLE_ON_EOF)
>  			return -1;

Likewise here, "size" is already unsigned.


I also wondered if there was a safer solution than a bare cast here.
Both of these are OK because the lines immediately before them checked
for the negative value, but there's nothing at the compiler level to
enforce that.

I guess a solution that uses the type system would be akin to Option
from Rust, et al. A helper that checks for negative values and also
promotes to an unsigned type, like:

  ssize_t ret = read_in_full(fd, buf, count);
  size_t bytes_read;

  if (!signed_to_unsigned(ret, &bytes_read))
	die_errno(...); /* error */
  if (bytes_read != count)
        ...

I don't know if there's a more ergonomic way that ditches the extra
variable. Or if there are enough cases like this to merit having a
helper.

-Peff
