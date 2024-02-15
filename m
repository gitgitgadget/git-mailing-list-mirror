Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39583C15B
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707974804; cv=none; b=QGq44pJMVR4FOwfkLNW6334vHlzRdPow+Hzp/rxFXLbVhnpuT4RL5Zo/rYGzsDql3T+ChE8sF6LnCxPhqAwaszetFnxexJncNVE9Nm9eAt/4V9JQvCJHX9AtrdCY16UeTlhVtHloX7DTIxHKhYWWtut3Uvdh2CNewYe/ko865rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707974804; c=relaxed/simple;
	bh=dKsiWMlJjMkiNdICQjJmhNf67GojhU2l0BtyqWP0Dtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ssf2oDHOhZ2fokQlZhTLNTMj4L6SSi7T/frfleVvz11piPRyb0T01cyuZQ2Rzc2GnUx/49Qe53dAk+7bU8T2nWfBREwrm1qhqgO/SBQi+SmKy0BzBbRIRz56wVX9OCT3Ikn5R1ApEKlQX2nCiDGmAtZn1L9YXvrxtFLKmvB4F28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18148 invoked by uid 109); 15 Feb 2024 05:26:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Feb 2024 05:26:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11864 invoked by uid 111); 15 Feb 2024 05:26:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Feb 2024 00:26:43 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Feb 2024 00:26:40 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Maarten Bosmans <mkbosmans@gmail.com>, git@vger.kernel.org,
	Teng Long <dyroneteng@gmail.com>,
	Maarten Bosmans <maarten.bosmans@vortech.nl>
Subject: Re: [PATCH 1/4] notes: print note blob to stdout directly
Message-ID: <20240215052640.GC2821179@coredump.intra.peff.net>
References: <20240205204932.16653-1-maarten.bosmans@vortech.nl>
 <20240205204932.16653-2-maarten.bosmans@vortech.nl>
 <xmqqil32l0i6.fsf@gitster.g>
 <CA+CvcKTtcHCCKucQ0h1dnaDAMNfErJ+a1CXEVi=ZE5dv57Tb3A@mail.gmail.com>
 <xmqqy1bxiiop.fsf@gitster.g>
 <20240213080014.GB2225494@coredump.intra.peff.net>
 <xmqq5xys6zdr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xys6zdr.fsf@gitster.g>

On Tue, Feb 13, 2024 at 09:35:28AM -0800, Junio C Hamano wrote:

> Remind me if you can if we (1) had plans to allow non-blob objects
> as notes, or (2) actively support to have non-text blob objects as
> notes.  I _think_ we do assume people may try to add non-text blob
> as notes (while they accept that they cannot merge two such notes on
> the same object), but I do not recall if we planned to allow them to
> store trees and commits.

Short answer: no for (1) and yes for (2).

In my head non-blob notes were always something we'd eventually allow.
But I don't think the "git notes" tool really helps you at all (it
insists on being fed message content and makes the blob itself, rather
than letting you specify an oid).

I wondered what the display side might do here (like, say, segfault).
But it looks like the notes code does not even consider a subtree like
this to be a note. It ends up in the "non_note" list of the notes struct
(and format_note() on the display side explicitly ignores non-blobs
anyway).

So it looks like it did not ever work, and nobody can even be using it
accidentally (of course you can put whatever garbage you like under
refs/notes/*, but if neither git-notes nor the display machinery
works with it, I think we can discount that entirely).

Non-text blob objects, on the other hand, should be easy to do with "git
notes add -F". Interestingly, the display code (in format_note() again)
converts embedded NULs into newlines. I think this is an accidental
behavior due to the use of strchrnul().

Of course it's reasonable to also store notes that aren't meant to be
displayed via git-log, etc, at all. The textconv-caching machinery
stores its results in a separate notes ref. Those should generally be
text (since the point is to come up with something diff-able). But I
think it would be perfectly reasonable for another mechanism to make use
of notes in the same way and store binary goo.

(And of course we can store notes on any object, not just commits, as
the textconv cache demonstrates. But I think that is orthogonal to what
you're asking).

-Peff
