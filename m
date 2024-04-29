Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2A79470
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714378615; cv=none; b=kPF9VX+Nn9BXsskrJiOc8Gsbw3clWpehdW+4rjrHx0VnKn/uBHtnyQRhSIu4Z6pU5w7wnG/qAd9NbCwPpuH0bGF1sE4/4hh748mAwLTx6BLxjlkzXyxY54pEXvTXnjcdbWUHVkWG2aWZRGwJH1EgESASzqwIv6D0/L58CV0hA/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714378615; c=relaxed/simple;
	bh=mzJACVV6cSWrvOcOCYanSBJo9lrOwny8rLcSFQO3U0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aAy/6HLI6MfeGcmXH2W7GlCcc+Zc22w7MQpTeNRIg4DMnqmuBdT0sZcnu/x/G7Y+C1yIp54KekdsLxAnn21YZTaPCNsB24XjkvmEAwB1dMyulbbQQ07DhEbG5459NxCEEFCLw3I0aoIBxkVhej+mHwu6ejGKaqEZDeTMWkmPtSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20179 invoked by uid 109); 29 Apr 2024 08:16:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:16:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26788 invoked by uid 111); 29 Apr 2024 08:16:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:16:57 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:16:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 1/8] t0600: don't create ref outside of refs/
Message-ID: <20240429081652.GA228803@coredump.intra.peff.net>
References: <20240429081512.GA4130242@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240429081512.GA4130242@coredump.intra.peff.net>

We have a test that tries to manipulate the branch refs/heads/referrent,
mostly using either the fully qualified refname or git-branch (which
implies refs/heads/). However, the call to update-ref uses the
unqualified name, meaning we were quietly creating ".git/referrent",
which was otherwise unused by the test.

Fix this to specify refs/heads/referrent.

I _think_ it actually doesn't affect the test outcome either way. The
point of the test is that expiring reflogs for "the_symref" should not
fail when we cannot lock "refs/heads/referrent" that it points to
(because we have created a fake .lock file for it). And that is true
even if the "referrent" file does not even exist. After all, the process
holding the lock could be in the act of creating it.

So I suspect this "update-ref" line could just be dropped entirely.
Which you can verify by going back to its origin in 41d796ed5c (refs:
on symref reflog expire, lock symref not referrent, 2016-04-07) and
removing it. The test fails without the matching code change and passes
with it.

But I think it's worth keeping the update-ref call, as it creates a
situation which is more likely to match what we'd see in the real world.
Even if it does not matter now, it's possible it could in the future.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t0600-reffiles-backend.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 64214340e7..41db9e30d4 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -343,7 +343,7 @@ test_expect_success SHA1 'parsing reverse reflogs at BUFSIZ boundaries' '
 test_expect_success 'reflog expire operates on symref not referrent' '
 	git branch --create-reflog the_symref &&
 	git branch --create-reflog referrent &&
-	git update-ref referrent HEAD &&
+	git update-ref refs/heads/referrent HEAD &&
 	git symbolic-ref refs/heads/the_symref refs/heads/referrent &&
 	test_when_finished "rm -f .git/refs/heads/referrent.lock" &&
 	touch .git/refs/heads/referrent.lock &&
-- 
2.45.0.rc1.416.gbe2a76c799

