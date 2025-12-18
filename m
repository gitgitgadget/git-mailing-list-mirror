Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C5132D0E7
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 12:11:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766059892; cv=none; b=TAUMp/AQVgOhHzlh+hdvgvdX/GDYnj1bECjdK4b6dhfb1Ekz1QFYAYCJYfWzTiqGLCVW17xGg4T12bJ6xbChnE2+E2o2n5APc0PlcRAhyYP9TTdiXXcgQGqWXT+OHySK6neaToGjmLJQ3Ld8XET7TJyV8pUpCp1mTQnpk9kSSDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766059892; c=relaxed/simple;
	bh=NgiukBWleF3/RZwd/FauBfMwhULRmGKPy9vM6QEhc9I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MrorKQllLtJ69aTFYz3k7fl0zCqk1qNSJlc1rctxjTMyQyILpPy7Irfg0LmoZnCv6htIn7gRnyL2UUlwrThPzbLM9e4K0CkMRM9MpkRtLNLgOlDp1PXaTHtzfesKr43r2/E7I3kzZm0mLXqHmd9MtQX/+iNjMP5dQtLrFaf2zF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MdO7qwuX; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MdO7qwuX"
Received: (qmail 390632 invoked by uid 109); 18 Dec 2025 12:11:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=NgiukBWleF3/RZwd/FauBfMwhULRmGKPy9vM6QEhc9I=; b=MdO7qwuXreQ7CSXv3QYm75DujPDhwYpfkgt3b06VGR3JQ0GrF0LROh8N37GaDhcm0fVfRx5W3wlQ7hvFfXblUOuBhQuVw/HJsX5apIY5uuz2YGVhP2Gj99nXy+TWQirTJzXQHIvXMp/pDF1VBB5Zz2DKA9PcOi+1ZdsTvAYv0gN9xirOtTIfw93UiDD0PBjZ81NPykm+/gm08EBohHfKKvD+uSl+DUyTCeA65O/DlDe/B1CPTqjCldbBleLDRwzoqkhRRWSSVEdDm/xfXP8i92a2TMAKWYoTtG9F0zDc3L4ylTS/1EDnzlcZKKx20Mij0JQ92G/mAGg3bTNQ4sF4uw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Dec 2025 12:11:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520570 invoked by uid 111); 18 Dec 2025 12:11:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Dec 2025 07:11:20 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Dec 2025 07:11:20 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Matthew John Cheetham <mjcheetham@outlook.com>,
	Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH 0/3] test-suite fixes for upcoming curl 8.18.0
Message-ID: <20251218121120.GA3252258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

After upgrading my Debian unstable box to libcurl 8.18.0~rc2-1, I
noticed a few new test failures. They seem to mostly be caused by
brittle expectations in the tests. These patches fix the tests to handle
both old and new versions (I tested against curl's 8_17_0 and
rc-8_18_0-2 tags).

Daniel: I'm cc-ing you in case you want to double-check that curl's
behavior changes are all OK before the release. I think it's mostly
fine, though the handling of tab versus space in the third patch is
perhaps questionable.

Matthew: I had to make some educated guesses about one of the tests in
patch 2. You might remember the original intent.

  [1/3]: t5551: handle trailing slashes in expected cookies output
  [2/3]: t5563: add missing end-of-line in HTTP header
  [3/3]: t5563: relax whitespace assumptions for unfolded headers

 t/t5551-http-fetch-smart.sh | 15 +++++++++------
 t/t5563-simple-http-auth.sh | 15 +++++++++++----
 2 files changed, 20 insertions(+), 10 deletions(-)

-Peff
