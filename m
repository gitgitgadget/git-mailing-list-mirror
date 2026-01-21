Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C5A310764
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 05:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768973517; cv=none; b=YlEVpwvs8b5kE6zTKxjZSH3WUV+87FSr43qEQ8NQQGH/yb04U5aH4DNqkKTr3Tg54c4jZkUxbJ6zsrFOEkY7OZVSRsz3XXEhI6mJxUTSvODiWd+VcTMIMUME32Vme/G2p1yOwd3enUWrJ/zo3rxO8QYAlsDesQjAG8mrb9Ahr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768973517; c=relaxed/simple;
	bh=WMtIVNeQh8hcZq093e2YLfl9AlKNI3mZbdrMIwrZ2Rc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hbni+qViOQ4UTHS6SI8a/ZfmIyblLXMmVN5kdaDraUgkj8XAv8zjaESN00my4SFLpte7Cw7jLq0wXbhN21tdZBJ1ob8I7ARE8sLvbb4tKTFu8JHGLigXkMFfijCZ2mX2Dk7lTyM6jLqJpRA3MpVE8FQbxpod1PUr+WwQX5e117E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Gey7p+Xs; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Gey7p+Xs"
Received: (qmail 119323 invoked by uid 109); 21 Jan 2026 05:31:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WMtIVNeQh8hcZq093e2YLfl9AlKNI3mZbdrMIwrZ2Rc=; b=Gey7p+XsP29iRiblgWnKnTgkGDVwl+86t0z0Fb90MMoZ6HGAQZyU+YbxCjjd7E12chCnSihwTZ6O5HW65ieEJWRzggcWC1IN0o9sAe7NR3hUDp8uYPa/m09AYSFIxP64+kyKYoVQ1koVVvRDX97fyvXbigLPjgIMliZkP+phg3dv1icBkapvgg6TfNEU/jWLr96UlFjlessE0+UQoibqqEdb2PloI+cUGjx+P4cMs852LumOViNagwc5b7eQgegz32zJp2kjY/4g1xJDbVkFPygwVZZQw38MsuI3HPKLneSV42I1kvYg1k83vosOD/kq+m2MTHqplIiw+pmUtUeOAQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Jan 2026 05:31:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 193573 invoked by uid 111); 21 Jan 2026 05:31:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Jan 2026 00:31:57 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Jan 2026 00:31:53 -0500
From: Jeff King <peff@peff.net>
To: Chris Packham <judge.packham@gmail.com>
Cc: GIT <git@vger.kernel.org>
Subject: Re: Detecting source of a push in a pre-receive hook
Message-ID: <20260121053153.GA567894@coredump.intra.peff.net>
References: <CAFOYHZDnXQOcDmzwf1WRpZpNRAs-R2YOBh3ru0mr0ffrMLB=9Q@mail.gmail.com>
 <CAFOYHZDcFJBiZwmposZVGmymmRz1XOaXP8iCRgTDVcsWPTH=6g@mail.gmail.com>
 <20260121052705.GA567009@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121052705.GA567009@coredump.intra.peff.net>

On Wed, Jan 21, 2026 at 12:27:05AM -0500, Jeff King wrote:

> But the protocol layer that does that hooking up sometimes leaves
> information in the environment. If clients are connecting over ssh, for
> example, then you'll probably have an $SSH_CLIENT variable set. For
> HTTP, you'd probably get $REMOTE_ADDR, I think.

BTW, one easy way to investigate this is to just put:

  env >&2

into your pre-receive, and then try a push. We forward stderr from the
hook back to the client, so you can see what the server has available in
the environment.

-Peff
