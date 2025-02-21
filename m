Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEB01FBCAA
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740123368; cv=none; b=eb51Tkvkw4GORFBGK9tZrjF+37CArWcxF1ieu/Oij/eJXGgVGFHaBR86CRyOr2l8U/Oy+9uxsR3Pqq6c9S2iBm+H2qasp64dmvtj98nWk4F8vaQWFyVpMXnAjuPTpEOlyZ4eShWL/LKX03MKxnCdkY52Ed9YAxh8QtsopPQwu8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740123368; c=relaxed/simple;
	bh=TMGQlu2DeYqxT4AJKjoV1k1glvTi/cK9K3yKYofexn0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rdn0v6wZVCYA3f0k4bVKKS1sRYsphIcOFdf9e4/aKTUmA6owKD0R65s1uSrVaK9W2HnrKD9imJtGk3vu0q/xp+BXtDKoZzaVA/2QRi9nlC2NmpRzcWvAdn4jNYwZJLPuFCXkuqZk7vUsNRzouCNgUakKhTfFSkJRj+xlPZAIxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FG6hFpZm; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FG6hFpZm"
Received: (qmail 3184 invoked by uid 109); 21 Feb 2025 07:36:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=TMGQlu2DeYqxT4AJKjoV1k1glvTi/cK9K3yKYofexn0=; b=FG6hFpZmJi8v0Aoilf1FVLwNLJA3F6vSOnVj4lA125GPsrfgeM9pKKkX5ld/1oGFH4cUPQwJDCp5fiLuiyvfv8iBB2lYQmNCoC40x6azymaDi0YkkPvdJW0hMd3T6xfdVqY/UQBkgEIYlM9EFOiE9e/ZUtmDpaxy4gg5899nlIUJYTpRUmZSlIpoRDPN2nMtM9RgghrNaLo8CJVjqdVE0+oHhPD4jRKVzoOqPEOKpI1Z5IpO8wQYJB+XbOJYe2/nZ9LodNIPHe+2OvRfRrd+r9atSUeqII8x3iBU6JL3flP9NDOYTBK5MySfxCISFohyxeIbEwq+3grPsxwDE7hdog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 07:36:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30865 invoked by uid 111); 21 Feb 2025 07:36:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 02:36:05 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 02:36:05 -0500
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/4] bundle-uri: enable git-remote-https progress
Message-ID: <20250221073605.GA1988395@coredump.intra.peff.net>
References: <20240508124453.600871-1-toon@iotcl.com>
 <20240508124453.600871-5-toon@iotcl.com>
 <20240509164646.GB1708095@coredump.intra.peff.net>
 <87o6z43gz8.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6z43gz8.fsf@iotcl.com>

On Fri, Feb 14, 2025 at 12:26:03PM +0100, Toon Claes wrote:

> I've been playing around with things and I haven't found a good way
> forward with this. We could have the parent process ingest stderr of
> git-remote-https and swallow messages that match `/^fatal:/`, but that
> feels like a hack and not foolproof.

Yeah, agree that feels quite hacky (and you'd probably want to swallow
/^error:/, /^warning:/, etc, too).

> I was thinking if we could override `die()` in the child process to have
> it not print anything, but because git-remote-http basically can call
> die() basically from anywhere in the codebase, I don't think we can
> ensure the silenced die() function is called.
> 
> Or what do you mean by "squelch non-progress errors"?

I was thinking of having some kind of "very quiet" mode where
git-remote-http would not print any errors (except for progress). But I
agree that doing it is non-trivial. Our die/warning/error functions are
all pluggable, so remote-http could add its own implementations using
set_die_routine(), etc.

But that does feel pretty heavyweight, and you'd still have to pass
through the "please suppress all your die calls" option into
remote-http. Plus it wouldn't catch any spots in the code that happen to
call fprintf(stderr), etc.

> And yes, sending progress logging over a separate fd seems like the
> ideal approach, but I haven't tried it yet. I'm afraid it's not worth
> attempting so.
> 
> So I think that leaves us with your suggestion to "ferry
> machine-readable output back to the parent". If I understand correctly
> you mean the child process will not write progress logging to stderr but
> to stdout (with some kind of command prefix the parent process knows
> what to do with this)?

Exactly.

> I imagine communication between parent and child will then look
> something like this:
> 
> -> capabilities
> <- stateless-connect
> <- fetch
> <- get
> <- option
> <- push
> <- check-connectivity
> <- object-format
> -> option progress true
> <- ok
> -> get http://example.com git.bundle
> <- progress 123 345 40
> <- progress 234 345 50
> <- progress 345 345 40
> 
> ~fin~
> 
> But then we need to decide on the format the child sends back to the
> parent. In the above example it's something like `progress <size>
> <total> <throughput>`. An alternative proposal could be:
> 
> <- log Downloading via HTTP: 
> <- log Downloading via HTTP: 200.00 KiB | 100.00 KiB/s
> <- log Downloading via HTTP: 300.00 KiB | 100.00 KiB/s
> <- log Downloading via HTTP: 400.00 KiB | 100.00 KiB/s
> <- log Downloading via HTTP: 400.00 KiB | 100.00 KiB/s, done.
> 
> So the child sends the progress text with a `log` prefix, which the
> parent simply has to send that logging to where it wants it to go.
> 
> Or am I completely misunderstanding your proposal? Do you maybe happen
> to have any examples of a similar solution?

No, I think you understand it perfectly.

Your "log" example with arbitrary text seems like the simplest approach,
and might be enough. Then we wouldn't have to define a schema for
progress numbers (and we have at least two types of progress: counts and
throughput, though I guess maybe this would always be throughput?).

But I do wonder if we'd want the flexibility of the machine-readable
numbers. In particular, would we ever fetch multiple bundle-uri files in
parallel? If so, then we wouldn't want them stomping on each other's
progress. You'd probably want the caller to present a unified view based
on the progress reports from all of the child processes.

-Peff
