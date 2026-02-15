Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8A65B21A
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146054; cv=none; b=tCm81P+jCaFcukvLMOkJqPmR7IrCDjz7hy3o1yMPHbI6pYOIoC3CXRBvHyj9D5BvLxIL8zunh2gT65q/0Sbz0mk5vNUgdNbe/+iqGw5N/eyj7e+z8lzVK5CSPXCZfNNsV8G1KHXtNvufidjuGe5vvFFGfj1AVLijMsE63BXaeds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146054; c=relaxed/simple;
	bh=Owuv0EsTikTn5D6yRdpFzcO/11m9QZnAOdPZow24RNo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI1O/bPp2aXHXliv+Ty55A3qUpzuAa4Rn+gjKaOXuudiNa9leeyCCfGwgKnj9ePQ5Eoa5EXSz+lKHfU53Uc83QNyuNDjNfpRbVQ6LlUlY16YBwM2ZCGbQo/+AjeV6a5qzFxxXBmWAHHOYUsf+blGLTggV80EFTcoSZ1VnEo823M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dwl5IppT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dwl5IppT"
Received: (qmail 44682 invoked by uid 109); 15 Feb 2026 09:00:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=Owuv0EsTikTn5D6yRdpFzcO/11m9QZnAOdPZow24RNo=; b=dwl5IppTrEg5pzmHeLGhTSiful9v/e4RFiaeKAapWgUfV7H+1b4jitc6C00Som+az+JZOgzcrJVLfBeWAMgfHxtzlAphgN/DNE1cHIGKvkFtcjzXcKWmhyStiw4XaqSr4wqDs0aLzF5HyqtiWTleBqqkhp2qon1FQUQJtGs3L9q6pd/M77c1HJI4MoJnbX3taBGxULTPiyhJ5cG/eAr9eoEQyPZLEmr+ESRIcs4JAilQGWvpku688kAJveGsqj0Yrf9nTtaoSy6dj6zjzwXpGpRh3PMv/UPdlRSTypKSBH6CjS47knNmkqFT+2LXFE0P/maB1Kq3Ki2ET/4K9jeX9w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 09:00:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 113028 invoked by uid 111); 15 Feb 2026 09:00:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 04:00:57 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 04:00:52 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/4] ref-filter: factor out refname component counting
Message-ID: <20260215090052.GA695631@coredump.intra.peff.net>
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

The "lstrip" and "rstrip" options to the %(refname) placeholder both
accept a negative length, which asks us to keep that many path
components (rather than stripping that many).

The code to count components and convert the negative value to a
positive was copied from lstrip to rstrip in 1a34728e6b (ref-filter: add
an 'rstrip=<N>' option to atoms which deal with refnames, 2017-01-10).

Let's factor it out into a separate function. This reduces duplication
and also makes the lstrip/rstrip functions much easier to follow, since
the bulk of their code is now the actual stripping.

Note that the computed "remaining" value is currently stored as a
"long", so in theory that's what our function should return. But this is
purely historical. When the variable was added in 0571979bd6 (tag: do
not show ambiguous tag names as "tags/foo", 2016-01-25), we parsed the
value from strtol(), and thus used a long. But these days we take "len"
as an int, and also use an int to count up components. So let's just
consistently use int here. This value could only overflow in a
pathological case (e.g., 4GB worth of "a/a/...") and even then will not
result in out-of-bounds memory access (we keep stripping until we run
out of string to parse).

The minimal Myers diff here is a little hard to read; with --patience
the code movement is shown much more clearly.

Signed-off-by: Jeff King <peff@peff.net>
---
I did generate this with --patience. Using --color-words also helps show
that it's a pure code movement.

 ref-filter.c | 56 +++++++++++++++++++++-------------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3917c4ccd9..9153331f42 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2173,28 +2173,32 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
+static int normalize_component_count(const char *refname, int len)
+{
+	if (len < 0) {
+		int i;
+		const char *p = refname;
+
+		/* Find total no of '/' separated path-components */
+		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
+			;
+		/*
+		 * The number of components we need to strip is now
+		 * the total minus the components to be left (Plus one
+		 * because we count the number of '/', but the number
+		 * of components is one more than the no of '/').
+		 */
+		len = i + len + 1;
+	}
+	return len;
+}
+
 static const char *lstrip_ref_components(const char *refname, int len)
 {
-	long remaining = len;
+	int remaining = normalize_component_count(refname, len);
 	const char *start = xstrdup(refname);
 	const char *to_free = start;
 
-	if (len < 0) {
-		int i;
-		const char *p = refname;
-
-		/* Find total no of '/' separated path-components */
-		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
-			;
-		/*
-		 * The number of components we need to strip is now
-		 * the total minus the components to be left (Plus one
-		 * because we count the number of '/', but the number
-		 * of components is one more than the no of '/').
-		 */
-		remaining = i + len + 1;
-	}
-
 	while (remaining > 0) {
 		switch (*start++) {
 		case '\0':
@@ -2213,26 +2217,10 @@ static const char *lstrip_ref_components(const char *refname, int len)
 
 static const char *rstrip_ref_components(const char *refname, int len)
 {
-	long remaining = len;
+	int remaining = normalize_component_count(refname, len);
 	const char *start = xstrdup(refname);
 	const char *to_free = start;
 
-	if (len < 0) {
-		int i;
-		const char *p = refname;
-
-		/* Find total no of '/' separated path-components */
-		for (i = 0; p[i]; p[i] == '/' ? i++ : *p++)
-			;
-		/*
-		 * The number of components we need to strip is now
-		 * the total minus the components to be left (Plus one
-		 * because we count the number of '/', but the number
-		 * of components is one more than the no of '/').
-		 */
-		remaining = i + len + 1;
-	}
-
 	while (remaining-- > 0) {
 		char *p = strrchr(start, '/');
 		if (!p) {
-- 
2.53.0.438.gad17e1cd28

