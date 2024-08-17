Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF19646
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 07:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723879617; cv=none; b=FjaOJ9mlUhAwQqb5oZWEKqnZyg8iB59Gkzg/qd9MOsRX02L3OxjkZg2iclBtbf603nywE/A5Xcp4C474lXLheLY5597gHLUlIerkDa1r5G5F5MfNdcsmFrU7gFX5gS+AiforgsObBfXzGYphaoTAF4XPvbfo3cnyxx04JfDxtjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723879617; c=relaxed/simple;
	bh=xm6u3FGrkVsyLYEEiM+gIHzIIJMHWuG3sun7g1YMD4Y=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iAhysSKbXSCDxItXu9JVf+N8jMAXJQ5oE9V9uH6/I//aGAWEhRGa7CP3tNpvmqavtr3+uk9OJHqjZwioIBhVd+WLCHj5Jb+pXg9suHJYN55aF6h3JtHOVApIHzqTegB4hTZV7MnLBgWGQL9x4J5J3mNd87i21+J79vAMk7t/TZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23555 invoked by uid 109); 17 Aug 2024 07:26:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 07:26:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27564 invoked by uid 111); 17 Aug 2024 07:26:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 03:26:58 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 03:26:53 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 2/5] pack-bitmap: load writer config from repository parameter
Message-ID: <20240817072653.GB1535915@coredump.intra.peff.net>
References: <20240817072621.GA1535666@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817072621.GA1535666@coredump.intra.peff.net>

In bitmap_writer_init(), we take a repository parameter but ever look at
it. Most of the initialization here is independent of the repository,
but we do load some config. So let's pass the repo we get down to
load_pseudo_merges_from_config(), which in turn can use repo_config(),
rather than depending on the_repository via git_config().

The outcome is the same, since all callers pass in the_repository
anyway. But it takes us a step closer to getting rid of the global, and
as a bonus it silences an unused parameter warning.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap-write.c | 2 +-
 pseudo-merge.c      | 5 +++--
 pseudo-merge.h      | 3 ++-
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
index bf96c80898..7787600234 100644
--- a/pack-bitmap-write.c
+++ b/pack-bitmap-write.c
@@ -51,7 +51,7 @@ void bitmap_writer_init(struct bitmap_writer *writer, struct repository *r)
 
 	string_list_init_dup(&writer->pseudo_merge_groups);
 
-	load_pseudo_merges_from_config(&writer->pseudo_merge_groups);
+	load_pseudo_merges_from_config(r, &writer->pseudo_merge_groups);
 }
 
 static void free_pseudo_merge_commit_idx(struct pseudo_merge_commit_idx *idx)
diff --git a/pseudo-merge.c b/pseudo-merge.c
index 77a83b9c5c..1d7f5381a4 100644
--- a/pseudo-merge.c
+++ b/pseudo-merge.c
@@ -183,11 +183,12 @@ static int pseudo_merge_config(const char *var, const char *value,
 	return ret;
 }
 
-void load_pseudo_merges_from_config(struct string_list *list)
+void load_pseudo_merges_from_config(struct repository *r,
+				    struct string_list *list)
 {
 	struct string_list_item *item;
 
-	git_config(pseudo_merge_config, list);
+	repo_config(r, pseudo_merge_config, list);
 
 	for_each_string_list_item(item, list) {
 		struct pseudo_merge_group *group = item->util;
diff --git a/pseudo-merge.h b/pseudo-merge.h
index 2aca01d056..3aecba772b 100644
--- a/pseudo-merge.h
+++ b/pseudo-merge.h
@@ -10,6 +10,7 @@ struct commit;
 struct string_list;
 struct bitmap_index;
 struct bitmap_writer;
+struct repository;
 
 /*
  * A pseudo-merge group tracks the set of non-bitmapped reference tips
@@ -72,7 +73,7 @@ struct pseudo_merge_matches {
  * entry keys are the pseudo-merge group names, and the values are
  * pointers to the pseudo_merge_group structure itself.
  */
-void load_pseudo_merges_from_config(struct string_list *list);
+void load_pseudo_merges_from_config(struct repository *r, struct string_list *list);
 
 /*
  * A pseudo-merge commit index (pseudo_merge_commit_idx) maps a
-- 
2.46.0.585.gd6679c16d8

