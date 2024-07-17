Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A902C9A
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 05:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721195165; cv=none; b=CkzwKWcgy804ZN/2UXFBNalQtpLgVYtSn/UxxQPOFvmjLzm9E72EjLRSq3q7dqBDqM+BRLFIamuHaKZp5CWGcY0JNd9dx8KZEriCjdk0+Vcl2MeIdVoFy+3W6br350xOq5xnx1LOMQp9FkQdKF0RouNhkok0um/ZxLrzD9c8YrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721195165; c=relaxed/simple;
	bh=mwWLR8qr6ElZKdfZ1xnOO2fVzMc0dqtfmHfG6rGf8oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qLZ6TFivYT6/0R+bK37AKXawYbKpaQc9DF0N3zoVeqY7RqI1thQWnu60UPAXkepHm4IaNzAPpHNcdrBYy6YohMIGkfCW4tDmeHcRfR80hXSX9KBUumVqd+NujACnOjCKaKpKnmlD+BtpQg6D9a+qpCknaI4q5c3ZYKVe0O4jsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23305 invoked by uid 109); 17 Jul 2024 05:45:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 17 Jul 2024 05:45:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18734 invoked by uid 111); 17 Jul 2024 05:45:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 17 Jul 2024 01:45:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 17 Jul 2024 01:45:55 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] Revert "reflog expire: don't use
 lookup_commit_reference_gently()"
Message-ID: <20240717054555.GA547635@coredump.intra.peff.net>
References: <xmqqv8156rh2.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv8156rh2.fsf@gitster.g>

On Tue, Jul 16, 2024 at 12:56:25PM -0700, Junio C Hamano wrote:

> During Git 2.35 timeframe, daf1d828 (reflog expire: don't use
> lookup_commit_reference_gently(), 2021-12-22) replaced a call to
> lookup_commit_reference_gently() with a call to lookup_commit().
> 
> What it failed to consider was that our refs do not necessarily
> point at commits (most notably, we have annotated and signed tags),
> and more importantly that lookup_commit() does not dereference a tag
> to return a commit; instead it returns NULL when a tag is given.
> 
> Since the commit returned is used as a starting point for the
> reachability check, this ejected the commits that are reachable only
> by an annotated tag out of the set of reachable commits, breaking
> the computation to correctly implement the "--expire-unreachable"
> option.  We also started giving an error message that the API
> function expected to be fed a commit object.

Yikes. I guess this is at least only for reflog pruning, so you couldn't
corrupt a repo this way, only lose reflog entries. But still, I think
your revert here is the right thing.

It does make me wonder if there other gaps for reflogs that point to
non-commits. E.g., if I have a tag pointing to a blob, would we save its
reflog entry if a reachable commit points to that blob?. I suspect not,
as the full reachability check is very expensive.

But certainly your patch is not making anything worse there.

-Peff
