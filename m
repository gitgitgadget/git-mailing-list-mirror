Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C532A271471
	for <git@vger.kernel.org>; Tue, 12 May 2026 19:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778612468; cv=none; b=R7ZDGK0I8xO/pLDTZsCs2QmA6eZjXwubvDvRCLJ3uOnSlQpV1BFPbnWgxl4nz8TPLZZNixWgM6PpE/xosGTzFg/5sJPlrKwlRRdmZkvlIHuVGyC77d1gpjBiyXj5TUv03MeYAx98GPJT93Ecewus8m4+7KkLlMJvppx64xkxtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778612468; c=relaxed/simple;
	bh=hDc/R+q3EU1O1EgZbrfgTwhynfroz/qkZC4xU+HrGk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrnYJAcXQd9MRTHpoXd7OqfMSbZJwBT3zH4nZXDb0OAF6/CZoPmFi/N0780gp1gjYLulw/k9cA7OjBNR/7GLK/9hL00DJEGoGK+vPrdfIp5RtY1K34yFbtn+mkEh5RCq/aD9zxWeoUvQ0L71PWIgbJVY+rXWQy5H+p438Zr5/M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TTu4WqqJ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TTu4WqqJ"
Received: (qmail 29027 invoked by uid 106); 12 May 2026 19:01:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=hDc/R+q3EU1O1EgZbrfgTwhynfroz/qkZC4xU+HrGk4=; b=TTu4WqqJWZowqu9ucqZj6IbZNFwc7hPUhbMJaaEFSBPetDnkYicrKhTghWQr2Bej+JDZREUekMo5XMFjjLhIbml4xDK4QUU8BrrW92t6fVLLUNERfaPciDJPZvH2Nvh6M4gVcMSuhKGk9XRGvff2qDxogYj5cy6zJ3iuiwzqdXitGdqDaLLu+b2HFzjXkT5k0Mu6uZbe7xKdlUwypuTo3Uo6nDo3/Ma2hHgqc1WjB3PLnuZfeeFkAsRInznn/TDreDhcRRc0/hia6dIDQ4PsckzSJmo3hvSnXuTtovMLRhI5AAuCyEsVQqRZKVO6Z3Ube1vMpMk0vo+9Ad7fjNLpNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 May 2026 19:01:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 52667 invoked by uid 111); 12 May 2026 19:01:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 May 2026 15:01:05 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 12 May 2026 15:01:05 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] ls-files: use strbuf_add_uint()
Message-ID: <20260512190105.GE70851@coredump.intra.peff.net>
References: <20260512115603.80780-1-l.s.r@web.de>
 <20260512115603.80780-4-l.s.r@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260512115603.80780-4-l.s.r@web.de>

On Tue, May 12, 2026 at 01:56:02PM +0200, René Scharfe wrote:

> Speed up printing of objectsize values by using the specialized function
> strbuf_add_uint() as well as strbuf_insert() for padding instead of the
> general-purpose function strbuf_addf().  Here are the numbers I get when
> listing files in the Linux kernel repo:
> 
> Benchmark 1: ./git_main -C ../linux ls-files --format='%(objectsize)'
>   Time (mean ± σ):     257.3 ms ±   0.4 ms    [User: 197.4 ms, System: 56.7 ms]
>   Range (min … max):   256.7 ms … 258.1 ms    11 runs
> 
> Benchmark 2: ./git -C ../linux ls-files --format='%(objectsize)'
>   Time (mean ± σ):     253.4 ms ±   0.3 ms    [User: 193.6 ms, System: 56.6 ms]
>   Range (min … max):   253.0 ms … 253.8 ms    11 runs

OK, so here the improvement is less impressive than the previous commit.
And the code is...

>  {
> +	static const char padding[] = "       ";
> +	size_t min_len = padded ? strlen(padding) : 0;
> +	size_t orig_len = line->len;
> +	size_t len;
> +
>  	if (type == OBJ_BLOB) {
>  		unsigned long size;
>  		if (odb_read_object_info(repo->objects, oid, &size) < 0)
>  			die(_("could not get object info about '%s'"),
>  			    oid_to_hex(oid));
> -		if (padded)
> -			strbuf_addf(line, "%7"PRIuMAX, (uintmax_t)size);
> -		else
> -			strbuf_addf(line, "%"PRIuMAX, (uintmax_t)size);
> -	} else if (padded) {
> -		strbuf_addf(line, "%7s", "-");
> +		strbuf_add_uint(line, size);
>  	} else {
>  		strbuf_addstr(line, "-");
>  	}
> +	len = line->len - orig_len;
> +	if (len < min_len)
> +		strbuf_insert(line, orig_len, padding, min_len - len);
>  }

...also less nice. We are formatting into the strbuf, and then maybe
memmove()-ing the result to accommodate padding. I wonder how much that
affects the timing. It's extra shuffling, but memmove() etc is often
surprisingly fast.

I wonder how bad it would be to handle the padding ahead of time.
Obviously strbuf_add_uint() knows the size of the result right before it
calls memcpy(), and it could insert the padding then. But adding a
padding length parameter (let alone the space vs "0" decision) to that
function feels kind of gross.

In the earlier patch I raised the notion of pre-computing the output
length. If we had a helper to do that, it would be pretty easy to do:

  /* noop if third parameter is negative */
  strbuf_pad(line, ' ', 7 - decimal_digits(size));
  strbuf_add_uint(line, size);

You could also imagine a world where we had some stateful formatting
system, and you could say:

  strbuf_pad_next(line, ' ', 7);
  strbuf_add_uint(line, size);

but somebody has to store that state between the calls, and I don't love
the idea of bloating strbuf with it. So probably you have some
"formatter" struct, and it operates on a strbuf. And now we have all of
the OO boilerplate hassles like initializing and tearing down our
formatter object. ;) So probably not worth it for this triviality.
Having it all in one string ("%7d") is nice and concise.

I have often wondered how hard it would be to implement our own
vsnprintf(), and whether we could do better than the libc ones. It would
be nice to be able to add shorthands for common types (instead of the
unreadable PRIuMAX mess), as well as custom ones (e.g., hex oids).

Probably also not worth the headache. ;)

-Peff
