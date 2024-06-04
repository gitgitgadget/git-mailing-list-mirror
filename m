Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AAE144D10
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 10:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717496013; cv=none; b=oTTqT0oulXe4kPlXvgteTVRfXuRnhip0Pk/JbGxtlz224aT311adbKg0xQMg5Gg6WQFvoOGpaTd+Nffhsc1HsI8zUOb32OS52qiGICC5JY/o43eB8x99pATPGSxYYPIUlDV0mk+AbsF29jwcL5BdNJyVYYNGcuU7uiCK6M6QiUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717496013; c=relaxed/simple;
	bh=gvCK55F0sDRjL2Ty3tjrGCVkN6s9axj+fGWc7JHQ6Qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RjxUoQGRkU/OzD3xnhF0w0f3hwnfKkye8NjWH58qy3rwGm34UVCZETnCn1ZBfCNW0M3KnGd1FvpaGcevVHVli9tiSMRKiSii0whvDYOT8pJQhdPv0sWpAChEJx2dQ57QCzS9EAo92zvv20UqRY96BZwk6z2hnhGErE7N4qdn2fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 21529 invoked by uid 109); 4 Jun 2024 10:13:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 04 Jun 2024 10:13:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18387 invoked by uid 111); 4 Jun 2024 10:13:28 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 04 Jun 2024 06:13:28 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 4 Jun 2024 06:13:30 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 09/13] sparse-checkout: refactor temporary
 sparse_checkout_patterns
Message-ID: <20240604101330.GI1304593@coredump.intra.peff.net>
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

In update_working_directory(), we take in a pattern_list, attach it to
the repository index by assigning it to index->sparse_checkout_patterns,
and then call unpack_trees. Afterwards, we remove it by setting
index->sparse_checkout_patterns back to NULL.

But there are two possible leaks here:

  1. If the index already had a populated sparse_checkout_patterns,
     we've obliterated it. We can fix this by saving and restoring it,
     rather than always setting it back to NULL.

  2. We may call the function with a NULL pattern_list, expecting it to
     use the on-disk sparse file. In that case, the index routines will
     lazy-load the sparse patterns automatically. But now at the end of
     the function when we restore the patterns, we'll leak those
     lazy-loaded ones!

     We can fix this by freeing the pattern list before overwriting its
     pointer whenever it does not match what was passed in (in practice
     this should only happen when the passed-in list is NULL, but this
     is erring on the defensive side).

Together these remove 48 indirect leaks found in t1091.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/sparse-checkout.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 8f8f5c359f..b84d2e1c80 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -205,11 +205,13 @@ static int update_working_directory(struct pattern_list *pl)
 	struct unpack_trees_options o;
 	struct lock_file lock_file = LOCK_INIT;
 	struct repository *r = the_repository;
+	struct pattern_list *old_pl;
 
 	/* If no branch has been checked out, there are no updates to make. */
 	if (is_index_unborn(r->index))
 		return UPDATE_SPARSITY_SUCCESS;
 
+	old_pl = r->index->sparse_checkout_patterns;
 	r->index->sparse_checkout_patterns = pl;
 
 	memset(&o, 0, sizeof(o));
@@ -241,7 +243,12 @@ static int update_working_directory(struct pattern_list *pl)
 
 	clean_tracked_sparse_directories(r);
 
-	r->index->sparse_checkout_patterns = NULL;
+	if (r->index->sparse_checkout_patterns != pl) {
+		clear_pattern_list(r->index->sparse_checkout_patterns);
+		FREE_AND_NULL(r->index->sparse_checkout_patterns);
+	}
+	r->index->sparse_checkout_patterns = old_pl;
+
 	return result;
 }
 
-- 
2.45.2.807.g3b5fadc4da

