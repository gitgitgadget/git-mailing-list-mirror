Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C34B14831E
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 21:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215157; cv=none; b=fGcv+GsUR6tBrNeumL1QgpmyjSSNhzRAX2md4M2vtEeLa+FoUo1fSBvAijLMyBIueTkv+x+gfv7U1KVnYj5s2VU/LBJSdpO6aSiVuziw1cQn9EkreczUHSc+GIqGqeNDpdKymwdgX1qqu1DB7InZhXe4BtFIeTgw5TxjKtXOp60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215157; c=relaxed/simple;
	bh=FvTuMYIjlrEgXXutyQopmn0reLw6+WtFHFZ4Mb4Pslw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tnWeGzYzOsjr/dRQV+fusMgDGue5wBV+Q+m0eO3iXP05DL09UihYKfuZdi8r/+a39i9dxryIzSpdL4Q0SE8QeWTT54Piyc6eccGXkVcECff6ynH+eW4ffvyBF5vhZvgx9HIFKQMIxA9YP9Bt/mYzw4RICnVwvcB+7w50CZL/mgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15499 invoked by uid 109); 24 Sep 2024 21:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 21:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18615 invoked by uid 111); 24 Sep 2024 21:59:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 17:59:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 17:59:14 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 13/28] http: fix leak when redacting cookies from curl trace
Message-ID: <20240924215914.GM1143820@coredump.intra.peff.net>
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

When redacting headers for GIT_TRACE_CURL, we build up a redacted cookie
header in a local strbuf, and then copy it into the output. But we
forget to release the temporary strbuf, leaking it for every cookie
header we show.

The other redacted headers don't run into this problem, since they're
able to work in-place in the output buffer. But the cookie parsing is
too complicated for that, since we redact the cookies individually.

This leak is triggered by the cookie tests in t5551.

Signed-off-by: Jeff King <peff@peff.net>
---
 http.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http.c b/http.c
index 6c6cc5c822..cc136408c0 100644
--- a/http.c
+++ b/http.c
@@ -800,6 +800,7 @@ static int redact_sensitive_header(struct strbuf *header, size_t offset)
 
 		strbuf_setlen(header, sensitive_header - header->buf);
 		strbuf_addbuf(header, &redacted_header);
+		strbuf_release(&redacted_header);
 		ret = 1;
 	}
 	return ret;
-- 
2.46.2.1011.gf1f9323e02

