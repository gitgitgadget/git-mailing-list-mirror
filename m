Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5354E149C7C
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717154901; cv=none; b=TJkcMQbWI7mAc46EjSd15HH1jwnICzGBOeMC+XU1FJcKqGnNHjtzIDbtITXDANoFCcZ9cquSj8n6lyTvdnpKOQvDljrN4GWGyjReF2Jki4131obrbO20j1TcZE/dv2FuyCrP9m5fcn967WZl4y4mc5/FgmTbyH8xRp+ffJh2ytg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717154901; c=relaxed/simple;
	bh=caETPD57O421Qs8nakS9euhjm5gY6qv5mNf6Mxt4ZP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n7GY4IdQ3gIaw+9UbW4/BP1HgUGTl09yVVW/ZX0KeHyPkOCGZSpdfD4hG2yk4+Q5p/FYiRlX+V6/8maU+R6fn1jhb5mXNVQGm2BmD0LeyXt0xMOYt+DVwZehgSiYJX/TZIiDgiUO0GKLpJpFWuTDRK6G0NLLyhOHbUTLUD0cImY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22733 invoked by uid 109); 31 May 2024 11:28:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:28:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9263 invoked by uid 111); 31 May 2024 11:28:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:28:18 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:28:18 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 05/13] dir.c: free removed sparse-pattern hashmap entries
Message-ID: <20240531112818.GE428814@coredump.intra.peff.net>
References: <20240531112433.GA428583@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240531112433.GA428583@coredump.intra.peff.net>

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
2.45.1.727.ge984192922

