Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0033C18DB2A
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758053843; cv=none; b=BUnfgF3Hi+stYZNICXKHqc7RghVDWwawa8iRSDK0KPx/GY4zJEBEMdY9QlZmpd2g+gYWzv7vAcn0aoxViqN9FRHFPVrFnfxjn+tL55+jQKjB0hQew7aLFlSEyoq+s7bgL+X23/ShT3sgTYgASV8Lph+aGcSfr4YsMpFoGFIjnD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758053843; c=relaxed/simple;
	bh=NZKN//XywmoA2SAm/l1yiENVNuR5DlEISk0QYwtQQbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZEEMbH3ZTz/I3ed7+MHO3I5C1bRzZ8oVKF6YmBOmEnTHnvnxyhIfRCK7lYQhytWUMiv7a7vWPrg17TvyiHyUsBkCCi5IeNZxL3ijzYxKgKzX44V8smX4Gt7deum97eE+G5PVNny/BTm15HmzE/1NtDvkEcJyTs3ozBe5/MVHLOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GIjZT+cb; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GIjZT+cb"
Received: (qmail 102331 invoked by uid 109); 16 Sep 2025 20:17:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=NZKN//XywmoA2SAm/l1yiENVNuR5DlEISk0QYwtQQbA=; b=GIjZT+cbOrpWWdJ2DfNwNNeyFfEfwS5wLMOBdkuqoEIFz9tvZ51Ew8dd4pwfusbl8ypJtP3ap75rAZ77n9HgbU1QzlLiYQiYMH3QK4h8/wXKdkBOYJZR2OKpIioVoYBBywvEj8FfrlnVMYflU5o2XJ8m/PAs/qnrnd7t2zt1AgZbmvBq6G9lSr70+Lg8lnkfUFl+O/hl7E75CVl/fFJOU19S4C6R50E9ti8IVl21MhbIw4QAewzZco7y+PB6zHbVR5ugGMsKoIdv95CqflKxeV/XOXjG3CtTNOvsTJxN9m7P0+maD4gGy+JsKxicug6AZJ6Lh+eZ4DnhzGicguiG9g==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Sep 2025 20:17:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 166176 invoked by uid 111); 16 Sep 2025 20:17:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Sep 2025 16:17:19 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Sep 2025 16:17:19 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 04/13] diff: simplify color_moved check when flushing
Message-ID: <20250916201719.GD612873@coredump.intra.peff.net>
References: <20250916201036.GA612463@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250916201036.GA612463@coredump.intra.peff.net>

In diff_flush_patch_all_file_pairs(), we set o->emitted_symbols if and
only if o->color_moved is true. That causes the lower-level routines to
fill up o->emitted_symbols, which we then analyze in order to do the
actual colorizing.

But in that final step, we do:

  if (o->emitted_symbols) {
          if (o->color_moved) {
	     ...actual coloring...
	  }
	  ...clean up of emitted_symbols...
  }

The inner "if" will always trigger, since we set emitted_symbols only
when doing color_moved (it is a little confusing that it is set inside
the diff_options struct, but that is for convenience of passing it to
the lower-level routines; we always clear it at the end of flushing,
since 48edf3a02a (diff: clear emitted_symbols flag after use,
2019-01-24)).

Let's simplify the code a bit by just dropping the inner "if" and
running its block unconditionally.

In theory the current code might be useful if another feature besides
color_moved setup and used emitted_symbols, but it would be easy to
refactor later to handle that. And in the meantime, this makes further
work in this area easier.

Signed-off-by: Jeff King <peff@peff.net>
---
 diff.c | 25 +++++++++++--------------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/diff.c b/diff.c
index 64a4bd23ea..e6c85c8491 100644
--- a/diff.c
+++ b/diff.c
@@ -6746,20 +6746,17 @@ static void diff_flush_patch_all_file_pairs(struct diff_options *o)
 	}
 
 	if (o->emitted_symbols) {
-		if (o->color_moved) {
-			struct mem_pool entry_pool;
-			struct moved_entry_list *entry_list;
-
-			mem_pool_init(&entry_pool, 1024 * 1024);
-			entry_list = add_lines_to_move_detection(o,
-								 &entry_pool);
-			mark_color_as_moved(o, entry_list);
-			if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
-				dim_moved_lines(o);
-
-			mem_pool_discard(&entry_pool, 0);
-			free(entry_list);
-		}
+		struct mem_pool entry_pool;
+		struct moved_entry_list *entry_list;
+
+		mem_pool_init(&entry_pool, 1024 * 1024);
+		entry_list = add_lines_to_move_detection(o, &entry_pool);
+		mark_color_as_moved(o, entry_list);
+		if (o->color_moved == COLOR_MOVED_ZEBRA_DIM)
+			dim_moved_lines(o);
+
+		mem_pool_discard(&entry_pool, 0);
+		free(entry_list);
 
 		for (i = 0; i < esm.nr; i++)
 			emit_diff_symbol_from_struct(o, &esm.buf[i]);
-- 
2.51.0.527.g34bc42dacd

