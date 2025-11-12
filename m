Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCA02550BA
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934215; cv=none; b=dGduoC7f2ekh4XmrGjgEeE+dm+cE+86RthCUg+Ck/WbeWz8yYJuyRJi9f2wKfZKUEFXNml8mBFd2X/ZvBCy84CEOVGrUJV0W9RiRCqCCSYp6s/dRSeboYaOiau02ElZgjGldFhFbdM3W5Tf+Ff+8Fb1IM44Yr47IgUJP47maJw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934215; c=relaxed/simple;
	bh=6wFAJVZqXq2zuKUDASzkbK1mSHdKRKpqU5Q6fyDncK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cu8VnDOaxFMl9VMREybS1zveYRM7vhmQDtrT4RhrNVwWr6QJ+EKE7Cjsrsb69rpBUCJIH3qkVIvet8Ly0tKzRJvwK+VCgTn6GpAZBZiFzmY1P5F8GNSIncsPCjTUEhoJa+dUYpoUZqdDKswINtrScuzo+OZMVlL37OP0ylxsCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dASW7ptu; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dASW7ptu"
Received: (qmail 495318 invoked by uid 109); 12 Nov 2025 07:56:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6wFAJVZqXq2zuKUDASzkbK1mSHdKRKpqU5Q6fyDncK8=; b=dASW7ptuKnIWdteezkX6C9y6YRRWtCvACh5mvX8J92vpSParHfeU1lgrQP95cYAKJ09pQpiVzzWzdE2+z5qU8uA+zlFbfhYD7hTTkJAFXlXD9Aw/J28fPNqT05lKTNjgbosnC5dToRrlSIXzQhYmuGkGCNOOxzMaV7Ot353t3EyWKxDJQcaQHEindAPHYHn2APf+gChHYPdE1Lpb/HQWxtz+mZvOllwvcr9JlrjRdAkT+XTFsxH0DRTwmN5NJnq4HgdVSLkofrNZNcSGJjkAtzuF0y3/VVhxcfMFP4GpSxjdaWnkXbukw+Am+VA8Jv+p0wCHZiy/SY6p6DFLeIiKwQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 07:56:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786279 invoked by uid 111); 12 Nov 2025 07:56:52 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 02:56:52 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 02:56:52 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/9] compat/mmap: mark unused argument in git_munmap()
Message-ID: <20251112075652.GA979063@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

Our mmap compat code emulates mapping by using malloc/free. Our
git_munmap() must take a "length" parameter to match the interface of
munmap(), but we don't use it (it is up to the allocator to know how big
the block is in free()).

Let's mark it as UNUSED to avoid complaints from -Wunused-parameter.
Otherwise you cannot build with "make DEVELOPER=1 NO_MMAP=1".

Signed-off-by: Jeff King <peff@peff.net>
---
This made me wonder if nobody is using NO_MMAP at all. But it may just
be that platforms which need it are not using -Werror in the first
place.

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
2.52.0.rc1.260.g3e4993586f

