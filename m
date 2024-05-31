Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83EEB157491
	for <git@vger.kernel.org>; Fri, 31 May 2024 11:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717155514; cv=none; b=hwfMubD2p2FF0rFfYa5wQGou3L65wdhTqdvCies6GvZ9rySNdxrXYLVl9/68uS1HqTYTuq8Z87BFMX7ySBiVWeNNUAn1KjUEzlrggvpOXCQp3gK6R+f6VsawyPFJ9HtLM4o8t4FPiX3wUnhEYQhNBd7hFeqKADOuXwAtSaBHj9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717155514; c=relaxed/simple;
	bh=O54xXQlLU1sn19yZ8QDBbRGoSyPS4HoZtFTXBhGgAK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tv2unknfdRqJ0anLT0R/BHAMVjV3LbpbbKR5W8Q57P051lSfU9ndmfL3hVat/Pm8Df43x/uD4nOOYDhph1PeUl4Z9WhbkaQxVoa4hFsaL+8ht8WRjnUa+i0/34cbgJKSMwX+QjhsI8brkat25h54ub43eqcvJ7D7g97tzNgENR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 22791 invoked by uid 109); 31 May 2024 11:38:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 May 2024 11:38:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9390 invoked by uid 111); 31 May 2024 11:38:31 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 31 May 2024 07:38:31 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 31 May 2024 07:38:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 13/13] sparse-checkout: free duplicate hashmap entries
Message-ID: <20240531113830.GM428814@coredump.intra.peff.net>
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
index 0b979a17d6..c8179d59d9 100644
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
+		if (!dup)
 			hashmap_add(&pl->parent_hashmap, &e->ent);
+		else {
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
2.45.1.727.ge984192922
