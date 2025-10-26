Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86952222A0
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761493310; cv=none; b=CMpcZ7Ky6Szbl0TMNg2QiiuHNbn+ew1Qmtl16U6AHVfTFWxcm8TbV4sKsFXp1FWB1L57KHB1FwoavTxPpHLno63ozrPdxQiDFZfGKHTFci48xhzs1OskjMK/AFHGcIsmkGK5hWoOQEGPPhRJS5dkiBmpKYlt7AQ6iV0UItz9/mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761493310; c=relaxed/simple;
	bh=87HuWYB+QsIDbCG06swBNCvErEpmN5j5XNYw+0lHaZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3tlTJ6qFBvyQ8StJPH/tibZ+Q4u7wR3z5X8KChaIL4gKF2XsYNMWeGWdGO67XKBF07eIchRBLmlROHlano/6Nqjww8FEu37UuglgMV6sI2ANvgZxKQgwf1x0NINmG1LrIfmKanFxPzo2M1McOVjWC+0h4PAGIGU+8cj5QYmtQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=U5PQxxU6; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="U5PQxxU6"
Received: (qmail 346935 invoked by uid 109); 26 Oct 2025 15:41:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=87HuWYB+QsIDbCG06swBNCvErEpmN5j5XNYw+0lHaZw=; b=U5PQxxU6PT5B+ngLaG02nvR7u7M7V6b2p1YhNJ+PkGRzLefXA/cnBUEpjWALzrwcPc8OUaKF98F6HF1G4XZUKLYVDE+afRx0RN8T1CIyFsub2l5DnxYHI1A/Fq5btTXQC4PNSE2DUvC/nlehJVgREIs+wobuvrS8+7zMr399N1XnH42Ro+9dfPIMs816L8wrIOFksQCue8lJF3tmOF/21UzTfR1gCkqMFaIpMYTlC2gOfRFT43kcoYJaFNrb63lBGvVTdNneGVcrWjBjUZPWDPxZtnlEp4CA8NuHZXoyFIIm8aNf0nv5LQSMgAH2wdMWqbIG1mvuDwwAt+5G9Px4xA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 26 Oct 2025 15:41:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 542520 invoked by uid 111); 26 Oct 2025 15:41:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 26 Oct 2025 11:41:46 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 26 Oct 2025 11:41:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Sruteesh Kumar <sruteesh.oss@protonmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 1/2] match_pathname(): reorder prefix-match check
Message-ID: <20251026154146.GA2728835@coredump.intra.peff.net>
References: <20251026154036.GA2173430@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251026154036.GA2173430@coredump.intra.peff.net>

As an optimization, we use fspathncmp() to match a prefix of the pattern
that does not contain any wildcards, and then pass the remainder to
fnmatch(). If it has matched the whole thing, we can return early.

Let's shift this early-return check to before we tweak the pattern and
name strings. That will gives us more flexibility with that tweaking.

It might also save a few instructions, but I couldn't measure any
improvement in doing so (and I wouldn't be surprised if an optimizing
compiler could figure that out itself).

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/dir.c b/dir.c
index 0a67a99cb3..bbc2bf289d 100644
--- a/dir.c
+++ b/dir.c
@@ -1360,18 +1360,19 @@ int match_pathname(const char *pathname, int pathlen,
 
 		if (fspathncmp(pattern, name, prefix))
 			return 0;
-		pattern += prefix;
-		patternlen -= prefix;
-		name    += prefix;
-		namelen -= prefix;
 
 		/*
 		 * If the whole pattern did not have a wildcard,
 		 * then our prefix match is all we need; we
 		 * do not need to call fnmatch at all.
 		 */
-		if (!patternlen && !namelen)
+		if (patternlen == prefix && namelen == prefix)
 			return 1;
+
+		pattern += prefix;
+		patternlen -= prefix;
+		name    += prefix;
+		namelen -= prefix;
 	}
 
 	return fnmatch_icase_mem(pattern, patternlen,
-- 
2.51.1.840.g23b87c0a58

