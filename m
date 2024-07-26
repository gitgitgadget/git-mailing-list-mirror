Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07092628
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 00:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721954497; cv=none; b=HI4GZeq+1ox+rO/IlmFRjL2qXeEeqGpXksJY/9F0eqf3AIDU2ozcXnQOmHEzZx67lAwKQPbNW+pEkNFkByylKm5ra1b06Ib6tRH6krRqY/M883chHkD2rtz9vWnga2cYxGxaKFM1SVbT0YzVMZwgTlRNcUxi29T0iWMCFdGGAQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721954497; c=relaxed/simple;
	bh=PPlyHBbLGvL/M5fnxQMe6HhKeymsB4mzAq/WCcHGHs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dj/Rpa+NRX0s1Yu9ZWgsww/2NYTuGRhZEYMYW4HB/zuWUA4tFvd0u7yOtNwGMqg+jZ0vBvGTWtPoVlk5m+jJ9vGQt5vS7YIKXyptay8IVBa1exDVru76z2LwbtccfQd+afaiaw1iUP/oV4Dp1jMua6DPBA0MrzyG4ugnNuGJ9Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14330 invoked by uid 109); 26 Jul 2024 00:41:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Jul 2024 00:41:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28788 invoked by uid 111); 26 Jul 2024 00:41:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 25 Jul 2024 20:41:31 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 25 Jul 2024 20:41:27 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Randall S. Becker" <the.n.e.key@gmail.com>, git@vger.kernel.org,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	"Randall S . Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2 1/2] Teach git version --build-options about libcurl
Message-ID: <20240726004127.GA611651@coredump.intra.peff.net>
References: <20240621180947.64419-1-randall.becker@nexbridge.ca>
 <20240621180947.64419-2-randall.becker@nexbridge.ca>
 <f44f1e25-41ca-0784-3186-f9e1bdae0d4f@gmx.de>
 <xmqqed8me36c.fsf@gitster.g>
 <20240624235557.GA2727@coredump.intra.peff.net>
 <402c12c2-7ada-4d9e-c3da-1a78827e7496@gmx.de>
 <20240724205541.GA557365@coredump.intra.peff.net>
 <8ef819f0-e80a-74ec-274d-fe10991fe992@gmx.de>
 <20240725065214.GA590196@coredump.intra.peff.net>
 <xmqq7cd9lccl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7cd9lccl.fsf@gitster.g>

On Thu, Jul 25, 2024 at 08:28:58AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> A command with a name along the lines of `git diagnose`, I'd say.
> >
> > OK. I don't really care much either way how it is spelled, though my
> > inclination is that we already have a confusing number of commands and
> > should avoid adding more.
> 
> I think what you are responding to is an oblique reference to a
> command that already exists, and there is no need to worry about
> adding more ;-).  If "bugreport" is not farming out the task of
> collecting the information to it, "bugreport" need to be corrected
> to do so (while "diagnose" may have to learn to collect more, if
> "bugreport" collects things that "diagnose" does not (yet)).

Oh, sorry, I somehow missed when diagnose was added. Yeah, that seems
like a perfectly reasonable place to put it, though like bugreport it
has the same annoyance that I just want to dump the info to stdout, not
make a zipfile.

Curiously, it seems to segfault for me when run outside a repository. :-/
The issue is a NULL the_repository->objects->odb pointer passed into
dir_file_stats(). But obviously that bug is orthogonal to the discussion
here.

-Peff
