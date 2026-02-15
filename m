Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDB478F59
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146146; cv=none; b=ZnF2j+Qtu+p4QrX6ncvKWZ8CtdW2Kj+xQONz+a8UJIZ7u+/LLnar0FPRjX4LvNyIwLNDqUBYBZ9vTbQ2K1AeI8MrAVNshDVtTVwY68jzXoedoSBnMpoyi7lursw5Yj7DIuAHgJQ3JWBd+zOIqUq3HIrYgHhjKJ0iZIXnK4hdiMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146146; c=relaxed/simple;
	bh=F5XZnH41zzSkkdpZAyxhgOxybrIgdwjZ01DHtwkCV1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfJ8q2R3E5eIuYPaFS0EqF3u6yCvFzKC4A0MHtFbXIgkaDV2jt7JozAKLMwftGT/yEqpiIL3X44S7d/i0rVS8xsw175XpSj6TQt2Vzaws4nnNOR6O9ASOa17Dslx+ehszzOuLWocu6slXxfsB13siv0FV4tAOiYMA/xPMEQS6GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DqMD5s2Z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DqMD5s2Z"
Received: (qmail 44698 invoked by uid 109); 15 Feb 2026 09:02:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=F5XZnH41zzSkkdpZAyxhgOxybrIgdwjZ01DHtwkCV1s=; b=DqMD5s2ZgIHgxYUCIYd+g9n4Oa4e2o8uno+8SDm+oV35c3lEOwPyiseYbpU2FWXhZrX0UcWnXcqPF3CcOld+toIaCNKUg66BHBTWjBU3ODqhF4iKrbVgkYAjAKQBD1a+JpstOJNmXYTnFwk6Cy1q/yiO+e4KN2qDzTgP+cBBhVnqI562m9OpB/2y1mGvpwP9mFpYMj9r8GJuyvbrk47jm9ZsF8V/o55bo5CsTD6opjJu64nwNAEzegL1qgy8MrZeIhrLHGxVP+j+ocW7AOAFaoi42dx4mazAY/334DwuTUXGUdMfguWhoY71OS/T5wljUFWInFi82FhnHPU0FdDvrw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 09:02:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 113052 invoked by uid 111); 15 Feb 2026 09:02:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 04:02:28 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 04:02:23 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 2/4] ref-filter: simplify lstrip_ref_components() memory
 handling
Message-ID: <20260215090223.GB695631@coredump.intra.peff.net>
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

We're walking forward in the string, skipping path components from
left-to-right. So when we've stripped as much as we want, the pointer we
have is a complete NUL-terminated string and we can just return it
(after duplicating it, of course). So there is no need for a temporary
allocated string.

But we do make an extra temporary copy due to f0062d3b74 (ref-filter:
free item->value and item->value->s, 2018-10-18). This is probably from
cargo-culting the technique used in rstrip_ref_components(), which
_does_ need a separate string (since it is stripping from the end and
ties off the temporary string with a NUL).

Let's drop the extra allocation. This is slightly more efficient, but
more importantly makes the code much simpler.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9153331f42..eb09fda21b 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2196,23 +2196,18 @@ static int normalize_component_count(const char *refname, int len)
 static const char *lstrip_ref_components(const char *refname, int len)
 {
 	int remaining = normalize_component_count(refname, len);
-	const char *start = xstrdup(refname);
-	const char *to_free = start;
 
 	while (remaining > 0) {
-		switch (*start++) {
+		switch (*refname++) {
 		case '\0':
-			free((char *)to_free);
 			return xstrdup("");
 		case '/':
 			remaining--;
 			break;
 		}
 	}
 
-	start = xstrdup(start);
-	free((char *)to_free);
-	return start;
+	return xstrdup(refname);
 }
 
 static const char *rstrip_ref_components(const char *refname, int len)
-- 
2.53.0.438.gad17e1cd28

