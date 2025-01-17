Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2151FE477
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 12:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737118534; cv=none; b=JMYLocX/MrkpSnCBi+spRP/QSqbqMA/IVi9RS9gka01jB2lHFQjtgMPdTJ3fHeY5JWro9vtmjIc8kVe01qOUXNX6oD/da2rbUkAqGH7ycB/G4X/1iMCe1sJjadA0reqIfx99cdky/mvLbEw7Im51rhOhQSqlJTgJLaS5FBihzwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737118534; c=relaxed/simple;
	bh=zDEUXzXJJiK9j4cKo5qDBYp7uG1Mdb1tuyyOiQMcvQE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EyvZR/ZsU6hoAfM/hTZYXtb+nFpQB5nDKETyQyYbAerlbOAydRNjwgGqvZrzVEOr74Xqf28bt7XjNegQYO5zqFE05ZBHix1YQCCdztlwGZ2rIyW/68e/tJ+iip2Lk8F/pPN6RkQ91rR8Wmyns6m8jrxfzChbFmCI+f/dW0D73NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HS23juK9; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HS23juK9"
Received: (qmail 21926 invoked by uid 109); 17 Jan 2025 12:55:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zDEUXzXJJiK9j4cKo5qDBYp7uG1Mdb1tuyyOiQMcvQE=; b=HS23juK9/99eQGw/Svq0wbJsSANxCS0qQ+edkBqNJJxkSq0KcO5gfD1Fe4l+opLA+LwszwFzYZhb33bC/2JkwbwoOS+iJ168SmV01Oc27RfSIDCjcHr5jC4UvzPZaL8NTnlydw+VkvN5dBDHHK+gXj0ikMMGZcAgYPvtWop5DolCbP0HYcCUUu0tS+etGIWCdpt6MBXmD8CASUWX2YR/Ip91ewe2ySa6dVy1p9oP0zCAfsqb0rzBCbAGcL6vaIzjdF0DMTVzlCo3nB6cxFMhqvvduM7Xh65qXpts/CK7WLqvPgOVNG0eKEoeHVYBF6GMRkhx5c1SeHmuRs42SUYapg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 17 Jan 2025 12:55:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8088 invoked by uid 111); 17 Jan 2025 12:55:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 17 Jan 2025 07:55:31 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 17 Jan 2025 07:55:30 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 2/3] parse_pack_header_option(): avoid unaligned memory writes
Message-ID: <20250117125530.GB2893666@coredump.intra.peff.net>
References: <20250117125207.GB2356599@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250117125207.GB2356599@coredump.intra.peff.net>

In order to recreate a pack header in our in-memory buffer, we cast the
buffer to a "struct pack_header" and assign the individual fields. This
is reported to cause SIGBUS on sparc64 due to alignment issues.

We can work around this by using put_be32() which will write individual
bytes into the buffer.

Reported-by: Koakuma <koachan@protonmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Fingers crossed that this is sufficient, and we don't have more
alignment problems.

 packfile.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/packfile.c b/packfile.c
index 2bf9e57330..2d80d80cb3 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2318,17 +2318,20 @@ int is_promisor_object(struct repository *r, const struct object_id *oid)
 
 int parse_pack_header_option(const char *in, unsigned char *out, unsigned int *len)
 {
-	struct pack_header *hdr;
+	unsigned char *hdr;
 	char *c;
 
-	hdr = (struct pack_header *)out;
-	hdr->hdr_signature = htonl(PACK_SIGNATURE);
-	hdr->hdr_version = htonl(strtoul(in, &c, 10));
+	hdr = out;
+	put_be32(hdr, PACK_SIGNATURE);
+	hdr += 4;
+	put_be32(hdr, strtoul(in, &c, 10));
+	hdr += 4;
 	if (*c != ',')
 		return -1;
-	hdr->hdr_entries = htonl(strtoul(c + 1, &c, 10));
+	put_be32(hdr, strtoul(c + 1, &c, 10));
+	hdr += 4;
 	if (*c)
 		return -1;
-	*len = sizeof(*hdr);
+	*len = hdr - out;
 	return 0;
 }
-- 
2.48.1.438.g7fbf7b046e

