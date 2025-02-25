Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81E50257422
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 06:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740464944; cv=none; b=g6Rdj100Mxci/xJyv4nZYUpkJpQNu+dgXcFM9Wa67HFrhhwHwe4XlA5yNnl9KMQHQRPQtc2fPaDYY+SdcsCdVl38f+mcNr6Pr2sfZLNNsWdyXKIbSkXPqKPvnZ9vDbsSLUObQFku1xGY0GuDaoxQqWMc8MDho3w+4y8pY/UP1a0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740464944; c=relaxed/simple;
	bh=s1akJXVmihyq7Ut+m85y2/lZ6g3Y0TiPxOG1hBp6UpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsgdK8+hGiEDU+yD8e259evUN51TX8l98GbSwhAI3gFuZT3xapPclBejKGbG0Nf7OEb/nwnVCgjQGYZjfBXvTIOnaQ4rGu7mIyS/JuDexX1Ko8qZk3txcX+8iqhu0UOfQ2fVog0ts9mB8t8L5bSuOzj3HylikUUvpnmCxWe0GG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TMI/moOJ; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TMI/moOJ"
Received: (qmail 24570 invoked by uid 109); 25 Feb 2025 06:29:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=s1akJXVmihyq7Ut+m85y2/lZ6g3Y0TiPxOG1hBp6UpU=; b=TMI/moOJYzxPe+LKBqYa1qhmv+fjAzJIQMUj9kRkoax8KiBiH2+uGwQ0isLr01qG1l9OjVJjdJ1BooirEEbqeXyIgb66j0f3H0KpC2FpazRsFHljkwXGDU6tUbj1dCYYgeUZAZTMy4wRxI++F2xCsLt/+LcU8lMUOecTRlQ9CWoLPbL7yJE+PE8ZgLONpQPdMA0H3lzGM8xx/K0z0AH0jX6D59m1s6zp+1tHpNrOnBC/hJIBqq3lIsJPH4KBlEdE3Q/M9XwxiVAenfL9LwXaAXjeXDhdlQ++Xgp+pLBBIUYT1TJXj/l3LgmvQAaWYM58SvBJ7T+B+QLlIMNahw21jA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 25 Feb 2025 06:29:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2692 invoked by uid 111); 25 Feb 2025 06:29:01 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 25 Feb 2025 01:29:01 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 25 Feb 2025 01:29:00 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 02/10] unpack_loose_header(): simplify next_out assignment
Message-ID: <20250225062900.GB1293961@coredump.intra.peff.net>
References: <20250225062518.GA1293854@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225062518.GA1293854@coredump.intra.peff.net>

When using OBJECT_INFO_ALLOW_UNKNOWN_TYPE to unpack a header that
doesn't fit into our initial 32-byte buffer, we loop over calls
git_inflate(), feeding it our buffer to the "next_out" pointer each
time. As the code is written, we reset next_out after each inflate call
(and after reading the output), ready for the next loop.

This isn't wrong, but there are a few advantages to setting up
"next_out" right before each inflate call, rather than after:

  1. It drops a few duplicated lines of code.

  2. It makes it obvious that we always feed a fresh buffer on each call
     (and thus can never see Z_BUF_ERROR due to due to a lack of output
     space).

  3. After we exit the loop, we'll leave stream->next_out pointing to
     the end of the fetched data (this is how zlib callers find out how
     much data is in the buffer). This doesn't matter in practice, since
     nobody looks at it again. But it's probably the least-surprising
     thing to do, as it matches how next_out is left when the whole
     thing fits in the initial 32-byte buffer (and we don't enter the
     loop at all).

Signed-off-by: Jeff King <peff@peff.net>
---
Not strictly necessary, but I think it makes some of the reasoning in
patch 4 easier.

 object-file.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/object-file.c b/object-file.c
index 45b251ba04..0fd42981fb 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1385,18 +1385,17 @@ enum unpack_loose_header_result unpack_loose_header(git_zstream *stream,
 	 * reading the stream.
 	 */
 	strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
-	stream->next_out = buffer;
-	stream->avail_out = bufsiz;
 
 	do {
+		stream->next_out = buffer;
+		stream->avail_out = bufsiz;
+
 		obj_read_unlock();
 		status = git_inflate(stream, 0);
 		obj_read_lock();
 		strbuf_add(header, buffer, stream->next_out - (unsigned char *)buffer);
 		if (memchr(buffer, '\0', stream->next_out - (unsigned char *)buffer))
 			return 0;
-		stream->next_out = buffer;
-		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
 	return ULHR_TOO_LONG;
 }
-- 
2.48.1.709.gf47ae731ff

