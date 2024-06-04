Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 116CC143C72
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717495988; cv=none; b=RxaHzFuW+z/9rtF42cviT0rspP0dYkSNiF4MG1I/DXK+Lk6wVIb+/pgDCiCpHYkxBKF2OMCmY1aVFK3B2Ux4e1S0GsHQ8/R3E/uPbVrAsdY+p64fYye3Rc6b/x3E1JDACm4jZAx/gwXRVABcPiTV2+zXJWPb1rFMNN9KK4lGAVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717495988; c=relaxed/simple;
	bh=Su3xFihH12BGsb+BCs1A3A2YWR85Ia/rvF8RsiNk8y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9192OGvxRzt8RIw1NIeuIXh484wObWy+m4WaAogJaX85M6LN0p+asH+Bk0ydeeGdK6wHktE25DDJkrJn3JvVMYg3Hb0e0DicT3W5r2xWACU8aIaauIeQQ+Nm8FZ5uf+XsPe0iVCvq6itOxnIbQmMTqZMXLn6DGpH8kwuXBNS04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21453 invoked by uid 109); 4 Jun 2024 10:13:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18342 invoked by uid 111); 4 Jun 2024 10:13:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:03 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:05 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 01/13] sparse-checkout: free string list in
 write_cone_to_file()
Message-ID: <20240604101305.GA1304593@coredump.intra.peff.net>
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
2.45.2.807.g3b5fadc4da

