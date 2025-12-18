Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6755F324B2D
	for <git@vger.kernel.org>; Thu, 18 Dec 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766060304; cv=none; b=Ty41quJqrKwKBTulgRcknhwt4e/u9cNfJTqM9F1DjPdbAMZy3g9uOcAoDR/CSNTSkEDi6nstc9XxdVGCg3TMJzajeradPuWAYPHhHz2nB0JJq4YDV9g+DAAB9miHu5lSTFkEH2CdiBx21Engko3ooQP/f1JPI3tT+jWUGa2wPqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766060304; c=relaxed/simple;
	bh=Z4hRRIu5D21CeF9SkIMrNlX81TUfqQgO4KRLWp8JY70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+tu9XsjuPFlQ0Wk9PQInZ9xxkl98Oz8gyBmWag4ljxq99NuBUeF1uhS6hOOROFEwP8t9fIZ2SDOIbXPL4wX/gPirsQ8m7jJ7IK/oyzNiri+MUZEqeUdv4o5tYIcCZWF71JoAqU/X2rpJaDxsPdeQcbaZOv3H1kK6vsvFAypiRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=P/e+Rl9S; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="P/e+Rl9S"
Received: (qmail 390776 invoked by uid 109); 18 Dec 2025 12:18:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Z4hRRIu5D21CeF9SkIMrNlX81TUfqQgO4KRLWp8JY70=; b=P/e+Rl9SnT+3nVUOEGdz+JwFc6Jp4bTHoAvnJF9VzB4KAFT1gyx0/+fb1ho9vtfDJ/aqf4sFF8cb/YbnvzOrx201ldrVr8vkvlvMDjohTM4ZI2qMeDqFNFFAFVNxDBrNQN96qzW1jCpi6TuMkwGLLzQkUT6LbnYU4Zl+M2UBgNf+/0hs4hipHOGzLWxJnZgwbpDnlG+6PUgm+1odhOLTE8NOlvOeeWSmo6a/42bpu4Z6fAwk95A7+4VMsQqtCGej2QTKxsw1At+Q/BAeDHPDn1zA6tih63CrcTsIdSJMgAHDp0kYS9TNc8/Gd/smly0vOwlQjM9IiEwphqPILdljYw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Dec 2025 12:18:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 520659 invoked by uid 111); 18 Dec 2025 12:18:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Dec 2025 07:18:20 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Dec 2025 07:18:19 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Matthew John Cheetham <mjcheetham@outlook.com>,
	Daniel Stenberg <daniel@haxx.se>
Subject: [PATCH 2/3] t5563: add missing end-of-line in HTTP header
Message-ID: <20251218121819.GB3758205@coredump.intra.peff.net>
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

In t5563, we test how various oddly-formatted WWW-Authenticate headers
are passed through curl to git's credential subsystem (and ultimately
out to credential helpers). One test, "access using basic auth with
wwwauth header mixed line-endings" does something odd. It does not mix
line endings at all (which must be CRLF according to the RFC anyway),
but omits the line ending entirely for the final header!

This means that the server produces an incomplete response. We send our
final header, and then the newline which is meant to mark the end of
headers (and the start of the body) becomes the line ending for that
header. And there is no header/body separator in the output at all.

Looking at strace, this is what the client reads:

  recvfrom(9, "WWW-Authenticate: FooBar param1=\"value1\"\r\n \r\n\tparam2=\"value2\"\r\nWWW-Authenticate: Basic realm=\"example.com\"", 16384, 0, NULL, NULL) = 106
  recvfrom(9, "\n", 16384, 0, NULL, NULL) = 1
  recvfrom(9, "", 16384, 0, NULL, NULL) = 0

The headers themselves are produced from the custom-auth.challenge file
we write in the test (which is missing the final CRLF), and then the
header/body separator comes from our lib-httpd/nph-custom-auth.sh CGI.
(Ignore for a moment that it is producing a bare newline, which I think
is a bug; it should be a CRLF but curl is happy with either).

Older versions of curl seemed to be OK with the truncated output, but
the upcoming 8.18.0 release seems to get confused. Specifically, since
67ae101666 (http: unfold response headers earlier, 2025-12-12) our
request to the server fails with insufficient credentials. I traced far
enough to see that curl does relay the header back to us, which we then
pass to a credential helper, which gives us the correct
username/password combination. But on our followup request, curl refuses
to send the Authorization header (and so gets an HTTP 401 again).

The change in curl's behavior is a bit unexpected, but since we are
sending it garbage, it is hard to complain too much. Let's add the
missing CRLF to the header. I _think_ this was just an oversight and not
the intent of the test. And that the "mixed line-endings" really meant
"mixed continuations", since we differ from the previous test in
continuing with both space and tab. So I've likewise updated the test
title to match that assumption.

Signed-off-by: Jeff King <peff@peff.net>
---
I do find it puzzling that we hand curl the credential, but it doesn't
get used in the follow-up request. So I may have mis-analyzed something,
but I really think that's what is happening. I can share the
hacky instrumentation I added if anybody wants to dig further. But since
the original was garbage AFAICT, I didn't think it was worth spending
a lot of time on it.

 t/t5563-simple-http-auth.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5563-simple-http-auth.sh b/t/t5563-simple-http-auth.sh
index 317f33af5a..c1febbae9d 100755
--- a/t/t5563-simple-http-auth.sh
+++ b/t/t5563-simple-http-auth.sh
@@ -469,7 +469,7 @@ test_expect_success 'access using basic auth with wwwauth header empty continuat
 	EOF
 '
 
-test_expect_success 'access using basic auth with wwwauth header mixed line-endings' '
+test_expect_success 'access using basic auth with wwwauth header mixed continuations' '
 	test_when_finished "per_test_cleanup" &&
 
 	set_credential_reply get <<-EOF &&
@@ -490,7 +490,7 @@ test_expect_success 'access using basic auth with wwwauth header mixed line-endi
 	printf "id=default response=WWW-Authenticate: FooBar param1=\"value1\"\r\n" >>"$CHALLENGE" &&
 	printf "id=default response= \r\n" >>"$CHALLENGE" &&
 	printf "id=default response=\tparam2=\"value2\"\r\n" >>"$CHALLENGE" &&
-	printf "id=default response=WWW-Authenticate: Basic realm=\"example.com\"" >>"$CHALLENGE" &&
+	printf "id=default response=WWW-Authenticate: Basic realm=\"example.com\"\r\n" >>"$CHALLENGE" &&
 
 	test_config_global credential.helper test-helper &&
 	git ls-remote "$HTTPD_URL/custom_auth/repo.git" &&
-- 
2.52.0.595.gac9d83db54

