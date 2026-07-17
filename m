Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A384B30C368
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274894; cv=none; b=I0PKbIOPciGjs5ZOp4yzTfDK5updcQ1E7V8aZpxcqFuq5I97hWVOTChWVG9KUMs9zd19JCt0ZQ/Qz9zolSlAsIOEomhjytniXO41VwbRyPU3bSz1IfLoLkD2HLooxu12cGI4HJJL/zFv+pBlT7o6WCmgVmOuSv/Jp2+k0LdKLrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274894; c=relaxed/simple;
	bh=sYLKnug7yOChqTfDEi9yPOTDOije5ZIxqFcDaEsAnZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3qT0H9VFbd/jGljbGQAZ2x8patyUXIy+sY4it/u1ohP204cPlBaShz1pczwSU6sPm+b51g2Q7LSDMKnMuMjOS5JTkoc9Da6oD6HZ1lyQk19Y9n1b4poFQ7XDneGpDGGB0Bz9pyCXsc91g7XShQ85hLUfPxDsjBnJjKfEYfovig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dJo/bn/p; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dJo/bn/p"
Received: (qmail 51915 invoked by uid 106); 17 Jul 2026 07:54:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=sYLKnug7yOChqTfDEi9yPOTDOije5ZIxqFcDaEsAnZw=; b=dJo/bn/pdXX/X/azgoioPpIEx2ygchrEJBvsjhaZwKMNlLQCFxbUVPNKTRUgg8fzYhgk3absgH1s+kF1LKKC9KCZEo033kPSJcoOZPxIFjEC5Czsrt3M/RG5Ei9TqyRp2sB22h4Vz4ys3ub+aRZYwm5V4YXZ7btB8/dAxxNWrxm7DnAA7eHaBaoZ36oH0oc1I1khw7/Wicn670th9SijlNyXZRCjTwXPJgIaEQRPmvZIHqkpyKiXMpoxwwCqlETN48gL3VUgmX4G02bXMzXks5DyayfrRdjqqFyR2KbKbvfw1q4EeVHlI3MgGXIWcfmriCuKWVN46WmpwnhU1k0fgg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jul 2026 07:54:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 92192 invoked by uid 111); 17 Jul 2026 07:54:54 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jul 2026 03:54:54 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jul 2026 03:54:49 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sahitya Chandra <sahityajb@gmail.com>, git@vger.kernel.org,
	gitster@pobox.com, avarab@gmail.com, stolee@gmail.com
Subject: Re: [PATCH] wt-status: avoid quadratic insertion for untracked paths
Message-ID: <20260717075449.GA1832790@coredump.intra.peff.net>
References: <20260716185045.229320-1-sahityajb@gmail.com>
 <alnLPSnOt_Sf7cA5@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alnLPSnOt_Sf7cA5@pks.im>

On Fri, Jul 17, 2026 at 08:27:09AM +0200, Patrick Steinhardt wrote:

> > fill_directory() currently sorts dir.entries and dir.ignored
> > before returning, so another possible approach would be to append the
> > entries directly and rely on that order, reducing this copy step to O(n).
> > That would require relying on these arrays not containing duplicate
> > entries, though, which I have not been able to verify yet. This patch
> > takes the safer approach of preserving the existing duplicate-removal
> > behavior from `string_list_insert()` by sorting and deduplicating once
> > after appending.
> 
> Out of curiosity: is this something that you have encountered in the
> real world as inefficient, or is this rather a theoretical inefficiency?
> If the former it would be great to add a small benchmark to the commit
> message.

Yeah, I had the same question, and tried for a moment to produce an
example before realizing that it probably is theoretical. If we are
feeding the entries in pre-sorted order then the insert is always O(1).

I think it's still worth doing this, though, as it makes the result much
more obvious to analyze. I think it could even be O(n) if the sort
implementation is optimized under the hood for pre-sorted inputs.

-Peff
