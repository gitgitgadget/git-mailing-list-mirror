Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C6F3EEAEF
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 08:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782895657; cv=none; b=bzOfdWaxlmGbgrGRto7mFLx8AbIJn2d3sD/K18ouga9hzWu7GXNte5pPHscNleaDXezFXW7n55Uk0a4FawqC/nA+u5BBhMcY3ELs3B3j6SYgo6OpV2EIc2R8c1tBNF3XPhCR7zI98LBo1w0Q80QNnspZ5HS7cddSsyRFn8HOb+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782895657; c=relaxed/simple;
	bh=73VLubdnS5uis5KrC+/Fz4HhYsmumCqD8hIGZlM70y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdQ59nl1GmkzZKCVQ2FxRK5Fd1ZS1dTYAjOn3pxtuhWZXCo9GtxtXU/TfoR+zcmQqC7SDkA4IKNpQU/WttXPk0ySW7RY7COf1ggjYiawKIyHFBTE9xk624hj4xcCThOUPtS57ELycXJBbnd/g8Q/6xlxBZTkd6z9/x14YYRVZcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fyWg5771; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fyWg5771"
Received: (qmail 77933 invoked by uid 106); 1 Jul 2026 08:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=73VLubdnS5uis5KrC+/Fz4HhYsmumCqD8hIGZlM70y0=; b=fyWg5771xqGuuxDeCzpp1RTRfcQ9Bc8jud6md6pDj4VzMLY8Xv6zr/MqujZzHrh5FLLuV6kst/1DL1sRw6FscP74S98JIgrebO6ypG5pTaPkBOgHMEWf+qiEcbzKWejAO/umlQ7disK7v/WFN9KuU7RVewPL4AijanfUcW+La5LT6xxyRHnpQukDV9BiCkzFPQDzhnUuPyIDOK/ujg25PtL/9DcXF4aD5mshHMwfBnaVDdOomkboWTFSR+3skG71palzp9o+pMH2JZWzYbXjL0yhhp/m1gFRPd3EYjjsM2f42HmGOCJKSScXqXnfT84jpqqdSVT8qsYUoTWFOWsO3g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jul 2026 08:47:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 159106 invoked by uid 111); 1 Jul 2026 08:47:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jul 2026 04:47:34 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jul 2026 04:47:33 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH 2/2] format-patch: fix leak of rev_info in prepare_bases()
Message-ID: <20260701084733.GA814472@coredump.intra.peff.net>
References: <20260630063944.GA3733670@coredump.intra.peff.net>
 <20260630064301.GB3733961@coredump.intra.peff.net>
 <akOZy-BygZS8fqPM@pks.im>
 <20260701081358.GB813310@coredump.intra.peff.net>
 <akTS_rPV7JaGHKRq@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <akTS_rPV7JaGHKRq@pks.im>

On Wed, Jul 01, 2026 at 10:42:38AM +0200, Patrick Steinhardt wrote:

> > We already run a special leak job for linux-reftables. Why not turn that
> > job into "leaks plus reftables plus test-vars"? The only downside would
> > be potentially hiding leaks found by linux-reftables-leaks if the
> > test-vars features force us into a difference code path. But looking at
> > the list, it doesn't seem likely to me. None of them is particularly
> > ref-related.
> > 
> > In fact, I kind of wonder if we could fold linux-reftables into the
> > test-vars job completely.
> 
> linux-reftable or linux-reftable-leaks? I think it would certainly make
> sense to drop one of these and merge it into linux-TEST-vars. The
> linux-reftable job doesn't provide any benefit over its -leak variant,
> so that would be the candidate I'd personally merge.

Both. Fold linux-reftable into linux-TEST-vars, and then drop
linux-reftable-leaks in favor of a new linux-TEST-vars-leaks.

-Peff
