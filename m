Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21D01DD880
	for <git@vger.kernel.org>; Fri, 27 Dec 2024 14:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735310086; cv=none; b=hSILdXHV0iWMtzzuexqkBsED4kb44unyzixgywvKRImVjAi86whIc4mAGTW9eA6MdMKu+OXnX0n12w5PBSjvioEO6xUcQP0HiLc1DDtYqoucQBp1RjT2ToRFDrgoZKpdauu2UxtKmI6sQhjhYYSts+ydibLfAUkYmAEhEtXwPYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735310086; c=relaxed/simple;
	bh=slaj59K1WYYNkSdhswZ2C5+E9iQVp2KMfWe0HakwjZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2vmF3CfPrgLU0beWcIACOxCSt9LM9Ip5S0rbZGMHQtJhhCNdr/gk3YrmfZBzCcbctWirR2acsSGl56toN4Nq5nLFM/t8uSdLaBz/hSH/Xx58FH7vS1glAXC1ELbcOfzYpfSBXxyiYsm3mECfPYCvhGDmBi2osSpCJ7dsf4BH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GhqHCfuE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GhqHCfuE"
Received: (qmail 7974 invoked by uid 109); 27 Dec 2024 14:34:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=slaj59K1WYYNkSdhswZ2C5+E9iQVp2KMfWe0HakwjZk=; b=GhqHCfuEKSjPGPVwxG52Osf7B8yANwU11yKj37ogjsuEFOU+yCd5E0pAtmxfr5KbLKsvFDNKafTNWVaaD1L5lLLBqU6H/zddMvHvxdQu5VsHhSYDekd25QJxRv0fFbsXaxoFnf4RIsggynITo+VfD9IHAPTVeZc3bIKPa5EIDvtt8QwWYxKOVwzB3UsilMIYiG2yIRYbh36Lzky5wKBO91AxJ7FcckmLEyMWnxnQzJu0fjr2f2ud2tVgu6CIPHIWbn0C7QdxzPtrUN73wgCXZvducAciQSVG9qW2V4q2Z0F/dr0TYYh/6cFB+fBtShE7TaR8rpGccQzF5eqk+diHwg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Dec 2024 14:34:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14415 invoked by uid 111); 27 Dec 2024 14:34:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 27 Dec 2024 09:34:40 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 27 Dec 2024 09:34:40 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] prio-queue: use size_t rather than int for size
Message-ID: <20241227143440.GB88306@coredump.intra.peff.net>
References: <20241220084949.GA132704@coredump.intra.peff.net>
 <Z25-PaOQg7lAeyxx@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z25-PaOQg7lAeyxx@pks.im>

On Fri, Dec 27, 2024 at 11:15:31AM +0100, Patrick Steinhardt wrote:

> On Fri, Dec 20, 2024 at 03:49:49AM -0500, Jeff King wrote:
> [snip]
> >   4. The insertion_ctr variable is currently unsigned, but can likewise
> >      grow (it is actually worse, because adding and removing an element
> >      many times will keep increasing the counter, even though "nr" does
> >      not). I've bumped that to size_t here, as well.
> 
> I agree that bumping it to `size_t` would be sensible, but it doesn't
> look like you actually followed through with that change, as...

Doh, good catch. I had backed it out temporarily to confirm that it was
a problem even before the patch, but accidentally ended up with the
wrong state in the commit.

> I was surprised by how few callers there are required any changes due to
> `.nr` changing. I scanned through the code and found one more instance
> where we have to adapt code, in commit-reach.c:queue_has_nonstale(). The
> compiler does not generate warnings for this case because the file isn't
> -Wsign-compare clean yet.

Makes sense.

> Anyway, I see that the patch has landed in "master" already. Let me send
> a follow-up patch series to fix both issues.

Thanks!

-Peff
