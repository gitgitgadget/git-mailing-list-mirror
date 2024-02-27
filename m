Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33268130AC0
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709023533; cv=none; b=QJEvT5bczZeMyIiPU3HH3tdwDgfpqzoT0XgXzLaEjk8PqZ7t5BpFM1c6fh74nnvGFYN7Gd7nv9tMhP5WDVXxcIVIYroz0NMZQbuyvI+zSs9Z2aaS+wzQ/4IEVroBn3TOtpnnhW/L4al3hE0uNoqKFBP9FVYlZ8AyfkM6W6zJDoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709023533; c=relaxed/simple;
	bh=AiJPHGMWX3o2QaSe5RpcX4RyfNOyCt3oeP3ZWdUUczk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nok5CPM418V9tiXxKCz3OyUOqO0d2EW8OWb44nZimy1WbJ1h/FO9njayhYlddIMYbXN7ilA84TZnVAaD66jZy/U2YmoG6X0xVLWkYB8kh4tDaVmmiX568Uv+n+PEOGTdCG2iDVxkbkeEyeSgV4VstdlDRpJtMgPrhD9ZNQ7gyuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11832 invoked by uid 109); 27 Feb 2024 08:45:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Feb 2024 08:45:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7664 invoked by uid 111); 27 Feb 2024 08:45:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Feb 2024 03:45:34 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 27 Feb 2024 03:45:29 -0500
From: Jeff King <peff@peff.net>
To: Kyle Lippincott <spectral@google.com>
Cc: Junio C Hamano <gitster@pobox.com>, Calvin Wan <calvinwan@google.com>,
	git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>,
	phillip.wood123@gmail.com
Subject: Re: [PATCH v5 1/3] pager: include stdint.h because uintmax_t is used
Message-ID: <20240227084529.GJ3263678@coredump.intra.peff.net>
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-2-calvinwan@google.com>
 <xmqqh6i0cgyo.fsf@gitster.g>
 <CAO_smVi76TbmHd5w2rpBEEYbaw46SNTrekFHE-ohDC6-=dk6DA@mail.gmail.com>
 <xmqqle76iwqw.fsf@gitster.g>
 <CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAO_smVjeNYFTgh4MZjRM9U1coY=UJxo-E6bD9OfdS1A1Xf6vcQ@mail.gmail.com>

On Mon, Feb 26, 2024 at 04:56:28PM -0800, Kyle Lippincott wrote:

> > We use inttypes.h by default because the C standard already talks
> > about it, and fall back to stdint.h when the platform lacks it.  But
> > what I suspect is that nobody compiles with NO_INTTYPES_H and we
> > would unknowingly (but not "unintentionally") start using the
> > extended types that are only available in <inttypes.h> but not in
> > <stdint.h> sometime in the future.  It might already have happened,
> 
> It has. We use PRIuMAX, which is from inttypes.h.

Is it always, though? That's what C99 says, but if you have a system
that does not have inttypes.h in the first place, but does have
stdint.h, it seems possible that it provides conversion macros elsewhere
(either via stdint.h, or possibly just as part of stdio.h).

So it might be that things have been horribly broken on NO_INTTYPES_H
systems for a while, and nobody is checking. But I don't think you can
really say so without looking at such a system.

And looking at config.mak.uname, it looks like Windows is such a system.
Does it really have inttypes.h and it is getting included from somewhere
else, making format conversion macros work? Or does it provide those
macros elsewhere, and really needs stdint? It does look like
compat/mingw.h includes it, but I think we wouldn't use that for msvc
builds.

> I think it's only
> "accidentally" working if anyone uses NO_INTTYPES_H. I changed my
> stance halfway through this investigation in my previous email, I
> apologize for not going back and editing it to make it clear at the
> beginning that I'd done so. My current stance is that
> <git-compat-util.h> should be either (a) including only inttypes.h
> (since it includes stdint.h), or (b) including both inttypes.h and
> stdint.h (in either order), just to demonstrate that we can.

It is good to clean up old conditionals if they are no longer
applicable, as they are a burden to reason about later (as this
discussion shows). But I am not sure about your "just to demonstrate we
can". It is good to try it out, but it looks like there is a non-zero
chance that MSVC on Windows might break. It is probably better to try
building there or looping in folks who can, rather than just making a
change and seeing if anybody screams.

I think the "win+VS" test in the GitHub Actions CI job might cover this
case. It is not run by default (because it was considered be mostly
redundant with the mingw build), but it shouldn't be too hard to enable
it for a one-off test.

-Peff
