Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C340136347
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 05:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752642577; cv=none; b=S9hakReaEQL5FbWW43UOhu99u7AuOfP7xwFY+5f3pC7+2+yp8375AjD+YFZGQnEM81uz93F8QbR53T7m9eDfTJeCikN3VD+UGRXCp/6VD99drVfZFbSuset+et68r9uWHkTxafVuJr0Vt/NuQq1j3WkRxRJl6NHWAFmPG+xszOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752642577; c=relaxed/simple;
	bh=pE8+c0JXGlP/5nA4RWW9OHRFnH0AagKC8RKmBGGhogs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QD3E05/il2M5PLfEOvaYeY45Hv52j377Gtj2++1IvcVLPaAUE29dKXplrloQubevpHGkCJjHx7bYNlBActag+C3aSwkKO+el2iP5C5lD6SvI7uOpO0q/rz5AxjlJL8YMQClO73JQEM88+0Rh9odSoSe+lFPFjIuHz5jYyEKl2GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=W/GIfRtb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="W/GIfRtb"
Received: (qmail 553 invoked by uid 109); 16 Jul 2025 05:09:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=pE8+c0JXGlP/5nA4RWW9OHRFnH0AagKC8RKmBGGhogs=; b=W/GIfRtbMgzy6MSr82ZSf/mqZuwOubEY41f/j504khetJwG7rCUbnFhZtz6BqK0zdmYgwlL/4PReFR6oUCuGt3XIH5s8GLltyKmSpz2Puzbhpr3myHnE2zMPrMp7z2ylrcB6Gq73gjA2/UiFU8ybY7OgrAE5SciS+g3Pxw+EGJh+s3hgVARuRpfqBoCsdsAyeVZXxizcxvPsda6Cwqgq87FxMU9RoxD+D831/2Ac41dcVogEMv8hFxWUczQVseNZGEIGBtjQRjAUbYz4RI/GwSIRy1pi4NcpB5W30gNo4fSKW/Ww4Ro489dBQabGWheKcsE8w591Cis7T0UGJjCGuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Jul 2025 05:09:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9711 invoked by uid 111); 16 Jul 2025 05:09:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Jul 2025 01:09:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 16 Jul 2025 01:09:33 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 2/3] prio-queue: add prio_queue_replace()
Message-ID: <20250716050933.GC1396022@coredump.intra.peff.net>
References: <bc079b3c-a472-4f5d-95ca-390f9de25196@web.de>
 <cbabed69-b44a-4920-9a56-e81b404be2de@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbabed69-b44a-4920-9a56-e81b404be2de@web.de>

On Tue, Jul 15, 2025 at 04:51:22PM +0200, René Scharfe wrote:

> Add a function to replace the top element of the queue that basically
> does the same as prio_queue_get() followed by prio_queue_put(), but
> without the work by prio_queue_get() to rebalance the heap.  It can be
> used to optimize loops that get one element and then immediately add
> another one.  That's common e.g., with commit history traversal, where
> we get out a commit and then put in its parents.

Hmm. But surely we still need to rebalance the heap after adding an
element? And indeed, we still call the new sift_down_root() function.

But I guess we are getting away without the "bubble up" operation that
put would do? So we are doing half as much work (but still big-O the
same)?

-Peff
