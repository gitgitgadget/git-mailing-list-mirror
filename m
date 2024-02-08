Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA810383BB
	for <git@vger.kernel.org>; Thu,  8 Feb 2024 20:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707424012; cv=none; b=u8JVlfbPdqFFu7fvBPYj6UL3HdMr2syH1S2XEpf6+ERgFkYSfOyBzr+tgu2DAxvua8v3px0lWFnAXWA+sgKQNbDvvG5lhtXi+0bbcqGvSDLIGk64Dokgz8sD/CxeLCFdJ7puamvR4vC+CNJro2qZDmeRz4bx2YNIXSDk9zQDA/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707424012; c=relaxed/simple;
	bh=TJCrjHzfZAxim2dG3Ih0cMvdkQtF8vlxE7x3fP/axjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gKiurTaQVaORxGs07O2BpH54M0zqOLGlJQwZ7+o47e4f6680oO9XR8/2rOKAL266BrzCVYEC6CzYm8FNesCvfr9S8YlAIs5WaZkZvvXqj0r+6p4K/ILSl0b3LksO219yxU6xBxcx3jw4NRjYuvRrCptFW9qyWsW0QcadZ4YNGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24284 invoked by uid 109); 8 Feb 2024 20:26:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Feb 2024 20:26:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3007 invoked by uid 111); 8 Feb 2024 20:26:35 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Feb 2024 15:26:35 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 8 Feb 2024 15:26:34 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Sergey Kosukhin <skosukhin@gmail.com>
Subject: Re: [PATCH] tag: fix sign_buffer() call to create a signed tag
Message-ID: <20240208202634.GA1090198@coredump.intra.peff.net>
References: <xmqq4jek9ko1.fsf@gitster.g>
 <20240208004757.GA1059751@coredump.intra.peff.net>
 <xmqq5xyzr6tm.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5xyzr6tm.fsf@gitster.g>

On Wed, Feb 07, 2024 at 07:08:37PM -0800, Junio C Hamano wrote:

> > FWIW, I would have gone the other way, and fixed sign_buffer_ssh(). Your
> > solution here is future-proofing the tag code against other
> > sign_buffer_*() functions behaving like ssh. But it is also leaving
> > other sign_buffer() callers to introduce the same bug.
> >
> > Your documentation change at least makes that less likely. But given how
> > much of our code uses the "negative is error" convention, I wouldn't be
> > surprised to see it happen anyway.
> 
> Yeah, but other callers are prepared to honor the current return
> value convention used by gpg-interface, so "fixing" sign_buffer_ssh()
> would not give us any future-proofing.

It future-proofs against a hypothetical new sign_buffer() caller (just
like your patch future-proofs against a hypothetical new signing
backend).

> We could do belt and suspenders by tightening the other callers to
> only expect negative for errors (but then what should they do when
> they receive non-zero positive?  Should they BUG() out???) while
> teaching sign_buffer_ssh() that our convention is to return negative
> for an error, of course, but I am not sure if it that is worth it.

I'm not sure that's worth it, since we'd only notice if the error
triggered (so writing a test).

-Peff
