Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E89207A33
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736506469; cv=none; b=R3ou1QrC+EDfK0O51eV7wFOjNoOG0oWkJn2lvXxgtP2K/2Z6oaWxOEuIgyOr9At0A+8r8nr9NVbyj757RP9QtHr5Uu8DC4JlEBmIjfI0kMYTUsay3uSvsIxrk8WA5J7MB+Pzvb+pmefqJBgmfuOnSeeoTNo6xlYlIm81vTCnbSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736506469; c=relaxed/simple;
	bh=gN+3DBcHdzdLxTia7uxuenS+pM6ICpGtht6zYrJM7AA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CDCb40psUmWxR3xpuyz36CccUtlYE3JlfC5Vq5MG29o9SpKtRxH90btMzF9t4cSCfi+eYeVfkMM2P7k+a3ssdOD8oTUazAUF1OvtVCNGVQR2lOH3q/NuQxlfBUa4zsdXzTszfUuubibi5hCRpq8LryAKnwi/m1AAHy/Tkd/igvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=eX125C03; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="eX125C03"
Received: (qmail 3900 invoked by uid 109); 10 Jan 2025 10:54:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gN+3DBcHdzdLxTia7uxuenS+pM6ICpGtht6zYrJM7AA=; b=eX125C03vVihCiJ82cri7y8+ouQ5lExtpfWvu1ULdkEYaBQN0BhGFUGuGi66uN9ySZiiipCX6mXh9NrC31EF57tvlIKtsSfKfMhSdETkDkxITF42SMh/9iiDIU3o6WKo9WVveaBHq8T4coMbyV/A1035Jr+sD19MJQrmo4Wi73ZIiv/CSJHPQQpVRPPe5fQKroarpf0UNsLWMqlL8CoRwNTl1Bhyn2XI6I2b/Hue4YUNck19MY9FlgII1jodnkKMMZUJm4RhPz0V8vjz57UDdbRt6IgRFNuz9ELDoB4Rc8J5fl/VC/9pOa+k6IN0KNKdCwiqzZtR1yXRSqKhNCszDA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jan 2025 10:54:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4177 invoked by uid 111); 10 Jan 2025 10:54:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 05:54:25 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 05:54:24 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Git List <git@vger.kernel.org>, Wink Saville <wink@saville.com>
Subject: Re: [PATCH 03/14] tree-diff: clear parent array in path_appendnew()
Message-ID: <20250110105424.GA1014503@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109083310.GC2748836@coredump.intra.peff.net>
 <xmqqo70fj0zu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo70fj0zu.fsf@gitster.g>

On Thu, Jan 09, 2025 at 10:28:05AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > All of the other functions which allocate a combine_diff_path struct
> > zero out the parent array, but this code path does not. There's no bug,
> > since our caller will fill in most of the fields. But leaving the unused
> > fields (like combine_diff_parent.path) uninitialized makes working with
> > the struct more error-prone than it needs to be.
> 
> OK.  We however will still not use the array at all when we do not
> need it, so it would be between accessing uninitialized bytes vs
> accessing 0-bytes by mistake?  With my devil's advocate hat on, I
> wonder if this would lead to more sloppy users saying "I am not
> following the pointer; I am merely stopping when I see a NULL
> pointer at the end of the array" or something silly like that
> without checking the validity of the array itself (which presumably
> can be inferred by inspecting some other member in the containing
> struct, right?)".

Yes, code may be equally wrong to look at uninitialized versus zero
bytes, depending on what it's doing. I don't think "stop when you see
NULL" is a danger here; this is an array of structs, one of which now
happens to be NULL (rather than an array of char pointers, which might
imply that NULL is the end).

Some of that sloppiness already exists. For instance, before my series,
check out intersect_paths(). If we are removing an element from the
list, we clean it up like this:

	for (j = 0; j < num_parent; j++)
		if (combined_all_paths &&
		    filename_changed(p->parent[j].status))
		strbuf_release(&p->parent[j].path);

but if we allocated for 3 parents and have only gotten to the second
pass, all of parent[2] will never have been filled in. We zero
initialize the parents in that function, so there's no memory error. But
it is relying on the fact that filename_changed() will reject a zero
status to avoid calling strbuf_release() on a zero'd strbuf (which
incidentally also works, but violates the strbuf API).

Now in that case we are zero-ing, so it is not one of the uninitialized
cases that Wink ran into. But even if he had tried to be careful with:

  if (filename_changed(p->parent[i].status))
	/* ok to look at p->parent[i].path */

it would not have worked, because that status would have been
uninitialized, too.

> > Let's just zero the parent field to be consistent with the
> > combine_diff_path_new() allocator.
> 
> But I like the "let's be consistent" reasoning, so I wouldn't
> complain ;-)

So yeah. This is the part that I think is really helping new code.
Changing the strbuf to a pointer makes it even simpler (you do not even
have to check the status at all), but this is the commit that is
preventing undefined behavior. ;)

-Peff
