Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E33485295
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 10:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805621; cv=none; b=Pn42H4ulKLLSiDBcoNPrVtz5pIhM2xGKxfacVXRB/0ZgnwS/8WiXe6UK3Lre3Yo/IjYkfIvO6Kyku0FyXuU7rJ5u8jNk8x9z0QrrXHDaKVt5HRJoOHldXFRHSItmCWExlF7PHLjaLLhvhE7FSOXyfWyR3wxAja6wScoshrCKI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805621; c=relaxed/simple;
	bh=zZCCIvlNTnvPtSUTPeiMaE8HbBlxARrePflkvsHte9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gLtLHoK13GexO+ntwSEvLASLAwVhPtYZ6NMSdmHX0splwjmB16MAy9AkX8ekIxjUWnrO3hmWlQLdSIRr1Yq7p/zErBiH/vtsCQ3+VecHUKOTQl4PtPAmtrIG19xhy4lU4NjSGsNv3MglQ2xwYjFslHWxTlRp1pXw3MkJCVwHf6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 7247 invoked by uid 109); 7 Mar 2024 10:00:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 10:00:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13014 invoked by uid 111); 7 Mar 2024 10:00:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 05:00:23 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 05:00:18 -0500
From: Jeff King <peff@peff.net>
To: rsbecker@nexbridge.com
Cc: 'Junio C Hamano' <gitster@pobox.com>,
	"'Randall S. Becker'" <the.n.e.key@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] builtin/unpack-objects.c: change xwrite to
 write_in_full avoid truncation.
Message-ID: <20240307100018.GE2650063@coredump.intra.peff.net>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca>
 <20240227150934.7950-4-randall.becker@nexbridge.ca>
 <xmqq1q8xspht.fsf@gitster.g>
 <03be01da69af$d8366e10$88a34a30$@nexbridge.com>
 <20240227192530.GD3784114@coredump.intra.peff.net>
 <03d701da69c0$c3430e80$49c92b80$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <03d701da69c0$c3430e80$49c92b80$@nexbridge.com>

On Tue, Feb 27, 2024 at 04:05:53PM -0500, rsbecker@nexbridge.com wrote:

> Unfortunately, I do not have sufficient knowledge of the code to
> resolve the originally reported problem without further assistance to
> determine the root case (assuming it still is a problem). Changes in
> master post-2.44.0 appear to have contributed to resolving the
> situation, so I am now getting random pass/fail on the test. I'm going
> to hold 2.44.0 on ia64 and wait for a subsequent release at retest at
> that time.

If you're getting random pass/fail (which does seem like the kind of
thing that could be related to pipe write() sizes), you might try using
the "--stress" argument. That can give you more consistent results while
bisecting (e.g., if "--stress" runs successfully for a few minutes).

That said, given the failing test you mentioned, I kind of assume that
it was not a code change that caused the problem, but rather a new test
exercising new code that happens to tickle your race.

-Peff
