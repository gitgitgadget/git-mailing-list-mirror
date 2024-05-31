Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF2F155C87
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155114; cv=none; b=MhSjIMmZsRbYGBAI85NYZVL0HKGvYUON9l3IWQPDZH65QrOBpamTAP6gRzlNkrwdAFawt2rPbAASaWP6uLqTwR9xkrGuS8ocsZkpYj9uxgjl3/yLx7qhuZODYLksV7cTq7tHK0OjHgccE2INBL+I1+yMYOpSKAMTGCYD46axySw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155114; c=relaxed/simple;
	bh=NylRKFdMd6oYGxYk8Ef5lHKwt7qywZ13XIr9dlJO6x0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aqUhL0UlqymVt9GjdorQDvMdv+jj+TIGNMwDcKo3z0A0O1G6Aj5eI8SNW+4/NBJ/fMvpqi+cjCM0k/pqC/2SdZ0OSwvOJJigvD9o53yy93AS67rTgHe5p6mJN0pnONT5KYV5ezc3Iw5jJ/P3DdBHPNgrSliwFkiCQvMIH4HMw60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22747 invoked by uid 109); 31 May 2024 11:31:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:31:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9324 invoked by uid 111); 31 May 2024 11:31:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:31:51 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:31:51 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 07/13] sparse-checkout: reuse --stdin buffer when reading
 patterns
Message-ID: <20240531113151.GG428814@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

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
2.45.1.727.ge984192922

