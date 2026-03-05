Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA72D273803
	for <git@vger.kernel.org>; Thu,  5 Mar 2026 23:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772751799; cv=none; b=OYyMbNLuY0fdhZFTBlzxK6fEq80V1PhO4k+YDQCNiSIaxgSxd5PnLH8cWy0WsQSDtGWWmMpmMlwyLTwaToJrxYyFtuz/k5yJGiSZZ1Fp8yRJdDDA0dTEjWK45o/4XU+lo7x0qqJOT19I0KKainKmhBJe49SZBdwUN7e9mjz3hgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772751799; c=relaxed/simple;
	bh=kLKzA1+SiH5F5Oe48wwzgpGglQKUJ6+AeyZxDwUB09A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khxQIMFMUD6gyyKoMF8WHBOa6t+FNuhU9Q2zScs3JYViS2B68WaJkEMYZLlmg5Y8//v4FV+PKhkioYMGIo/acBHtMlD1u63oVGLQzStTIKGf2uBqHqx3LysmoWj/OKwoh1VnZ0pOIszFAAiC0G5RStLUo60U1KWGxfqHmn0bT7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Vs2Fnupp; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Vs2Fnupp"
Received: (qmail 2658 invoked by uid 106); 5 Mar 2026 23:03:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=kLKzA1+SiH5F5Oe48wwzgpGglQKUJ6+AeyZxDwUB09A=; b=Vs2Fnuppg5Ysxa6Etre/q4Kmbjl9uJ92TKpsrnAYomoAhgWBHlUKJg/te18o/gXRTIe/sQ1imwl+BVnHwz35pKVDqjuxI7mi1UgOp7cBHoeDKRefDZTP/+o7qah7sPez8Rz1qcxGcnv0g+L4bq5RHhZkxc0/6S41QpptNLmiXj05MfVwJcK4ms4kqcx66ehIdx2uLuTaTsUscosHTR58WKdJFMbQmvL1AZhoLxLzGzt6DyADTaGZwQkX6yF5J/wXcDN0RfvfXhsSkPdWFlSzRmmIBd5YG0bwurSrdhsNoSFSoLWn6FCOMOiW1sQJPhc9gsS5jSMv8BNK+CTxKDRnig==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Mar 2026 23:03:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 393351 invoked by uid 111); 5 Mar 2026 23:03:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Mar 2026 18:03:17 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Mar 2026 18:03:15 -0500
From: Jeff King <peff@peff.net>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: git@vger.kernel.org
Subject: [PATCH 0/4] plugging some mmap() leaks
Message-ID: <20260305230315.GA2354983@coredump.intra.peff.net>
References: <b9fa930e-7d5e-47f1-8896-1997cf7c0cdb@intel.com>
 <20260305220214.GB736322@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260305220214.GB736322@coredump.intra.peff.net>

On Thu, Mar 05, 2026 at 05:02:14PM -0500, Jeff King wrote:

> Anyway, I think the solution is probably something like the patch above,
> though probably it needs to cover the case where new_pack is NULL.

So here is a more polished version. I decided to try running the whole
test suite with leak-checking and NO_MMAP, and it turned up one other
case. This series fixes that, too, and then turns on the flag for all
leak-checking builds.

  [1/4]: check_connected(): delay opening new_pack
  [2/4]: check_connected(): fix leak of pack-index mmap
  [3/4]: pack-revindex: avoid double-loading .rev files
  [4/4]: Makefile: turn on NO_MMAP when building with LSan

 Makefile        |  1 +
 connected.c     | 38 +++++++++++++++++++-------------------
 pack-revindex.c |  4 ++++
 3 files changed, 24 insertions(+), 19 deletions(-)

-Peff
