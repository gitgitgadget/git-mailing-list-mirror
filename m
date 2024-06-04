Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775EB144D01
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496015; cv=none; b=CXqIJahqKZtwBeM10MAwTmOUXJ4VeCUQHw7oPCht9h2ce1fq7cmHnL4rH9s3fNfApKcx7/i4ppBtsdqEzTJ+uSSqdg5HyXp12yVEQPLiaP/0W1AS1NIHgCUKlT042WJE5f7fLbmSx+VgxZB4wyWR6yUdp+MbeRuq5A6D+pFv3gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496015; c=relaxed/simple;
	bh=T7TbIYQBTc5u7imbbj+7v05rLjlFHADTRid6arMA9t4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tdTuoYA18C2AtsqYJSQ/XU9SfXNhRb+WdmBQTNB9H8CSQ2XyfKcd/lYQ11rSD0dPTsu+bd/Q51BOGwoHhLXVAGX16zg3nqlZbQqWHYehWQQ1NgEzMZBwgT2EDKDvs92zIWzVucq+0b4Ko+jW+9Ci25bhUW/Ez/E7KqBjdZm5Fdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21543 invoked by uid 109); 4 Jun 2024 10:13:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18392 invoked by uid 111); 4 Jun 2024 10:13:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:30 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:32 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 10/13] sparse-checkout: free sparse_filename after use
Message-ID: <20240604101332.GJ1304593@coredump.intra.peff.net>
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

We allocate a heap buffer via get_sparse_checkout_filename(). Most calls
remember to free it, but sparse_checkout_init() forgets to, causing a
leak. Ironically, it remembers to do so in the error return paths, but
not in the path that makes it all the way to the function end!

Fixing this clears up 6 leaks from t1091.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index b84d2e1c80..79342480eb 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -500,6 +500,8 @@ static int sparse_checkout_init(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
+	free(sparse_filename);
+
 	add_pattern("/*", empty_base, 0, &pl, 0);
 	add_pattern("!/*/", empty_base, 0, &pl, 0);
 	pl.use_cone_patterns = init_opts.cone_mode;
-- 
2.45.2.807.g3b5fadc4da

