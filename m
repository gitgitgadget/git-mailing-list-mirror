Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1581723B0
	for <git@vger.kernel.org>; Fri, 27 Sep 2024 03:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727409086; cv=none; b=VVb3PpHA47tMJKD9Aph/Owes0ZGM23KDU6t8o65mAUSyRYOL+6EahDowKIkpBzbRzb6KPEtKIBB63VHQjPWS56ZxS86/xTAREnlgaVFP35kJ9GU4ZM+qWlHK0sTT8Hec1nobyyaezOeRJVYYhoymnrYjnVzTW6JhihmwKHrHUdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727409086; c=relaxed/simple;
	bh=ezrN5LLGy891cLb4rEdWQotWdFMNYO+HSf6Y8K6pxhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tqfVLIGcuhC6xssokklsMb+ypk3qD4odZo/wsHzzAXpTJ9riZl6N0jtrogIaFGS5EHvGWglFnw5Cwq5AV+95rvjC65kFi4gwSTqS4XmfxGPLOwp85uHOjKSkRGcRQI6pFzPTYD4lraj/G24gE7F81lj6Y8GIRoTNiq2WqfZsrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 4864 invoked by uid 109); 27 Sep 2024 03:51:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 27 Sep 2024 03:51:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9039 invoked by uid 111); 27 Sep 2024 03:51:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Sep 2024 23:51:23 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 26 Sep 2024 23:51:23 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 15/28] http: call git_inflate_end() when releasing
 http_object_request
Message-ID: <20240927035123.GE567395@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
 <20240924220213.GO1143820@coredump.intra.peff.net>
 <ZvVmnCJNRY_V0a8a@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZvVmnCJNRY_V0a8a@pks.im>

On Thu, Sep 26, 2024 at 03:50:20PM +0200, Patrick Steinhardt wrote:

> > We can't just add a git_inflate_end() call to the release function,
> > though. That would double-free the cases that did actually finish.
> > Instead, we'll move the call from the finish function to the release
> > function. This does delay it for the cases that do finish, but I don't
> > think it matters. We should have already reached Z_STREAM_END (and
> > complain if we didn't), and we do not record any status code from
> > git_inflate_end().
> 
> I had to read this paragraph multiple times to understand it, as I
> wondered why you did end up adding it to `release_http_object_request()`
> even though the paragraph claims that you cannot. But what you say is
> that you must _move_ the call, not add it, and that's what the patch
> does.

Yeah, I could see the confusion. It is really "We can't just add a
git_inflate_end() call and be done. We must also...".

I don't think it's worth a re-roll on its own, but if I do re-roll I'll
try to clarify.

-Peff
