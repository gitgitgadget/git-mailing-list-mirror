Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4A028643A
	for <git@vger.kernel.org>; Sun, 22 Mar 2026 20:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774212319; cv=none; b=bKHomevXSmgO2XDyc9G0LK2qdxnsGZl0t4FTEIRCefIp/7Qj77FiL4LVTcPYWM+SUGDx1UFtXU/cXj2lzmR0DUwxY/815iEn70yvhj7jJ32em5P0D5fhCIrR13OEW5urWZEejwTjzdFx2m3zytVdyM9yT0HoDa3HMyiKQPkfcfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774212319; c=relaxed/simple;
	bh=OQSgH1rAk5fdjVeCHO0ec3akKo2/BrIfQCFYcP7cACA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ecl+t9MDqbCx2EId0KR5qmRK7kOsbGhFRz//rlHbEdudvbt32y7AyL7DcZQBwGLWXSf6eh6sYpv/FVqCek9zPSQVrtZUtB6xR3IQS4hJwcBmXvOk+43IHrtzMfZwwk6xN9cFGJf3dUiiI2hYS2gR/ECVgJzdZL73Km9KJF0ypJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G1dd2o+A; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G1dd2o+A"
Received: (qmail 106195 invoked by uid 106); 22 Mar 2026 20:45:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OQSgH1rAk5fdjVeCHO0ec3akKo2/BrIfQCFYcP7cACA=; b=G1dd2o+A83RkXO52aHl4LsAO8GiOT2yMYl0OQ53tXkwLxxYTwSsPpevL2czSkt/onApNCHq6LQxH4tIYCfc4ydtID4cXLHxs7lENdzZ8YqdOwcsDkRD8xOV+STHmqKsc7hoCxCCPF+iU2bXXsJlFNo7HHyJSqcLdXTLW8CDyA5ZCRnqzIzyyLCOxPTHGSFLBHnHiczDRGl0eCOVo+xRqEbBzF/Dak5zFl04DE3OVpXvCcu8MpPXwYUH5pOyFxuSluFQtgKW5GCYIaC9RJbDFK5y2aKMs94YbV19BiAy6sAX5OHOTnoohyFCzH4QAa0jdfILp7ekeyFQP2wkVZva5oA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 22 Mar 2026 20:45:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 139796 invoked by uid 111); 22 Mar 2026 20:45:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 22 Mar 2026 16:45:09 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 22 Mar 2026 16:45:09 -0400
From: Jeff King <peff@peff.net>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org, Scott Baker <scott@perturb.org>
Subject: Re: [PATCH 8/8] diff-highlight: fetch all config with one process
Message-ID: <20260322204509.GA2047044@coredump.intra.peff.net>
References: <20260320004138.GA3653623@coredump.intra.peff.net>
 <20260320004856.GH3654226@coredump.intra.peff.net>
 <9d3633e4-6413-4932-a29d-e0347546ede8@malon.dev>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9d3633e4-6413-4932-a29d-e0347546ede8@malon.dev>

On Mon, Mar 23, 2026 at 01:18:30AM +0800, Tian Yuchen wrote:

> > -	my $s = `git config --get-color $key 2>$NULL`;
> > +
> > +	if (!defined $cached_config) {
> > +		$cached_config = {};
> > +		my $data = `git config --type=color --get-regexp '^color\.diff-highlight\.' 2>$NULL`;
> > +		for my $line (split /\n/, $data) {
> > +			my ($key, $color) = split ' ', $line, 2;
> 
> ...another $key. I think it would be better to change the name here. What do
> you think?

I noticed it, too, but didn't have a better name (in fact they are of
the same type, just two different contexts). Shadowing seemed less bad
to me than using a mis-matched name.

> > +	my $s = $cached_config->{$key};
> >   	return length($s) ? $s : $default;
> >   }
> 
> Something doesn't feel quite right here.
> 
> If the user has not configured color.diff-highlight.*, the expression git
> config --type=color --get-regexp=^color\.diff-highlight\. will not find a
> match and should not output anything. In this case, %cached_config->{$key}
> becomes undef, length() returns 0, and a warning is issued.

The length() of undef is also undef (and documented in "perldoc -f
length"). But either way, length($s) will be false, and we will return
$default, not $s.

I don't get any warning on perl 5.40.1. Are you seeing one on a
different version?

-Peff
