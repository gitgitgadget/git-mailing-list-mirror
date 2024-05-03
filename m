Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844917C64
	for <git@vger.kernel.org>; Fri,  3 May 2024 18:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714760024; cv=none; b=BEu2HrnjtOSf7klJDEWb64ylyFIcCXPAdojkTajS9Kva0a85OEfmTSPIJNnV4T8hYV8MHHavZchZQ/vuVUgCeSIxcFIqmlX5Xv7RvVEEMudE6hNOWRFdff6A1SWZhkapgpwJnuH1p8OwbZD/gk3wTAvtJyIscA5LcODPMJ7+ZLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714760024; c=relaxed/simple;
	bh=sCw5Vg0J9QwgAKYyGRHmHIByWJeKJOKglSp8i+DBr4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fx3x0vLFnVLhCf9KxxWMltQ/gURdaOBpZxxk+XK9trOOx1MgJl7KYX+7hOvUu8DsLK6z+tRktBnaARWDTK8L5b1PhgQ71pAKvoneGnYvAcMGGoNs5IKCFltVCuSrCcS63hU+lyTwiHX9vPKTBNXOrQym1qjK6a/P2XpToWjOqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 11912 invoked by uid 109); 3 May 2024 18:13:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 03 May 2024 18:13:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17871 invoked by uid 111); 3 May 2024 18:13:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 03 May 2024 14:13:41 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 3 May 2024 14:13:39 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Justin Tobler <jltobler@gmail.com>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v3 07/10] refs: root refs can be symbolic refs
Message-ID: <20240503181339.GH3631237@coredump.intra.peff.net>
References: <cover.1714398019.git.ps@pks.im>
 <cover.1714637671.git.ps@pks.im>
 <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <92a71222e1067ca4ce9ecaaa555d78d0cce0d9d0.1714637671.git.ps@pks.im>

On Thu, May 02, 2024 at 10:17:42AM +0200, Patrick Steinhardt wrote:

> Before this patch series, root refs except for "HEAD" and our special
> refs were classified as pseudorefs. Furthermore, our terminology
> clarified that pseudorefs must not be symbolic refs. This restriction
> is enforced in `is_root_ref()`, which explicitly checks that a supposed
> root ref resolves to an object ID without recursing.
> 
> This has been extremely confusing right from the start because (in old
> terminology) a ref name may sometimes be a pseudoref and sometimes not
> depending on whether it is a symbolic or regular ref. This behaviour
> does not seem reasonable at all and I very much doubt that it results in
> anything sane.
> 
> Furthermore, the behaviour is different to `is_headref()`, which only
> checks for the ref to exist. While that is in line with our glossary,
> this inconsistency only adds to the confusion.
> 
> Last but not least, the current behaviour can actually lead to a
> segfault when calling `is_root_ref()` with a reference that either does
> not exist or that is a symbolic ref because we never initialized `oid`.
> 
> Let's loosen the restrictions in accordance to the new definition of
> root refs, which are simply plain refs that may as well be a symbolic
> ref. Consequently, we can just check for the ref to exist instead of
> requiring it to be a regular ref.

It's not clear to me that this existence check is particularly useful.
Something that fails read_raw_ref() will fail if:

  - the file does not exist at all. But then how did somebody find out
    about it at all to ask is_pseudoref()?

  - it does exist, but does not look like a ref. Is this important? If I
    do "echo foo >.git/CHERRY_PICK_HEAD", does it become not a root ref
    anymore? Or is it a root ref that is broken? I'd have thought the
    latter, and the syntax is what distinguishes it.

Making the classification purely syntactic based on the name feels
simpler to me to reason about. You'll never run into confusing cases
where repo state changes how commands may behave.

And arguably is_pseudoref_syntax() should be taking into account the
"_HEAD" restriction and special names anyway. It is a bit weird that
even if we tighten up the refname checking to use is_pseudoref_syntax(),
you'd still be able to "git update-ref FOO" but then not see it as a
root ref!

-Peff
