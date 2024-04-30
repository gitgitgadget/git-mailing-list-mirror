Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D357612B176
	for <git@vger.kernel.org>; Tue, 30 Apr 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714473220; cv=none; b=Y9OGWZWxPV0QRhzMFYulNh6ZQOetKMx53RnK90WuYOWRmxVKMOmugRITa5+jK9J2xQsW3zZYrFg9qBrNbyYxX0L4pXk8gDEVpeqGJy0SwqgNwQoaCCdV/mSzB1hI3/N8buGqi1XxThwos2UNHqvQQRohaL/jFj8yyvoDPg1Htxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714473220; c=relaxed/simple;
	bh=RIDVEc4Eiu8nfuEzRFBeIMcLbfxtxjNTFjqNVnbIdE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AezGBkcjIrPS7j6zpQzzxrW8Q+h+jnPDIHAt1dVelmqiD2FtgfL2vSOTHWeBv6LQISmzqKnNtd6hBkGemNme/HDVQMft+AbK+fqypmpw0YV+5ApKnpHoGpkssrF6SdiQzrjVJfJd9v+gGCcVLSZy5mZd+se9utBJyRmjhAJrYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3406 invoked by uid 109); 30 Apr 2024 10:33:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Apr 2024 10:33:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5568 invoked by uid 111); 30 Apr 2024 10:33:42 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Apr 2024 06:33:42 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Apr 2024 06:33:37 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: phillip.wood123@gmail.com, Phillip Wood <phillip.wood@dunelm.org.uk>,
	Karthik Nayak <karthik.188@gmail.com>, christian.couder@gmail.com,
	git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH v4 1/7] refs: accept symref values in
 `ref_transaction[_add]_update`
Message-ID: <20240430103337.GE1279403@coredump.intra.peff.net>
References: <20240423212818.574123-1-knayak@gitlab.com>
 <20240426152449.228860-1-knayak@gitlab.com>
 <20240426152449.228860-2-knayak@gitlab.com>
 <xmqq1q6rc44n.fsf@gitster.g>
 <20240426211529.GD13703@coredump.intra.peff.net>
 <b2977495-3b4a-4f2a-85dc-d0568f34f2e9@gmail.com>
 <xmqqo79sxhug.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo79sxhug.fsf@gitster.g>

On Mon, Apr 29, 2024 at 09:18:47AM -0700, Junio C Hamano wrote:

> phillip.wood123@gmail.com writes:
> 
> > ALLOW_ONELEVEL just disables the check that the refname contains a '/'
> > and I think it is aimed at checking branch and tag names without a
> > refs/{heads,tags} prefix. If we want to move away from using
> > refname_is_safe() perhaps we could add an ALLOW_PSEUDOREF flag that
> > only allows the name to contain '[A-Z_]' if there is no '/'.
> 
> Makes sense.
> 
> I wonder if we eventually can get rid of ALLOW_ONELEVEL, though.  If
> all callers that use ALLOW_ONELEVEL know under which prefix they
> plan to hang the refname they are checking (if the refname passed
> the check), we can force the check to be performed always on the
> full refname, and it will become easier to make the check more
> consistent---as the check will have full context information.
> 
> For example, with ALLOW_ONELEVEL the check may say "HEAD" is OK, but
> if we get rid of ALLOW_ONELEVEL and force the callers to always test
> the full refname, we may say "refs/heads/HEAD" is not acceptable,
> neither is "refs/tags/HEAD", but "refs/remotes/origin/HEAD" is good.

One case I ran into while working on my series is refspec parsing, where
we feed the left and right halves to check_refname_format(), albeit with
a special flag that allows the "*" wildcard character. And there we are
OK with one-level names because they will be passed through the
dwim_ref() lookup.

I don't know if there are other spots that do something similar. Most of
them would, I imagine, just take any input and leave it to the ref code
to enforce syntax after the dwim-ref has happened.

-Peff
