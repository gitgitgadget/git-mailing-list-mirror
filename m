Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8287F
	for <git@vger.kernel.org>; Thu, 30 May 2024 06:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717051176; cv=none; b=Lsxxe7lH4YbABnqUZriHozC6hWNX+C6SUMj/HzkuWZoInWBdo9szuQ8NYdH8XoY9fTid37ncmQ/VGEJAUNpxCarJRvxjBRiHDyQe0k4aoHMbgGLc6lhM+BkM07rctqQNEbdU2DFOulF0Ld+mlcOAZGc9WMQ0XOAE3uLshnHuVvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717051176; c=relaxed/simple;
	bh=kCAxMrEVMRlczHBV+hiQv2em8uVAbX/q3/HqQI7rXB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPu41xmV9PYJEQ9bFIJe8FnHkcM3w2dWxefY2gUqS+KlgOtZpllk0e5Rsu44MfhlKpFs2WsiLGuf29bxZM+vsG+90uzaqyCYgLoizo9840vT7On5GJlGIcHaSFilOsHoMXMcnhm5Da/FZw7pl8FjJpNgdn1+6ZI7ol1iQDTm/ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16754 invoked by uid 109); 30 May 2024 06:39:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 30 May 2024 06:39:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27595 invoked by uid 111); 30 May 2024 06:39:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 May 2024 02:39:30 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 30 May 2024 02:39:32 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/5] t-strvec: use va_end() to match va_start()
Message-ID: <20240530063932.GA1949704@coredump.intra.peff.net>
References: <20240530063857.GA1942535@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240530063857.GA1942535@coredump.intra.peff.net>

Our check_strvec_loc() helper uses a variable argument list. When we
va_start(), we must be sure to va_end() before leaving the function.
This is required by the standard (though the effect of forgetting will
vary between platforms).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/unit-tests/t-strvec.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/unit-tests/t-strvec.c b/t/unit-tests/t-strvec.c
index f17fb10d9e..6c1465ee61 100644
--- a/t/unit-tests/t-strvec.c
+++ b/t/unit-tests/t-strvec.c
@@ -22,11 +22,13 @@ static void check_strvec_loc(const char *loc, struct strvec *vec, ...)
 			strbuf_addf(&msg, "strvec index %"PRIuMAX, (uintmax_t) nr);
 			test_assert(loc, msg.buf, 0);
 			strbuf_release(&msg);
+			va_end(ap);
 			return;
 		}
 
 		nr++;
 	}
+	va_end(ap);
 
 	check_uint(vec->nr, ==, nr);
 	check_uint(vec->alloc, >=, nr);
-- 
2.45.1.692.gbe047d9c60

