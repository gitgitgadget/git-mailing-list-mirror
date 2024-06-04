Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A7E144D2D
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496023; cv=none; b=oVdmfuSlA2sCltNXZPyWwCWaV1UZk6S1xFmqSBA9woNaCOfib9tBD+PFVt60pN+RhIH1SHKyNy07P5xL3hw4ot8i1D13Ok92MHLLBKOFJbvUCDSTYDuxl4TQc++QKGYXBrNgSYkfp21KUb/s5UI+QH9EijmDqf6yXwhxgucHFX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496023; c=relaxed/simple;
	bh=8egrULMIwM+ub4Unk5iAaNgQUWCrwr1gofvZnj0MLjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=njKOee7L0eudg/2vDgUgWoU9CGY/l53P2UaKIp+iVsYbwZKvrKUX5E4C191Q1XJRq4fQBhNQGnXLPxCiBQGglIpu+U44KSoBMhuDCSuFYNxhXYsd8Dryau73sN/kTdkYPTIASj7WOsacre5jZmep9Bqim2GADQ3mzPGbeDWZGOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21571 invoked by uid 109); 4 Jun 2024 10:13:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18407 invoked by uid 111); 4 Jun 2024 10:13:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:38 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:40 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 13/13] sparse-checkout: free duplicate hashmap entries
Message-ID: <20240604101340.GM1304593@coredump.intra.peff.net>
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

In insert_recursive_pattern(), we create a new pattern_entry to insert
into the parent_hashmap. If we find that the same entry already exists
in the hashmap, we skip adding the new one. But we forget to free the new
one, creating a leak.

We can fix it by cleaning up the discarded entry. It would probably be
possible to avoid creating it in the first place, but it's non-trivial.
We'd have to define a "keydata" struct that lets us compare the existing
entries to the broken-out fields. It's probably not worth the
complexity, so we'll punt on that for now.

There is one subtlety here: our insertion is happening in a loop, with
each iteration looking at the pattern we just inserted (hence the
"recursive" in the name). So if we skip insertion, what do we look at?

The obvious answer is that we should remember the existing duplicate we
found and use that. But I _think_ in that case, we probably already have
all of the recursive bits already (from when the original entry was
added). And so just breaking out of the loop would be correct. But I'm
not 100% sure on that; after all, the original leaky code could have
done the same break, but it didn't.

So I went with the "obvious answer" above, which has no chance of
changing the behavior aside from fixing the leak.

With this patch, t1091 can now be marked leak-free.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c          | 9 ++++++++-
 t/t1091-sparse-checkout-builtin.sh | 1 +
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index e648e035ab..3f2bfce8fa 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -523,6 +523,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 		char *slash = strrchr(e->pattern, '/');
 		char *oldpattern = e->pattern;
 		size_t newlen;
+		struct pattern_entry *dup;
 
 		if (!slash || slash == e->pattern)
 			break;
@@ -533,8 +534,14 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 		e->pattern = xstrndup(oldpattern, newlen);
 		hashmap_entry_init(&e->ent, fspathhash(e->pattern));
 
-		if (!hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL))
+		dup = hashmap_get_entry(&pl->parent_hashmap, e, ent, NULL);
+		if (!dup) {
 			hashmap_add(&pl->parent_hashmap, &e->ent);
+		} else {
+			free(e->pattern);
+			free(e);
+			e = dup;
+		}
 	}
 }
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index ab3a105fff..8c5cd651b4 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -8,6 +8,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 GIT_TEST_SPLIT_INDEX=false
 export GIT_TEST_SPLIT_INDEX
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 list_files() {
-- 
2.45.2.807.g3b5fadc4da
