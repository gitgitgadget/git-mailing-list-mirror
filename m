Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0692780043
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215350; cv=none; b=hRQmJSY9iN6JW1JVh2yHLrCTmxcy4GiJUZhyqwvT5XPEcaAqsQxJsRduPqr+j9/w0zxh/pR9c4KQRdt1wSL2G8KciP+gobErtrU5oM+lVGA9vEECF+SaRY9tjm16tsBkMDK8jX9o6UbBtxAnJiHHiQROEeysWqnSqOXZvjx3C2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215350; c=relaxed/simple;
	bh=4+HhupHR/7ev57JGoQKGeQr5NzYEjOMlwk19sGKRgSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NVvMm/QDJ0R36PJfAQZ5afCkJE3EkFKYIFreilzc1uS+8pJ7YUsinNZ0EV/lHBb0FWWj6D8D1t3urzXadHwybAhKMKytnvZn4HfQawILZdo/Wux1bc104AnMVu4IcSG5omLKWJbfeOXkXZSNKBPuPO4FC0+bCv4V5dNQTR9Qpm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15540 invoked by uid 109); 24 Sep 2024 22:02:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:02:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18706 invoked by uid 111); 24 Sep 2024 22:02:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:02:27 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:02:27 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 16/28] http: stop leaking buffer in http_get_info_packs()
Message-ID: <20240924220227.GP1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

We use http_get_strbuf() to fetch the remote info/packs content into a
strbuf, but never free it, causing a leak. There's no need to hold onto
it, as we've already parsed it completely.

This lets us mark t5619 as leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c                                     | 1 +
 t/t5619-clone-local-ambiguous-transport.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/http.c b/http.c
index 4d841becca..54463770b4 100644
--- a/http.c
+++ b/http.c
@@ -2475,6 +2475,7 @@ int http_get_info_packs(const char *base_url, struct packed_git **packs_head)
 
 cleanup:
 	free(url);
+	strbuf_release(&buf);
 	return ret;
 }
 
diff --git a/t/t5619-clone-local-ambiguous-transport.sh b/t/t5619-clone-local-ambiguous-transport.sh
index cce62bf78d..1d4efe414d 100755
--- a/t/t5619-clone-local-ambiguous-transport.sh
+++ b/t/t5619-clone-local-ambiguous-transport.sh
@@ -2,6 +2,7 @@
 
 test_description='test local clone with ambiguous transport'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-httpd.sh"
 
-- 
2.46.2.1011.gf1f9323e02

