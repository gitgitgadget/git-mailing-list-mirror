Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAE1DDC5
	for <git@vger.kernel.org>; Tue, 19 May 2026 01:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153662; cv=none; b=krRRJrXhrCtJ+LY7KPxoYAaltHw1eUIQDHHMOT2oMC2iKNIFz0SGs4VgT2n5hdsfEBYSXhpDZYs2Cd0cCdHlO/Qbi+tzowO8mVwUZB2oo2+Kcn699cDd4A5ZPGjYTestrPOQX4436XE3jUQfulSmycwDXlKMUgB9O9cz1uxHjrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153662; c=relaxed/simple;
	bh=n3kXkEIWp00SuylK9XeYykmhGT6IK235LlJ8BUS5wxk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ef44FzcS3yNvBkwS2hF8szn5Vgb6zQfRyXu3aLbGKUzhfJh+C9HbHN82jvLVs9oDRXq/+g8Rm+wymhymrV65bdLf8R5MwinljNOra+mZp2zYbqL2SrHNM86ppQHkw3IComEH+jcfzNV5DKcYifCeKGDZGd0Dgea/M1bmmJr55EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=TkQJb1hE; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="TkQJb1hE"
Received: (qmail 15825 invoked by uid 106); 19 May 2026 01:21:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=n3kXkEIWp00SuylK9XeYykmhGT6IK235LlJ8BUS5wxk=; b=TkQJb1hE3Vhw9kYe0zlDQNlKOB3RCF7qP7HxwcLT4xTTaZpofge1iDN0g0KF1MRy8xMHsW/zS4/mHiaa9ZGbN8SDsl30bwXPlv2xBYYYeIGhbtkDU7oopjrBvpRFb4o7CyGuXbkqeue2U9zSy+5YM+n2X8vDwGWjhlgN0iu8055itVOguI1qwPhMMvgzDLoUY6rAUSHe0LVhqnfGuu/C8ywWPoHhQ+F6wdVpKr0vH44nFNM5juML1q5D+bB+QHV8Knm7bV/ScjwMgExTGTiacYcCpo/y0z8rZNwbu2uaPAYgNX877bZ0pjKgwf2iRSbyiSQxAQm/zf8QEbvQ5Yzpyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 May 2026 01:21:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 38864 invoked by uid 111); 19 May 2026 01:21:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 18 May 2026 21:21:03 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 18 May 2026 21:20:59 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 3/3] quote: simplify internals of dequoting
Message-ID: <20260519012059.GC1615870@coredump.intra.peff.net>
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

Our sq_dequote_to_argv_internal() helper was wrapped by the to_argv()
and to_strvec() forms. Now that we have only the latter, we can stop
wrapping it and drop the argv-only bits.

Note that in theory sq_dequote_to_strvec() could take a const input
string, which would be friendlier to its callers. We couldn't do that
with the to_argv() form because it reused the input string to hold the
output elements. But since we're built on sq_dequote_step(), which
munges the input, we'd have to rework the parser. Since no callers care
about it currently, we'll leave that for another day.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/quote.c b/quote.c
index cff78af3a4..235fac8e47 100644
--- a/quote.c
+++ b/quote.c
@@ -171,9 +171,7 @@ char *sq_dequote(char *arg)
 	return sq_dequote_step(arg, NULL);
 }
 
-static int sq_dequote_to_argv_internal(char *arg,
-				       const char ***argv, int *nr, int *alloc,
-				       struct strvec *array)
+int sq_dequote_to_strvec(char *arg, struct strvec *array)
 {
 	char *next = arg;
 
@@ -191,22 +189,12 @@ static int sq_dequote_to_argv_internal(char *arg,
 				c = *++next;
 			} while (isspace(c));
 		}
-		if (argv) {
-			ALLOC_GROW(*argv, *nr + 1, *alloc);
-			(*argv)[(*nr)++] = dequoted;
-		}
-		if (array)
-			strvec_push(array, dequoted);
+		strvec_push(array, dequoted);
 	} while (next);
 
 	return 0;
 }
 
-int sq_dequote_to_strvec(char *arg, struct strvec *array)
-{
-	return sq_dequote_to_argv_internal(arg, NULL, NULL, NULL, array);
-}
-
 /* 1 means: quote as octal
  * 0 means: quote as octal if (quote_path_fully)
  * -1 means: never quote
-- 
2.54.0.524.g198262df96
