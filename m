Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8E259480
	for <git@vger.kernel.org>; Tue,  7 Jan 2025 02:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736218112; cv=none; b=T+g0MLBkcVJtHYrYO6kD2io/0qIvpd29aeoQWVycfuVdQ94kc0kCEVScCuGg2AbyC9jSF9O4MwrcDpLLFMhUbm7JHe3q46tVi8iiLqh0ScyiyupXZuVKvrjY53qY4ys/sn9EapODlNeJtjG6rzHXBn7cr0sWtMPOlW8ulP8lCqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736218112; c=relaxed/simple;
	bh=S5SORXDYT+BodRjvscRcXmc8noqyofbPyJrwjFiMBmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PzuRd/iE9Xtnao6B6hF18yX45lJBUcQmG5VSYigJUGk8i8lSUdRVC/UUkYlUACCXIrT1p07PW02moSBrqesCidLcwixMI2nK/O+6Xqa2rgAvb6dGO1KdimBZqt6rEF6QMIIhpZS90w4EPYmYKbC5Lu74//oZ/PcwDVItOXqG/vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cgypxnMX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cgypxnMX"
Received: (qmail 26971 invoked by uid 109); 7 Jan 2025 02:48:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=S5SORXDYT+BodRjvscRcXmc8noqyofbPyJrwjFiMBmM=; b=cgypxnMXXgjlEAI22MCttuV0uRr/iAqdlLIxoP8CWVUfMzzKDF9ASgGXKG4lJKA8ETSupxDLos+X/TYJ3rcajJylnUndkp0cCMqXdC5iWe+C8z3nILSdnvmyE/7R9TF0RSdqGrJtRkEbbNvmLBUKMCZqTMGYNAltz3SI0UTGfM0XxMs2ck6e5iugXwxQLN4EOlBVuwkKXeT2Ngf8EDDmHIGjwicvOFmxhUk70PENP8XwHQDfhqy5S1xwh5NEh4JrCRdXwJhd8mBl7RCSW/gvd/20Y+6PaalU5fS3SEIWxVahd9yyc7h3i6dcw3x4mp/ihy+Cr2GmGbd0c7KvC9qccg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 07 Jan 2025 02:48:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19269 invoked by uid 111); 7 Jan 2025 02:48:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 06 Jan 2025 21:48:29 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 6 Jan 2025 21:48:29 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/10] t7422: fix flaky test caused by buffered stdout
Message-ID: <20250107024829.GC2363@coredump.intra.peff.net>
References: <20250103-b4-pks-ci-fixes-v1-0-a9bb95dff833@pks.im>
 <20250103-b4-pks-ci-fixes-v1-2-a9bb95dff833@pks.im>
 <20250103181739.GA2527684@coredump.intra.peff.net>
 <Z3u6lj_bpM7N93Fd@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3u6lj_bpM7N93Fd@pks.im>

On Mon, Jan 06, 2025 at 12:12:22PM +0100, Patrick Steinhardt wrote:

> >   - I tried using test_seq to avoid the inline perl, but it doesn't
> >     work! The problem is that it's implemented as a shell function. So
> >     when it gets SIGPIPE, the whole subshell is killed, and we never
> >     even run git-submodule at all. So it has to be a separate process
> >     (though I guess it could be test_seq in a subshell).
> 
> And that one should also work if we retain the grep. I wonder though
> whether we shouldn't prefer to use Perl regardless as it's likely to be
> faster when generating all that gibberish. Perl is basically a hard
> prerequisite for our tests anyway, so it doesn't really hurt to call it
> here.

I don't think we should pursue this direction any more because we need
to get the SIGPIPE mid-way through the git-submodule command (see the
other message I just sent).

But because it is a basic technique for establishing a reliable SIGPIPE,
and we might end up using it elsewhere, I thought I'd post a slightly
improved version.

The two things I didn't like about what I posted earlier were:

  - the guess at the pipe buffer size. 128k is probably enough in
    practice, but it's not guaranteed.

  - piping to "head" actually made our buffer size guess worse. We know
    that "head" is going to read the first line and then exit. But how
    much more data might it read? It might easily buffer 4k or even 8k,
    leaving the buffer not-quite full.

So I think a simpler and more robust version is just this:

  {
	{ yes || true; } &&
	command_expecting_sigpipe; echo $? >status
  } | true

We'll keep producing data in "yes" until the pipe is closed. So it will
closed before command_expecting_sigpipe even starts, and there is no
race there. And because we're using "true" on the right-hand side of the
pipe, nothing is read at all from the pipe. So there's no guessing about
how much might have been read.

And it works no matter how slow the right-hand side of the pipe is
(e.g., you can add a "sleep 1" there and it still works).

Like I said, this won't help our current situation, but after having
spent a little time on it (before realizing that) I figured it was worth
documenting.

-Peff
