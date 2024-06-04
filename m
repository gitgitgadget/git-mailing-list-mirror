Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7C214532F
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496008; cv=none; b=T9OEbbgvuEOiZeWtgD/v4kcicFRC4iDJEGOSAUFyRf5u8lPaLVhaO5ZKQWdafXt5Uv4UU/vSse5yenpGvQZC/ZeQs5OH+/r+Uxt5wgxK4uUH9PD4jxVtArbOiQo0VdvJVhqaVm8fs80RJQ3Eq2yG7ovJHZgFEQiEHm6Hpkf4llw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496008; c=relaxed/simple;
	bh=S1m6CMFs1uu28irQFctu2UeHjXha6ebGGRgGnE0bgMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXHN/tcQ4uGmIe9AlCG6vLtpAT77qpnMtsvrlAA+2CFDAQKeVtji3cKyefYsd5iG/auxWR6bnE8cIr2bW2YFKvJxu96jTyrq2JfVeY4l6mVCp/EiSLGvBxXb+m5Sj8Ob9IH8xhgZvHxu4zZjzxLtybdXIWF/aIyG4x0+EaUfLJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21512 invoked by uid 109); 4 Jun 2024 10:13:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18377 invoked by uid 111); 4 Jun 2024 10:13:23 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:23 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 07/13] sparse-checkout: reuse --stdin buffer when reading
 patterns
Message-ID: <20240604101325.GG1304593@coredump.intra.peff.net>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604100814.GA1304520@coredump.intra.peff.net>

When we read patterns from --stdin, we loop on strbuf_getline(), and
detach each line we read to pass into add_pattern(). This used to be
necessary because add_pattern() required that the pattern strings remain
valid while the pattern_list was in use. But it also created a leak,
since we didn't record the detached buffers anywhere else.

Now that add_pattern() has been modified to make its own copy of the
strings, we can stop detaching and fix the leak. This fixes 4 leaks
detected in t1091.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 923e6ecc0a..75c07d5bb4 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -585,11 +585,10 @@ static void add_patterns_from_input(struct pattern_list *pl,
 		if (file) {
 			struct strbuf line = STRBUF_INIT;
 
-			while (!strbuf_getline(&line, file)) {
-				size_t len;
-				char *buf = strbuf_detach(&line, &len);
-				add_pattern(buf, empty_base, 0, pl, 0);
-			}
+			while (!strbuf_getline(&line, file))
+				add_pattern(line.buf, empty_base, 0, pl, 0);
+
+			strbuf_release(&line);
 		} else {
 			for (i = 0; i < argc; i++)
 				add_pattern(argv[i], empty_base, 0, pl, 0);
-- 
2.45.2.807.g3b5fadc4da

