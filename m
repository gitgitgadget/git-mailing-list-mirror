Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1655A1B81C5
	for <git@vger.kernel.org>; Wed, 21 Aug 2024 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724254806; cv=none; b=u94UIg55CXx8CottLZ3+tNq/tTApm+QJ8y2Taop5tNLkrjim8z9Q2AM3pmxhZngJOcvWxxXrZAl3ob5krgT1WpNUNV8038OTq8lz7ON+ZXis46ZwlL0QZbViuQCXTB1gYADHIjBkut5zVrgOc6wZcCr9xgX7cJxuUxAFl8jfJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724254806; c=relaxed/simple;
	bh=cyozs/XDbXvQtihkSYNLzT1K7zowK3/4YuXxHy8m/PY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXyzklBSkrM5grG8921u5IzHNW4/sh4qnV1V1Hb2qyM6fMsenkz+cA7cExFHOz72Lr2Unnchm8eAr2GMbctl+QlrtRaaChBfN/ulksXKwdJfLGAY+FL8PbI/BdRY0aKyOYJEBae+fmQsq9apL/Bq5rJfMFDz/y1HKFwoHUOx0uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 28029 invoked by uid 109); 21 Aug 2024 15:40:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Aug 2024 15:40:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13997 invoked by uid 111); 21 Aug 2024 15:40:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Aug 2024 11:40:03 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Aug 2024 11:40:01 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de,
	ps@pks.im, james@jamesliu.io, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 0/7] [RFC] advice: refuse to output if stderr not TTY
Message-ID: <20240821154001.GA506216@coredump.intra.peff.net>
References: <pull.1776.git.1724238152.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1776.git.1724238152.gitgitgadget@gmail.com>

On Wed, Aug 21, 2024 at 11:02:25AM +0000, Derrick Stolee via GitGitGadget wrote:

> Advice is supposed to be for humans, not machines. Why do we output it when
> stderr is not a terminal? Let's stop doing that.
> 
> I'm labeling this as an RFC because I believe there is some risk with this
> change. In particular, this does change behavior to reduce the output that
> some scripts may depend upon. But this output is not intended to be locked
> in and we add or edit advice messages without considering this impact, so
> there is risk in the existing system already.

Playing devil's advocate for a moment: what about programs that read
stderr but intend to relay the output to the user?

For example, programs running on the server side of a push are spawned
by receive-pack with their stderr fed into a muxer that ships it to the
client, who then dumps it to the user's terminal. Would we ever want to
see their advice?

My guess is "conceivably yes", though I don't know of a specific example
(and in fact, I've seen the "your hook was ignored because it's not
executable" advice coming from a server, which was actually more of an
annoyance on the client side).

Ditto for upload-pack. Another possible place where it matters:
interfaces that wrap Git and collect the output to show to the user. I
don't use git-gui, but I'd imagine it does this in some places.

Looking over patch 7, I think the escape hatch for all of these cases
would be setting GIT_ADVICE=1. Which isn't too bad, but it does require
some action. I'm not sure if it is worth it (but then, I am not all that
sympathetic to the script you mentioned that was trying to be too clever
about parsing stderr).

-Peff
