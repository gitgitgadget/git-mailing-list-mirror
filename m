Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C90C15575A
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154706; cv=none; b=SQ6ZTLT57AcMcJC7fik+LuM8L/JRrbnwXF/IdA/Vgq80snJMMXry3Vl9cKcV2rQ3fsNPSJwmBfq6vqlfElPrfYPWLKE8qEPOWuAN49Y6m2X9UXX61zus7cV3RGZnkp8ikDgAwBnikwr+lLlv5xjWHtU8CzyPI0izy0ALtwp6jCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154706; c=relaxed/simple;
	bh=yZvCiVdG8k6SirU6jFW/UwNY6LCAqUD249pbBstQH9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iyBAkyjm/zjssUrE4h6bgbn6iY1oL/+HvxAWD2zOv6yaAPKek5SpuA20dxjqvd8CUs8vAzaAVmZZ/DjGcuVGjX3hHbXjElXUockMS7rHBJjF8r6fZ2VYjKttWUzLJnIN/h6o1Pz7R9iSDazWfH5EAu7hSzjqiBgONtCkH5W8tnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22706 invoked by uid 109); 31 May 2024 11:25:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:25:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9237 invoked by uid 111); 31 May 2024 11:25:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:25:03 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:25:02 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 01/13] sparse-checkout: free string list in
 write_cone_to_file()
Message-ID: <20240531112502.GA428814@coredump.intra.peff.net>
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

We use a string list to hold sorted and de-duped patterns, but don't
free it before leaving the function, causing a leak.

This drops the number of leaks found in t7002 from 27 to 25.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 0f52e25249..8747191484 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -311,6 +311,8 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 		fprintf(fp, "%s/\n", pattern);
 		free(pattern);
 	}
+
+	string_list_clear(&sl, 0);
 }
 
 static int write_patterns_and_update(struct pattern_list *pl)
-- 
2.45.1.727.ge984192922

