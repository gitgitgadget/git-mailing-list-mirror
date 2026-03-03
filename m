Received: from newcloud.peff.net (unknown [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75D351F192E
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 13:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772544944; cv=none; b=rIpT4IkFAXJrLOtG4LL73y8IwCHIijblCLiaLbk3BIP021+pJTe6fw6W6OvVG7p8zEPH5whVkQMWEb8xaMY/J8KHn9LTHVXJzgsm92yvYd0+buv/nK+nPMbEo8r6GYezYKWWKXgteqavuZ+x8p/cqU+islcuWySZ6l6nbwYlEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772544944; c=relaxed/simple;
	bh=iva4iUyKW0jkLvfZzlHSNzqWtZIkIhj0OuIOjBo/uBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiKja2x5C8mrAZUXF4guIYUtO6e/hTumREzWsqMmiet7pn4L9yPRLlgvgLCoWh5+B+E7kzE9TDqv26+tzNTnt9mzJvTj2mCmHtXTASBJir5iTBrjxxXD1a149JVVeWz0RrZVbjWxuUpAO3SjxLmjTnlj1K3CmV0SzR47uasIs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=IyAdG3Gf; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="IyAdG3Gf"
Received: (qmail 47797 invoked by uid 106); 3 Mar 2026 13:35:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=iva4iUyKW0jkLvfZzlHSNzqWtZIkIhj0OuIOjBo/uBk=; b=IyAdG3GffjsRIhJa4yzLbp4KWmV++LU4tljN4bB3yrsechmrPw+qJOZZHPaG0S4OO5f9pVZ8O62PCrltomNAmNxAEd/QXOCZJm8TZpQ5KtY3WnJmE/8Cmcgtad0xCf3h663KQuqILC8QdkQGxuj1wpwnx6F2qlZKORyWO7ehuu8ZlMf1DSBXoqwF84mquUUlx7NzL07vaEuUgJqJ6u9BQuZwe4l3w403GVAOQJ5ueeu9SawBCNZtyxDr6TMnZ/9C0NErsvyNXCwo/kLKCxedcu83ZK6U1xBpqAC7l2CoM7FWBUYynpEIqzWH8Ti9efKXi5rHPeIrAPBK1pJgdTFxOw==
Received: from Unknown (HELO peff.net) (10.0.2.2)
 by newcloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 03 Mar 2026 13:35:41 +0000
Authentication-Results: newcloud.peff.net; auth=none
Received: (qmail 347996 invoked by uid 111); 3 Mar 2026 13:35:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 03 Mar 2026 08:35:41 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 3 Mar 2026 08:35:40 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Matt Smiley <msmiley@gitlab.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] upload-pack: reduce lock contention when writing
 packfile data
Message-ID: <20260303133540.GA818878@coredump.intra.peff.net>
References: <20260227-pks-upload-pack-write-contention-v1-0-7166fe255704@pks.im>
 <20260227-pks-upload-pack-write-contention-v1-2-7166fe255704@pks.im>
 <20260227193758.GA2931515@coredump.intra.peff.net>
 <aaV-l_NyWpkKDDp6@pks.im>
 <20260302182023.GG28275@coredump.intra.peff.net>
 <aaaqgrmOBj-Ly1Vx@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aaaqgrmOBj-Ly1Vx@pks.im>

On Tue, Mar 03, 2026 at 10:31:46AM +0100, Patrick Steinhardt wrote:

> > As far as doing both, I'm not sure if it's worth it. My two concerns
> > are:
> > 
> >   1. It re-opens the question of whether upload-pack might stall waiting
> >      to fill its buffer and fail to produce keepalives correctly.
> 
> I've got a patch for that. The problem can even trigger right now as we
> already do buffer some of the data, and that may cause the keepalives to
> be missed. But this only happens initially in our current
> infrastructure, before we see the "PACK" signature, so it's unlikely to
> be a problem in practice.

I'm not sure what you mean by "this only happens initially" here. If it
is: we can only miss keepalives in that time, then I think that is
probably a real problem. The time we _most_ need keepalives is before we
see the PACK signature, because that is when pack-objects is chewing on
the input, looking for deltas, etc, and not producing any output.

It is usually "solved" by pack-objects producing progress over stderr,
but for "--quiet" fetches, it could produce nothing for a long time.

But anyway, if you are fixing it either way, then I am happy. :)

> We would likely hit this issue if we insist on the buffer being
> completely filled before sending it out. But that's why I adapted the
> logic to say that we send out once we've filled it at least 2/3rds of
> the pktline limit. So in your case above we wouldn't face an issue as
> we'd already send the first 50kB, as it is smaller than 2/3rds of the
> maximum length (~42kB).
> 
> That being said, you'll still be able to construct cases where we have
> weird edge cases. For example if you consistently send one byte less
> than 2/3rds of the capacity.

Right, my numbers were just meant as examples. Whatever the values, it
means that whatever is generating the pack data (pack-objects or
otherwise) really wants to be in sync with how upload-pack is buffering.
Or vice versa. If we just pass back whole chunks of what we read() in
upload-pack, then that happens automatically.

-Peff
