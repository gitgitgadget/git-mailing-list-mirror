Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5708138F92F
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775000543; cv=none; b=uB7Sr0Wi7+1Uvzg7B/8RKGwMxZ3S/bRxitTp+SySfishtHhjCsAi+K+noSolMab5FVbwBp+eKCWYF9sZCXrjZn9B/6b30GsLXZUHKw6eRY9lNmIhK3F3gVWm5ozSxhsUmf17fg4jEO2AI72s+Om0CrFAyvnp/tjmc/FRZj01FaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775000543; c=relaxed/simple;
	bh=6rnNRRxCzhmZ/ntZDnIR0zPJ1EyOmhCqTI+6X0HPLqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXAbrrRdRos4r1XkfBkUNeuSLpigC6daOLA/YueIj3q7ikgHbRMiyFRlF/ZZsi4thvF/P+p6HkLMrsXazf5RLB/BNwbJtUwbOzeBxV/95fCxhbZCU3VmRYJCwejODNI0b5g0JaZSnoRWnt13TAr2tXeJwB8GtGAQBzLxj4DWJxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=fyH2WFIm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="fyH2WFIm"
Received: (qmail 206616 invoked by uid 106); 31 Mar 2026 23:42:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=6rnNRRxCzhmZ/ntZDnIR0zPJ1EyOmhCqTI+6X0HPLqY=; b=fyH2WFImsdtdI/HJ7OjPaucoaACNg/jf9DMEjebpobz99+KTxWorqoiUtCYSZr+sKODAx/CL4wRewloQ+xMKuKmtZQhUN8GCnv8ygzMu9AQXVcV+C5/2jTKihXmN35mxT+8NuaK/OMjbkjEO8PwqNF7yqh5r0QAoYP6A5XtJUdC8h8rbjGSyiNQ9v1sX7ifmyG6kd02jo6a7xbxJz9wLfWP3mhCF6GntR5HtUscbKG3xS/y4nwk0vIn1bclXj4K4jXe9C0gYGEG1c0Ksm79+Cv16FYedAizQ6Ngt3RRTOdgEWjJonqWXeUyLi11TKoanQTNzWqSTx967cMNyFa47zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 31 Mar 2026 23:42:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 326433 invoked by uid 111); 31 Mar 2026 23:42:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 31 Mar 2026 19:42:21 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 31 Mar 2026 19:42:20 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Collin Funk <collin.funk1@gmail.com>, Michael J Gruber <git@grubix.eu>
Subject: [PATCH 04/12] pager: explicitly cast away strchr() constness
Message-ID: <20260331234220.GD2328529@coredump.intra.peff.net>
References: <20260331233856.GA2327197@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260331233856.GA2327197@coredump.intra.peff.net>

When we do:

  char *cp = strchr(argv[i], '=');

it implicitly removes the constness from argv[i]. We need "cp" to remain
writable (since we overwrite it with a NUL). In theory we should be able
to drop the const from argv[i], because it is a sub-pointer into our
duplicated pager_env variable.

But we get it from split_cmdline(), which uses the traditional "const
char **" type for argv. This is overly limiting, but changing it would
be awkward for all the other callers of split_cmdline().

Let's do an explicit cast with a note about why it is OK. This is enough
to silence compiler warnings about the implicit const problems.

Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/pager.c b/pager.c
index 5531fff50e..801ba392f2 100644
--- a/pager.c
+++ b/pager.c
@@ -118,7 +118,8 @@ static void setup_pager_env(struct strvec *env)
 			split_cmdline_strerror(n));
 
 	for (i = 0; i < n; i++) {
-		char *cp = strchr(argv[i], '=');
+		/* we know this is writable because it was split from pager_env */
+		char *cp = strchr((char *)argv[i], '=');
 
 		if (!cp)
 			die("malformed build-time PAGER_ENV");
-- 
2.53.0.1136.gd760fbd4a0

