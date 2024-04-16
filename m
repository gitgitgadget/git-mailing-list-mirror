Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B18439ADB
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 05:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244356; cv=none; b=WWdBgGaUWpv5x0pmi1RLzN8K8beVZAZf1VJBuaAO20Y5kIxHvthx0vEAoGh9ANF78w1YV7v+JbVUtePS9BAX/ymw8WVleR+IBkUN2wO2I9SjkUR1OF3rJU22yWPiyo1ipvt4cE2+8QL71zGieN+WVzo2m7iLSUge33TXAuqZq7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244356; c=relaxed/simple;
	bh=Er+muEiC4BQ0WXUmrUi3jnjTFfrzRQzEavrqvrp79ps=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lkqijkj5dDxRjWnOwjB7DAuEcIeLAYuesY8T8Y2qbFo8JITvCuwzAGDuMNQ6I99k2uVjnFaScKJWoM94ixR5gcFoJ5Yx5qw/IKRgoS/6k+RJQvDEnBdT5eR3xuVa0nSCMMG4003OE5pSS6qDEHx3Us2kJ5IkUtTF8k4R6oacHZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3627 invoked by uid 109); 16 Apr 2024 05:12:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Apr 2024 05:12:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26743 invoked by uid 111); 16 Apr 2024 05:12:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Apr 2024 01:12:36 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Apr 2024 01:12:32 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] pack-bitmap: gracefully handle missing BTMP chunks
Message-ID: <20240416051232.GA1745631@coredump.intra.peff.net>
References: <5933a302b581670183a6f3c881f62e96f61ff192.1712642313.git.ps@pks.im>
 <a8251f8278ba9a3b41a8e299cb4918a62df6d1c7.1713163238.git.ps@pks.im>
 <Zh2vZB/60QlLYjUZ@nand.local>
 <Zh4C9xhOC4BVslyX@tanuki>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zh4C9xhOC4BVslyX@tanuki>

On Tue, Apr 16, 2024 at 06:47:51AM +0200, Patrick Steinhardt wrote:

> > > +			GIT_TEST_MIDX_READ_BTMP=false git -c pack.allowPackReuse=$allow_pack_reuse \
> > > +				pack-objects --all --use-bitmap-index --stdout </dev/null >/dev/null 2>err &&
> > 
> > A small note here, but setting stdin to read from /dev/null is
> > unnecessary with `--all.`
> 
> Is it really? Executing `git pack-objects --all --stdout` on my system
> blocks until stdin is closed. It _seems_ to work in the tests alright,
> but doesn't work outside of them. Which is puzzling on its own.

Inside a test_expect block, stdin is already redirected from /dev/null.
See 781f76b158 (test-lib: redirect stdin of tests, 2011-12-15).

I do think it's still good practice to redirect from /dev/null
explicitly to indicate the intent.

-Peff
