Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAB331A270
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 01:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725585580; cv=none; b=epS27PU2ZNG4shVhd+xRfPSR0AKUMF+cGNv63Vv2eKFQOQU5aXMAk8dUNW+BdDVDL85JD05GqcuFI7konOJqaMuddQxDXZg/VqpUfdmTiBRqaegre+i+gWZbWgFrj85P0V7dl4S38RW5kCznxZs/8NmoQPx716iCAJAC9ucN9tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725585580; c=relaxed/simple;
	bh=2BH5u02Y8iIDMnPSpgo+73NR4wpueNvEBUdKZVIadwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t0s17AyvBaQCuJCf8wpxx9cqsi8aeus5c4kQUPbZPigsg7boKD5IisyN6bb2KB0o2yuYSCLYjXOw9wxRQ5sX3bXTGMNtTiWiTGQx9em7z7DbNuWynJwUq9e0QT9Q9Fw503F4d75fbV1CsodMMx8EMZJ1S6L4g2XxLloEQ2cn9Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14429 invoked by uid 109); 6 Sep 2024 01:19:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 06 Sep 2024 01:19:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15477 invoked by uid 111); 6 Sep 2024 01:19:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 21:19:36 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 21:19:35 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] sparse-checkout: use fdopen_lock_file() instead of
 xfdopen()
Message-ID: <20240906011935.GA2616101@coredump.intra.peff.net>
References: <20240905082749.GA88220@coredump.intra.peff.net>
 <ZtmN6sZCvDy1BGfn@pks.im>
 <xmqqr09xztqa.fsf@gitster.g>
 <xmqqmsklztkd.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmsklztkd.fsf@gitster.g>

On Thu, Sep 05, 2024 at 02:20:18PM -0700, Junio C Hamano wrote:

> >> I think the error handling is broken. `commit_lock_file()` calls
> >> `rename_tempfile()`, which deletes the temporary file even in the error
> >> case. The consequence is that `lk->tempfile` will be set to the `NULL`
> >> pointer. When we call `get_locked_file_path()` we then dereference it
> >> unconditionally and would thus segfault.
> >
> > Hmph.  Would this be sufficient as a band-aid, then?
> 
> Of course not.  That would refer to a piece of memory that we
> already free'ed in this function.
> 
> Perhaps like this?

That works, though...

>  	fp = fdopen_lock_file(&lk, "w");
>  	if (!fp)
> -		die_errno(_("unable to fdopen %s"), get_lock_file_path(&lk));
> +		die_errno(_("unable to fdopen %s"), sparse_filename);
>  
>  	if (core_sparse_checkout_cone)
>  		write_cone_to_file(fp, pl);
> @@ -356,11 +355,13 @@ static int write_patterns_and_update(struct pattern_list *pl)
>  		write_patterns_to_file(fp, pl);
>  
>  	if (commit_lock_file(&lk))
> -		die_errno(_("unable to write %s"), get_locked_file_path(&lk));
> +		die_errno(_("unable to write %s"), sparse_filename);

Note the difference between "get_lock" and "get_locked" in these two.
The first will mention the tempfile name, and the second the destination
filename (and sparse_filename is the latter).

I don't know that it really matters much in practice, though. If
fdopen() fails it probably has nothing to do with the file itself, and
is either lack of memory or a programming bug (e.g., bogus descriptor).

I'll pick up this change, but I'll split the whole error-handling fix
into its own patch, since it's getting more complicated.

Will send v2 later tonight. Thanks, Patrick, for noticing the problem in
the first place.

-Peff
