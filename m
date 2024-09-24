Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54AAB6E614
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215876; cv=none; b=N01jm21F2j0/5pb1Xvn75KxmI95yg7q5kjVypI0UIq34gxkoOZwmiDkOZqlY/7hUv3DS6odFAMpcrH0Qq/8rZPp/ne2hZIv4opVTHeWOXkVS7bLSY3ls12iNFo19gM65ujIrpb2m4BNXGyBXM/S6jDHLSwfrJ4w37ChHoIcBs0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215876; c=relaxed/simple;
	bh=uP7tLNkdvwbKUuNvwXSg41B/7dXBuLdAKqpYb4bhU5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChSiLKYKbMYaIFg4F4Z5M/E0+dZiySNIVWyGKwl3n2Vo0NNNr34iAdua0IInHsgVnHkppCIduIKC8++oMYNqDfVA22mOoJpO7ntJpxFGh26S3WZhUlE4mopeHVCwJ0MtSuoOLjzHMz12AlmqK6tpzdrAspdoELCgTN9Y3jvFy0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15627 invoked by uid 109); 24 Sep 2024 22:11:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:11:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18915 invoked by uid 111); 24 Sep 2024 22:11:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:11:14 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:11:13 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 27/28] http-push: clean up loose request when falling back to
 packed
Message-ID: <20240924221113.GA1143820@coredump.intra.peff.net>
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

In http-push's finish_request(), if we fail a loose object request we
may fall back to trying a packed request. But if we do so, we leave the
http_loose_object_request in place, leaking it.

We can fix this by always cleaning it up. Note that the obj_req pointer
here (which we'll set to NULL) is a copy of the request->userData
pointer, which will now point to freed memory. But that's OK. We'll
either release the parent request struct entirely, or we'll convert it
into a packed request, which will overwrite userData itself.

This leak is found by t5540, but it's not quite leak-free yet.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/http-push.c b/http-push.c
index 1cddd2fb37..b36b1f9e35 100644
--- a/http-push.c
+++ b/http-push.c
@@ -582,9 +582,10 @@ static void finish_request(struct transfer_request *request)
 			if (obj_req->rename == 0)
 				request->obj->flags |= (LOCAL | REMOTE);
 
+		release_http_object_request(&obj_req);
+
 		/* Try fetching packed if necessary */
 		if (request->obj->flags & LOCAL) {
-			release_http_object_request(&obj_req);
 			release_request(request);
 		} else
 			start_fetch_packed(request);
-- 
2.46.2.1011.gf1f9323e02

