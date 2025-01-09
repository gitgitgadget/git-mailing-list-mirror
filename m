Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663E42F2D
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 08:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412552; cv=none; b=D9FV0iHxW8rRqSCGBwy3sIzzr3vWxQHUpxzHXNMQavNX6yKkhM7rsbSXvJ/nIXuzUeGwDTQcFDO5kMgxEsbqDgW/OEuow3HxVp0UjcwHn5mYgGyuyKXYCz+BkKf48ULQ+7rLrU5IyPSNRk1FpBK5yd2auTw+3hVDkiXPRkUjvS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412552; c=relaxed/simple;
	bh=De8OL1AnpiYqqAzZx/IQG74vHQ2sB2rlbfYeyMdB0RM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SyYh7ib14QcDw4a9TqAc/5KbOGZ04qIs0Vumm+8P+iO/M7cUUtkhn559MTUi1OBf3QZYQjmeEYK9LfM8cuxWMb03+1U7J6G2I9sfgrO3PKgndfxW+DU7wAw0H3SaSQs4XJZZiPc8uQTDYyhpNytcC3yC6WUaVDkfD5plerFHoyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WTCLwUct; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WTCLwUct"
Received: (qmail 25714 invoked by uid 109); 9 Jan 2025 08:49:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=De8OL1AnpiYqqAzZx/IQG74vHQ2sB2rlbfYeyMdB0RM=; b=WTCLwUcta4Y3wt8xUHJP95l3BSHHY+WQ9FNamgw2fumhfFRcHQK62y1trGfjGeeZa8A9id8JWNSNWqYCrqRG3jifYK1cfHj6ejQvPHlLVaYSxSjRb6QPhU4wPHZlCHVsf0l0BMy7g9Gy+oZwfOSBaRtCLsEVFFOBjchazgrSoBlbwdd+wc3VcJGLq/4gtBYaAqlqaWJ4nOvvEJaViAu1jJwZMpFWD+7G21FRuyHDZUB0DokETJO3gtlNGvowmIy+NMlYdaYiq2LDzXCKvSceH+jKsdioZijCc84FHDpWXEXtCfVh+Lp7C7cgrGvOuzElqdrl39rwiB9v2jNTuJBgYQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Jan 2025 08:49:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20356 invoked by uid 111); 9 Jan 2025 08:49:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Jan 2025 03:49:08 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Jan 2025 03:49:07 -0500
From: Jeff King <peff@peff.net>
To: Git List <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>, Wink Saville <wink@saville.com>
Subject: [PATCH 08/14] tree-diff: pass whole path string to path_appendnew()
Message-ID: <20250109084907.GH2748836@coredump.intra.peff.net>
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

When diffing trees, we'll have a strbuf "base" containing the
slash-separted names of our parent trees, and a "path" string
representing an entry name from the current tree. We pass these
separately to path_appendnew(), which combines them to form a single
path string in the combine_diff_path struct.

Instead, let's append the path string to our base strbuf ourselves, pass
in the result, and then roll it back with strbuf_setlen(). This lets us
simplify path_appendnew() a bit, enabling further refactoring.

And while it might seem like this causes extra wasted allocations, it
does not in practice. We reuse the same strbuf for each tree entry, so
we only have to allocate it to match the largest name. Plus, in a
recursive diff we'll end up doing this same operation to extend the base
for the next level of recursion. So we're really just incurring a small
memcpy().

Signed-off-by: Jeff King <peff@peff.net>
---
 tree-diff.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/tree-diff.c b/tree-diff.c
index 22fc2d8f8c..d2f8dd14a6 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -129,20 +129,18 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
  * and append it to paths list tail.
  */
 static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
-	int nparent, const struct strbuf *base, const char *path, int pathlen,
+	int nparent, const char *path, size_t len,
 	unsigned mode, const struct object_id *oid)
 {
 	struct combine_diff_path *p;
-	size_t len = st_add(base->len, pathlen);
 	size_t alloclen = combine_diff_path_size(nparent, len);
 
 	p = xmalloc(alloclen);
 	p->next = NULL;
 	last->next = p;
 
 	p->path = (char *)&(p->parent[nparent]);
-	memcpy(p->path, base->buf, base->len);
-	memcpy(p->path + base->len, path, pathlen);
+	memcpy(p->path, path, len);
 	p->path[len] = 0;
 	p->mode = mode;
 	oidcpy(&p->oid, oid ? oid : null_oid());
@@ -206,7 +204,10 @@ static struct combine_diff_path *emit_path(struct combine_diff_path *p,
 	if (emitthis) {
 		int keep;
 		struct combine_diff_path *pprev = p;
-		p = path_appendnew(p, nparent, base, path, pathlen, mode, oid);
+
+		strbuf_add(base, path, pathlen);
+		p = path_appendnew(p, nparent, base->buf, base->len, mode, oid);
+		strbuf_setlen(base, old_baselen);
 
 		for (i = 0; i < nparent; ++i) {
 			/*
-- 
2.48.0.rc2.413.gc1c80375a3

