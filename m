Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7842936682D
	for <git@vger.kernel.org>; Mon, 23 Feb 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771851599; cv=none; b=QxpOE4u64sEzReHrPx+57emIzX+qUGn9VT7YRWGia4UfG6Qyk9yZmW4OIl2o9ryUu7TrfgkoMNvtimbtH9+MEr9HLMq+820oiuQlWkcFJb72KirFRbREvr8NRuzEGf5H2v52ygNF+vaone7lgCj69/NpDRbMRNRMDbGW0m+QqQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771851599; c=relaxed/simple;
	bh=POM/ebFiZ70nc1n983+053p+kcY54rVsadnyzAFoZ4U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SVwo4lYu6LYPrOPD0gfi1Y9oM2aJzzpLD25o3wB9MqQjn0iBWBa0scgP+bHatDCCWEkNCUlpKY1xhBclUmyqgYuDzRfgl6eUxIlx1xEkGyX5U5dByk943kLspPhBMgeInDJs/Eq1uA/R4aBN9hJ2C/lA7ax90K5l+aQQNZeJ8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eSZm4o3Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eSZm4o3Z"
Received: (qmail 54048 invoked by uid 109); 23 Feb 2026 12:59:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=POM/ebFiZ70nc1n983+053p+kcY54rVsadnyzAFoZ4U=; b=eSZm4o3Z4YcSqdjwMYrFk8imZk4j8o4s6vNo9YcFRu8VvCwI1wmOe+TkGJO9DktlcciXstm3wMsZxCOstK3RAybvzS0MdZHNixc36CBgmlClYKLu91R5k+mypuxx4EQ9G8Es9rBpApHqVQ2xduzaTFfLU0z5dSw9/iXHG2R3moV+r507p5al7dGdXZizY7/ZWzNrS19W4YYJTVicXe9eJ5X2wjThBx/mWBPlUrBOOvdGBsQE61WZKxVuQSHJIbz/Gr5U97DBZUgeLFw4QIIImMnzwgzyjgXcp317Gd4AnCWovIyD8enKFxB9N711unL+MHkXHkXcZOBdv0Kk2kNx6Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Feb 2026 12:59:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 104171 invoked by uid 111); 23 Feb 2026 12:59:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Feb 2026 07:59:56 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Feb 2026 07:59:55 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/4] object-file: adapt `stream_object_signature()` to
 take a stream
Message-ID: <20260223125955.GB215671@coredump.intra.peff.net>
References: <20260223-pks-fsck-fix-v1-0-c29036832b6e@pks.im>
 <20260223-pks-fsck-fix-v1-2-c29036832b6e@pks.im>
 <20260223104915.GA215364@coredump.intra.peff.net>
 <aZxGLKycnZcVoXPt@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZxGLKycnZcVoXPt@pks.im>

On Mon, Feb 23, 2026 at 01:21:00PM +0100, Patrick Steinhardt wrote:

> > That matches the existing code (since it all happened in a
> > single function), but should we take this opportunity to give more
> > accurate error messages? I.e., to do:
> > 
> >   if (!stream) {
> > 	error(_("unable to open object stream for %s"), oid_to_hex(oid));
> > 	return NULL;
> >   }
> >   if (stream_object_signature(r, stream, repl) < 0) {
> > 	error(_("hash mismatch %s"), oid_to_hex(oid));
> > 	odb_read_stream_close(stream);
> > 	return NULL;
> >   }
> >   odb_read_stream_close(stream);
> > 
> > I dunno. It should be quite uncommon to see either of these messages,
> > but that is sometimes the moment when details are most important.
> 
> Agreed, that feels like a sensible change indeed. Also makes the code
> flow easier to follow in my opinion.

Yeah, the readability was actually what got me thinking on it in the
first place.

> > Also, as an aside, I found it curious that we still need to pass the
> > repository struct to stream_object_signature(). That's because it needs
> > to know the correct hash_algo. I wondered if the stream struct itself
> > might know about that, but it doesn't seem to (it doesn't know anything
> > about where it came from). So it's unavoidable that we'd need to retain
> > it.
> 
> Yeah, agreed. I wondered whether we should eventually extend `struct
> odb_read_stream` to have a pointer to the owning object source, and in
> that case we could've avoided the extra repository parameter. But I
> decided it was out of scope for this patch series, also because I don't
> want to cause conflicts with other stuff I'm working on in this vicinity
> :)

Yes, definitely out of scope for this series.

-Peff
