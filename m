Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC703A6400
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775001123; cv=none; b=HDO6TA+Y1saiisQk0gI5ZKin+F1fwW3VYmusL9rPUZQQTtVzz6gwP4GbdCAMfikf6kAjV0k7r4F4tl4E52qWyk6YsvScr4ef2yf8Lx32M0xzKIBcpFmae0PPGIrX93rAKOTxs0OvGYB6eYDfOu/2yFiiNDoBUJiQFI8NWOymWIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775001123; c=relaxed/simple;
	bh=inRMFaXsZU1r4Sak8QAOEjNrD7VmAe6l6B4tVcEuAEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wr17zwuea/971H/WaW/ypMyqEo5ea4tcoXl0zHwYek73Dae6X7zaAjn8SgX2KapAoTlwEaySyd+LDqSrEs8KtCrawJ1qblip4KM5f1hiEi7gU308THO31hIv3767kVBRgZzQUJ859QXaqyUEwCZ1LRUwXXXpN0TTf6TEBKT++24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=iIA8k5KB; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="iIA8k5KB"
Received: (qmail 206709 invoked by uid 106); 31 Mar 2026 23:52:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=inRMFaXsZU1r4Sak8QAOEjNrD7VmAe6l6B4tVcEuAEc=; b=iIA8k5KBz+UUeqo7wjXSDbae1jwqsVS54AvITOQktuIy5YHU4TamEdYoPR9h9INzJcXkamvpVdsLDcb3vgLLEoFISGyj1qexVJMbj6/ywQ4UuoUpt98iNOmcq9wEsPjmIYpfkN6xJ2WASHo5HKyo9uhEuCmUIP1r6GmKkA4gOeGwI+rZlWOcLcIv0mPKhmd+BUTcktDDvEx1sF8RUr1d8mxFLlokmSFPgwIoYI42u8GhAfNkAT6pL4oJ0InEja8fTql4rOEEhtXQBlhVSMjaOtAU8KR9xVBQVIKa9oRX84AzWPANDll3y+4Lmv+ugvJfwClg9o30xpy7ajd1YW6zLw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:52:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326606 invoked by uid 111); 31 Mar 2026 23:52:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:52:01 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:52:01 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 10/12] range-diff: drop const to fix strstr() warnings
Message-ID: <20260331235201.GJ2328529@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

This is another case where we implicitly drop the "const" from a pointer
by feeding it to strstr() and assigning the result to a non-const
pointer. This is OK in practice, since the const pointer originally
comes from a writable source (a strbuf), but C23 libc implementations
have started to complain about it.

We do write to the output pointer, so it needs to remain non-const. We
can just switch the input pointer to also be non-const in this case.  By
itself that would run into problems with calls to skip_prefix(), but
since that function has now been taught to match in/out constness
automatically, it just works without us doing anything further.

Signed-off-by: Jeff King <peff@peff.net>
---
 range-diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index 2712a9a107..8e2dd2eb19 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -88,7 +88,7 @@ static int read_patches(const char *range, struct string_list *list,
 	line = contents.buf;
 	size = contents.len;
 	for (; size > 0; size -= len, line += len) {
-		const char *p;
+		char *p;
 		char *eol;
 
 		eol = memchr(line, '\n', size);
-- 
2.53.0.1136.gd760fbd4a0

