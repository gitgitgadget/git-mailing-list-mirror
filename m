Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF12F2F2D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412588; cv=none; b=q/HDHxhPQTaCLQVU2CpStlwxU8FSGabWwZvX7fmf2G2z7waTDdET0yX9jj0MrX6dSN43DUKgVQh+WT9gH5tF64qkAx0RDs/iXBjMuj+kSiXwYM+ml3sjwy/JrIb7NGhWtEN8BtM5ku9+NU5kwDaG79RndtQrObwYTyaTE/RgBfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412588; c=relaxed/simple;
	bh=4e+U0p6mws8DNFrmPl1j5itBMiZAMOb/l7ceK9XHvcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pgBNeQyirkUac3VuAxJvs9UGd/5x5RX0cWsjYkyq5EAuu3Wo94fzVoNFZj+vAPE51n9XXGLA3My2pP4axFqpHV7CPXo7tRMdtHBQQtxF3PiP43PuOlRlOdXoeUUVkzX7bRyyIAtd5uo/jh/WT/3U0hEMp3KwBascZKBGRsQo89U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KwBBoHF3; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KwBBoHF3"
Received: (qmail 25722 invoked by uid 109); 9 Jan 2025 08:49:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=4e+U0p6mws8DNFrmPl1j5itBMiZAMOb/l7ceK9XHvcU=; b=KwBBoHF3HpuQNW4/I8OKm6yRCMHfxxJBcSPOl1ryd+bnamf0LCDTd3OGWSt3zKR8n+dlNpDgqGjJz4/qJ5XJ84PlAhb4usr9s3e4AUzlQYmhvFbV5KZbYJtai11gfHXXIUdKHQqNI9wPHzmIb/V88ojhMJPStEDFMwTnD1vIZw5nPsCaeVep7LGtrkh0n2GtYG88DNzUANb7lup1sewqiHCbhZL5kqK8tO/Lv6nqEGC0Ch1nx4PncIVAagDeTypg8CunNGs5DSHcfyxDhnWXqSTORRVOt4nRnMCkkUvBEbeOZRQ+I89GnlbdNFJaoK0y81ycGJXtGL4s0h3oJwctng==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:49:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20366 invoked by uid 111); 9 Jan 2025 08:49:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:49:45 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:49:44 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 09/14] tree-diff: inline path_appendnew()
Message-ID: <20250109084944.GI2748836@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250109082723.GA2748497@coredump.intra.peff.net>

Our path_appendnew() has been simplified to the point that it is mostly
just implementing combine_diff_path_new(), plus setting the "next"
pointer. Since there's only one caller, let's replace it completely with
a call to that helper function.

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-diff.c | 31 ++++---------------------------
 1 file changed, 4 insertions(+), 27 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index d2f8dd14a6..18e5a16716 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -124,32 +124,6 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
 }
 
 
-/*
- * Make a new combine_diff_path from path/mode/sha1
- * and append it to paths list tail.
- */
-static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
-	int nparent, const char *path, size_t len,
-	unsigned mode, const struct object_id *oid)
-{
-	struct combine_diff_path *p;
-	size_t alloclen = combine_diff_path_size(nparent, len);
-
-	p = xmalloc(alloclen);
-	p->next = NULL;
-	last->next = p;
-
-	p->path = (char *)&(p->parent[nparent]);
-	memcpy(p->path, path, len);
-	p->path[len] = 0;
-	p->mode = mode;
-	oidcpy(&p->oid, oid ? oid : null_oid());
-
-	memset(p->parent, 0, sizeof(p->parent[0]) * nparent);
-
-	return p;
-}
-
 /*
  * new path should be added to combine diff
  *
@@ -206,7 +180,10 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 		struct combine_diff_path *pprev = p;
 
 		strbuf_add(base, path, pathlen);
-		p = path_appendnew(p, nparent, base->buf, base->len, mode, oid);
+		p = combine_diff_path_new(base->buf, base->len, mode,
+					  oid ? oid : null_oid(),
+					  nparent);
+		pprev->next = p;
 		strbuf_setlen(base, old_baselen);
 
 		for (i = 0; i < nparent; ++i) {
-- 
2.48.0.rc2.413.gc1c80375a3

