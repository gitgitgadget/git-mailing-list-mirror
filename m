Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9A101F2
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728236441; cv=none; b=iiWVJuyyXtiq4eQigfkBVxzKddLGCcL5ab77ZekNznKLNRnmFQ9Mx15Tzdog1klG81Apiw/p4HWGMGDaT2OVosM9rfnLarpX4g5NWqQcD0zBMd3JvC6ffXUWXfHdIKHTaian1tz+LQP5G3mIzoSuJI91LzdJ30Xa2NQ06iFKI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728236441; c=relaxed/simple;
	bh=qI6qKXCeQDynyG/ituy4+OiHd7p1Mgym5BXA77HNygI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeUrmESlQN0+tJUW5PvvFjZx/JAM8C4lVXBdKnZJ+tbcykxpY/X61FhY8gDKM0gmz5g7eiPcBzlddUKWIZD131gjx4g2jauIKTQQwdQLlEsEtYjUkPIAXDPEEDsNXhKJSJhbPdhsoHQbIP5mmMXS4j4jKyq5qy7OeoAmQCLLxyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=hjzjT18L; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="hjzjT18L"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 30B0A1F4B8;
	Sun,  6 Oct 2024 17:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1728236433;
	bh=qI6qKXCeQDynyG/ituy4+OiHd7p1Mgym5BXA77HNygI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hjzjT18LOfh4y7dU3zJLbGbCw2dfUwNhAvnFoadq8ddVKexRCnZO/PDgjPGH6nOnw
	 u2EMju0eiNAab56Sp6rFZkUw8bcdls9vVyMIFZxSk0IHIvnKU+zkkCkd50ON2Fk+91
	 5CD721pwfNbmgJRSv0xpwuLHAqWefPU27wY6wUjY=
Date: Sun, 6 Oct 2024 17:40:33 +0000
From: Eric Wong <e@80x24.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 04/10] packfile: inline cache_or_unpack_entry
Message-ID: <20241006174033.M85696@dcvr>
References: <20240823224630.1180772-1-e@80x24.org>
 <20240823224630.1180772-5-e@80x24.org>
 <xmqqjzg3ky77.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqjzg3ky77.fsf@gitster.g>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <e@80x24.org> writes:
> 
> > We need to check delta_base_cache anyways to fill in the
> > `whence' field in `struct object_info'.  Inlining (and getting
> > rid of) cache_or_unpack_entry() makes it easier to only do the
> > hashmap lookup once and avoid a redundant lookup later on.
> >
> > This code reorganization will also make an optimization to
> > use the cache entry directly easier to implement in the next
> > commit.
> 
> "cache entry" -> "cached entry"; we tend to use "cache entry"
> exclusively to mean an entry in the in-core index structure,
> and not the cached objects held in the object layer.

OK, will do for v3 (apologies for the delay, Real Life is awful :<).

> > +		type = ent->type;
> > +		if (oi->sizep)
> > +			*oi->sizep = ent->size;
> > +		if (oi->contentp) {
> > +			if (!oi->content_limit ||
> > +					ent->size <= oi->content_limit)
> > +				*oi->contentp = xmemdupz(ent->data, ent->size);
> > +			else
> > +				*oi->contentp = NULL; /* caller must stream */
> 
> This assignment of NULL is more explicit than the original; is it
> because the original assumed that *(oi->contentp) is initialized to
> NULL if oi->contentp asks us to give the contents?

The original code unconditionally assigned cache_or_unpack_entry() result
to *oi->contentp, and there's a bunch of non-cat-file callers which pass
a non-NULL *oi->contentp and expect packed_object_info() to NULL it.
