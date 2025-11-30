Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1536D51B
	for <git@vger.kernel.org>; Sun, 30 Nov 2025 13:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508485; cv=none; b=sbe3sxVtBnJxYU5hPHURvSlK4FUty9CEoWaCJaQlkAjAR3tjM6NQZ4nCTqoXrvG0sCNiRsfT73NGke7uSNSAsqgLCYpeccHijQnFLPZUwNsnio0PAzCqu2NqOXyR9yNWeI1LOOBOJ9KSlADGo6zwlCB8Ct5bSWAuzM6sLWrkxwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508485; c=relaxed/simple;
	bh=90FKz1ECifa/1XbRazCNWWmIbl783Imo5ClbjxDkZe4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a/OJqQldbfxRO6zICEDN4U2B1T92puIeRdabikueuup/howSDUpePM3OQVLquvx3+2JLAbkW7i9plIAnX5ct6vDUHoGfy0wcK//lXQPEXIxg7+NWOUa0+I36zi/p9JauYXcqzUxgpMJVF7OKUdzeuJvfJeMPRHzL9Ozvj5//LpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YE2scKoU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YE2scKoU"
Received: (qmail 170822 invoked by uid 109); 30 Nov 2025 13:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=90FKz1ECifa/1XbRazCNWWmIbl783Imo5ClbjxDkZe4=; b=YE2scKoUX6xGTDvs7xplxwMq7KwUDcwpNLFJziogtIUZFdJGwn3P6FAGD9PJpqqDOj/WjA0xhgvVzfgXiaOb8Lcohb4xwNPCB9I/T+n85kyfzTVxgawlJGWbspG9g0O6eaeCHk24PYrvfsEBUodXQyBCMXmkyKvBwNnq4DjitIaeWvOpfDtVw/lnIn3H0qIGHh2BGo5fMLMzlsB7bUVDVwnS4PSPZjRXblsXNuI1qV+aG0lORh7dAO5JMQrGliWKE6bwAPqBqBBsif/A+gNOfZ9nkmf+tlpBUridIm2SgNu9uAIGIt6lBElrebVPSnTYWokdu007x5LY36AKkSrKtQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 30 Nov 2025 13:14:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 254751 invoked by uid 111); 30 Nov 2025 13:14:41 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Nov 2025 08:14:41 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Nov 2025 08:14:41 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH 1/4] parse: prefer bool to int for boolean returns
Message-ID: <20251130131441.GA199335@coredump.intra.peff.net>
References: <20251130131351.GA198697@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251130131351.GA198697@coredump.intra.peff.net>

All of the integer parsing functions in parse.[ch] return an int that is
"0" for failure or "1" for success. Since most of the other functions in
Git use "0" for success and "-1" for failure, this can be confusing.
Let's switch the return types to bool to make it clear that we are using
this other convention. Callers should not need to update at all.

Signed-off-by: Jeff King <peff@peff.net>
---
Obviously not strictly necessary for this series, but I think a good
idea regardless of the rest of it.

 parse.c | 66 ++++++++++++++++++++++++++++-----------------------------
 parse.h | 14 ++++++------
 2 files changed, 40 insertions(+), 40 deletions(-)

diff --git a/parse.c b/parse.c
index 48313571aa..f626846def 100644
--- a/parse.c
+++ b/parse.c
@@ -15,7 +15,7 @@ static uintmax_t get_unit_factor(const char *end)
 	return 0;
 }
 
-int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
+bool git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 {
 	if (value && *value) {
 		char *end;
@@ -28,30 +28,30 @@ int git_parse_signed(const char *value, intmax_t *ret, intmax_t max)
 		errno = 0;
 		val = strtoimax(value, &end, 0);
 		if (errno == ERANGE)
-			return 0;
+			return false;
 		if (end == value) {
 			errno = EINVAL;
-			return 0;
+			return false;
 		}
 		factor = get_unit_factor(end);
 		if (!factor) {
 			errno = EINVAL;
-			return 0;
+			return false;
 		}
 		if ((val < 0 && (-max - 1) / factor > val) ||
 		    (val > 0 && max / factor < val)) {
 			errno = ERANGE;
-			return 0;
+			return false;
 		}
 		val *= factor;
 		*ret = val;
-		return 1;
+		return true;
 	}
 	errno = EINVAL;
-	return 0;
+	return false;
 }
 
-int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
+bool git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 {
 	if (value && *value) {
 		char *end;
@@ -61,97 +61,97 @@ int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max)
 		/* negative values would be accepted by strtoumax */
 		if (strchr(value, '-')) {
 			errno = EINVAL;
-			return 0;
+			return false;
 		}
 		errno = 0;
 		val = strtoumax(value, &end, 0);
 		if (errno == ERANGE)
-			return 0;
+			return false;
 		if (end == value) {
 			errno = EINVAL;
-			return 0;
+			return false;
 		}
 		factor = get_unit_factor(end);
 		if (!factor) {
 			errno = EINVAL;
-			return 0;
+			return false;
 		}
 		if (unsigned_mult_overflows(factor, val) ||
 		    factor * val > max) {
 			errno = ERANGE;
-			return 0;
+			return false;
 		}
 		val *= factor;
 		*ret = val;
-		return 1;
+		return true;
 	}
 	errno = EINVAL;
-	return 0;
+	return false;
 }
 
-int git_parse_int(const char *value, int *ret)
+bool git_parse_int(const char *value, int *ret)
 {
 	intmax_t tmp;
 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int)))
-		return 0;
+		return false;
 	*ret = tmp;
-	return 1;
+	return true;
 }
 
-int git_parse_int64(const char *value, int64_t *ret)
+bool git_parse_int64(const char *value, int64_t *ret)
 {
 	intmax_t tmp;
 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(int64_t)))
-		return 0;
+		return false;
 	*ret = tmp;
-	return 1;
+	return true;
 }
 
-int git_parse_ulong(const char *value, unsigned long *ret)
+bool git_parse_ulong(const char *value, unsigned long *ret)
 {
 	uintmax_t tmp;
 	if (!git_parse_unsigned(value, &tmp, maximum_unsigned_value_of_type(long)))
-		return 0;
+		return false;
 	*ret = tmp;
-	return 1;
+	return true;
 }
 
-int git_parse_ssize_t(const char *value, ssize_t *ret)
+bool git_parse_ssize_t(const char *value, ssize_t *ret)
 {
 	intmax_t tmp;
 	if (!git_parse_signed(value, &tmp, maximum_signed_value_of_type(ssize_t)))
-		return 0;
+		return false;
 	*ret = tmp;
-	return 1;
+	return true;
 }
 
-int git_parse_double(const char *value, double *ret)
+bool git_parse_double(const char *value, double *ret)
 {
 	char *end;
 	double val;
 	uintmax_t factor;
 
 	if (!value || !*value) {
 		errno = EINVAL;
-		return 0;
+		return false;
 	}
 
 	errno = 0;
 	val = strtod(value, &end);
 	if (errno == ERANGE)
-		return 0;
+		return false;
 	if (end == value) {
 		errno = EINVAL;
-		return 0;
+		return false;
 	}
 	factor = get_unit_factor(end);
 	if (!factor) {
 		errno = EINVAL;
-		return 0;
+		return false;
 	}
 	val *= factor;
 	*ret = val;
-	return 1;
+	return true;
 }
 
 int git_parse_maybe_bool_text(const char *value)
diff --git a/parse.h b/parse.h
index ea32de9a91..f80cc5b9fd 100644
--- a/parse.h
+++ b/parse.h
@@ -1,13 +1,13 @@
 #ifndef PARSE_H
 #define PARSE_H
 
-int git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
-int git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
-int git_parse_ssize_t(const char *, ssize_t *);
-int git_parse_ulong(const char *, unsigned long *);
-int git_parse_int(const char *value, int *ret);
-int git_parse_int64(const char *value, int64_t *ret);
-int git_parse_double(const char *value, double *ret);
+bool git_parse_signed(const char *value, intmax_t *ret, intmax_t max);
+bool git_parse_unsigned(const char *value, uintmax_t *ret, uintmax_t max);
+bool git_parse_ssize_t(const char *, ssize_t *);
+bool git_parse_ulong(const char *, unsigned long *);
+bool git_parse_int(const char *value, int *ret);
+bool git_parse_int64(const char *value, int64_t *ret);
+bool git_parse_double(const char *value, double *ret);
 
 /**
  * Same as `git_config_bool`, except that it returns -1 on error rather
-- 
2.52.0.413.gf695cdb9bd

