Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5932879D0
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 20:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749070556; cv=none; b=gpStyP83kV91ekzSHSNHq1pi2YAMQ0fnQHgchVRPES0Fcng8iI2KBPUqbzKXkeV7GD57meFQVAtqPbBA06TrVEVbqSL+miu4G4SvKqxz/ETAgRfWCw3c+LYThEoQ/5HtRwmp7Ap02UPOpkfGF+sdrrqrol3xLKSqSgnzLGJuVSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749070556; c=relaxed/simple;
	bh=9QX0pgyd6bxzVwfRK8RaQZLbZfcRJQWeiYcA3mZKMdU=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwtCSkINoAUhdrt3pd3nK4i5aFAni0QtH6T1tKycgQM+L+awEPtmu000a3p926IQpE4YbCvN298b4snJ3gVkOq1+ghqAYl9vCi1Kwv6TpYPBvgG0bk1rHtOsJZ75KnFt5IJXETZBmlitbDABkA7ZYqAf/7/PvJBHI+XXG09UUbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Q553ViLT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Q553ViLT"
Received: (qmail 14301 invoked by uid 109); 4 Jun 2025 20:55:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9QX0pgyd6bxzVwfRK8RaQZLbZfcRJQWeiYcA3mZKMdU=; b=Q553ViLTRLt5tlOTjiEm/7s4AfRiYWmeMyxj+kg0Omp0xsRAj7pQq+VKKlyrawkmLCzPMdcyZU4ZWNvcyAagUH7AnQw6LwNeI5jGvVcgaG6fYmlcWN3oV+5pkdfLQXfwO+Ibo482JTSWG0Du3YOyJ1NXZbTmB2L1MROMoSuphIlcf/tK7vmbvwq0sAGzvsWg3AhS+jpfdBSOEDfs6n4pR+4EA0o+j+P48vsZhStPpeL2kr4gr1zKWWV3fqRV9mULtczw8RzxRXpXPDFSIFRkzATmEQTlX2lC/4VZkCEN66kjgiYrDaaKyVVjyZsaSz5uP9/M/IZQpcQlsEGGgGuVog==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 04 Jun 2025 20:55:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13765 invoked by uid 111); 4 Jun 2025 20:55:55 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 04 Jun 2025 16:55:55 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 4 Jun 2025 16:55:52 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/3] curl: fix integer variable typechecks with
 curl_easy_setopt()
Message-ID: <20250604205552.GB1510819@coredump.intra.peff.net>
References: <20250604205505.GA1510724@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250604205505.GA1510724@coredump.intra.peff.net>

As discussed in the previous commit, we should be passing long integers,
not regular ones, to curl_easy_setopt(), and compiling against curl 8.14
loudly complains if we don't.

That patch fixed integer constants by adding an "L". This one deals with
actual variables.

Arguably these variables could just be declared as "long" in the first
place. But it's actually kind of awkward due to other code which uses
them:

  - port is conceptually a short, and we even call htons() on it (though
    weirdly it is defined as a regular int).

  - ssl_verify is conceptually a bool, and we assign to it from
    git_config_bool().

So I think we could probably switch these out for longs without hurting
anything, but it just feels a bit weird. Doubly so because if you don't
set USE_CURL_FOR_IMAP_SEND set, then the current types are fine!

So let's just cast these to longs in the curl calls, which makes what's
going on obvious. There aren't that many spots to modify (and as you can
see from the context, we already have some similar casts).

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 27dc033c7f..2e812f5a6e 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1420,7 +1420,7 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 
 	curl_easy_setopt(curl, CURLOPT_URL, path.buf);
 	strbuf_release(&path);
-	curl_easy_setopt(curl, CURLOPT_PORT, srvc->port);
+	curl_easy_setopt(curl, CURLOPT_PORT, (long)srvc->port);
 
 	if (srvc->auth_method) {
 		struct strbuf auth = STRBUF_INIT;
@@ -1433,8 +1433,8 @@ static CURL *setup_curl(struct imap_server_conf *srvc, struct credential *cred)
 	if (!srvc->use_ssl)
 		curl_easy_setopt(curl, CURLOPT_USE_SSL, (long)CURLUSESSL_TRY);
 
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, srvc->ssl_verify);
-	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, (long)srvc->ssl_verify);
+	curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, (long)srvc->ssl_verify);
 
 	curl_easy_setopt(curl, CURLOPT_READFUNCTION, fread_buffer);
 
-- 
2.50.0.rc1.276.g7db1193dde

