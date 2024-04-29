Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2C017BCB
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 08:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714379003; cv=none; b=Y7eCh/ajp3z/u6wdPH5LdeIQm1041EWUqxCSlB0t9qhHzBLbt6jHydHGpsT2y+RAGhKdcErpgPVUHwVschyIkM7dAu162PxcBJXpOtO4KfS+8Grdqw5tpmIYHPFjA2fLuvNluAISdzmGPcZSmx/bYvIcskDgjG0YxvCBzqiKRAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714379003; c=relaxed/simple;
	bh=qA9HjnxJXHzZyL88P6boplP1eGbuPBor4pVOwiLN6aw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=kg5UweY54lOBWR2Us4YjMZBV+1+8zfXYAhbYwIU7035H5B785FDFfnHPl8E4h0HlFW2R6PWq/KvPTg+YZaqg6vBTPGSaUWmXUHyHKEvHHRabcSYh8KMoOvu0MqG3sh944nev5tkV6AyLNsf8zYa62cYh9yp9DjBOhdCXSVUpKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 20211 invoked by uid 109); 29 Apr 2024 08:23:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 29 Apr 2024 08:23:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26850 invoked by uid 111); 29 Apr 2024 08:23:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 29 Apr 2024 04:23:25 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 29 Apr 2024 04:23:20 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 5/8] refs: use is_pseudoref_syntax() in refname_is_safe()
Message-ID: <20240429082320.GD233423@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

The open-coded logic in refname_is_safe() predates the addition of
is_pseudoref_syntax(). But now that we have it, we can make use of it.
This shortens the code, but also makes sure we use a consistent
definition of a pseudoref.

Note that refname_is_safe() allows HEAD, which of course is not itself a
pseudoref by the strict definition (since it can be a symref). But the
syntax for the two is the same, and that is all that we care about here.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/refs.c b/refs.c
index b202dca904..8cac7e7e59 100644
--- a/refs.c
+++ b/refs.c
@@ -362,12 +362,7 @@ int refname_is_safe(const char *refname)
 		return result;
 	}
 
-	do {
-		if (!isupper(*refname) && *refname != '_')
-			return 0;
-		refname++;
-	} while (*refname);
-	return 1;
+	return is_pseudoref_syntax(refname);
 }
 
 /*
-- 
2.45.0.rc1.416.gbe2a76c799

