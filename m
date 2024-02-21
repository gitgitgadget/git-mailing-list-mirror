Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E1584055
	for <git@vger.kernel.org>; Wed, 21 Feb 2024 17:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708537122; cv=none; b=IkS56FmOd9TwdAO7uRP7E5pqLPPzYoJJVPAFAxUFGygEDFcQOckPYcxfg96+e6DP/APOdYxz0LurROffmC/EPzSkpplaYrD0u7/C8rzJ3TOMiEB2o3Mb6N0lr/ZatBoyB332zVakSzgmDEvLiBkGyR7Lv8BLQlk8TYihybBuVTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708537122; c=relaxed/simple;
	bh=KZ14Fq7t0lKpYKX8RmreSZdNUdImLNCmUi+DtT/YOzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JxOBYrTYqR0NkD3B/6sEmJrU+1fNNeaSWH77qOPs197xD9ui6QaZhk42q5eVLXgMw9QaXzAMCKtz2DXGYdwehPjYnGExhoaivSHcBH2PSv9uX86Jep9Bg02kvAvLLIbcUze3CBSk3y02q7r3dG2Xd4GhcQJ27dE7bjOF/V5ss6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7453 invoked by uid 109); 21 Feb 2024 17:38:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 21 Feb 2024 17:38:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6177 invoked by uid 111); 21 Feb 2024 17:38:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 21 Feb 2024 12:38:40 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 21 Feb 2024 12:38:39 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Yasushi SHOJI <yasushi.shoji@gmail.com>,
	Denton Liu <liu.denton@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: Segfault: git show-branch --reflog refs/pullreqs/1
Message-ID: <20240221173839.GC634809@coredump.intra.peff.net>
References: <CAELBRWK-bZTV0qx6_34HAgpmYwy+5Zo2E0M+4B6yZJJ3CqweTw@mail.gmail.com>
 <20240221084250.GA25385@coredump.intra.peff.net>
 <ZdXLBIv1vLjhQUgx@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZdXLBIv1vLjhQUgx@tanuki>

On Wed, Feb 21, 2024 at 11:05:56AM +0100, Patrick Steinhardt wrote:

> > I am still trying to wrap my head around how it can get such wrong
> > results for show-branch when asking for "git rev-parse branch@{0}", etc,
> > are correct. I think it is that "rev-parse branch@{0}" is only looking
> > at the output oid and does not consider the reflog message at all. So I
> > think it is subtly broken, but in a way that happens to work for that
> > caller. But I'm not sure of the correct fix. At least not at this time
> > of night.
> > 
> > Cc-ing folks involved in 6436a20284.
> 
> Ah, our mails crossed, but we came to the same conclusion. Things indeed
> are subtly broken here and work just by chance because all callers pre
> initialize the object ID. So in the case where the reflog is missing or
> empty we'd use that pre-initialized object ID because `read_ref_at()`
> does not indicate the failure to the callers.
> 
> I think that this behaviour is not sensible in the first place. When
> asking for the reflog, we should only ever return object IDs parsed from
> the reflog. Falling back to parsing the ref itself does not make much
> sense. I've thus sent a patch series that changes the behaviour here.

I left some comments on your patches. But assuming we are OK to change
the branch@{0} behavior for the empty log, the approach is sound.

That still leaves us with the bug in showing the message (which is
easily fixed), and the weird off-by-one output caused by 6436a20284.
Obviously the segfault fix can be taken independently of the rest, but I
wonder if some deeper refactoring of what 6436a20284 did will be
necessary.

-Peff
