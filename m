Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACEA343207
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 17:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761325526; cv=none; b=pdQssy2Rl+/xL9WmL3sWA4R0d5X0l5zKh/jGsJVPXFJY6SPf0T+6Ll0hL1nJvIngQczdkk7VKvP/uxWUhXGgw13oWqpXotkWz5PBoxObiB1k94T0dagLVkCRQdRvrtChN9oDO4ZN4NkW6je8r+HS0+oQXV18ch9Syz8Q+Sf7bVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761325526; c=relaxed/simple;
	bh=7FefgFzI2AND2WKKIfKOceqtadDmxreJ4Q3nJHoOwH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=MR0NJp/GhT9V5jdKYq0OV0M3tRNvA16VCItDjoLwWQhdF7oNY77HY/ad9GUuXUzNqwSxSxtv2ucxibeg8jVqSXcXcVyKF9wEtUR4A5GBpTUvt+c/jyLgF4Qzhve/5OAU19wW3gzG+1Jq1hxNmiDSWELFIlQNYU8yual1qY6fwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R1l2/FOB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R1l2/FOB"
Received: (qmail 326104 invoked by uid 109); 24 Oct 2025 17:05:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=7FefgFzI2AND2WKKIfKOceqtadDmxreJ4Q3nJHoOwH4=; b=R1l2/FOBje9opBIHYXXDAVgifvH4JXN4KzrWuIwXW7uTGOGyHO95t0OZ4oBsrLRHpoY/oo2u4EIqmgV61IAjZ/kzNeItCDqQ3Ra9WUD8ABmoHTZJLM4vIgBjJceiK+C+rteFZghVp7N2uKclr4/DaA5a27wZrI5Pe7AMgAjqPeDGq8g6kgCjK2UgmD/wy0KTnb300arT9w6YWD1Bq7coGC3I5+Q63M+mwJpB1LdqLvsuTEOTtJnFdEmEfwiC5NgdMsJxYNJ6Q+KpYvN+r49ShuLwSAG2jrXOXo/05Lp3BIu63dJV9gqoK6FixBvWETmb7sFDrJIBhsCy1eeyrD9qjA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 24 Oct 2025 17:05:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 513130 invoked by uid 111); 24 Oct 2025 17:05:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 24 Oct 2025 13:05:23 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 24 Oct 2025 13:05:22 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Lidong Yan <yldhome2d2@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/4] diff dry-run cleanups
Message-ID: <20251024170522.GA2344972@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Since we were talking about this topic so much this week, I wanted to
collect these patches before they fell out of my head. They would go on
top of ly/diff-name-only-with-diff-from-content.

  [1/4]: diff: send external diff output to diff_options.file

    This one is actually a bug-fix that we found along the way, and
    could be applied completely independently. AFAICT the bug has been
    there since 2008, though, so probably not super urgent. ;)

  [2/4]: diff: drop save/restore of color_moved in dry-run mode

    This one is hopefully a no-brainer simplification.

  [3/4]: diff: replace diff_options.dry_run flag with NULL file
  [4/4]: diff: drop dry-run redirection to /dev/null

    And then these ones clean up our extra layer of fixes, converting
    any missed dry_run checks into segfaults. But we hope there aren't
    any after Lidong's fixes. :) So possibly controversial, but I think
    the end result is nicer to read.

 diff.c                   | 56 +++++++++++-----------------------------
 diff.h                   |  2 --
 t/t4020-diff-external.sh | 10 +++++++
 3 files changed, 25 insertions(+), 43 deletions(-)

-Peff
