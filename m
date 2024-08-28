Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663DF1E49B
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 04:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817653; cv=none; b=mHVjUVPfBwVjA0wtD817nlA87rdDfuKWeN0NmE05PCdQu+TBVCYYGn94JtUju+gZcY03+kCJhp78Ok7jPi7O39wMUgcu48coaGh07yLJN/wLxwHQP4JQBcahV+LDPzkA4EbjAnsMHoXBMOihQFwbSnoMiDqIMHZ5dUWVa5wPrYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817653; c=relaxed/simple;
	bh=p1WMXBfUe3TKe8/WlrmNHnTUwzWxBzSUL2gd/7lBx4E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g4JRTHw3lRIaVVmehg1W+gTupAuGTM04Sj7rpBqVCTwvcB+IR5hBPRzK/R7Y1nYzV6bhSXsU5I072ou5WFzAMV2cwMbHcPzLTmqYfjRWq+KabMM3sT69SmN4hU98xiAHNLXnsegiwVBlPhrZlujcKgHtBxA656e/Q+7U4v0bxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20552 invoked by uid 109); 28 Aug 2024 04:00:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 28 Aug 2024 04:00:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23107 invoked by uid 111); 28 Aug 2024 04:00:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 28 Aug 2024 00:00:53 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 28 Aug 2024 00:00:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 6/6] config.mak.dev: enable -Wunused-parameter by default
Message-ID: <20240828040049.GF3999193@coredump.intra.peff.net>
References: <20240828035722.GA3998881@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240828035722.GA3998881@coredump.intra.peff.net>

Having now removed or annotated all of the unused function parameters in
our code base, I found that each instance falls into one of three
categories:

  1. ignoring the parameter is a bug (e.g., a function takes a ptr/len
     pair, but ignores the length). Detecting these helps us find the
     bugs.

  2. the parameter is unnecessary (and usually left over from a
     refactoring or earlier iteration of a patches series). Removing
     these cleans up the code.

  3. the function has to conform to a specific interface (because it's
     used via a function pointer, or matches something on the other side
     of an #ifdef). These ones are annoying, but annotating them with
     UNUSED is not too bad (especially if the compiler tells you about
     the problem promptly).

Certainly instances of (3) are more common than (1), but after finding
all of these, I think there were enough cases of (1) that it justifies
the work in annotating all of the (3)s.

And since the code base is now at a spot where we compile cleanly with
-Wunused-parameter, turning it on will make it the responsibility of
individual patch writers going forward.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.mak.dev | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 5229c35484..50026d1e0e 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -54,7 +54,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
 DEVELOPER_CFLAGS += -Wno-empty-body
 DEVELOPER_CFLAGS += -Wno-missing-field-initializers
 DEVELOPER_CFLAGS += -Wno-sign-compare
-DEVELOPER_CFLAGS += -Wno-unused-parameter
 endif
 endif
 
-- 
2.46.0.754.g24c813f009
