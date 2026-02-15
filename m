Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A58225A3B
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146336; cv=none; b=EWeSvHEyp9hDDxi5EsNjDtsX8Hak77DL6OLkgU/z/CTy+v4kqSLGztnMk0vgXzMu8EiYvkODoMhY8TcJ7Bkb1dtIRIFnmkvNV8Ego6s4fGPwvW65wC35pmQekTp8H+oTzGxGrgEv3U9wS1k/iWlYlkgYDqKcPYdhWwQmWixngwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146336; c=relaxed/simple;
	bh=YGHXoZZBJI5n6oFiSR5yV3+OeVbTI0MFPxgn1fOcdzs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5ALXZBoH2nAEfB+x0anz7IEKUAr3Fg1hnF5qYi2XMaaW+vlYkIefn/AGhJXeitMOGteaF+n/A8S1PmYYqHLHxwsefycgsD1xIIzA1lNaDK8B/PHKjOqJFE52UoojrOcg8PFTz69t+xewo2ctdP6/xB35KKwa/x0z81N73wbs6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=RUyscLFg; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="RUyscLFg"
Received: (qmail 44726 invoked by uid 109); 15 Feb 2026 09:05:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=YGHXoZZBJI5n6oFiSR5yV3+OeVbTI0MFPxgn1fOcdzs=; b=RUyscLFgBXPkaNz7u3E3ggQX3602UJJ+gA9vniK9kYGi2su/hOarOc8mZCbEXKtf4f1e/LuuBmdtrtQkZiobc7+OVRVAXroR/5+HCyRn5/SrvEm+jVh/vVOvF4b3j+IRaObdpExMfgUTByREAINDTD0bAEUV31Tu3Nh50lUZgiw49XBHfdI5TDDGDwyXlpzSGn0frNtBTsreQrvclJgfhIVdwChh0BidBRBWUBAjA1JC8Y4VsZacvRKUq/Kp0r8AAW38Ss11S5GjVBXHj0cfG9IUfeFk8PgCVTjXWTLNopxtQVvBbcpszZAUtCN8Q4PmSFejniFYIzPhtkbwzI5e7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 09:05:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 113120 invoked by uid 111); 15 Feb 2026 09:05:39 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 04:05:39 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 04:05:34 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/4] ref-filter: simplify rstrip_ref_components() memory
 handling
Message-ID: <20260215090534.GC695631@coredump.intra.peff.net>
References: <20260215085755.GA86262@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260215085755.GA86262@coredump.intra.peff.net>

We're stripping path components from the end of a string, which we do by
assigning a NUL as we parse each component, shortening the string. This
requires an extra temporary buffer to avoid munging our input string.

But the way that we allocate the buffer is unusual. We have an extra
"to_free" variable. Usually this is used when the access variable is
conceptually const, like:

   const char *foo;
   char *to_free = NULL;

   if (...)
           foo = to_free = xstrdup(...);
   else
           foo = some_const_string;
   ...
   free(to_free);

But that's not what's happening here. Our "start" variable always points
to the allocated buffer, and to_free is redundant. Worse, it is marked
as const itself, requiring a cast when we free it.

Let's drop to_free entirely, and mark "start" as non-const, making the
memory handling more clear. As a bonus, this also silences a warning
from glibc-2.43 that our call to strrchr() implicitly strips away the
const-ness of "start".

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index eb09fda21b..1008b2fd5a 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2213,13 +2213,12 @@ static const char *lstrip_ref_components(const char *refname, int len)
 static const char *rstrip_ref_components(const char *refname, int len)
 {
 	int remaining = normalize_component_count(refname, len);
-	const char *start = xstrdup(refname);
-	const char *to_free = start;
+	char *start = xstrdup(refname);
 
 	while (remaining-- > 0) {
 		char *p = strrchr(start, '/');
 		if (!p) {
-			free((char *)to_free);
+			free(start);
 			return xstrdup("");
 		} else
 			p[0] = '\0';
-- 
2.53.0.438.gad17e1cd28

