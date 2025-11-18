Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213E81E5714
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763468487; cv=none; b=p8xsltVf4NxDBg/ZdqTzOpmvr3Cb58IKdL7BqyCuSRTB/sPZfI8UgkWpiML5l4EVdpqs8yceu3aHLPyMWlKqaUBqeivvuyFbPng9tMlu9QItWmv3U6PzL4UMaFAogZ0g0OKPOjRjCF2mFgmF38qykxyTLSocBrfgQCV5+oYEaEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763468487; c=relaxed/simple;
	bh=9AYvyYsHH+lxmAIVdqn8Tb8chYQwZA27lvmobS1lrcU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=DVsPXE7tB+Er7dXOPEMWe3uvD1du+TCB9uqEj614mvHqPcWhrOmXr/XB2uW9EESJFhJYgpeIp7BxdvKdsxLnord1hOYCEARTMgUkwnhyT6w5if6Wpudg3HdAYqE0BjMWpu3RoWt27Cdu+k/JrhYeVspPJxXpzvBoakLipvTulzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cXYSeMF0; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cXYSeMF0"
Received: (qmail 21501 invoked by uid 109); 18 Nov 2025 12:21:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:mime-version:content-type; s=20240930; bh=9AYvyYsHH+lxmAIVdqn8Tb8chYQwZA27lvmobS1lrcU=; b=cXYSeMF05KbT23zou8JcAxsA2m3VFK4xOMI3BJBguWcxJYpqD4amtZryageVzG2SdM7Z1aGFdb8nzL7gEfvEPfDiwls8MBzVHcyohL+x2o1s4yadFnnBKKmhE4aD91rk98GIfjjyfWqOGFx2gNF0ucEMQ/sjSesMQNMzI1kX8HO5+FtTUB3Z5cnwD/ZW+d50qhQqdyY6Ir0AH5YqJroqdt5Tiulwlz4udjr0ImwuO3XMT2/561Howuw7JQtnI7UMD8DXNM+O5ENgeAB7g4qM7pElsSTuMu1Z0j4MHHtOIZj/j2iYMyVeDdoWaxH5WImADrtrNMmtyLc6OjCmRTmVDw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 12:21:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29720 invoked by uid 111); 18 Nov 2025 12:21:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 07:21:24 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 07:21:24 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH] test-mktemp: plug memory and descriptor leaks
Message-ID: <20251118122124.GA1117960@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

We test xmkstemp() in our helper by just calling:

  xmkstemp(xstrdup(argv[1]));

This leaks both the copied string as well as the descriptor returned by
the function. In practice this isn't a big deal, since we immediately
exit the program, but:

  1. LSan will complain about the memory leak. The only reason we did
     not notice this in our leak-checking builds is that both of the
     callers in the test suite (both in t0070) pass a broken template
     (and expect failure). So the function calls die() before we can
     actually leak.

     But it's an accident waiting to happen if anybody adds a call which
     succeeds.

  2. Coverity complains about the descriptor leak. There's a long list
     of uninteresting or false positives in Coverity's results, but
     since we're here we might as well fix it, too.

I didn't bother adding a new test that triggers the leak. It's not even
in real production code, but just in the test-helper itself.

Signed-off-by: Jeff King <peff@peff.net>
---
I think the rewrite of xmkstemp() triggered Coverity to consider this a
"new" problem, even though it has been there for years. So not urgent,
but this is mostly just trying not to waste the brain cycles I spent
analyzing. :)

 t/helper/test-mktemp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-mktemp.c b/t/helper/test-mktemp.c
index 2290688940..da195640a9 100644
--- a/t/helper/test-mktemp.c
+++ b/t/helper/test-mktemp.c
@@ -6,10 +6,16 @@
 
 int cmd__mktemp(int argc, const char **argv)
 {
+	char *template;
+	int fd;
+
 	if (argc != 2)
 		usage("Expected 1 parameter defining the temporary file template");
+	template = xstrdup(argv[1]);
 
-	xmkstemp(xstrdup(argv[1]));
+	fd = xmkstemp(template);
 
+	close(fd);
+	free(template);
 	return 0;
 }
-- 
2.52.0.292.gf04cec7acc
