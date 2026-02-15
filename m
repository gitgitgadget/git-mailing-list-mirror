Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B4E22CBD9
	for <git@vger.kernel.org>; Sun, 15 Feb 2026 09:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771146466; cv=none; b=rq157wMzNHStD/SkW1RsebR/ibEQiwth3XTU2Vk7rP3rjhL11qVJ5EtVFdTmrL3oRAQRvQIecCd+T5Ilfc9IHyG/iPkuh11QXQZ64WVPzOVxCMLgagM4yEAIhZ9dHYczthj3MuvtqxvInEXMwzNyWCSSFzHQcg0bIrE8cumBM6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771146466; c=relaxed/simple;
	bh=HKhOKiOjjqdKpn9hOu+CJPR+il0m8r63unrBbto+LwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FQEMPtrrLBMWTFTxvEogJCgYR8mu13y0/JULb+DRM5foGrD/1I3/PdcoYi2QV/Fln3peP3ZEuLcFm+pV0MQloOFR8vMKd7P3XSmh1lbNA1cLDwsjLBbnmJ3lXCXM740d5BHTPuBZanl41Izp3cpn2XV5XlmFhIDkvcSMqW46STQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WbX6VwIq; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WbX6VwIq"
Received: (qmail 44752 invoked by uid 109); 15 Feb 2026 09:07:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HKhOKiOjjqdKpn9hOu+CJPR+il0m8r63unrBbto+LwE=; b=WbX6VwIqgmK7rENgRAR03NVRnl7sn1cz8w2MmneTC5CiVlHJKnn84O3I5AzHNZnVHnPnkulOaLY53GuW+Dc7CXWzlYyrtDWNFoG4Q1wvD7UlZFdQrYaYEM6z7T80Q8vb714iiw26BKL1xAZi8jNttztDG+OVNv7K2dVsOaJSjhNmRE8lgsHRAxKXN3C/1qqrO6Q4VOr1Gu6MAZVHWpw3JRe8lGYUpMOgobQhfNt+htNpjnqgEXc6wtUCEoxTEce0+O9CFTTTC9z17bGwkMTYYzb6KR+/ucB9eI5sklUuyvqNqapNiCPT/j2586QPSkbHdFkOqUDeboX8zbPTvkpi7Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 15 Feb 2026 09:07:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 113169 invoked by uid 111); 15 Feb 2026 09:07:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 15 Feb 2026 04:07:49 -0500
Authentication-Results: peff.net; auth=none
Date: Sun, 15 Feb 2026 04:07:44 -0500
From: Jeff King <peff@peff.net>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/4] ref-filter: avoid strrchr() in rstrip_ref_components()
Message-ID: <20260215090744.GD695631@coredump.intra.peff.net>
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

To strip path components from our refname string, we repeatedly call
strrchr() to find the trailing slash, shortening the string each time by
assigning NUL over it. This has two downsides:

  1. Calling strrchr() in a loop is quadratic, since each call has to
     call strlen() under the hood to find the end of the string (even
     though we know exactly where it is from the last loop iteration).

  2. We need a temporary buffer, since we're munging the string with NUL
     as we shorten it (which we must do, because strrchr() has no other
     way of knowing what we consider the end of the string).

Using memrchr() would let us fix both of these, but it isn't portable.
So instead, let's just open-code the string traversal from back to
front as we loop.

I doubt that the quadratic nature is a serious concern. You can see it
in practice with something like:

  git init
  git commit --allow-empty -m foo
  echo "$(git rev-parse HEAD) refs/heads$(perl -e 'print "/a" x 500_000')" >.git/packed-refs
  time git for-each-ref --format='%(refname:rstrip=-1)'

That takes ~5.5s to run on my machine before this patch, and ~11ms
after. But I don't think there's a reasonable way for somebody to infect
you with such a garbage ref, as the wire protocol is limited to 64k
pkt-lines. The difference is measurable for me for a 32k-component ref
(about 19ms vs 7ms), so perhaps you could create some chaos by pushing a
lot of them. But we also run into filesystem limits (if the loose
backend is in use), and in practice it seems like there are probably
simpler and more effective ways to waste CPU.

Likewise the extra allocation probably isn't really measurable. In fact,
since our goal is to return an allocated string, we end up having to
make the same allocation anyway (though it is sized to the result,
rather than the input). My main goal was simplicity in avoiding the need
to handle cleaning it up in the early return path.

Signed-off-by: Jeff King <peff@peff.net>
---
 ref-filter.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 1008b2fd5a..ac32b0e6bb 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2213,17 +2213,15 @@ static const char *lstrip_ref_components(const char *refname, int len)
 static const char *rstrip_ref_components(const char *refname, int len)
 {
 	int remaining = normalize_component_count(refname, len);
-	char *start = xstrdup(refname);
+	const char *end = refname + strlen(refname);
 
-	while (remaining-- > 0) {
-		char *p = strrchr(start, '/');
-		if (!p) {
-			free(start);
+	while (remaining > 0) {
+		if (end == refname)
 			return xstrdup("");
-		} else
-			p[0] = '\0';
+		if (*--end == '/')
+			remaining--;
 	}
-	return start;
+	return xmemdupz(refname, end - refname);
 }
 
 static const char *show_ref(struct refname_atom *atom, const char *refname)
-- 
2.53.0.438.gad17e1cd28
