Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5488427F754
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000511; cv=none; b=oS+nMnJXZEjqhx1lnuMoUVGJeoP84leIszibQRWfTrGLilU6BkpT/Jn1NwCYIqYVEpwhBzv83ivvXh4dt+dVOiZ3C1SKG7xi2gnnUkS2k6DzNqK5pRTldDw3s64x58iJBLg+sRsPt34ognhvrkstsM1EjkPH/L2w46JCw8Q0TiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000511; c=relaxed/simple;
	bh=SX3zg7OxoLXPKVxRCZV5xh6bWo3PaOGmz+A9U9uQnS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Znmm5ITjeRZjvXihwb5H6VlczNBKPcr+ZmAyq/XuVMPrOxHW2aSAMpC9TRZcVRR9V2tSD0l+JXAy/SBFG0ttcimEpKIKLdxmf1VXZqvE6JgjkKQk97iqFZ8kjEtMaSi9l6MXY34/avGyB9S9Ax9I/WjCI1qHnz25E0P7TDu1FJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=d/Uasz4q; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="d/Uasz4q"
Received: (qmail 206602 invoked by uid 106); 31 Mar 2026 23:41:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SX3zg7OxoLXPKVxRCZV5xh6bWo3PaOGmz+A9U9uQnS8=; b=d/Uasz4q26nwT5VwWqIPl7GeGbQcqMZzrrduqCJAquuF2/kl1p9xbrZJ4Te3+RgNeIBnneIlPXsrOLtPoIA6sRmH/674GaafJkOhynVgOeaEzhpoaMo7tRWj6OZN4q68Ma13QT+/Sao2Ew/r3gar8H4AOMgLQUb5JHqoh/aPaRA+vMEwMC78QCxWY+P8izU0z28UbuEFC4guFJWLWvzxlAJ30K/8wslVcjPirNLS6ahDfRkmB8B2To3nfOL4delxykb/wn+jP1rkUGEdEG0kAwST8EsmfWqJ9tNnY2+nn8mLkTk8GDhodKkkCG9WpXWVVmkgm3xKHwLYZjNHf4Nu2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:41:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326425 invoked by uid 111); 31 Mar 2026 23:41:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:41:49 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:41:48 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 03/12] transport-helper: drop const to fix strchr() warnings
Message-ID: <20260331234148.GC2328529@coredump.intra.peff.net>
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

We implicitly drop the const from our "key" variable when we do:

  char *p = strchr(key, ' ');

which causes compilation with some C23 versions of libc (notably recent
glibc) to complain.

We need "p" to remain writable, since we assign NULL over the space we
found. We can solve this by also making "key" writable. This works
because it comes from a strbuf, which is itself a writable string.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/transport-helper.c b/transport-helper.c
index 4d95d84f9e..4614036c99 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -781,7 +781,8 @@ static int push_update_ref_status(struct strbuf *buf,
 
 	if (starts_with(buf->buf, "option ")) {
 		struct object_id old_oid, new_oid;
-		const char *key, *val;
+		char *key;
+		const char *val;
 		char *p;
 
 		if (!state->hint || !(state->report || state->new_report))
-- 
2.53.0.1136.gd760fbd4a0

