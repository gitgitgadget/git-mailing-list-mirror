Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CD2DA763
	for <git@vger.kernel.org>; Wed, 12 Nov 2025 08:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762934807; cv=none; b=Z6vxu3hD2SArJpBDZV1WCaFrSELFEmIrF16m5KpoBs7bSOw7Qaf2/+xT412ZhKQqxlV3s4sRGz5BdyQ/cJUV3bjue9wnWRRYDO86R4FbP+At3FQW+3XotooYVstpEQ8DagygtnZBIf9Uh8eL5ZIza+wR0dTERmuHdSPIoPOk4cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762934807; c=relaxed/simple;
	bh=6c9Ptv7HPOy9SJu/rFyXFQpBfNg/QhXABJ//pIXe1X4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EodvL67we0rRsVFV30+tigWTFPiT0Lgt/g0+eI9jAm26p6rZU81T8pxv1mPQEfXZLtzEmh68ofm7qG9lkxjgyHY9D9fCTrCo5Uj/+oPTyL44pEntdaJVr6Ex1RhnQ9IyYIuFBxadBRR0V0bN0XTkmGskK1gHUJ4WI49agShshUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SUIVjtHL; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SUIVjtHL"
Received: (qmail 495408 invoked by uid 109); 12 Nov 2025 08:06:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6c9Ptv7HPOy9SJu/rFyXFQpBfNg/QhXABJ//pIXe1X4=; b=SUIVjtHLlN/zUYDV+BrVDkvfG8AATUTS/mPK+jMenIW3nDRLVPoTWalZWnUeTibAoW+APaNLsiJR3jEi9EWxIfpZf6gId0Se/8sLA6Zy+eZ3SChw7PgcemavDMsb2QzMjvYQrKSJCCWITI/hsyHlhp826fQtAkHjl/GQWM76pZzapXDTbi1hxtaf3M4oqVmyZTlCxn/mcY7ZbQyhp7/US+xt0NzeQ34vEKmrc2h3/Kr5BDeygRZO5sLqgdi/Q1U+6pXJJFo+a1lBkXrBhnl0JpNarqjpKaCF2Zf5Z9wHXNCjXkVUytg3FnPyGiaPElRZVl02b3PBmJPQz4DXb4b7IA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 12 Nov 2025 08:06:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 786420 invoked by uid 111); 12 Nov 2025 08:06:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 12 Nov 2025 03:06:44 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 12 Nov 2025 03:06:44 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: correctmost <cmlists@sent.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 7/9] fsck: remove redundant date timestamp check
Message-ID: <20251112080644.GG979063@coredump.intra.peff.net>
References: <20251112075522.GA978866@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251112075522.GA978866@coredump.intra.peff.net>

After calling "parse_timestamp(p, &end, 10)", we complain if "p == end",
which would imply that we did not see any digits at all. But we know
this cannot be the case, since we would have bailed already if we did
not see any digits, courtesy of extra checks added by 8e4309038f (fsck:
do not assume NUL-termination of buffers, 2023-01-19). Since then,
checking "p == end" is redundant and we can drop it.

This will make our lives a little easier as we refactor further.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.c b/fsck.c
index 2ee72d573d..266c965cec 100644
--- a/fsck.c
+++ b/fsck.c
@@ -920,7 +920,7 @@ static int fsck_ident(const char **ident, const char *ident_end,
 		return report(options, oid, type, FSCK_MSG_ZERO_PADDED_DATE, "invalid author/committer line - zero-padded date");
 	if (date_overflows(parse_timestamp(p, &end, 10)))
 		return report(options, oid, type, FSCK_MSG_BAD_DATE_OVERFLOW, "invalid author/committer line - date causes integer overflow");
-	if ((end == p || *end != ' '))
+	if (*end != ' ')
 		return report(options, oid, type, FSCK_MSG_BAD_DATE, "invalid author/committer line - bad date");
 	p = end + 1;
 	if ((*p != '+' && *p != '-') ||
-- 
2.52.0.rc1.260.g3e4993586f

