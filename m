Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D97E198A0E
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 12:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730377500; cv=none; b=ops/S14ihTwZZzYObWiVgXldl4vYZ58coEKvwJDqZcJGEmoshesTKWfpHo+drZ2fV/OcskY8xrWWQ9RyyJzihK7E+iMk1/80U1OX8hCCqX34T3oqrl3dLPQLdGwTJWrDJdzxgU1Q23AnUS+fqmdan1pKby3lNR5RCDgM5XCL8LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730377500; c=relaxed/simple;
	bh=uuDgNKO6THZE3AKJ2QqsvwkGs+0CTZ9ihmdonQAshIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uHQ6v2APP2e4HtsYtrO2MQmFkAYwpYW0sL9vKj07yJqJ/IluhTsJ0U/3JeA6ZI0mHaF76i+YX4QN7ErCPc3qmJZPew5uzf3sshcJZxcjlIiUHfFk8TlOsji+5jPHCdr84EpHKKNH3NsgHzHUrsPJeu8XVC8jJmhStOwKsphbQg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Bq2d1mL5; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Bq2d1mL5"
Received: (qmail 18815 invoked by uid 109); 31 Oct 2024 12:24:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=uuDgNKO6THZE3AKJ2QqsvwkGs+0CTZ9ihmdonQAshIA=; b=Bq2d1mL5U95zbc9uyy9e3vXwjPW91GdgtNC4UhYA7aRFxR4O5lBpccEJIGZf8RqpNllue1uzYNoX6HjLEvTvnBnAlNZoxOZVID6kdPFlBUPL/cMHgBe9div6SnWIFyAFu3t+9KcjVdVRbaXMFLGdR28tYsVc1l/koAGOMD8GMiOQIDumS1fFVLCzmVXRI3akk2f+Kwo49KAFw3BHwEExQvVhGnjN477oxgCtQYZ+ZE4Y/rMTPfq7GJc9BaymptvyC4EaPPQLXWnP4+kOqOLeMpikRxZuTBjjX4L4SJNkQB1EOw9LtzTWSWllFU3aEQwqJwh7hx15zDBLTVWfAqWZNg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 31 Oct 2024 12:24:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32452 invoked by uid 111); 31 Oct 2024 12:24:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 31 Oct 2024 08:24:56 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 31 Oct 2024 08:24:56 -0400
From: Jeff King <peff@peff.net>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	git@vger.kernel.org
Subject: Re: [PATCH] setlocalversion: Add workaround for "git describe"
 performance issue
Message-ID: <20241031122456.GB593548@coredump.intra.peff.net>
References: <309549cafdcfe50c4fceac3263220cc3d8b109b2.1730337435.git.jpoimboe@kernel.org>
 <87bjz0k17c.fsf@prevas.dk>
 <20241031114210.GA593548@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241031114210.GA593548@coredump.intra.peff.net>

On Thu, Oct 31, 2024 at 07:42:10AM -0400, Jeff King wrote:

> That works, but I have a feeling that figured out what the heck is going
> on with gave_up_on might produce a more elegant solution.

OK, I think I might have made some sense of this.

In finish_depth_computation(), we traverse down "list" forever, passing
flags up to our parents, until we find a commit that is marked with the
same "within" flag as our candidate. And then if everything left has
that same "within" flag set, we can bail.

So I _think_ the point is to basically count up what we'd get from this
traversal:

  $tag..$commit

where "$tag" is the candidate tag we found, and "$commit" is what we're
trying to describe (so imagine "git describe --match=$tag $commit").

We can't just use the depth we found while traversing down to $tag,
because there might be side branches we need to count up, too. And we
don't start a new traversal, because we'd be repeating the bits we
already went over when finding $tag in the first place.

And we feed that "list" from the original traversal state. So if we
break out of the traversal early but don't set gave_up_on, then we have
nothing in that state that holds the "within" flag. So we just walk all
of the commits down to the root, because nobody is propagating the flag
to them.

We have to feed at least one commit with the "within" flag into the
traversal so that it can let us end things. But I don't think it really
matters if that commit is the one we found, or if it's a parent of one
that we happened to pass "within" bits down to.

So I think we can just set "gave_up_on" to the final element we found
(whether from max_candidates or from finding every possible name). I.e.,
what I showed earlier, or what you were proposing.


I was also a bit puzzled how this works when there are multiple tags.
We feed only one "best" candidate to finish_depth_computation(), but
gave_up_on does not necessarily have its flag set. But I think that case
the point is that _some_ commit in the list does, and we literally add
every commit to that list.

I'm actually a bit skeptical that any of this is faster than simply
starting over a new traversal of $tag..$commit to find the depth, since
we are considering each commit anew. And there's a bunch of accidentally
quadratic bits of finish_depth_computation(). But frankly I'm somewhat
afraid to touch any of this more than necessary.

-Peff
