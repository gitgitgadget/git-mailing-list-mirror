Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E15041C89
	for <git@vger.kernel.org>; Tue, 18 Jun 2024 23:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718753587; cv=none; b=bmsHVrGjznoV87EhLhx2yUwGZXBdnsz/pT5tuyLakz/qXfsXCrQlKx3qVw3S9bLENNVZ9b+GQrcSoHJNLoycTzk6V6FgLVT68srYdprNK6eymlUKM7eygdE81VHeAVpfpBJj6poVZVVzDedV9kneqxemOAMIqb9k6Y0rtKKPEXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718753587; c=relaxed/simple;
	bh=4+2JXgkN4ijdvf6EScfbCK/LTp3eOcwYLLNCGUqbo+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FNjy3iFdbrFTamAExk+iReF3nD38JERYuhJ+z9x7auIV1zw4lWCgYsqHB0KTEdjVmVpuJgiZBuQH+G+Jl9jVMVHn15Ud04kI4Jh9qLyk7OtBmCgtRoFdwSOyRHK2Th8wG58sPFxPMepBYn0uBjQtbJZuqJuma5wMWlrp+M4ufU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3082 invoked by uid 109); 18 Jun 2024 23:33:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Jun 2024 23:33:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15846 invoked by uid 111); 18 Jun 2024 23:33:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Jun 2024 19:33:02 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Jun 2024 19:33:03 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Alexey Pelykh <alexey.pelykh@gmail.com>, git@vger.kernel.org
Subject: Re: Non-blob .gitmodules and .gitattributes
Message-ID: <20240618233303.GA188880@coredump.intra.peff.net>
References: <4F3AD9A8-DA3E-43E2-BF9A-9D7458EED7EA@gmail.com>
 <xmqqbk43ilk3.fsf@gitster.g>
 <20240618183156.GB178291@coredump.intra.peff.net>
 <14349714-F8D1-4F7B-BB13-4FA39C6819DE@gmail.com>
 <xmqqa5jiypmm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5jiypmm.fsf@gitster.g>

On Tue, Jun 18, 2024 at 01:14:57PM -0700, Junio C Hamano wrote:

> Alexey Pelykh <alexey.pelykh@gmail.com> writes:
> 
> >> But I'd also suspect that other non-POSIX platforms would see the error
> >> at open(), and _would_ actually produce an error message. I seem to
> >> recall running into this before with Windows, maybe?
> >
> > Is there an easy way to verify "what on Windows" part? I'd be happy to
> > help, yet I'm not sure I got it right what to look for.
> 
> Create a .gitmodules and .gitattributes directory, "git add" it, and
> perform various operations that want to read them, probably.  Even a
> simple "git diff" should try to consult the attribute system (e.g.
> because it wants to know if a path needs use custom function header
> regexp pattern).  As Peff said, on Linux and probably on macOS, we
> will silently ignore such .gitattributes and that is what we want.
> On Windows we may see "cannot open" error reported and visible to
> the users.

I don't think you even need to "git add" it. Just making it in the
working tree is enough for us to look at it. You probably do need an
actual change in a tracked file for "git diff" to bother looking up
attributes (an alternative is just "git show" on an existing commit).

Interestingly, a directory .gitmodules _does_ complain:

  $ git status
  warning: unable to access '/home/peff/tmp/.gitmodules': Is a directory
  On branch main
  nothing to commit, working tree clean

That's because it uses fopen(), rather than open(). And we have a
wrapper that complains about directories there, triggered by the
FREAD_READS_DIRECTORIES knob in the Makefile. It's set for Linux, but
not for Windows (which is why I suspect Windows might just complain by
itself). We don't see that for ".gitattributes" or ".gitignore" because
those use a raw open() syscall, and Linux is happy to allow it. Arguably
that's a bug, as the intent of that knob is that we'd notice and avoid
trying to read from directories.

So even putting fsck warnings aside, I think it's mostly luck that
having .git* files as directories doesn't produce noisy warnings during
normal use.

-Peff
