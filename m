Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5488173C
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155250; cv=none; b=JJYoZ2gMg9R+bMw5LNl4UKsGIfxRrRZjq6RGNm43Qg3nE5dnABJ1O/gBiZcbVg/IZZVS4RZXzEPaY9wNc5OKAKJ1bvD6z7BQD/DsyfoqsLai2vyZvVTUW8I6TOiTq+gFwS+XV6Y1ib3Uykfp6JzBrDozApuXtFo3zPHvDDDdwMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155250; c=relaxed/simple;
	bh=DGzpVrIlztXUXJWj5atlN7K02UijGmDEFVa7km389Ww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZqJPUd1dNj+vsEk5XpbrHmg6WjJlJPaQinuFvdY3cOf+IpDrEoUTJOXPoe3zyjF2+wPZMqr/nN+90W6wspH1/aux9R4Li2cdOQCl4ZgXdLRbTxE7bl9OojolsCJTJV4CjNy4QhGUFCVtM8kxu1kf3fsKeCABf/uV3abrCbILp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22758 invoked by uid 109); 31 May 2024 11:34:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:34:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9329 invoked by uid 111); 31 May 2024 11:34:07 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:34:07 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:34:07 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 08/13] sparse-checkout: always free "line" strbuf after
 reading input
Message-ID: <20240531113407.GH428814@coredump.intra.peff.net>
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

In add_patterns_from_input(), we may read lines from a file with a loop
like this:

  while (!strbuf_getline(&line, file)) {
	...
	strbuf_to_cone_pattern(&line, pl);
  }
  /* we don't strbuf_release(&line) here! */

This generally is OK because strbuf_to_cone_pattern() consumes the
buffer via strbuf_detach(). But we can leak in a few cases:

  1. We don't always consume the buffer! If the line ends up empty after
     trimming, we leave strbuf_to_cone_pattern() without detaching. In
     most cases this is OK, because a subsequent getline() call will use
     the same buffer. But if you had an empty line at the end of file,
     for example, it would leak.

  2. Even if strbuf_to_cone_pattern() always consumed the buffer,
     there's a subtle issue with strbuf_getline(). As we saw in
     94e2aa555e (strbuf: fix leak when `appendwholeline()` fails with
     EOF, 2024-05-27), it's possible for it to return EOF with an
     allocated buffer (e.g., if the underlying getdelim() call saw an
     error). So we should always strbuf_release() after finishing a read
     loop like this.

Note that even the code to read patterns from argv has the same problem.
Because that also uses strbuf_to_cone_pattern(), we stuff each argv
entry into a strbuf. It uses the same "line" strbuf as the getline code,
but we should position the strbuf_release() to cover both code paths.

This fixes at least 9 leaks found in t1091.

Signed-off-by: Jeff King <peff@peff.net>
---
This touches on the strbuf_appendwholeline() thing we were talking about
in the earlier thread. But even if we taught strbuf_getline() to never
return an allocated buf on EOF, we'd still need this because of point
(1) above. I do suspect this anti-pattern may exist in more places,
though (it was also present in the preimage of patch 7).

 builtin/sparse-checkout.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 75c07d5bb4..8f8f5c359f 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -581,6 +581,7 @@ static void add_patterns_from_input(struct pattern_list *pl,
 				strbuf_to_cone_pattern(&line, pl);
 			}
 		}
+		strbuf_release(&line);
 	} else {
 		if (file) {
 			struct strbuf line = STRBUF_INIT;
-- 
2.45.1.727.ge984192922

