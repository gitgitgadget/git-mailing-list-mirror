Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A521DEFCD
	for <git@vger.kernel.org>; Sun, 19 Jan 2025 13:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737293028; cv=none; b=IRIPiIl/T3and2UAo5fB35Dc1/EsBIV3G5MpHg9ss+DCZkgc3dTAgZMwxj05zWGApIZ/GbgyJrOlgixutYQ6Q8EbsyyphUuMbkiiGapvGYjzSvWqAdqk3yIQ41XoRg4W8e6mAp6WG26X3LxJ2lQJGygKJjobewoP9CUuQ7qQzmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737293028; c=relaxed/simple;
	bh=ANFyt+e7D6m7+Lf5Rtw4I1uNNKtKznzTJXeKhtM/2r4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n8ADieY6M0f1IjqoX5sNgHrgEhR/XVjhWNQhytdN2HdqoAt5koe25H44mbIsFWW/fu/IVPF/Y8JZAgi0gIbXBxJIdLdF04OqQjLvrYyYav3k9ixFbxiViwnFlzGcUEIjPVUIYLswzOgGY+7Usw2sq1QdPmuShHc3WILdM6RBX88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=T4iyTfhI; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="T4iyTfhI"
Received: (qmail 7984 invoked by uid 109); 19 Jan 2025 13:23:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ANFyt+e7D6m7+Lf5Rtw4I1uNNKtKznzTJXeKhtM/2r4=; b=T4iyTfhIggb0eoXe9JJQ3Y259XKuqg6Pz73XWAqwxWE1xRUvK59/uU/gZDHlUVfwEO9tkrdDJ3u0t8xYJeA0FONcPVel22WPrVgVi0z3aczhhludsYsGuBqgmDoNl7yVYYGz+qa8k3uFNlFV0DMSwxNPQXgU7JiuA6CQ1B1fvix4EC3Z3Dxkw0QV7P2rQgk5YSzNVxE/dg2fZMRJ+fotFerthklJSV8683Mij1zmBXBehxMwNlmxDGjGTMpbiO1gzvIMiKPAOzBYGVBfxHWFw5s+d//1ZoFfC+ctVc+wydU/10mU3g1MvsEyH0qJEyKs+B6dslTZdkQoq2OP1nX4Lw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 19 Jan 2025 13:23:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 747 invoked by uid 111); 19 Jan 2025 13:23:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Jan 2025 08:23:45 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Jan 2025 08:23:44 -0500
From: Jeff King <peff@peff.net>
To: Koakuma <koachan@protonmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH v2 3/5] parse_pack_header_option(): avoid unaligned memory
 writes
Message-ID: <20250119132344.GC1552263@coredump.intra.peff.net>
References: <20250119131224.GA1541095@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250119131224.GA1541095@coredump.intra.peff.net>

In order to recreate a pack header in our in-memory buffer, we cast the
buffer to a "struct pack_header" and assign the individual fields. This
is reported to cause SIGBUS on sparc64 due to alignment issues.

We can work around this by using put_be32() which will write individual
bytes into the buffer.

Reported-by: Koakuma <koachan@protonmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
Same as before.

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
2.48.1.466.g22b8cfd1fa

