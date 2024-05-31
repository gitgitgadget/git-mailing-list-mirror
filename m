Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A64157470
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155348; cv=none; b=Z04s012fXCnykBIbfM4uK/SKmy3ZqfIowUPykJbd6Er8u0bNWi249rCvbxZYrWAwJfIw1KMrbowUBrWq3mxiTGf4aOWbPDoU2HxMVlwLA9yo04V+oKx/iKoPrbe8QfGY2sM9ceQUolAddugt3FUs/QFFNXdSo0UBL5Ha/eECw1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155348; c=relaxed/simple;
	bh=9DbxMPxS97T6dG/dxVi9uKsd5vtkHUBlaUyMJ6Sa3vc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cx1PCNuFnwNrmS/XdxTSe/qhBjCCDCJrz/42mUhaYbuG+8ij5iBFcd8bbWF9mxo/ty2LAYWKiKCJH4/1Q09VauKghc/aFLGwmxfeDFm5THb16wREtFBrGlsi/hT4yzBkDQ9iFvrvlLFYWrnOX86njryOwbwELNzxVUEzdrp97Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22771 invoked by uid 109); 31 May 2024 11:35:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:35:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9377 invoked by uid 111); 31 May 2024 11:35:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:35:45 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:35:45 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 10/13] sparse-checkout: free sparse_filename after use
Message-ID: <20240531113545.GJ428814@coredump.intra.peff.net>
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
index 356b7349f9..3af9fec1fb 100644
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
2.45.1.727.ge984192922

