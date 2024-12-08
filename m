Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8771586FE
	for <git@vger.kernel.org>; Sun,  8 Dec 2024 19:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733687836; cv=none; b=iRE6gm1ylv7cxJGPAiprvi6mqtdPRZN10BPdJUOnxhPHORxVCqBv9v99Lb/n7d9XyarQl0QcZdZJOYyyDBxRuX1KJSfJc0dzA9UObpVFtkQ9kVrpyeJXdNEZUU+szLMSTpuk1JDswdbz720D/M1nDE6zXhYYaeY4EyxSSNeVHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733687836; c=relaxed/simple;
	bh=7uJbh+ZHSfI+F7UQ6z2qaK6b304BE86p2hBR6aTDBug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXxYr2Z2IkdqPngBBd5CGvJy9uwS9MypDTXBBIgyPFnbZUKB/YQRG4HnsouyQvPk7Cv7patFqysWSrBH0pJdNAW+evEA5ZowJQj+pvgZXUcJE/JigqcIyLeWEvc0OfC+xd/tE0bYtxyTeaAykUCcXMOh2WziGkqbUxTKqYTsAV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GYZNvc5T; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GYZNvc5T"
Received: (qmail 14007 invoked by uid 109); 8 Dec 2024 19:57:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=7uJbh+ZHSfI+F7UQ6z2qaK6b304BE86p2hBR6aTDBug=; b=GYZNvc5T7iYKy7K81sBm+W/N25O/XhKV7GtLViGz2VNbjWOdvHbTrXOXDzJPle6jvPmap7igmeZnqYfOxMx3QmMTZBG647xE1OLE5TV9toEIdMNC+fvJArgwMeGDPrEu5gRuZmh6owMj3s8fe8UObzN4CYwdj3JTJ7HbG6zjnLkACpKZRbt//ZtXowlfZfjlTuXCf8CRfjYfaqgdOebNPcNEPK8hxH4gr7PrBiyEetR3T+VR+qStqLZyUnBqp0jar0fMmbtH/00rLn4qYN88uiRYgs6yro7lcvPOhn2r6sGZPKAqXFT+btC5krZsjJW+UYraafMgRw0Xw/DuylDkrw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 08 Dec 2024 19:57:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17991 invoked by uid 111); 8 Dec 2024 19:57:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 08 Dec 2024 14:57:04 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 8 Dec 2024 14:57:03 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, shejialuo <shejialuo@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 08/16] pkt-line: fix -Wsign-compare warning on 32 bit
 platform
Message-ID: <20241208195703.GA1231962@coredump.intra.peff.net>
References: <20241206-pks-sign-compare-v4-0-0344c6dfb219@pks.im>
 <20241206-pks-sign-compare-v4-8-0344c6dfb219@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241206-pks-sign-compare-v4-8-0344c6dfb219@pks.im>

On Fri, Dec 06, 2024 at 11:27:23AM +0100, Patrick Steinhardt wrote:

> Similar to the preceding commit, we get a warning in `get_packet_data()`
> on 32 bit platforms due to our lenient use of `ssize_t`. This function
> is kind of curious though: we accept an `unsigned size` of bytes to
> read, then store the actual number of bytes read in an `ssize_t` and
> return it as an `int`. This is a whole lot of integer conversions, and
> in theory these can cause us to overflow when the passed-in size is
> larger than `ssize_t`, which on 32 bit platforms is implemented as an
> `int`.

I think part of the reason this code is so lenient is that we know that
pktline lengths will always fit into a 16-bit integer anyway. But I like
that we can (after your patch) look at this function in isolation and
immediately see there are no integer problems.

> None of the callers of that function even care about the number of bytes
> we have read, so returning that number is moot anyway. Refactor the
> function such that it only returns an error code, which plugs the
> potential overflow. While at it, convert the passed-in size parameter to
> be of type `size_t`.

This seems like a good approach to me. Whenever I think "but no callers
do X", I always try to double-check: "might new callers want to do X"?
And in this case, I think the answer is "no". They are asking to read a
whole packet, and it is an error if we don't come up with whole thing.
Showing the partial garbage we did get is unlikely outside of debug
tracing (and in that case we'd probably put the tracing inside this
function anyway).

>  pkt-line.c | 20 +++++++++++---------
>  1 file changed, 11 insertions(+), 9 deletions(-)

The patch itself looks good.

-Peff
