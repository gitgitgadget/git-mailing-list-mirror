Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1741714535B
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496010; cv=none; b=LQtnJleHvRwyxr+9swXj72zQWUiuO3tvsYtGXwKx6d/j4nCTahXuSV5BnNjmD/mi/CUhf2pU9k3yl62T8VaKUPBf1wJouFQA3WGYDXIJZbp5fehQ9EAdQ9cESdnzVSoWU5MtH5BYAnfuh2NL+FcgfBc8MmUZOfJrFwwQmTvVPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496010; c=relaxed/simple;
	bh=ASJX00FrRKyzwxf8aeQSZd6qCVM9EYKX1CgI5CadC+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ReihEHYlV+3WBfT8dxo+rGOwz7qM70xIEln0HTClJYTSrs+ftt5NHdmZNe/9Ag99+JhQamr96llesBCEtuRL2yBdBrpyihgSbq5MaFMGka0/5to614usPD8Kg75aawH7PZX+1lbnuLUAA7VAux7N9/dHzMCXt1UT2HOWeIjAQbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21522 invoked by uid 109); 4 Jun 2024 10:13:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18382 invoked by uid 111); 4 Jun 2024 10:13:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:25 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:27 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 08/13] sparse-checkout: always free "line" strbuf after
 reading input
Message-ID: <20240604101327.GH1304593@coredump.intra.peff.net>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604100814.GA1304520@coredump.intra.peff.net>

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
2.45.2.807.g3b5fadc4da

