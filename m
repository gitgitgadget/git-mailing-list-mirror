Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5789454768
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153577; cv=none; b=iTrODehKitsAyxnKDHohVLJMklsrrwl7tgPJGJRLWElEcPRSFwdFakgnxWlzc8eU8fKDiNmk9dPvj9XzUyqW02sSuc/AufbMOk19o++8QxBOUI2HTPLelRbm1lEdGfLyVnBLajaq5hYMJerrHg/Fi0FILukQBV7VCo2te/Phvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153577; c=relaxed/simple;
	bh=WUL2MNwLdyzbHj4VLZ6a6nviSuIKy4S+hQyN1ClEm/E=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7NoLm0yOn3OpzfEsPesd6sCeamyY5bh26FmcjH3AO3WTytJemAYIGoyB7m8+Ar1Z7O5xpd44JCNu3ahW8GprZktOeYyYM/OVryllCTOgBz48dNyJoso7uBBT+YY2ptk9H0Pk0QW9jYBeVNNxGP3ZhOpJ0oRzJNGJ1vpxUEYB8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OOOOzYlt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OOOOzYlt"
Received: (qmail 15820 invoked by uid 106); 19 May 2026 01:19:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=WUL2MNwLdyzbHj4VLZ6a6nviSuIKy4S+hQyN1ClEm/E=; b=OOOOzYltBhlQSzMOD0XtUVDwcu/ubi5BhaMtsCX66A9nQdL8wwBUqpuNFMGIXTGlomgwQoeBstnoaBr4XsqGPPOcfl+rkTKOeyFJ6E77m3a1JqXQelm9KqJjHlXPTR10iTEYgCbrDmTWtKZRhq3V8oYNLqHnIlLQzZhtshlD27ZcuGjljftnibW711SUqN8izFwyp5HFSLiFSjA3bfvg8/OtJMnwLN9WogwoxgV6mhorfjqtLCwaaFT5WGEt2i+X1DLvl4CUA22K4F5pAnXU9colnJT39ayZaH7FAS0sssvpcTj1yU71voUA0s+hfuda/YHhIt0cnbg8+/aR/g1eJA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 01:19:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38821 invoked by uid 111); 19 May 2026 01:19:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 21:19:38 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 21:19:34 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/3] quote: drop sq_dequote_to_argv()
Message-ID: <20260519011934.GB1615870@coredump.intra.peff.net>
References: <20260519011837.GA1615637@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260519011837.GA1615637@coredump.intra.peff.net>

The last caller went away in f9dbb64fad (config: parse more robust
format in GIT_CONFIG_PARAMETERS, 2021-01-12), when we switched to using
sq_dequote_step().

The "to_argv()" form is not a great interface. If you care about raw
speed, then sq_dequote_step() lets you work incrementally without extra
allocations. If you care about simplicity, then sq_dequote_to_strvec()
puts the result in an encapsulated data structure. With sq_dequote_to_argv(),
you have a data dependency on the original string but still have to
remember to manually free the argv array itself (but not its elements).

So it's sort of a worst-of-both-worlds middle ground. Let's get rid of
it.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c |  5 -----
 quote.h | 12 +++---------
 2 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/quote.c b/quote.c
index b9f6bdc775..cff78af3a4 100644
--- a/quote.c
+++ b/quote.c
@@ -202,11 +202,6 @@ static int sq_dequote_to_argv_internal(char *arg,
 	return 0;
 }
 
-int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc)
-{
-	return sq_dequote_to_argv_internal(arg, argv, nr, alloc, NULL);
-}
-
 int sq_dequote_to_strvec(char *arg, struct strvec *array)
 {
 	return sq_dequote_to_argv_internal(arg, NULL, NULL, NULL, array);
diff --git a/quote.h b/quote.h
index 400397b11a..989f2388c0 100644
--- a/quote.h
+++ b/quote.h
@@ -68,15 +68,9 @@ char *sq_dequote_step(char *src, char **next);
 
 /*
  * Same as the above, but can be used to unwrap many arguments in the
- * same string separated by space. Like sq_quote, it works in place,
- * modifying arg and appending pointers into it to argv.
- */
-int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int *alloc);
-
-/*
- * Same as above, but store the unquoted strings in a strvec. We will
- * still modify arg in place, but unlike sq_dequote_to_argv, the strvec
- * will duplicate and take ownership of the strings.
+ * same string separated by space. The strvec will duplicate and take
+ * ownership of the strings, but note that "arg" is still modified in-place
+ * during parsing.
  */
 int sq_dequote_to_strvec(char *arg, struct strvec *);
 
-- 
2.54.0.524.g198262df96

