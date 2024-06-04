Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBAD1448F3
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496003; cv=none; b=BwdC7hzZ/YBJGURyXjP0Y1Ei00LF0py/xvInfewbTVaXvnXCZON+AeCOqeh4z05fTWBIZuCXT6qD+Ah1L8/2jeEEHNgBjriqjV2fnfvcwXr+pC09zR5g5blzcVl7TTBaUEqv71Q3DFWePJqrMdEnq2j+tSAMRpDJJ4WDAJyeOn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496003; c=relaxed/simple;
	bh=pclLH5xWChQEwgL3WovA8aok6XFXqtdZbb60wGEJwlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ve3Iv2KPza6P29v8IzR3E6BUVMRSSZofwYmawIkN+BNr0owIToabTLor3uK6MLellSA44tFWooqUReLIPQWw3ah1pvV0cXg69FPJczcq5CbqtA4kWF1v+qPA7CSagaTxmwhvHSzuHOoJMmI/3WrzECatEhtYq0DHi6vb3sSsBQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21494 invoked by uid 109); 4 Jun 2024 10:13:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18367 invoked by uid 111); 4 Jun 2024 10:13:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:18 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:20 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 05/13] dir.c: free removed sparse-pattern hashmap entries
Message-ID: <20240604101320.GE1304593@coredump.intra.peff.net>
References: <20240604100814.GA1304520@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240604100814.GA1304520@coredump.intra.peff.net>

In add_pattern_to_hashsets(), we remove entries from the
recursive_hashmap when adding similar ones to the parent_hashmap. I
won't pretend to understand all of what's going on here, but there's an
obvious leak: whatever we removed from recursive_hashmap is not
referenced anywhere else, and is never free()d.

We can easily fix this by asking the hashmap to return a pointer to the
old entry. This makes t7002 now completely leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c                         | 8 +++++++-
 t/t7002-mv-sparse-checkout.sh | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 9cc4a68fbc..d812d521b0 100644
--- a/dir.c
+++ b/dir.c
@@ -810,6 +810,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 	if (given->patternlen > 2 &&
 	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
+		struct pattern_entry *old;
+
 		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
 			/* Not a cone pattern. */
 			warning(_("unrecognized pattern: '%s'"), given->pattern);
@@ -835,7 +837,11 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		}
 
 		hashmap_add(&pl->parent_hashmap, &translated->ent);
-		hashmap_remove(&pl->recursive_hashmap, &translated->ent, &data);
+		old = hashmap_remove_entry(&pl->recursive_hashmap, translated, ent, &data);
+		if (old) {
+			free(old->pattern);
+			free(old);
+		}
 		free(data);
 		return;
 	}
diff --git a/t/t7002-mv-sparse-checkout.sh b/t/t7002-mv-sparse-checkout.sh
index 26582ae4e5..57969ce805 100755
--- a/t/t7002-mv-sparse-checkout.sh
+++ b/t/t7002-mv-sparse-checkout.sh
@@ -2,6 +2,7 @@
 
 test_description='git mv in sparse working trees'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 setup_sparse_checkout () {
-- 
2.45.2.807.g3b5fadc4da

