Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192E275AE2
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 17:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758648814; cv=none; b=BejyXwur5fFis/QYujTcrN2mSpj/n79TxlVpbOeE0k92dyHoqiqLPJD9tAg2cl4903ZWtmWBZPIioLBBBmVstNRT4dFDJUULifZDBwyK3oT8fmhyA8zTm93TNzw+e/YNvFwn5442I420jA3XFqO5Vm2yhDw5en7PRu8m4M9lGQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758648814; c=relaxed/simple;
	bh=Y5zVvB9G9uaHN95MDs18wwzt0tDfs296OkbBd6fW5a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AjBiNCSZ+0t/CdtjjUFjd0saYEaa2DhiibD6iHKz2LTtvuW52Q4Q4kQycvwGBDLIF/JHYej/dzzQ2o/XNHWo9fjZrxAymxj44u3WTy3nWXgbV9EzUCeuVdnhXYRRVF/VUH4cIIYHzObqEcNHrmVOVCJ75YlUVy9sg0rymruXqCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fwaEi9q3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fwaEi9q3"
Received: (qmail 7987 invoked by uid 109); 23 Sep 2025 17:33:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Y5zVvB9G9uaHN95MDs18wwzt0tDfs296OkbBd6fW5a4=; b=fwaEi9q3FISPaen6ImZMIi6vjmZk+SDj1H5itfVz8XJnOQak7DqPoPEyb3hnK1gSSwOhAcgyoGpTjRGoYBgwpQBwTKMLzV7h/MX1MZflS8t4OM7ihsahZiyhBDn0HlQBNN9V733S/RwLzJkjV4WV+2fIfWf3Dd44cl4x4ajVpxc8ZR5lS25dtZrH/KuYfp70zFzEcVMZlfnINfRMoBVb/GEV1LML8UTnynH0gcESVaVhD5c2D9cTCdK4+pMIkgVX+t1H9daNIXBv+tchShspNAq8AojVzHZ/uktN6ZbHZP5kKS2ArrCLHrd4B2Q5quXMw4vWP9EclD7EwxHUOSXEzw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 23 Sep 2025 17:33:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11636 invoked by uid 111); 23 Sep 2025 17:33:22 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 23 Sep 2025 13:33:22 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 23 Sep 2025 13:33:22 -0400
From: Jeff King <peff@peff.net>
To: Toon Claes <toon@iotcl.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 4/4] refs: do not clobber dangling symrefs
Message-ID: <20250923173322.GA1136654@coredump.intra.peff.net>
References: <20250819192934.GD1059295@coredump.intra.peff.net>
 <20250922122332.584428-1-toon@iotcl.com>
 <20250922171203.GA2202085@coredump.intra.peff.net>
 <87cy7hy0gc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87cy7hy0gc.fsf@iotcl.com>

On Tue, Sep 23, 2025 at 11:36:51AM +0200, Toon Claes wrote:

> Jeff King <peff@peff.net> writes:
> 
> > So I dunno. My inclination is to say that the double-null-oid invocation
> > is weird and wrong, and callers should update if they need to. But I
> > could be convinced otherwise.
> 
> Thanks for your feedback, and I have to agree. I'll get in touch with
> the Gitaly team to see if we can rid of this odd invocation. For the
> record, this conversation has been happening here[1].
> 
> [1]: https://gitlab.com/gitlab-org/gitaly/-/merge_requests/8161#note_2767808133

Looking over that conversation, I do think you might consider using
symref-delete. As noted there, doing "delete <dangling-symref>" is going
to delete unconditionally, whether it's a symref, a real ref, or nothing
is there at all.

If you know it's a symref pointing to "refs/heads/foo", then the safest
thing is:

  symref-delete FOO_HEAD refs/heads/foo

which guarantees the operation is doing what you expected.

There's an open question there of: how do I know what it's pointing to?
But that's kind of the point of the "old-target" (and "old-oid")
options. They take information you discovered previously non-atomically
and atomically perform the operation while checking (under lock) that
things haven't changed unexpectedly.

So from the test perspective, I think you just know what's in the test
fixture. From the Gitaly API perspective, the caller should have some
idea of what they're deleting (just like they should for a real ref).

-Peff
