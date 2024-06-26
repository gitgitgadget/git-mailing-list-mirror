Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187588F47
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 20:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435330; cv=none; b=aq+1UyX2+3jxeurNGgsQZgnek2Lhk8GreR+eL4KWby8lOhSC34fjUb36zjxzIxUMJyXGBXp/LF4ATMFcuPqWMt86RqG0v91N8mqv5tPmr4k4M82LkfemIDy4jP2qsh2Ba90aoe4aSo7CWcnfDKltSjGD0xbZfuJDEcl4bnnpfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435330; c=relaxed/simple;
	bh=iZZ+3Di3p5blLU+uPIrlQ2n3urJ+y86QsaO0p8oEbdY=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QmhFVo9qVq2BF16kM5RzGCq6Ctrg+mr6YgqiqeuVqHVBxb1Ivz7lMxj73Et7eF+XNHfAc0jy50TUvQGGE2FnpVFO14cznnFThoiyhxEQGdrDG6TLIMB3M03tmp2fO+piGWAA+UbRxG5DBDEMfWyrY6ksDFBseDgyAxicfMZwbF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26066 invoked by uid 109); 26 Jun 2024 20:55:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 26 Jun 2024 20:55:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25216 invoked by uid 111); 26 Jun 2024 20:55:26 -0000
Received: from Unknown (HELO coredump.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 26 Jun 2024 16:55:26 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 26 Jun 2024 16:55:25 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/3] t5551: do not confirm that bogus url cannot be used
Message-ID: <20240626205525.GB1457138@coredump.intra.peff.net>
References: <20240626205355.GA1009060@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240626205355.GA1009060@coredump.intra.peff.net>

t5551 tries to access a URL with a bogus hostname and confirms that
http.curloptResolve lets us use this otherwise unresolvable name.

Before doing so, though, we confirm that trying to access the bogus
hostname without http.curloptResolve fails as expected. This isn't
testing Git at all, but is confirming the test's assumptions. That's
often a good thing to do, but in this case it means that we'll actually
try to resolve the external name. Even though it's unlikely that
"gitbogusexamplehost.invalid" would ever resolve, the DNS lookup itself
may take time.

It's probably reasonable to just assume that this obviously-bogus name
would not actually resolve in practice, which lets us reduce our test
suite's dependency on the outside world.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index a623a1058c..7b5ab0eae1 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -643,7 +643,6 @@ test_expect_success 'clone empty SHA-256 repository with protocol v0' '
 test_expect_success 'passing hostname resolution information works' '
 	BOGUS_HOST=gitbogusexamplehost.invalid &&
 	BOGUS_HTTPD_URL=$HTTPD_PROTO://$BOGUS_HOST:$LIB_HTTPD_PORT &&
-	test_must_fail git ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null &&
 	git -c "http.curloptResolve=$BOGUS_HOST:$LIB_HTTPD_PORT:127.0.0.1" ls-remote "$BOGUS_HTTPD_URL/smart/repo.git" >/dev/null
 '
 
-- 
2.45.2.1058.g2ff574fec9

