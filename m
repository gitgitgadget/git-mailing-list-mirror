Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBE01D696
	for <git@vger.kernel.org>; Mon, 24 Jun 2024 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242358; cv=none; b=Q8+m4RlBfHpcxVaXQ6hcHRbWF/7V7Cw1rupmOjKPt1SWsaVE4KuTgEVOsqS6nFIHWtFAFhYKBr86j1YziQsECYQXRmJEevfap55QXptB2+N7VfbuPOfjFRfgh8dSAG47xfko9Wjngg/IfJZ1Myrn/VX7201QRDjp3T9NkuWqxQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242358; c=relaxed/simple;
	bh=1d1dmRAMtl2c7UVZ0IKj+//RvDyVCOuE5FC5DpxbiyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gV8JWy4gAiITjfN0JohNJH4veZxCDVk5iVyMSW17vG4qLR39PuDtBSHNMHJPJTai8xGwgD5+bDOg9NeJfNJrlv6t7IqNPUZw9F53tN6lEmhIoPEHtYD/3U1iwsexKlOSSQ/cIgsBYBdseZbRY5OSUSwwWD5jiU9Wf5+ZjYd5U7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2764 invoked by uid 109); 24 Jun 2024 15:19:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 24 Jun 2024 15:19:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2085 invoked by uid 111); 24 Jun 2024 15:19:08 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 24 Jun 2024 11:19:08 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 24 Jun 2024 11:19:06 -0400
From: Jeff King <peff@peff.net>
To: Eric Wong <e@80x24.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t1006: ensure cat-file info isn't buffered by
 default
Message-ID: <20240624151906.GB19841@coredump.intra.peff.net>
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
 <xmqq1q4v5m5a.fsf@gitster.g>
 <20240618213041.M462972@dcvr>
 <20240621071640.GD2105230@coredump.intra.peff.net>
 <20240621200002.M726804@dcvr>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621200002.M726804@dcvr>

On Fri, Jun 21, 2024 at 08:00:02PM +0000, Eric Wong wrote:

> > We often use "perl -e" for one-liners, etc, but this is pretty big.
> > Maybe:
> > 
> >   cat >foo.pl <<-\EOF
> >   ...
> >   EOF
> >   perl foo.pl -- ...
> > 
> > would be more readable? To be clear I don't think there's anything
> > incorrect about your usage, but it would match the style of our suite a
> > bit better.
> 
> *shrug*  It doesn't save the nested quoting/expansion confusion;
> but it's Junio's call.  I don't think a v3 is worth the effort.

It does allow you to use single quotes in the script, though I think you
managed without it.

> > +test_expect_success PERL '--batch-check is unbuffered by default' '
> > +	echo "$hello_oid" |
> > +	perl run-and-wait.pl git cat-file --batch-check >out &&
> > +	echo "$hello_oid blob $hello_size" >expect &&
> > +	test_cmp expect out
> 
> I prefer to avoid process spawning overhead from test_cmp;
> but that's a small drop in a big bucket.

If we care about that, I'd rather see us make test_cmp zero-process with
a shell helper than come up with ad-hoc solutions. I've tried to measure
something like that before, but couldn't come up with any conclusive
improvements (my findings were mostly that running Git itself accounts
for most of the process overhead).

-Peff
