Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3CC3D68
	for <git@vger.kernel.org>; Thu,  2 Jan 2025 02:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735785149; cv=none; b=ULsxPACGy2rMai2dJUBErFvk6q2Gx41gvwm1lQRXy81PZHtiWlvT9B+BhX+3X4q/RpQ0x1g5mq0e3EHdTOHnt90SWT3OWxhqL7af0h/J32cgaQrr/910DCsK6yTKWEmNKWFrNCStNiN4+x2BhVcx4NUgsfPBNgk4rvKCFoeeAos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735785149; c=relaxed/simple;
	bh=+l+UXh3gJLrk2eeJWYlnc9pu8VODiHhnkTO1bY0qqIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Te/9VLmMmLwKrVIkbQfPDOjAvZH2XQJqsWDPJvzzJIsk7FlHvpD2iAmImx+hEgeJkGTnc4io6IAXCEcO2pO2BbF80Xahe9I4lMfJGN/83kvkVAlDia8eJ7Y9kyTV3QIYTc9V5NUqtmAuQoBFL35WX9Inofu+oX2SOMPKHOMbuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=aXANAp9b; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="aXANAp9b"
Received: (qmail 26664 invoked by uid 109); 2 Jan 2025 02:32:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+l+UXh3gJLrk2eeJWYlnc9pu8VODiHhnkTO1bY0qqIk=; b=aXANAp9b37h6RpEmnbcYihqNdARZMsYvIc7csE9CzK7kLS0F1KVnHfoWN3mXFuIq7hMVw054KiaVmTYsuiEUIKp6j91mQ4GKEwCtVO5ocDh0hyhqlyASZnpZzpyAOWIGt+qYcmKFtknrMI7f5me88dKxVk/1ioAnw++MxkgZUQ/JCWP3Rorv8VRnEIS19W7kLlUHQnPgHCZXvSXBwo8xAbm+1fRAVTGh9nnztdH6KQlcFW33KkKckBZi7vQwQhXM98PBjI/9Ryf1gGh4Un753hs9zhWwjRPe3hG3MGPUatDh1a+i03ihy9XwnxJtF+KKwFHmpjDAmsxpO+vF8NYXxQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Jan 2025 02:32:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15183 invoked by uid 111); 2 Jan 2025 02:32:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 21:32:24 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 21:32:24 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: a less-invasive racy-leak fix, was Re: What's cooking in git.git
 (Dec 2024, #11; Mon, 30)
Message-ID: <20250102023224.GA3853144@coredump.intra.peff.net>
References: <xmqqpll9xehr.fsf@gitster.g>
 <20250101191422.GC1391912@coredump.intra.peff.net>
 <xmqqa5cavz8h.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5cavz8h.fsf@gitster.g>

On Wed, Jan 01, 2025 at 04:25:02PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Mon, Dec 30, 2024 at 09:33:20AM -0800, Junio C Hamano wrote:
> >
> >> * jk/lsan-race-with-barrier (2024-12-30) 5 commits
> > ...
> > This graduated faster than I expected. :)
> 
> Heh, it is before -rc2 and the change is only about tests, so ...

Yeah, I figured as much. I also considered it of relatively low
importance during -rc, but I guess CI false positives do tend to annoy
everybody and waste their time. :)

It looks like you pushed out the version of 'master' with it merged. I
had figured you'd revert jk/lsan-race-with-barrier out of next, so I
wondered how we would proceed (revert the whole merge from master to
rebuild, or do a moral revert of the final three).

Looking at jk/lsan-race-ignore-false-positive, it looks like you did the
moral revert via fc89d14c63 (Revert barrier-based LSan threading race
workaround, 2025-01-01). That commit's tree matches what I'd expect (I
guess you probably used "revert -n HEAD~3..HEAD" just like I did).

It would be nice if the 3-commit revert mentioned the specific commits
it was reverting. If you revert the whole merge, you get the merge
commit's id and you can find the original commits by inspecting the
history (but of course here we were reverting only part of it, so we
couldn't do that here). If you revert the sequence without "-n" you get
three individual reverts. Which is informative, but a little clunky in
the history.

I wonder if revert should have a "squash" mode that reverts all of the
commits (perhaps in reverse order of application in case they depend on
each other textually), and then gives you a commit message template
similar to git-fmt-merge-msg, where we list all of the commits, one per
line (though probably with their commit ids in this case).

Probably not a big deal either way, and certainly not a blocker for the
series. Thanks (as usual) for doing all the maintainer juggling.

-Peff
