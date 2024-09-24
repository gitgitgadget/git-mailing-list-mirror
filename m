Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B0242A8F
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 22:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727215489; cv=none; b=IECyX3/h/YDrnfHGUmMG4Pa0dJ5xSji021TEy1bwN2+V4Tds/oivAx207RJMtvYFbI8aVXSQuep/C+Hovla/sVCt3MDWvewU3JXZIHlI6JA6e0vK/Efr8Kb5r3CUWxsrcIZMKXedLkHuoWXtnLFijy2423K3Nkl7EuNdU/cIYVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727215489; c=relaxed/simple;
	bh=c4vloYVRGtopetei8LpYCBm0sNSAKQnKKcvkzUPxG8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XHFu4RuF/BnrUJ/rNa9Peu6kGlL1H5/BuWToipAsEuvMM3PUjnGsAxZ+DN2fKWudgYKPOaFL3fPRzlpIqlFEFadxDRCvVkSXRA3BwHdk6VQ1iYVgotcB+PdfCyzmAcqOE9BuOAGtH1d8U0Ncf3m/mKaqxSKA0rf2aAVXYJlBMac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 15574 invoked by uid 109); 24 Sep 2024 22:04:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Sep 2024 22:04:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18749 invoked by uid 111); 24 Sep 2024 22:04:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Sep 2024 18:04:46 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Sep 2024 18:04:46 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 20/28] http-push: free repo->url string
Message-ID: <20240924220446.GT1143820@coredump.intra.peff.net>
References: <20240924214930.GA1143523@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240924214930.GA1143523@coredump.intra.peff.net>

Our repo->url string comes from str_end_url_with_slash(), which always
allocates its output buffer. We should free it before exiting to avoid
triggering the leak-checker.

This can be seen by leak-checking t5540.

Signed-off-by: Jeff King <peff@peff.net>
---
 http-push.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/http-push.c b/http-push.c
index f60b2ceba5..52c53928a9 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1972,6 +1972,7 @@ int cmd_main(int argc, const char **argv)
  cleanup:
 	if (info_ref_lock)
 		unlock_remote(info_ref_lock);
+	free(repo->url);
 	free(repo);
 
 	http_cleanup();
-- 
2.46.2.1011.gf1f9323e02

