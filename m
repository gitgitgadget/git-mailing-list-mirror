Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2E332E6BA
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 12:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060032; cv=none; b=YMCAMXkni8a6cMVBXnagLQmgiBjLkeXrrUvw8UOO6VSIwmvxS+PWZ1/gSBQVGmq5U83UlwddL5wGRr1Hiw+p+cGeqYs4lNbW8IECbK1vINgkj8nbXna03vu2uxjPgjNYXkTCWiouEgxymDsfrvslnWs0ioKfTEbcXqtNaOBaVXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060032; c=relaxed/simple;
	bh=StkRv7ikPWpzlnBCvEfMqXLcXEi9tju1z1uFegUtfbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RIuKkmRV5b+95kDcCdwW54qgb9AHTYWhBNAQnItpDIRizr3r9i0I9O2rPFOqxidYhLm+SiEQdfsHtQg3t/obLhZB4wCeO7/W2Y8zY5/Uv0v1MoSdeqn24lOsUPH8w1t+emmHvPma0DikznMDB/vndxvuMNzfzuvd+iguBI1FvY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=AiGBSuUo; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="AiGBSuUo"
Received: (qmail 390683 invoked by uid 109); 18 Dec 2025 12:13:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=StkRv7ikPWpzlnBCvEfMqXLcXEi9tju1z1uFegUtfbs=; b=AiGBSuUoOduwCUbWPIgqy8dUiVM4cyuLJXRgDJ9vwJABqjdx/Y/hShLo/6sGgfRNAZXh6wgahg9641TdvZlfh0gF0J5yPSYGeLjQaqjz7AqISDP4lxuDsVJTel4hqrTIwHExesKBpCpJBgmcky5oxwFQgJg8qTekmS1elYmmM8Ryy6D9UnELUXHxMx0pNyrKqSvF5F4FdiwXwX7WwFNdKYc8dY5Aa6dEGuBxKfehvGDLR1dfhqtPu261ZHbauC2iXWK6swIWkHyqvhzRNJfmGxOymd5teu4IT1Pmu7SWx5nCa8AZgehigZE0u6W2Un2DwdVJ3QxSv3rfaTyRqSmhAA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Dec 2025 12:13:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520601 invoked by uid 111); 18 Dec 2025 12:13:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Dec 2025 07:13:47 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Dec 2025 07:13:47 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Matthew John Cheetham <mjcheetham@outlook.com>,
	Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH 1/3] t5551: handle trailing slashes in expected cookies output
Message-ID: <20251218121347.GA3758205@coredump.intra.peff.net>
References: <20251218121120.GA3252258@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251218121120.GA3252258@coredump.intra.peff.net>

We check in t5551 that curl updates the expected list of cookies after
making a request. We do this by telling it to read and write cookies
from a particular text file, and then checking that after curl runs, the
file has the expected content.

However, in the upcoming curl 8.18.0, the output file has changed
slightly: curl will canonicalize the paths it writes, due to commit
a093c93994 (cookie: only keep and use the canonical cleaned up path,
2025-12-07). In particular, it strips trailing slashes from the paths we
see in the cookies.txt file.

This doesn't matter to Git, as the cookie handling is all internal to
curl. But our test is overly brittle and breaks as a result.

We can fix it by matching either format. We'll expect the new format
(without trailing slashes) and strip the slashes from curl's output
before comparing. That lets us pass with both old and new versions (I
tested against curl's 8_17_0 and rc-8_18_0-2 tags, which are
respectively before and after the curl change).

In theory it might be nice to try to future-proof this test more by
looking only for the bits we care about, rather than a byte-wise
comparison of the whole file. But after removing comments and blank
lines (which we already do), we care about most of what's there. So it's
not clear to me what a more liberal test would look like. Given that the
format doesn't change all that often, it's probably OK to stop here and
see if it ever breaks again.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5551-http-fetch-smart.sh | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
index b0d4ea7801..73cf531580 100755
--- a/t/t5551-http-fetch-smart.sh
+++ b/t/t5551-http-fetch-smart.sh
@@ -333,12 +333,12 @@ test_expect_success 'dumb clone via http-backend respects namespace' '
 
 test_expect_success 'cookies stored in http.cookiefile when http.savecookies set' '
 	cat >cookies.txt <<-\EOF &&
-	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
+	127.0.0.1	FALSE	/smart_cookies	FALSE	0	othername	othervalue
 	EOF
 	sort >expect_cookies.txt <<-\EOF &&
-	127.0.0.1	FALSE	/smart_cookies/	FALSE	0	othername	othervalue
-	127.0.0.1	FALSE	/smart_cookies/repo.git/	FALSE	0	name	value
-	127.0.0.1	FALSE	/smart_cookies/repo.git/info/	FALSE	0	name	value
+	127.0.0.1	FALSE	/smart_cookies	FALSE	0	othername	othervalue
+	127.0.0.1	FALSE	/smart_cookies/repo.git	FALSE	0	name	value
+	127.0.0.1	FALSE	/smart_cookies/repo.git/info	FALSE	0	name	value
 	EOF
 	git config http.cookiefile cookies.txt &&
 	git config http.savecookies true &&
@@ -351,8 +351,11 @@ test_expect_success 'cookies stored in http.cookiefile when http.savecookies set
 		tag -m "foo" cookie-tag &&
 	git fetch $HTTPD_URL/smart_cookies/repo.git cookie-tag &&
 
-	grep "^[^#]" cookies.txt | sort >cookies_stripped.txt &&
-	test_cmp expect_cookies.txt cookies_stripped.txt
+	# Strip trailing slashes from cookie paths to handle output from both
+	# old curl ("/smart_cookies/") and new ("/smart_cookies").
+	HT="	" &&
+	grep "^[^#]" cookies.txt | sed "s,/$HT,$HT," | sort >cookies_clean.txt &&
+	test_cmp expect_cookies.txt cookies_clean.txt
 '
 
 test_expect_success 'transfer.hiderefs works over smart-http' '
-- 
2.52.0.595.gac9d83db54

