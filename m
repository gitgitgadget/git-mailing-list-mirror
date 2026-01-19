Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF1426A1A4
	for <git@vger.kernel.org>; Mon, 19 Jan 2026 05:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768799987; cv=none; b=TCpuwRts7UNPRmAVatJ+9Wo79s7rlh1sbFgxwtQoK9HKeCCbzGZFg+VIw/DcN2mCxArSLFVaKi5anoxcdqV+NpmpT+cixnAb3PBShH27Xi3MfXwcgl5wbB3UaJrJtxE4XcVgZqNrAXuKd9P28qaoHc5EwQANrT6WEpQ1lEbDhcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768799987; c=relaxed/simple;
	bh=1ZxWJaI9ZC/4DW/Vz6awqFaG8Ut+F6wxOM9EviayDL0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJTVp9i+qHGXjSPIxYPMKYsD+HSvr+n4sgOZMirNfmVsf7+rQQV4juoznahs7A3BKW0OHW2OHvgJVta+8yvYvP/oIHJbbYerbfszI5Ev3EjxZjYgkvco03hL3KW1BPBkQDb2f8XAhPHkILslqEQq2mSiYUmLr7oKrsGGneVbzbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=VNxlA3To; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="VNxlA3To"
Received: (qmail 94389 invoked by uid 109); 19 Jan 2026 05:19:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1ZxWJaI9ZC/4DW/Vz6awqFaG8Ut+F6wxOM9EviayDL0=; b=VNxlA3TotXFUcaPQJP5j4R7f/8B38e1HwYRDCifOp5mAbTLFX1bQ+697Tlva5hHzDGeDAPpqbujCNN7r7GCgHUPwaUHAlPmMDJ5CcntSRxP26dzJOGonSPjHeryw5OjAgoQkDK2oqZn0VROCXGyFpVvcxnqymYKCwXYT59VY85yVeT6ja7M+rKDJe82wtlbMiKS5njNrlije9D/joXb6sbQbcS0OOuXdkRavi+qOFliAHwGtcHvLn+Cz+zjrse6FhmQrhiRl8ircurZeHZO77EPmo1qYzYHcBoifwFFYKmrgj1d9J2RqPMC8HTeOZV19dOus24Oc2et+8jDsUpyPuQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 Jan 2026 05:19:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 153838 invoked by uid 111); 19 Jan 2026 05:19:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 Jan 2026 00:19:49 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 19 Jan 2026 00:19:45 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>
Subject: [PATCH 1/4] remote: return non-const pointer from error_buf()
Message-ID: <20260119051945.GA1991523@coredump.intra.peff.net>
References: <20260119051858.GA1991308@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260119051858.GA1991308@coredump.intra.peff.net>

We have an error_buf() helper that functions a bit like our error()
helper, but returns NULL instead of -1. Its return type is "const char
*", but this is overly restrictive. If we use the helper in a function
that returns non-const "char *", the compiler will complain about
the implicit cast from const to non-const.

Meanwhile, the const in the helper is doing nothing useful, as it only
ever returns NULL. Let's drop the const, which will let us use it in
both types of function.

Signed-off-by: Jeff King <peff@peff.net>
---
 remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index b756ff6f15..3dc100be83 100644
--- a/remote.c
+++ b/remote.c
@@ -1831,7 +1831,7 @@ int branch_merge_matches(struct branch *branch,
 }
 
 __attribute__((format (printf,2,3)))
-static const char *error_buf(struct strbuf *err, const char *fmt, ...)
+static char *error_buf(struct strbuf *err, const char *fmt, ...)
 {
 	if (err) {
 		va_list ap;
-- 
2.53.0.rc0.338.g08aa8a9473

