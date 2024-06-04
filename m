Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD88145A02
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496018; cv=none; b=lhOLYpaKgDO8qb3vhl1f4cpi33i9biRALnwteKQ7gTqvbNKbH/wSHM643i5bs/3SwVMw3SBCrsimAr4lW1w01imNgwaFx/5boFgtdSTSmt90/TNFSyM8SdPStnQSm/L44YB8D8P7X0Pw8fb4zj4STZkfRpmlpUuhVtwVVkmisvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496018; c=relaxed/simple;
	bh=WFEpOu+PtOu8ON0eS3y9A79Z+jbL2Gz7cGGQrhU2PQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkrBhD3obV/YT0XWQh6HWqn5o9gyLeEfp9myBmOiGC8yBmlTecblRwXw3uSOboHPE8OqRUo9Vdbpuln8YjM/naQSqN4Urq3C7AkAhakziNakABNR+VD9ModvGxhNGN6qzvjeoAqTn02m5Hc3YEmBgNqSvbrpQS/0ROGeFaxGJ94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21552 invoked by uid 109); 4 Jun 2024 10:13:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18397 invoked by uid 111); 4 Jun 2024 10:13:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:33 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:35 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 11/13] sparse-checkout: free pattern list in
 sparse_checkout_list()
Message-ID: <20240604101335.GK1304593@coredump.intra.peff.net>
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

In sparse_checkout_list(), we create a pattern_list that needs to
eventually be cleared. We remember to do so in the regular code path,
but the cone-mode path does an early return, and forgets to clean up.

We could fix the leak by adding a new call to clear_pattern_list(). But
we can simplify even further by just skipping the early return, pushing
the other code path (which consists now of only one line!) into an else
block. That also matches the same cone/non-cone if/else used in some
other functions.

This fixes 15 leaks found in t1091.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 79342480eb..fb43bb7577 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -95,11 +95,10 @@ static int sparse_checkout_list(int argc, const char **argv, const char *prefix)
 			quote_c_style(sl.items[i].string, NULL, stdout, 0);
 			printf("\n");
 		}
-
-		return 0;
+	} else {
+		write_patterns_to_file(stdout, &pl);
 	}
 
-	write_patterns_to_file(stdout, &pl);
 	clear_pattern_list(&pl);
 
 	return 0;
-- 
2.45.2.807.g3b5fadc4da

