Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A204B28685
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 04:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724904146; cv=none; b=H5JNSI4f9m7Oa2emp/0otlZf0T/ItF9WDQjjmL91TDD3zNcBBm3/XuFr8VwVa+/SUKizUOJa4fENNEtp9n3ls7AryFzb5yH9XgwURgzSiGc7sUsdzAmrYlF5RjXJf/xc8O2Y2+ySQH6vc+0MmcZ4aeJWzhFu8MwmPjNTilmiuM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724904146; c=relaxed/simple;
	bh=7rqwKGKuMivPMtEXh7GvWLiBsBzQ1uQjSs7LMXQeLQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=utP4auOnUOlFVOhvBvzZttBwFJ+f06shcP68FqF0YXnUsJf8QalWUZNUl3jeRRTPgKBCSpdUJ1hexfleaiSrMYyok6oG/asKPZuWAvsiXH5ngTpuD/8aFPWmsAIFWH/EuTQ2atXs7v+W/gLGXR7fawi/kyByD+nngDOCgCZajvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 31871 invoked by uid 109); 29 Aug 2024 04:02:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 29 Aug 2024 04:02:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2722 invoked by uid 111); 29 Aug 2024 04:02:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 00:02:19 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 00:02:15 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: shejialuo <shejialuo@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
Message-ID: <20240829040215.GA4054823@coredump.intra.peff.net>
References: <ZsIMc6cJ-kzMzW_8@ArchLinux>
 <Zs348uXMBdCuwF-2@ArchLinux>
 <xmqqbk1cz69c.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqbk1cz69c.fsf@gitster.g>

On Wed, Aug 28, 2024 at 02:28:47PM -0700, Junio C Hamano wrote:

> By the way, Peff, do we have MAYBE_UNUSED that can be used in a case
> like this one?  Platforms without symbolic links supported may well
> define NO_SYMLINK_HEAD, which makes the incoming parameters unused.

Yes, it would be fine to use MAYBE_UNUSED in a case like this.

The other option, and what I did for a conditional compilation in
imap-send.c, is to just mention the variable like:

  /* mark as used to appease -Wunused-parameter with NO_SYMLINK_HEAD */
  (void)lock;
  (void)target;

In retrospect I think MAYBE_UNUSED is probably a little less magical,
and I perhaps should have used it there.

In this particular case, though, where there's no actual code in one
half of the #ifdef, I think just defining two separate functions is
cleaner. I.e., what you did with a macro below, though I'd probably have
just used a real function with UNUSED markers.

As an aside, I wonder if we should consider deprecating and eventually
dropping support for core.prefersymlinkrefs. I can't think of a reason
anybody would want to use it, and of course it makes no sense as we move
on to alternate backends like reftables. I sent patches ages ago:

  https://lore.kernel.org/git/20151229060055.GA17047@sigill.intra.peff.net/

but I think it may have just gotten lost in the shuffle, and I've
somehow been meaning to re-submit them for 9 years. :-/

-Peff
