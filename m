Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F520146A7A
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215733; cv=none; b=lIGGJfaWfBg3WQAEJiRkBUvJgrPi9luBofbHzAXfCDO4HY1SolhEYRlOf2+NNCkdfsxLUXmH5sJa0OtrZaMPriozRYRHIXWQTSHB8svyVOSXqxFvaZBFQsQldH3frQw5PhzWJAl1AXYXCmY3JOpTOx3n9G4olFBRX2h0o77OLYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215733; c=relaxed/simple;
	bh=rwLyHuWsqVkH1+QthS0qbZpIfN9+w0p04tHr1gWVzPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nYdBCA63to+VCSB2xjaP3E9dBEQ7BUROi1+/XJeEb7r7nvtf2wQgRZ6YdkB/yKP358JIimCMOX6C1hAJnaWvI6qQQGwlKxaMybHStsJrqm1MqQq9IbPH61C++lycDEuLzYfIkVsfOxvtwSRnD5q9iL1Z1cPhVcUqyI7B8RRksEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15599 invoked by uid 109); 24 Sep 2024 22:08:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:08:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18836 invoked by uid 111); 24 Sep 2024 22:08:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:08:50 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:08:49 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 23/28] http-push: free transfer_request strbuf
Message-ID: <20240924220849.GW1143820@coredump.intra.peff.net>
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

When we issue a PUT, we initialize and fill a strbuf embedded in the
transfer_request struct. But we never release this buffer, causing a
leak.

We can fix this by adding a strbuf_release() call to release_request().
If we stopped there, then non-PUT requests would try to release a
zero-initialized strbuf. This works OK in practice, but we should try to
follow the strbuf API more closely. So instead, we'll always initialize
the strbuf when we create the transfer_request struct.

That in turn means switching the strbuf_init() call in start_put() to a
simple strbuf_grow().

This leak is triggered in t5540.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 9aa4d11ccd..8acdb3f265 100644
--- a/http-push.c
+++ b/http-push.c
@@ -375,7 +375,7 @@ static void start_put(struct transfer_request *request)
 	/* Set it up */
 	git_deflate_init(&stream, zlib_compression_level);
 	size = git_deflate_bound(&stream, len + hdrlen);
-	strbuf_init(&request->buffer.buf, size);
+	strbuf_grow(&request->buffer.buf, size);
 	request->buffer.posn = 0;
 
 	/* Compress it */
@@ -515,6 +515,7 @@ static void release_request(struct transfer_request *request)
 
 	free(request->url);
 	free(request->dest);
+	strbuf_release(&request->buffer.buf);
 	free(request);
 }
 
@@ -655,6 +656,7 @@ static void add_fetch_request(struct object *obj)
 	CALLOC_ARRAY(request, 1);
 	request->obj = obj;
 	request->state = NEED_FETCH;
+	strbuf_init(&request->buffer.buf, 0);
 	request->next = request_queue_head;
 	request_queue_head = request;
 
@@ -689,6 +691,7 @@ static int add_send_request(struct object *obj, struct remote_lock *lock)
 	request->obj = obj;
 	request->lock = lock;
 	request->state = NEED_PUSH;
+	strbuf_init(&request->buffer.buf, 0);
 	request->next = request_queue_head;
 	request_queue_head = request;
 
-- 
2.46.2.1011.gf1f9323e02

