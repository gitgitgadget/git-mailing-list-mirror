Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60E118EB0
	for <git@vger.kernel.org>; Sat, 15 Nov 2025 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763172773; cv=none; b=s4+iXTpMCUOlXzgWPb9k9hshK+Xnf21VlMPlKiJJhkMYevZFPPQKSBBGpF9AFIg7R+KkmZTSJSLqtEPLJEQDqgaFSFiVIdwqbdU1gpuUvnEdc5BtpKzFI4QjwGr+cfA16vB4ynFPCX/LsQDw5P5EI7pi+IRw84BWq2aiMLRMCi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763172773; c=relaxed/simple;
	bh=7LV7EqhJgaOyQkF8XxiK5nujK0gO3YyyGWFvb9CNOFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bF35qIxEL5swaVGIlZMYvBfBckR9vSScDLN+vH77tR1XR7QHoSNHmQ10JnbEMH/0l246rfNVyfq2iZc+yYPxEht0DHJwCEM1pk8X2b62/JeJwEvZE+Itr0eYi2v2JvlAMp78+dOwcwBuPfJyOySpBEXTn4UGubpD6omN3Ed/xLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=hLTFk4fq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="hLTFk4fq"
Received: (qmail 522522 invoked by uid 109); 15 Nov 2025 02:12:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7LV7EqhJgaOyQkF8XxiK5nujK0gO3YyyGWFvb9CNOFk=; b=hLTFk4fq0QIsTVZA7M4v0Zef0Mf8ijTXqlddvQ9Yby2Gi6sIuCldt4iwEJdI3O5Tog8oAjmZGuxxz51Hmz7Puvr8r3zutDDdRdSq31BOQqUkiWm5bxIi8ZYIvj0ALi9giy2NPct5dDJ+ejkZzF596nFSZzfISoy3chgLiyTRKb8imh9WhqV+PqgeD3fgLtpYR76zjj21L3l9V8EP4T9rbMPCjbDAriudEO8F+/+W6mmGaNGcjjTVjWYzY/cN3WDF21KW9Nowz/JwSXRJCn37WnmT+lEwT0WUdSdl4RXdFb5EfcWfvd0ckfBZvcoKQfRE+L9SHRqLg5ebmaJ3o1dq6A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 15 Nov 2025 02:12:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 827959 invoked by uid 111); 15 Nov 2025 02:12:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 14 Nov 2025 21:12:49 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 14 Nov 2025 21:12:48 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 8/9] fsck: avoid parse_timestamp() on buffer that isn't
 NUL-terminated
Message-ID: <20251115021248.GB3499607@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
 <20251112081040.GH979063@coredump.intra.peff.net>
 <aRRux2uBfORc214r@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aRRux2uBfORc214r@pks.im>

On Wed, Nov 12, 2025 at 12:25:59PM +0100, Patrick Steinhardt wrote:

> On Wed, Nov 12, 2025 at 03:10:40AM -0500, Jeff King wrote:
> > In fsck_ident(), we parse the timestamp with parse_timestamp(), which is
> > really an alias for strtoumax(). But since our buffer may not be
> > NUL-terminated, this can trigger a complaint from ASan's
> > strict_string_checks mode. This is a false positive, since we know that
> > the buffer contains a trailing newline (which we checked earlier in the
> > function), and that strtoumax() would stop there.
> > 
> > But it is worth working around ASan's complaint. One is because that
> > will let us turn on strict_string_checks by default, which has helped
> > catch other real problems. And two is that the safety of the current
> > code is very hard to reason about (it subtly depends on distant code
> > which could change).
> > 
> > One option here is to just parse the number left-to-right ourselves. But
> > we care about the size of a timestamp_t and detecting overflow, since
> > that's part of the point of these checks. And doing that correctly is
> > tricky. So we'll instead just pull the digits into a separate,
> > NUL-terminated buffer, and use that to call parse_timestamp().
> 
> So this is another site that would benefit from having something like
> `git_parse_int()` with an extra parameter indicating the number of
> bytes available for parsing (and a way to disable unit factors).

Yes, but also no.

Yes, in the sense that if we had a robust global function to parse an
integer from a buf we could use it here, as well as in cache-tree.

But there are lots of no's:

  - We could not have one such function, because the implementation
    would differ based on signedness and size of the integer type. And
    cache-tree is a signed long, whereas this is a uintmax_t. We can
    factor out some of the work with a helper that takes a max
    parameter, but you can see we duplicate a bunch of code between
    git_parse_signed() and git_parse_unsigned().

  - The interface for git_parse_int() isn't quite a match. It wants to
    parse every byte in the provided string and complains if there is
    any extra cruft, rather than aiding in progressive parsing of a
    buffer. So if you have a string "10 20\0", it will not just parse
    "10" and then tell you how far it parsed; it will barf on the space.
    If we added a new parameter for "this is how many bytes we have",
    and you fed it the buffer "10 20" and the length 5, it would have
    the same problem.

    So there's a fundamental mismatch between "parse this as an integer
    and complain if there is anything else" versus "parse an integer,
    advance the pointer, and we'll keep going".

  - The implementation for git_parse_int() isn't a match either. It is
    just asking strtoimax() to do all of the work, which is the very
    thing we need to avoid.

So I think one _could_ write a strtoimax() replacement that handled
everything we wanted, and then you could probably build
git_parse_signed() etc around that. But it would be a lot more work than
what's there (like checking overflow progressively as we multiply and
add), and there are some decisions to be made (like handling leading
whitespace or how +/- work on unsigned integers). I'd probably err more
on the side of simplicity and strictness than strtol() does, but that
also means that plugging in the new function would change user-visible
behavior. Sometimes in a good or OK way (stricter parsing), but maybe
sometimes in a bad or confusing one (rejecting inputs that used to
work).

-Peff
