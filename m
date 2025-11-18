Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA46281358
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457121; cv=none; b=ZhOXA4l0eJGNOeOkrbxd0MfHJVtyidSqSdx8Bkryy1e9tfXdD+qYqf8gvjJxPn1cokPYPjZzkY3/P+o0b3HI9b3yOm6r5Jt1ixx9gv+VeaxidTD0DVJ8K31Fwwc+jy5FzpH+sIeEgOkIgKvjDp8MaYMGibEpgOErdcFvEVFbkQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457121; c=relaxed/simple;
	bh=x6LzpMNi63/2CpYx5saLU7ObCgt7gf47WJ8uYDGzbW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BY3+mrHqdnWB4nEgeCRSNR95tY6ENafYW9nqc1tEF5HZHXKsPsYe2slUYAxpcl9tIsS4wY5pE01h3OdsHYUa2h+mQc7odnLoT8KHT8bRG5dRCSfrtdKhG2Lz2GVArW9ECA2a4COpFHaxT6+BBhyiI9gs2AKn7SetYY8uL8vDdY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RGbfRow9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RGbfRow9"
Received: (qmail 19735 invoked by uid 109); 18 Nov 2025 09:11:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=x6LzpMNi63/2CpYx5saLU7ObCgt7gf47WJ8uYDGzbW8=; b=RGbfRow9CuyHiBJaXBEtfq4YNALkmuGT3hL8vzAFFJTz8nPA/WdyFoKCS2YymkcIZUL3olk/tflGTThV3xriI/eUd2Eca2jSYNweJ6aScwxnBn623g6fggRtKpsh7klzIVwQ2GLDWLGNMgKJo3UOMzMHziEElcZqJ7lGiNJBJj0EmuovVqsKl3i6NnxWCRu1Y1jY4pKyUS6yVGA69DUA5mJNEROSeqZjefJC6JYlro4YMy5dbJeH/X8glhkUJliXSmhOAqES3+rkmu67RhGyE2IkSM2NVO2whkxIb/YsN6u9UUjWLgVS19UDnQ+nV91Df1deTBiQAemfSkVTbTgygw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:11:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27374 invoked by uid 111); 18 Nov 2025 09:12:02 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:12:02 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:11:56 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 1/9] compat/mmap: mark unused argument in git_munmap()
Message-ID: <20251118091156.GA529192@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118091127.GA4175601@coredump.intra.peff.net>

Our mmap compat code emulates mapping by using malloc/free. Our
git_munmap() must take a "length" parameter to match the interface of
munmap(), but we don't use it (it is up to the allocator to know how big
the block is in free()).

Let's mark it as UNUSED to avoid complaints from -Wunused-parameter.
Otherwise you cannot build with "make DEVELOPER=1 NO_MMAP=1".

Signed-off-by: Jeff King <peff@peff.net>
---
 compat/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/compat/mmap.c b/compat/mmap.c
index 2fe1c7732e..1a118711f7 100644
--- a/compat/mmap.c
+++ b/compat/mmap.c
@@ -38,7 +38,7 @@ void *git_mmap(void *start, size_t length, int prot, int flags, int fd, off_t of
 	return start;
 }
 
-int git_munmap(void *start, size_t length)
+int git_munmap(void *start, size_t length UNUSED)
 {
 	free(start);
 	return 0;
-- 
2.52.0.278.gadc6434dc3

