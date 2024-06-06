Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6CA17C68
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717661458; cv=none; b=cEDjN4xZWKnUFE/FgNMAoBX9GbzP4VDUyeB5quAd8DkzBpzBer5qSs3pEHzzQpwbGherQh4G7QFXJ6mE8la3R/H/kaW+N/PiH4unNRcaNDfG1HQ1THYq+6YNlJ/ukKt/KzF/TWEjN9na7RGKt6D5/8TnbHN6yNi6AVRJseZ/dK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717661458; c=relaxed/simple;
	bh=trhqOdMfO2WbcUkN/ZFzABAMYsraZCLPO2kmHQDy8uk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4NjM6oMAWvLZY6VFVGQTHd2XlHKfxiC3dhorbdULc1SleCHF964et/qKoL68UlBgXrCblQaCMGwsE7Sz7tG4wIvbKVCrWqbVCfwNJ+hHeewbJVvMOJIV98FkUR0GsXDgGOAFRwGeQDgnQjtbcka4bLL7w6TALw1eRyOFkUqTNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11166 invoked by uid 109); 6 Jun 2024 08:10:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 06 Jun 2024 08:10:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6552 invoked by uid 111); 6 Jun 2024 08:10:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 06 Jun 2024 04:10:53 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 6 Jun 2024 04:10:54 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Aaron Plattner <aplattner@nvidia.com>, git@vger.kernel.org,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: Re: [PATCH v2] credential: clear expired c->credential, unify secret
 clearing
Message-ID: <20240606081054.GC658959@coredump.intra.peff.net>
References: <20240604192929.3252626-1-aplattner@nvidia.com>
 <20240605085733.GE2345232@coredump.intra.peff.net>
 <xmqqtti7tj32.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtti7tj32.fsf@gitster.g>

On Wed, Jun 05, 2024 at 10:06:41AM -0700, Junio C Hamano wrote:

> So we have clear() that is to "clear everything", clear_secret()
> that is to "clear auth material", but we would want another "clear
> every members other than used as query keys" level?
> 
> That way, anytime we add different kind of "auth material" (like
> brian's series did), existing code paths that call clear_secret() do
> not have to change, and if we add different kind of "query keys",
> the reject code would not have to change?  Or is the reject code
> path the only thing that cares about what members are used as query
> keys, in which case we do not need the third helper?

I can't think of another place besides the reject path where we'd want
that (though I'm certainly open to being corrected if somebody finds
such a spot). But mostly I am not all that confident that the set of
items that reject() is clearing is the best one. So I'd just as soon
leave it as a weird internal detail for now, rather than codifying it in
a function.

I dunno. I guess it is the same lines of code in either spot, but
somehow sticking it in a clear_response() helper seems like an
endorsement that the author knew what they were doing. ;)

-Peff
