Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 191E51714D7
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 07:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736409474; cv=none; b=LCqInyKQUvgQziCefLX7oKAAqtMYPe957uDEivw8j7JP0HqKa4M6U7+5io287rjNNEwZDQFPpTaLqGT08dSFdWJB9iI2E6vXvgsKCeri/gnsYNSUQz+2hC2sr6tuGTgsftJ0QaS8A7L7rCBsSaW6zmAYbUgq4AAYTLhSw3b5Ffk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736409474; c=relaxed/simple;
	bh=orUoHH2U5oatLNtkdv0D50tWoL07pHiUQyteT+sga4A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ah8hUoZWbkuGzs4uDLvfmZg+3UA2m26ZFzBtNhYNI6kATfB9RTDbLzW4aWgvrHMw+GoeGlJ0IxTGhK62l3eAImn2sktKXGnRy8GWfpga+TqBK2tb8xQpMz//nqwMF63gTBYLiacodfpbJngiKQ0+IR0ihVP/ttlSxzta7Zx2q7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AX9ux1ap; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AX9ux1ap"
Received: (qmail 25156 invoked by uid 109); 9 Jan 2025 07:57:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=orUoHH2U5oatLNtkdv0D50tWoL07pHiUQyteT+sga4A=; b=AX9ux1apFeEx4mfBGNZth+B4qo45FrF01TbjhBGdcA3FgXXc3ulhT8lfYJ3RgQQSJ6f4pYkI6zza8Uu48PJPQQ8aN7v+uuDfYTFzaPYs067AZ2YwgxQmvM5L6XdJigf52EbtBX9zHTXObd2nvLD5Hk2yV2GBv6sj+qDX3ZxQIw5EQyNrmPeltpN0R94XeLUjPjG7G7W0poKk3nY1YL6Xx3cma61rhRfZDUbJLz/wIbO0ylTR0s/HdyydUS642IWhdmu51yQjSy5UroWhKNVwVqPxbauXamrB73seB2uzj2usslAdi1cjUWUxhDQZHsfnfvmET2FoSNHpZ6jHK0Q+2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 07:57:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19756 invoked by uid 111); 9 Jan 2025 07:57:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 02:57:50 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 02:57:50 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/3] test-lib: simplify lsan results check
Message-ID: <20250109075750.GC2735258@coredump.intra.peff.net>
References: <20250107070409.GA584456@coredump.intra.peff.net>
 <20250107070752.GB584668@coredump.intra.peff.net>
 <Z3zZt2OCjcDGvjBS@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z3zZt2OCjcDGvjBS@pks.im>

On Tue, Jan 07, 2025 at 08:37:33AM +0100, Patrick Steinhardt wrote:

> On Tue, Jan 07, 2025 at 02:07:52AM -0500, Jeff King wrote:
> > We want to know if there are any leaks logged by LSan in the results
> > directory, so we run "find" on the containing directory and pipe it to
> > xargs. We can accomplish the same thing by just globbing in the shell
> > and passing the result to grep, which has a few advantages:
> > 
> >   - it's one fewer process to run
> > 
> >   - we can glob on the TEST_RESULTS_SAN_FILE pattern, which is what we
> >     checked at the beginning of the function, and is the same glob use
> 
> s/use/used
> 
> I'm always a bit thrown off by your style of bulleted lists, where they
> feel like sentences but start with a lower-case letter, and sometimes
> they do and sometimes they don't end with punctuation. Maybe it's just
> me not being a native speaker and it's a natural thing to do in English.
> In any case, it's nothing that really matters in the end, but would be
> happy to learn if this is indeed something you tend to do in English.

Heh. Yeah, I've seen you mention them before and I've been tempted to
start a big discussion. But I never felt like it was worth it. But
tonight's your lucky night. ;)

In short: I think it's a style question. I perceive them as
continuations of the sentence that has the ":". Though admittedly I do
not always grammatically continue that sentence. So for example I could:

  - have one bullet item that completes the sentence.

  - and then another that likewise completes it.

;) I think many style guides would frown on that. Especially with the
periods at the end (you might argue that they should be semicolons).

In the example you quoted above they don't grammatically continue the
sentence, so arguably what I'm saying doesn't even apply. But I also
kind of think of the list items as sentence fragments. That sometimes
happen to make a full sentence. Or need punctuation because that
fragments gets so long it contains multiple sentences.

I dunno. You asked if it is something you tend to do in English. It is
something _I_ tend to do in English, but I think most style guides would
suggest against it (but then, most also suggest against bulleted lists
in the first place). (They probably also suggest against lots of
parentheses).  So I wouldn't necessarily copy me.

My general feeling is that unless a commit message is inaccurate or hard
to understand, we should mostly let it pass (even typos). Yes, they are
an artifact that is enshrined in the history. But at some point they are
also just a written communication between developers, and we all have
our own voices and styles. And make mistakes. Polishing them is
something we _can_ do collaboratively, but there are diminishing
returns.

In case it is not clear, I would not say the same for documentation,
error messages, etc. Those are artifacts that hits a wider audience, and
we have a tool for polishing them together: git.

And people should still proofread and correct their own messages before
sending. Believe it or not, I do always take a final pass when sending
out my commits and still manage to have errors. ;) A lot of times I end
up improving clarity and wording on the final pass, but end up
introducing a typo (I'm pretty sure that the use/used above was me
switching last-minute between "the same glob we use" and "the same glob
used").

Bringing it back to the example at hand, my assumption is that the
bullet list capitalization and punctuation is mostly a question of
style, and isn't making the result hard to understand. But if it is, I
can try to adjust. I actually wrote a bulleted list in a commit message
earlier today and capitalized it just for you. :)

-Peff
