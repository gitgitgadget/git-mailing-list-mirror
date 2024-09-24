Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E238617557
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727213647; cv=none; b=WdUfMc6xZa91dEkesLu8CbbMKg77izC2nZMMUckJQ6Y0AdEoAYxS2M9NcPDhMtwPAdlLTTuPesPw7sTFWr4ecsZRO9JazUMDkjeke2vIV0oRZjFBpoW3vXF/YS7iewI0S6HsckHiCblh8bfdoEAOdApJwl2Gql8dY8EDmHs5IuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727213647; c=relaxed/simple;
	bh=xr22eu4oxCEE95uez2h80Gs29+//RqG39j57CgPQwQo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=AbzIlR8uFkngQUTN61esrMuaAxpA/pA3/9mXPU835ZXYVLJWY0OpkNgLLlNGZecmAspBttDqHcUcTLF5AIsNLDEEndjarfKypDPLAWDnmNty483wdiwtnLFU50EJp+qwPDO6FmjfrR5httAGqLPIXIUcge+9Obj1irMENGRuUM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 14841 invoked by uid 109); 24 Sep 2024 21:34:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:34:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17686 invoked by uid 111); 24 Sep 2024 21:34:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:34:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:34:04 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/3] LSan quality of life improvements
Message-ID: <20240924213404.GA1142219@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

I was fixing some leaks the other day and came up with a few changes
that made the process a bit less painful, especially when the leaks are
hidden in sub-processes (which is most of them when you are digging into
http push/fetch, as I was).

I hope we're not too far off from a world where leaks are something that
pop up in your newly written code, and you're not slogging through
existing test scripts. But until then, I hope these might help others.

If you want to see the before/after, try:

  cd t
  ./t5550-http-fetch-dumb.sh -i

before and after this series. Before you get no leaks reported to stdout
with "-i", and way too many without it. After, you get the leaks for the
first test that generates them.

  [1/3]: test-lib: stop showing old leak logs
  [2/3]: test-lib: show leak-sanitizer logs on --immediate failure
  [3/3]: test-lib: check for leak logs after every test

 t/test-lib-functions.sh |  3 ++-
 t/test-lib.sh           | 41 ++++++-----------------------------------
 2 files changed, 8 insertions(+), 36 deletions(-)

-Peff
