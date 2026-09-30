Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1BC93A75BD
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 22:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790808615; cv=none; b=Zg3xqmHevXfSVHuBfyOunN72M/G9q3oJdppEWH1bn8hW+Jc8mH5MMwbQRop8XMN9FU5SI3U2aGQg7VHIrq4RGbmgzAIztmgMq3Z+KhN07PXXreVfzTK5sdxBBlIzJWh0Fg9oMNXep2wE2XXmuohToDyyxQhYcH9WXZ9oYoVSas0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790808615; c=relaxed/simple;
	bh=nItGHPK6flH5eRDf1ABLfDd6jNQfLRQn7VLps8RrHHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FbCbg7Jdc0sKQRphXg+Nkf+BjJGehXCozA6FKv00NQEoOaMP9iDlNnf9ZjXv1wtDL7+MYc5vV/xKZ6HH+hTNcHgetUHnS8Yl0AH9TWP9Hm/99oTQTUfbk729tVHoROSpIqu6kPU/U7HvYytkFEFqEy7fRqHhEzfNZlwVl7NCwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=C09bx5Pb; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="C09bx5Pb"
Received: (qmail 7972 invoked by uid 106); 30 Sep 2026 22:50:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nItGHPK6flH5eRDf1ABLfDd6jNQfLRQn7VLps8RrHHY=; b=C09bx5Pb4O+TeBpeI0Fm1Q09vVbPuDMDj4AhyAwriitQiqBEdgxJSei8Y9LipLrNBbZNQtTezUPf2vJN6dFwVW86LAfqhARtD+IFML5lJMNG/kc62MDKk7gEydDQQEPN8nPDrsY8Y+a/kSW442xKTiCrJRKFyy8RyCpJKzNUz0KnDijInCqqpZAN1mG05saWu7Zg9Sy8R1QM1jQphWT90sZm0vXYa7oQbUlunSJ66RX6F/D5N0WA1211vDMwgkMXh4fy7P6C4gC6riwKC9XAJrKcwwQrNYMa+4grjvNMsqGejZhuS/eRli1iqBneavYTklhUy3j08+0SPiBKBpZGUA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 30 Sep 2026 22:50:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20109 invoked by uid 111); 30 Sep 2026 22:50:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 30 Sep 2026 18:50:14 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 30 Sep 2026 18:50:11 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge-ll: use read_mmfile() to read external merge
 results
Message-ID: <20260930225011.GC765052@coredump.intra.peff.net>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065442.GD1697497@coredump.intra.peff.net>
 <ar0rrVE0ZxcU7uG-@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ar0rrVE0ZxcU7uG-@pks.im>

On Wed, Sep 30, 2026 at 05:33:01PM +0200, Patrick Steinhardt wrote:

> So we do lose the NUL-termination that `xmallocz()` gave us, as
> `read_mmfile()` doesn't do that. You reinstate that in the last patch
> though, which makes me lean more into the direction of having that last
> optional patch. If so though, we may want to reorder it to come first.

Yeah, I'll do that re-order.

> > -	if (read_in_full(fd, result->ptr, result->size) != result->size) {
> > -		FREE_AND_NULL(result->ptr);
> > -		result->size = 0;
> > -	}
> > - close_bad:
> > -	close(fd);
> > - bad:
> > +
> > +	/* We can ignore errors; result is left NULL/0 in that case. */
> > +	read_mmfile(result, temp[1]);
> 
> One change in behaviour that wasn't called out is that this will now
> make us write an error message in case we failed reading the file. That
> could be a good change, but that's hard to say.

True, I hadn't even thought about that. It seems like a strict
improvement to me, but I'll mention it in the commit message.

-Peff
