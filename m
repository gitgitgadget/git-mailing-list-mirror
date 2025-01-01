Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAC6208A0
	for <git@vger.kernel.org>; Wed,  1 Jan 2025 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735762711; cv=none; b=lX1j+Cvx6g9ET+jSTwI7FNc++TUi9+kSbN8hcgEe4DRwG2Iezbh+0kHB/CfLFGGkQJTtqvaJz6xoyxC7JTn6Tm0RDfPrMqvFojQ+hayhjnpCUa8PObnFu6yvRdOOqHMoRdJC2aThgTTGp85tMT+i/o+CyYv1nrk2pGqs6QnLoTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735762711; c=relaxed/simple;
	bh=mmke7E8kk/ds2ca4e64S15GYbMccBzLD/fqTkKopWDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLwQD42PBRKS1tndwZ0f42r1yKT+cGmk/1OvK7rBFszXqPl+vIeDJTenaC+8zbBWRt9EOZB8dBUkFb3AvNKecWtYJ+hXeqauHgS4epI/LE7eld3FVVxkjcuv2fNREgcAbmngvs7Tio67VGd1I74Horz8pVw2b3wqI7J3TXioHsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HKBygkvv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HKBygkvv"
Received: (qmail 23118 invoked by uid 109); 1 Jan 2025 20:18:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=mmke7E8kk/ds2ca4e64S15GYbMccBzLD/fqTkKopWDk=; b=HKBygkvvheUBGhHMG7+u2k/JMpWTMnBicX+zXx0gbqG1lwjJLHMfxUU22go5x5pr4nT+fUo2sKyrijbrpWSqzLpdBbJ+F9ultQIVDkIkJ98pmkmavnXEnHmg6dIxgJiIV/MP6Dg7SWNgut5BY/GyuoXGPTTdGVWy5nHLvKDNTEo2y/KbjGqRtoFWbCqhrS38PUDyHmLtvLKR/AM+UMXOsth/3mvDOPcYria/3qsWBbhdOzXB1kjPK462COoD3vhPpJ0EHVedfAZRm/YCMDys/azuhfix18BNbuOMM9QxtN/mJs44f0AkbwWaREtw3kCohedxToiZb+XgyKlthCCLLQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Jan 2025 20:18:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11471 invoked by uid 111); 1 Jan 2025 20:18:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Jan 2025 15:18:28 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 1 Jan 2025 15:18:28 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: [PATCH 5/6] test-lib: check leak logs for presence of DEDUP_TOKEN
Message-ID: <20250101201828.GE3305462@coredump.intra.peff.net>
References: <20250101201226.GA3304465@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250101201226.GA3304465@coredump.intra.peff.net>

When we check the leak logs, our original strategy was to check for any
non-empty log file produced by LSan. We later amended that to ignore
noisy lines in 370ef7e40d (test-lib: ignore uninteresting LSan output,
2023-08-28).

This makes it hard to ignore noise which is more than a single line;
we'd have to actually parse the file to determine the meaning of each
line.

But there's an easy line-oriented solution. Because we always pass the
dedup_token_length option, the output will contain a DEDUP_TOKEN line
for each leak that has been found. So if we invert our strategy to stop
ignoring useless lines and only look for useful ones, we can just count
the number of DEDUP_TOKEN lines. If it's non-zero, then we found at
least one leak (it would even give us a count of unique leaks, but we
really only care if it is non-zero).

This should yield the same outcome, but will help us build more false
positive detection on top.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 23eb26bfbe..c9487d0805 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1177,7 +1177,7 @@ check_test_results_san_file_empty_ () {
 	! find "$TEST_RESULTS_SAN_DIR" \
 		-type f \
 		-name "$TEST_RESULTS_SAN_FILE_PFX.*" 2>/dev/null |
-	xargs grep -qv "Unable to get registers from thread"
+	xargs grep -q ^DEDUP_TOKEN
 }
 
 check_test_results_san_file_ () {
-- 
2.48.0.rc1.363.g2bf91ec010

